Return-Path: <linux-kernel+bounces-60845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4764850A1B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D1E1C20F27
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC6F5C903;
	Sun, 11 Feb 2024 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="KcploYk9"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4260C5C610
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707666280; cv=none; b=Oko+/wmAU0cESMxRaJzsitWT6CQiwLcAEXJI3UtUGrehr5tMPEHfgmCl8+f813x6kJQFrfSrE+cz4v7m1Z/ODwcfM5TOkCb7clvf/+VljHjRpCBIbL2qo/e1XkXOTAfnHK0WoHCk/a2AUVINmUIbO7JumQOoup1g/1G0+y12nQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707666280; c=relaxed/simple;
	bh=Zp1Q7HHvgyv0KT1mM4ftOo2mRyUQ2sFgTV9nu850Kig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mdk8ueu6nZs610AwQB3UF1ALRtaSnwehBfEC+5zubWmwKZkW4tcrqYeYW+IqlFh91bihuuVsDX7e1Jwlhq2yMoLmYI1/WSniWJu6C8QORcwPYaLImzDw2N7z547bktnpnYrgnK3diBKlPYBeeu0kZFr95U/kFEbRFxtw5uMvxO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=KcploYk9; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e2e6bcc115so63566a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 07:44:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707666278; x=1708271078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iSmA1cSynCqQIlNVQ5FPbNWJVzvoZ+aRPHqPGGv5d7I=;
        b=fu8FkO6R+KaWD2Wse7sxAHsUcqzwYCs4h8gy6kGH55tXULKg1hiV3+WEB57MJG8gVt
         C520wJTLJ/b4T/Kduu63PYQk/aYNW2sexRxkQCHL59PQXPPrE/Cj8hBTC8nITfFUkRao
         CNBJKLRNYS9q9VtKV978NWGEVB9omXHmqPQqjfT180joCMGORvdqO+RSpWcefIvt6Z3j
         XjX7PZzdEq4uABe5TLE9yxsTPTnL2cpPAAZOgi/Oq331lVNcBlnOlIOunvMH5dpd26ve
         F5R7WfyZdemhskunelsMlK9E5JXQaOoV5CJnTelt3UV25LPfzgfxxY+xW5Q4aU2+8ige
         u9dg==
X-Forwarded-Encrypted: i=1; AJvYcCVQE+i7/+pzp8wed9jmaqgKeB1Ymg+c+LVbzuRXjBh8GO30G/5I+Mdqf8L9wPRui8dg8lkk2diiCmGaH/wCMVhrfa2x/GNMNcmB0FNQ
X-Gm-Message-State: AOJu0YxJZNe8QcHOVHCLhnOIPx1NW7cUB3rWOFXylN51DfX2eXmnf7Tm
	U2ukmoMdWnGw+H4SzlWTOQlp3JBmDM5V6a5MPfVt2CoXv+x4vFDatKzsx2dS/dNJ3A==
X-Google-Smtp-Source: AGHT+IFNs2spGEyVcBjQ8A170hFY1vqr5VCSGucgDBWE+QDFujCRcS5xMIKSTbAZn2S/iP1XJmq4LQ==
X-Received: by 2002:a9d:5f1a:0:b0:6e2:bdcf:e31a with SMTP id f26-20020a9d5f1a000000b006e2bdcfe31amr4720136oti.17.1707666278219;
        Sun, 11 Feb 2024 07:44:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWoiMSbGJe8S1q2ovuzusX/bwgA76D8ullFd58iyry0AWkEGojBJQ0EJoWZFHJDcMiDN7rPTy9GkX105L8QzRE21VZRx5jH79bkNSvRNO4viHrNf3u1Q0i0dUHorNKkGz8URPu7q1Vghg==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id n25-20020aa78a59000000b006dd8a07696csm3907611pfa.106.2024.02.11.07.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 07:44:37 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707666276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSmA1cSynCqQIlNVQ5FPbNWJVzvoZ+aRPHqPGGv5d7I=;
	b=KcploYk9c9GJF1gy2PasRbT+RUU6tACZjm4S3eIKku6LuupjPmSFQHrXQI3KQeQMTqJHTI
	1XRZFqxNOdPHkAaFeWVW9ODPwug13zNMSev/0jYrmJKvu8i/at5hKtttR4xjqUYE6sKZwc
	V21H7BsReWjBY5pYlm0xFG/C0OrbupSo7olH63WBL3GVepMfBX/x++K3656cpCRLqHmoyX
	wRLvLCK+cb03czKClyaXtO+eFE7SB+ubv3ws0tvNNLc06+oHvn6X8umuLjSikTWt/1WC7g
	cDjrSLEy2pivGXHIDMaAfK87jG8U13b9IWMD/giWO4i1ymJLHfhEINHulhnsOA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 11 Feb 2024 12:45:08 -0300
Subject: [PATCH 2/2] ARM: ecard: make ecard_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240211-bus_cleanup-rmk-v1-2-65668e578d55@marliere.net>
References: <20240211-bus_cleanup-rmk-v1-0-65668e578d55@marliere.net>
In-Reply-To: <20240211-bus_cleanup-rmk-v1-0-65668e578d55@marliere.net>
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1570; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=Zp1Q7HHvgyv0KT1mM4ftOo2mRyUQ2sFgTV9nu850Kig=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlyOuD8ODd/0ZKmuvbvR2pW6rdXJpZB6FjW2D2r
 ocNh2NL10uJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcjrgwAKCRDJC4p8Y4ZY
 pr2MD/9NAY96OeQSHI6t2nQzztaYYKMIBrBwXSn08TW8UZsVlJnKQ5zegjL4D1I/RViTQ11NQ8y
 LnkxFtyae4w2KqgtvGrfCt1wJgMmagqY11wKtLQ6svch8FDgo7KpQJA0BMv8KToG2aRy/YOaX5V
 PsR2vpnKeXOxC24C48bgbXf4p+DthYx4fvzApG8Mv76dVgqZlBCjsQ4nnrgbWaEVE7cYE/SkCbF
 mQlhvJaf0hvWb89tggvEbxHScJlrGHzPEo6ykRjLou1QQONG0RHiTeLT9BJmAAHpVEr4rVLUClw
 +yr+hZZdz0ppoJqsW/S1rFT2f7tvAAfCY6F/jcakfYA8/Of2Z+UfIsfEy+PohxeVVt1owFSwHtp
 E+LEGAYjrDTaUbQeE0VQs165EcdlsbpvEsZpelo67ilK4B2S/nt75+7oN2u1GPYWRNqYYHIg2dr
 IDG5L3/RIybyqmNIAhmQ3isC2aDobQTaYqpsiGd9oeP9P6vgjNeMlsSD4eoDX3nX6u849NOWvOR
 tj74tTG4qKk913CebFAfR3WQccLSQVKFXeBw0x2EEi+uhgGmHxLxDbwDvg7YaGqlyEMrW3d+FT6
 GJeATLwfV/ETdnFd8abiOQpuoL4rQ2ZRISyTwCbRNO3+MBXEJW4PeWXUNz1Jj2KW11QxAswH/K9
 wPX+2G/5eZmlcSQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the ecard_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/arm/include/asm/ecard.h | 2 +-
 arch/arm/mach-rpc/ecard.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/ecard.h b/arch/arm/include/asm/ecard.h
index 4befe8d2ae19..7cbe001bf9cc 100644
--- a/arch/arm/include/asm/ecard.h
+++ b/arch/arm/include/asm/ecard.h
@@ -195,7 +195,7 @@ void __iomem *ecardm_iomap(struct expansion_card *ec, unsigned int res,
 			   unsigned long offset, unsigned long maxsize);
 #define ecardm_iounmap(__ec, __addr)	devm_iounmap(&(__ec)->dev, __addr)
 
-extern struct bus_type ecard_bus_type;
+extern const struct bus_type ecard_bus_type;
 
 #define ECARD_DEV(_d)	container_of((_d), struct expansion_card, dev)
 
diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index c30df1097c52..4b843cffcac2 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -1124,7 +1124,7 @@ static int ecard_match(struct device *_dev, struct device_driver *_drv)
 	return ret;
 }
 
-struct bus_type ecard_bus_type = {
+const struct bus_type ecard_bus_type = {
 	.name		= "ecard",
 	.dev_groups	= ecard_dev_groups,
 	.match		= ecard_match,

-- 
2.43.0


