Return-Path: <linux-kernel+bounces-150099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A257A8A9A60
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 590E6280DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03CF15FA9D;
	Thu, 18 Apr 2024 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="TCVK3aOm"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24941635D1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444513; cv=none; b=Yl4Oq2Df2rfjGkBwje9rMB7FjvgeD91Ba8ul/4b/KcfN3QvvnsULErKHrQG6yxTn9bda4lBaMrRF7C94zc87zlabidWQzl/U2M3z4cTtjoPzHTWsb9m8lPLPgpV8Fy2jWzjUgdBDbeYAGjgBLMSQ3vpSmKmoAFgtZZXjihI8sc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444513; c=relaxed/simple;
	bh=rF2Ft4/jo+8jlUv/5SD9PoDryldsp2ptl9ihYrt1QWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Lky/7jhV3nSty/F1UQFyW6nN/xsbwZ8U54/NLpjWbNgsU5idsnILwy1nA1+b9vCebNT27/p+sdIcRljUZRVkEJaEAmKISOG7L/1+YSbUlVGFDm7nRuvGBouoneegWk4QEs4YO/1Eho1ZgIN7Jtp1/y8Y9Pe1jVX/IOkm5dvc3YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=TCVK3aOm; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5e152c757a5so434026a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1713444511; x=1714049311; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uGDsLEb5BghVT9qGOK/loQQdaX4v11rqejOU2LWrdN0=;
        b=TCVK3aOmdgk1QDN4DOjxln8ICe57v4T3xJmJCqlxQuA5r/629scoVShEpSnxEPqFXK
         TxemM9TIyBAmmtwIKzWFEotJYhgnrhbcmHIvEzeWYrjBEahhQsuc0/xEdfKZ0aIi2f6D
         BhpMP9KOvkCYt6DzMduxls8SjTsadw9U+GWrnsOifA/EXlGYr4MESqcdu4EGPAAoRcBQ
         C/Ep4OYVx3mRuP4FzBF5Cg2QLHSATsl518cwG/ApFfxxQOrrrM/Tdi20fq+9fK2WpaRP
         fJEsu8bQV8IiBielY+uljGLH8vktZahIZLHa09fV+LQ9JU+x/dJoZX/nDt0ZOiL9gEHK
         iSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444511; x=1714049311;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGDsLEb5BghVT9qGOK/loQQdaX4v11rqejOU2LWrdN0=;
        b=R7+jrfl4z80vyBQ5zbAdlkyq+p/o/fpQRxnBswl+DKTozR5cMtHyB3Fd6IBHDeCxd9
         kNxqlqo9kl0vq1lxGNEQGn7wiisS6vplt84vAtbzGL+oyYqxInzlP5kum1HJLol+jhNa
         TQ09bjm2pAG5Zk/oyMHb0Hg7ijg/iaM8PGLMO/Im71lmAremjkFhMjAosvSYYoxxY8Nw
         uLVD5X7MBQ/2hrw84FQ1sSsavpKMG0jWR+N3Lpa+T+pZ403y1qRSgyt2t4L4QF/kwCWW
         AHOtMyLtv+CL2pap1BKpWl6fbAK6/ILp1168yFgyebYmn3vD++mBSOQpJzP9zEZcKfSL
         2sdw==
X-Forwarded-Encrypted: i=1; AJvYcCViAu1xvb4tE4DfDfb5x0orAL4bBQXkd+UKYg8D4/88uX9iVSK5A8GV47cHAK81LOVrp4MUv463TJ0L5qGApgvY6ieXVbix01ezwdj/
X-Gm-Message-State: AOJu0YweEf842oudSAGmXNxb1jv6A5SnerHU+4fqPvpKXkSci2hOOkix
	yfKRs+Zm8cEdi2YwZG2A2qISakEcW41jPQ1nCjSS8E52lAGbvZl5liRGfoo8uNNEKCmC3NuVvT6
	0gMk=
X-Google-Smtp-Source: AGHT+IFp+L1hQ3/71MRE5nC1up3U+FLG4bqHqA86kwgOkj44rzc6HfpwUAixZbMftqOKs33+zrh95Q==
X-Received: by 2002:a17:90a:88d:b0:2aa:c2ba:3758 with SMTP id v13-20020a17090a088d00b002aac2ba3758mr2382354pjc.42.1713444511114;
        Thu, 18 Apr 2024 05:48:31 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id ju24-20020a170903429800b001e3d8c237a2sm1423509plb.260.2024.04.18.05.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:48:30 -0700 (PDT)
From: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v1 1/2] dt-bindings: input: i2c-hid: Introduce Ilitek ili2900
Date: Thu, 18 Apr 2024 20:48:14 +0800
Message-Id: <20240418124815.31897-2-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240418124815.31897-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240418124815.31897-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The ili2900 touch screen chip same as ilitek ili9882t controller
has a reset gpio.

Signed-off-by: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
---
 Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml b/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml
index c5d9e0e919f9..5063ea2c8375 100644
--- a/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml
+++ b/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml
@@ -19,6 +19,7 @@ allOf:
 properties:
   compatible:
     const: ilitek,ili9882t
+    const: ilitek,ili2900
 
   reg:
     const: 0x41
-- 
2.17.1


