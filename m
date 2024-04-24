Return-Path: <linux-kernel+bounces-156145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D961C8AFE7D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098B31C231FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B33484A3B;
	Wed, 24 Apr 2024 02:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="N/hbELij"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DEE1428F1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925862; cv=none; b=eE7oijZKTDFk1CPzzWhApYeEijq4HuCtZqdiqIDCuVGdhPxWrWdmBubN+ySUyz1u8L8XWPr5u7L9Sak13AS9ydG3C5rpcYywmDPcNxhWf2WSf6lMe8JMqK66pC0lpE0IMjOfBlU0uWCr3LdlGX8FSjK3c4cS8pkzzdyT5ImRNG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925862; c=relaxed/simple;
	bh=1fXzANJS1NdIr6gfBBzLGbO0NdolpyrypaMOjlHOatk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sf3bqoQkI0aJHod0BwnASPDzMzLHeg4IPTPGlaX1haXhgaWN58SNvXDGsROpxRTVf82BjYam0bNztsxqQ4JzFSmdv7m64NzgGbUaUXQmWaHFJQ1GChMnXWiYaWfQ2PUjx+spjBqol+AHKR4gfpkBRBdR0OAYfyZxmqC7wMxG3t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=N/hbELij; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6eb86aeeb2cso3944794a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1713925854; x=1714530654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MnjlgBDGHiJT1b3SIjLYv8ukjj45prcH3kNNtWQHt4=;
        b=N/hbELijjoBlhvsGHmPlqR34zYdJazXPissYiBAbisKyXD2F7Ad4MT2ffA3Wm2dOgS
         f2DNjwB4UmVS/9C31AA6S5F7R8ZQMdLUwGcBbvTwznDLXUtz3Z956ultZteN/QdcLdbR
         XDAfRnC2vAwWKX0H6PaWQqCBFvbwKjmU8Rd7UJlzkNs5jRhXS/bcEsYA+B3ZfIrAP5sv
         k0AQ7z4WJcdZM6MKE7Hl05GR3d0J/CngGkAB4K02WBKxcYrlxVz6TF0uF4Quo+3bsLJF
         mEuG6dguykrRP9PKVfNN86qODLkltVbdzJkoJXUcENkRP2LzHlV+iEc/EdJPKodCVJxK
         ONYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713925854; x=1714530654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MnjlgBDGHiJT1b3SIjLYv8ukjj45prcH3kNNtWQHt4=;
        b=M5Cn9Vsiayd3uyV6RA9q8gHGNxmpkTouXAjfDMCL7HGs1xZCoGZ6P/uwTIvItc1H9S
         o6v6adpEdEJPNEJr05qv+iA99efeVVhlx+9YPT/9+zhBa0HW5TQE0If8MtdOk6d6kUBe
         jVkIuX5xjVSX9cz2Pp61dsv7NT3GTH4/LbmKqFnBGgqDf90ZapGgcQ70Yqn+FvHIaT+z
         cRdnNR9ZGAn9y3QDTS8bCRZ6O/gdPTfwxidv91/vnTTk/hiQOevL2Z2BSLUQJwcUKBad
         KfHBF8xgtmAnDL65xF+TN1dvRmqywQuBBIjfCUSP6sTRu2Y6eTkD3Yx1qg5ipbO+8mhJ
         dr0g==
X-Forwarded-Encrypted: i=1; AJvYcCUcGojp12hqnEgIe0UUROxgKzlo7+vmRZEeOg9zsU2wkxbCn4KMh8vTxRMScapYuVe4Vfd5zgTSZhLeoofuEWtQTiyhObxCWUMwYm9n
X-Gm-Message-State: AOJu0YxeVsb5fMV4aK+OtlqKz1YT0smiA7p+N4uuzHboJA/VmSLIAPgk
	T48q6MZGFlngCNmoBReTNlJCRfkjiig6NcJdpHQY6J3X4c3HfRi5/GeABSIfRbXiQlgAKJEW58U
	a
X-Google-Smtp-Source: AGHT+IEkSEvmufTo31NovuwbAJDzl/ptr7DRtDxY5kNTsiK//D2/6Diten8VqKV66h6nr3R0+n2taA==
X-Received: by 2002:a05:6830:619:b0:6eb:cca1:26e4 with SMTP id w25-20020a056830061900b006ebcca126e4mr1559527oti.0.1713925854331;
        Tue, 23 Apr 2024 19:30:54 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id m2-20020a638c02000000b005e857e39b10sm10179385pgd.56.2024.04.23.19.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 19:30:53 -0700 (PDT)
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
Subject: [PATCH v3 6/7] dt-bindings: display: panel: Add compatible for IVO t109nw41
Date: Wed, 24 Apr 2024 10:30:09 +0800
Message-Id: <20240424023010.2099949-7-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240424023010.2099949-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240424023010.2099949-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IVO t109nw41 is a 11.0" WUXGA TFT LCD panel with himax-hx83102
controller. Hence, we add a new compatible with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
Chage since V3:

- Update commit message.

V2: https://lore.kernel.org/all/20240422090310.3311429-7-yangcong5@huaqin.corp-partner.google.com/

---
 .../devicetree/bindings/display/panel/himax,hx83102.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
index 86c349bbbb7b..780521aaae9b 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
@@ -17,6 +17,8 @@ properties:
     enum:
         # Boe nv110wum-l60 11.0" WUXGA TFT LCD panel
       - boe,nv110wum-l60
+        # IVO t109nw41 11.0" WUXGA TFT LCD panel
+      - ivo,t109nw41
         # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
       - starry,himax83102-j02
 
-- 
2.25.1


