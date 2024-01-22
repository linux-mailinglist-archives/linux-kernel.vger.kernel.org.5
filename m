Return-Path: <linux-kernel+bounces-32960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EE383627D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0389F1F27FFA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212DA3C07B;
	Mon, 22 Jan 2024 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO7rDqaQ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB07D3AC19;
	Mon, 22 Jan 2024 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923949; cv=none; b=jOpXd+nBiRkq8ffKGGyLNuM8YhzzT7jaQ5LTgi3zopz2CywOTLnNo+nxjyL+eIPOX+UWNeInvCwuHAbI/FBFIYtbz0q/UYHqeDHREzOYUzP497r+pRvSPQ/CuJnALP/nIWqZBPYFIkqmLVP1EHZE4AGElK5SzueUdZYNeOG7gBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923949; c=relaxed/simple;
	bh=lDqTFONZguWVoI4iQdzCWEOoVdj8OaBzNQdR/j8lL1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dido8nphgTbu4XhQrqcqtUFzuu9AkG3gZDXNfdHZVfQk07s9y9wcXy/KMksgcyX7g21BM2ypA47tQoOFnXpfjgEY23CjxpUcX/GEa/nR061lW+Sn8ytjByl2eVjPaPdD0BWlKEN4bQFCm7A1g3l7HMzgRVwhlrwNNnpbip2fJ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO7rDqaQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e87d07c07so39258355e9.1;
        Mon, 22 Jan 2024 03:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705923946; x=1706528746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=og6eC9+qsmXGNdAAW90m6JmbZGEJBXXA+IqkIhag9Wc=;
        b=WO7rDqaQ6Ma9IyFjletyegq3c83eP+u60sHNQcEkyQ/96C+EnlSV18yS5ya9zTr9Gr
         Q/+36H7ju4Rt8Yn0kRWWoi7McX01Bk3xRO5fhuKsu2fJhccYWaeUWIyOpDZ0mAvR11Gu
         OscMvIfk1oe//DBi89Jabn724LaAxZA1jl7kHfWA5pzp4PDfKNXP96Y0CArZt3b1wCqH
         8DVTkGULqsMv+cChh59iD+XPjW5/gpKm6cZ7ykhAaGsipJLe9kQcHPnT557n7t/K1cnF
         DJ6FC+QB+xCNXTwVOTBzQR5nyy7zLg+xlcwM+WYPlTy9PDuWRG22bWKaf3lYCgNgY/un
         1SQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705923946; x=1706528746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=og6eC9+qsmXGNdAAW90m6JmbZGEJBXXA+IqkIhag9Wc=;
        b=CZyRE6DNEWjzxVQ/Hs1iW1VSG4ALBRz1/5SsBkuDDdUxz4V7HQtasNlcOQYqjXnvbE
         PwfIBYXRzeXqbZLWm6c5eTTP6g+CdZZjutAxaOIfQVx8QSqrnrxQfDTYAizzSHxV2DGt
         kKWI5wYPOFxPi1NiQp3cLae2uxqcmS1lMtkWhFYRYPgMwudFoPn3tUm4SX7JXViJUhbn
         uAVsp5GHzFsxz3dsP62keO/EiocatWTct9mruXb+lseU8NdSX/i1nF2V4OMlK5uxIJc/
         O0BqWtPOjiCr0Sxsl8xMbuvBcfwnxLl9BAo1SIX3ZqYlq3sAK3cfZesyeXluVu2NqzwA
         4meg==
X-Gm-Message-State: AOJu0YwMIZOA+wByjaFREI+7ybfNElgflWz/kpuguMkYHSvD01kJK9S5
	6c1gunS3HRoiSppd3OkSXWnaU03Ikwia5RijYdtgQuPTf3pDG4kPaduddyE=
X-Google-Smtp-Source: AGHT+IHE2c8y+Il/LywBJfAfQ06RJUwiZ/H1df0Qb8r5knfiKNeICJTHkeRPWasd/ylBvnOUpeuB4A==
X-Received: by 2002:a05:600c:6b04:b0:40e:5326:718f with SMTP id jn4-20020a05600c6b0400b0040e5326718fmr2181635wmb.184.1705923945810;
        Mon, 22 Jan 2024 03:45:45 -0800 (PST)
Received: from phoenix.rocket.std.lan (a95-93-126-153.cpe.netcabo.pt. [95.93.126.153])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b0040d7b340e07sm38990358wmq.45.2024.01.22.03.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 03:45:45 -0800 (PST)
From: Rui Salvaterra <rsalvaterra@gmail.com>
To: amadeuszx.slawinski@linux.intel.com,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH 1/2] ALSA: hda: Replace numeric device IDs with constant values
Date: Mon, 22 Jan 2024 11:45:12 +0000
Message-ID: <20240122114512.55808-2-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have self-explanatory constants for Intel HDA devices, let's use them instead
of magic numbers and code comments.

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---
 sound/pci/hda/hda_intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 2276adc84478..66f013ee160d 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1729,8 +1729,8 @@ static int default_bdl_pos_adj(struct azx *chip)
 	/* some exceptions: Atoms seem problematic with value 1 */
 	if (chip->pci->vendor == PCI_VENDOR_ID_INTEL) {
 		switch (chip->pci->device) {
-		case 0x0f04: /* Baytrail */
-		case 0x2284: /* Braswell */
+		case PCI_DEVICE_ID_INTEL_HDA_BYT:
+		case PCI_DEVICE_ID_INTEL_HDA_BSW:
 			return 32;
 		}
 	}
-- 
2.43.0


