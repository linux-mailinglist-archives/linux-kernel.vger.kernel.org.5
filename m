Return-Path: <linux-kernel+bounces-101601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D7D87A933
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A77BB23585
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFD955E6E;
	Wed, 13 Mar 2024 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dqcKrQG6"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE633537F1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338949; cv=none; b=HlksgNceUpUZPdE+jy5FN/Gj/1Wod0rCFZlpP8Ds7EqxzEfr2OFNTmE0MkEmArEbzphVjos9oDHs1c01+Z9fg3wpzcnV4L5Lu2nhBWQ4ljkb6JYhlGX3zU0JsC+iJPYpj+7ECfqjmHH/8VJlY6942TyQRPl7qn29ntHeT2e8+MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338949; c=relaxed/simple;
	bh=VqvyhpLImrEEWUqrm8LqdGsOX7rFQEk5APKWIx4SW5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVQMYBScP8c4g/gVk6ZN0pZ+oXLtFCl6dh/01fgzILrGBWduQSNseT+dw0re9f7XyjNLw/1RPUqU4t1tzIQxNPkt9tNytIC3VijGNlYEwxmVFI3LTF4PffLOngQ+zuCdyRxaGo88LRrakbv/H8MFFtXgNWXPFnAK9IjIDHZCRfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dqcKrQG6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a44d084bfe1so646011066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710338945; x=1710943745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iC5hRkZE8XydpjuCjvZ54lBNe2FsAX8ONZyCD9caIGw=;
        b=dqcKrQG6GZlDHC94DESDNEXdZQmYsLRUlYwlrISa96pHNcvKqVf6z8njAV/JZ3w0o5
         jDRnQUGz8IepZRJ23228wV25B9jgsIx6S3Wl500SWVzNsBUa5ATtSUtsuPyzp6TIyNz6
         EvS9U55Jd59c2gv1A7q7/y4yPwPIqIbUQygpcz2RFsZhwuQHm1sD8gPUa25zCatAN2Sh
         fkWy1KoZvW1AboDh+reNltaEktPQPiK0SCmLK5bQZulr5HHkim/mVeSkHgazVOi/el1W
         L0tUk8s+tQ7oWcyuMbauvGl9oB4r8SjXoBiaRWDf6leQrm38ZyPHE7FRwlJQ6AVgZmjQ
         yYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710338945; x=1710943745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iC5hRkZE8XydpjuCjvZ54lBNe2FsAX8ONZyCD9caIGw=;
        b=lJDDY40oOiYji/kg6a44aZ8ivccjVdYL/7+gk38vljkhgqynrZyjoxVusIM4NViOee
         zgDbFExZFh99iz+dUT8i/9lkbXoaoWQL4F0Uy8WT+DOx41aFTj/bKf6YKKfPjo/6F7e8
         bOEldW367Ggn9JzLFWNkNOS+tF9AMbSLHhNcX/XxCISuBNTOIt+EtmtpxAcM7j9VmML8
         n7udvHOKDWzqjGt0VpQrL9OAov6eveG6jZulE9hiSNOC52RlIbDqob6VFR52wwv0Got+
         Ou0YdZ6eld/1mpMfk1g2Qy3DUw1IyYqCMQmuSzBVb77RKJ75D9+iv3tQrpzDxG0sGf1H
         7V2w==
X-Forwarded-Encrypted: i=1; AJvYcCUBs9UmYOuzOcAoPp3ltiwDVjDsnHzu6TXgn7Ce1V5qbQQeR1xAq8na0N2g1wpRYfeOFHzqRbMKGWxss4wZdMcTe9Prp1lv0kI+Jdha
X-Gm-Message-State: AOJu0Yy8cNV5R8YcC+5bu3eLQQox9QyR8ksmIxGF1dg5sBidHf70HAfM
	RAWH+87WP5UIY3AqnYVzB4/DqPSH23nr/aKLnJRnxv+78bXVaOo1uBtHBqAxAbk=
X-Google-Smtp-Source: AGHT+IFyuIjwtvgpdhhj/173HsZkPpiyLzXxHYape6PR7U0HW2/2V4AAAxMeCUd7QbQujytsrNhvVg==
X-Received: by 2002:a17:907:7e83:b0:a3e:792f:3955 with SMTP id qb3-20020a1709077e8300b00a3e792f3955mr3050129ejc.62.1710338945176;
        Wed, 13 Mar 2024 07:09:05 -0700 (PDT)
Received: from localhost (host-82-56-173-172.retail.telecomitalia.it. [82.56.173.172])
        by smtp.gmail.com with ESMTPSA id lg12-20020a170906f88c00b00a4432543b21sm4858324ejb.198.2024.03.13.07.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 07:09:04 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dave.stevenson@raspberrypi.com
Cc: Phil Elwell <phil@raspberrypi.org>,
	Maxime Ripard <maxime@cerno.tech>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Dom Cobley <popcornmix@gmail.com>,
	Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 13/15] dt-bindings: dma: Added bcm2711-dma
Date: Wed, 13 Mar 2024 15:08:38 +0100
Message-ID: <346611b3ec6f47cb10e538d6cbe52056f535f965.1710226514.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710226514.git.andrea.porta@suse.com>
References: <cover.1710226514.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BCM2711 dma engine compatible.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml
index c9b9a5490826..4271a6fedf54 100644
--- a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml
@@ -20,7 +20,9 @@ allOf:
 
 properties:
   compatible:
-    const: brcm,bcm2835-dma
+    enum:
+      - brcm,bcm2835-dma
+      - brcm,bcm2711-dma
 
   reg:
     maxItems: 1
-- 
2.35.3


