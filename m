Return-Path: <linux-kernel+bounces-112296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D31D988780C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729381F21B81
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CBA1798E;
	Sat, 23 Mar 2024 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dO0dWuhc"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B22610A12
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711190512; cv=none; b=rbtp/4XbdQx+FEknydn4/xXQzjL45Feg9MhfsIo75J9MGIrh5xD6fHrQ5oeJc9Eqku8JKHOGY0lSuKmnjCcZpsd/MDzSKluFBEjsVfyxEJWjU83YciClKtYMf8yHy/D+HkIm9qRAnBjpGY3z6kC1FNhw2ZBB4t1qRzeCzW29JMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711190512; c=relaxed/simple;
	bh=SydhYBUNZqt6seDV8GSPes7otcagbCoXjH+x0l9PSis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ur5UE0DOpj7Dio1hrNOFaOF+mj8i3SWJPZBM7+aSN60Zhl8IDihThNq6WqgFhngfr1PiIs6n/dXdl4DS3UdwkNrcmliTzzN8AikRe647gwDEVfk444bCn7MF9hAat/aJLi9y0Rgzr0TEXtyS4NgDKagU7adH5VapDZF8eZezqu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dO0dWuhc; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-789e5021703so197658085a.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 03:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711190509; x=1711795309; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3XV/BFRORhDDlgNHHmWyRWqMIVOw6WvWWLzRQu/wIQ=;
        b=dO0dWuhc306F9Z3PScGw1uDUZtZ4FR4RWg6mIBHJAbbFx/CnS5AiCdFwM2YCSMcyvc
         oi0T/VbWujf6EAdlgosVNElC1Q078IHlfrRk4iSXk+co6CDHka27oNcpPubPb5jK1gvX
         d2sVVhBxcnGVS0EaKBb4KpoPwRvDu/DMV/bvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711190509; x=1711795309;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3XV/BFRORhDDlgNHHmWyRWqMIVOw6WvWWLzRQu/wIQ=;
        b=fbh/6K8eEs6nVs1s6nNLeio/3YzkCITKlrBpp+JOx1gUjovRIk94N3dEvQmdWtecpW
         j5H5zEEer5/SYsQGJJ+I6xOSFHSE9W5y495CiQ/dyqHGi9gFbFg8BlNaxqArmzmSBoT8
         sbnFsLM1b0V7tBProof4KD/cXkk3ZQ9QmWYC1fWzOZCm74oheUgEBnW1kd4c37L8THMn
         l9ZaoQ5iF2yVGysHCc8MosfzdcGeLFsKL0g577tswo9ZNp52KxynFik4fb9hRG/J3fNq
         PguT/p/T/Wl+7NHUTKKnBvXsqFvfC27VttAdbpvivHFKRHbYPY3ykR3BUzZwGAZ3HmS/
         aelA==
X-Forwarded-Encrypted: i=1; AJvYcCVGYYz4/MNcnNneEbgjx9PCcgeVP/kD8A/Z0olWQzmWW6GR9ip+uovR91jw4UPqPEnq6aih+vA+nT/pc2K+PHDf8Ck+G62dGT8XhcT6
X-Gm-Message-State: AOJu0Ywbx821KE8hzfrU/bWl+LmBCPDpEtj6k4g2G+y3+umhm1J8zZ7D
	qzs5ez097zvYlaXdVamBTuZHijDzwPcIXldcpMqKspxenVnS197F4O70d+AxIw==
X-Google-Smtp-Source: AGHT+IFJ0AxLDSRvjFb1ZMGrWouHQmyY7qI2KBszA3xQ8hMp/4DEq6hXhIgWD+DLoGqs1PoIzfFgPg==
X-Received: by 2002:a05:6214:4112:b0:696:116c:f00 with SMTP id kc18-20020a056214411200b00696116c0f00mr2359404qvb.59.1711190509586;
        Sat, 23 Mar 2024 03:41:49 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id 6-20020a0562140d4600b0068f75622543sm1998523qvr.1.2024.03.23.03.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 03:41:48 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sat, 23 Mar 2024 10:41:45 +0000
Subject: [PATCH 1/3] staging: media: tegra-video: Fix -Wmaybe-unitialized
 warn in gcc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240323-gcc-arm-warnings-v1-1-0b45cc52f39e@chromium.org>
References: <20240323-gcc-arm-warnings-v1-0-0b45cc52f39e@chromium.org>
In-Reply-To: <20240323-gcc-arm-warnings-v1-0-0b45cc52f39e@chromium.org>
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Make sure that tegra20_vi_get_input_formats always assign a value for
yuv_input_format.

Fix:
drivers/staging/media/tegra-video/tegra20.c:624:72: warning: ‘yuv_input_format’ may be used uninitialized [-Wmaybe-uninitialized]

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/tegra-video/tegra20.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/tegra-video/tegra20.c b/drivers/staging/media/tegra-video/tegra20.c
index c25286772603c..c39b52d0e4447 100644
--- a/drivers/staging/media/tegra-video/tegra20.c
+++ b/drivers/staging/media/tegra-video/tegra20.c
@@ -176,6 +176,7 @@ static void tegra20_vi_get_input_formats(struct tegra_vi_channel *chan,
 		(*yuv_input_format) = VI_INPUT_YUV_INPUT_FORMAT_YUYV;
 		break;
 	case MEDIA_BUS_FMT_YVYU8_2X8:
+	default:
 		(*yuv_input_format) = VI_INPUT_YUV_INPUT_FORMAT_YVYU;
 		break;
 	}

-- 
2.44.0.396.g6e790dbe36-goog


