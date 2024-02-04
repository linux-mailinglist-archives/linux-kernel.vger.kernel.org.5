Return-Path: <linux-kernel+bounces-51699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7905848E5C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018BF28342B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3489E249F1;
	Sun,  4 Feb 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="h9RJaU/i"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0786A23751
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056507; cv=none; b=ayq8MqQLuBd7w+KjdNeAf56+I32hbtBJ5cVecDUkzg/lNnzZk7/ZcSc2xakOZB8DOZnsb9lNeEYZ2B0zbUcwTxDCf3LdneU/mvgFP0Tdc7TMGynbxG3T5ZiOe8wrM/vtWwYxwijdT6c725KEbqYWiIRMLKfiRZViadmGv0hxaD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056507; c=relaxed/simple;
	bh=vX4zjhZKqFa8JoxKRN7aX2nEk1pJYZI5Yuxa5g51+Ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nk4X1EG8lUl53mS+uIB0b3q6BxjZ63n3hk2HxQSRykAMA9R7l66EBYq4LaxOGVgGPS8s0bmQA+gbz0PlwmL6/tVEFw6Q19mGCppb/QO1Acf9gFQNvT3W48IGEbLVAn2aVYliLI6wbgkfw1Tf5CPBPYuI+ld273opZ4LNpWsuF3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=h9RJaU/i reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d9b2400910so628685ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 06:21:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707056505; x=1707661305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHTVR82oJxjzskpZPEdBmE91C5T4iAunxv4wjFY1nfc=;
        b=DCKLydOl6TXdllKE/h2SnyM/c5YJOjV6YQHTu9lpGyzITvDFLLchHyZbCXuvG+dMEd
         r9T664O2ZeKvR5vEcbEHRnaSqDjY79IjIVf4M8Ymv/gZzqsTDtjsxMigccXPS6nGNFeD
         8DbmgsNUEAAiPtpqM1HzvBTsNhtyUCqEP0LcwiWPiE44DKHUen3LOaERgYe2cxDXJcos
         hGsHONa/4bKnqo8Ai2nCjho981SLjoeJ+hdB2C05pZZZEkaRRN4eqOV+lE/ZjeZsOgDI
         0LNO+g6VJiNE1NaRb88xJ/e0BitZX4TGOA3F9/y5LOUeha7RSFoULReEaeqqEZUaV2vj
         U50g==
X-Gm-Message-State: AOJu0YxgaLE8smU80rjYjkiZbgj0GV8d/xwggM6oR8gHCtcusCq2HFBn
	ZV5ogQUkWyflVA+ijgWrTZXCT/C2XrHh1HrO2zNfETX1efnR8aqX
X-Google-Smtp-Source: AGHT+IFnxDcHKcqFG0FkygR0Ytn7AdpYRpJG5e9YcGVrKPogkQsls2qpinGrOuL42JpnMCDUjOHynA==
X-Received: by 2002:a17:903:98c:b0:1d9:a15:615d with SMTP id mb12-20020a170903098c00b001d90a15615dmr5281659plb.1.1707056505235;
        Sun, 04 Feb 2024 06:21:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUhC94iyl0+VWBvOMii/Ie3ZeOnJPwaJglnNjuI4MN5P+jK+5NO+K8t2AD3Nw+NK2FfuD0xLeb8vODLn9BgAf0iziOWHtiq0o7RzDbCO/hXyIobzMj6hhmrSWq0SK8x2WYALXXP7nU4JAMp7mZqrvtwr0F2xUCJqhlWofgTvsWzcllWPLe9npaGiG8JalL1mEyfx+DsDP014R5KH/g+ycBWm+jI+oFTvj8bWvZguGerqXYnR6tcW0h5LKTsF85JcLqb
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902c38200b001d8ee2884c6sm4609803plg.218.2024.02.04.06.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 06:21:44 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707056503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHTVR82oJxjzskpZPEdBmE91C5T4iAunxv4wjFY1nfc=;
	b=h9RJaU/iHQx+xntBzJkEFD2ovMgBGTUqNtBTge7Qh7LVL3klLNR4GW6iranmYAIYJKODRw
	JC/rTKcnEx+NkhV42R9gdRJAWtxn+yXdpEZXW0VtuE8uEbhZyGKkNOxX0QtYvnR4mdyEv1
	nV/w+5WiSgUj6ke4Hlra+FxL9xCPr4YDKGjwS3+dZqLY2aTCqzC5AfwJ3y1aaNG/T6Hd2S
	sZfb/dm1vgNaKZpz7q80D+Sb6cpwLaNaLBM8+AdgyF+uww8NMYV8Aks0efJPlWD4pxxGAX
	armnejmHiNlRTcchM0HcX3PKFJt7gTKz4kvgh0u2IO6nj7KWXXizYLb36MBU4w==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 11:21:57 -0300
Subject: [PATCH 3/4] powerpc: pseries: make cmm_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-powerpc-v1-3-c763f0e142e9@marliere.net>
References: <20240204-bus_cleanup-powerpc-v1-0-c763f0e142e9@marliere.net>
In-Reply-To: <20240204-bus_cleanup-powerpc-v1-0-c763f0e142e9@marliere.net>
To: Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Geoff Levand <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1015; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=vX4zjhZKqFa8JoxKRN7aX2nEk1pJYZI5Yuxa5g51+Ic=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv52JH0RVChP/ofquW6EPeXAMdjGo10WSeUC9O
 h3sBucb3ZWJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+diQAKCRDJC4p8Y4ZY
 pkadD/0TlY8FzfIjCQDLawUdlYcvbSomh3gXRLnEHroWY/LecVGFkF3AkbtPP0QIYBXD5T31HFB
 HVypW5RmOBQFdiFBG2sHO+PCkZBvzkJJewhHZNW2eF/uYqr2SfnDY3+MwmJyCYCTNKDVMdDqqk5
 kKOUUXv0YW5fXx4v2Uju0b8G8oAthRrkfKwiYMXm87gpA06e6QuCxUHEOyxisJaFiVfCdI73I9/
 L63eIOxFStcTa9yxet3Culd3mN6R8T5Nk0rlHqYoT13DepgrIkkuIrVWtWIe8jvqWA5Hrv7a0PO
 sKc8ml7h4B2XY1OfpZHeD/1TKxjBtulPfhD3p71EhodEneU+yD0d89Qa6IhafmWG7ACX7Zr1Ech
 gt8gPI2mkJxcWviJ2DFInqAG0kztc4YDOdnxuBRjkZEqbZ6JOqZ6cXXGcx5/glhAFiiv25bzDkl
 GBIz7Oo7rydanRQUykKDN7S+pNqM3wjBKYOJYdCktkQNzO8pTTlt6wspLz2idEfI2cntNkmjPmt
 cihQJ095A+Qaaq8qepX1esm/yOfaB5KOyrZlH8ke8IiQm11HYX1dB3dzR6p5lgaNAGRfjRip2gG
 ZNwagG60OdKk8UaEU3M9c/NkhPbn5PVk+UGpgrMkVgLKzFlWHYnxFEUnXTCDpfLmVI+50CtmEHv
 9lisZWj+nM2sLPw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the cmm_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/powerpc/platforms/pseries/cmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 5f4037c1d7fe..6307dacc3862 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -375,7 +375,7 @@ static struct device_attribute *cmm_attrs[] = {
 static DEVICE_ULONG_ATTR(simulate_loan_target_kb, 0644,
 			 simulate_loan_target_kb);
 
-static struct bus_type cmm_subsys = {
+static const struct bus_type cmm_subsys = {
 	.name = "cmm",
 	.dev_name = "cmm",
 };

-- 
2.43.0


