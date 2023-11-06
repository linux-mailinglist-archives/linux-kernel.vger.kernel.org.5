Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6687E30C0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjKFXLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjKFXLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:11:17 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F8AD77
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 15:11:13 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6ce2988d62eso3294220a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 15:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699312273; x=1699917073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cl1a3BIlGOodzNLugPywadXuDNbB772BtN6sPF7d3Lw=;
        b=gHkoTftqQ8UqHb1fR8OSU+h3xjRiunf3HJbSl47pP26UeJXeH4kk7/B+YPKfDV3eXd
         uLDQOBl+ySS09Dalvr6lcSyRGXIUvH4uk+NUDC5g2Bo5HkC7oMhuIibjsDnzRE8JVqYA
         YHizBJw34ojHQPMnZtVdYKAIswJKWBSftrPCRxNaqTn72gHtR5DBfbJlp2LmCJFW6ToF
         DDEMFLlU9J2A6wnGaadN4WIMVXmOjTtyNwKzeSVFQyXGGd04/k0pPUX2iiTTk73NGFuj
         LqIYs0/Qtd1+J6qHXehEHcFBj2OqgvHtgsgh7HdGdy927Uzd0IQVd0iyEHcMy1vD5zX8
         kGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699312273; x=1699917073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cl1a3BIlGOodzNLugPywadXuDNbB772BtN6sPF7d3Lw=;
        b=D1iL/wV5bqX4NFWA/PD4OiA9qlj5TDoqrlgUg3qXVCriksv+zf42A4JP7sYUWFmCXz
         Xal8+6OEMSAjxcIrBTa1A8c1ZXmwyUtiy8QZ3TsA1Pv5HrDMGKdDagqkB3g/4OqmT/2n
         iWZ4R0of/xpmsDkukvsyyVxc9cAv6ZirOEkbuQJL0An9AIwO5SKocy9EvObdHpSqq/j0
         x9W4PgBBG3T9onvhfxzV/oFX99G3yJtmSJROfhp7n5eyCE7G2CYWyMMhDWv/xiHUv+fC
         bj+giFAVhuS2w+NNsZNE/ns2pPnc070X6OpzXJHLc49Lt2sO/aoIQpUXIOftFr65940d
         9Eyg==
X-Gm-Message-State: AOJu0Ywic7PcX/twWaDTqegcZQmDbg9NVID/d0H1RdQNaldbVtnGIlYH
        Yslrp7xUiT1ThPl65h60ZOQYVCfie+hzh7efm/fqFA==
X-Google-Smtp-Source: AGHT+IGb1DmE54qptCOR2jAgyCBNxxBT8ZRXpnCC4KrdEm4H9wksmx24bdsLdxd9hYmTf1F9bDafFA==
X-Received: by 2002:a05:6830:2b2a:b0:6d3:1f3e:4c4 with SMTP id l42-20020a0568302b2a00b006d31f3e04c4mr19885732otv.0.1699312272970;
        Mon, 06 Nov 2023 15:11:12 -0800 (PST)
Received: from evan.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w19-20020a9d77d3000000b006d309c126fbsm1418385otl.57.2023.11.06.15.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 15:11:12 -0800 (PST)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     cleger@rivosinc.com, Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] RISC-V: Remove __init on unaligned_emulation_finish()
Date:   Mon,  6 Nov 2023 15:11:05 -0800
Message-Id: <20231106231105.3141413-1-evan@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function shouldn't be __init, since it's called during hotplug. The
warning says it well enough:

WARNING: modpost: vmlinux: section mismatch in reference:
check_unaligned_access_all_cpus+0x13a (section: .text) ->
unaligned_emulation_finish (section: .init.text)

Signed-off-by: Evan Green <evan@rivosinc.com>
Fixes: 71c54b3d169d ("riscv: report misaligned accesses emulation to hwprobe")

---

 arch/riscv/kernel/traps_misaligned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index bba301b5194d..5eba37147caa 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -625,7 +625,7 @@ bool check_unaligned_access_emulated(int cpu)
 	return misaligned_emu_detected;
 }
 
-void __init unaligned_emulation_finish(void)
+void unaligned_emulation_finish(void)
 {
 	int cpu;
 
-- 
2.34.1

