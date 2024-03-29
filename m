Return-Path: <linux-kernel+bounces-125144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241E489210B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322B9B238CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585E625778;
	Fri, 29 Mar 2024 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="fMQo+Z7A"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD321C06
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711727359; cv=none; b=XbtBpuRVN1E7Sm9qKDgULht2onMAJuXjyo9wtDbxT7ZJpG8qKD/oh+UgoRXgUFBaVhR+pySONrLXzieO+PKkiqft4sDuYt3NFAPOXBinU+9wNSpNHuDi5i52PsXCRWU/ccLcX2quJ+PGzGM545xnukdayuD1Lp4MBjgVPnkXPME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711727359; c=relaxed/simple;
	bh=lnooIcnRm+Tj9mcyOfrRGjNu8vfwrgz8A/shrwBRbbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFCs2Ienn8ysRcpYEtYR78eAUnyRzJLzwtB2YR5Jb3Mg/sxSJSdEc34SSoff9OSB3jCECa/0vCtWNpbYKBGwO3zXoQSJnInNRRMdXrxTt1khoSwoIANqQ+SuVj9DDAdDMFX1OVkfzjs13FnfLlzaUTBEPZ/Yh+irPEpAle6uYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=fMQo+Z7A; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56bc8cfc19fso2374577a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 08:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1711727356; x=1712332156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xl4g7kNwbZSWPZHN5jBx2cvEXqgu3O7G1Se4DzXl3uE=;
        b=fMQo+Z7AL8tM9cuYXErnx7hO9gy514ZVipjF13lMr+GvGtE4v+lrJWKI3X8uT+rbZs
         QpbytKBsloff8/EsV8zd/13KYoU1rthfRTg67nKHk3GKCbHaj6AW4pqtca4LEnmQxPtY
         dSwL3Pjt9SAJ91SoLqZYzc69eVKEhbqyefHBEIA7tc0UgCp/ZHZhCURlRS/Ml0LXxq9t
         YCu1EN/W/B2hByHflGuC/QXpGGSWWf7mqwuVwDC6swbMlxbLwe6489v2c7oUKdWSLr9S
         fvyn0JSPkkcWAQxg6oST42poH/n802O4xS2kptY+5UmZ2Y0tWM5tBjcEA+dzdq3q4Lo5
         tOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711727356; x=1712332156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xl4g7kNwbZSWPZHN5jBx2cvEXqgu3O7G1Se4DzXl3uE=;
        b=e48JubleSJ5GFqc/MwuaDxlsjpvXUSi4v5G6BFk98vLHj09hdnCNRu0xnOY7HjYMZc
         JoawsCPSd8rU7yTv7ZSwthxWCfBgwffeGjvhF4dvzAuiym8sX8Eh0ZmBPUs3sAeh8sbp
         W1GIyTrDzIpm72/YtJHs1gINtZBKXzS+pTH3MajWYmXuZNVJOaWYWdOEfooQeECfAqr+
         t2KNIi/tNV7oNbJQR+AIgCW/0/uRIIWt/qQvWJPpr5UQOfIy1Idl3vp/sWBblLycSQPR
         HPzsi0TDW1WizOO4crSUW2UvEOOospf0i334yL10RTRbNz5prYZB5dpBBwWXX+G8JfPM
         UCdw==
X-Forwarded-Encrypted: i=1; AJvYcCV8l4sccNOSnG0SThPYr+Wp6MHS/DeUQhisdn14Q/bYTk+CpZFwwjFZRaR05h/rxHxCwvbaDSGTxA/+kluaIjb63cQCY+zHFIiRLWN0
X-Gm-Message-State: AOJu0YwjA8qLtwzsKd8TsY7eYR3bcopstPlJgzz0+6i4ufr4JiPANgN0
	8GpzGwCkJlOXPciKcWdHxjuyObtq7ynMPuLbCO5/QT2mTpuLL8P6gLAiXfpuY4FGaIwi3URcKDB
	S
X-Google-Smtp-Source: AGHT+IEoTDNuKniQKyvP1LcAKCmnmgTPpoKnq+nHfUNUTmyJXKTX+6p6o2lqqh+la6T6vBc+BWJu3g==
X-Received: by 2002:a17:907:7e9c:b0:a46:ec44:477c with SMTP id qb28-20020a1709077e9c00b00a46ec44477cmr2119729ejc.41.1711727356324;
        Fri, 29 Mar 2024 08:49:16 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id bw17-20020a170906c1d100b00a46b4544da2sm2038962ejb.125.2024.03.29.08.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 08:49:15 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: davem@davemloft.net,
	herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] crypto: jitter - Remove duplicate word in comment
Date: Fri, 29 Mar 2024 16:44:54 +0100
Message-ID: <20240329154455.1733-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328160401.445647-2-thorsten.blum@toblux.com>
References: <20240328160401.445647-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

s/in//

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Fix the commit diff because I made a mistake when breaking up changes
  into individual patches
---
 crypto/jitterentropy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
index 26a9048bc893..ee2aa0b7aa9e 100644
--- a/crypto/jitterentropy.c
+++ b/crypto/jitterentropy.c
@@ -158,7 +158,7 @@ struct rand_data {
  * See the SP 800-90B comment #10b for the corrected cutoff for the SP 800-90B
  * APT.
  * http://www.untruth.org/~josh/sp80090b/UL%20SP800-90B-final%20comments%20v1.9%2020191212.pdf
- * In in the syntax of R, this is C = 2 + qbinom(1 − 2^(−30), 511, 2^(-1/osr)).
+ * In the syntax of R, this is C = 2 + qbinom(1 − 2^(−30), 511, 2^(-1/osr)).
  * (The original formula wasn't correct because the first symbol must
  * necessarily have been observed, so there is no chance of observing 0 of these
  * symbols.)
-- 
2.44.0


