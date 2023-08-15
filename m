Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D88377C4AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjHOAs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjHOAs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:48:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDB91737
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:48:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EADB64BD3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3440DC433CB;
        Tue, 15 Aug 2023 00:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692060504;
        bh=8tSfMGnAd50oKVThmqq7FfKvCcOhK1uCIhtjujNgeQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qSFPXhmTH+ypX1rtN/dHmPJaaNRWsqIQ7b4KRWeHq7rgad0ebhL2oshth6MtFfuuw
         DP7MaCtJ8wO/PNXsqee6Qcy7ULH8xyehvV5mXqSfkP5nNOkSYqrynfT1KsGSd2Dmbr
         J4y0QjriFENCS4lLHlkd50YQ851oqCGVeKObYb04NMXIqoFowkSE35TdT0gsODcBep
         vInYcQSJFrnWAvDF+hL0nRJu2y5t3o7E0gMrfQp0gEp0VzsdfEnuRhw0o9beRtPh7P
         CllckWVfnUx4neT5fms8LtjLoJ7uIC9/qfWg607LcRSdB8av52Iu6AeI8fCnMvJkOK
         wTDsgj9tuCvQg==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 15/20] ARC: entry: EV_MachineCheck dont re-read ECR
Date:   Mon, 14 Aug 2023 17:48:08 -0700
Message-Id: <20230815004813.555115-16-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815004813.555115-1-vgupta@kernel.org>
References: <20230815004813.555115-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/kernel/entry.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index f291fc8476d7..46582fbebcf2 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -95,16 +95,15 @@ END(instr_service)
 
 ENTRY(EV_MachineCheck)
 
-	EXCEPTION_PROLOGUE
+	EXCEPTION_PROLOGUE	; ECR returned in r10
 
-	lr  r2, [ecr]
 	lr  r0, [efa]
 	mov r1, sp
 
 	; MC excpetions disable MMU
 	ARC_MMU_REENABLE r3
 
-	lsr  	r3, r2, 8
+	lsr  	r3, r10, 8
 	bmsk 	r3, r3, 7
 	brne    r3, ECR_C_MCHK_DUP_TLB, 1f
 
-- 
2.34.1

