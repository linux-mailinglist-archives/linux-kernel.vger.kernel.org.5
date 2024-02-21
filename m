Return-Path: <linux-kernel+bounces-74872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2153685DED1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C75B2A83B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0947CF27;
	Wed, 21 Feb 2024 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7tDGBwd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9547BB18
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524839; cv=none; b=doE7QB7J8o+oaWdHydT2DGKwshga6k7eALmSptdsoGpWIvFC3JlZO8MxKYIz8DDW7W1ltBtbmb0tz55mMd9Gyklw/KWYezYRAq2M3vevWAmKdNW7Bp8dtIfrI8nTkcmCk2GRsb7RJIqrZ1daIivoxhMBxT50C1JXcuLAlvaxyl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524839; c=relaxed/simple;
	bh=/D4edU2dlMgF7cFcJy5ah1s2Lb6gvj+ZpJAcgtiUZ/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y7/lam6WAtsxpcr84jCa5jN4b7EUOOQC2xTbw5j1mjiAwCudTJCTNT+HWEAXwASyKeGHL0+5ZydyEucAnclMYGsdzrRYNK3/V55N78jMpSU2kP+ws4PuNj/kv9bZ/uwmTcGeh1WqoxF70EEsC1Lo2tG67ZIeNhf1zYU+sa1BNKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z7tDGBwd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708524836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X/GA9uj2BxRMWNhwLbIQ/l7TXK6bjdPEXsLkC/BAEhs=;
	b=Z7tDGBwd+0P1Hv0ZRNme8QsJLoauu+Z8qscjXhNWNifZ9q8Vg/G2zfhnyFubLeIVRjuVsi
	ued6a0zoH3YxQ/MR1y56sxisLy1M9qDIMFz+gY5s888SAu7Ub23em8NDqE8pGoImmYoybC
	PSwvHHQ8Wshj5a+detNWF7z89rX8U9w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-sTpd45gkP5-GOnExvvHczg-1; Wed, 21 Feb 2024 09:13:55 -0500
X-MC-Unique: sTpd45gkP5-GOnExvvHczg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d35592d4aso1422845f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:13:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708524833; x=1709129633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/GA9uj2BxRMWNhwLbIQ/l7TXK6bjdPEXsLkC/BAEhs=;
        b=EpvHH4etnaACQIYbHXAlLfEE3XdXAafUz0v/0ZenYfWLIhBcDzGe1zCMSXMKN6M/HD
         GGGcJSvk7ErnfE2e69Ecrgm9NYWy21ftxXujijKQTy6Ou5dpLBy6qIdHxbkYs8020nlj
         s5k2oehfG5cBx3r6yej9DT61utfrOS6YtE+N4FXovOhMSJ5qviD3F7Q/fT/9XEgt/LOm
         Zg12XB1RsUOpG6p3F5eeXtFGQp18Cj41qPbdZo485H6+4lp/1ZhX7RppnsnqWuyzINyL
         X4ElN2fbxGQj9R3sSu+2nr44AzLS21wukKp3JiTWS62q40Fq/o3PJ2jUhAsp/MJzSuVV
         PDJQ==
X-Gm-Message-State: AOJu0YxSJzcgswE7F1fjZ1my+FP5ZDkg8n616P6eF+whK/r9eiDNmo9c
	i7s7N2P9QEnRxmivQIJabVE0dMQ1Yhe3u342kjMa5EbRfOe5C6xcbMHkCJbtHWYt1EX7ybNikZM
	mf6sNo/N/Jx2rld9Pv/dwtfVkOBexyQHHSG2DnZcnpjUhBHK/wAMcwGOXBKHxKNIOCRCbbBfDIw
	eiWuuM7Ishh/wGn/4LgbcVvgwQaEWDlHfoSPdKV0j8Sm77
X-Received: by 2002:a5d:4b8b:0:b0:33d:2120:1016 with SMTP id b11-20020a5d4b8b000000b0033d21201016mr12179262wrt.52.1708524832873;
        Wed, 21 Feb 2024 06:13:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4awMLHOnfcg+o6Wd6BP/y/EfVVau5ctktrK2DVh4AW13DCBEghcS3UBmxjHejdwgA/Y+9Ng==
X-Received: by 2002:a5d:4b8b:0:b0:33d:2120:1016 with SMTP id b11-20020a5d4b8b000000b0033d21201016mr12179226wrt.52.1708524832472;
        Wed, 21 Feb 2024 06:13:52 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j11-20020adff54b000000b0033b43a5f53csm17092735wrp.103.2024.02.21.06.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 06:13:52 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@redhat.com>,
	Maxime Ripard <mripard@redhat.com>,
	Erico Nunes <nunes.erico@gmail.com>,
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
Subject: [PATCH v2] arm64: defconfig: Enable zram, xfs and loading compressed FW support
Date: Wed, 21 Feb 2024 15:13:47 +0100
Message-ID: <20240221141350.3740488-1-javierm@redhat.com>
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
Reviewed-by: Brian Masney <bmasney@redhat.com>
---

Changes in v2:
- Add Brian Masney's Reviewed-by tag.
- Drop CONFIG_MODULE_COMPRESS_XZ, it's OK to build uncompressed kernel modules.

 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 056a6cc546a4..b062d6ca7f5e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -241,6 +241,7 @@ CONFIG_PCI_EPF_TEST=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER_USER_HELPER=y
+CONFIG_FW_LOADER_COMPRESS=y
 CONFIG_HISILICON_LPC=y
 CONFIG_TEGRA_ACONNECT=m
 CONFIG_MHI_BUS_PCI_GENERIC=m
@@ -275,6 +276,8 @@ CONFIG_MTD_NAND_FSL_IFC=y
 CONFIG_MTD_NAND_QCOM=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=m
+CONFIG_ZRAM=m
+CONFIG_ZRAM_WRITEBACK=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
 CONFIG_VIRTIO_BLK=y
@@ -1595,6 +1598,7 @@ CONFIG_HTE_TEGRA194_TEST=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_XFS_FS=m
 CONFIG_BTRFS_FS=m
 CONFIG_BTRFS_FS_POSIX_ACL=y
 CONFIG_FANOTIFY=y
-- 
2.43.0


