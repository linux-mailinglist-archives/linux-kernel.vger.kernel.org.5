Return-Path: <linux-kernel+bounces-72320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9F785B1F6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D62E28442A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756F757316;
	Tue, 20 Feb 2024 04:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H30U95uo"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A13D56777;
	Tue, 20 Feb 2024 04:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708404165; cv=none; b=ZtImqXuvjzrRQkgLuLBpSPlowONPQO2EyyDLFS75IyWOdCUcQHG6GR01BbroUmnKfadiWkL+ICML1h/ZVF3kNEmP5br+wDRJoSGUBCJK0jCU9oSMlFCZeqmpNCwcFsNu4Un51VKOXu3UzalzglL7MxEa2m4BkmwV2yir4ptXZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708404165; c=relaxed/simple;
	bh=gzQ6R+etidSetPQOExWWoNqJeEwkHtJKCmG1BAhkx5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cg+RYWmwtAw+uhmRFpa/aG4YgqKuf4nk4WqQ/rnK0lZB776SFNII/AHQy6l2RFGD1riuHhq3HIdFc8vcfcBGXpIibCTfx7+axKiY87uxvzAnN7iimG1iyJkZ4lLQUF0pE6ugc76aaL7cMuHq0WBibAu9SwO2Q2uj9tPXso1YDLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H30U95uo; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso4131636a12.2;
        Mon, 19 Feb 2024 20:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708404164; x=1709008964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7g5zKrHqcnJOKfoElmxvygC1Q68jKDTJ5BwTUnStAdU=;
        b=H30U95uo3b7kUdsZZILOteSZKBFMYutx7VdrrMEYwy0lC7DkSYAoxqVLB9S5PWnBLI
         qCgv/JWEnJ7GrjExucodXCAd/6MG0VyemHiRB0chShQhq3UROY62vt73LpTG3xVcGsbZ
         aQPzDCFiwbvFTl3uQnMuBUbQuJ+IrjgNSQUAGrDSsAj76WiKOS13UtoS1+nOP3+dqNv0
         CcRhFQ9Ry/BsRBYG2qsAQhYeZWuChLnw1Jj5dUa1w4PlLScIm9gwi2hvvO/hzmHMXYPr
         JfOM5tMGo50Mhr8WS1dq9IqB6niocpJDgkvcvNhFbr5jAPdOKPpVBMx3SLQcD5HXDin5
         A2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708404164; x=1709008964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7g5zKrHqcnJOKfoElmxvygC1Q68jKDTJ5BwTUnStAdU=;
        b=vmX4v8Q7VhpBQ1/2Kt+iS3sUDaoJB/l2HL2dld5Zj81QstRq1f8vybuDSFbFILfkTk
         UWALLT63rr/t0dGMWvf6zVHVS3hv3jxvFV9NvvjCN7y5zzv6vJTerZhTBvm7JwwSDaUI
         T0owVPqf7K8MQjnlNOVolJGBMrquOuZ8HZiS9vIY66UQ/ssWA9ZZSPgSieRR8Wmz/UFq
         adOayRtRkYm1p7BsxEyoPCJhVpbE/su1STnzUExzwzTen3gceUuBCepUgkg081XVt8hC
         rE9u6EPheb5X1Q5oXR88Qv9877l95I4/cuo6ASaJVFJATFtQdmxk7MnKUaMNeimBrG2d
         40Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVTsn3JrE0xCzKxEIFPFCRX+2ZHB2A+RQMLlNIrkCR4hAgeu+jjlc+Waseq3VxsvPagW5j7cGxYRIbnPGq33srFbFCAkucDgNMFoItn
X-Gm-Message-State: AOJu0YzDD8C7tucEULbCckdo7NYVmUh4KGSh4F/Nytwf/sE0vPeMHU9Y
	B4/XkJxO7DYQLhjchx8mxDs55i/YteI36fcJJSeaGpu2t3k1z5vG
X-Google-Smtp-Source: AGHT+IE10OrRu4H+PUfT8kK7+rl/B+sTFjZWko/bwghxSxLqBq4Qee95eoS+eYZvO4HV1B/C/1MKCw==
X-Received: by 2002:a05:6a20:d493:b0:19e:3ccd:6f86 with SMTP id im19-20020a056a20d49300b0019e3ccd6f86mr18420855pzb.43.1708404163715;
        Mon, 19 Feb 2024 20:42:43 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a5bd:9c11:af2b:aecf])
        by smtp.gmail.com with ESMTPSA id f9-20020a17090274c900b001d9eefef30csm5195923plt.6.2024.02.19.20.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 20:42:43 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To: davem@davemloft.net,
	herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 2/2] crypto: iaa - fix the missing CRYPTO_ALG_ASYNC in cra_flags
Date: Tue, 20 Feb 2024 17:42:22 +1300
Message-Id: <20240220044222.197614-2-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220044222.197614-1-v-songbaohua@oppo.com>
References: <20240220044222.197614-1-v-songbaohua@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing CRYPTO_ALG_ASYNC flag since intel iaa driver
works asynchronously.

Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
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


