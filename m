Return-Path: <linux-kernel+bounces-141109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A488A1A86
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E441C232F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D6D1E5A8C;
	Thu, 11 Apr 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OTXCoFgE"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7ED1E5A69
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850052; cv=none; b=nfcqdV1YWyzMvtb2BNHcG7LLjlPwW8YeWBgxqWhgzgiane7o36DuExLJEosADHqRcmdBe++uHK/1lfPDHWUa/P5cWSqheKn1lhLrd8oDWrG1fbaJVwRDugu6Z49ddzSGbWMSjxDTaG9qL9UflGatfV71N4/PlaX55MbBKsy4ge4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850052; c=relaxed/simple;
	bh=m2iqChL6HETmz/ZtiknVulQsjum0zCKG2dh134JjhGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ji5p59RgZC+bBtGRrgfEnWT6G9T7x0pqqu26R6PVq6QiUY4VUxwiouUla0xMUZNQ4sDxmO4EyvuQxA2Ix8j0mB+5t9b3L+RnPKIobaOn9OMC5kpq4Jnt3K1KxW/noyXu1Fkt3Nmtj+frc5ybQm6Pc3dXuXN8nWym7vcSnPom8Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OTXCoFgE; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170614139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850050; x=1713454850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdvTd/Z6iWJcYI3wdpCfxtLeNNXPNiT3U4B2ltOyVR8=;
        b=OTXCoFgEZt4tLkA1kAN3CgBJ7u1+L8kayPgWSVpBld457m3S7rgUZPaYGViVNoeFFa
         Gd21iHwVbRbp7wfQcWcznt2VLDHSHzm2SebcrEXNiSFVO3EFX6x+gDfXia1HmAOVLQSn
         Q2I5UjYGaP4LZ/vpNp3EIpFR9rTVBwlbjrUes70sF78a8D6NI8M1P9Htz5fm2ESOUClQ
         Ot7SX/sPHt/BubHJLCOKF24zqpfeZiF9iHP11VqPCfE3H2xUslDRFH/LrMfuwGj6zk+F
         /Jng5aHKQCDzxAXaytogPt2nxW96ApdexDCHpJ3+P+Zs5jMNA2HlKbLO2zDOLDzjYAAM
         fT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850050; x=1713454850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdvTd/Z6iWJcYI3wdpCfxtLeNNXPNiT3U4B2ltOyVR8=;
        b=p1HTgU33qN9LC5O4ACV1Y1ezN2WPZebu//RJH6GklzLymmoHsTDYuHWHN+YiN18A/C
         XNqdgBA02qZPD89j22v/RSmhpMK7zBN56waP734DQz4wlRy+xwuJTFjSBdERGZ0Njt+P
         s3IOAaN9UzmQuajRBKgZz2JytHNgvW9ikdpcyLzFH6jotRug0l0szh3gAWv6F2690P7M
         ODNFH8tTxD+MUigllzqGNLuRIjMUxyEGhoCPOHhlcJ8hegVxuPSYlDKddSXYS46k2I1O
         lD1L1po5yloPSHzuiR4AFgXjtKzzNG8rwsemex6ONxFGEs3Zlfpjh02tQYYsA+gTA0yY
         FwLw==
X-Gm-Message-State: AOJu0YzVHJNXxPoUKpO1lg8zJSynbSsKUmvlGpApqVNCPjfFl3mUmIZh
	cthjCnM9ZNkJgPkwJOC46GbmRZrLfNwEp55ttl8ilARGrKro8qane4KPzRO3ogWvZGM/w2bJbKm
	C
X-Google-Smtp-Source: AGHT+IGz7J0shjkdOGLVLKWXVno+h7HpxzpClNN5Mu1JYtxbpeMIyKmerz0MmNbf4UJ4HNBpzFIC2w==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr234137ioh.0.1712850050225;
        Thu, 11 Apr 2024 08:40:50 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 331/437] x86/kvm: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:51 -0600
Message-ID: <20240411153126.16201-332-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 arch/x86/kvm/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
index 999227fc7c66..552db0812b02 100644
--- a/arch/x86/kvm/debugfs.c
+++ b/arch/x86/kvm/debugfs.c
@@ -184,7 +184,7 @@ static int kvm_mmu_rmaps_stat_release(struct inode *inode, struct file *file)
 static const struct file_operations mmu_rmaps_stat_fops = {
 	.owner		= THIS_MODULE,
 	.open		= kvm_mmu_rmaps_stat_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= kvm_mmu_rmaps_stat_release,
 };
-- 
2.43.0


