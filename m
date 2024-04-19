Return-Path: <linux-kernel+bounces-151656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1548AB1A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9318C283EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DBB13440D;
	Fri, 19 Apr 2024 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kl1XPb4v"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F940131180
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539894; cv=none; b=Amq7ya3kLaLzYDx5UpPe500IA9kFoXxdoDOuhjktDbyVYPURnhROPgKKwP7i4JquugAPdA8c4/dei+Pwlqtb/uuIJ/61ewwPqEKCSUPFMqOb/C9/V+TAo6fS4nxQPAZdkOCZvHu4q3znRftJSV5xa2ihEjfkzRWAbTWb2oLPmMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539894; c=relaxed/simple;
	bh=erv4VXroO0M21slKGUyDFXCqBxmjZSFL8Sl5lqDo4rY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AYv2qrgu2xWIrXiBDBCe1F+5YPv34CpYoPdjirArbNgW30coB9B493xbTQ8FbsXXFQk9AZBz8Rc1FiUBb6I6LuwTJHDVLunTAiWSCY3OuWzrIfjhf5khMKRXQbhW9dNWDebXVimzN77Tz8seoCBb+/Py/GVxAjfv/NXLzbemeTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kl1XPb4v; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7da382f57a5so63518239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713539891; x=1714144691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwnKPG2Aybimx/N3MD6w+czRD9+BNJvZbpMTIj3AUuA=;
        b=kl1XPb4vePOvoPx1YiVC+9UC8u+4l4xrn6Sx5P1ftQO0m5EEojo9VrGyRKIsEFgUvh
         4JcPSsgto1PdAFu9Uh/Q+FBTLgkYj57op+6b6FnRKuah/uqrDBQL9AQJJ8SjX9M+P2i5
         u2gXoCDixfRrjDCEei0VU1+D2Mmgdmy1bD5Am9qI2j9htoEvWTcmpbTiI14xoFoJ2suY
         DxJIYD1GI5I8/ODdJQJFfWo9WCu7gCijYqErXZ4nG/s3dmRVbCy1Jzw5ACoMpp6l7tfN
         rnU2yyd0ZbMU3kYygaETXuOr/HR5qfRdAmWQtEHCcSm+vFDPC1On3UpvnSl4wZv9Bevo
         sKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713539891; x=1714144691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwnKPG2Aybimx/N3MD6w+czRD9+BNJvZbpMTIj3AUuA=;
        b=iOZfnEvRd0Mdjgw+mR4/1wzKQ8oYkoFdfE1BNfN31sjS8Im3z6Pw+tnKWI4LjIXZcm
         PracF0pTGsIl8g5XnHhq5w1XYTSQwnMtCdqAIvGZaCRSOjdrco7utb29vJq1tljNTJil
         q+SNx/my2KZX0Denb/pMhZ/sbl8Je0uLLPc8U1NqszzpQEBzvqSbx8QnGGXrD8CAEm8S
         bEjwRVRsr/QKk4DFiKmbq1X7NweNuTw8wUAQZwiagXbz7EAuwiGEzWWjyCcaa/YXEQDm
         j7Nx3kqZvrnWmec/WuDm8JeE/1lghSYCvJOsXVa8iibic87V3/QzpM2goLNcqYFlMy3M
         e3SA==
X-Forwarded-Encrypted: i=1; AJvYcCUOeIQQszTD7cIYY36o0gRT+/Sp5R4/xfBL85KTcbxW01ANRM3uIDXDDX+JGATOAe/6X7p4Mo4jydwcdnYv9JCWWxQvB4gwveaArfHv
X-Gm-Message-State: AOJu0Ywr1qp3IhP9yYuNSAsgJvEhh6nCHbP9m+CP7gUylEU3d7Mi1s0A
	I98FU9ShKp1qREDEhydvcRcvS6L0P0PiptaneqhW3pG/djTvFgQRbvT8JNPnyuw=
X-Google-Smtp-Source: AGHT+IE9uu6ak6BSrNZjfqIaY8j4SEnqF00T+KY3FChxz87UgQ+A6nXOPiLVnowpl6k8ZRP6dhGsAQ==
X-Received: by 2002:a6b:6c0e:0:b0:7d5:d60b:c425 with SMTP id a14-20020a6b6c0e000000b007d5d60bc425mr2679541ioh.19.1713539890773;
        Fri, 19 Apr 2024 08:18:10 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id lc8-20020a056638958800b00484e9c7014bsm116126jab.153.2024.04.19.08.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:18:10 -0700 (PDT)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 6/8] net: ipa: fix two bogus argument names
Date: Fri, 19 Apr 2024 10:17:58 -0500
Message-Id: <20240419151800.2168903-7-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240419151800.2168903-1-elder@linaro.org>
References: <20240419151800.2168903-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "ipa_endpoint.h", two function declarations have bogus argument
names.  Fix these.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.h b/drivers/net/ipa/ipa_endpoint.h
index 328b90dfd1695..e7d8ae6c6f6a6 100644
--- a/drivers/net/ipa/ipa_endpoint.h
+++ b/drivers/net/ipa/ipa_endpoint.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2019-2023 Linaro Ltd.
+ * Copyright (C) 2019-2024 Linaro Ltd.
  */
 #ifndef _IPA_ENDPOINT_H_
 #define _IPA_ENDPOINT_H_
@@ -199,9 +199,9 @@ int ipa_endpoint_init(struct ipa *ipa, u32 count,
 		      const struct ipa_gsi_endpoint_data *data);
 void ipa_endpoint_exit(struct ipa *ipa);
 
-void ipa_endpoint_trans_complete(struct ipa_endpoint *ipa,
+void ipa_endpoint_trans_complete(struct ipa_endpoint *endpoint,
 				 struct gsi_trans *trans);
-void ipa_endpoint_trans_release(struct ipa_endpoint *ipa,
+void ipa_endpoint_trans_release(struct ipa_endpoint *endpoint,
 				struct gsi_trans *trans);
 
 #endif /* _IPA_ENDPOINT_H_ */
-- 
2.40.1


