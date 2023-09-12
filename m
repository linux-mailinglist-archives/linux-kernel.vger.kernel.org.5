Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B021479C837
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjILHcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjILHcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:32:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F8EE73
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:32:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD38C433C7;
        Tue, 12 Sep 2023 07:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694503930;
        bh=dMC0uSI27EU23WMp3+VJekGrCo9Z7fUubo7Y54KD6PA=;
        h=From:To:Cc:Subject:Date:From;
        b=uMqeMhsFfF7qQk4qNvUPNkwD+uwtLp2ZVAY6opjn/00PYa5feL3Y/B1vpYwN6NvOg
         G1v27iNKMk90tyKqKSHX67y+aj0MEXKsmKFtQ9r7MBuOPyxjwjQdNN/C2oemo+x0cZ
         GTDe/O4NxjCmgc07dvV+FiVhJCUls7YGEepPqGxQb1LpRFQ9mC4TfxHEWCvrTBrLl+
         d9MNsf/nsuC/jjgc7MvVB3NuEtI2sceSq2PsHI8EJZMiGbdqHGRHthLuCsqNb4Cmkp
         fyra9qzFfLtFnkhM7wWNzmWTcfT0MoBXYeCC302azW+vPPuhRADrnPIF3qTKe/GQVi
         +4zMG3Q+ry7Qg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 0/3] riscv: vdso.lds.S: some improvement
Date:   Tue, 12 Sep 2023 15:20:12 +0800
Message-Id: <20230912072015.2424-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series renews one of my last year RFC patch[1], tries to improve
the vdso layout a bit. 

patch1 removes useless symbols
patch2 merges .data section of vdso into .rodata because they are
readonly
patch3 is the real renew patch, it removes hardcoded 0x800 .text start
addr. But I rewrite the commit msg per Andrew's suggestions and move
move .note, .eh_frame_hdr, and .eh_frame between .rodata and .text to
keep the actual code well away from the non-instruction data.

Link: https://lore.kernel.org/linux-riscv/20221123161805.1579-1-jszhang@kernel.org/ [1]

Jisheng Zhang (3):
  riscv: vdso.lds.S: drop __alt_start and __alt_end symbols
  riscv: vdso.lds.S: merge .data section into .rodata section
  riscv: vdso.lds.S: remove hardcoded 0x800 .text start addr

 arch/riscv/kernel/vdso/vdso.lds.S | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

-- 
2.40.1

