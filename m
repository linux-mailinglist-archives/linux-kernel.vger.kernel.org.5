Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1274C780C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377161AbjHRNdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377156AbjHRNdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:33:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83F32D50
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:33:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 757D7630BE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 13:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6155DC433C7;
        Fri, 18 Aug 2023 13:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692365583;
        bh=nQkSvjw/b52/PsLHpuHKay9SWoBTTMGR4P0aQ3yKgKg=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=r+Uw3TaYEO8U6g7zP7fe1guf5B0kFPn65KoDCs+KY7uqsyZiQW75+lcWJffWHI1sc
         E91kdgDxcCMebfX4jRAaQXOmd40NMtNw0ArIcuF+yNcUj0tZEdwMIPcqvGaovI582/
         OQkYIsCOb78TaU1yZ0aFAqcBCxE7nIi9nbLadPBUoQ0S6JSJ8Jbxb0nwO8ewg715V2
         jDBmzkcNZrA3WEZoOh+BmEVoy8kwicDbd8WjLm57SFk5VOHzVtfJjU8QN94Grr+vOw
         2pi2lQ4hQtbh4+E6i9APbK1MhUDYi1Aygn0hbv1xFjaoYgLa64/q1ici8YS1+7UDv2
         Qrk+RWWJy/GzA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Yunhui Cui <cuiyunhui@bytedance.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
        bjorn@rivosinc.com, conor.dooley@microchip.com, jszhang@kernel.org,
        andy.chiu@sifive.com, cuiyunhui@bytedance.com,
        dave.hansen@linux.intel.com, elver@google.com, glider@google.com,
        cyphar@cyphar.com, kirill.shutemov@linux.intel.com,
        keescook@chromium.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] riscv: add userland instruction dump to RISC-V splats
In-Reply-To: <20230818121504.60492-1-cuiyunhui@bytedance.com>
References: <20230818121504.60492-1-cuiyunhui@bytedance.com>
Date:   Fri, 18 Aug 2023 15:33:01 +0200
Message-ID: <878ra8o4qa.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Nice!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
