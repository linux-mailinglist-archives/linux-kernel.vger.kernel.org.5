Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4824477E4BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344034AbjHPPL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344025AbjHPPKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:10:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0875B1FCE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:10:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B49863AB4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7BEC433BC;
        Wed, 16 Aug 2023 15:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692198654;
        bh=0x89vx8T7ctChfZuk4nUajsbvgaqWMb4v5FnF8RzIps=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=d2ilGcmUc2lIoXlJIxwbA9xsJE8ThubtKAfd5IO0NRTSTadGqUE8bCddtcFkE2AbS
         YiUjYK9SeLUS95ZDV49L5iI/kuFcZFS1nydpgRoIR3FB+TMv7PDkUakxLkecYndN/W
         WsB6X0Kc7+N/iH7zGCSZuHfNlA9PZv0t2S/7TcYm7l6CJMSCkKk0LJ8h6YOzGsws6T
         /Ek8MmIsJcdtaj3NuAvIvUwgmva44HAZbG1kDsBLeeLn4E8w2diMJyJmBBMbNZE7FZ
         ITi1FtPkH6JNTxdVqvyiNJC6aEcrqX1VlUUvUIX+FuxC6x7fQnvYSQ7hZuPlGv47bb
         DX2l/+G/IS98A==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Yunhui Cui <cuiyunhui@bytedance.com>, conor.dooley@microchip.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, peterz@infradead.org, mpe@ellerman.id.au,
        jpoimboe@kernel.org, mark.rutland@arm.com, svens@linux.ibm.com,
        cuiyunhui@bytedance.com, guoren@kernel.org, jszhang@kernel.org,
        ebiederm@xmission.com, bjorn@rivosinc.com, heiko@sntech.de,
        xianting.tian@linux.alibaba.com, mnissler@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: Dump user opcode bytes on fatal faults
In-Reply-To: <20230329082950.726-1-cuiyunhui@bytedance.com>
References: <20230329082950.726-1-cuiyunhui@bytedance.com>
Date:   Wed, 16 Aug 2023 17:10:51 +0200
Message-ID: <87v8dfqays.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunhui,

Waking up the dead! ;-)

Yunhui Cui <cuiyunhui@bytedance.com> writes:

> We encountered such a problem that when the system starts to execute
> init, init exits unexpectedly with error message: "unhandled signal 4
> code 0x1 ...".
>
> We are more curious about which instruction execution caused the
> exception. After dumping it through show_opcodes(), we found that it
> was caused by a floating-point instruction.
>
> In this way, we found the problem: in the system bringup , it is
> precisely that we have not enabled the floating point function(CONFIG_FPU
> is set, but not enalbe COMPAT_HWCAP_ISA_F/D in the dts or acpi).
>
> Like commit ba54d856a9d8 ("x86/fault: Dump user opcode bytes on fatal
> faults"), when an exception occurs, it is necessary to dump the
> instruction that caused the exception.

X86's show_opcodes() is used both for kernel oops:es, and userland
unhandled signals. On RISC-V there's dump_kernel_instr() added in commit
eb165bfa8eaf ("riscv: Add instruction dump to RISC-V splats").

Wdyt about reworking that function, so that it works for userland epc as
well? I think it's useful to have the surrounding instruction context,
and not just on instruction.


Bj=C3=B6rn
