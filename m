Return-Path: <linux-kernel+bounces-123618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B26890BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0AF2A4BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C9B13AD16;
	Thu, 28 Mar 2024 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pi17pcPA"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BE013A875
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658760; cv=none; b=gkH+D3GGRyy6HHND4ld7oE8Cy7KqMnOWZbqovG5he9YINeL0pZVLfBldzufWlayVkMiSOWScOlT5hQmXgYcCqhICMC1ED1gJRjvI6Xwp9dSpDIH4buoORH+rY1alBZwcX8lze4uSfwkGXczaY8xUout/t6+F2z1AVSDn9pACtgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658760; c=relaxed/simple;
	bh=gN916IcSHjAxGrt7q/maZ9c7wFkfPaWOLEW7VAt440s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TqWB9c4S0XNZMFXrKSdY5LwDogfz/XoDQabOeOlvihJGZE/Ny/QXWy3NYXNWmeEGd1O7U+GeiAf0LOeP50oje0nFFY0C2Ji5MDFfzqPqeWou5Bkx91RYG93jU/SRwKw5UOga+YSncUPtQ580GYm7dbJ2CzL1qNWhqwDjfIjL42c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pi17pcPA; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34175878e30so987268f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711658757; x=1712263557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ic1TsjIr/XGxwgAahTlTahad7ksIOvKlntEYIZsJCJ0=;
        b=pi17pcPAmMVVf78RpKd7BV1QAtSy89WTEVLmhuFncOIhKrflruETmyB1gDw2lOKuaL
         0Q09qyXgD78BPLT4Q8vWyXYrdEBfKXNt/y6xl7cIaNkDnPhpHeXSataMGZczIqyaU83M
         4nIx/22JS9t0cqTE9Lmfn1uk38khqiH3NZcF8766AYHuGMNi64zIAl846PFQSCdJ9cqT
         LIHCrfWCRY0keOdehuIEVXjChlPioIoTkw5YPoa1a/Hcvhdfiw+E3aYXdzHX4bn51FA7
         yiERvIcufgeMxazyj5LNiRoIj2c0JOUe/8+75sDdWKDNBx2mLaltTIuv3ozmHiE2ozH1
         0QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711658757; x=1712263557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ic1TsjIr/XGxwgAahTlTahad7ksIOvKlntEYIZsJCJ0=;
        b=e9zxMYvproFaeRATvMDaYw9KPJsH62jlRB7ZIV195Vp+qMeUe7Vp5pjgCKQFJeP7cI
         oIqbu8eQC3maI5Nware1dtQBjqTEMBhTbkiwNcEK2LHhc2bEF4PSQJZD+PqdRK81XkbX
         zr/2qXehZ/JxoC6tENuFSbI1HZ9dVBPh1spfEVbFK6iPX8ecP5rrxuKSg6yqTbg0s9Qh
         bAar2ZMOZFvOEdT9SAyjOwmUbFASDEcZ144SGBmVyH8atphTmnQ8v840cpzxe8uVclT3
         YPKu3h9acBcG+JSlqM/7lHSiFVL+jlN2MOBhJWneosKGi7eJYoyrTmu6uxPaTULgBDsT
         hcyw==
X-Forwarded-Encrypted: i=1; AJvYcCXKnlAKgF1IG+WU6+d9H4Ipjam06cAeUEyGh8fobDduvZr0iZ9GIKlMneuneZj1g15ioN3i38yBuk70B/6MVUrPjARH0xWpcKciirvI
X-Gm-Message-State: AOJu0YzkhvXT0VBKUZx3SX+us3TmHAjh+3odA20XVlcRG+x0BVH4P1nC
	phQzeIGoXY41BshPUgmnD5lqkD5lPM8gfP2myeswHIKVnNa6rQHK8Joz8d2bKte+YqrsiFfNZu+
	9
X-Google-Smtp-Source: AGHT+IFuSXRqSgUvsp9AV89+cl6HvFlJ1yqTwJU6euN4ZjRI0tQoaL3mmRe80mIonpzVjyj5rVtVnA==
X-Received: by 2002:a5d:58cc:0:b0:33d:c572:7641 with SMTP id o12-20020a5d58cc000000b0033dc5727641mr150048wrf.14.1711658756980;
        Thu, 28 Mar 2024 13:45:56 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.50])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0041497459204sm4762697wmq.12.2024.03.28.13.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:45:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 21:45:46 +0100
Subject: [PATCH 2/6] scsi: sd: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-scsi-v1-2-c86cb4f6e91c@linaro.org>
References: <20240328-b4-module-owner-scsi-v1-0-c86cb4f6e91c@linaro.org>
In-Reply-To: <20240328-b4-module-owner-scsi-v1-0-c86cb4f6e91c@linaro.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 =?utf-8?q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
 Bart Van Assche <bvanassche@acm.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=648;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=gN916IcSHjAxGrt7q/maZ9c7wFkfPaWOLEW7VAt440s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBdb8GTSlzu8DtKZvzSQzb6fUGShz2JAX+naIT
 dBLA8agNUyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXW/AAKCRDBN2bmhouD
 10gSD/9lsHVyjZ4k8JwzJLZQZnjn3DJzmE52DtyVoaMx+FIDZmj7PwJr3KJkPLwL+W25JmAkoIk
 PEIhpAFvHqcZIPPo5bCJ1sAIvoHbQNnWQmKC5ioG9YjWbX0MYvnNiDZj0+y38dfJYqesRnKBBVh
 +MEK85Y/Rk22R+EoMdqhzH273DG0xuZ/kMl9xWhddg97kzb9Bla0fL57aHaHr70uJIExOH9DDS3
 QvQ+J4+A3ILkzqts9CrpbmYPEaLMDHBYe7TFcZGSRADx/KEX6yxxPODRufFavRVKX2qgUJF6Y2q
 cXaEE3hQVgaFxRtp/ouuDQTNq6DMbO9SdTqk9eDeIPF/XUEeZnE/IRtOQZk+Q06Swq8a4Z4OWdk
 ux6FSv3DN3rkV607X4QIvlfz+x4Gc+y+a1qoXpvhhqNteBQiF74haLh5+k/DaYIp7hYuFm6Uyfx
 jIGZvddtAB1GpKmb+G17ZrXk2QSIuTU9zzoPPKXGx2JqNuC/abvYHUeTpVtFyaKcrVPTj+MfUMv
 lB6ZoeqnRpnqsmzV/1d2UDiDZaHmqtePcSHLZM64nKyHTIMqUNRCLuUxb5oxclYMmMRo0xKoGBS
 WTSEVTITwUCOBdKm1KOiB37bnbD9bsFIwaJB99PxvEDJjP0bf1ceGwgeffxN5cC3XHe4s+ZqEpq
 t2wTURsrAsWa6Ag==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in scsi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/scsi/sd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index ccff8f2e2e75..0b447f1bc1a9 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -4185,7 +4185,6 @@ static const struct dev_pm_ops sd_pm_ops = {
 static struct scsi_driver sd_template = {
 	.gendrv = {
 		.name		= "sd",
-		.owner		= THIS_MODULE,
 		.probe		= sd_probe,
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.remove		= sd_remove,

-- 
2.34.1


