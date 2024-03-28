Return-Path: <linux-kernel+bounces-122870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FAE88FEBE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E759028D767
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60CE7EF02;
	Thu, 28 Mar 2024 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbAptNwU"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D667E799
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627973; cv=none; b=VX5St+abRl/Cehs5jquHXX2ptUyrcyeMz4P6RbOIhq4pm3g9Sg0Ij7fOnBSBGEZJdXJTgkj2tFTMuLhiK/YccWkYkqYGKOmnnjrbG2pN3gg03EFV8mvfMVb4Qc0iTwlSTuTePwVP2ZgsMQ111TXrhGQkeVUorC20AUryBQ62lRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627973; c=relaxed/simple;
	bh=eQPwDOS/et2gGh2U5lbLbgdW+2Fr6vfgAdlGcEfpeUU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A5w/hQAbJ0iHJlRmNWb1ac2LdTq4uSQSUdPPxWq64K/nxZxJhdD+vzYJf7NOkk2Y3ehYQ+RdIK7zHOJtkmO8DqyxGwrCHJXBV4cC5jGEyH+fhdFvw5WGiNtyiOS/TDuMlCyLzrFIgQ+r7PdS/NP0wilazaknh8ugWZbhafxIybY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbAptNwU; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d6c220a377so10151921fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711627969; x=1712232769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IHDJ6rlEEebln0ELZLhFxdjJ4IMCGnn3th1c8YTYOtw=;
        b=GbAptNwU6lMCNGXbqhRLu8kZXW8Fr2UX8ZIdTulIeuB5JvRaNtYULUU6dL+bUyj+WS
         h21Uacel5lLvUqaWf1smzM7MmFV/MgxU6xLO8Bpa5GcZ4E/CnaCsI5CVQINnCnrbaLgO
         xzI/oNC+x7xbHa7BkBdJUyntLoBuDkvJULMioXPiP5FP1H89PPB6P0HBeOwuQadQ8v3v
         k9v+1lW/QkEfN9k4hBWsqvfcIkVODuErpE5Vt/xEXSK4WyO2/C0nvb2LRDlFZjYqqdns
         6PfMYDWu8jj1uTHsu199Oqlsj2El/tIVfRRHFK/Iver/pyEyvwfv3oazjACqN9Yol/Qb
         WE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711627969; x=1712232769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IHDJ6rlEEebln0ELZLhFxdjJ4IMCGnn3th1c8YTYOtw=;
        b=WWhIbKx+xR/t82jjgi4Dc/3t56fSiFKP7oehzi75JL7PKy2kO78AV1XFXQwNoG10EQ
         U993Fvv0mChfhd72n2HG6r8WJnf6E3Oc53JUEl4MO1rDjQ7dAO12fI/nkwzJSsIXYP1s
         otK0BnqFxKtuOKS0NLExgFbT6FCy2xizI3SM+wKpXjbvChEApD10Zt1dyhrV9bdAf5tv
         neh76pFLcDlLjYi/pwMwpmDi/mpG8wZgXCNLVeDlEYzYMFB8XLaKR8/AoMOgDymuCjIr
         ETd2HGnNV4ixLkt3+yyMiPAtuvkzqztsn3owC12QV+5TiGr7SMkw1PdYqRvmf+1lgbvE
         4gmA==
X-Forwarded-Encrypted: i=1; AJvYcCX3zRHgUFwGXPp/rYLae9mrXWRNbcECcXuwjM5CKwK5N0WFZ2BAloJikdwQi5ybBYnI72pjpr2DBJYA9hfRiCO2M3ygJgVymo5eq5cs
X-Gm-Message-State: AOJu0YxEP2jKnH6WS9Jz4FO/7b1ZiuXQzbvMbmBA9PQscOVVXzq3CltL
	HlEYWLnw+EryloDkv5E+L/tVB76QqG7VHeYCuUwxGvubRxdDt5Ak4dtg0jjI
X-Google-Smtp-Source: AGHT+IHwlz6BzdFgPSHNY37ZWQvhFtbbZArhAgaM/MNTbOlDBkFm7N0qsXklr2nX7WXuUysQCuB+Dg==
X-Received: by 2002:a2e:6a18:0:b0:2d4:99f8:8b9f with SMTP id f24-20020a2e6a18000000b002d499f88b9fmr2235018ljc.50.1711627969345;
        Thu, 28 Mar 2024 05:12:49 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:736b:f200:125e:963c:4e4b:b7c5])
        by smtp.gmail.com with ESMTPSA id bd11-20020a05600c1f0b00b00415460a63ebsm1416456wmb.29.2024.03.28.05.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:12:48 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] staging: pi433: Rename vars, update param type & remove duplicated code.
Date: Thu, 28 Mar 2024 14:12:38 +0200
Message-Id: <20240328121244.1244719-1-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset improves readability & maintainability:
        - Rename device related vars.
        - Update pi433_receive param type.
        - Remove duplicated code in pi433_init.

Shahar Avidar (5):
  staging: pi433: Rename struct pi433_device buffer field to tx_buffer.
  staging: pi433: Rename struct pi433_device instances to pi433.
  staging: pi433: Replace pi433_receive param void type to struct
    pi433_device.
  staging: pi433: Rename "pi433_dev" of type "dev_t" to "pi433_devt"
  staging: pi433: Remove duplicated code using the "goto" error recovery
    scheme.

 drivers/staging/pi433/pi433_if.c | 690 +++++++++++++++----------------
 1 file changed, 345 insertions(+), 345 deletions(-)


base-commit: 20952655235dd9b1447829591774f1d8561f7c6a
prerequisite-patch-id: 91943193af2fea74182be67fb583235a3fbeb77b
prerequisite-patch-id: 2cad031ba6a0782a67ab1645ff034a8be65c2e76
prerequisite-patch-id: 1a852ed8f9d133aec7c651fd9007e59e39c55fb7
-- 
2.34.1


