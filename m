Return-Path: <linux-kernel+bounces-153045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A038AC850
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD931C20EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD67413DBA2;
	Mon, 22 Apr 2024 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="v5CoYQcb"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713AE20B28
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776623; cv=none; b=HmMs9vnbGdV+zz/pE7Xkv4xzyvKb5ZSZYYU3OJMuLtPIyBn/68EkeSQGNf3+Dn3VDSGovpGGDD9csvk7oHssviu16rb/o/jUnY7AqTKDHy/OLdA6chr+98J+QNHkRFLSzEKjOaZ1bqKF1l3RNALlQ++ae1ylTNNfqDFHLwZ9gh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776623; c=relaxed/simple;
	bh=1PsJkl9gqbxqs5Js84qkSKFGlvFiLs0dc8CyNn3QLpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PnzLUD5bAW3wxNwEuJy3ycp5fAqHbjtxY0hs4JnZmEtIC00hVx+2g6tFXR+TqikF91oPK4gmJjFerXT6eqX92ObIG4d3p6Cx4ZNUa9CbRGc3vd+TzOUJBfFUr7JwSXa01i9jTG/OAH+oYV1VaZHnc+egkuiOe40aCZZVvVBWhJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=v5CoYQcb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ece8991654so3925085b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1713776615; x=1714381415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnqPgkVLzV+3jDYl1oUryZqqEdno7AXyD0XeGcrBAnA=;
        b=v5CoYQcb5vEobIjWy9RAikfhv9yEUvPKi3jHTwTQH7QhqtxowMpXsD4Cy5kWxBJn9j
         hOd7ahnNqb3B/rg6LPu1qLp0gnljK7TfsPTWvK2pE1IiZg4+URU3J71AME3b6bTlbSYV
         6JSB5eZWCdDBWXsW0n2kfgd81G6d38rAVaIT5dix9gB2Dvk8odIYDTOjk/cImMS9XhfX
         OnbXC1S7d/qjHjEcqPDlsXdOqKq/3d+FWzrrUon/qDydJV+spay016xKRl0vMBMCuniZ
         xxd324xmZQ8SCD9bwhCatFGramouVPCknux8Q/hmEZRsDsj9r0DWnm91UkiRuGlSIoyA
         nMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713776615; x=1714381415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnqPgkVLzV+3jDYl1oUryZqqEdno7AXyD0XeGcrBAnA=;
        b=vXPC45nPHZvgVEJgC4fycr9aF1FVKs4bAbCYNomuo5O8B9WtmuyT1nbyD18UTZYhHY
         JuQOXqEVW1gCJkEXSk1eA1/ZYCqy+znD3ZgTuIHa2954izPYJNN30cnn88z180UMyWe8
         Jq2LIyswc5wQZp0ssqm+FjP+yOWC5Od+9eM60/gUMgScELN4/doK+tFwmdsSIOUNArHc
         xifgKrHtUimNW+kobNYwQSmYg5BaApmJiDgwwqjb37hq5pmqaBclq4ciYLRSKWEy9lU6
         QuH9ImKCiau8yi5VHDO9AAzd8ORB4i7Pqrmvhu9+NiO6sasL76oAGw/4xfCd9QJoZ02p
         +Z6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIsy+bZ4FUJ0Fr/xZxP1SEVGWN8f64K5hGUP36gF3BMWSfbzLpCXQDkVdX494CKyMFNY2nBAy2YyGuIgjNSVqRvv+fdIg5Mg6X1IsY
X-Gm-Message-State: AOJu0YxqzZ1T7rsEAaTAdSip24+SjKCG45zsMrEDteSG0iofnmgot76n
	cqjkVGNhvqAluMZsOi/pMQl0ZNU6bIRdJTU3evgmcsgo2Odxobl+2MEUd7BDz1k=
X-Google-Smtp-Source: AGHT+IGOWzu8Sm8Boy+KiVHgZhpsdqCs/U5Pw74Tds0iYevluy6MAqtOWmu41LUeQ1x3ipKWvjB/ew==
X-Received: by 2002:a05:6a00:4f8e:b0:6f0:b81f:af61 with SMTP id ld14-20020a056a004f8e00b006f0b81faf61mr16298827pfb.5.1713776615456;
        Mon, 22 Apr 2024 02:03:35 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id by42-20020a056a0205aa00b005fdd11c0874sm1919137pgb.64.2024.04.22.02.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 02:03:35 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	linus.walleij@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v2 3/7] arm64: defconfig: Enable HIMAX_HX83102 panel
Date: Mon, 22 Apr 2024 17:03:06 +0800
Message-Id: <20240422090310.3311429-4-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240422090310.3311429-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240422090310.3311429-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DRM_PANEL_HIMAX_HX83102 is being split out from DRM_PANEL_BOE_TV101WUM_NL6.
Since the arm64 defconfig had the BOE panel driver enabled, let's also
enable the himax driver.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2c30d617e180..687c86ddaece 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -864,6 +864,7 @@ CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=m
 CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_SIMPLE=m
 CONFIG_DRM_PANEL_EDP=m
+CONFIG_DRM_PANEL_HIMAX_HX83102=m
 CONFIG_DRM_PANEL_ILITEK_ILI9882T=m
 CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
-- 
2.25.1


