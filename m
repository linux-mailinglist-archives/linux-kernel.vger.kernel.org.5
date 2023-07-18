Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E23A7586BE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjGRVUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjGRVUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:20:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04EEC0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:20:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4340760F16
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 21:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD7EC433C7;
        Tue, 18 Jul 2023 21:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689715230;
        bh=BNmey0qZr97jeo30G5U3uLZrj89rJCidj/kyhI65D0c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TGWyCWuGfwtm6RzVbBADCVL+Df6SgXsQAt+sY2GZ+UUNUYViUg2f1lYNlB/eGUrdO
         RH/HcOzcrTsE0N/Tw5jkh4WY25SiL8MRai4bDMvUZsexYR2yD5/6i+EzDhOjUA8Lrp
         lzIXLiKv5AN5SBXcwkHtHeAX0I6R/uRqV+X/hiH95oOBEpaJR5ETbAfu/3x2X7Ap2d
         ALLQigK3dQLYLoNdWOheg3FzlKRpVsX0CgSIHwv0PcS4fblkvvpPf+sMPOdGertzcf
         aLweMUgexBgjEliPFo4UFccw0FIM8ms1I5MNxMBvmKqInVsOagLjJdFwJf3m1XDQ9v
         7Ax5DB6X7c24A==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Celeste Liu <coelacanthushex@gmail.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        =?utf-8?B?QmrDtnJu?= =?utf-8?B?IFTDtnBlbA==?= 
        <bjorn@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Celeste Liu <CoelacanthusHex@gmail.com>,
        Felix Yan <felixonmars@archlinux.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Subject: Re: [PATCH v3] riscv: entry: set a0 = -ENOSYS only when syscall != -1
In-Reply-To: <20230718210037.250665-1-CoelacanthusHex@gmail.com>
References: <20230718210037.250665-1-CoelacanthusHex@gmail.com>
Date:   Tue, 18 Jul 2023 23:20:27 +0200
Message-ID: <871qh4lxwk.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Celeste Liu <coelacanthushex@gmail.com> writes:

> When we test seccomp with 6.4 kernel, we found errno has wrong value.
> If we deny NETLINK_AUDIT with EAFNOSUPPORT, after f0bddf50586d, we will
> get ENOSYS instead. We got same result with commit 9c2598d43510 ("riscv: =
entry:
> Save a0 prior syscall_enter_from_user_mode()").
>
> After analysing code, we think that regs->a0 =3D -ENOSYS should only be e=
xecuted
> when syscall !=3D -1 In __seccomp_filter, when seccomp rejected this sysc=
all with
> specified errno, they will set a0 to return number as syscall ABI, and th=
en
> return -1. This return number is finally pass as return number of
> syscall_enter_from_user_mode, and then is compared with NR_syscalls after
> converted to ulong (so it will be ULONG_MAX). The condition
> syscall < NR_syscalls will always be false, so regs->a0 =3D -ENOSYS is al=
ways
> executed. It covered a0 set by seccomp, so we always get ENOSYS when match
> seccomp RET_ERRNO rule.
>
> Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
> Reported-by: Felix Yan <felixonmars@archlinux.org>
> Co-developed-by: Ruizhe Pan <c141028@gmail.com>
> Signed-off-by: Ruizhe Pan <c141028@gmail.com>
> Co-developed-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
> Signed-off-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> Tested-by: Felix Yan <felixonmars@archlinux.org>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
