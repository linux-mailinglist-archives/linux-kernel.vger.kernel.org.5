Return-Path: <linux-kernel+bounces-125147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B34F48920FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E439F1C255AF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A87E6A031;
	Fri, 29 Mar 2024 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="tBg5NsLI"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C396A029
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711727658; cv=none; b=d55VMe9FzoSKQIOiKgppvFoodliHtocq4BtBBtlmk5xlL+Y9ynLvJBR8V/kQeUszZLPrVospXxlP5UDAPlu5qpMSmaKtqLjQXLAgGSRYuyDJZioe70xYpAucHAoAJHO4aQNoBLLDkwhjKtbTDrGMz+ST7r5IW9T5sv/BEebSvPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711727658; c=relaxed/simple;
	bh=vtTblsRc+wVqJ6tKn5gTXVgrZJN5e4s6L8dhh2uEnLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7jhla2/Ui/4LKJp20cw9lLxIDDOQ75VZbLNZhgNXlChxvDk2I/NMnRPDr1m3Sb8vfEopAQqZnSKaoxDz/IZ8ytBYVi/oe47ajijfyjAitTJKIFfE2LuFn2GKkhlW+BrdtnRuiiU+RER+pe03TLSvzclWdj9wu0R0ER4g4LV/tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=tBg5NsLI; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso3059117a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1711727655; x=1712332455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydk4tnBWDP6DoMkMXrIOPwG9i0lGGhIvBed6DXOHPjw=;
        b=tBg5NsLI3XDF/eQ0hhlvMMdc++tdmrZ4g8G1l2S4yFRfKO4S4RKCvtZFB7D6j15g+/
         KXcGtGHCmGOsfqRphxWOXsx9pL4IEwLKh1ld5nmk2Hibon9LIH/4kFVfmBI7je3++pdR
         kjIK9R4gOwxolixptQZgtbT8AlG0eTodFpYlFl771mCYOtbpzRkEPurD26G9HsQr4Cvq
         SnpoVCN4kaYi1356p45H7HVdRVM22lBiPVqvwR9c00GIwzI0r6qlXPCsC8fsMtfCFthZ
         DLpRjE7oFOpCcZ4NKaeqA934iu4fnIRuIOu10jXmm0qu0lmCwccD5kDMs19Re0D8zqaE
         g8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711727655; x=1712332455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydk4tnBWDP6DoMkMXrIOPwG9i0lGGhIvBed6DXOHPjw=;
        b=sl7Ag1lHAloVDvzCjvHBPkROvlwLU3f0puhlWPbWgjuKBhO9z5ZIib+4ppnAiQHAdr
         TgR1Qerhsk++4c5bkzQ/+6afpNGTCizeSy3bjolA4CPR6yvWo062ylUYkEMVLerRMRGU
         D2yW79kJGSD8ok9HI8tTnUDnjmFe3/GfPUbAFrI79x8Y2qC+U5actlehlgm3Z9drXKOP
         uJd2ItAVq/wtIjVVccIl/cd014WNusQNRBp4JRWpKcf7l5wzRtpRQdvBQxfyRpSPNZwt
         c3QWGyarY2RzF0X+Ooc3emUdmIzb+ljkr83jczUuvfHuaSEr8wS6sUKxkZTfKshTYHFq
         frBA==
X-Forwarded-Encrypted: i=1; AJvYcCU/r6bTdq2sGWolcFxojuTzXc4sBqw/eb7zFOSBOoyc1MZatEKjPm5fTWT5gVzJZZMiyvwBxOvlOYHy4DTwgxDFXt0+WxjZXtv6zdUg
X-Gm-Message-State: AOJu0YxhbkDxhUWEVqRDu1I1l7UVrmYUuIr2pEfPfQsMNZehgpRed57F
	/20wDGIUqHhJtpkR5iC6GVQagFHAIoHv7ABEgR5xEoFRSD+cVGKxX2f/bXjHIfA=
X-Google-Smtp-Source: AGHT+IHq+DMnS1H+BOBJytzr6EPT7vrwrca2u3kAsQ7K8DmMFFjbSyT3iO+fnMlYGEz682MaGnGRMA==
X-Received: by 2002:a17:906:c0cb:b0:a46:b1b3:aba0 with SMTP id bn11-20020a170906c0cb00b00a46b1b3aba0mr1799114ejb.17.1711727655311;
        Fri, 29 Mar 2024 08:54:15 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id s25-20020a170906bc5900b00a45200fe2b5sm2058379ejv.224.2024.03.29.08.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 08:54:15 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: davem@davemloft.net,
	herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] crypto: jitter - Replace http with https
Date: Fri, 29 Mar 2024 16:53:45 +0100
Message-ID: <20240329155345.2015-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328190511.473822-3-thorsten.blum@toblux.com>
References: <20240328190511.473822-3-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The PDF is also available via https.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Fix the commit diff because I made a mistake when breaking up changes
  into individual patches
---
 crypto/jitterentropy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
index ee2aa0b7aa9e..d7056de8c0d7 100644
--- a/crypto/jitterentropy.c
+++ b/crypto/jitterentropy.c
@@ -157,7 +157,7 @@ struct rand_data {
 /*
  * See the SP 800-90B comment #10b for the corrected cutoff for the SP 800-90B
  * APT.
- * http://www.untruth.org/~josh/sp80090b/UL%20SP800-90B-final%20comments%20v1.9%2020191212.pdf
+ * https://www.untruth.org/~josh/sp80090b/UL%20SP800-90B-final%20comments%20v1.9%2020191212.pdf
  * In the syntax of R, this is C = 2 + qbinom(1 − 2^(−30), 511, 2^(-1/osr)).
  * (The original formula wasn't correct because the first symbol must
  * necessarily have been observed, so there is no chance of observing 0 of these
-- 
2.44.0


