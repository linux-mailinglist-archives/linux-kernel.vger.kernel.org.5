Return-Path: <linux-kernel+bounces-100061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C239487914C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3E728263B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5394B7A130;
	Tue, 12 Mar 2024 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NDSls8lB"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724EE7A120
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236733; cv=none; b=oVmwHsuL8T8j9PKpxe4Z/Phz3kfYe4j0qCKH5x9E8NoIk1IeecbZ8kxt2X/R3thCqasl8EcpZsw4Vqb2Nu3Z7voYMYhexf/4WTRljJd4WTx6lN+kEXqMM32adssAdgdEkT9k8Hyf8sS1vL5ky9ZNnp4c2ACfgxkY4AXPeKdpdBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236733; c=relaxed/simple;
	bh=rtCtCTfsWVn3FDixpBkjFdC0M7KERRVs5YHjbhVSp6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AxrDDzBKlJhxRGx88rbvTuhEn92cbHRJ+OXM3hl1Tik70aZhlFVj+EEZfTfarkiK6cg7Sm0gScb9ttgSEL7zYEXch8b2iw/pMFXvJWQx8zdjtBEqSv5gMB62wdGeHdJiX2WDIM3mVva7Taw2LV0INJURFrGnETtrlfuj0gDI4l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NDSls8lB; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56878bb1abdso341358a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710236730; x=1710841530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ALeLip2C4yogQ+hCN3DoYab4ksupR6DdlYyCQNNPtkU=;
        b=NDSls8lBv0ycbi7206JsM2OLPeSoenva8RnCrDv2crqBLTosCRJW/Y+6HSUnsjlsAn
         BZDMTnyD9NJZiT1gEMuUNsFMXJgM6O5Qs6x6q5eUN0spTwvQ0ORKPzBHY895CRJmbCXU
         ktMR964MaD1PFmNa0tZtaFVlW3+LikkbZ70eZHLhMK/E7hxA1zbEPv4KhJgQnfYtut5S
         0zgvUHdfG+kt0BjLKMawwTpe1GOZQziKJOoKfIdlZplJNdGYTd3nFxcu9SA1X+7aqHI+
         A+Th1T2eS7psj+kdTJZDJIexva6HE0QnBTZEqSxPKtJVcSHT3tBIyqd3CBWjsvRo3zYb
         tO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236730; x=1710841530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALeLip2C4yogQ+hCN3DoYab4ksupR6DdlYyCQNNPtkU=;
        b=k7dDy5ChkxbcBbxcQbs5d9iu2YkZLATViBEn+LqLpOb8bSIm+kTAXpIhxqSaZYOacp
         SKab94BN/KJhR7n8qXNLhfAS0RliYF9kHdxC1K4Yf8kM6UzdzoCm5Va0m0MLGMCE/vIM
         y+LJe33J2oWK5IFBpqrG4KlHqMGXgBYwH9L1/BMhXGmItcq55SlMmxFq/Iqo/k7Qz8qI
         GIBzga/nN9cNeBDX4Q+48flE8sWAqhZ+mImaj3hfKJLSYlWWSEHtQui9W0nS3RnYzZFW
         R/+0OTSiAaAOzKi6FctRsaWpj1Mwva+pv6BhV5IFv5SD1fZqM/T93INJ4ucrPrslU629
         woSg==
X-Forwarded-Encrypted: i=1; AJvYcCXHlq70lr2+f4NF1lchncfOLH5BwBNa0OZYvpdiK/np0QXUjYq/f/VTEIZiAuRVmjxvmD9Q2jMgloRe957+8kclZxDKTjnt9RHJst9E
X-Gm-Message-State: AOJu0YzZ34iENOzso70BO73Aax+GtiTG8mEUSjo3MX3B71AwXKcvdtfu
	FoFyPE2SudTpPsKIQYia8+zdY4L0ekvsqU4LpWb24SS3pZem+Uy7YRZBDIscdgJ/idDnnOUdQeE
	s
X-Google-Smtp-Source: AGHT+IE0907/CNxZ7q+uOhAPlkuvV3rMayDFcoFEVbcp62w3PIvWqjxL1WjzMT7zVc1W/E2ItDwtMQ==
X-Received: by 2002:a50:c048:0:b0:566:aba4:7209 with SMTP id u8-20020a50c048000000b00566aba47209mr1016597edd.13.1710236729773;
        Tue, 12 Mar 2024 02:45:29 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id f21-20020a50d555000000b0056835320f76sm4010027edj.8.2024.03.12.02.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:45:29 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux@armlinux.org.uk,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] sound/arm/aaci: remove unused variable
Date: Tue, 12 Mar 2024 10:45:24 +0100
Message-Id: <20240312094524.2087101-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes compiler warning:

 sound/arm/aaci.c: In function 'aaci_do_suspend':
 sound/arm/aaci.c:742:22: error: unused variable 'aaci' [-Werror=unused-variable]
   742 |         struct aaci *aaci = card->private_data;
       |                      ^~~~

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 sound/arm/aaci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index f64896564728..c3340b8ff3da 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -739,7 +739,6 @@ static const struct snd_pcm_ops aaci_capture_ops = {
  */
 static int aaci_do_suspend(struct snd_card *card)
 {
-	struct aaci *aaci = card->private_data;
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3cold);
 	return 0;
 }
-- 
2.39.2


