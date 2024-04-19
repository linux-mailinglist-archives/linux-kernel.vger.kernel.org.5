Return-Path: <linux-kernel+bounces-151649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E398AB18D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E7DDB225EC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059C712F5B2;
	Fri, 19 Apr 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZpZWezQ+"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD00B12F585
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539886; cv=none; b=EGKIaBA5lnKl/WQe4sJQJ5gAuatQ+RqbG9TiGh2nNTzEhPqm8zcsGLop8U9YEIEpnxN4ckj2Kq9m4u7NlJAOnlvI7ZwufNst80ybuLBnrP9LiqPdlebENiIfyDfeoRKrnC1jtwiSiz4AVZRhVw4i+vfrZa5TLhyO7KAgYEgC28c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539886; c=relaxed/simple;
	bh=5/0w+7xhHbrR8SQruCxiXh9BC6LOxv6DX3Bpmvy8B5E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ArHCUmLXmi0jnoQ8j2D5yRQCx6KyG1coiF22NieJQIsnjviwZ/8KSPto577ov+l+5gtHtx82xPspZnnst35NuRmJ/uI13mwlTniQl26pVpsg1jnO1dcFL/S/pfS4uHR3vatQ/ECqCjPsfoF88cpG9Hl7MBAeJdBzgQ43rdonu3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZpZWezQ+; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d0262036afso81845939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713539884; x=1714144684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5TUCxK+gq1hZMcbtI1POUSVOx0x7lQqoinD0IAWm1/s=;
        b=ZpZWezQ+YoMilENS6zSpKH33IZ3swCwQ72BJtPEnTZUcZUI48aefaI2KkFB/uRlSrs
         JCMtgdTMQFWiJsstqVXM2sahwkkTQcYg3Cg7RzYzbjupcWEPGzISFFrDALi5qjP8l4/m
         bzzbVnwrdp6SWMc2nTWnEtcujdm2Xe0NYNM2mFJ5BR++movnQiDnCU/GNWU/76yhBNSk
         rOcEvxyvumaJnm8uhkNkB/lhHRB3pmhrKCK9/uQ/Lb+QshCiH+HWVVo2/lfmFTIWGCrX
         otCuuMxU9pVZgDrwbQkR5sSmvrkvsiPBhxan4yUVI+O8DuFeLEKUKcFfvW0Q9CkqWqhS
         fJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713539884; x=1714144684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TUCxK+gq1hZMcbtI1POUSVOx0x7lQqoinD0IAWm1/s=;
        b=Z8ezuwV42vvcWI7bK0sRKLe6N0Ekn/YNDntd/vrRoMLJvqjpYnrKZXO7nQgmoI3hMt
         M5w6hGVH1G+80nUOEYuBFAvAqQML/qXkl2iR/2wN0xfD6H9WR3RkCGgrn7OpSi+1XyRG
         3JKQ/I4GAHZA60i/fhF2c+jLFR4Q0CWYOHin+mcpOk985/HlNDh2A/DdBZsjBdsotc6D
         J7uJQlgPuFm25FkuNuY8C3Nrj7ERsJaTXsvtQw4hL8MeCJJcyKR77A+hn+H8Vnf/bnHi
         HFodecQr5EZvh9uC+E2vqnxZAobQJgi1zuKRW7zSzYdoM/VHfK3Fkx+zOMoL81i4uCoC
         IVYg==
X-Forwarded-Encrypted: i=1; AJvYcCU/xfx2XTNNewKd1Pm4+mxvPs28kmFuGoHyNCP8o7LRUpNC2vbEOpjPFqysDhSyKN1Qeo99vnM6JlrS0cIM44fu7VYUGiIEubvoF/6i
X-Gm-Message-State: AOJu0YyOZ3C2LgDh7KgisfegAKbsHRZnQw65NLPRg3+EJkPJQQKift+V
	fgG7DHXLWTocRnqBAn6fPmLa79qFSsGDCJfzaVz2c6LFvf+RVuUW5FI7V5Gfk4I=
X-Google-Smtp-Source: AGHT+IH0dmVlefrLZhr+LOHeIGHQZt0nGe6r8h49wxCpPAKq1DFAzY8daiE6lXPhT1uQ/Q4GDTMasQ==
X-Received: by 2002:a6b:f303:0:b0:7d9:9445:1992 with SMTP id m3-20020a6bf303000000b007d994451992mr2940801ioh.2.1713539884019;
        Fri, 19 Apr 2024 08:18:04 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id lc8-20020a056638958800b00484e9c7014bsm116126jab.153.2024.04.19.08.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:18:03 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/8] net: ipa: eight simple cleanups
Date: Fri, 19 Apr 2024 10:17:52 -0500
Message-Id: <20240419151800.2168903-1-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains a mix of cleanups, some dating back to
December, 2022.  Version 1 was based on an older version of
net-next/main; this version has simply been rebased.

The first two make it so the IPA SUSPEND interrupt only gets enabled
when necessary.  That make it possible in the third patch to call
device_init_wakeup() during an earlier phase of initialization, and
remove two functions.

The next patch removes IPA register definitions that are never used.
The fifth patch makes ipa_table_hash_support() a real function, so
the IPA structure only needs to be declared rather than defined when
that file is parsed.

The sixth patch fixes improper argument names in two function
declarations.  The seventh removes the declaration for a function
that does not exist, and makes ipa_cmd_init() actually get called.
And the last one eliminates ipa_version_supported(), in favor of
just deciding that if a device is probed because its compatible
matches, that device is assumed to be supported.

					-Alex

Alex Elder (8):
  net: ipa: maintain bitmap of suspend-enabled endpoints
  net: ipa: only enable the SUSPEND IPA interrupt when needed
  net: ipa: call device_init_wakeup() earlier
  net: ipa: remove unneeded FILT_ROUT_HASH_EN definitions
  net: ipa: make ipa_table_hash_support() a real function
  net: ipa: fix two bogus argument names
  net: ipa: fix two minor ipa_cmd problems
  net: ipa: kill ipa_version_supported()

 drivers/net/ipa/ipa_cmd.h            |  8 ------
 drivers/net/ipa/ipa_endpoint.h       |  6 ++---
 drivers/net/ipa/ipa_interrupt.c      | 38 +++++++++++++++++++++++++---
 drivers/net/ipa/ipa_main.c           | 16 +++---------
 drivers/net/ipa/ipa_power.c          | 19 --------------
 drivers/net/ipa/ipa_power.h          | 14 ----------
 drivers/net/ipa/ipa_table.c          |  8 +++++-
 drivers/net/ipa/ipa_table.h          |  7 ++---
 drivers/net/ipa/ipa_version.h        | 18 -------------
 drivers/net/ipa/reg/ipa_reg-v3.1.c   | 14 ----------
 drivers/net/ipa/reg/ipa_reg-v3.5.1.c | 14 ----------
 drivers/net/ipa/reg/ipa_reg-v4.11.c  | 14 ----------
 drivers/net/ipa/reg/ipa_reg-v4.5.c   | 14 ----------
 drivers/net/ipa/reg/ipa_reg-v4.7.c   | 14 ----------
 drivers/net/ipa/reg/ipa_reg-v4.9.c   | 14 ----------
 15 files changed, 51 insertions(+), 167 deletions(-)

-- 
2.40.1


