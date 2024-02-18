Return-Path: <linux-kernel+bounces-70203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDED8594BB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7CFCB21DF7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320FD4C80;
	Sun, 18 Feb 2024 05:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhcEt3ck"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC7F1C2D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 05:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708232556; cv=none; b=UyW9CE7tapAZJP0znUcRleE8gx5LDGVnzqoKBHBxNJtcYpLbqGIQbjpUTj7YY8hZ61DWXxgvPbTujtC3a3wszWep6WTQ9lTzvXMiR7AEFSPGJUUu7m+j/ffRUdpA2tckLVPptmUiaAVfNximLOyaRTNc96ItS8CQtvcf/DKBZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708232556; c=relaxed/simple;
	bh=EH8yWcDAy3W3ecDVf+82YXRrT8f3dPAB53gelUfTzFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l2A/ccYyphj2fSOhj9X65j3MXqJHcdNjptUdc7cufDgscRQuxC+jjtRCQ9s2AImJfv7C+AlZjipXht/PBZadrvdxgfxuJ6vLYXzOokA8spW3Mp9dLX3z7YpLaA6BYuPBfWid4yP+Z84Do7XiL1Ee2AJMoSHxslPyyp7oS7hKeaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhcEt3ck; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbb4806f67so2348362b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 21:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708232554; x=1708837354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uEhuBzl/XUO5srIc9IiEtG7zueZD6dPpQ8b++F1rfE4=;
        b=YhcEt3ckxjgFJ5+j9myqrg8he1yUVNiCVKrfwl33t/0/0klpxef99y4Tv+4FhQvwbs
         OmwANA4n8jsjv5nXvy2lFls7kO7Reafr0wHQDfOvzckbjwBUOYSvKkKnnsDLjJ8KwRNG
         GEFNgY5uUFMsdAfDBydrfzWstHtPTcZf/YnDXJ5TQGa0pyZWviKg1O4lhslbaFMMp366
         jLMrPKJxeeOxP0WHRSCGq53w1LCoIZ77SiMS5Cj4T3Xx3kKVBAOupbjNrGNLySUeps3l
         O79g8V6yb2rU3ntsjN+T42yPHDfA+J3JIrAoFUkmdMBEUVgkpYTbUfv0aU0z0p3+PSVr
         Abtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708232554; x=1708837354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEhuBzl/XUO5srIc9IiEtG7zueZD6dPpQ8b++F1rfE4=;
        b=IAOIxsQzz6VkGS17wf+RBEBdw4L7S+fH9jofRESVgd7uC37VfHNYyOJL4l4Osn+Mop
         tqBGVA33wKI81xudE1zZ9KfN4gGLtBCb2nVlToydj6k7a777v+wK8/HhxZzGzTGPRVEI
         +6QgoV73laRW9k+tX2R0e9AeUMeiA+7XTnMXy15fwE2NMdWAfdOVJCSGsLERHE3aA5Fx
         4O96Jp/2MnpBcLMh+isUAgOwE4DAaFHePgg5X1NUCs02S+PRnbN0xzENpE0jMF2i2IAc
         fe5HXefSgbc5cofqs3RuhEHtUEh2HpBCtUjrKVb98VOAsMQcux6mU91HhcLfT5SxOOd9
         YZ2w==
X-Forwarded-Encrypted: i=1; AJvYcCURyuWRFRZah+wWfarykReRnnvWy4obtu6o+QXS4Sroge1mwriU3W6FuoEDdIWZ7eeh0ItScdHr3tTwnSdeT1yucHXWUortcx5HuQHa
X-Gm-Message-State: AOJu0YxEK2iG9TEx7XjWNIn5niTupHdujx9KhxjeLjOaWo3mnYIfdch5
	7tbsV7YGzoRMySvS+YK3b64HFwltfdwa9hob7aJa+Zov/1Dn2xaq
X-Google-Smtp-Source: AGHT+IFtcp5ctWAyRJeAGhJBhuhoEgIuvQ40gFn8og9Zx9QQmyVo4hFDLZYPPM/JgIF7Q/kwRxHrlw==
X-Received: by 2002:a05:6358:f485:b0:17a:e6d8:b19f with SMTP id ku5-20020a056358f48500b0017ae6d8b19fmr9987069rwb.24.1708232553829;
        Sat, 17 Feb 2024 21:02:33 -0800 (PST)
Received: from nilq-virtual-machine.localdomain ([60.24.211.11])
        by smtp.gmail.com with ESMTPSA id y5-20020a634945000000b005dc48e56191sm2297762pgk.11.2024.02.17.21.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 21:02:33 -0800 (PST)
From: "ni.liqiang" <niliqiang.io@gmail.com>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: "ni.liqiang" <niliqiang.io@gmail.com>,
	"jin . qi" <jin.qi@zte.com.cn>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/iommu: Ensure that the queue base address is successfully written during SMMU initialization.
Date: Sun, 18 Feb 2024 13:02:23 +0800
Message-Id: <20240218050224.33426-1-niliqiang.io@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the system reboot test, I encountered an issue:
After the OS started, the base address of CMDQ failed to be written
successfully and remained at the default value of 0.

Through timing analysis of CMN, it was found that although
the write request for the CMDQ base precedes the write request
for CMDQEN, the write response for the CMDQ base might be later
than that for CMDQEN.

Upon reviewing the SMMU Architecture Specification,
I found the following explanation:
The registers must be initialized in this order:
1. Write SMMU_CMDQ_BASE to set the queue base and size.
2. Write initial values to SMMU_CMDQ_CONS and SMMU_CMDQ_PROD.
3. Enable the queue with an Update of the respective SMMU_CR0.CMDQEN to 1.

If there are no memory barriers, how can we ensure this order?
Therefore, I believe that adding a memory barrier before enabling CMDQ
is necessary to ensure that the base address of CMDQ is correctly written.

The base addresses of EVENTQ and PRIQ would also be subject
to the same situation.

Could you please review if this modification seems reasonable? Thank you.

Signed-off-by: ni.liqiang <niliqiang.io@gmail.com>
Reviewed-by: jin.qi <jin.qi@zte.com.cn>
Tested-by: ni.liqiang <niliqiang.io@gmail.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0ffb1cf17e0b..ac854c46fdf3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3324,6 +3324,11 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
 	writel_relaxed(smmu->cmdq.q.llq.cons, smmu->base + ARM_SMMU_CMDQ_CONS);
 
+	/* Ensure that SMMU_CMDQ_BASE is written completely
+	 * when SMMU_CR0.CMDQEN == 0.
+	 */
+	__iomb();
+
 	enables = CR0_CMDQEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
 				      ARM_SMMU_CR0ACK);
@@ -3350,6 +3355,11 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	writel_relaxed(smmu->evtq.q.llq.prod, smmu->page1 + ARM_SMMU_EVTQ_PROD);
 	writel_relaxed(smmu->evtq.q.llq.cons, smmu->page1 + ARM_SMMU_EVTQ_CONS);
 
+	/* Ensure that SMMU_EVENTQ_BASE is written completely
+	 * when SMMU_CR0.EVENTQEN == 0.
+	 */
+	__iomb();
+
 	enables |= CR0_EVTQEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
 				      ARM_SMMU_CR0ACK);
@@ -3367,6 +3377,11 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		writel_relaxed(smmu->priq.q.llq.cons,
 			       smmu->page1 + ARM_SMMU_PRIQ_CONS);
 
+		/* Ensure that SMMU_PRIQ_BASE is written completely
+		 * when SMMU_CR0.PRIQEN == 0.
+		 */
+		__iomb();
+
 		enables |= CR0_PRIQEN;
 		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
 					      ARM_SMMU_CR0ACK);
-- 
2.34.1


