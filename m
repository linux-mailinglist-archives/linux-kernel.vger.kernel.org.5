Return-Path: <linux-kernel+bounces-60838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4448850A0C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFA71F2116C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451C85B67C;
	Sun, 11 Feb 2024 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="dUOfPkvY"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AD71E507
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707665987; cv=none; b=p9fWaFhil8Ua5ggdr86gNj67y3ilY9+BLD7oCy6SqvUOTUFqAEYnX7lSXDFIWdAgWPjx7EFvENQm5Q2LIFIqVrY8yro6/ttrKG4i2Bn2oXR1A5u03y+BC5HSnrOM9uQGHr7Nb5/b+LYOa5rFa0QwytIofzLPZd+OexynjEZDARg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707665987; c=relaxed/simple;
	bh=bljRfPaQVjigyFVceR2XV3xV7K1YChBBcPSiObHEMyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ORqpIZXUviTtgrVvNEEWPo21oK7wQcbyTJHQCsXd8t9LSHuZxwfgk1sU1IEoWhEs/67S1Fyjc9iTIEAq4SvKlGmeWTu86od9GW5eECSmjMWoxI6AxXduB1FFGW9okxdxut+CWPQDB5HvX8w6FsFQV1W6tvToVYNQa4pwGwLjjMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=dUOfPkvY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d91397bd22so18564355ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 07:39:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707665985; x=1708270785;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeOhRENjM5da5ZxD2TIHWuN96wbbN5rtaFilt5Cnj9A=;
        b=HqH9vtAQDFWDUYhPIm5q+5LI4dKbIlc6U/TLeszaKRIA3dIKK1HJOrN2e6U81U1izf
         8zUEq89dyy72HbOP2JjkB5oyLs1ABkB0ECm9QBkR27vxioihU5y9Bw7Vk+58GOhCAj/5
         aqAda9ojvR6nmr9VvKecteFZjZKmnBL/upKQ6DIqFsCfXzT4UJbM3vxOiyzeVt0yHwOz
         7blQqpINFPJKkXr231j8FPAPXIDBZRsAKIR+Q1+BnC6DZjES8POLvAo6rzE1yWhcYr+N
         ew//9Rq1zR40zuyIwJCuL9gZAB97IWlmaB/3foEyEncgPewTa+H/t2nyhlIQj0Ie39eF
         kkcw==
X-Gm-Message-State: AOJu0YyWAD9fPxE72uCtwKVcy9TL3HradA1ywaH1RSr+JVPleO9h3XS/
	ACEfAT2MySfU2WWPL7qzdJxsG+bxlO81nW6uc0vNcS5EbSwCiN4zKg2xXApeSm7XNw==
X-Google-Smtp-Source: AGHT+IETtXFPF2KNwF7w9pNmFQDbWLAVZXnE3TIUWNkvjq1i5uDjjWNIGUvizbNkbaamdl896qwvSw==
X-Received: by 2002:a17:902:e54a:b0:1d9:63fd:88c0 with SMTP id n10-20020a170902e54a00b001d963fd88c0mr4956053plf.38.1707665985349;
        Sun, 11 Feb 2024 07:39:45 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id o11-20020a170903008b00b001d9df9589e5sm4510272pld.10.2024.02.11.07.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 07:39:44 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707665982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WeOhRENjM5da5ZxD2TIHWuN96wbbN5rtaFilt5Cnj9A=;
	b=dUOfPkvY6AKJxNYvbOUD27cRUlbhhY4lNwi5xZzw22z1u7vHFcc3cwChKJm1eGC9vJEQQP
	L8WJFH8sluYgXlf04eGyp+3D/k9QbtqFxoGLX7XUM/V1ugFN+KyEuqh9thFCU05gowmpeL
	ZWKvSq2D2MxGg0e1FgeZfPdRm0ojwmUgPp4heSmntXrv61DIdjYTrvLX+sMvw7BQciNWW6
	8HqRsFwd1rQ9jvv6B0v1XzEaFd1TSgeqc3BzPObAgZLimSuYbBQHgfPZkLBrj39PQrYIrY
	S423qE6w0QNDklcAYywT9YpJ8ryj+QMxPQF/BvQfE9I8ZZWkBa76FEFMZuOTKw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 11 Feb 2024 12:40:16 -0300
Subject: [PATCH] dio: make dio_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240211-bus_cleanup-dio-v1-1-02140fbc5289@marliere.net>
X-B4-Tracking: v=1; b=H4sIAF/qyGUC/x3MTQqAIBBA4avIrBNU+r9KRJhNNRAqihFId09af
 ov3MkQMhBFGliHgTZGcLZAVA3NqeyCnrRiUULVQUvI1xcVcqG3yfCPHW6N33QvsmmGFUvmAOz3
 /cZrf9wPVb/9EYQAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=bljRfPaQVjigyFVceR2XV3xV7K1YChBBcPSiObHEMyg=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlyOpkWeOWzVMtOtU3AxajU7I+Fs4zXSIqiwace
 Gchbmz9VvSJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcjqZAAKCRDJC4p8Y4ZY
 prg4D/9iXMb1RbDRJiwntskkCNRk8VE+7xGsLGQ5w8jIvBLYZjNVhkFqxcYLGYZUn0Hj2+9q/9i
 mZZNZ/+1Y5ri7Oqf3QYyrcrOyq8tpUgK3Xy+qklxAY/zxjxJ/WhA0kEiKj6EEw+zKXQs2Cd5ZFQ
 hj/tcEP30JWKYPvjds8j4Yl/fcnhTZaIoRjXxZtkPZ93CC6D3OahVbCjmpnkIF9wSMItMZ+4qHT
 MVazoRqvEEktfH/xMBbp2MQjLwyzuqFMaTK9qTHo10QWEmbU6qRisVZaWrt6mw+OkowxwX/2duQ
 fBQL3ZcygAxbiOMxCqQoUTsyZQ5GCBsE5KjU/Ef/4vYRy/T81SaIcPyixlmSyezwBrKeKf8lk1u
 qTK+GIo6VKH0bg6ovVJ0Yuj5Chz5TijXn+FXMkWktmY8VMYmb94VNTB/KYSWQFl0C420fs9RuBa
 r71k+CDjWR22FoiU5ZivC2/6yS45Y7DgkYhXtkMdCxkUCyALeCOnblMrq87/zYDU38Uvsq8exoh
 NgACJRSFhT8XcsaBwFIv+vartE4tl5z8j3O+14aiiw2VldWYfhrn4y8pSMeKFfFa9XXeyZ9559D
 Il7mC0IduIP7i0WRbpt1MoFoZBwX0oxlg1VdGqwS350SwOfWuIcY+stcIsxCdYl3AwArHqpi5jL
 7eEBAgpeQ6wzucw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the dio_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/dio/dio-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dio/dio-driver.c b/drivers/dio/dio-driver.c
index 69c46935ffc7..2d9fa6011945 100644
--- a/drivers/dio/dio-driver.c
+++ b/drivers/dio/dio-driver.c
@@ -123,7 +123,7 @@ static int dio_bus_match(struct device *dev, struct device_driver *drv)
 }
 
 
-struct bus_type dio_bus_type = {
+const struct bus_type dio_bus_type = {
 	.name	= "dio",
 	.match	= dio_bus_match,
 	.probe	= dio_device_probe,

---
base-commit: 047371968ffc470769f541d6933e262dc7085456
change-id: 20240211-bus_cleanup-dio-6cafa80e759b

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


