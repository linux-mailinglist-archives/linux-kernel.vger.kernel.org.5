Return-Path: <linux-kernel+bounces-98871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B725A878082
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCF21F211B2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5F74174F;
	Mon, 11 Mar 2024 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Tu8oNqV/"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3225C405C1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163406; cv=none; b=ZJ4Z/l6tcBtjDkjLWN1dAHRF49Ol/VC9sTM0lZ7CUD75oINBqPEfH1Eftsr+W57RA9dOvG1TVC8URY/Ety1y/cGhl1Ow15OjFpmc3PXqe1FCFx+YzI38m1L1/J7gp3gRhu50BSYiBIXbIMyM88dat9qk0UBRb+LpkbLjgSpMVAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163406; c=relaxed/simple;
	bh=++b1Hp5v+ZafpN1rfbdsbIrHdB/oRUlmtmRPZn2q9HY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZtjmbBd3d8BUzxM4OFIWnJA2t5EL9HjeEzWD8kUhTpVb5p0PUs1mTWMLflhIqmUckkZtVyhWgeQ+dFWsCJEDaRXLqNRGsAxdH97KQVUQuljSb/j0deTsTOWD+CR72NZGdVhxlMT6wnOCi6rwihRkMXhaKzOEbjW7PJIcD2aqJio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Tu8oNqV/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a461d0c90c1so144365366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710163402; x=1710768202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8wg/GCSWc11sCWJQlZhQbjR19f7OlqscDESiBNq4wo=;
        b=Tu8oNqV/ybdiPlRHmHDhD35eAetpGlxNgwqcHvxTHoTtO7JQZvyO9uzFjnQRziWTGz
         ru4EY8NvqCvbpDLBbrlLhkpADqzIkalBwXDjdJqEOSHzQj98s4AFle30rj4dFHlyIM9H
         R2oqmgxGWuksrJ+1Nrg5xlfALGaBWuuLcqfl5VpWqlTRZaapZl4kJ3wQcLbYSHBKcZHy
         EYJpF1ogpfXjMY3euv9mi+I1DRTexHeTtk0rabFb13H7XzkQPkonCPGGa5FuEsN2vZhC
         IxxVRIvpCAEvQMzR2hcobcx/a9gSJmuBqhIywdx2tZkCbGkjs8luaCTebEljgdE996Bn
         5UAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710163402; x=1710768202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8wg/GCSWc11sCWJQlZhQbjR19f7OlqscDESiBNq4wo=;
        b=oAMpx1/I16NetxG9LX5qLi9Q5XInTFvkBG/wRBWJsCIahAPd4J2LEYfBaGdz1b+d2/
         APp1HU0p2iW+3DhcSGyRVhdQM08ZBfyyoe+sNbWkii6+H8cJLPNnBCK/3kD4Rb8yits1
         +5kN8Qpy2AoKF+8Cge7xBF4+sIb2GfD0ZaOw3GoFJdLr4zd6MGOxMpSNik/Uyr4IqdSB
         9bWy1vqLiTSV7sypw7I/9IX4M5oxTiIqbgkP/kZ4uzS/cFdOgmztof9qS0nVz7zs3bro
         lMMQaiNCXaqZogUHp46Mv6/q9aK6gxCk6Tf8syY7T8FTCp5pY0CLsBa64WEn1HtmiLwN
         YW+w==
X-Forwarded-Encrypted: i=1; AJvYcCX1gxmmUNq9ZZEXkMUsKSy3JNauKOzed+yTiNqccCGpPlK6VXCkK21sjP0W71XSwXJAGP6merm3InSiSDSNVRtrYWbph5C+FbhSRq+r
X-Gm-Message-State: AOJu0YzjPnGnk9YpuhE6JfNfJf3eLpSxEMlnlMxVmdcc3jhiKwE7lk8k
	kFOgg6mWKD+Z8gDCHLlFqC2Gfh/y8QV2bSeJRD13xfz+WdDRRNgfYmWYMqxffPU=
X-Google-Smtp-Source: AGHT+IHyyDKtPVD7kpbPYbrkf2QrQKWybWVF1u8QgQ3Zj1Sx8LN5Ovc3IzbKUJy5idcT5X+BdrFVKw==
X-Received: by 2002:a17:906:f80d:b0:a44:2218:4817 with SMTP id kh13-20020a170906f80d00b00a4422184817mr3932195ejb.39.1710163402683;
        Mon, 11 Mar 2024 06:23:22 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id i26-20020a170906251a00b00a44cb0bf11bsm2861075ejb.79.2024.03.11.06.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 06:23:21 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: richard.henderson@linaro.org,
	ink@jurassic.park.msu.ru,
	mattst88@gmail.com,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 07/11] arch/alpha/perf_event: make init_hw_perf_events() static
Date: Mon, 11 Mar 2024 14:23:02 +0100
Message-Id: <20240311132306.3420135-7-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311132306.3420135-1-max.kellermann@ionos.com>
References: <20240311132306.3420135-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function is only used within this source file.  Fixes
`-Wmissing-prototypes`:

 arch/alpha/kernel/perf_event.c:873:12: error: no previous prototype for 'init_hw_perf_events' [-Werror=missing-prototypes]
   873 | int __init init_hw_perf_events(void)
       |            ^~~~~~~~~~~~~~~~~~~

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/alpha/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index ccdb508c1516..1f0eb4f25c0f 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -870,7 +870,7 @@ static void alpha_perf_event_irq_handler(unsigned long la_ptr,
 /*
  * Init call to initialise performance events at kernel startup.
  */
-int __init init_hw_perf_events(void)
+static int __init init_hw_perf_events(void)
 {
 	pr_info("Performance events: ");
 
-- 
2.39.2


