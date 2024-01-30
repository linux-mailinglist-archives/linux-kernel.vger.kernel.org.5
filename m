Return-Path: <linux-kernel+bounces-44341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74018842079
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4672823AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550AB6A348;
	Tue, 30 Jan 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="XFxZfmIC"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D266A32C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608829; cv=none; b=kr5f4lsmKmXNO/jPnLZTf1BY6BlKlku0GuMBw6XmoHgLeTppJEAQFgqRVFjh4izFvpAyiz8WwkHeI0mHthd3RLOcrw1l94x3oMZQZRXe9SU8qFJSM0tLjZWM0bRZH/L2dmBH+rKu5TtLAY3XGfizO4IyNN79yPzP7HshQQZqSj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608829; c=relaxed/simple;
	bh=UXxOFnzyPjSmWhL7VN01cLQZkxTaV1mX68f4OmqP1C8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MCR/AJ8EvHMnhMc+xqA6KS4T34qSLXpoSDUdu2mAsM1epGBnLmSzYURbq5vgTzLmupBZ+4+Wmrds+LJVhS/IlEPNkLsNowkIVW30ZMbX4dZHWhCpFgBHDFjkIUm8uezeRJPK4kG6+5S5gIhV346b+UigtjgieAiyqUEt3PyUEWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=XFxZfmIC; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ddcfda697cso2825362b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1706608826; x=1707213626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b8wT6bcymUslDtltBZzAISdjS3jJfOOrz/LevDJCQnA=;
        b=XFxZfmICV3268PQyy8LsPPvJWfUwpbnkOgIuLrCTHiIIwHU4+G5pj/9KBrVGiA5DZI
         gr3rHTmTnECx62dynyV94UXRv3x1wDvmOlfPUYN7aN3NxfKHRB7XPL2kTk8PUJUKwGBQ
         kfu1Mb1rTwfZZLiB6IFgnybZyYoY8Fmd5lLW93r6C2ElBL8CH/q4jEgI8gcAgJMRbdvF
         p9o11P5r1oSSjGGYVP5+Z4pOqIEQnMpoEDCSBw7tfLWYWLq52vhuSwB72ZwFCexnUki4
         QUSHGgyiy4r/nWhL2YwWyOIUSbLJ9xv8NlQWP8ocphquFTM4Oj3tNY/tQXVD33w5nMg5
         V61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706608826; x=1707213626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8wT6bcymUslDtltBZzAISdjS3jJfOOrz/LevDJCQnA=;
        b=XHFMfHzsz+J1btJKM4OsxeqfakprrrAiJ3tR+gW1R0XPPAMbDqCrUGD0hsITxVx2x2
         kCosrMxW+HZ5TtYgE0RhwhdRb1iDv11YX3S01v2jHGypM51AQcyWs00KsZ0OEYPOvIS/
         WhqTHdm6WE9JQtZz39W2XUc6pkIVl/PfFd//ikdBQ8OIbO7TbBnkYFI8lZHmBLKUWCFy
         jrqDMe4paRNqH5fC+r82MtvPSHitMjk6gFX4UEHTlHrMgLZefZNY+BNH9O/UfaGmGQQT
         g7iUo5QwSwpGwHOjrn1JDM+5wOpGg7hfrMvOARiW+M7oWUOqBETTVW53wgQiOH+fJ22n
         SatQ==
X-Gm-Message-State: AOJu0YwGtel1DJy8/luc/GwfyW0MDDhPdC8ALQgvRJP0G4BBH7/g8lT4
	9qBIfxU47EvV3goel7mskmP1zrsNw2DW5kAVVjrW2hsmQslu/9RpB2PFHwi8vhQ=
X-Google-Smtp-Source: AGHT+IGDHT0UPx/DNjOeTCfqAlne/0fbxsadm9lL9NrmGBXb7/BJ1WXgntbW37yuK8GXzLGuWXYMBA==
X-Received: by 2002:a05:6a00:179c:b0:6dd:7fd4:9fa1 with SMTP id s28-20020a056a00179c00b006dd7fd49fa1mr6712516pfg.8.1706608826374;
        Tue, 30 Jan 2024 02:00:26 -0800 (PST)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id w22-20020aa78596000000b006dde44a2d16sm7345021pfn.199.2024.01.30.02.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:00:26 -0800 (PST)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	David Box <david.e.box@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-ide@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH 1/2] ata: ahci: Add force LPM policy quirk for ASUS B1400CEAE
Date: Tue, 30 Jan 2024 17:59:33 +0800
Message-ID: <20240130095933.14158-1-jhp@endlessos.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some systems, like ASUS B1400CEAE equipped with the SATA controller
[8086:a0d3] can use LPM policy to save power, especially for s2idle.

However, the same controller may be failed on other platforms. So,
commit (ata: ahci: Revert "ata: ahci: Add Tiger Lake UP{3,4} AHCI
controller") drops LPM policy for [8086:a0d3]. But, this blocks going
to deeper CPU Package C-state when s2idle with enabled Intel VMD.

This patch adds ahci_force_lpm_policy DMI quirk for ASUS B1400CEAE to
fix s2idle's power consumption issue when Intel VMD feature is enabled.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
 drivers/ata/ahci.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index d2460fa985b7..6bc5298a4adf 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1434,6 +1434,33 @@ static bool ahci_broken_devslp(struct pci_dev *pdev)
 	return pci_match_id(ids, pdev);
 }
 
+static bool ahci_force_lpm_policy(void)
+{
+	/*
+	 * Some systems, like ASUS B1400CEAE equipped with the SATA controller
+	 * [8086:a0d3] can use LPM policy to save power, especially for s2idle.
+	 * However, the same controller may be failed on other platforms. So,
+	 * commit (ata: ahci: Revert "ata: ahci: Add Tiger Lake UP{3,4} AHCI
+	 * controller") drops LPM policy for [8086:a0d3].
+	 *
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=218394
+	 */
+	static const struct dmi_system_id sysids[] = {
+		{
+			.ident = "ASUS B1400CEAE",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR,
+					  "ASUSTeK COMPUTER INC."),
+				DMI_MATCH(DMI_PRODUCT_NAME,
+					  "ASUS EXPERTBOOK B1400CEAE"),
+			},
+		},
+		{ }	/* terminate list */
+	};
+
+	return dmi_first_match(sysids);
+}
+
 #ifdef CONFIG_ATA_ACPI
 static void ahci_gtf_filter_workaround(struct ata_host *host)
 {
@@ -1760,6 +1787,11 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			ahci_pci_bar = AHCI_PCI_BAR_LOONGSON;
 	}
 
+	if (ahci_force_lpm_policy()) {
+		pi = ahci_port_info[board_ahci_low_power];
+		dev_info(&pdev->dev, "force controller follow LPM policy\n");
+	}
+
 	/* acquire resources */
 	rc = pcim_enable_device(pdev);
 	if (rc)
-- 
2.43.0


