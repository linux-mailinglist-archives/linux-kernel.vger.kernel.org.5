Return-Path: <linux-kernel+bounces-58345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0BC84E4F8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5858328EC39
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF3D7E774;
	Thu,  8 Feb 2024 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+i050Xj"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0987D41A;
	Thu,  8 Feb 2024 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409406; cv=none; b=cbvA5MzLEjDMWyLAYm/u7L98QxFfaT3WO0MsjfZRIxvEd95jH6EjPCxXzZkhBrWn1+23gKe6yMpy7hbA8+SutC88u9uPyb38p1BQ5aUdm61qQbSyafN3f/cRywdh8KQZgdmxIbBdNNsgqOUqidl95ekp9kbq/akGZtlFM0vnbPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409406; c=relaxed/simple;
	bh=XSbI4p8cfTNAnfz90m6UvSOBjVQtI0cNaq7RlLExBCg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mebO0nT/p9bBydCzmktVsSIm8AZLLM5SfXj/gbujdt3HeHvhtvd0OIcmLArTDlGQjESX8+gLpQcwqSxRZ/TvDjJEOZ7PURdXlD+pfyWDo1hTOi2mK7JenKKVmo2ftxc43vwCCNuotaK3GfCjcQZi5Jx/8Xkhj7aOssiqGvRgJW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+i050Xj; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5116bf4dcf4so1472005e87.0;
        Thu, 08 Feb 2024 08:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707409402; x=1708014202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5fHV9+zIO+0IkutaijdwO8mXBVrGFAikLKk07NhjxfQ=;
        b=G+i050Xjlk0K3h9yeQM9B+cRyjdmeJZwIL27BW2PM91J7Gh2rrTB0qin4ZqMODF9x4
         Rgrq9JGivqRMFwE0noPGTIpYt3JiZOH6DwLIBtYLO4UIS8rhFRWX1v5yYRh7cjKFuNO2
         rZ4X1KJi/7Ny7nnlCftzTJDlnYPpxtDzh/B/Chs7QxJMHb+2vI2gkjp/7vvm6wE5hmQp
         Tj4NBS6NyhLPxSTs3Qspu7UQA2pzqAL4yFwYDtEdDq3niI/EARZmZu/QRA/ucmJmTG0I
         pr4HiQgq5WU2shitKtg2dv64cLcN58iKKUUlBNZpYqIuo1h5gSFktkv5aSZ5b3fcqpAV
         f/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707409402; x=1708014202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fHV9+zIO+0IkutaijdwO8mXBVrGFAikLKk07NhjxfQ=;
        b=Uq7qHIja1/CuGECOc9lnzka+bZFO7qtnUtlsCgSUeuVC8y5Dt4AmB38swarr4pZHcG
         nyObuDu1IhADLeWsMXFK99fBBEgsqbfAEJTLoZ4bVFeaasuZVlYZXyjs8wS2PzOd4qOE
         /go+6JlWYXGqGQX6EMqj8lwMM1M9u6XdPtPC8L03urJUB948HzxflxmKmEYUAthSrtGu
         gJpb5te2+Zyt7f2FcfefIyakjcwPfuEjb2dw4zKC5cIOSegZdzyBabbeaFo65iM3YeKN
         A9fWAmVriuUiluKiLtcOyHHAntklLt0LKXtn+eVZBIMfQrFGqETO+uSXu+ub4MZMXml3
         jZNQ==
X-Gm-Message-State: AOJu0YzZttofHuGAdJmiBV8U8ybv1ZStdwoE5HIitvPlYu577Yw9nh0Q
	nOb6+Pd8MmyTa+biyVNgu9JjBp/OCoSR5epus+nrgYn1PtZJs5qL
X-Google-Smtp-Source: AGHT+IEVDNJO8itB6REMJMyJRNrZeTPaWCuL8J2Q9W8E0E24Ms2e7G7zRtB9CXlYio2hR2dXhiAmpg==
X-Received: by 2002:ac2:46cc:0:b0:511:42b5:5616 with SMTP id p12-20020ac246cc000000b0051142b55616mr6494596lfo.17.1707409402301;
        Thu, 08 Feb 2024 08:23:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXFYwmNfpCeGaVHYlN/mOivVUxMbr4GNh5eUn02YEfoPQEsPWeL8onjqmzuDEyJxGWo30hl3t4Yv8l1O+WP2WPrKiBIjFwLKwfpcmSPETHNi0Sgi4Rrc40rM8Unsl8RaqFf8YFeOQSUSxtCH61fftK+wX/KaEQFoNzZpK+fqr3ujYDjpg==
Received: from sacco-Inspiron-5559.. (88-160-103-158.subs.proxad.net. [88.160.103.158])
        by smtp.gmail.com with ESMTPSA id x5-20020ac24885000000b0051152c32fdfsm39852lfc.267.2024.02.08.08.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:23:21 -0800 (PST)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [PATCH] docs: media: fix typo in docs
Date: Thu,  8 Feb 2024 17:23:17 +0100
Message-Id: <20240208162317.109915-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch resolves a spelling error in the documentation.

It is submitted as part of my application to the "Linux Kernel Bug
Fixing Spring Unpaid 2024" mentorship program of the Linux Kernel
Foundation.

Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
 Documentation/driver-api/media/v4l2-subdev.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/media/v4l2-subdev.rst b/Documentation/driver-api/media/v4l2-subdev.rst
index 1db2ba27c54c..13aec460e802 100644
--- a/Documentation/driver-api/media/v4l2-subdev.rst
+++ b/Documentation/driver-api/media/v4l2-subdev.rst
@@ -229,7 +229,7 @@ Asynchronous sub-device notifier for sub-devices
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 A driver that registers an asynchronous sub-device may also register an
-asynchronous notifier. This is called an asynchronous sub-device notifier andthe
+asynchronous notifier. This is called an asynchronous sub-device notifier and the
 process is similar to that of a bridge driver apart from that the notifier is
 initialised using :c:func:`v4l2_async_subdev_nf_init` instead. A sub-device
 notifier may complete only after the V4L2 device becomes available, i.e. there's
-- 
2.34.1


