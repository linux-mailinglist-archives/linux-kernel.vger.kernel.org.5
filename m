Return-Path: <linux-kernel+bounces-79595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5A7862498
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9171C21792
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1C636AF3;
	Sat, 24 Feb 2024 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wr6LcHWr"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684C137156
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708774913; cv=none; b=gYljNLgXxCJ1H4Q6D9jtA075dgIo/A/apdd6o+cE54LxwrmiLSzn8cf9jHBoR3HpSdR1JTFuwpjFXWVC4GjQzmjx3uGQqmmarFRVZCaVw4GwLMiBFS5hJjlEPcFq/O9LCa8CRA9ZSDDSlMNsJQjgmbTKvaTsuJ60teGnR7MWOQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708774913; c=relaxed/simple;
	bh=Lrcpd/5UpAf/i4hlW7coh7EUhBfakwpQOHR0r4s+vcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CMZ00Ut3EoHGni04AQtJ19z9TzEW+JnVhprftzRNHwyZnsD0QhVY6Traebxl7zeNA4GzTWCIqmB+M9WWmBB+N6w/xIUGjc8SHqCT+yQaudiGUaivnjXiPJVG4M7v4TO3aFzQhHuI6e/QGM5CQ8C7SvfiREOZOBYjXmw83qgBDJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wr6LcHWr; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-565a3910f86so547807a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708774910; x=1709379710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Yath7VHW7z/WtxSbQ8YWwyCMrpMBbCsul+1XKfwfDA=;
        b=wr6LcHWr0XI26HFXXhUx4NlKrPA3HJIC7fRSWvmhOGawqST+kOnoWw8CFTalf6fPKf
         HzpuF/WeqhZDK+GJHHPCDxtCsxC7burWLsURDX52zmK6Gp+MFYk9Bo4B99VljefdLoS/
         oOe7kAsTn5FqzR/+SHwwRtx+NrWxVsc/nnxFZTnddnTXfb4QoPxcGSzptO0rABM7kjQK
         /9Jg4/8dWJ31RyKqzcPGh1+F7Zfj84ZPHkWmdb7FYxFxA8BsUB/LCqZt6s9Z5ORfKQ2J
         N2Q29gmWlaJf1RLUSMsEVRU8bCkXc3OCD09o3Yr2ncXk0DnIv2iJawIdAbytZsqToaPs
         8rqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708774910; x=1709379710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Yath7VHW7z/WtxSbQ8YWwyCMrpMBbCsul+1XKfwfDA=;
        b=aWfxnuhYjBYxzTZoq/8r2tLUOol3CiR4+Z+v1prBw/UKUsaUDk4zLN2+WcqaKa3rp+
         6BC/w+PL7RvjXcdYyh1Zyp368DvT6SE3Wrm7oMQgkFL44mMU/slxHlPO92ZqvfOyVw2P
         Xg/c/KO39Fq729EWqTylZec35uo+AJJJ9pqL5ujLdkOV6KdVn5BxsJTyRgBl4i45ozuo
         xYnEh3hqRHOEERP/vDGv/I8ArLcrGhR10sMvV7Hv4z5bVNySi5MPnxFjYeluP1etSLlx
         2xdiAySS0AaGZaMTUBXqVDdrvW1vBCWkknarIqzfgHzH34Y4KIS+mXOXI34b6vIIY2qY
         VqAg==
X-Gm-Message-State: AOJu0YwGWWG8Sfd+If8hs0mxlQo/RN7euK6+w50gdBfICsFJFxCLXaCT
	yvVodd1LPND63QDfREGIAsWgWrd2p7OLTves1xsGGaFh7l59m67V7KRWfzSw0+s=
X-Google-Smtp-Source: AGHT+IEeat1QReLUI0OyR0PeXa141FDVBDhat8pXwxedQ9Ty16jxR8KZCZ0Pg1jr590YNaIeoxzpeg==
X-Received: by 2002:a05:6402:1513:b0:565:6e34:da30 with SMTP id f19-20020a056402151300b005656e34da30mr1283503edw.21.1708774910083;
        Sat, 24 Feb 2024 03:41:50 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id et8-20020a056402378800b005655c44ac01sm453779edb.89.2024.02.24.03.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:41:49 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Stable@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/1] slimbus: core: Remove usage of the deprecated ida_simple_xx() API
Date: Sat, 24 Feb 2024 11:41:37 +0000
Message-Id: <20240224114137.85781-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240224114137.85781-1-srinivas.kandagatla@linaro.org>
References: <20240224114137.85781-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=Xh3R9iRbEMjVSCJR4o35AiNg3AXIY41qxHjPnz3p3P0=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2dXx2ClmF1Dgnr9A4F8aF4fEGwACTo7uSqyx2 cpKXGePNLKJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnV8QAKCRB6of1ZxzRV N1OiCACOOZw18PUi2Wx+xXUG35htO/lLZReHvqGvYJbZmDkjr4gnyZp753E9yv0wcqowcNShTHl ShEzVfb+2Bvj52u1L7+2A6w9Ak97PWnTatr+z4T97AK9NggecaoKmzKNo/fzUR1TCECzSjCIK7N cHYLbPLMRQH5KvPMeE8/sHpXOH0h82YVd2RHDNUWkm+GLnaymYLvEIwpa88OM84hsVB9yiWXGTY FcMA2A+eyCpnD1DpvAMPqVyce/jjKe5auCm/sBb5BHrXXxc4DXvtbiX/k9eVHMVsi94VcZZflph iSLvxWaH8IOzzM6fOTYMEt6ucfova0DLgh+2snfIqQhKS8nq
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_range() is inclusive. So change this change allows one more
device. Previously address 0xFE was never used.

Fixes: 46a2bb5a7f7e ("slimbus: core: Add slim controllers support")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index d43873bb5fe6..01cbd4621981 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -436,8 +436,8 @@ static int slim_device_alloc_laddr(struct slim_device *sbdev,
 		if (ret < 0)
 			goto err;
 	} else if (report_present) {
-		ret = ida_simple_get(&ctrl->laddr_ida,
-				     0, SLIM_LA_MANAGER - 1, GFP_KERNEL);
+		ret = ida_alloc_max(&ctrl->laddr_ida,
+				    SLIM_LA_MANAGER - 1, GFP_KERNEL);
 		if (ret < 0)
 			goto err;
 
-- 
2.25.1


