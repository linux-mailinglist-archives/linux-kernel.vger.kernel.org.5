Return-Path: <linux-kernel+bounces-70088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE238592E7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA922846C6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2199280BE1;
	Sat, 17 Feb 2024 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRhJLieS"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7998003F
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708204423; cv=none; b=UqjwhV518RgQx8z4qqSH5hIIGyVQYbSpN+PgeoPzbP2/oEnWG1YvsuQphlKE9pcmvQUg91PKblYzsxoHkFzh/hiI8H/rZOm2DVE7L3sSoqqqWclU2aHfp2aDbLP3AIBP/VBdH1FYQQS81kd6+07/Pl/XarcGlM3rQ3Rzj9U/K1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708204423; c=relaxed/simple;
	bh=oYnrT+8AlEwhuH8TSjjJJlm1Ziq5F47iM56Zc5FKX+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lodgz9zo0Envh1YliLRoTWuJ09KsWP24jn1pGhJHL9Su9Kq4cv7ly1AV5XjOxzyZBJltnQGBhVa15NBGi9b95aF81/Mqiw5eO0zlXAHST51+FA/0V6q9ZaWyjWQlMzFWelIYMWxyv8tI9JEGg1cSbJousF9UKLoppWsnEWJYZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRhJLieS; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d0aabed735so38225071fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708204420; x=1708809220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9J6l45754+YIV51YnWa0fLN4KO1F6tNb34S41wWnKVc=;
        b=XRhJLieScOmTH9YSZDp3+RCxhMb96X0egQYgnN9TIPmYEXZDLCSVQMcp2C0Wo2DwJA
         MS6ArX3Rk/9HzCP/m2q/63qTnUVJDH4xQGacBhscXtxOIB0hRkytFiwD5CAFMUoFQLMb
         7o2CpHsvV03ZXa/1LneLtkZDHr0SjVe7OhxCATVJ6Z2rO4yqncrYokRTnq+cBWvSsZRb
         AFcBThqh/dbZAg6bMoNURZGh/9XxQvoYpo4KOv8m6y40lwH9+f+t5nS8b0jH5AEdgv8z
         6jpe7UbJGeg3UaOEjdQ5+3DlTyqmwhHrtp6e0DRI5J7OYjOzVuze5ZREfm/UGJ65bAXj
         x85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708204420; x=1708809220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9J6l45754+YIV51YnWa0fLN4KO1F6tNb34S41wWnKVc=;
        b=b5p7loF12THuAxfwagwzhJrj7AQVaA9GGy5tKqnlr55GYlspjZFRmiQcIDd7vsfAfN
         9GaRjr9C0qkkCIGJDXUXutHSMcFRvVlojnlj6WJy7/JV7SD6cUdJc5ITsMJZ1+ZuHVhY
         6vWY/nTHv2YU7n+XSOLJGtNDNk64fNvwqMJ3N4sV6eW9ELZ8WUcgDNsW7miW4UYpwPN0
         lrRqZD9M7e2egk/2wj7EOuEXIIwt8kDcpSDh3kPIgpemzc2qUDJ4Yxh2Rf6QrhWVfLo0
         wkF8LkN1ORD4el/rDlpT/lEONNLHGFttpQpUYMEBuGGAbjwAUyjvDUvQ2YVqQwOwdTaF
         I3tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRAkOzmgQZGDBwDxdz4NUc0o6MvYqf9xq5khNa1KsvUSX9XQtLkdmuEduhrbwbkmSK+jhB6uAzygomveYt1CvzbPfvGKFuOElAgVb6
X-Gm-Message-State: AOJu0YwuQI/OKx6B9ybmXEw+p/7sJsv6uChFlulH2zu6lBZQqCepS8AF
	VLF2rqC/a5kpOUoWkmc/ameiYqre454eqm9c3NjsaqvQp0OP6cF6
X-Google-Smtp-Source: AGHT+IEm7/eTeW5J6tzTUexCF/3tixsPMmhf3jztev7rLkxUqpSQJ02amkIIfrVSopV5oE1tpPY/sg==
X-Received: by 2002:a05:651c:10a9:b0:2d2:317a:4e48 with SMTP id k9-20020a05651c10a900b002d2317a4e48mr697969ljn.28.1708204419852;
        Sat, 17 Feb 2024 13:13:39 -0800 (PST)
Received: from pinguine.lan (ip-176-198-146-182.um43.pools.vodafone-ip.de. [176.198.146.182])
        by smtp.gmail.com with ESMTPSA id n3-20020a05640206c300b005644eca3befsm132087edy.85.2024.02.17.13.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 13:13:39 -0800 (PST)
From: "Moritz C. Weber" <mo.c.weber@gmail.com>
To: florian.fainelli@broadcom.com
Cc: linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Moritz C. Weber" <mo.c.weber@gmail.com>
Subject: [PATCH v2 6/8] Staging: vc04_services: bcm2835-camera: fix blank line style check
Date: Sat, 17 Feb 2024 22:12:44 +0100
Message-Id: <20240217211246.28882-7-mo.c.weber@gmail.com>
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

Remove blank line to fix checkpatch check:
Increase readability and consistency

Signed-off-by: Moritz C. Weber <mo.c.weber@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index b9745bb80..a25a361c8 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1002,7 +1002,6 @@ static int vidioc_try_fmt_vid_cap(struct file *file, void *priv,
 	return 0;
 }
 
-
 static int mmal_setup_video_component(struct bcm2835_mmal_dev *dev,
 				      struct v4l2_format *f)
 {
-- 
2.30.2


