Return-Path: <linux-kernel+bounces-86530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CDD86C69A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B721F22D3F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4838C64AB6;
	Thu, 29 Feb 2024 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS5HIwDY"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D20164AA8;
	Thu, 29 Feb 2024 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201706; cv=none; b=Z+NNzbANhcF+2yLQV/hVhskxRdpPxl7RR86DMD3pL+YPFoVxF6ALhVgC+RrV/pCaD8XHxAs8NiPwVm+tdES6F4XEjyMj6yI3pmGCphoW1sFgE1+9EDd6+JV91cL94nh8iOM1upI3VK31qHb+ILeQVFDTJzvP6dyqzmPZtaPO27o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201706; c=relaxed/simple;
	bh=XAPVfS9t8TOCNGonQw4q4SG8sv7NDvOP8vlbc7T7wp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3EVZAmafqHNna6CMyceOsM0xd4nxdAEAGfcut8UdyApto9dODsYpKvWpIHuYpTsMjfJsF9E5lOJnosnX+rAA7DrlPmCNc30/whsld6tt+I3nxtMao3cl5hU+XVFKVTdWNdB7/flJ7L3gtnoYfSmzEN8A3CeLgdKi0YF63looIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IS5HIwDY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so6092115ad.3;
        Thu, 29 Feb 2024 02:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709201704; x=1709806504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxP2XLwTLhcjh6Nu0DkhBrLBQzkVwKMK2PxdaxrpCmk=;
        b=IS5HIwDYoL80TMHzFb7oXvsK9YBhFRObyyEc12lUxOJXv07A2yIaUaeN0m3/brr2qi
         h/EEl5iNSeDnaWSJo55LKnZox7DKMbjV3B8i+T/c1/lDv6ueKFbrbGeJqjbdmitpqVYf
         TBrtNfsQjBs1SVsNA8K1EduonTz7vCGvPQpvQktx/fFpnw88wFmF0iJ9um/lLP4Uf7Ki
         B4Lqp2zUDho8Rj6z/Mcz2Q9zlfD3jDdIRRJXWmTHAJ61E5kCkfSME4Q2cy+mDbbhSsiD
         a9UYQ8hZXEddakUhX27Z3MBEy2lvjGsthHkg6oSkqsGdpFO0gByh16ujrJVUdhHTatD0
         UtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709201704; x=1709806504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxP2XLwTLhcjh6Nu0DkhBrLBQzkVwKMK2PxdaxrpCmk=;
        b=Qym4UrV4r4LieYJv6fggbDX4Xc+0rvhoFIbt+nrVsyj5f9Ns9uUkWtcsXBR6KoIhp/
         I33+cEmup0Wrtnr/OJJCi8kVpSF857Bc+9IdYh7VTsf3cHc3lwQFqXAZVANI86y15L/d
         Vl3QJTIHIormXkGxwPtFtxJM+9MwjWGn8NxgyiqBx9iu8L1K8d5UVPPErxblk+nTDc8X
         wDvXFvkS7vsIGOrcXUq0OxLW32R/mKHwc/jcLjt969OUBEq7bHrBNTouS0NPq7rSgMoX
         piCrPobeiAC/oDIgRBgbTwNZsOX0+Smt34zLHcC/m6gPJDEpbGrv3vjDqyooy3akKf78
         RC9w==
X-Forwarded-Encrypted: i=1; AJvYcCURlM6ZLNXPuMOv5tqcl0gt2+mr9UcHAClpemEWCCz2z8BCHH82DenBkY3DPodubOTHxr4O2qOV9kn8Ql5zaeJMwuVlfTE3MveqmDUh
X-Gm-Message-State: AOJu0Yyhyk6uILLAZqz6CyZgOyoMUl/nFaQ/9U/QMzIvyPaNjpB4F9Q5
	f0YFliLN5HiLQCRqc4hx8U9rmUbeEp+SuUFAnoVlbbOsGrS/DV2h
X-Google-Smtp-Source: AGHT+IGXaKuifoDJbxqmpyFaAJdWeaThwvqn9ddV8SlKNHxzzQmVpEmxOkwjxAD6W0YeThUXHwze7g==
X-Received: by 2002:a17:902:ed94:b0:1d9:6de3:9980 with SMTP id e20-20020a170902ed9400b001d96de39980mr1376216plj.48.1709201704500;
        Thu, 29 Feb 2024 02:15:04 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:5158:ed66:78b3:7fda])
        by smtp.gmail.com with ESMTPSA id k23-20020a170902ba9700b001da105d6a83sm1061874pls.224.2024.02.29.02.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 02:15:04 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: davem@davemloft.net,
	herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Yang Shen <shenyang39@huawei.com>
Subject: [PATCH v2 1/2] crypto: hisilicon/zip - fix the missing CRYPTO_ALG_ASYNC in cra_flags
Date: Thu, 29 Feb 2024 23:14:48 +1300
Message-Id: <20240229101449.227921-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229101449.227921-1-21cnbao@gmail.com>
References: <20240229101449.227921-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Add the missing CRYPTO_ALG_ASYNC flag since hisilizon zip driver
works asynchronously.

Cc: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Acked-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/crypto/hisilicon/zip/zip_crypto.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index c650c741a18d..94e2d66b04b6 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -591,6 +591,7 @@ static struct acomp_alg hisi_zip_acomp_deflate = {
 	.base			= {
 		.cra_name		= "deflate",
 		.cra_driver_name	= "hisi-deflate-acomp",
+		.cra_flags		= CRYPTO_ALG_ASYNC,
 		.cra_module		= THIS_MODULE,
 		.cra_priority		= HZIP_ALG_PRIORITY,
 		.cra_ctxsize		= sizeof(struct hisi_zip_ctx),
-- 
2.34.1


