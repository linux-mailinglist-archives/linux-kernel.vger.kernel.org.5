Return-Path: <linux-kernel+bounces-70089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EEF8592E8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9909F1C21016
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DC37E760;
	Sat, 17 Feb 2024 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDt3ZHhJ"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E6780056
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708204424; cv=none; b=YiCBESbXWwXNQKWcNUO7LN98ARMs6WhxyP/IHOFImnz68kGL0G+9rmvXWRP7UqZ9vaZHxOO34gkW4WEf118EmAUgt5zRW4Iv1CWaGxVVAR2duFG5bNRj1ZjSKKwA5qBx7eu0q9lzgJ5KNq1u+WJvxVaPQwHNj3vF/CLscgvTNUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708204424; c=relaxed/simple;
	bh=Lqe/eh4edoLNExmGQW5FnAVKYcgYlc53IcedPkXMnAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TUzna5kfWfD4K6rF5xYNFVjKXFdJ/vjvAvSkv9QDhY8Dpmi29DLa5rIsjCNQKMEWprXi3FqABhsUC0xZY2IItuzszFhyGC9+mzMFtc+SB9eo25Mx9Khu+WEweizbYPBiaQzwGH5l4w0BQi00G6E1X8EpHkG1qwu2FzELFtsPQjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDt3ZHhJ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d204e102a9so39848281fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708204420; x=1708809220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwzE+HW50uBtxpNueeebTnFB3RH1F9CMaB4/QKSCdA4=;
        b=CDt3ZHhJGU274gVC6+02QEXilZVvl0HuePBhTHBVmRMkiuaNflQeYDsV55KY0m/LEv
         Z3ETjbWzQmR+THQyS9hn8SJT8lDOP8YyJ8eqzfA20FKUPwYBxZtHWdKizD+2jingp7HQ
         KWkInHeT/0+IZDWTRw5JYCwF2gr6D11PNdz5eMx08Dbdvpoj77cWYMdXkcBE0ds1ZMHy
         xMV3D+SGIO4TiwHSVybs0RaXPJW33zjqIXlFQIIywolN7g+HpBcdDb+HWsoaaIj0L3Eh
         Xy5qOqOyVYQxEcDW2g7/MlmjlG0dgiN+OkiKmNjuzI4v8je9uFZv5TOGqSuEvtUOlTI4
         eBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708204420; x=1708809220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwzE+HW50uBtxpNueeebTnFB3RH1F9CMaB4/QKSCdA4=;
        b=YTxrWo0ZnMm2YEPxfUW9TBWM3x+3ELmISuVcGCy0YtHEPYbcw3Ts2q/pEqs37SpfMC
         +ib7HKnzS8bJ/Su1MmjqN/q3dkcTSYlwL5Gz87Zp1mlCMvE7ZX2sxrpInzdAuyyP8BWS
         twtUoDevwyH4DpbcbKwNGFSiUneZSIwtZbl3s0o/GwG+vbr0BygvqIK/8OmPhDtCPTEY
         aKeCDn5/WuUTC4/toFK7NDSmVM6adJf2u9BYsEE+3kZ9WQR0S3d/v2MxXR7rfmnH69XJ
         8V9y0GLWJ/cALgIycKrseEU1EE5aO5w3pQ8InGwwQiIHouPDppPLPY/yeea9xN6XbXr3
         Fcog==
X-Forwarded-Encrypted: i=1; AJvYcCW+c5j9HE0sXBjn8BYJtJY7spVmipnz2+g6SU4t3GwSWMKBVORyzoNTZ/HkXARkUfJalK3u9PCtHcUbCj3GrMphNdmEwINK8n42ypWp
X-Gm-Message-State: AOJu0YwbF+SWXXglSW5+cBaRwCJFBXnmUfQpSrS1K6qkAuzIZ6z8Gig6
	pmCIhgNvRrA1TCKZ3UzkrKoFsxcTxB/z5ZDq8jGnc+jW7QZlRkhZ
X-Google-Smtp-Source: AGHT+IHXk3qWQV+bKRSd+5nTEjZcSXqE/wa9eEPEqHCenqKtjQ2GVmUO279LV584cCqrqG3qXtjJDw==
X-Received: by 2002:a2e:7206:0:b0:2d2:299d:af0a with SMTP id n6-20020a2e7206000000b002d2299daf0amr1617273ljc.14.1708204420495;
        Sat, 17 Feb 2024 13:13:40 -0800 (PST)
Received: from pinguine.lan (ip-176-198-146-182.um43.pools.vodafone-ip.de. [176.198.146.182])
        by smtp.gmail.com with ESMTPSA id n3-20020a05640206c300b005644eca3befsm132087edy.85.2024.02.17.13.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 13:13:40 -0800 (PST)
From: "Moritz C. Weber" <mo.c.weber@gmail.com>
To: florian.fainelli@broadcom.com
Cc: linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Moritz C. Weber" <mo.c.weber@gmail.com>
Subject: [PATCH v2 7/8] Staging: vc04_services: bcm2835-camera: fix brace code style check
Date: Sat, 17 Feb 2024 22:12:45 +0100
Message-Id: <20240217211246.28882-8-mo.c.weber@gmail.com>
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
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index a25a361c8..9cd79850b 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1037,8 +1037,8 @@ static int mmal_setup_video_component(struct bcm2835_mmal_dev *dev,
 
 	if (overlay_enabled) {
 		ret = vchiq_mmal_port_connect_tunnel(dev->instance,
-				preview_port,
-				&dev->component[COMP_PREVIEW]->input[0]);
+						     preview_port,
+						     &dev->component[COMP_PREVIEW]->input[0]);
 		if (ret)
 			return ret;
 
-- 
2.30.2


