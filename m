Return-Path: <linux-kernel+bounces-89877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87BF86F6CB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2E61C210CC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E5E7C6C1;
	Sun,  3 Mar 2024 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMCDnVW3"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D4E7BB0F;
	Sun,  3 Mar 2024 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709493670; cv=none; b=cCKHt5N9F3bENIphAGDePxDe6qEtTSOIrcjTKzJlaLS1oX/iK4RstuqSnaohe1ViOmzYvr6qZGU9EHUwYviIJhX3lO7S7g2DNRCUCqi34w2ylv4AsAknZ4TYJiKmNfKO255sh6Dx0/i0dHbgZO8KKWcX6rdfpCx5tv1Z4eT1nrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709493670; c=relaxed/simple;
	bh=HXXGYpJ2R5e+79N0pwn2xJeIEF177FohfLn8yHJouxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PpSVqPKHq/WWS0CMQmmDba8t7cjW7w8OjCIZtpcg2ouU1lEPPk0LyNI4Q16JWaiEhzfnEDymePaZlBMlc1fNZqQqM9gwncPLIlRkJ/paB4F1d7QBgUuOa7Zq6prqwyjzshfmUFpZKIF9alQDnbzRRSMLxn+oDixqQXT+Bt/x4Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMCDnVW3; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d2509c66daso46918601fa.3;
        Sun, 03 Mar 2024 11:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709493667; x=1710098467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aV7WL2VyqwjcPUAOHZGvSrsENXpgeqqeSjEPfrb9SVc=;
        b=FMCDnVW3zGoktWTrSMIU3sNej10OUIEN6Y7wFD4YXAQw5HqyIrxsp2PZGbD/7aFOP0
         iEYN7zoy56eS7Zzzuz/rhrlwQgHuFlMo3eiTZm9YesSQaZSj3v65RdBbCugvMR1ExF2b
         2TGFemHNaH70pPx51FPfTfCO6Eq580S5lqEnNP5RcvXiba4yrPam72VyY6VPM+/DOAx8
         s5+T3Mham6R/fO0HASImWfqBZVUIoWJ3XFgrxk6LRudW9P+DT78l8g8Vhng09GB+JHOY
         N4uV+7ZymU0b+fc5MLJKEjTCmFQm/x8Sx6dCXKs0UyV90MfaWC1W09w5B0kfrS4bPA6R
         EGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709493667; x=1710098467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aV7WL2VyqwjcPUAOHZGvSrsENXpgeqqeSjEPfrb9SVc=;
        b=u3a7kxMgKseFZ9sAecIkF37Oz7EP2D09+f+9odPI6mJpbK13Jej+8+lCqqdElhgRag
         Co4X96JadsjUMB1gZ6aSkntJAoNom7zvmQIIdZfSh9yb11yOtM4whqaH8GpjlopKUzre
         gaS3Yuo4taZx1IxejXST0F6bkBV66/TXXx5E3O89JbnwL3wouyn3RlX6+9hYli9tU5HY
         IpRLi/McJ1ur60nlNworFPLpKd1gK+B4uKKuSkT88YC9fMSgjU8pS7fO3c/j7l09oc9A
         P1cwPIc1pE6KIH8TtnaGfFFIEg2Ic0zD6jZxZN7AXdzh4OdRPZPzyfTRYNWVgLqvmHmF
         HaQg==
X-Forwarded-Encrypted: i=1; AJvYcCVcsdZLsUPw9e4wq+BKT5KKbsZyKUvbn9mF4U/Ypj5L4nHkojltSuJvWUGw0ey2v/rsITmLhoIQXeQZFZNCTeiwoWZ1Jh5tzJfeYorPesbffORInbNtjtfTiPeqeNw4V8Sna4g+GXbtLqU=
X-Gm-Message-State: AOJu0YzrzUs8Ql4+nIQbjuJ0KUhmQuEOUx/VIri+wdneAGwmV2h6neRs
	L2mg9hVi2ohlsvZw0VK3DphmfM1Xteppc/9WKmg7WaLjgApbdeUO+Kd//w4+4hTh4A==
X-Google-Smtp-Source: AGHT+IFYrK6BFXMxgBtOI5e0v7ag4D6ZxuchnvKaXkTkh3l4iybNsnEO87VMKw9Q9i7M4HIfhfeXLg==
X-Received: by 2002:a2e:989a:0:b0:2d2:e9f7:6753 with SMTP id b26-20020a2e989a000000b002d2e9f76753mr5063879ljj.39.1709493666778;
        Sun, 03 Mar 2024 11:21:06 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id y10-20020a2e9d4a000000b002d3c466adc7sm68438ljj.15.2024.03.03.11.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 11:21:06 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: mchehab@kernel.org
Cc: mcgrof@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 8/9] staging: media: av7110: Ensure whitespace ahead of opening brace '{'
Date: Sun,  3 Mar 2024 20:20:39 +0100
Message-Id: <20240303192040.8116-9-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240303192040.8116-1-bergh.jonathan@gmail.com>
References: <20240303192040.8116-1-bergh.jonathan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses the following code style issue:
 * Ensure a single whitespace ahead of an opening brace '{'

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/av7110/sp8870.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/av7110/sp8870.c b/drivers/staging/media/av7110/sp8870.c
index 8afddf61e52b..a3c7660c5092 100644
--- a/drivers/staging/media/av7110/sp8870.c
+++ b/drivers/staging/media/av7110/sp8870.c
@@ -107,7 +107,7 @@ static int sp8870_firmware_upload(struct sp8870_state *state, const struct firmw
 
 	// do firmware upload
 	fw_pos = SP8870_FIRMWARE_OFFSET;
-	while (fw_pos < SP8870_FIRMWARE_SIZE + SP8870_FIRMWARE_OFFSET){
+	while (fw_pos < SP8870_FIRMWARE_SIZE + SP8870_FIRMWARE_OFFSET) {
 		tx_len = (fw_pos <= SP8870_FIRMWARE_SIZE + SP8870_FIRMWARE_OFFSET - 252) ? 252 : SP8870_FIRMWARE_SIZE + SP8870_FIRMWARE_OFFSET - fw_pos;
 		// write register 0xCF0A
 		tx_buf[0] = 0xCF;
-- 
2.40.1


