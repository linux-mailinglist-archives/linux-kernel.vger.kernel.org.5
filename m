Return-Path: <linux-kernel+bounces-165779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CF28B9134
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1A52816EF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44684168AFA;
	Wed,  1 May 2024 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="WJ0MDWcW"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA10165FD3
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714600671; cv=none; b=t3WbCTxnbiVzBzTuOmfA+Yq+frymKx98li3vvo5z4F8+rmOJjQSnBX46S1qWJm3FQn7YHu2R0reDkwSwng2Vz5OltaJQcRC+5FXsKqjgylf5X2R4FRThPhLj7vZ7EXu9l1TaOd/4rICG9kV3avsVJWR6UD3rRVVEk4M9q9pC12w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714600671; c=relaxed/simple;
	bh=85q0tifsi/ZuyVB/GgI9ADumbYXEGf7MqN589kwsqLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PDFg+HJhmZeEeydXLPgDbQcUNea9mvPBiqAAIZ8XgHkxwYteZZNmtdm0EejmBpU0lta/MEtjj6EHxnOpXlHYLFucUYj769bAm9CUnwzEnZi0FYHYJUVi4PcVfffKSB6RFvJd4Btu74FvK5s4UFj5OJqLq9qRwnIdvgOdnZ3sTk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=WJ0MDWcW; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-60585faa69fso877979a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 14:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1714600668; x=1715205468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liA+N999r9bzQdbuy7djyarhfhemj80TYrbbaFh4LiE=;
        b=WJ0MDWcWb/i+3q/Kag3ECG2z5b7EoCCox20EeNjma0DOc8jQbQmM4dH2InDjzw+Kda
         Gbuhka0vwRJbNZwfTqrTAeZbQ07MkVJhM+IIpVOodL3ki4YMJTJQHPWc8CyJNhrR0IxB
         LT33M51MSHuOTyEKq+EoJ4uQ2TBReqmZKnRZ9gUIUXsHr81dWBHmc0eG0UGSAYQEVBlz
         QF7au4knrcyy4eTiaI6/6kTbJ4O1Fhqcvvz4DxF62gOlkQeOHLJL5kSpBf4o1NadJdVY
         +JEncIx+tlEBUbIKIzwvlGhk5P8GhLZ0Pcxbo1gAJf7nu4ySaQMtuFl8pQySjVcPuSwC
         trWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714600668; x=1715205468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liA+N999r9bzQdbuy7djyarhfhemj80TYrbbaFh4LiE=;
        b=WCdvzzTbDW/ZJagoCJr7fzsrijtBzWnHcek58dgfZN+hQHBp6f77nI1RhhoNJxzPYh
         HG4Z+SfIWx/AYry6Kf5e6pLEN8QrLhq+OA+qQYOVN+oUkGbCJ5KUMFtS6+7b695VLT3D
         EKY1wWwsLGNtAprZtjav86KK905HO60tVrZ0/sCQy4cWdN5pX9JtR/Z6jlGNWK79u9rZ
         it442JpiS/AP5mtwJQTDLRBfeuSpqTHVWxkG+9u1euGQLshyfmiEk18YO74vdUZ5smdo
         wEpKdw+530CqtS7mKfvR3WZSt01DyJIWJZ5XOHg7IS3ZigITRRFrYUnzx93E73f4jIGc
         iQ5g==
X-Forwarded-Encrypted: i=1; AJvYcCW2EyPyU0FswXPP674j6Wh2ueIZTCei69eg2vstNu7Hm880+Zg0/0nqloUCPILNIU6XFExjaBdIqEIliglSyS46UPm1BUTRmnV4MEv6
X-Gm-Message-State: AOJu0YyZzdnUt0YmSbd+HUbinJH43vgbtkrZChLgfwQUnznCCeTyhkpQ
	LggwCtX50Ljs0qPJ138C4H7p3MVMKmhWeNVRQb1hjf2BfItjepaQ+Qd1NK8fzEoeatAI0bWT0iv
	VZhcxwg==
X-Google-Smtp-Source: AGHT+IFAYI1TjC9m2O0A+NLCtQ7DkOKK944/vmZckq1Oir19NSXnSbP1R7+CwfYA09TFN+xseYv4Xw==
X-Received: by 2002:a17:90b:1298:b0:2a5:5f9f:6733 with SMTP id fw24-20020a17090b129800b002a55f9f6733mr1240580pjb.20.1714600668154;
        Wed, 01 May 2024 14:57:48 -0700 (PDT)
Received: from Rigel.pinscher-bonito.ts.net ([2804:14c:34:2097::6c7])
        by smtp.gmail.com with ESMTPSA id y5-20020a63fa05000000b005cf450e91d2sm22919843pgh.52.2024.05.01.14.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 14:57:47 -0700 (PDT)
From: Jorge Harrisonn <jorge.harrisonn@usp.br>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: Jorge Harrisonn <jorge.harrisonn@usp.br>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	laisnuto@usp.br
Subject: [PATCH 1/2] iio: adc: ad7606: using claim_direct_scoped for code simplification
Date: Wed,  1 May 2024 18:57:23 -0300
Message-Id: <20240501215724.26655-2-jorge.harrisonn@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501215724.26655-1-jorge.harrisonn@usp.br>
References: <20240501215724.26655-1-jorge.harrisonn@usp.br>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using iio_device_claim_direct_scoped instead of calling `iio_device
_claim_direct_modeand later callingiio_device_release_direct_mode`

This should make code cleaner and error handling easier

Co-authored-by: Lais Nuto <laisnuto@usp.br>
Signed-off-by: Lais Nuto <laisnuto@usp.br>
Signed-off-by: Jorge Harrisonn <jorge.harrisonn@usp.br>
---
 drivers/iio/adc/ad7606.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 1928d9ae5bcf..fa989e0d7e70 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -174,17 +174,14 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-
-		ret = ad7606_scan_direct(indio_dev, chan->address);
-		iio_device_release_direct_mode(indio_dev);
-
-		if (ret < 0)
-			return ret;
-		*val = (short)ret;
-		return IIO_VAL_INT;
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+			ret = ad7606_scan_direct(indio_dev, chan->address);
+			if (ret < 0) 
+				return ret;
+			*val = (short) ret;
+			return IIO_VAL_INT;
+		}
+		unreachable();
 	case IIO_CHAN_INFO_SCALE:
 		if (st->sw_mode_en)
 			ch = chan->address;
-- 
2.34.1


