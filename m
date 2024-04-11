Return-Path: <linux-kernel+bounces-141617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99128A20C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30687B225D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599BF3D0D5;
	Thu, 11 Apr 2024 21:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UxxTBHrH"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5762E36AEF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712870276; cv=none; b=H8qComAmqhFP1pFbMYEWsoitQ/AQu+SIAhOgOM2ldaZ6pvcwPMBHEIjpHJCRFvDsXJRi3sZaPUIfOimYQxIBQiJogQxcalgP8ult1qtc6YhINf3bILxxYU5lLbrYZtnGY2WveAAuGnbE2xiixeOFX/BAagVEs1gMjHMgvJNUJ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712870276; c=relaxed/simple;
	bh=ufd7B+p2FkYNpk8qLtjfnLDHP5pTTghrh6j0nvh6z8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PeCe0QNCDprDBquOB5jW47jB1rMjUK2YwQCoUvU5hRA9KTdAJqQMYFET+K3z43/iuWlLn+AeAcOztU0ArtQ8u1zbWIz69u9JBxUteiM06x1ztsYi7wjOZ/oS73JIv+PlddRID/1vxFRU0AcEkG5aJhLMAYLU81/mYceS4YmMiI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UxxTBHrH; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c3aeef1385so136709b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712870274; x=1713475074; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4R8SNBXJ275CXC4IwKn1Nf9LGrTrEst208ivldsCOI=;
        b=UxxTBHrHcEKj9qrhNBiFUPaGnqdS/+eENZ2ttbwLqITLIKri0XMmg6AKrgp4gGJhuZ
         EH3AOdhoM/HLqiS6kg7WC5Yh31ZKxUSvPczi2LQqpPKhH9TTCxw/oK3SUmokervwXr/z
         16CGv6lHerxMx1binx3punJNY74MwyI4k0NCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712870274; x=1713475074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4R8SNBXJ275CXC4IwKn1Nf9LGrTrEst208ivldsCOI=;
        b=Mn+DNiIabdyCnAwRyd3WWB5KClkU6Uhf0yjqa9vRqqGSDD/L+bUQBrVUR+njihroDV
         u0WIF5zrxdexKCu3/+eaLY+Q5qVzjOBSs3opPfJEWw2qyKxCCukMjU02/UZCZfxzMsBy
         UAGKlCwV6s3uRG1n+LVYSO8POidslFclHhLgHUMCxP827q7PI0x69EYbO9JcHYUZp0rf
         0pUFjKMhM6mhvPlQmE0AI4qLHP0LL+uCt7b9qVB8kEkKc3vIwoxln6o+Sp3MwycWoNVf
         bc7vBdgGpvnK49bQ0SMF7vYIAODDvbO+g3ysoXGXkb07h/yx4yTqBl0wCan7tEBwvgEV
         diSw==
X-Forwarded-Encrypted: i=1; AJvYcCWz2mIepaNDxfC4mbLC+FGOzlBGMHrJPeckhw5Lw5Knj7FNYI9OxLzqGgBK0e5UkCd9xYD3RArJjcRebGXlfbpemeIbEUXAI101FkyG
X-Gm-Message-State: AOJu0YxZfqQA1NKGsBsKQ0lyjjOvISnId7J8ONpOmjphLVeHq4fDineN
	/cR5PzjamQgqNpgLXRp6oWPrk+MASLjdUkkR+wPQfwrhaq84C851Y3eO1vBceohbUnTkDPTa3IN
	9sg==
X-Google-Smtp-Source: AGHT+IEC1vdgwkjJJheMAKozxbMmu/L/tTm4eEGL7yncy97G5OW/5qnYsDss86EcRfqPSpyjplNl8g==
X-Received: by 2002:a05:6808:1cf:b0:3c4:f70b:7755 with SMTP id x15-20020a05680801cf00b003c4f70b7755mr793202oic.20.1712870274492;
        Thu, 11 Apr 2024 14:17:54 -0700 (PDT)
Received: from denia.c.googlers.com (200.234.86.34.bc.googleusercontent.com. [34.86.234.200])
        by smtp.gmail.com with ESMTPSA id k20-20020ac84794000000b00434d7c4f9fasm1373362qtq.8.2024.04.11.14.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 14:17:54 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 11 Apr 2024 21:17:51 +0000
Subject: [PATCH 2/7] media: solo6x10: Use devm functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-fix-smatch-v1-2-045f92467937@chromium.org>
References: <20240411-fix-smatch-v1-0-045f92467937@chromium.org>
In-Reply-To: <20240411-fix-smatch-v1-0-045f92467937@chromium.org>
To: Bluecherry Maintainers <maintainers@bluecherrydvr.com>, 
 Anton Sviridenko <anton@corp.bluecherry.net>, 
 Andrey Utkin <andrey_utkin@fastmail.com>, 
 Ismael Luceno <ismael@iodev.co.uk>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Let devm handle the life cycle of the irq request.

Makes smatch happier:

drivers/media/pci/solo6x10/solo6x10-core.c:631 solo_pci_probe() warn: 'pdev' from pci_request_regions() not released on lines: 631.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/solo6x10/solo6x10-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/solo6x10/solo6x10-core.c b/drivers/media/pci/solo6x10/solo6x10-core.c
index abf30b7609e17..1a9e2bccc4136 100644
--- a/drivers/media/pci/solo6x10/solo6x10-core.c
+++ b/drivers/media/pci/solo6x10/solo6x10-core.c
@@ -144,7 +144,6 @@ static void free_solo_dev(struct solo_dev *solo_dev)
 
 		/* Now cleanup the PCI device */
 		solo_irq_off(solo_dev, ~0);
-		free_irq(pdev->irq, solo_dev);
 	}
 
 	pci_disable_device(pdev);
@@ -544,8 +543,8 @@ static int solo_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* PLL locking time of 1ms */
 	mdelay(1);
 
-	ret = request_irq(pdev->irq, solo_isr, IRQF_SHARED, SOLO6X10_NAME,
-			  solo_dev);
+	ret = devm_request_irq(&pdev->dev, pdev->irq, solo_isr, IRQF_SHARED,
+			       SOLO6X10_NAME, solo_dev);
 	if (ret)
 		goto fail_probe;
 

-- 
2.44.0.683.g7961c838ac-goog


