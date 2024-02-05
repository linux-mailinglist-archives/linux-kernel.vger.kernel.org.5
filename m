Return-Path: <linux-kernel+bounces-53224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDF784A256
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C831F24EC4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7B051C46;
	Mon,  5 Feb 2024 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="BFd0uCk2"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4284F898
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157709; cv=none; b=KtqOmLK2fDf4spJ+JndJfeV/H303ii7cuiTDBO1Nn/4JOFgjzVtB+88inr0JT8nuwfszQHzXIxhbKDi0g7Eea/ImM03878nQxy8oEBpISWl/osH/GO+6nNW/WAbK7T+PucDr9JARQRnRX2YcnyBgolmyZnsw6Qe2n20OiTQ5k0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157709; c=relaxed/simple;
	bh=RcKQ75xoYo5Om6NQThsRZd4P2ACDxtfbHJ3rKoRtNvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mKo4rY+Auhh0gTLR9qVbSeREX7dOn7OrcdYIbdXEVdOJflNndnBGbbEuNxk9UwF+Fr8KCHrOuYlPmvWoPwkMe5BdA2k4VOvBoVRiAGfx2T+VLJqwooLnTwQcamwoZ7x4lr9ecyyIrk4rqyCRoC9uf+x/vxgiuu7+hVH4Xv9leWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=BFd0uCk2; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so3767830f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707157706; x=1707762506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tupJ2FnxBizYD8gOKKXQjNXDQsDvYn5mQ/R4h0dASo=;
        b=BFd0uCk2pVOFWjuMauOX6MYm6byKOYfb290WyHDWUfwEV5HXXX1aTTN43ot0C3maEu
         dLZKv/r0cKXK989A89LHPyqEcGtjeAZSwzEBq6vElE9WaZsmvfDG6lrb2ywu+dGqFyNs
         s+3+WXi9vi7CJWiSnA733iWrfb9ZA/fJWjhEA16258eUqTGZPp3gqlkJ/AzozIzXQRrp
         S8DWwJCxTyRhi53VoKwSuAHRwhlIN7c61W/3k2je04DjwV+r2vTt4rQClu3vPYsNw4Od
         cdpIlzi61llBc8p7HwnIBIsuD45fQxVn03ObvSFQsX3LBJNAhLIi6+hdAEnf4Y+Lbq0j
         E+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157706; x=1707762506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tupJ2FnxBizYD8gOKKXQjNXDQsDvYn5mQ/R4h0dASo=;
        b=SC7x6BlrmuV+SE4En7a9HiABkSBHpO/MT5tUVLnxbiB0GC5oflLT/JRgWsBUkC9Ocv
         IzJAtZznyHOKrga/PjRp+xlDWovH3yLspJmM3QDqy9NHjMAZsf+ok7U8Gw4Jv4+6I7G3
         1+/x+y3EkWxXfSuXbPihx+ndxa0TtR2R2H/auaiHKlbG+wVuzlWQHDADaErZfmU0RJA5
         6HIMeoPgJZIZBYynUhynWreYENS/XDk7U5+CqFntgqptsgx7a3b5s7ZdYcdX0dCp7qcz
         t1vxlDa5jMIZlaFXxuWhXhmQqNtr3j4j3ZHm6+ODigRxVfe6HMTRyYch01nz4arI8HKh
         CSmA==
X-Gm-Message-State: AOJu0Yx0KHNi0A+RxmDaKJZEKClHrP0i7DB9pfv48XfEkl0tgBBeJwEA
	38e3m+iSXDqi2Jd0S44wibRYVDbF2gd1OccQ6Eo2uUkcQGvrSrk+u3+ytK2dZss=
X-Google-Smtp-Source: AGHT+IG+sbdjO6Ne8XmtkOxg440O385CsG10rcZ7aD0fSOEF5DCvQP0k+e5WPvC4oyOL/1iaE06kWw==
X-Received: by 2002:a5d:494e:0:b0:33a:df1f:c18d with SMTP id r14-20020a5d494e000000b0033adf1fc18dmr255069wrs.50.1707157705890;
        Mon, 05 Feb 2024 10:28:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXT4ZnvEnP4r10+RPvCVOQEo/78xjrvuNkUXKNr++627Pk5BHgAMo+Rf0L/87RTJA+svf85xNKmwk6kmz1uPt2PkGDVRD2gnMPKtsJwWgLUZyGmpD1E0uhk4e1CZObeYh6dabINSzekps/tw9VN9MY5EQgzJzUem0h87D4uH7M7mX7vRI6+dlFYxfvdozs2Lm+53hPSmrvuvl8S/AONFl/aHEbigym1Lih9+1BaOE9+Itd0diqOSE6bvzlmhmZGrtPHMgyRteHjV1fgRVNm13JMscAALB38tXEbAi0VTrtcUDT6I0E5ZR4VwAMVT1CMmSxQiNm3fPWhG0CVeZB6o6rr2DJtowzN8/KpJzGDrMzABZZoVCxlUc02q6IW7fM91L3839j7Zfn497dsZj86Jyr901En4lqTvLZ1jFsxvmrSTHMTXU0henmvHiXvgvOFRpN2PbFszLxiZDZA6aPA0YOZNtbcuqdW+yVzIcpbVMp5SfbDS/NE/r0ac3Ztb/qbKD0vVtrIw+dtjRJh48zQk5y+58svR/mty7n4a/gumYUcukQq9R9+zjeHcXWYgusCqUQ=
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d929:10db:5b5c:b49d])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d678f000000b0033b17e18df8sm203229wru.12.2024.02.05.10.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:28:24 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Guru Das Srinagesh <quic_gurus@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: [PATCH v7 05/12] firmware: qcom: scm: make qcom_scm_ice_set_key() use the TZ allocator
Date: Mon,  5 Feb 2024 19:28:03 +0100
Message-Id: <20240205182810.58382-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205182810.58382-1-brgl@bgdev.pl>
References: <20240205182810.58382-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Let's use the new TZ memory allocator to obtain a buffer for this call
instead of using dma_alloc_coherent().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 754f6056b99f..31071a714cf1 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1197,32 +1197,21 @@ int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
 		.args[4] = data_unit_size,
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
-	void *keybuf;
-	dma_addr_t key_phys;
+
 	int ret;
 
-	/*
-	 * 'key' may point to vmalloc()'ed memory, but we need to pass a
-	 * physical address that's been properly flushed.  The sanctioned way to
-	 * do this is by using the DMA API.  But as is best practice for crypto
-	 * keys, we also must wipe the key after use.  This makes kmemdup() +
-	 * dma_map_single() not clearly correct, since the DMA API can use
-	 * bounce buffers.  Instead, just use dma_alloc_coherent().  Programming
-	 * keys is normally rare and thus not performance-critical.
-	 */
-
-	keybuf = dma_alloc_coherent(__scm->dev, key_size, &key_phys,
-				    GFP_KERNEL);
+	void *keybuf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							   key_size,
+							   GFP_KERNEL);
 	if (!keybuf)
 		return -ENOMEM;
 	memcpy(keybuf, key, key_size);
-	desc.args[1] = key_phys;
+	desc.args[1] = qcom_tzmem_to_phys(keybuf);
 
 	ret = qcom_scm_call(__scm->dev, &desc, NULL);
 
 	memzero_explicit(keybuf, key_size);
 
-	dma_free_coherent(__scm->dev, key_size, keybuf, key_phys);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_scm_ice_set_key);
-- 
2.40.1


