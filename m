Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ADE78B0F3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjH1Msh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjH1MsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:48:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7831512D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 05:48:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CB2E63723
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA959C433C8;
        Mon, 28 Aug 2023 12:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693226889;
        bh=kDq/niXhUU4fC0NJCwF4054vsgDUGlnT0wfr+SrdKmc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=L5WfgM6kxZ2A5b4o8Jnawow6CY5FXahBc83FH1e+Eq6L0sdo7kRqhH7bUiJTezpdb
         r/MVVM1t2TgGqfeU1WZxPbdo3LvVCMQhP7SHWQ+CrTk+aSQr+ZfGYJJmDc1zjfppu5
         45Q3/niUU3ot46QvPmgiFiVKGglmry80DY8QQa/SHg3Zphkaom3sivx5/MVC3dGVI6
         Bixmk6CRFtQCep/NHp2c34TZ3FvKPxnnxA2nqWf3QX+zEGmCddzexhHATOPO+RPs5a
         Kywa9QtSWDnLVUOUNOTQVkRZpyGCEOw/5Km8/ogI/tTKQvflvtwSPhurln9ixoquAr
         XlY07v+RYQgUQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Nam Cao <namcaov@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org
Cc:     Nam Cao <namcaov@gmail.com>
Subject: Re: [PATCH] riscv: provide riscv-specific is_trap_insn()
In-Reply-To: <20230827205641.46836-1-namcaov@gmail.com>
References: <20230827205641.46836-1-namcaov@gmail.com>
Date:   Mon, 28 Aug 2023 14:48:06 +0200
Message-ID: <874jkjl4e1.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nam Cao <namcaov@gmail.com> writes:

> uprobes expects is_trap_insn() to return true for any trap instructions,
> not just the one used for installing uprobe. The current default
> implementation only returns true for 16-bit c.ebreak if C extension is
> enabled. This can confuse uprobes if a 32-bit ebreak generates a trap
> exception from userspace: uprobes asks is_trap_insn() who says there is no
> trap, so uprobes assume a probe was there before but has been removed, and
> return to the trap instruction. This cause an infinite loop of entering
> and exiting trap handler.
>
> Instead of using the default implementation, implement this function
> speficially for riscv which checks for both ebreak and c.ebreak.

I took this for a spin, and it indeed fixes this new hang! Nice!

However, when I tried setting an uprobe on the ebreak instruction
(offset 0x118) from your example [1], the probe does not show up in the
trace buffer.

Any ideas?

Regardless, your patch fixes the hang:

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

[1] https://lore.kernel.org/linux-riscv/ZOum50Py8Vki+Nd3@nam-dell/
