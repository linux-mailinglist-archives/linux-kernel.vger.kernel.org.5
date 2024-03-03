Return-Path: <linux-kernel+bounces-89845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6213A86F66C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 18:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023C91F21296
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A00476419;
	Sun,  3 Mar 2024 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLFejsnv"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56872763F0
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709486975; cv=none; b=lRXeaUGyshKtIf12vM7jJZNwxADuxTuVikD+ghF/yIfzHJBLgIQxX3kvgEnhw8Vdeg2NeYan2rSy3XNnsqJDxkJsEQxO4YVzNA2P76ddjEdHvSXsSM7JKaRJ3F+9IEfhhnlPrMkEZNo5vz17rJeWirXCMRBDaUTKLj4mrV1Ksug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709486975; c=relaxed/simple;
	bh=28EhC5XSpteuYd/qzCd4RcejlAoQCodh6ULXimjO9C0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CthnpU0FzB68/XvhJyENP9I2ETqCFywHt1ugYWcIHlHKIdfhmeTJara2UX4y0mL0d1WnbCZrsT5amQSBWqL0uZ74462KKJ8tPewIrffiWguhRjo7EaHIdwVy1tp33/uJi+2/5d3PS4VrNV04nBevKyjbUCKbqrHPBBh6Eat9bVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLFejsnv; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d228a132acso47603181fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 09:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709486971; x=1710091771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hkvXYX+ONENv8/j+tz0gO2keTFuryyaJ4d+HnaqfB4Y=;
        b=eLFejsnvhJMhV2EFM6Yd0O3edreW7z2XaKVYFEgjQp+SBTyNI8QWJkqeJNPWgQYcJS
         ROlLLZ4YnbZf+sbkKVDqEmroH8THMqQr5ODCejK4xwiBKHc84GbjG8pFBdzb8tDtyl5f
         7rs58+jrejjBQ108CuuQVgJmy3hHHxJkeb0u9+xBSVG1TMP2jPvVqslJpX36x9f3vYXy
         xZxP9CA8dJQvlZrTmxVfTOohhyE6nkewEttA736CjbuUdRUBM5KQVH6Ml9AqiQaWyukf
         N72o00bVM9L6xs5xUVQ8lM1p/YJ6zrvXTnpp3Fk+X3GXdTliXdM4G0FgAqSeJuvGkAcK
         AOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709486971; x=1710091771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkvXYX+ONENv8/j+tz0gO2keTFuryyaJ4d+HnaqfB4Y=;
        b=tv5eI6uDQdt6GFGkhhjuGNS3Bpt6y6Syr0QbZXY417lZ+pjx3bob0vBmZApHQOUz8z
         H5g/VsPh7M+DijbMpJd+jU8EgUtLOmfU1g/n4L2YvUGA2rQkERI7e4a8id7cuTkAAZ25
         XhJlIzZ60Gt0btGiGnYqmIBNwVFDwnt87zMBpB2KSLBUfnnTd2OqgxsevnVMJ/yVX30A
         ZRlxNL3rVit/ovnguaf7ZUVzuZG+nJJEQD3XJ4E51uird4dSGI+xAQjZqLwhFK+6sbNy
         qY9hPl5ipybYjD7+L7pblEo5zMaSPxI2CN0kR5BkaLN0Hs063B/XAmZy9y8GpEeKvTpV
         HcsA==
X-Forwarded-Encrypted: i=1; AJvYcCWRSQZQKetdTjLLlPymEupJyPzlP8lNJvZwRCp5F62JcqdIEnHAvqa8En/K1OIGlz2so5Y20A/CuSPWu9vOoK7TuGExGKsiUyxt94cy
X-Gm-Message-State: AOJu0Yz+x9dp7hs0aV+MQF/QHFbwxtQP5nkDtNw/+VC80yJcTY7bRg44
	P6VgVRiHpG9hhsjc43+1EXJWHqI55H32fRv7Qp36MEp6xgEcy7/Vjik+TnxCeY1umw==
X-Google-Smtp-Source: AGHT+IHyJJ/DcrP89x+IuuSiPZW3F7228qHRaRw4qu8k4MUOA9GgO+lUlyrl6G4FeFxAdCNV4uvKaw==
X-Received: by 2002:a2e:9018:0:b0:2d2:dfd6:8335 with SMTP id h24-20020a2e9018000000b002d2dfd68335mr4556684ljg.22.1709486971170;
        Sun, 03 Mar 2024 09:29:31 -0800 (PST)
Received: from ubuntu-focal.zuku.co.ke ([197.237.50.252])
        by smtp.gmail.com with ESMTPSA id j1-20020a50ed01000000b005667629f6e1sm3695030eds.39.2024.03.03.09.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 09:29:30 -0800 (PST)
From: Dorine Tipo <dorine.a.tipo@gmail.com>
To: forest@alittletooquiet.net,
	gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dorine Tipo <dorine.a.tipo@gmail.com>
Subject: [PATCH] staging: vt6655: Match parenthesis alignment
Date: Sun,  3 Mar 2024 06:56:40 +0000
Message-Id: <20240303065640.11651-1-dorine.a.tipo@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Align parameters in static void calculate_ofdmr_parameter()

This patch aligns the parameters with the opening parenthesis for better
readability and adherence to coding style guidelines.

Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
---
 drivers/staging/vt6655/card.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 36183f2a64c1..77662056c52c 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -81,9 +81,9 @@ static void vt6655_mac_set_bb_type(void __iomem *iobase, u32 mask)
  * Return Value: none
  */
 static void calculate_ofdmr_parameter(unsigned char rate,
-				       u8 bb_type,
-				       unsigned char *tx_rate,
-				       unsigned char *rsv_time)
+				      u8 bb_type,
+				      unsigned char *tx_rate,
+				      unsigned char *rsv_time)
 {
 	switch (rate) {
 	case RATE_6M:
-- 
2.25.1


