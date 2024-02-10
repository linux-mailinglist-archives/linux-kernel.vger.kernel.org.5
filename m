Return-Path: <linux-kernel+bounces-60168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 562EB8500F9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6A11C254D3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5543217;
	Sat, 10 Feb 2024 00:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="fXF6svOJ"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C32423BD
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 00:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707523639; cv=none; b=gO9Tm8c8qw4EhgN35CUzicYz1xgPD06/yhFjzeCYg47X709tU6cqiN5JKBdGu7yv76s3PO2WXJcx2qCvrU5me32CTzB4wtmeqU8+GpEmnu3dci600800dQZzqavJnfqn9x4OZC4uBC19Vk8TEtsYQQ0imDP99rPkSiySkK+nIhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707523639; c=relaxed/simple;
	bh=XAd8TiVz4++g7NhVht4S/FztN9ETtYB4+lyWg4fhN8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OdSM+4B2NOylMzuw+47yhtbGUuL58pZYn1cJjGyqs2zrEvdFO24bj44/6NYYNRjbE8IRS8Op1kxOW7MrnNwnFcB/zqxxqRv1wRwzMJYVmjkwrZHNilgQfRkWXReyej4nwJ+ECvJaeRIAYSmqpY2fnX0EsjuSJkoKI+Up2861WQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=fXF6svOJ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d746856d85so12162415ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 16:07:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707523637; x=1708128437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CobaHuwhU7pfdk6obvxMNllpPaSd+YlPdvQP3GqjP1E=;
        b=Wq66aYfmi22TepHm9hh3dyWSjjqGkXbAGhXrVTM9Jz8fI/aMORx3tsjY25eo7qhbcx
         lWYpuvfMuc6BfYZk7ztF3iRZi9vdR8CZHw/mxRoe1q7qJJ06dYAN2zwMP5+tbrLj+Gal
         YZQOCFPnk7m7ce+MxR7OOzduy8ixpZfkoaKjDyOJ58zQaVqoPZjPFfBG94xhb+yYYEHC
         YrB6cC1lPqiIWtuLiQ+08wqtDY2oWrJPJPJOQ3qby0slONWU52WqlqnModjv1bQ3Gg6K
         06giJuuYSkAH4VSv6rxyPV5mvvwFY7BwYlGljEUy9xSc7LYkgCBrAr993VN1UwaifKic
         8n/Q==
X-Forwarded-Encrypted: i=1; AJvYcCValcltid/lxK5EUEMyml1C5e8n2GOUWUNd4Fp3aBmt+t55suPZgvGzWvdk0fM11xyoTClWIu7EgBgJ/ICQd42BpIasdJVazdcTotjl
X-Gm-Message-State: AOJu0Yy+DDc8q8lJtqiL0uyoN0+8ZL5IFEDSelFNFdVLc3th2WNsct+P
	HwUMYl10RucMZzLdZnCbgKX7QHL4RA4WhdexNBGrP45hQKdRi1jB
X-Google-Smtp-Source: AGHT+IELargduUlzNN38PwnIetV6/MvnOucoZlWdk6gJAlxDNfByHo3C+GE6gaMaFucRru0I4uO3LQ==
X-Received: by 2002:a17:903:246:b0:1d9:8d17:87b8 with SMTP id j6-20020a170903024600b001d98d1787b8mr1074664plh.34.1707523637554;
        Fri, 09 Feb 2024 16:07:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0aEb6MnfJbY0j2eWqTKtV05+9CqXH9uCo76kEowe90g6exquj1cqimTIiQK+WSIAsS+VVnkbotfuPq/Chs90/JbZLbTkaBW1gGFt8YWxYi5QaqWO2YnHW3jjJKaTKXprxqo/oUdaUMESQQKOYfxx2o32z7pe88MD8ehrKsJcdyvosrHNqzuf4DUkNkgqi5G+0LYqgxA0LUBxgIpYTNJlbjLjnFJGmFlmRxv2ShYpGo7T0mfp3sbdQFd82/xRPzT9yNSOKDiy7QGgP0a2L
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902d04b00b001d92c29d6bbsm2056182pll.83.2024.02.09.16.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 16:07:17 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707523636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CobaHuwhU7pfdk6obvxMNllpPaSd+YlPdvQP3GqjP1E=;
	b=fXF6svOJNdlRnM2oB7YKPES6ppQVF0fjIc80z3phw+cxQ+ozcbx2n7BoxNhXXHCgeWo34B
	v9UnDF69uGr6ByW00AwqmiaHC3T+Gy+0+hxWswm6Qb3U2oZiIAhsZI6Jf2XKAcpmhiYfww
	K6q7WI1meVICQZAUYHUeR1UPFOI+B5ztW6CH7SVwyB3h0pRa2JdiXODZ7owmxntqcR/2wC
	Dzb/hcuGqh3c+cpaDBzMwif89Qffn2Qf8f2l5tWPgwtFnOsNuwSKtcnefGq50TU92umuUo
	og9f3nsYzqUI/3vTVeXvVBGf59J03HC6umMYR/ZsGUiNwKwiNEDUL/mlnGtlDw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Fri, 09 Feb 2024 21:07:17 -0300
Subject: [PATCH 2/4] powerpc: vio: make vio_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-bus_cleanup-powerpc2-v1-2-79a56dcaebb1@marliere.net>
References: <20240209-bus_cleanup-powerpc2-v1-0-79a56dcaebb1@marliere.net>
In-Reply-To: <20240209-bus_cleanup-powerpc2-v1-0-79a56dcaebb1@marliere.net>
To: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=XAd8TiVz4++g7NhVht4S/FztN9ETtYB4+lyWg4fhN8M=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlxr5QwYe5223DLNqd7+j+9RNBUgkXhzfbm4xn+
 3YtJ5UFEauJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZca+UAAKCRDJC4p8Y4ZY
 priiD/9QTh7JZjD2iaoGlvBuQdWikMPT+ZgyMMW5qzwsew1lpWvHKrhCt6uODcMwfcjeKG7WeFv
 yPs5Apx/9jnJSqxhzgbG6htKZZc7T/Kq9wc9kHg204yOLWNtuWXu9lxWyVqbjC/hCRAzWZ+F66M
 RT9YheXnQ7qfol1hQHgH00RH0nmarQeoe0KUJoH+u6+Zy0bImMYYqbCahWxiHOksGuZWB/RyrRf
 ABv3bba3BURL8hjyne+2TVZB6HqQLrkXJDd++pDZeK2oott5uIqWE2xOMNOvYpVJxiei/F33FVq
 fvbOjzPmKrxUw/p9WZEZK6cx3woWODAARBXe1XllSmQDh0OtOJn/khIidGfOunFSesL9nN5xnYq
 tRD7750kmXJYo/tF3YVVwCeiFytdWmipNMokUhztawwGM2qnJpTfCs9UYQQ1Wp69lzWQdM/orW2
 8bCfNdtymrjtHhzAOTYw+bn3r3t76nRqg3jSTkCykyH5tJh8PankQhknj5mdhgqAInun8Mh+N1r
 09d+QHXIErib7mxWdL6spsDJMNVXHCE8nTA1pHMQapKdEDE64dfIVgTjz1i0bl5JrjJd4Tg6mep
 vLB7VNJ6XT4S4XYdkhuIIF9U5/hpAQ2ruq6/DSmapbiHtCh+a1y8lRN6qjAzIh3Aj8cIZ26+PTs
 TcffrCYWM08hVFQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the vio_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/powerpc/include/asm/vio.h       | 2 +-
 arch/powerpc/platforms/pseries/vio.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/vio.h b/arch/powerpc/include/asm/vio.h
index cc9b787627ad..6faf2a931755 100644
--- a/arch/powerpc/include/asm/vio.h
+++ b/arch/powerpc/include/asm/vio.h
@@ -39,7 +39,7 @@
  */
 #define VIO_CMO_MIN_ENT 1562624
 
-extern struct bus_type vio_bus_type;
+extern const struct bus_type vio_bus_type;
 
 struct iommu_table;
 
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 6c58824190a2..90ff85c879bf 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -1615,7 +1615,7 @@ static struct attribute *vio_cmo_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(vio_cmo_dev);
 
-struct bus_type vio_bus_type = {
+const struct bus_type vio_bus_type = {
 	.name = "vio",
 	.dev_groups = vio_cmo_dev_groups,
 	.bus_groups = vio_bus_groups,
@@ -1634,7 +1634,7 @@ static struct attribute *vio_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(vio_dev);
 
-struct bus_type vio_bus_type = {
+const struct bus_type vio_bus_type = {
 	.name = "vio",
 	.dev_groups = vio_dev_groups,
 	.uevent = vio_hotplug,

-- 
2.43.0


