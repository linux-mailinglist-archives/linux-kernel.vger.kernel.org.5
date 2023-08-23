Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2D67853BC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbjHWJVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjHWJSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:18:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722C33A93;
        Wed, 23 Aug 2023 02:08:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0841462C55;
        Wed, 23 Aug 2023 09:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F3CC433C7;
        Wed, 23 Aug 2023 09:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692781688;
        bh=io4Q0PxusKKtCDplWhMVdna1pz9TzX1YUrlW8pFjO1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XAA2JrXx6qAAt+nZq1vahQ+uXOCJ1xlcmx538cqtPSkgfM9aaoHDFrV5McTfaba+x
         CM20rqIIJEXxfCH5pGV8PZS/PwKcnRSImWu5BPjBARP75nnyoDPFwhYhue8KiQhZgK
         ei+3vUUWk1gKp9TlE80sWmmW0qv/JNHNV+1+PVvY=
Date:   Wed, 23 Aug 2023 11:08:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Babis Chalios <bchalios@amazon.es>
Cc:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, graf@amazon.de,
        xmarcalx@amazon.co.uk, aams@amazon.de, dwmw@amazon.co.uk
Subject: Re: [RFC PATCH 1/2] random: emit reseed notifications for PRNGs
Message-ID: <2023082322-semester-heave-e5bc@gregkh>
References: <20230823090107.65749-1-bchalios@amazon.es>
 <20230823090107.65749-2-bchalios@amazon.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823090107.65749-2-bchalios@amazon.es>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 11:01:05AM +0200, Babis Chalios wrote:
> Sometimes, PRNGs need to reseed. For example, on a regular timer
> interval, to ensure nothing consumes a random value for longer than e.g.
> 5 minutes, or when VMs get cloned, to ensure seeds don't leak in to
> clones.
> 
> The notification happens through a 32bit epoch value that changes every
> time cached entropy is no longer valid, hence PRNGs need to reseed. User
> space applications can get hold of a pointer to this value through
> /dev/(u)random. We introduce a new ioctl() that returns an anonymous
> file descriptor. From this file descriptor we can mmap() a single page
> which includes the epoch at offset 0.
> 
> random.c maintains the epoch value in a global shared page. It exposes
> a registration API for kernel subsystems that are able to notify when
> reseeding is needed. Notifiers register with random.c and receive a
> unique 8bit ID and a pointer to the epoch. When they need to report a
> reseeding event they write a new epoch value which includes the
> notifier ID in the first 8 bits and an increasing counter value in the
> remaining 24 bits:
> 
>               RNG epoch
> *-------------*---------------------*
> | notifier id | epoch counter value |
> *-------------*---------------------*
>      8 bits           24 bits

Why not just use 32/32 for a full 64bit value, or better yet, 2
different variables?  Why is 32bits and packing things together here
somehow simpler?

thanks,

greg k-h
