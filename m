Return-Path: <linux-kernel+bounces-74744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A5285D88E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64EA2883AC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CD169964;
	Wed, 21 Feb 2024 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RatGZhkB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D861E4B2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520377; cv=none; b=lh+RfwRu86GjndcsTzLMB5YjumO97F2fva5wDi7KBuVfZh2VsqyYMyl2D4zCiqxG6jFStu6wROsvEVwEj6QaU05tCEGlZtn7vLSgGqpfP+w1y7cisA6TC+eS7XrfZG/xnAUErvnZ1yOZrA85dr/cUAsP4ZnoPL1KdYl1pMPl8Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520377; c=relaxed/simple;
	bh=grketJfhMapQkec1fanriqgmz/x4ZO0T2+wbrS1Z3RY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rGGisdd6Mk7eOmjEfp2fdsiIpvspsrOKTgbXh5ugluMKEJnDkX7XI9VnI4iVpB0yd/DRUxJgNIATj6kT5h0wfdXOR0XpOW6+61JBjjiRBd74kACR2LYF7+Vr62njdcJRfLEr13jWybSHNQ3g5bvBtmbz2a1cXxqEwvmziLQCmUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RatGZhkB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708520374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gBLnLZ7gPPJnpOZETDZcAFCVCoE8QefiuZtuibWc+I0=;
	b=RatGZhkBFmYPPMDsnCzs7Ib+dKskd986Nev/0EKSI8pAvrt0BeawqRI/0Hdxf6VKS/KYgx
	1jCJWbGpAndRHGSNnv/mt2XeQM1WdY2L66CVKRed0tVGB0X09DBzFUvJoXBoDGNOA9QjD5
	MeVf2+8HYk6p0BDuHLI9XP0FfeP5g0I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-QVc2uZC_PxmKUZoYhls8Hg-1; Wed, 21 Feb 2024 07:59:33 -0500
X-MC-Unique: QVc2uZC_PxmKUZoYhls8Hg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d308b0c76so1791127f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 04:59:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708520371; x=1709125171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gBLnLZ7gPPJnpOZETDZcAFCVCoE8QefiuZtuibWc+I0=;
        b=dgK5BRwicm/mBVjxDEOFboKvhu9O+RRt8xhuMB/3zEEsvCIecmIZRcn9mHj5mv20lQ
         Q/K2sFTQhJ08ZhaGsPK7jyTbdtYbgpc6J61RjZiSwkjmnPG9IC78DaMug+LwRMibxc+3
         KsEAE5OLuuaeUZJaE1b9w0hfpSYcay3T3/aY9ZXMj20MD0S/IyPN/H9t93FbKbFOjKvt
         uytjQE036pFRbN9Jk+smr7vU7x9p/Y5ml37dz03Fh7tszJBOlGfn6FqKpXF11CDbTn4c
         R5O3vleF1kn/Sb1Lh2AF997wDnkg9YnHTVxvPE6wRrUyuLe6gdSz1642lvfjzUF4xSep
         q72g==
X-Gm-Message-State: AOJu0YwLt1qyQAjOgbL+ylAjDCBLRCEMfBSZZm2o9Xce5qfqKeeliugz
	x67Uq4r4+MTxKkuwq8YLHVMR4Qu52PrE10JCx5BUngqEx8caya+ddreCd16g8QICDJeDSShGMys
	wdBsxZJA/8tglksQaIh3646CMbTgcccZem7XNTDiB3JOoBCIMdJLBCPWfUD4M9azc8h/e+C9voX
	8kZ2kP/f0WXe8LWqni19r9MJNKZZNwhhAB5Loz6k6kJdnZ
X-Received: by 2002:a05:6000:1845:b0:33d:69c1:e7af with SMTP id c5-20020a056000184500b0033d69c1e7afmr5467530wri.9.1708520371730;
        Wed, 21 Feb 2024 04:59:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH2RiruKdXKGalF1ffzYhm/Vb/ZdNACa7fcotW/WNe7sF3+1fB9rGxXUoDV7l8GcjH3SuRsA==
X-Received: by 2002:a05:6000:1845:b0:33d:69c1:e7af with SMTP id c5-20020a056000184500b0033d69c1e7afmr5467500wri.9.1708520371316;
        Wed, 21 Feb 2024 04:59:31 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u11-20020a056000038b00b0033d7dd27d97sm1918348wrf.45.2024.02.21.04.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 04:59:31 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@redhat.com>,
	Erico Nunes <nunes.erico@gmail.com>,
	Enric Balletbo i Serra <eballetbo@redhat.com>,
	Brian Masney <bmasney@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: defconfig: Enable zram, xfs and loading compressed FW support
Date: Wed, 21 Feb 2024 13:59:17 +0100
Message-ID: <20240221125928.3711050-1-javierm@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These options are needed by some Linux distributions (e.g: Fedora), so
let's enable them to make it easier for developers using such distros.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 056a6cc546a4..12aebbba814e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -241,6 +241,8 @@ CONFIG_PCI_EPF_TEST=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER_USER_HELPER=y
+CONFIG_FW_LOADER_COMPRESS=y
+CONFIG_MODULE_COMPRESS_XZ=y
 CONFIG_HISILICON_LPC=y
 CONFIG_TEGRA_ACONNECT=m
 CONFIG_MHI_BUS_PCI_GENERIC=m
@@ -275,6 +277,8 @@ CONFIG_MTD_NAND_FSL_IFC=y
 CONFIG_MTD_NAND_QCOM=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=m
+CONFIG_ZRAM=m
+CONFIG_ZRAM_WRITEBACK=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
 CONFIG_VIRTIO_BLK=y
@@ -1595,6 +1599,7 @@ CONFIG_HTE_TEGRA194_TEST=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_XFS_FS=m
 CONFIG_BTRFS_FS=m
 CONFIG_BTRFS_FS_POSIX_ACL=y
 CONFIG_FANOTIFY=y
-- 
2.43.0


