Return-Path: <linux-kernel+bounces-86531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD2086C69C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D72288B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC0A651AB;
	Thu, 29 Feb 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXpXfCWU"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3485764CE6;
	Thu, 29 Feb 2024 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201709; cv=none; b=YmeEUm5M8O6sQCEGihdFFP0EFpD/ijvO+s0QJDufIoxKMOqnJQdOo9KZ4XjR6aMz5yxmJ057VlCretSrdjvpolFGzXCncXUEJh/U4S7rT4VWfPu4TMAs/oFxBcL4Tu1EGhZ811V6BZQCavNkYVkASbiqBYAx+xHb59i0THDqr1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201709; c=relaxed/simple;
	bh=VS3k7Eme/hyQ7tEVQDrFi8KfYkX4wGsSA7G+IgQF6YA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f0JdKjhtjqEfwbwgKovfWG4nBUTw4NKOZjNZeoIQNCPO9sIi3SNBVTtCyjXx/1wCCqK8E2TSGpp3HMlOVp0gnwFXigwqbzR0oNiHisQCjVu3CFXhQ1bysD7Mg61uV1R+PWjRvo+JYyLIzaDKR+qypYmFnpRy1xvifT+bhfmbIi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXpXfCWU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so6092355ad.3;
        Thu, 29 Feb 2024 02:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709201707; x=1709806507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=he/ItjnnuJyDwNl8joarj/oySXhyLeJqmRkPhPpRNSw=;
        b=BXpXfCWUelIfLjf7C/DRFVL3gFAUCVNwnIiY4CYHIxIehs0boavoyV8xuciMX85sPp
         rEGNQ9KwymmrZlv0UvJ9SSUETB1EDTamvE1VHRclA8t5ed2XH1xlpiz96OQW15tjV6fx
         ugbrCF4gwKHFk9YbjWX/iRmEPOJd18Lfe3qSs9Z0jYqEGKM1OZYYcIIW4ive4q/8WZbE
         pzAl2Ppfp2NhtoyepFhR5edE3QR7vxGchmx/+R1AQd3DioU9e8NLXPPTmI09qRkAZIBv
         v0068vQSsoUd5sMrht+EjmfpCeDE1coZix0yJlkPfxpcHoSvndBEGYZ0ddvE89Kt21C8
         jAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709201707; x=1709806507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=he/ItjnnuJyDwNl8joarj/oySXhyLeJqmRkPhPpRNSw=;
        b=PhDo5gz8D7iZ1VbiSYmDof648mioW7TYcQ7Yp7iANIgXC5Kqz9YyxMpxq0AFqLJjvu
         5r85aunV/84+gSCItfbSjqaaghu6AgsZE10LB+PVlLDiLqOxoGdHHIjJx247Xv1e2NvG
         NrIg1CZu6gD5TptXxBJ+twBR9boIpCUfvXRwa4SGPWmuDr+RWp2i4h4cEBf6fn8UM0JZ
         rd27DEw7U9R0Eipuof4Nxoc2IqOl0FWq91D4Qlq78sSurOy2jUW1hzd74IqsAAw1QrF/
         gh3V4Qa8OUYgcywXRrf2YoqmhuUw92XdQXiBme7mJAP8NATEgszFJk2tCrEdi4XMPMHp
         B2gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKYog+XN+cjJvk0Kicj/uG9JVw3Q90oq3Df7h15m3bWfbdhvk8Hf5moN+whmsqHqgScG/VkuTmMndZz1WkvRymsY2vSDRiKbwFLf8b
X-Gm-Message-State: AOJu0YzNv30NDVC/AFZRcGjCitPsHsypBeZsI7mOYVG2TS5+TzhIc5/1
	jkHjl0/h+UNg6FeJsbbAFHY1gnJW361ZrNMOtVsErZ8pZp+w1C7f
X-Google-Smtp-Source: AGHT+IH6byZhriC+6ROnCkkVdld3fAcEBOYZQuXS5LEIhNL+V8ZkyXqw2nKcc/YDbgccqUh6melXwg==
X-Received: by 2002:a17:902:eed5:b0:1dc:1ff5:3dfe with SMTP id h21-20020a170902eed500b001dc1ff53dfemr1537039plb.27.1709201707609;
        Thu, 29 Feb 2024 02:15:07 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:5158:ed66:78b3:7fda])
        by smtp.gmail.com with ESMTPSA id k23-20020a170902ba9700b001da105d6a83sm1061874pls.224.2024.02.29.02.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 02:15:07 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: davem@davemloft.net,
	herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v2 2/2] crypto: iaa - fix the missing CRYPTO_ALG_ASYNC in cra_flags
Date: Thu, 29 Feb 2024 23:14:49 +1300
Message-Id: <20240229101449.227921-3-21cnbao@gmail.com>
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

Add the missing CRYPTO_ALG_ASYNC flag since intel iaa driver
works asynchronously.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index dfd3baf0a8d8..91adf9d76a2e 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1916,6 +1916,7 @@ static struct acomp_alg iaa_acomp_fixed_deflate = {
 	.base			= {
 		.cra_name		= "deflate",
 		.cra_driver_name	= "deflate-iaa",
+		.cra_flags		= CRYPTO_ALG_ASYNC,
 		.cra_ctxsize		= sizeof(struct iaa_compression_ctx),
 		.cra_module		= THIS_MODULE,
 		.cra_priority		= IAA_ALG_PRIORITY,
-- 
2.34.1


