Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21FF767D16
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 10:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjG2IKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 04:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjG2IKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 04:10:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DAC3C30;
        Sat, 29 Jul 2023 01:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1690618237;
        bh=K9Nu5Mur1VUu1WUTzSv/ImXqpeDJ9TPv/2LQQo1sYIo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QSIFGoJV6H8Ihv2zIshooG1Ggr7zvlYF8ylzKx+wur+ekbenPmlijEx3jPFhzkdhM
         +WKTT8VLXbmuYYd/PJWEg+yUmj0mu17Bg71e/2S7d5IcvAkxJSbVWxDPgZA19dQVUe
         dQAIBM+a+DPt3E36gO3f1NUBcBy2L8L93lDQZieZH/SJGAa9s5OtVkqDuCFtC/lvM+
         GQ2cBQh/jLQN0ubpN8Kzvln82vTJA4/Vf3reWUmaA4gf6LbOJfl2OlsjMLE1buEsLT
         j7dn2oQowirDgwKXH77u2JlctB+7LT43oY/tnW+7Ajs06e+sKC6Encse0tnaGl2Wxr
         gjZbR9n4rzgLg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RCcd91fYnz4wb8;
        Sat, 29 Jul 2023 18:10:37 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org
Subject: Re: Login broken with old userspace (was Re: [PATCH v2] selinux:
 introduce an initial SID for early boot processes)
In-Reply-To: <CAFqZXNtsCKsr0YHPCSJJQ5An=RoMhf0dufgr7P_SnAAv7CrLjw@mail.gmail.com>
References: <20230620131223.431281-1-omosnace@redhat.com>
 <87edkseqf8.fsf@mail.lhotse>
 <CAFqZXNtsCKsr0YHPCSJJQ5An=RoMhf0dufgr7P_SnAAv7CrLjw@mail.gmail.com>
Date:   Sat, 29 Jul 2023 18:10:36 +1000
Message-ID: <875y63dtoj.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ondrej Mosnacek <omosnace@redhat.com> writes:
> On Fri, Jul 28, 2023 at 4:12=E2=80=AFAM Michael Ellerman <mpe@ellerman.id=
.au> wrote:
>>
>> Ondrej Mosnacek <omosnace@redhat.com> writes:
>> > Currently, SELinux doesn't allow distinguishing between kernel threads
>> > and userspace processes that are started before the policy is first
>> > loaded - both get the label corresponding to the kernel SID. The only
>> > way a process that persists from early boot can get a meaningful label
>> > is by doing a voluntary dyntransition or re-executing itself.
>>
>> Hi,
>>
>> This commit breaks login for me when booting linux-next kernels with old
>> userspace, specifically Ubuntu 16.04 on ppc64le. 18.04 is OK.
>>
>> The symptom is that login never accepts the root password, it just
>> always says "Login incorrect".
>>
>> Bisect points to this commit.
>>
>> Reverting this commit on top of next-20230726, fixes the problem
>> (ie. login works again).
>>
>> Booting with selinux=3D0 also fixes the problem.
>>
>> Is this expected? The change log below suggests backward compatibility
>> was considered, is 16.04 just too old?
>
> Hi Michael,
>
> I can reproduce it on Fedora 38 when I boot with SELINUX=3Ddisabled in
> /etc/selinux/config (+ a kernel including that commit), so it likely
> isn't caused by the userspace being old. Can you check what you have
> in /etc/selinux/config (or if it exists at all)?

Not sure if you still need it, but /etc/selinux/config doesn't exist in
the 16.04 image.

cheers
