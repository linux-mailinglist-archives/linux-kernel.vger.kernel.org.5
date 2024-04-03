Return-Path: <linux-kernel+bounces-129034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B564896388
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBDD21C225D0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDFB47784;
	Wed,  3 Apr 2024 04:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YqiX1Jeb"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08DD46435
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 04:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712118876; cv=none; b=Hz5brCMxR0GpTfzPUzPN1AZnJ/ImMj35Y0qSX5fSxND6lHkiewhRFDZB0WlWfskBCm2W3giE0n8lMVee0hSTc6y4W3DqN9TESzKuGwxobmzvyJaQicbJ2dpQxwkT2OWSoo5W5wOtQCfqd8IWl5FdVOWSiEZSzip2bhmI4p96mrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712118876; c=relaxed/simple;
	bh=rPfFrJBnAulSY0rHFnC89I3kUqU3f8YhptHrQUiyOjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8+id8FqW7fcjhDRnwFelVNNz0a7FH0j80qioSDYBMnfrDgF9R5gclnerpgJ783LBIGbCfrHTHxmW2/jKrZexOLUs6IrrzlBJLoXQpS+Bbi2gr6lJqo/DFY9dEnaGMgVRS9wavvpmzLuKFVqHh+cOfKUx3dToUOS6zlYqceWzy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YqiX1Jeb; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso4500845a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 21:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712118874; x=1712723674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaoVf9eqjsot1BqIU97nmYIfRRMIaK539UE6et7+tDo=;
        b=YqiX1JebFONPSvAvEbPTvA/CA8fa4arVK9TuWx4QAJ3sBjkP3CW+SxnQ42GizX9OKI
         2R5nRul30YLKoSuJO/7D1Ay84JaUcLefN5vnptEKibQG8zY0ZZRhSRidaugO0OjkY6Yk
         y67xu/tDQyYRJbNSXGHjrjVg/fniitGdynfYp2zj5iBq0YIYg+qA/jP8c60tiN4txztg
         LtEx+CHkBh5xBLy/+v+2jbG/B8zRdGvOp6orH0qwQYXzsnl+1DwedmL7Nbwwx3j/28lA
         Hfp8XNsO4fBXIH8nkV//9d9FvgEzvb9C8bHRjehNX4ZUsSjW0Z7rdyDPlAZHDGxhQ375
         coPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712118874; x=1712723674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaoVf9eqjsot1BqIU97nmYIfRRMIaK539UE6et7+tDo=;
        b=s0X1jpfmL//cWod28z4PtXwsztb5d0b+BU1GNR6QniWlyvSJdnYiSsbrp1AqKZBvW8
         eM3ZGXQgm4GpjTwk2eWW36YxmzuXAQbojrBSg8LYLaee8lp6XtkWICeT0oSBCaFxXpOT
         IJeqnQnpYZcy7+AZDW6Mm2yZBK4v4Bz0MuK4U0a6+R+P4hJspaTQTlVRWqoPUjxnj7jK
         75A9irAAP+CA2CuwqnZDqf4ACY83P+Uo3ZSJV4H7W4kji/nnnQs7mARqX1lJvZGi2NHt
         QX+nFh7XqrJ+iJOzzVzATQK/jOWgqdKDascvAQVI87XGvD457jRgm9E+nRPMcRPvScHM
         LjRg==
X-Forwarded-Encrypted: i=1; AJvYcCVOm/oppJ6TsPH28S6xH3jcy/YR15WAMJipKwGt8ShgeYCp0LW6WL/ynTw8p+pdndyP/Hr7QAXjFejRrGvMJXgCYjY+dFLs9VGdSE84
X-Gm-Message-State: AOJu0YxxCVN3aqEbQ31DDFV93JmF7Xc49aIFMRfvIXOYQ2Y6tEU1MjVL
	aLZOxjgo1YopdnOZuzyiHs/f8tFzJ/+MwHwIFDdfQskRNpz6M3h6awARMzbyuM4=
X-Google-Smtp-Source: AGHT+IFZkTS+dAm3sITI5Fi/0v8c0j9ZLvqoObt+/vUEqnSjQgaBrlu533I8dHQgSl8QKNuWkE7KhA==
X-Received: by 2002:a05:6a21:191:b0:1a5:6c73:74b8 with SMTP id le17-20020a056a21019100b001a56c7374b8mr16939114pzb.39.1712118874010;
        Tue, 02 Apr 2024 21:34:34 -0700 (PDT)
Received: from sumit-X1.. ([223.178.212.199])
        by smtp.gmail.com with ESMTPSA id cp12-20020a170902e78c00b001e2059a6386sm12074634plb.12.2024.04.02.21.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 21:34:33 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	stephan@gerhold.net,
	caleb.connolly@linaro.org,
	neil.armstrong@linaro.org,
	dmitry.baryshkov@linaro.org,
	laetitia.mariottini@se.com,
	pascal.eberhard@se.com,
	abdou.saker@se.com,
	jimmy.lalande@se.com,
	benjamin.missey@non.se.com,
	daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/3] dt-bindings: vendor-prefixes: Add Schneider Electric
Date: Wed,  3 Apr 2024 10:04:14 +0530
Message-Id: <20240403043416.3800259-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403043416.3800259-1-sumit.garg@linaro.org>
References: <20240403043416.3800259-1-sumit.garg@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for Schneider Electric (https://www.se.com/).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 1a0dc04f1db4..4ef38573e411 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1211,6 +1211,8 @@ patternProperties:
     description: Smart Battery System
   "^schindler,.*":
     description: Schindler
+  "^schneider,.*":
+    description: Schneider Electric
   "^seagate,.*":
     description: Seagate Technology PLC
   "^seeed,.*":
-- 
2.34.1


