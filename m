Return-Path: <linux-kernel+bounces-32961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D1D83627E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F7ADB25172
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF953C6A4;
	Mon, 22 Jan 2024 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD9UqSaX"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB94E3A8DB;
	Mon, 22 Jan 2024 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923950; cv=none; b=O9XSmmxZ1k9+pCVzphxN7dFRC1E+SOSA1wv+ju/wwUBEyl3wOZ9dD6sC0CrTCT7cCr/FvaI094qOKgr1DMSBDlUoaFLkhLeWO5SCwKwyaw3EGE1tvPTaBCN/S28Ee8PgJkkAtluViCINV4cCEhgYzJnSTVom7YZXYHP8MuBpyrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923950; c=relaxed/simple;
	bh=SvFVbC+C++WLfOGYirGg6Fwp2Bp27iB5saetpjSVeo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUITgksOPghOeoXawdfnu79AlZ+0LwUsV6ZITtTHoPLQycxw/wL4NUAeaK2BQu5gnvb8j9LSB+bRNua4guplfYgXHjny9w1KIzDRSgxw6tGs5uSy0QSSEdvIN0Uq6ugi/l9D9ywCkVHrUQsuh2xd125c/C8C49IiAdUkXxwxjlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD9UqSaX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e9d288f45so36678925e9.2;
        Mon, 22 Jan 2024 03:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705923947; x=1706528747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2NxgDZZ+RtYFKDvLqUW2ETrJtJHmkdaPJy40LrEhoc=;
        b=LD9UqSaXbGBEn64nIR0dupauQdjjJk8HDxv0oRJPQzyqeBjAfFdCN9T3EODiAfxJ+j
         Fc5K2KG68OEhDBT/3WGamsJSWRQBYkF4cfyKHHH0ZkadWZWu8oHBJ+RzXYzC1m1W1Icr
         Lvz92syz9zFXUObcwJt3XWhB6Ga8BzI+Z4xlv7k0Lo9RJ0LP0eaceQenq58iGXnG2D49
         kVRzjh3NJTOSqdtTXzDbrttRN+5OA4ul2OjENBfb5gWB1W5maQgCihUqwGfgy/2q4jQL
         j+FcQC6HPsmIcT/EsLWJ0XX2ARjPPt6YkgT2xIWrUQcxOuerhWsq0yG7SB72tDm8hFQI
         vrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705923947; x=1706528747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2NxgDZZ+RtYFKDvLqUW2ETrJtJHmkdaPJy40LrEhoc=;
        b=bvfTQKbkTZ6OETLosuLMXvPbl/I0sNbAru96T25lZ+lJXXl+riycn1KMESRkVhbGww
         JVWTFtMAhfnG5p3y3VN9/xvk+NVbBu6veJ1/yVpDXIN8lVkvjai18MM6xSvHa7SfrHdI
         C+92Ek7rvfuhiKiq0yTR3u8t66utVtS1XsODRwYQ0UlGtPuccYqkPSJ1ps/6sJtQdGjG
         LNwWGIFOuY/Dl2+FNWVdB1OOxO2D3ZxDzrO/a/FxWTHqhFfu0I07d1aYokHRQzEb9/Ba
         ezEWritg4PGeVxG1Xka8XJw114LVgTZ2ArMF63FLJDQP3n46wEqLypiUfs9dI3e+3SQn
         E/8g==
X-Gm-Message-State: AOJu0YxlJssCcWiGP1mIf5R5zIdKK+o/f8B0fS0f/1l1RQkBXGqaq4ft
	v2biYr4JCRdo8XAro1a7W4PAZ6XxrTo7zziplAQXXLJY/OYoQVE=
X-Google-Smtp-Source: AGHT+IE3rLwGkX8ekqtF+WBWNT64BYf/HYPMyTRd0JcpBIG5vt4S4e+w96fZxl/DhTHQgouWfRnVHw==
X-Received: by 2002:a05:600c:502a:b0:40e:5d1b:b1a1 with SMTP id n42-20020a05600c502a00b0040e5d1bb1a1mr1607731wmr.67.1705923946681;
        Mon, 22 Jan 2024 03:45:46 -0800 (PST)
Received: from phoenix.rocket.std.lan (a95-93-126-153.cpe.netcabo.pt. [95.93.126.153])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b0040d7b340e07sm38990358wmq.45.2024.01.22.03.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 03:45:46 -0800 (PST)
From: Rui Salvaterra <rsalvaterra@gmail.com>
To: amadeuszx.slawinski@linux.intel.com,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH 2/2] ALSA: hda: Increase default bdl_pos_adj for Apollo Lake
Date: Mon, 22 Jan 2024 11:45:13 +0000
Message-ID: <20240122114512.55808-3-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122114512.55808-2-rsalvaterra@gmail.com>
References: <20240122114512.55808-2-rsalvaterra@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apollo Lake seems to also suffer from IRQ timing issues. After being up for ~4
minutes, a Pentium N4200 system ends up falling back to workqueue-based IRQ
handling:

[  208.019906] snd_hda_intel 0000:00:0e.0: IRQ timing workaround is activated
for card #0. Suggest a bigger bdl_pos_adj.

Unfortunately, the Baytrail and Braswell workaround value of 32 samples isn't
enough to fix the issue here. Default to 64 samples.

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 66f013ee160d..1b550c42db09 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1732,6 +1732,8 @@ static int default_bdl_pos_adj(struct azx *chip)
 		case PCI_DEVICE_ID_INTEL_HDA_BYT:
 		case PCI_DEVICE_ID_INTEL_HDA_BSW:
 			return 32;
+		case PCI_DEVICE_ID_INTEL_HDA_APL:
+			return 64;
 		}
 	}
 
-- 
2.43.0


