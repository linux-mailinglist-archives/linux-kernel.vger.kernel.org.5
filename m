Return-Path: <linux-kernel+bounces-33022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A01836350
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767A61C21868
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E1F3CF47;
	Mon, 22 Jan 2024 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b="HD+7xI35"
Received: from egress-ip12a.ess.de.barracuda.com (egress-ip12a.ess.de.barracuda.com [18.184.203.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347238392
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.184.203.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926896; cv=none; b=CE8xlFD16+00ln6SB89o7sNyKzdHHDZbDteqgaLuEhh7lY4rxRCJgKoCgzKXY5rtV9fD0nCcPqz56Gg8e10/MLdG9q0ALMwGz8yO6+5k9aup5hMJygrehRZcpwnBuDTJ2o92193YL64YXTWB0maYgaISyb7l+IQpU98PA/iHcxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926896; c=relaxed/simple;
	bh=DQMdq5kXfeU9rmi3XcU3mcsUUsgpZDqBl6MHRQPrBCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CxKKgBBvFG1nSUrD4UZsECytYGFT3cwXL4ZKbmHlCVJVskukcfTmYMAuhAgiuHtpeQICqgx+2zPu44EyfnVxOr4SFpjgK5UbM718N62nbr7ZaT5QLhRFXeqNobcGYvWWoa2MBPcSUxGCYwN+0/6subpyHWPc6BpYGZ3ov+FUUW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com; spf=pass smtp.mailfrom=mistralsolutions.com; dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b=HD+7xI35; arc=none smtp.client-ip=18.184.203.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mistralsolutions.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200]) by mx-outbound8-173.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 22 Jan 2024 12:34:52 +0000
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5cfd94f9433so91812a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 04:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1705926890; x=1706531690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MwBAcrKdbC6/FKS38nrflJIvsjmnyFlJx07vNmPMm4=;
        b=HD+7xI35WkBfQ4IGglOIXqOJ0OAL4PW1gGAjCRT92lvNcFUo1rw8jtZ5Tmn2HwXDy0
         lXLV0Mp8vz+d+/hN5gxx7L2Y+VQmDq4hTyu68z0qo14epuGMdMHZLK3wdaW1DH5n6C/W
         vE+nqXXB/yGrwodZ7pTlIc2PoR0FzcBc9S0oE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705926890; x=1706531690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MwBAcrKdbC6/FKS38nrflJIvsjmnyFlJx07vNmPMm4=;
        b=I4FhEK9maDHAMYQ/LJhWFsJCBQVlWPgqJUE/Tqe6O13ZC4j9Qnmpo8MPvuWyNd5Z2D
         x4ola5GkbhSqBU1Yqjedy6nweRG5GSHmJPT6/ppfP5et3tM+C+YOgQ1NbKtz2f+4W+9Y
         nhk+FI0/Xc5N/3+hJrjLT6/MLTysu4LqcXkcfdhZ/4HpVRbR6uz6GUc+Uq/eO2sbDHF8
         fYRAoxegJ5egmkHKh2hrKFME7gUbi1RlBHfyCM7KDL6ZWL0TO6DP+pCkH8UWnuNKeTL/
         DZ4eZJGXKghBZWYXO4DHMlrkawk8CA3vj3EZePSY0HRrqQdetgQeC/U9ETU74sH2dn4D
         TsbA==
X-Gm-Message-State: AOJu0YzCKekMRKx7iC/Eo1moxogXOCBNk6Oer7YI2objdoS4zg46FuUh
	LjLUavo4X0zhTQmq7GHrnPoLeYp58OjSc+0MJyYXgw9grPpNTcQqa1nbMrFq5qsCOypo4Y+sryn
	DfXOXpmgFxdEO5GraTs9KSJz+1cWitk2wx3aDJnKcCDmSyduaJlhZ9m7hBDl2Cd4OnbZ2pU1OT3
	10G6gsF8Iss+no0aPXVz9uQOl8u+8n
X-Received: by 2002:a17:903:22c4:b0:1d7:601f:a093 with SMTP id y4-20020a17090322c400b001d7601fa093mr393878plg.96.1705926889814;
        Mon, 22 Jan 2024 04:34:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEHy0PlP28nl2vOLylSR6SvUWTHUX9rdWPrekvnmVR+eT+Rlsn5GKb2Mr5IgvGFPwKuHuM6A==
X-Received: by 2002:a17:903:22c4:b0:1d7:601f:a093 with SMTP id y4-20020a17090322c400b001d7601fa093mr393868plg.96.1705926889516;
        Mon, 22 Jan 2024 04:34:49 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902684f00b001d721386cc2sm5372148pln.84.2024.01.22.04.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 04:34:49 -0800 (PST)
From: Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH 2/2] arm: configs: omap5: Enable support for DCAN devices
Date: Mon, 22 Jan 2024 18:04:36 +0530
Message-Id: <20240122123436.11269-3-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20240122123436.11269-1-sinthu.raja@ti.com>
References: <20240122123436.11269-1-sinthu.raja@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1705926891-302221-12669-6647-1
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 209.85.215.200
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyMzcHMjKAYkaJaamGFokmpu
	YGpokWRklGqcZp5qYWiWnGFoZJBmYWSrWxAKPwg9BAAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253679 [from 
	cloudscan12-252.eu-central-1a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

From: Sinthu Raja <sinthu.raja@ti.com>

Enable configs CAN_C_CAN and CAN_C_CAN_PLATFORM as module to add support
for C_CAN/D_CAN devices connected to the platform bus.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 07d52c079eb0..87b2c6136e72 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1305,3 +1305,5 @@ CONFIG_PRINTK_TIME=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_SPI_TI_QSPI=y
+CONFIG_CAN_C_CAN=m
+CONFIG_CAN_C_CAN_PLATFORM=m
-- 
2.36.1


