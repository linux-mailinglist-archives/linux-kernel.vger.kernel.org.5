Return-Path: <linux-kernel+bounces-161531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99398B4D42
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1673A1C20B42
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660C873513;
	Sun, 28 Apr 2024 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwVC9LZB"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EC871B39
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714325582; cv=none; b=FQ70S6GuXQTrPb5uk4/eGGYKuOLZUpi+2mdbNvs8ZdMTJTVX2xqYfPSWOXEEGG6KtZlwY4y/Sd1WD5Z0BO+Pz0D9poV0NIKNh28gdj72zKKll5kfvk43yGcmEHqp+f9O7UTQlGvW3T7AkN7IMlnWZoswqC4YR5/bGbY5KJsKye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714325582; c=relaxed/simple;
	bh=u9J6lO2NJacHQtxP14GpMZjLUCM+3kKhh/6Dchva6X0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L5ZPP3hR4lUVs6kIy3H7xoYdPtnTGpSbOh3JzjSkObbNHmgtVq1nK9EX03bqDbbWErC7fpnD6211qQHTaKIeaP7A2PhB1onGByD1rp4gUt6lyTbOAaXrtFO+61MOEGXeshV6MK4ofi2YtcMTti9QTionA9olhsvkeoswQRKGBNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwVC9LZB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41b79451128so18875825e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 10:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714325579; x=1714930379; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jcplmvIQk+FcUwOQ5qYRmNSxvLe0nIBjbwTuOkEX+S4=;
        b=gwVC9LZBvy/WE65DxsER683kAV2TllMVrz18iq9u6dtWaF6ZWaRUb5xFLQyR/ZwU4f
         pbQdnfoaTuTkI2LTNC1MfUKe7hlKh7XF+h4b6x1SopCPrCYMGQMNR8/cd/T2QIOXfac8
         uvXOv7fFT8yKunFrskmuDdiWA2QJ3Sf4Dmw/lp6QrvLqXAhsu531gEhuJUMgx5P74Yki
         YR+mNdKuHiX2OByZDRZqchAoRmRHWXlzGHZFUI5RSkeVWSUzPx2osmXwdgToqKqtad9q
         IBurxB5t8A1TRwxF2iU9wF7QWrzhSE7wK0jSIziZ3NbDivp77+Wq0dxYFCkdXZKOr36C
         iDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714325579; x=1714930379;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jcplmvIQk+FcUwOQ5qYRmNSxvLe0nIBjbwTuOkEX+S4=;
        b=NoMCtMXvi8EtdkKTJ++W6qfRQ5GTOpaoLKVbznKqYHkMu1UN0dBkb2pIvRM9p+nUwH
         ZlwxsTZYqvVne7QE5JgZmPZHrLjKVXszIB4mFDl9Ry98nkIi9Bx34XPaBglthQVImqJY
         zjCdbz336iEuXEM8WK6FoGSJ/sU6+cg0gZz7SH5QzFmoy/XJFV/F+bU9cc03bYezVuG5
         hrGXfVSoxn4h39RHREvA1Bq1BUk06NIijgWoZLBya451uP/cXPv5EgtbmMII1JpPMxL1
         lUGlBI1KuRomNCTkiAXLL3e3FRpy2JNocii3Zd6NoIQNIBOv2EI6iD455cf/1uuHsDee
         3Kew==
X-Forwarded-Encrypted: i=1; AJvYcCX/SfGtUM8bvU89bBvisuMRIgLp4abAvr3GPI/ySpeCNXuTiv5XL7ZTknjEcJBt3s7sNMdHQLdorszmfIehrnVkz27b310bVMuX71G+
X-Gm-Message-State: AOJu0YwPahb5Rymi+3usO51tks57NMxr7imZL1rTQTKagTIfAOypfw/3
	h+3fA2WkhLTGn6yoc1ejSA23HKOZzY2IiLTCFXYHAewFNjrAzgM=
X-Google-Smtp-Source: AGHT+IEB7N4wpUh+4ZTj3qXztX0OIxn4UYxrw5TE1QO6fIgkuWuvQXx6BtRbjarjoC3UujdC8l4r3w==
X-Received: by 2002:a05:600c:45cd:b0:41a:a521:9699 with SMTP id s13-20020a05600c45cd00b0041aa5219699mr6367992wmo.4.1714325579392;
        Sun, 28 Apr 2024 10:32:59 -0700 (PDT)
Received: from octinomon.home (182.179.147.147.dyn.plus.net. [147.147.179.182])
        by smtp.gmail.com with ESMTPSA id a9-20020a05600c348900b0041bb11ff5a7sm8139463wmq.8.2024.04.28.10.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 10:32:59 -0700 (PDT)
Date: Sun, 28 Apr 2024 18:32:57 +0100
From: Jules Irenge <jbi.octave@gmail.com>
To: mingo@redgat.com
Cc: tglx@linutronix.de, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
	peterz@infradead.org, rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] x86/tsc: Use div64_64 instead of do_div()
Message-ID: <Zi6ISSkMLzM-C4yk@octinomon.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

do_div() truncates a u64 divisor to 32 bit.
This can lead to non-zero being truncated to zero for division.

Fix coccinelle warning
WARNING: do_div() does a 64-by-32 division, please consider using div64_64 instead

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 2ed154a2642c..9106069f18b2 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -401,7 +401,7 @@ static unsigned long calc_pmtimer_ref(u64 deltatsc, u64 pm1, u64 pm2)
 	pm2 -= pm1;
 	tmp = pm2 * 1000000000LL;
 	do_div(tmp, PMTMR_TICKS_PER_SEC);
-	do_div(deltatsc, tmp);
+	div64_u64(deltatsc, tmp);
 
 	return (unsigned long) deltatsc;
 }
-- 
2.43.2


