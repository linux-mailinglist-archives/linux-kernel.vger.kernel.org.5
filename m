Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B607A35B8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 15:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbjIQNmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 09:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbjIQNm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 09:42:27 -0400
X-Greylist: delayed 482 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 17 Sep 2023 06:42:18 PDT
Received: from smtp-out3.octopuce.fr (smtp-out3.octopuce.fr [91.194.60.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E5B131;
        Sun, 17 Sep 2023 06:42:18 -0700 (PDT)
Received: from smtp.ouvaton.coop (smtp.ouvaton.coop [194.36.166.20])
        by smtp-out3.octopuce.fr (Postfix) with ESMTPS id 75E804062E;
        Sun, 17 Sep 2023 15:34:12 +0200 (CEST)
Received: from [192.168.0.30] (189.89.89.92.rev.sfr.net [92.89.89.189])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ouvalternc.octopuce.fr (Postfix) with ESMTPSA id EB3D53FDC8;
        Sun, 17 Sep 2023 15:34:10 +0200 (CEST)
Message-ID: <564c9bb6-1e7d-43c3-8dfc-5282ea82305a@droneaud.fr>
Date:   Sun, 17 Sep 2023 15:34:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Propagating reseed notifications to user space
To:     Babis Chalios <bchalios@amazon.es>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     graf@amazon.de, xmarcalx@amazon.co.uk, aams@amazon.de,
        dwmw@amazon.co.uk, gregkh@linuxfoundation.org
References: <20230823090107.65749-1-bchalios@amazon.es>
Content-Language: fr-FR, en-US, en-GB
From:   Yann Droneaud <yann@droneaud.fr>
In-Reply-To: <20230823090107.65749-1-bchalios@amazon.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 23/08/2023 à 11:01, Babis Chalios a écrit :
> User space often implements PRNGs that use /dev/random as entropy
> source. We can not expect that this randomness sources stay completely
> unknown forever. For various reasons, the originating PRNG seed may
> become known at which point the PRNG becomes insecure for further random
> number generation. Events that can lead to that are for example fast
> computers reversing the PRNG function using a number of inputs or
> Virtual Machine clones which carry seed values into their clones.
>
> During LPC 2022 Jason, Alex, Michael and me brainstormed on how to
> atomically expose a notification to user space that it should reseed.
> Atomicity is key for the VM clone case. This patchset implements a
> potential path to do so.
>
> This patchset introduces an epoch value as the means of communicating to
> the guest the need to reseed. The epoch is a 32bit value with the
> following form:
>
>                RNG epoch
> *-------------*---------------------*
> | notifier id | epoch counter value |
> *-------------*---------------------*
>       8 bits           24 bits
>
> Changes in this value signal moments in time that PRNGs need to be
> re-seeded. As a result, the intended use of the epoch from user space
> PRNGs is to cache the epoch value every time they reseed using kernel
> entropy, then control that its value hasn't changed before giving out
> random numbers. If the value has changed the PRNG needs to reseed before
> producing any more random bits.
>
> The API for getting hold of this value is offered through
> /dev/(u)random. We introduce a new ioctl for these devices, which
> creates an anonymous file descriptor. User processes can call the
> ioctl() to get the anon fd and then mmap it to a single page. That page
> contains the value of the epoch at offset 0.
>
> Naturally, random.c is the component that maintains the RNG epoch.
> During initialization it allocates a single global page which holds the
> epoch value. Moreover, it exposes an API to kernel subsystems
> (notifiers) which can report events that require PRNG reseeding.
> Notifiers register with random.c and receive an 8-bit notifier id (up to
> 256 subscribers should be enough) and a pointer to the epoch. Notifying,
> then, is equivalent to writing in the epoch address a new epoch value.
>
> Notifiers write epoch values that include the notifier ID on the higher
> 8 bits and increasing counter values on the 24 remaining bits. This
> guarantees that two notifiers cannot ever write the same epoch value,
> since notificator IDs are unique.
>
> The first patch of this series implements the epoch mechanism. It adds
> the logic in the random.c to maintain the epoch page and expose the
> user space facing API. It also adds the internal API that allows kernel
> systems to register as notifiers.

 From userspace point of view, having to open /dev/random, ioctl, and mmap()
is a no-go for a (CS)PRNG embedded in libc for arc4random().

I'm biased, as I proposed to expose such seed epoch value to userspace through
getrandom() directly, relying on vDSO for reasonable performances, because
current's glibc arc4random() is somewhat to slow to be a general replacement
rand().

See
https://lore.kernel.org/all/cover.1673539719.git.ydroneaud@opteya.com/
https://lore.kernel.org/all/ae35afa5b824dc76c5ded98efcabc117e6dd3d70@opteya.com/

Reards.

-- 
Yann Droneaud


