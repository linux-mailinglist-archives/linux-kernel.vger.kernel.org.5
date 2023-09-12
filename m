Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995CE79D0CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjILMN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbjILMNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:13:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B0310D2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:13:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28082C433C8;
        Tue, 12 Sep 2023 12:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694520823;
        bh=7jAMJX8m5mBzicQzcKiFy5A5RvULyRKUPRv33QhrqT8=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=Tw4X9uOip7ayv+vbb7p/Qq+GkFp0FY3Mq+fPr+FTvm27n0fUZO5Zv/ve6W1BKuqfA
         UqcvRyM4Y5dwoJYw9zoQFIFwKVWEtddvvhPFGP2B8h8p4lgxeaZaQp26iue1edlo9I
         7dqNkv1TXu2h5ojnXNBfAohOQwgMsqDwUdivWxVFE2goZ84s5kMNsU1geHGxavAXFz
         oBut8WStE8EVCwu8LqOMRMFviXTJObUaW14d0yivHdw97aiLa7bmaVv8gy/G8s0Wy1
         GKA8GFT2EC2gDzyBPRRzWUbWoR31eMnR6QeYxphNRNSt3EjHdfMJKebFqD5OXDmAip
         RqDSmC2IqWi0A==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Yunhui Cui <cuiyunhui@bytedance.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
        bjorn@rivosinc.com, conor.dooley@microchip.com, jszhang@kernel.org,
        andy.chiu@sifive.com, cuiyunhui@bytedance.com,
        dave.hansen@linux.intel.com, elver@google.com, glider@google.com,
        cyphar@cyphar.com, kirill.shutemov@linux.intel.com,
        keescook@chromium.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] riscv: add userland instruction dump to RISC-V splats
In-Reply-To: <20230912021349.28302-1-cuiyunhui@bytedance.com>
References: <20230912021349.28302-1-cuiyunhui@bytedance.com>
Date:   Tue, 12 Sep 2023 14:13:40 +0200
Message-ID: <87jzsvd1xn.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yunhui Cui <cuiyunhui@bytedance.com> writes:

> Add userland instruction dump and rename dump_kernel_instr()
> to dump_instr().
>
> An example:
> [    0.822439] Freeing unused kernel image (initmem) memory: 6916K
> [    0.823817] Run /init as init process
> [    0.839411] init[1]: unhandled signal 4 code 0x1 at 0x000000000005be18=
 in bb[10000+5fb000]
> [    0.840751] CPU: 0 PID: 1 Comm: init Not tainted 5.14.0-rc4-00049-gbd6=
44290aa72-dirty #187
> [    0.841373] Hardware name:  , BIOS
> [    0.841743] epc : 000000000005be18 ra : 0000000000079e74 sp : 0000003f=
ffcafda0
> [    0.842271]  gp : ffffffff816e9dc8 tp : 0000000000000000 t0 : 00000000=
00000000
> [    0.842947]  t1 : 0000003fffc9fdf0 t2 : 0000000000000000 s0 : 00000000=
00000000
> [    0.843434]  s1 : 0000000000000000 a0 : 0000003fffca0190 a1 : 0000003f=
ffcafe18
> [    0.843891]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 00000000=
00000000
> [    0.844357]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 00000000=
00000000
> [    0.844803]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 00000000=
00000000
> [    0.845253]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 00000000=
00000000
> [    0.845722]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 00000000=
00000000
> [    0.846180]  s11: 0000000000d144e0 t3 : 0000000000000000 t4 : 00000000=
00000000
> [    0.846616]  t5 : 0000000000000000 t6 : 0000000000000000
> [    0.847204] status: 0000000200000020 badaddr: 00000000f0028053 cause: =
0000000000000002
> [    0.848219] Code: f06f ff5f 3823 fa11 0113 fb01 2e23 0201 0293 0000 (8=
053) f002
> [    0.851016] Kernel panic - not syncing: Attempted to kill init! exitco=
de=3D0x00000004
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
