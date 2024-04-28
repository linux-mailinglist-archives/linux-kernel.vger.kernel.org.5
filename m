Return-Path: <linux-kernel+bounces-161614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8028B4EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06761C20FEE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA403D54C;
	Sun, 28 Apr 2024 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Pn/77IHE"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87AF28DD5
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714345277; cv=none; b=BdsEkLs6E53LnPtvMkj7m9OrzXAEGDbmT2YrCDHkARwjrNaerCMktzQsADbFVJpzUpVgbFvCCBi+io2AjGUMc9fY+IyPMybKknpASY7RHnxBLVYA4+JnBgphP4iQPiu/09IqruP5qcZeqLYZKXag28NkEOwi7RXHz0vjtZZKGwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714345277; c=relaxed/simple;
	bh=/+LFbaLuLifNnhOqFevNNN8UaYVAANs6mc+rNTS3Wqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bzV3o+GsYH1C4h/n4KDYvvHD1Ni9Syqdw2YQOzOgXZ0QEvIeXz+HTYchR0R3sPlZ98cHTrfJU8FSPGL/pLKOz9K8NGn1eC0tHa3i8OLYNeToxW3zc396yDbhbcfsp9K5oSOG32OwyrnO0nvg2oUreHVxKWY2r9WGJxtSWasNJL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Pn/77IHE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e65a1370b7so35926425ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1714345274; x=1714950074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMzdjpSY3aU2xO0etNilr8pDifs6x6rV56OohU4rWeE=;
        b=Pn/77IHEhXZLu0EgwHpjw47grcNZ/HF47J21Bhy2fPul8/e0mUpMTRmYv3pRdaDTz4
         26PRXyuj7Ha5RAqLuWzEO+/DUWQfdpOFYFBDZXyRLZtSsU4diIdIpl3et47++gjT2zJo
         EUXKG8r0tdFOit8TIYGXFxQZ0w+/PnN0XWsmNHa3QAHrJt5CTDzxoiFYZ4/+5QHNVQBo
         IJEWWpIKEYBtsTU3qssq6uN88mwIM0kwUwDL2RGzLojyPQLHYlxP2Yby9lgZDK94WMfU
         8KqQF+AeON3P0PY5oBQ34pFJcLrm3wQNEpPfHCrkXXyIUTHJFMm2YpTmXfPmY14GGmGd
         uZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714345274; x=1714950074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMzdjpSY3aU2xO0etNilr8pDifs6x6rV56OohU4rWeE=;
        b=LZ+LtrKEwQXiyppgC8BRn5FMMyfKfb7ikF/MJlcOkVqfy3E7DpMRspSxDtJCf6bR1v
         RUVUmcQDp8Ldslb3gOhuXjJGFsNaMjM4kzlYJADdTm4l0im5EzoI8RY+t+uumwyQQk3n
         HUYE5Mf1TDaIxZwd513Af1QwM2dITYPDkHYz/YpykNLRFuz5MLSUN9rLEms1b87aw68X
         5aPT5zD9apV3CXkDd3smyqSuUfCcfv2uxr0ZcIwBAzLMoIyz49fFYJKwZKTVxdQET8cQ
         QhH8fyXmtlDMoEQnKW4qniOHPmGWXNeP3Q/+6k3MpQrMCKetmcsEoxl1Hm8OyDFKpy9m
         Jrfw==
X-Forwarded-Encrypted: i=1; AJvYcCXiKgmYFyUjWOfzemwFXMxwoKisMG2/sV3E5Mx05xflHk+WUj7dSzg40KN/3h6ShKkJig4I+iw+i31cUotIjfoQ031cVNVRE3PPxSIC
X-Gm-Message-State: AOJu0YzubCbCfgJ1wPdS8VaPNTDBc5dJ7c6yTyX0zDwu3opPP/D1hn+t
	aSkRyv4z/ukJdXPeQ0g/aA2MmguTzML/9jZA0On6kgPmm9xeyFlymO3ww1tvxFxN22DiLpAzGTY
	K
X-Google-Smtp-Source: AGHT+IHUlmA1CEMYubfRTFna8pS70R5qtp4cOQDU6qPWbeln+BwJZzgbSv8m3NBuwIhLfxrEjlvQXQ==
X-Received: by 2002:a17:90a:fe8e:b0:2ab:e09e:fdf6 with SMTP id co14-20020a17090afe8e00b002abe09efdf6mr8718594pjb.47.1714345274388;
        Sun, 28 Apr 2024 16:01:14 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090aac1000b002a27132ac02sm17860864pjq.2.2024.04.28.16.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 16:01:14 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 07/18] Staging: rtl8192e: Rename variable MimoPwrSave
Date: Sun, 28 Apr 2024 16:00:55 -0700
Message-Id: <20240428230106.6548-8-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240428230106.6548-1-tdavies@darkphysics.net>
References: <20240428230106.6548-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable MimoPwrSave to mimo_pwr_save
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index fb3c0dba9d16..25cdfdf85991 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -26,7 +26,7 @@ enum ht_extchnl_offset {
 struct ht_capab_ele {
 	u8	adv_coding:1;
 	u8	chl_width:1;
-	u8	MimoPwrSave:2;
+	u8	mimo_pwr_save:2;
 	u8	GreenField:1;
 	u8	ShortGI20Mhz:1;
 	u8	ShortGI40Mhz:1;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 6eb708ba80ae..73d1e19a59ba 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -257,7 +257,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 	else
 		cap_ele->chl_width = 1;
 
-	cap_ele->MimoPwrSave		= 3;
+	cap_ele->mimo_pwr_save		= 3;
 	cap_ele->GreenField		= 0;
 	cap_ele->ShortGI20Mhz		= 1;
 	cap_ele->ShortGI40Mhz		= 1;
-- 
2.30.2


