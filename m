Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390FD75AA97
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjGTJ0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjGTJZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:25:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B7E2E153
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33E0B6192A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5704C433C8;
        Thu, 20 Jul 2023 09:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689844120;
        bh=7vwFcJOK2o2ICUdblT8hzETcmg2FeUVLkIn7N0rywqM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DyY8a9Zf8fGL/VPrimuDKR41GKnAtY7C1jKKvU2roErbYtGFI6ilB4gch6VPg3IOk
         NTxq7dgvKiWSmy/ZHq8UGLzJ12f0aijd9/rYauzgFG7VUxZFs1ju+/J7/Lo/3F69gy
         yMyhZT8TMHyLz/I/1NkLuViQsY020M99Q6WS0mTwkxg0tdgkVCDtnL2LvImxb4GrJu
         +TEL5+adOFo+bfNRpPoehSnZkrVd3DCCw6grd457EFuKBESkbu0TdE6WOBsP0BiRrw
         kjC4VVd2F3FtUwtDO6gCUdYEsEXce8bm0FaI8DU2JY/O2bPnTPXAPapRQ7nIFktGiY
         xno4ZTNlBVJXQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Celeste Liu <coelacanthushex@gmail.com>,
        Andreas Schwab <schwab@suse.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Felix Yan <felixonmars@archlinux.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Subject: Re: [PATCH v3] riscv: entry: set a0 = -ENOSYS only when syscall != -1
In-Reply-To: <54D8BFF7-C4D2-417E-B18C-62B5DB17B51B@gmail.com>
References: <20230718210037.250665-1-CoelacanthusHex@gmail.com>
 <mvmo7k8cqns.fsf@suse.de> <878rbbkgqo.fsf@all.your.base.are.belong.to.us>
 <54D8BFF7-C4D2-417E-B18C-62B5DB17B51B@gmail.com>
Date:   Thu, 20 Jul 2023 11:08:37 +0200
Message-ID: <87wmyvq7ai.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Celeste Liu <coelacanthushex@gmail.com> writes:

> On July 20, 2023 12:28:47 AM GMT+08:00, "Bj=C3=B6rn T=C3=B6pel" <bjorn@ke=
rnel.org> wrote:
>>Andreas Schwab <schwab@suse.de> writes:
>>
>>> On Jul 19 2023, Celeste Liu wrote:
>>>
>>>> @@ -308,7 +312,7 @@ asmlinkage __visible __trap_section void do_trap_e=
call_u(struct pt_regs *regs)
>>>>=20=20
>>>>  		if (syscall < NR_syscalls)
>>>>  			syscall_handler(regs, syscall);
>>>> -		else
>>>> +		else if ((long)syscall !=3D -1L)
>>>
>>> You can also use syscall !=3D -1UL or even syscall !=3D -1.
>>
>>The former is indeed better for the eyes! :-) The latter will get a
>>-Wsign-compare warning, no?
>>
>>
>>Bj=C3=B6rn
>
> Well, that's true. And I just found out that by C standards, converting
> ulong to long is implementation-defined behavior, unlike long to ulong
> which is well-defined. So it is really better than (long)syscall !=3D -1L.

If you're respinning, I suggest you use David's suggestion:
 * Remove the comment I suggest you to add
 * Use (signed) long
 * Add syscall >=3D 0 &&
 * else if (syscall !=3D -1)

Which is the least amount of surprises IMO.
