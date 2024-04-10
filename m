Return-Path: <linux-kernel+bounces-138057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF05889EBA3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716C5285012
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F21A13D243;
	Wed, 10 Apr 2024 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="3CFvlfh4"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8E913C9C2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733316; cv=none; b=rEqsuhDX6eCZ8b6xJs1z13y/dnSGAPYw5YOhFQbxR+rA07GeqefI5MHe9ewTNI00BnY7JPKGIX7dggiMuxo/olxYJPhvOoC3z3hVQqSiHkVt0KfUFKdIg1Xht421nk39XSyc1pT9p3jpp9edrTJL1nRg6VFHib7cIpzf7+ixgjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733316; c=relaxed/simple;
	bh=HiFF62xYC5j1uk2LqKhgRL4fn0S4VzgDMc40YEtSxHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UOVPmXPI29RdnUs90kk+97TxROFTKFUcxmOpIzQ+un9ge+ygiUkxd6wHW+owlr0Ko1HAww8AsUVVJw5wcn9cNRLusTyQSEStwN6TzU/IYJN01oFoN9sCilzt6CKynLQz+i4V8UQUdl8ZKZfjzGyZDcxCHwRQ6kvJ1R6D7zklsh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=3CFvlfh4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e51398cc4eso307065ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1712733311; x=1713338111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLNsviQIo1VwdlD8j/pmqb1ZJhhhQw3AWOszQa31LOA=;
        b=3CFvlfh4A/GAYeieuWgpxcwCrKD508rkkTkPWiLqWDD/5rG74g6x3QdYcMkLp7I8us
         xANauBN7OBnYIOOl65dvqx9gGKIAzulWyTSchE6ZQDGhwDUL/Hx5vOD1/CYZCGcmcfiB
         sPgL0U6F9fli0eqL7bsOtAerF0xJesdSQvAB8+3VGjMaAloZxA4/ycbA7aw3mrMqaYmK
         dtRJykY8hPyr22kngyrayFmktO1Rh9RYaEo1RwhsjN1LhG3vtgwT5YmacRDVbkWkEJGf
         AkUZrkPBVbCKeHrrhO8niWQB8E9VgqsJ8CBUNvbofawRuRR7SBPOvbJTlLORiM0PHWwM
         /RiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712733311; x=1713338111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLNsviQIo1VwdlD8j/pmqb1ZJhhhQw3AWOszQa31LOA=;
        b=ZQUQYB5vpjMBUVsmCu02fR2O5lOn0jTjDIkHtzRFjQZnuJVHCC2pJ6yo7RznVmR0wB
         +TmWpCl1Vsj5KI4fmgRgkHpyqfKoPmOM6hmaIbxlx2m1StS8dN1kSsr0vlGUGUYfXvA7
         YrqKjrCXmILa6AgLuOnRZcAec0Pj2gGrPEstIH009KTMxOtqAY4XqDnQ20e2E09sTqwC
         MHwSb4Pzf2OrgLCUOBTRjlJ+HpbL0MrvwGQUxkKQSBeakuENy4KxH/yTlQQiY3kkahHl
         9qBTbnWhvGQkQVzLXgqNbTpk2CF0CmPGmZx6hgbTaal3ihoi/Drt/5cnGnIDbe3+8V4r
         P7Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWdFwKURth3L2v7ZU8Q+27tHbpjz0mipSEAxhHiioo8iPnmdf7Bx9qFx+jp9Zh11zZDDRW9X51ynjzAYgBIMyUmGBpq4L3Q5ANfv81z
X-Gm-Message-State: AOJu0YyBou6QmAhEYJGsoCErwJJM1Ci424dQETFbuHq18sSYxyla8fTG
	MDoQRKyLT3b5j4KCbVZqjbJREZI0AfuQkBqtq7DsBP6OucWrfYvI1Wn5Cpz2uSE=
X-Google-Smtp-Source: AGHT+IGjEfCI9/aMprIcNOJB+4iYY7SjxOU1j2wcCISVFQSOXE94kFbIt9Mi2b+ndzdXO9Z48qYnSw==
X-Received: by 2002:a17:903:40d2:b0:1e2:3e0a:fc5e with SMTP id t18-20020a17090340d200b001e23e0afc5emr2704662pld.33.1712733310882;
        Wed, 10 Apr 2024 00:15:10 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id z17-20020a170903409100b001e264b50964sm10107975plc.205.2024.04.10.00.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 00:15:10 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	airlied@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v1 3/4] dt-bindings: display: panel: Add compatible for IVO t109nw41
Date: Wed, 10 Apr 2024 15:14:38 +0800
Message-Id: <20240410071439.2152588-4-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410071439.2152588-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240410071439.2152588-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IVO t109nw41 is a 11.0" WUXGA TFT LCD panel, which fits in nicely with
the existing panel-boe-tv101wum-nl6 driver. Hence, we add a new compatible
with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
index 50351dd3d6e5..f15588a2641c 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
@@ -38,6 +38,8 @@ properties:
       - starry,ili9882t
         # Boe nv110wum-l60 11.0" WUXGA TFT LCD panel
       - boe,nv110wum-l60
+        # Ivo t109nw41 11.0" WUXGA TFT LCD panel
+      - ivo,t109nw41
 
   reg:
     description: the virtual channel number of a DSI peripheral
-- 
2.25.1


