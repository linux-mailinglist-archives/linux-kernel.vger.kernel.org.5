Return-Path: <linux-kernel+bounces-126159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA66E8932F6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB911C220A2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2097514AD29;
	Sun, 31 Mar 2024 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EuK11uYg"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2335E14A63E;
	Sun, 31 Mar 2024 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902414; cv=pass; b=ksgeo40CZZoHjOGt8MKYqda3khumTsJ5Ndtklrqvhq63ohE/oRMRa+QBA60u1DlOUwQ1z3OIt6JePCAbX6JGsqTBX4YBSNZ/7iJulzeVE/sM/Xq0qp4DPKVy+agv+dwaenI1+fgC55h+wWoLI0rLE3bxWhiJTQFsXcodaLO7I58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902414; c=relaxed/simple;
	bh=/4yQxoR3DV9yvkLWH5V8H39qrAkzGcPAl4uH956qFcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sudOgHIpgPPNJk/dMDoKJa+B28J9xh4YPiHc1E3CRAM84iS8E+X14c6u6VceJRJIEqrmKwjJ1QqHo6hQfsXKREO/ghyy3MalE4T5dr8LzwhFG/FIeoeUDwt/vyRFSA2Q3rsdUpiNkwW2xT2O5dRlWY8J7yyD0xR8Tp6ljsxjGxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=fail smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EuK11uYg; arc=none smtp.client-ip=209.85.128.46; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linaro.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E8E1020851;
	Sun, 31 Mar 2024 18:26:50 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0qOul6Xc8Cf7; Sun, 31 Mar 2024 18:26:50 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 701DD208A2;
	Sun, 31 Mar 2024 18:26:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 701DD208A2
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 6346F800051;
	Sun, 31 Mar 2024 18:26:50 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:26:50 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:24:21 +0000
X-sender: <linux-kernel+bounces-125888-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=DwA1AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLklzUmVzb3VyY2UCAAAFABUAFgACAAAABQAUABEA8MUJLbkECUOS0gjaDTZ+uAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAGwAAgAABQBYABcASgAAAPDFCS25BAlDktII2g02frhDTj1LbGFzc2VydCBTdGVmZmVuLE9VPVVzZXJzLE9VPU1pZ3JhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAMAAIAAAUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAQKNAQuxQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAhAAAAo4oAAAUABAAUIAEAAAAcAAAAc3RlZmZlbi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEPACoAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LlJlc3VibWl0Q291bnQHAAIAAAAPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGQADwADAAAASHViBQApAAIAAQ8APwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRGlyZWN0b3J5RGF0YS5NYWlsRGVsaXZlcnlQcmlvcml0eQ8AAwAAAExvdw==
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 13716
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125888-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com ED60D2025D
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EuK11uYg"
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711833042; cv=none; b=eWzUgg8AsrOmii/PnsDx5QTK9phkSNbznWaLlXUL9148Rbu+JUEMhgY353KpmV8hwbgYmApakDCSLwKgWPZPLuwuYmsNReJFGqwaKirVisiIyo5s2uFi+HSggrO3M50bsupT2LXVIcBJVGZXqtXlRaGZ+WdQNji9Sx1zVgGMKnI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711833042; c=relaxed/simple;
	bh=/4yQxoR3DV9yvkLWH5V8H39qrAkzGcPAl4uH956qFcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NaOAmtAu3ncdR9vZrxQkQhjyS2IsAXFUaJeob4num+FnfSS/TkWvYsKtYraDpv/O6N5KK75BCyxdrDviFCvT4v8dWbKcq6KgRqcMYxutFb4/qXYGDQX9E+UCTpp9xkrfiT/RyVR8JTIoPEd2wkyAi+IO8Z21gkVZb9DtQwZZ4pE=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EuK11uYg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711833039; x=1712437839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=61v4scjVgIk2ToFnkXS2oeqx/czO/u3CzUzarujt/iQ=;
        b=EuK11uYg2xMVqXhNGntIbfC9q8LcHUe1FkvyowcuCkBRpYY9fizfrZBPmOHpwpq6JT
         youB6G1Azf4HbWTz6qs/jCr2ERT0dGTfcjq80tgPXt4ZTuRLE0HSLZcYvxkw4pFbpH+F
         iNYEKUhOJIwT5kT4W35vWMn3mSoU2i2su++VHxpjWsyAI2XnbTpvHq0pmtqDMhPQULRE
         IJ725Iok2kpIZ0uRzAs9McDhgnpdO2Aez7eUpsjzdt0KJMVtqhg+7ja47tc9DMd5SmWb
         EtMoEXRCOIUN3KIxGwiokW3Tpyr7yEngB0k/ebCRXAhHzZm7KE8Rh7lD4GAZcEnsHuh8
         PDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711833039; x=1712437839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61v4scjVgIk2ToFnkXS2oeqx/czO/u3CzUzarujt/iQ=;
        b=bA0s8o8fI8ASohhiuOMWSSBOXUkqtWzP0uS89oJok2Un7qhX0P/F0iwWFYKSzrN3J2
         Ie5yny0vAJIoAMV4tWTR1FPTLo7fQ3d72NvdNHbX1kDnnbrWYoMlUAQBCPaLdmHwo+rF
         z1wu3IBMLV68+oFUC4ByereB3szDb2xDV9701P7m8cnHY14EOIlnZ7/rmvyHWHRi11MS
         lbbmyAS2BPS59RGbeET8S2/+vLMFafRLAIplLdd7WgoGt3jMOEm620MzBNm6IZeldgDK
         phKt9/eUGoGd+pKq2g3hjbZ9lmoriPpSqJ6yvDWbpWpEeRYNggPzhXyDZVwbpwv10oPY
         +7+A==
X-Forwarded-Encrypted: i=1; AJvYcCVpoBHzsTzGsnrxiMtAl7ATZQzT7Ei2J3lzDbuYnmY6QWSpXygOk+qeWTcg6M2BhSWlbYCvynOmm4uSw510ezNW61RU4j8DhoYvtD5w
X-Gm-Message-State: AOJu0YxC9hltUka7//zGVChSA/bPVe82QPAR/76GZo13XdJP2MbzkUIo
	XLl6zWIC/dbpHM1Mkx6XfqwooGz/mh7OW6jrmojn20huwbgHCEEr8pkNtV2wzGI=
X-Google-Smtp-Source: AGHT+IGvC5puYahyLfoRxaBZa5kEc2+uWb+/xISXFXurHNo+cizr9pJb/P/tTe/zgahZkVnF1kYg5g==
X-Received: by 2002:a05:600c:4e8b:b0:414:f60:5d6a with SMTP id f11-20020a05600c4e8b00b004140f605d6amr4142782wmq.0.1711833039552;
        Sat, 30 Mar 2024 14:10:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] pmdomain: mediatek: scpsys: drop driver owner assignment
Date: Sat, 30 Mar 2024 22:10:36 +0100
Message-Id: <20240330211036.100956-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Core in platform_driver_register() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pmdomain/mediatek/mtk-scpsys.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/mediatek/mtk-scpsys.c
index 59a7a8c261ed..1a80c1537a43 100644
--- a/drivers/pmdomain/mediatek/mtk-scpsys.c
+++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
@@ -1138,7 +1138,6 @@ static struct platform_driver scpsys_drv = {
 	.driver = {
 		.name = "mtk-scpsys",
 		.suppress_bind_attrs = true,
-		.owner = THIS_MODULE,
 		.of_match_table = of_scpsys_match_tbl,
 	},
 };
-- 
2.34.1



