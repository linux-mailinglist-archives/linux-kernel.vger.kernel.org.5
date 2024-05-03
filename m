Return-Path: <linux-kernel+bounces-168015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D63788BB269
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F6C28293F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5237157A5A;
	Fri,  3 May 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j92tM54n"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047D515887C
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760108; cv=none; b=BxMPd5BXE75lkfuYC7AghLENGjkp12YXEvjm6xxB5bvZdBL2loEFDas4rW0RRkcqRtedeaQZDd9e7WwwqNPiDMg6vaWYvYB9P36B46UhAr52ooqWizpfRNwTS2gOweLpm3YDUjvBrMBux2JMlz7cqqdVeiBo3MCd8tFfuhZwpu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760108; c=relaxed/simple;
	bh=b7uOun1ntNdzPOKIgV03PceTfRzyuh2qAoZEj2CCG+U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a8u/9fR+FWfp1p63xabq5L769q6H5q9ThClnH3o8037/oAtWnZKUTwtYkEcjgoOOlRoPSoXr9SuScZhU6mf926GZLHmoeyv3jk1+3bKCnQO2FdxvWfJQfM4ChgQ0MxAzgBt69Pl9QBL9pu7Zt7rAwBq78L3x56TvcfUjx02VON0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j92tM54n; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2dd6c14d000so116444941fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714760105; x=1715364905; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6VHpW3YwQdLN/LIIhzeDsDWWk0Ue/DwBQ65FA5shOuA=;
        b=j92tM54nEnlBXO3+u84PagaITn+4xdQjA7duiO51/OppmA5tWROxq9stHNvTcSaj5I
         jgrcS5FlWhz/4fOXXYdwt+rAEbuQOJfPFzgeUXO/Fd8OeOekp5v0ZNtdul2L+RhVg8bD
         BLkA2P3fbzZQSPNjsO7rSu1pCTuXRXAKI5WsxpTFG4bzHfttob8rusD3waMCRFTIhD39
         JYuDBBG3q3Nkq0wT9qtKKpxC407sAzHdiUSOUK37wouIzcm4ZVEAiMic2YgGxizwBTkJ
         0e0mYS2DO2fakTxwHatdXTkbEaJGFTwncDyIKsJfA8riAaaPWevFqgjezBXPYqgcqtVH
         13Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714760105; x=1715364905;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VHpW3YwQdLN/LIIhzeDsDWWk0Ue/DwBQ65FA5shOuA=;
        b=jUVjOTVLFGQp2rBw6ob4X2pvS9T4BJDZTFPi7+7Lwv9gicfPUF7SmYi4ncymXJqZSg
         uMy5kucab8MnfBiCLV9xHDLUr5YePllD/cFFEPrCKByJ0iES8XMY6RGHj+OurR/6pW9B
         sUWV3nD0/xw1eRhSunEaabLqy1pOnRm024ExWO6o+O20cUUppdo0XqO2cciXZoADORDg
         PT17DsDzbiUY308ZtUF0sxM0Q5ul6OovBe/ThBE6z8OgimYPWObjQMogUCLFHIDNAiup
         AUBswQumqgR7jvRxPBQYXBS7NB78qHsPoPFYB4/vw0zonQXddUXUB8wpk8UYVzntIek6
         BvBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdC6z4JxETwKelFW4Xo3kudEjBfV1VdBDBPzgiEPkzQzCoh1oXqC/edr4zf/1XkRR+ufEFkQ7qyk8k2UVpfhYY8PGY3VS3PycTraT1
X-Gm-Message-State: AOJu0YyjkUzPIg5rnNEPMpBEtQ1jgMZd3hQypQK9JczmT9BovNIEc3CM
	lyQyXUQ0DuoGBBx434TpG+v3pUOU3+UYSGB3fWPt4GtqaZfp69FhJxmbbiE8balA6PBfTRS829Z
	ymJI=
X-Google-Smtp-Source: AGHT+IG270X7V/CPMT0cBVd0CUNrSK1X11hI+m8mqCij2hT0ErOlBIlX6u6taZn8Okcumuf+hZtf/Q==
X-Received: by 2002:a2e:b385:0:b0:2e1:bd06:51b0 with SMTP id f5-20020a2eb385000000b002e1bd0651b0mr2559625lje.35.1714760105181;
        Fri, 03 May 2024 11:15:05 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id s7-20020a2e9c07000000b002de118decbbsm605548lji.53.2024.05.03.11.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:15:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 0/2] drm/msm/gen_header: allow skipping the validation
Date: Fri, 03 May 2024 21:15:02 +0300
Message-Id: <20240503-fd-fix-lxml-v2-0-f80a60ce21a1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKYpNWYC/22MQQ7CIBBFr9LM2jFQkYir3sN00cDQToJgwDQ1D
 XcXu3b5/s97OxTKTAXu3Q6ZVi6cYoP+1IFdpjgTsmsMveiVUMKgd+h5w7A9AxJZq40yXiuCZrw
 yte+oPcbGC5d3yp8jvsrf+r+zSpRIV3sRwmkr7W0IHKeczinPMNZav+uC+CqnAAAA
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Helen Koike <helen.koike@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=b7uOun1ntNdzPOKIgV03PceTfRzyuh2qAoZEj2CCG+U=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmNSmn1LRPvp7NI+bsZssbP+ut3TuZL6Yc4tpig
 T9NM2DLbJ6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZjUppwAKCRCLPIo+Aiko
 1XEZCAChGQwzME/xcgNIXEa1YQRSf9nPsFpkjNFwkng3JTq7gJoKSB+KtK0yw/ZxZjVdh5geZzy
 895HYO1C5z9R0cmLb3j9RZ7xxWZyx9H7KVfQ42xbwP4IcMP/KGLI7k5xwOKRqxqT/zf6zlNDps6
 nsxOCkfXILrhSCUvZYZvEv8taBq3IuuJ4Cki3m/4y1jLtgD+zPHf5ItSWEcL+g3zC5uxS0ysRnP
 coMbWIi21rZZDCDMEq534giV7AFtqnaBIaJU5pLMUgjWhtfrCPKmMiRx2CKupcinWfcjdXI8ny3
 vTGY4fDmV53N3n0td6d/B03Dsnko3NaKgCv4XLmERrNHL+8a
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

In order to remove pointless messages regarding missing lxml, skip
validation of MSM register files against the schema. Only the driver
developers really care and/or can fix the files.

Keep the validation enabled during one of DRM CI stages, so that we
still catch errors, introduced by mistake.

To: Rob Clark <robdclark@gmail.com>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: David Airlie <airlied@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
To: Helen Koike <helen.koike@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Changes in v2:
- added validation of XML files agains schema in in DRM CI
- Link to v1: https://lore.kernel.org/r/20240409-fd-fix-lxml-v1-1-e5c300d6c1c8@linaro.org

---
Dmitry Baryshkov (2):
      drm/msm/gen_header: allow skipping the validation
      drm/ci: validate drm/msm XML register files against schema

 drivers/gpu/drm/ci/build.sh                 |  3 +++
 drivers/gpu/drm/ci/build.yml                |  1 +
 drivers/gpu/drm/msm/Kconfig                 |  8 ++++++++
 drivers/gpu/drm/msm/Makefile                |  9 ++++++++-
 drivers/gpu/drm/msm/registers/gen_header.py | 14 +++++++++++---
 5 files changed, 31 insertions(+), 4 deletions(-)
---
base-commit: 104e548a7c97da24224b375632fca0fc8b64c0db
change-id: 20240409-fd-fix-lxml-eecc6949f64e

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


