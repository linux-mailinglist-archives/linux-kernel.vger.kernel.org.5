Return-Path: <linux-kernel+bounces-34516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0386A837DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761E21F24DD0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E7815FB09;
	Tue, 23 Jan 2024 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MScpaeHa"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C59F15EAB4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970175; cv=none; b=jU8nxPkbV5YHf8QdtdaN3XDfo2lSqgbstNzRG5lA3lCDhZCAELruJDkP8cizyQ/dOkKajYMc4YHG7VKe1Dc66jAVLGnKFT9eQ4L+MzC1BOru1k3cgemrDGUC2LJwwbZHvEwBFVWYeBQAUQ3TXivmBBlZA8frrCfPBfVBfXLUlf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970175; c=relaxed/simple;
	bh=KcdFfpjp2tEyCmOpl25iW2AS7m4+B6NStR38DJl8ObE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DVogzDaY6B5cvaoAZ6VHZw7QVbEtisFoVnQeduQnj/m/XEQiwLg6WMh3Kz1LNe0NKW8t0n/0Sj+J5FCocwRO/oWAfB1A/pXMBbQCinQ4KZbxORj0rEMCx6ic1DfeARyizNITqNXme30pBV/+Jxpr52JEHbDrlJ/pinRTZ6mgE+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MScpaeHa; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bb53e20a43so2822020b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970173; x=1706574973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2GMW5d6UiU7LajKCHttmnW2RyiQyBOWeh+blbgnn98=;
        b=MScpaeHaTiAmixwiYozj+sN+zLpInBsf3akPMG0Ro45d9vU9zyoP4qnLVBrq2xrlWO
         ta+0SM/69oOaRPPCM4JL3zGpZQEwbMuJQmOhsY47Ka9+mY+nkBum1z9iWNrPJ3lVMfRZ
         5Oa0FcARnk/MTCYObP1soS7PTDSQsqNNpRouA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970173; x=1706574973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2GMW5d6UiU7LajKCHttmnW2RyiQyBOWeh+blbgnn98=;
        b=dyrFcDWHCn5hu7kUxxOxD2Os84UQkbYivjiQw2K3Wi2deG7h+YVEDeyGiIAdnq/IFK
         T+ghgy6V6WQOVGKwqRTptbqpKPH7XsdReSJO/wgw5L8zZbUg6GMaOEYkqiIv2oCgLqnk
         IpEMURqV69D/AJLipGHk1IoL2f0j5S4CDQcDbeuAnScUh+UI8+tjkGeKtmjGKUpOV7jQ
         7rhHprSuqY4QGHSNkEPW9om/Hgi8xyW+g7z/i7AoSNzgQuppBrHY3FxGTMepKqCV8mCW
         kWq4X97LCQWzpuAZzpJc19L10U0GpUr55rhzaz0d1XJk4L4rkm9DTcsj9ipZbmlja8W4
         qhtw==
X-Gm-Message-State: AOJu0Yw2/ScMRVOQFd0AD1sTK5t6gWxZxW+S4n/b91UHPv+m0xkVAnbz
	s4zRZA1buh+9AGgUVvAMkaJvuiHiZqtP6vxAQw48uiyMq2gc+YP80WrNrwtKJg==
X-Google-Smtp-Source: AGHT+IHM+0P0FFoTrriCmMbo8B8EOrjWPouiok2qtQ86UTP2/HFLy+hSK6JukrOOVWReaOLPFOxUUQ==
X-Received: by 2002:a05:6808:2383:b0:3bd:bff5:e2c with SMTP id bp3-20020a056808238300b003bdbff50e2cmr1442385oib.42.1705970173539;
        Mon, 22 Jan 2024 16:36:13 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h5-20020aa786c5000000b006dbd2fb0451sm4174214pfo.166.2024.01.22.16.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:36:08 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 50/82] drm/vc4: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:25 -0800
Message-Id: <20240123002814.1396804-50-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2077; i=keescook@chromium.org;
 h=from:subject; bh=KcdFfpjp2tEyCmOpl25iW2AS7m4+B6NStR38DJl8ObE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgJ2AMyzRsa5sDxZ4YRjmUqmbVj5uaz9YlbJ
 skuXbMaqBeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICQAKCRCJcvTf3G3A
 JlUcEACJwN1o8p9j5S/8sYa2gf2nY09bRSaqimJyQqXt58XWmacC7yhhCy8/YoRrWd4rtTKGNJO
 2pyhqZo0AjchZUD2eT/92rshpJ7BoxmmmipARVGs8rGccRxnL+NfA7KluKUS2arbEJZWAxsye1u
 7y9mIZmz0Rl2OEUDiZmLsRUn+x+avkj9t/3WyQhf6z4yB9UeAjExcIzx4ut7naUZQMOs4+nqkhO
 Zxzlk3pu3vEqZBDOzDzLUdhBPeX8m4ZfghTd9cnirA7bkdk+2o6zogqBJN3U6xN7BheU/BKOa1/
 z2viLhR6pAfqpCI5yqOPvSv1Vm+BuvP4sPKwJGV2Odq05P3+Crxq80AgR9KuL3Zuj0RUdDuPRr7
 CK2iELzMBzCaI6HGeRTGu1TcgkQK/Cc1GB5flX/hQ1gepvIzeDSxkg2zzksciW3yRdCdzK1R8vU
 Tp8TEvuJU2S75RSbpxkNPABsnumVvC61dAYZkurqkiHcZRtQWX2ycPQRm0/NVXUiHLtL5aNGijN
 xy3P5YOafRtNbo7sqqxpsgSvJHA6bW0Kp2/QMZetVh+TBxjwl1em23ZSqK8EVnA/Cpcn2GaT6N6
 eyYfB3sBKYHuJ6cigOdu7aG2tBuyJ9LI/IVLUrXbg5xH4fWbZdA2Dm/CSSYEZ4S40USso8DNtmk W8/+QxpbrEQYWUg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/vc4/vc4_validate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_validate.c b/drivers/gpu/drm/vc4/vc4_validate.c
index 9affba9c58b3..677d9975f888 100644
--- a/drivers/gpu/drm/vc4/vc4_validate.c
+++ b/drivers/gpu/drm/vc4/vc4_validate.c
@@ -206,7 +206,7 @@ vc4_check_tex_size(struct vc4_exec_info *exec, struct drm_gem_dma_object *fbo,
 	stride = aligned_width * cpp;
 	size = stride * aligned_height;
 
-	if (size + offset < size ||
+	if (add_would_overflow(size, offset) ||
 	    size + offset > fbo->base.size) {
 		DRM_DEBUG("Overflow in %dx%d (%dx%d) fbo size (%d + %d > %zd)\n",
 			  width, height,
-- 
2.34.1


