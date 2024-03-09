Return-Path: <linux-kernel+bounces-97892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4D0877138
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907D21C20979
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F47C3BBD8;
	Sat,  9 Mar 2024 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="NLCu2XhC"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6A364D8
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709989139; cv=none; b=Dsb/gDpcofZ6BD0npnzdgaT6+0UAdOAE97D3GvXUKrHiDwsoelSCxL5SySstxrVdvlycF1dnT5WuB55PZR0QVyUKw1iBHLEuKFWTYGzFFgeui+IqHg7y6DgGuUvxLmnPMSycLO7E2LyhJ1WhMzgP9L3n//hR9zAzQLOGb6cm+A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709989139; c=relaxed/simple;
	bh=fs7ZXvdLScRUzQwHtbe12XdweYH/PX00r1QyyV/7+7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h0AUsjRk51sHLP9wkgCTxHnt5mtGCZ8qGnwmNc1PRn/fACHrXcuDnAtE6ByevzC9G5/pMV0weBP+fWT2MsCq+UvwvNhyzdqTY6NUode1EYi2dlkO1XLZgdLTSTrMm5EynEQ1VBlPCtlgOcmWwdMKvl6TflIX5xFt2FI0GJTNwJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=NLCu2XhC; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-220ef791617so987742fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 04:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709989136; x=1710593936;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vdtNH2IVPVwkbgoygg/OHeXCXkaABB9e/JVCPNNHxM=;
        b=mIXOK2J/eK5jUz4MGTzZHIU0isGJfxTa7Lw3omiXFsS7IpG6E6PzSyr/S6nNIOf7hQ
         dy1lw9xpR8oX0vyFT0PSLglzdWKenl3rPL5ycSb9XOU3DtFD/feDg4sEpmRESQgibbRt
         RbZlx9NONOOB9UHllYAsHA5iIklfHxFlpoXBzGBt7FV9Ufef9CXuEieTY4ClUvz6SC0k
         HykwxQ8UTX+NrclwQrPY54tc/IDRltcJa9yOxFO3Fq1eE0A2IqxhU9JQr7ilTqomzGJW
         QXtSKWvf5R1msn1sq4aq3GL6q6PNpybfwpS52Q2EH+v7RKZxRPYA1+idBf7fENlpKmYg
         SicQ==
X-Gm-Message-State: AOJu0YxgM5F6wz6ikgHljJ6eCRSMGgyVkZKOknAdYm11WsjImioqxJlm
	0Jb5wzHR3BZdmk9GvNoc/cn4GNg3mulM5pTpQIc3EvseJi0bqSS9
X-Google-Smtp-Source: AGHT+IGRgebFec+Umv9knCz1mE2QPIXgrTSTDaZAM9fV+jXvUE/8zbIDeHbG8EeD4JxDOL/vd+lXfg==
X-Received: by 2002:a05:6870:a11b:b0:21f:f020:ef1d with SMTP id m27-20020a056870a11b00b0021ff020ef1dmr2034545oae.49.1709989136476;
        Sat, 09 Mar 2024 04:58:56 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id k10-20020a628e0a000000b006e5a915a9e7sm1310354pfe.10.2024.03.09.04.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 04:58:55 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709989133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5vdtNH2IVPVwkbgoygg/OHeXCXkaABB9e/JVCPNNHxM=;
	b=NLCu2XhCnvKo5xl7xiFfiN66gF7cHYs9TZUf1sDkLJJFOY92o1M9H3tSv65wwbJycj9yJN
	Ofa3TRq7w5SLDHtgzbp09BzgFAR9pWU42z+YgPUHc2p2jlp4cGWBBEaXYuMJeUbR1yo5eS
	IfQ0O+yL1z1OazmG82lP4JGxluBPssdnaFgRRwSD6e7k5NVnkaNNwpqW8ytUS4KtpAt5SP
	S4d6gPyVr7sBqsRcvJDAlDVqqIrjEKLX6cR7DUGurTGqI8vNHwZTzyMlIzRXlwh/q8A7fT
	CdxAYxe7Ungr0xQfiYfuaZhOKDL/VLzjxgG4RdCcJHksKFoSOelwpAX04Q7Fzw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 09 Mar 2024 09:58:46 -0300
Subject: [PATCH] bus: fsl-mc: add missing const specifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240309-device_cleanup-gregkh-v1-1-8ca586ef17ba@marliere.net>
X-B4-Tracking: v=1; b=H4sIAAVd7GUC/x2M0QqEIBQFfyXuc8LV7cX9lYgwPauXwkJpWYj+f
 aXHgZm5qKIIKr27iwq+UmXPDXTfkU8uRygJjcmwGfjFVoUmecx+g8vnoWJBXJNymoFlMVZbptY
 eBR/5Pd9xuu8/V6F8wGcAAAA=
To: Stuart Yoder <stuyoder@gmail.com>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=fs7ZXvdLScRUzQwHtbe12XdweYH/PX00r1QyyV/7+7M=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl7F0GzYos150+8By9YaFlXLYw8Qulg8BrZVu3T
 LzlAr9PBLuJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZexdBgAKCRDJC4p8Y4ZY
 ptTjEAC2kor7demePFLMvYOFKw2rYq5XuCGtgFnPJ2mNk2OzBwsedvC28P0B8OvmK9fJsqKOUcV
 1sb0KrtazGMtxe6ZFDP1q6IOU5D7uRCFLYoS7UNSkmr8VztRf8hs5q3SmfVk0TQ6gI4mE/hj7OB
 sHFinOdtntw8no+YmToUAKTVwO8vZD2GMV9WX4EEIyWI655XCV9p6zTXjwblYLJGGs5I6Y+LJD1
 vtx3UBJnRAFPSAKlC/mYY+JYZKxBS2AGTVXb+YEhEy0lisP72na57L+cWRU6/CLQ84mx55nlOKf
 s5hc8+iveHzdZge8BvusbhEXNWHTOaOsIVqxbU+LeaxY4vaGB50m/goWAvA5CcmfO3e97+gA3IM
 8Cu5XsDRY5BD14AY96ODbn0DngF8GMNTOgUFXtCn/VG7ZVOFERvfUgea3u2941d4k9uog2KaOY+
 2QAHUFDvWx6H++aQWq6rVhoDMJ0QBKE2zGxD86XSb8SnMAg1FXdaSX46Q/gA0vud969/o9lsmVb
 5zZ6CSZ1DOxs8I9n44KYgkS7LFlzom/51GqN4/FVGNy5qdfq2Fs7cbzaO41wBMEIl1EuGRGSedx
 rb+b+9Z41jqkU6uGjtu9PdP2E4txQurdIJ/FTM4jzZ3h7zy/3kG2T0ArcClVeKGMpAv3EvVV2kd
 MD6AbrLL4gikygA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

The kernel test robot found some static analysis warnings related to a
prior patch that constified all the struct device_type uses within the bus.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403091124.VOzGG1lj-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202403090918.89zrHUF2-lkp@intel.com/
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index f75ca3f0d75a..08e130122641 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -400,10 +400,10 @@ const struct device_type fsl_mc_bus_dpdbg_type = {
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpdbg_type);
 
-static struct device_type *fsl_mc_get_device_type(const char *type)
+static const struct device_type *fsl_mc_get_device_type(const char *type)
 {
 	static const struct {
-		struct device_type *dev_type;
+		const struct device_type *dev_type;
 		const char *type;
 	} dev_types[] = {
 		{ &fsl_mc_bus_dprc_type, "dprc" },

---
base-commit: 77294dd75aa919b6af3a44e9d68c441ea5d7de59
change-id: 20240309-device_cleanup-gregkh-a10eebb29190

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


