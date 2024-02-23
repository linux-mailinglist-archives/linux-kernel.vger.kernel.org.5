Return-Path: <linux-kernel+bounces-78936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB88861B00
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B043B2274B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0849143C4B;
	Fri, 23 Feb 2024 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6YPe/w2"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D42142623
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711134; cv=none; b=RBQGvSMf0nKhRrngeedMOqRw+9U18KYmHrfbNPho4f+8GRDJkUbDDuiPRvk2Bd4ImOoComlwcrT3Xgs3DGG1k2i41ZsbmM0ixjHbjMZwsa6tmKaE7PI+E7k9rWKJTogNKHZe1tEnDHuU1ytS61e6/rywLhoV8N3K1fLl4GjqZgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711134; c=relaxed/simple;
	bh=SCO8ITUqhG2FbmejGhM3Vq7ikdTJoRqR5JOu7/L0C2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ud0RrbbzAihpsVi2ZQOx3HE8vN9w/gWbqiWr6nndAx8s9WvHSGWv8B0Pdslz9vrb2/iyW6PIVgwe5/w7OkSmw5rZ1FFY2Kp0j+W3YYmbuCnqMNCkr7NcB2sdI+wd4EiG97PfUbjOxat0Q0sBrf8XQHjt8pnXhUa7Vt3sUBQhO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6YPe/w2; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512e733a525so626920e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708711131; x=1709315931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjPLPth3YBrz5IbXnB2CEJbAtOdB4AEiM340Etx+BTA=;
        b=A6YPe/w22blmkotXB8OQLBFBgnYG9+48SaKuNvN0LKiZHbtLebIpWL+NbirFmY27tQ
         s89smwT+koESylTQmtNbfFagmscCQUdhMqLIAJJnXGSEtoIRQd+SgCkt2kOo6PEjq4Ur
         4Gqymtttg7WvbSWvEjPS0Nz/V2yi0X3S6hsk7VRNh0A/9snfpmQhaKspxUxsCvIXVXHg
         qC4POLrSyfyNPPdBbzRYiWRi/0+yz8ZEO1DoTclpx8KMlLQ2Y61ijITbC0HJ47UzraMg
         3ltWj4GyQckhIRPAB57VEyfaiJNCystDmvcbMNezh94+wrtqglpIxut/ISCVnjYFW5TR
         coJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708711131; x=1709315931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjPLPth3YBrz5IbXnB2CEJbAtOdB4AEiM340Etx+BTA=;
        b=BUDRhZLdX7ta78xFdrWXh4gnwPNyWk84czPvgfkeLFXNAW6LVxN1bnMElSJB6d7oux
         IHH4dbf02R+lFk8W+hKmV0XqjEfL72NhzWXk7Z10Fgg2qIurHFfZi4DZRGzNtri5fJPQ
         v+JrkPwHsXFhkLdM0g4M1qMRjk+5eMnIpd7G1sXrFJwsDtP2AOD5KXhWjJ8lo9jjELZ9
         ZVuwDqcgjPGcForsBJrAI3ffjNSf20LqaKWshRU9AWOeAguQddA8DYlLDhhF679qPKO/
         eA+wqmn25ppb0dyIVwD8R0Mhso/ynJrcU0HNh6V1X2xhxVaWX0awvvxqFd3gsPUKZWiY
         p1Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVSrJ+pwhA+wPccD2U7EeTRFcQ+DkB+xgAcPGzhq2sOHrzSNo6D3X7v3o+qAPwKI5O56zdYhXC92fZdddDznIf3SRui1obszpKr7uq2
X-Gm-Message-State: AOJu0YzkC/Tz0FO5dW1hZc3fTHJ62Wye30RXDxHWekvAZaWbPGSToS/G
	gxMZWCQNKX22lz+Vkz0KjxrWbz9odSiblgKQuA8ztpk7PS5Levbs
X-Google-Smtp-Source: AGHT+IFAMAHx4vBOlMRimWgFf1gJmSbVaj4+lXguuwpejpvGFTmKnPyY3fhTFtusJXKgtctWwEXivg==
X-Received: by 2002:a05:6512:20c9:b0:511:aa89:2cd8 with SMTP id u9-20020a05651220c900b00511aa892cd8mr135231lfr.18.1708711130673;
        Fri, 23 Feb 2024 09:58:50 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id w11-20020a056512098b00b00512bc1445b6sm1785479lft.234.2024.02.23.09.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:58:50 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dan.carpenter@linaro.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 2/2] staging: rtl8192e: Include blank line after variable declarations
Date: Fri, 23 Feb 2024 18:58:36 +0100
Message-Id: <20240223175836.541337-2-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240223175836.541337-1-bergh.jonathan@gmail.com>
References: <20240223175836.541337-1-bergh.jonathan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch does the following things:
 - adds a newline after variable declarations as per code style guidelines

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 4df20f4d6bf9..c7c8ffecb825 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -945,6 +945,7 @@ static int rtllib_rx_data_filter(struct rtllib_device *ieee, struct ieee80211_hd
 {
 	u8 type, stype;
 	u16 fc = le16_to_cpu(hdr->frame_control);
+
 	type = WLAN_FC_GET_TYPE(fc);
 	stype = WLAN_FC_GET_STYPE(fc);
 
-- 
2.40.1


