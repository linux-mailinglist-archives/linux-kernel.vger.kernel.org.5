Return-Path: <linux-kernel+bounces-70090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A073F8592E9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B771F21FE2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D82B8121F;
	Sat, 17 Feb 2024 21:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X25I27RW"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33997F7F4
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708204424; cv=none; b=tb9vDhWK/YP1/rE5Ek8bBnWClC3h63BgQCHPYHIG4FjRT1Jl882tTU3UbqWrUJcZilSogNgYYk34Ewba5JN0YSb1jC/TP+f3PmaWhjWzAaUTeOaDrVHLZ+n0PINiXW6recUPc5O9VCAt46kLBTkD/xPgHv7g3Va1fLMPpUVIECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708204424; c=relaxed/simple;
	bh=Egs5AAdslHfC4udI6Z6vOJIl9ypQt5Bm3xmTh5+bEAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LTg3X8pgMF6W+CairKAAxm+0z/K3elzd1WVe5yJhVbst41osYIhTtmIOTpPlnizjzeeykPu1A7CUS9zSKDaZlatnssjIER8r/F8C1bkyp47H8X6gBDcB/+sQYe/XO7IYWIWJt/FEX0sJnneRcIK0+kAojCkKl/KrMmnAJveO9XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X25I27RW; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d107900457so44499381fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708204421; x=1708809221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eEAN/dOCoAmlP3G0zjBQsaiJN7xwf1Z8pHlWa8opt4=;
        b=X25I27RWzsymcIrIxVj7+094aLpXPZ0q+H4uP6CUes9s1WyUKV5y+P1iB6cE+1ez/G
         SRfuesQICwlOX7SpumQYFMf2PE/IoiSEwSSitL8l7Q0jmaP7Ii0T+OSxwmYwrZpzqt5N
         oJoW1z50QHrXzP3k05BFGs0yAXJQShaMDTlPy1+MS+8GHcGeW+ri6khilbbFhqZJhja8
         APRNWGGCk1kBIZ6Zl3BCR+6VTRpTmLihdq/6TySwDWoYrTN5aJe1NSJCnOyo2etSAAnm
         lZ/GL/Qlf7dtVaFOk3QJAEQDccEOscReAmiudnaObOq6uVMwVzneGNmQ/CSbM5hKvgfa
         roTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708204421; x=1708809221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eEAN/dOCoAmlP3G0zjBQsaiJN7xwf1Z8pHlWa8opt4=;
        b=r8u+hOfT1ZA021dv1p5B+I4Tqr0NhthfOzxttS5rlxbIO/WpUz3AAhi9hatt6Ewsko
         dHaGdo411oeQB+qCNJviu51oF7LsYXxOdbpbx5WI0LjiJ4lUEJWVRWWSqARCKRVSFIeH
         8Jb2Gm9V5Ti+uTou76+lS0fjqCWjOycW01ffrXbq83o8Q3vemfx/z246twAVuWo6r5AZ
         KVrfrQOEYPgfhuft9r52VfWT0Iy/m/ipYOiXt65cUUCwmEyd3rm/gi2UWF8YYyqdC/XF
         QAtavlRDyzrf3zWe+86C6wp/VbW2pLr/+4gHhEC3gxyKSNDSQc3t/mBd7ee27vGT4yuP
         ankA==
X-Forwarded-Encrypted: i=1; AJvYcCX11/PHpugL0vQjroQ0cfKcOluq3G887h5Jd4yV8ueAStgHLJWJ97dF40SfuOrb/mmElV2E2UhLzODDO7suRs/c7TdYZLeHJFTBeOQJ
X-Gm-Message-State: AOJu0YyU+78akqWdhjLlKMCenzJ/8O+sLnXJBnO0Gxp1j34CW4V+Fdt4
	3J0C7mfHNve5/HtWFXVuPVkUgiVRNQnx6Wb6JwjH3b2990g+xL7s
X-Google-Smtp-Source: AGHT+IHSe8QVXIsEhkK8QsiBuEezrULoPTmBu5wXHDINdwXtgs/KS2xhsazL+Kx6Wpw3kzLujnylNg==
X-Received: by 2002:a2e:9083:0:b0:2d0:c101:7a71 with SMTP id l3-20020a2e9083000000b002d0c1017a71mr5017928ljg.35.1708204421127;
        Sat, 17 Feb 2024 13:13:41 -0800 (PST)
Received: from pinguine.lan (ip-176-198-146-182.um43.pools.vodafone-ip.de. [176.198.146.182])
        by smtp.gmail.com with ESMTPSA id n3-20020a05640206c300b005644eca3befsm132087edy.85.2024.02.17.13.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 13:13:40 -0800 (PST)
From: "Moritz C. Weber" <mo.c.weber@gmail.com>
To: florian.fainelli@broadcom.com
Cc: linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Moritz C. Weber" <mo.c.weber@gmail.com>
Subject: [PATCH v2 8/8] Staging: vc04_services: bcm2835-camera: fix brace code style check
Date: Sat, 17 Feb 2024 22:12:46 +0100
Message-Id: <20240217211246.28882-9-mo.c.weber@gmail.com>
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
 .../vc04_services/bcm2835-camera/bcm2835-camera.c      | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 9cd79850b..c3ba490e5 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1715,11 +1715,11 @@ static int mmal_init(struct bcm2835_mmal_dev *dev)
 	{
 		unsigned int enable = 1;
 
-		vchiq_mmal_port_parameter_set(
-			dev->instance,
-			&dev->component[COMP_VIDEO_ENCODE]->control,
-			MMAL_PARAMETER_VIDEO_IMMUTABLE_INPUT,
-			&enable, sizeof(enable));
+		vchiq_mmal_port_parameter_set(dev->instance,
+					      &dev->component[COMP_VIDEO_ENCODE]->control,
+					      MMAL_PARAMETER_VIDEO_IMMUTABLE_INPUT,
+					      &enable,
+					      sizeof(enable));
 
 		vchiq_mmal_port_parameter_set(dev->instance,
 					      &dev->component[COMP_VIDEO_ENCODE]->control,
-- 
2.30.2


