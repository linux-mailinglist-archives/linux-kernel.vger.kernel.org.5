Return-Path: <linux-kernel+bounces-107946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 313958803E1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CAC1C230C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6342BCF7;
	Tue, 19 Mar 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNXAMApT"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625E2286AD;
	Tue, 19 Mar 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870630; cv=none; b=YXlDD3NaGrHd4eo1dVfAk19oR3ryqCQiejFPHz3w6XQppUl2pGpgIHxjT9+ng1Duv9qIrdvB0KtFvPmIN6ms/KJRZw6N1l+v5qvIdrFouOaHQuDT+WcorWONOAlhnjgZhApea+E5a51OzAcMGZni9vbAdOoWtkhbeC/+KtYg3TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870630; c=relaxed/simple;
	bh=oyR06qU+csCnIicxC6KaxDeCepNpijanUR+yklL+4uE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=njAKsRwHI2dmYKl3WfKIqpPPmpSHUS1rJnw4hvkauCZBg0sZ0J3Xuwr/aMRfDfcNu5AHZXdOAS+mW/Fj1LIekb86+sZqz0HFGTG6TOgsN0LKd04iaM3n/OG0GcsHaMo419FioTpk4QJgC4tE7PyiAZAUDsR7aAz1RQn5hnbUo3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNXAMApT; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56b0af675deso2611590a12.1;
        Tue, 19 Mar 2024 10:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710870626; x=1711475426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ar5SPvQbP2e4cGs9D4/VmHfS/OBugCDvvOGlm53Vplc=;
        b=kNXAMApTfisTmg46lhAxvVg7l/4z/Nlzr3rvHHKCmw5eb+FTNdxSWLnjwkmwdN8tfi
         u5TUw7fQRy38rk2MCBRR4CqLqY9CqOETLlgCIG5m+aYd1dVjQAqdi07yG6mFjZg6Dcpi
         uZ1+BYKxfNFoJLMD1HeraOn3FTmliL8cYH1PENv1GWnw5f8glZrfVj/cfsndfgwj+I3k
         pScUt1UIIG66BBvMvKwoidVl7x0d1HcOuFZ31KRRSK7mXbHBG3TT2zJf9m13zVVfN7xd
         wVA8D5cXD+jfpoCpDyE6qYxq4odT/nnJo4lC97FSiA3i67i5XpXQmsjj0IfiVPQoaDoL
         L6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710870626; x=1711475426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ar5SPvQbP2e4cGs9D4/VmHfS/OBugCDvvOGlm53Vplc=;
        b=gZJJir67c0GKcz6uiwDJ/RMfXEkp3iDYQuyigmsKqlH1pMHML/O18F4iv7B3hxrt4q
         potN95Zni+TcBdC7N4Xwwvy672HlgJi+Uz0fHJNlTqVRUxycUn3pzlNLfv3bIZhtxb50
         DVCuc44GSEcTgW9PirRv9kSea8ETIKXZqWoJsj9nqZ31V61SlekwrDBRD3d0o8cy7c6A
         1KtilRVm4llgvVu6kzG23s7H80PCocyLRYSTTexat6Dilk6etobf7UUPIhmOXw5DSruq
         cx1OX5bXc4muEzV+X0ClQT7lcR7ezMTrMCR9AFEWBq85EuZ9wBtfzHBh02yUZ8cKyNKi
         N5eg==
X-Forwarded-Encrypted: i=1; AJvYcCU1mC4pfQxXEPQnBTC3XV+p/kARqB2tpOvAVSb/YEDUIhcWPuYZ+0+ODNiP+BHzHvm1tE47N1BY2UtTaXMXmeGsKXWywUaSMVUldvnG
X-Gm-Message-State: AOJu0YzpsvNTvmHrGt1mzIzJ9O2+mSIzQPnFKv9AAK77prNu55OHGP+J
	m4ipuHLsaelDuZPfIufIQkIUilR3L7tkEXT/uYAP6eCr1N/5w5rO
X-Google-Smtp-Source: AGHT+IF4qt41K7Pzp9amQtDYp7XBOIFm2FLXJfiWIYT5GxvGUR+xjlhVBj+SweEImSVMLV0I258YEQ==
X-Received: by 2002:a05:6402:3884:b0:568:9a2f:84b with SMTP id fd4-20020a056402388400b005689a2f084bmr2383330edb.10.1710870626401;
        Tue, 19 Mar 2024 10:50:26 -0700 (PDT)
Received: from ALDERLEJK. (89-76-44-138.dynamic.chello.pl. [89.76.44.138])
        by smtp.gmail.com with ESMTPSA id et5-20020a056402378500b0056ba8b68505sm84329edb.92.2024.03.19.10.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:50:26 -0700 (PDT)
From: Kamil Kasperski <ressetkk@gmail.com>
Date: Tue, 19 Mar 2024 18:50:22 +0100
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: add t95 string
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-add-t95-axp313-support-v4-1-6204b6d23229@gmail.com>
References: <20240319-add-t95-axp313-support-v4-0-6204b6d23229@gmail.com>
In-Reply-To: <20240319-add-t95-axp313-support-v4-0-6204b6d23229@gmail.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Kamil Kasperski <ressetkk@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0

Add vendor prefix for T95 tv boxes of unnamed brand. It's hard to
determine the actual vendor, so let's assume t95 as default vendor for
all t95-branded tv boxes.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kamil Kasperski <ressetkk@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 04505cb0b640..65025ad4dcd5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1416,6 +1416,8 @@ patternProperties:
   "^synopsys,.*":
     description: Synopsys, Inc. (deprecated, use snps)
     deprecated: true
+  "^t95,.*":
+    description: T95
   "^tbs,.*":
     description: TBS Technologies
   "^tbs-biometrics,.*":

-- 
2.34.1


