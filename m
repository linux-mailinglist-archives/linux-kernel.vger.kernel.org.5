Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3996D759AC0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjGSQ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjGSQ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:28:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A6CB6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:28:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D50D612C4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F21C433C9;
        Wed, 19 Jul 2023 16:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689784130;
        bh=mIPWRegXctVmbaqFYfnJtfGdsGtv2kb3BA0sg42Weq0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EXvCiOqQIyWkGkHjU75JEkTVUDrykU8zhj8RUWweMzynUbaCvHTgywL7G2WERN0H7
         VnG2j3aRlxlRaJFxaHG4b0uhm58Y2MWZhCFggmrFdcAyJx/ADqR5FiPqYrKGQFQp4o
         yYVoOu463yyPZ9+hReuXnSls5Oul4NtCCUGXz0CVsk/UbKw/x0QQR2WmUq2DXa6fD4
         uBOoM1mlsNtFbA/gxnPJdj8m1ToHDk7UdBD4FSoGQOFGrL4KmlDi7NUjYOm7m2neSn
         4cn3Y9JAjG8r64m0QeqP/9saPfcnfwjjXW2/871nHHKef4rGYeNLMlh+DvBnxl6ZrM
         OB6eIMspE+DvQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Andreas Schwab <schwab@suse.de>,
        Celeste Liu <coelacanthushex@gmail.com>
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
In-Reply-To: <mvmo7k8cqns.fsf@suse.de>
References: <20230718210037.250665-1-CoelacanthusHex@gmail.com>
 <mvmo7k8cqns.fsf@suse.de>
Date:   Wed, 19 Jul 2023 18:28:47 +0200
Message-ID: <878rbbkgqo.fsf@all.your.base.are.belong.to.us>
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

Andreas Schwab <schwab@suse.de> writes:

> On Jul 19 2023, Celeste Liu wrote:
>
>> @@ -308,7 +312,7 @@ asmlinkage __visible __trap_section void do_trap_eca=
ll_u(struct pt_regs *regs)
>>=20=20
>>  		if (syscall < NR_syscalls)
>>  			syscall_handler(regs, syscall);
>> -		else
>> +		else if ((long)syscall !=3D -1L)
>
> You can also use syscall !=3D -1UL or even syscall !=3D -1.

The former is indeed better for the eyes! :-) The latter will get a
-Wsign-compare warning, no?


Bj=C3=B6rn
