Return-Path: <linux-kernel+bounces-156651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BE18B0646
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA6EB262D2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC2E158DC2;
	Wed, 24 Apr 2024 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk85HtE1"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E12158A29;
	Wed, 24 Apr 2024 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951747; cv=none; b=mk3T5/4urcqriOfEc/Tnn+FtU51Tl4ssoXz2/C47eWKp4HICq3Jf2UVFbYntALM3uAYjavuWq41wARAA/mvFZYWSNPZb7NMnIimxEIgKZ+y0zI+H/sSYjTIk8N1qis5mHYhxBZt7od648OL97OF9+rcZFbnY0Jc2PZHb8lwgvGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951747; c=relaxed/simple;
	bh=pdUM2PQ6lmcQ67mgawtuU1EkP4dhP3YHKQUjHS9V2qA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q29T0DFnwUKO+moiOpt+S/kQXmdtZ8mF8q03tNyGYxoF67yZrRr1AALGiOJASLfyqMaIONJfDLtgrVg04BADgNSi7zBFjC+azTl4kxHmQlIBqg7F0HE3OICa2JUSM1SjVAgNW5YiT0uFUh/GxRuANFr2Ds6NddE8km1GWmIG4Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qk85HtE1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34b66f0500aso1665261f8f.3;
        Wed, 24 Apr 2024 02:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713951743; x=1714556543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OZ1WcXyOys5YIDWCRIW5mC14e4vDyGa7xvoVt1+JFn8=;
        b=Qk85HtE1yOgELGZfTIz9Hsze9GS5tcnwo9WATyy4F7pqxNfj8GaHjrCLirKkzz/hKw
         G3lDsJEekhVc016LGr3xykDoEptG0sUlpgTPYz7BcAObG4J3GoSiDkBvsy6ZtsiZxS8b
         HMsnK+kRJoF91a+AFZmDsJh50HgfiXbAGEswJ0GZd1ovkPzZNOn7foH9wD8r0wHeMx6M
         w86dHhY2PbS5w70lZxW0oobQ3OD9AQ/uT+EW+abQVKHfrMLR3n8X7kfE9vbBfCOBRfmW
         B+6bbgiR/XxHtRKJgMX7YGOqXH5iqRPLjAumtzVS91Tpu3L2STrSPJDwBebuuM45FKnZ
         ONEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713951743; x=1714556543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZ1WcXyOys5YIDWCRIW5mC14e4vDyGa7xvoVt1+JFn8=;
        b=wA60arQHyvy9YFct1sr+aw2P9eAKHAGfnT/Uww1HBjdiy9sEC6KTycAktcInTznoCW
         LAButvcgM5oo9GQhQMH2QYmkMD0yWsAt+3hwRcGBbaAxP3rL9SrpyCU6O66nBIvZsQLI
         /5cdToLPfuir0/d8jHZ+wP/KTauV5bMuqCOc3hNyQT98lKcbQm1GFG2N0rNrlESgpy0Z
         nvG9TH0iRQZBfKt00UDv17SNStzSY1dTVfbCESBWrXWZTRDjCbAdPVkUbuSRZaFAY7Zb
         VxFaJdvCt6ww1hCrVn9sZmXRHldy6jfHjAHRFI4TsOHRuO/+55RwQxq4VT4WEPfcjvwr
         1VHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnfVJ3nscCkjMPmYOgGDA6Am6bmHKPc810M/9MOUNQeyf+jtcx0ghkIooHbolOSiDeL2Rsq5XGvd4O7NlfWSRqOOivPVZQzHEzKyJQpE8KfD7CgZPC5/+lW5UJCEoeZa3HmD5x
X-Gm-Message-State: AOJu0YzF3w4+5L8PUzgoowP7JLq1QpmGz/HtyWieXQmplC+BCXBU3HWa
	aJ36a61WNxB8oUgRUISp3LumK4xlDR3IU3Y9A4x/hYMny5xyfYwUJ0EtqS/H
X-Google-Smtp-Source: AGHT+IE9NZ/+nqIl5BW8fpYLEBP5nud8cGXZ3FcNjn3Pr4uGBSO+WLjwtOAW5sy6nLi2HbHzKQnTHA==
X-Received: by 2002:a5d:5449:0:b0:34a:a836:b940 with SMTP id w9-20020a5d5449000000b0034aa836b940mr1088278wrv.18.1713951743201;
        Wed, 24 Apr 2024 02:42:23 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:320d:e800:6acb:a317:3d30:4165])
        by smtp.gmail.com with ESMTPSA id a12-20020adfed0c000000b0034635bd6ba5sm16683339wro.92.2024.04.24.02.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 02:42:22 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
X-Google-Original-From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	corbet@lwn.net
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH 0/1] adis16475 documentation fixes
Date: Wed, 24 Apr 2024 12:41:51 +0300
Message-Id: <20240424094152.103667-1-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove in_accel_calibbias_x and in_anglvel_calibbias_x device files
description, as they do not exist and were added by mistake.
Add correct naming for in_accel_y_calibbias and in_anglvel_y_calibbias
device files and update their description.

Ramona Gradinariu (1):
  docs: iio: adis16475: fix device files tables

 Documentation/iio/adis16475.rst | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--
2.34.1


