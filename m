Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39720763DD8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjGZRmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGZRmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:42:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212482685
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:42:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3D9061BE2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 17:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE632C433C8;
        Wed, 26 Jul 2023 17:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690393320;
        bh=dMC0uSI27EU23WMp3+VJekGrCo9Z7fUubo7Y54KD6PA=;
        h=From:To:Cc:Subject:Date:From;
        b=UhLvcZHN4xJmXgD+c0TELRci4mIYAjXQUSdPuSKlpunL1yhtHSoXQ5GOEGtJLE8oS
         M47JXYUfn/4jeQiWRCUhfTs2ZIlyi9AMqvZufysykqUl7kBg/RiyGhJDDcRqLigUWo
         0igZkZxbU3Y14nU0ttNNpvs2tTl+xpGcB8Ngj/ZoCReBmz/Tv0u6tS+aS1fnGHQ79Q
         GsQN/Gk8sA4Lzt6AqjmRPwAjCPTvjFoDB0VUWgeAVgQLrOTIsuzcEb4F+x28RC+Pp7
         7FWX88/bSamgO6NiFBdrJYTjJzEsnhG8PEwCZPVs5zzT6FVP7Lxw+mY4r/Wdw7V81x
         eL7LSaXuFASYQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] riscv: vdso.lds.S: some improvement
Date:   Thu, 27 Jul 2023 01:30:21 +0800
Message-Id: <20230726173024.3684-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

