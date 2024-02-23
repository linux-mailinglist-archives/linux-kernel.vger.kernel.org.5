Return-Path: <linux-kernel+bounces-78935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2CB861AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBCF4B222E2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D867142622;
	Fri, 23 Feb 2024 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ot8IDGo4"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4828612AAD7
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711131; cv=none; b=he4SbAzM3lvZOhsFB5G4ScwgXOcpd+bSnR53k16NifJh8C+0Z92jWkUHZXYtZpRGyO/uksOnAXVdCuu/CCJUhxEYwHOAU9rw5wyfQlpsK74mY1Vk6l026bJAhYBT9KTlL2idOEJacNJ63wYV3JqhdgIeD/Chv8n2ZDhjVYbX7rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711131; c=relaxed/simple;
	bh=jQ5YAfHUku1i6/sOKyKkIsBENJmPyDq5YVyXEAsxP+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tGDNT8FDbUWXglwSIwXrLpjUeC9Q5j5EnlhndcxxPn5VJf/3hxyMrnSfpABJce6RCs7Rvd9nMe4uN0JLVlZl/HtS0bDaD4AdO/HnKJiqJlU66cntM7/AwhZldUXfhdVIoAgNJ2ETeSYZEpowApXafroBYLafsKdC7WGghRCKt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ot8IDGo4; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512dfa097b1so1542719e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708711128; x=1709315928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+TAsLTmRjAHz9Gzf0STs3D3neMCDxnHea4H2kpY3oKM=;
        b=Ot8IDGo4Z6w4EqNQameH+lB3BcT3dqphWKeKX9a1kcEbsI+x8RM6NBk6P6T0+LTdW1
         vhA7g8hA/1F0M6nLZFCJYJW9AZdHBzoPuglfnY0KCYZeKwUntKl5og/hGiA7LqbR6SAd
         oYIX39RUTFRiQGk9iy0r08DP9RbDvboAEjtaR/2d596dKzcLEfVscUsLu4tAZpLuvrc+
         nDA5OFIc0PQ0+/zMa+B1O28k24F/frkV+doByzSG9jNJ65O4rz54H0PK8Xcr7lWvLbzQ
         B+YVqnVHiAToDS3SvxqXwCxU3tbc7rv1FBb4CWvlJzAUtfhzwQK4nX8aGK8UciXVSWGn
         BuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708711128; x=1709315928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TAsLTmRjAHz9Gzf0STs3D3neMCDxnHea4H2kpY3oKM=;
        b=i5nCE38+x6uzrG25M0gKsbxCp4ekEP4Niie3WoOjDp99mYMptx7lx+qz20X6W7xEda
         /6TzMUYUGeM5Xtn/LJcroHRUBh7xmXnmL8Uu1GOaszFwtyU5Y3le5whYxv2F1ht8Uo7P
         RExVQR+KtLY/XTpuiNQy0y/MY7VaW5vEm4btSWxXBpYkntsgR3NojptDgb6Bqbhm00E3
         F4uMu6tV+H3Ev7tyv1nKS3GAvvBav1/Yo86bvKtqtgZfmQzlzZxnfQB37/6XN0Ay0hAe
         +jBVkuxkwAr3P+lttVJI2s9TKdetNyBM4AknVigD80pa2jGHNmHRCgfyWGIFANweyk10
         oL1A==
X-Forwarded-Encrypted: i=1; AJvYcCVowy9f1vICCeicOt8ysjNt2R3UxjWn/D3AGoX+vdvToJT3p2+xy8GBzRO3GpSpHtb1LS7k+tSlFwWt+2OEIrTtgMa4bn+2ml6NZHxz
X-Gm-Message-State: AOJu0Yw9VELriUEZdkVJlQbb6figbAbeyrEPXDrr5Edxz4M1EQlq7hDq
	1BFhXZPvWKTbwtzualFHJBqKthENegUFVHimD/Hd5wlxybKuA1/o
X-Google-Smtp-Source: AGHT+IGE2u2rCzoBYmP27bzERrf5znSl6cMvsZoMo8Q8FStURBUD2Dfpwn7Etj+Kbwt29iViZot3Pw==
X-Received: by 2002:a05:6512:2314:b0:512:e394:bfb1 with SMTP id o20-20020a056512231400b00512e394bfb1mr366064lfu.43.1708711128142;
        Fri, 23 Feb 2024 09:58:48 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id w11-20020a056512098b00b00512bc1445b6sm1785479lft.234.2024.02.23.09.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:58:47 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dan.carpenter@linaro.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 1/2] staging: rtl8192e: Remove unneeded braces from single line if statement
Date: Fri, 23 Feb 2024 18:58:35 +0100
Message-Id: <20240223175836.541337-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch does the following things:
 - removes braces from single line conditional (if) statement in
   accordance with kernel coding style

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 6d0912f90198..49b882c363bf 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -480,9 +480,9 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 	}
 
 	ht_info->current_mpdu_density = pPeerHTCap->MPDUDensity;
-	if (ht_info->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K) {
+	if (ht_info->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K)
 		ht_info->current_ampdu_enable = false;
-	}
+
 	ht_info->cur_rx_reorder_enable = 1;
 
 	if (pPeerHTCap->MCS[0] == 0)
-- 
2.40.1


