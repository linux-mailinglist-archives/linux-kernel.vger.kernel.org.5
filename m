Return-Path: <linux-kernel+bounces-70084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F16598592E3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A9E284631
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0D07F490;
	Sat, 17 Feb 2024 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awGcIIQa"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303E37E760
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708204420; cv=none; b=dVwD4ij4JXeAPqZrTagEi3zO4xMtpDq4mqMPzSEwU0cL46agu9V7zi4dW4myDglwtImzUDBjps7D9HTJUUnfMbgbO8MI3ggzMzLQUaHJOYrI4rAyLmfyfL9WXxamFfQOk3BrOv/H8Oadp9pOFqktBxVR8lU5Nw3X/6ep30qEGPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708204420; c=relaxed/simple;
	bh=AfmadviaZrb80S8i4Kp9Csah0gTIVUeuICCrJzeMHAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pg/gAQPhEbBo6yPtnDnW4VwQnlFvN8wK6nnhCKUa/aiFfp5JCzgLR9BggVFJXOCWUECU1ja/zpyUt4GYg8TY0Bwf6bFcid+UXQT06MZr2jc8JXG5/pB/VDdKoH0o3MQ4iO3zZ0/yITZ2WA285i0N8Z0v+3ro+00IXkD1pJPE4Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awGcIIQa; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d0b4ea773eso40022191fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708204417; x=1708809217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CRq8R2Pi0gMvJE/RQYPcDF05WRnk+6fZqPWux/HjP0=;
        b=awGcIIQakUWgqP4XG8B09y2eWStCR54JKaq/FoFH/ciiCLt0V8+to6HUGMSW/dTcWm
         +OeHHy/kdNHdnuII1n5HIkQHsL4v04cA8qv7clZeb99noqRlJ0lx1pk8LxL39vliaLN/
         /PcjUQdLo0nIo7EvmaIuTmdYs95QIvMc9y87kSBi0L8L3vYG7uuG+PK7TZs3q9c+szlI
         IXas7CS4w9Ifx//ow4Rzjg9krC8lZF7Nz6lNJFPWXtEeVBIjRXQbn7lgZ3Zyg/M0ddgz
         9GS1NE1xi0ZSAIK1FI8TkndIQXdU0vCJWGtL/vMybTlgBkeMdIxlsCfP0zLhAibvqwEm
         IqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708204417; x=1708809217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CRq8R2Pi0gMvJE/RQYPcDF05WRnk+6fZqPWux/HjP0=;
        b=CNnrSCgEpLePQnd7u6mvDCth9zULocUbwHi1T0fmr5O6mQzgbs6wcvn8EwLcvi/td6
         BdXxI9OWHykaWR6DEMfBXktfC++L/mU7Z7mkUd1Oe7cbdF95VdL/goX0Dx2SNP5U4whr
         dHox1CtPux8TzJdNfubPI/WN4av/YEMmRa0Gv9xBAGFFn1lUGfVBiy9vriJTpPvVcQSB
         V1Tc0rHfT4GMax7xtmCwkrC7IBtCYCNarwx3VFSPTEn/k9XzPmqUV1VxwqJU7/MTcQZF
         srUkmyQR9KKP/C9A9Epm5eh+vE7U6Sxugs4F6hSNsYr2j8Yw2yBHgwOJoBH9iIIDDOSn
         X2fw==
X-Forwarded-Encrypted: i=1; AJvYcCU35P8nAedkK/0GbT0eLtZgAqFUz4NcQbrbhZPS+4pLtGi4ZcC4VuTwwvARi6N/ekcSpfhs2bedCWBjkuOp9JKZhyf0+8P3WTgjRiYp
X-Gm-Message-State: AOJu0YxqyuwXTLtt7+23QraJ92GTOBVlYj9EN4t/03pxRwTAft8YFO/c
	Lak8vncPjem9O/kye452dDIe8AnmfbhrS8cWNzcfKrPr35C9/Es7
X-Google-Smtp-Source: AGHT+IHBIpJly84pRoYl5qk8+XBduxwSsgGqNE2taaG3NpJKHeObZGBiwLsUq0GomCR1dIpbfBgxYA==
X-Received: by 2002:a05:651c:1a29:b0:2d2:912:916b with SMTP id by41-20020a05651c1a2900b002d20912916bmr6743449ljb.24.1708204417266;
        Sat, 17 Feb 2024 13:13:37 -0800 (PST)
Received: from pinguine.lan (ip-176-198-146-182.um43.pools.vodafone-ip.de. [176.198.146.182])
        by smtp.gmail.com with ESMTPSA id n3-20020a05640206c300b005644eca3befsm132087edy.85.2024.02.17.13.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 13:13:37 -0800 (PST)
From: "Moritz C. Weber" <mo.c.weber@gmail.com>
To: florian.fainelli@broadcom.com
Cc: linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Moritz C. Weber" <mo.c.weber@gmail.com>
Subject: [PATCH v2 2/8] Staging: vc04_services: bcm2835-camera: fix brace code style check
Date: Sat, 17 Feb 2024 22:12:40 +0100
Message-Id: <20240217211246.28882-3-mo.c.weber@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240217211246.28882-1-mo.c.weber@gmail.com>
References: <20240217211246.28882-1-mo.c.weber@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reformat function parameters to fix checkpatch check:
Increase readability and consistency

Signed-off-by: Moritz C. Weber <mo.c.weber@gmail.com>
---
 .../vc04_services/bcm2835-camera/bcm2835-camera.c     | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 05e5e4ab1..1fa868163 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -405,12 +405,11 @@ static void buffer_cb(struct vchiq_mmal_instance *instance,
 	    is_capturing(dev)) {
 		v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
 			 "Grab another frame as buffer has EOS");
-		vchiq_mmal_port_parameter_set(
-			instance,
-			dev->capture.camera_port,
-			MMAL_PARAMETER_CAPTURE,
-			&dev->capture.frame_count,
-			sizeof(dev->capture.frame_count));
+		vchiq_mmal_port_parameter_set(instance,
+					      dev->capture.camera_port,
+					      MMAL_PARAMETER_CAPTURE,
+					      &dev->capture.frame_count,
+					      sizeof(dev->capture.frame_count));
 	}
 }
 
-- 
2.30.2


