Return-Path: <linux-kernel+bounces-33020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697AE83634D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6161C22DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7323D3A1BD;
	Mon, 22 Jan 2024 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b="TyDH6/JI"
Received: from egress-ip12a.ess.de.barracuda.com (egress-ip12a.ess.de.barracuda.com [18.184.203.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4D038DCD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.184.203.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926892; cv=none; b=lMNPVGrLcbckmb43UUs8eLFdVT0sj4+au3dYyqppdlcBl/ahPWqRsxJ/VtG47x6cg1YdOp8lNCijge8NELecTQs13GMBRQduTxqycDY2yC0tLDrBtx+WiKAOetEoCFBSD7tw0xYyvpvVbBYz3t7LX89qq1Cyb15VQSRBGS23Rlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926892; c=relaxed/simple;
	bh=5AVmJcWA7QugF9qRY66Qzo4tg7poEKJiuiB++h12ZiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OJGqA+DcrRH3+MO+WB9YqsX6nEEzJxR/kD5fW6wNVR1XhiOzmSqYZdfLqAnfR7ynsuMSlJ48SekapedvsVWIw6AQwZRPtTsrg1X4e84LxBqmwziqprrjcKgByoYLlRG8Mm6Y7VCT5hX+fvDEcecxU7wn5ZKIZ+ZmQong8eLt2bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com; spf=pass smtp.mailfrom=mistralsolutions.com; dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b=TyDH6/JI; arc=none smtp.client-ip=18.184.203.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mistralsolutions.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198]) by mx-outbound8-173.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 22 Jan 2024 12:34:47 +0000
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1d737e5a6ccso20946555ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 04:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1705926886; x=1706531686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILkLPAjbZJrNYbml6xYiTBTFIOrycbmXUD+as2HwxZg=;
        b=TyDH6/JIVOHRxJBVc4jeE1seEfc+arkgjyuiJMi1OUCfUjBMUNDb1UIbXuKd9DfCQ0
         2X5TeBcg1Tom/0/wMdfQ1iRiv0uzVKA9TIUIsybhQisOB4hY7Ihl3vNGdU8qDbHZqSTg
         PHV43/e12b2HzYLpCWRM3D7gVGccWoKVLk060=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705926886; x=1706531686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILkLPAjbZJrNYbml6xYiTBTFIOrycbmXUD+as2HwxZg=;
        b=dVYix7Ud7wO2nkMtBa7aQmiFnJPxfjDz18z9Aj7PtsbgOJK+56MO22K9dZikgutTLA
         UbyGonCcLXOXUe2R1XF6u065Y4WQPfxVsx1N32xi9pGB7jnW7fNqXwDMavmgn37BjZEQ
         CpnD87nm7Il8lX+1jG2wblY6CscZkSW/fhsWHd+r+TJdE6cwxm5y1elHBeTmmUreIWh/
         l6/rBK+bFkOPHadelYqeR+usuUmOuMLIpwkXDC8978AL095ke4tmBtXuONf7ooKQCF33
         Z6f3jYuynh9QRXklNXnUoQhDkXrhKWWXl6m8pXfPrqbLsaNRWOXzjQATF0URghI+QaVo
         jV6w==
X-Gm-Message-State: AOJu0Yzrczpqmiq9VcFHFQIW+shDfSy8VtaQEMqm0Nfzm5/BFL4C7iu0
	mOejl7eptSnl6oFE54/vZzpqk/vDGvvEmE4ZDY5i/bKmYPZSCckHFh6l3W/FemK7WhAAuz/FGhJ
	ELRvecMBrqPIIPETcTGSe9uSPV+zOWbITDXOOv4C7E/8bP261+9QHO5U66m8bn82l8XkHCp8k1o
	PwdFIEFpUxsfuuqeGiE+Ux
X-Received: by 2002:a17:902:7404:b0:1d4:3eb1:1e3 with SMTP id g4-20020a170902740400b001d43eb101e3mr4398817pll.13.1705926886825;
        Mon, 22 Jan 2024 04:34:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5GKBnKcgwQofDyubSKeVwC2/jw4dmQh+9byCos8My//ZEiU2IuOFF3+wzrmAw+y2PBtnJrg==
X-Received: by 2002:a17:902:7404:b0:1d4:3eb1:1e3 with SMTP id g4-20020a170902740400b001d43eb101e3mr4398809pll.13.1705926886543;
        Mon, 22 Jan 2024 04:34:46 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902684f00b001d721386cc2sm5372148pln.84.2024.01.22.04.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 04:34:46 -0800 (PST)
From: Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH 1/2] arm: configs: omap5: Enable support for QSPI interface
Date: Mon, 22 Jan 2024 18:04:35 +0530
Message-Id: <20240122123436.11269-2-sinthu.raja@ti.com>
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
X-BESS-ID: 1705926887-302221-12673-6666-1
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 209.85.214.198
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyM7YAMjKAYmYGZiZJKWnGKS
	YmhskphinJyalmhomGxkYWSakWiSmGSrWxAA8xE/5AAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253679 [from 
	cloudscan8-87.eu-central-1a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Sinthu Raja <sinthu.raja@ti.com>

Enable config SPI_TI_QSPI to add support for QSPI master controller
driver for flash devices on omap5 platforms.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ecb3e286107a..07d52c079eb0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1304,3 +1304,4 @@ CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_PRINTK_TIME=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
+CONFIG_SPI_TI_QSPI=y
-- 
2.36.1


