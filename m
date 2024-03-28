Return-Path: <linux-kernel+bounces-123206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9178089047B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D5EEB22451
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807BC130A40;
	Thu, 28 Mar 2024 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="c/gyCv7C"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C36F130A4D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711641900; cv=none; b=KKB7VqLHYGT2Gkp3u+KsVV935iwbAlpcB60W4n6BRuTK1gMD38WVOVjOwprTbcWDA97htn6qbo2ZNzx6PUnCC/2U/wVRi5u1AF4kMQd9tc+uyryrl3ApW+G3G+fZIVsABluIGlm8R+56fN5ZKBxC44vGjFnk2qxFjsMz6MGDvs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711641900; c=relaxed/simple;
	bh=jkgQqEjhRXI9Kg5HCJwBu1K2XFo6+zfHCumlEZPCDJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y9s02T6XjWFsnTZOLz+5HKX/1hmcwASc1ZuapQP52EVcsvY0xwYmWvcHQpypy64GwhReNM/tufwQsYzQhI1GeCvrDHeBLhjlL9J17jhUKi76b1uVcPIPJejHTcjz03rFfSYsmASQQdJMClGsmLoibXNFGhPfEnHmu6dYFA7A6/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=c/gyCv7C; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so1421684a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1711641896; x=1712246696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vI6ZoGEa9V83cdHy08Sxu7AfclgAoun/MX2DchJITXI=;
        b=c/gyCv7Chpj+xmXlPn2peXeDHMRQ90+JLVKbjNiG4d0MDTiQdwwkqRCAhqhPfKqZEI
         N8TwhFckxAKh6NYK9lH5s4POuyS9i4/y8iEvwKM4I7zviE2X7RJb425NBp1FaVXILE5U
         SF0ma12p6Q3CeXlTbM1kKwsoH1A+Xp3CecxJpLqYaaW/ibWBDsoKk0NR5ACRRU8bqMiI
         sfknNLeQRRrZasa++uEfiV0dvo1aPA4Drtny/el7CMCBI2XYWyvUTnd4GF2ZNtg/JXYp
         hnhaFieYAKbaXN4ai6mJFuJMkUHZIBGpnSB0ot8YW+rg9k3YNK1wikUNHounDgyVVyr+
         akJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711641896; x=1712246696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vI6ZoGEa9V83cdHy08Sxu7AfclgAoun/MX2DchJITXI=;
        b=Jpkn3WROQmkAsaeZCIjIpsKSVDrL0aBE7096j/eMEC/xp+CTXM61R7txX1uht2xhoO
         144Oao+8HaRgfRhOAKP0wM/dV7NJU2yLFMFYAdC+ZnCrcn/a6AmplV4rncm96GS22cPF
         ZUN5TS4qo6H8WV366Fc63Ebfxe1AEnsJ1AQAJK2ll4IcXvre+8sitwvJz9PSfSzgX+Pg
         vweMa0jCaHmYl+Nk/on4aBdwonhF11NBP3Eh228YJo7mRCFE+BVzCLTPGURBskOpG8eB
         PZRtnII4c6YoN99tJxmWmCUo9ZMdv4zZkVo5pI/8LPmJIxg86od0Wet3eweixmSVLEJp
         Rz5w==
X-Forwarded-Encrypted: i=1; AJvYcCW0WkhUExTVeZyMaBDa+6IlX8C9HEoK7sN2svBC7cJS0Dz3j+laP4GCOdsHY3N/NpQpfn3HK/i9E2It5SpSlZi8scYrqW767y5+a74Z
X-Gm-Message-State: AOJu0YzBNiZH6AuBhDIxlAZIkrfovO9Wnaq2b9d6WvZFLfhSN+GYU2Jo
	P1WYCPP20ia7NNCDNLYlXWgjqvVO3HDGjRIJhGWHZ7wVVB7wZs75avmjxnNfA9U=
X-Google-Smtp-Source: AGHT+IEY0llE5S1AsYzABRko/je7SVUd0HjrRfskEzSp9n9Aqx94IpT8XC7p7f934G10wxckne9PCA==
X-Received: by 2002:a50:d68d:0:b0:56b:9f91:d26b with SMTP id r13-20020a50d68d000000b0056b9f91d26bmr2950294edi.14.1711641896547;
        Thu, 28 Mar 2024 09:04:56 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id i40-20020a0564020f2800b0056c36a36389sm986115eda.19.2024.03.28.09.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 09:04:56 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] crypto: jitter - Remove duplicate word in comment
Date: Thu, 28 Mar 2024 17:03:47 +0100
Message-ID: <20240328160401.445647-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
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
 crypto/jitterentropy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
index f2ffd6332c6c..d7056de8c0d7 100644
--- a/crypto/jitterentropy.c
+++ b/crypto/jitterentropy.c
@@ -157,8 +157,8 @@ struct rand_data {
 /*
  * See the SP 800-90B comment #10b for the corrected cutoff for the SP 800-90B
  * APT.
- * In in the syntax of R, this is C = 2 + qbinom(1 − 2^(−30), 511, 2^(-1/osr)).
  * https://www.untruth.org/~josh/sp80090b/UL%20SP800-90B-final%20comments%20v1.9%2020191212.pdf
+ * In the syntax of R, this is C = 2 + qbinom(1 − 2^(−30), 511, 2^(-1/osr)).
  * (The original formula wasn't correct because the first symbol must
  * necessarily have been observed, so there is no chance of observing 0 of these
  * symbols.)
-- 
2.44.0


