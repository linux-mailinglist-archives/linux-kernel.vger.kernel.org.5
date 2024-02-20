Return-Path: <linux-kernel+bounces-72231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E3B85B100
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114C01F23CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D3E4643B;
	Tue, 20 Feb 2024 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1QCdxbO"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC8439AFA;
	Tue, 20 Feb 2024 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708397766; cv=none; b=RswsBJJrSFIcD//tkKspZQmIaoqHmMykT8zfNj34fOfEtO4VNg8RhusETy82cIAQjHEJcoLLha5fhELNH76sU/SWw1e0yXbvypGourPeNmALL6NVrAoM72ebkJC95UaR6NyeumX0GNUe7ysvWI4vYfnAvYLn1KraJ3SsIcDSkfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708397766; c=relaxed/simple;
	bh=S1sS2CIfRu5VdScV0YoYXahlKvwg66mxp8c5UQaDWVY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aGL8GKStfucg4pibP79mp1ags4s4kaGfvqq7xQowl7R1wN9LGzfQPcyjFtzjQ5JLRO9+T5OflGXjsyZ4Gd2tL+cnl/r1nF2MIJt5CsmATQcDsJjmEW7qCWqxpy8pDlr/500HmsVFdhWlihP9YUXBmttHAIDOfC2HknrF6mUpbpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1QCdxbO; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bbc649c275so2754405b6e.0;
        Mon, 19 Feb 2024 18:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708397764; x=1709002564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ew2uLDYa+YibzlC1ysi9/XNB2ZeTVfWqOboQZAqpaQ=;
        b=e1QCdxbOLK7h7iutY1FF5ElukJwBJ1Iw4qynejlFvb5I8HIcH5U0lCsQXRxaviSvc8
         YCzJI5Qttx2fLIqZ4QhyEWQwfE3RtTtJM2NHR6nkcUyTwFTCdqHTNn4on4IPdbDa7HbC
         ZauqTgnPN9i+9lRR+YWMteHhcSi7+ysYe5b30fLJs+zrcg1b6qzYC1gNxEdy+1OKLDtu
         ymXAjPKcK9Kn/FjMHVJom7a9Vi/3RfwPX8y+4mbe/7KbIZMU1XRjhlVYRXY8NdvjnFDg
         bW/wg9P7ug8lgtQ855R18PpRhpWnJ18kWA18AS9f+YCuGlF2ZyKE4r9koFf4NgQ36+58
         QRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708397764; x=1709002564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Ew2uLDYa+YibzlC1ysi9/XNB2ZeTVfWqOboQZAqpaQ=;
        b=dIqapQzpFmGlR7+cWnPTu8zSTX4GHbHWVOHh4Dga8kF/w5XCRkYUpf1dcSskt5zI5j
         0VRYzzd+tZboYcJlqQC3tE75E3GQa9K/kAY/SmtIzrc7pO9VNPxeRDUxSUNbGpoDMh4A
         XTUT9oOH36yCM/d8opQkcjPv1I6X273GbpppoeMI8N3mLg8Lzdw8Z8CpA2R8U5zedN4j
         BoqWoIw8vGsGhbSR9XxI8lwZ3pfi4XVyRfyo3Mj5axGZZQ+c87q3HQJvvlBZcYlm8fFN
         SovVnlGKIQdD3+ClLLwg24mRN6xDliKx2Z/GOYZeY8NjJ1IhJlb4BPlRwFcL+rUY74I5
         jPSA==
X-Forwarded-Encrypted: i=1; AJvYcCW6aMStua+jyOmB98b2fLeH6yBwMro7HxmUFohOPPHE6BzhGci9wTYju2nloYMQohJcN43h9nei9ufAoJ24/X07l/Mms0jwUWXhmOrH4zszzINGnkRh6Uq5dOzRB4mJMKteZrcuaLABEB14
X-Gm-Message-State: AOJu0Yzjvsp0wylagHbwNsxidtYUs2pZEDchDXXtUXK4VBjkqy603Pza
	c7m6NvwqQX8gx6Ae8C1FNLCUfL9ZFrIxXTNbg8HnT7gUEZhIA87K
X-Google-Smtp-Source: AGHT+IHVzDYuPtr1PDixjROU95D2WOpMV8YqDATlijBv/laOgNSF6wkze5o4QPBD98zajktdx5oSsw==
X-Received: by 2002:a05:6808:1642:b0:3c0:4d21:e62a with SMTP id az2-20020a056808164200b003c04d21e62amr17385554oib.31.1708397764271;
        Mon, 19 Feb 2024 18:56:04 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a5bd:9c11:af2b:aecf])
        by smtp.gmail.com with ESMTPSA id j34-20020a63fc22000000b005dc1edf7371sm5500047pgi.9.2024.02.19.18.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 18:56:03 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	davem@davemloft.net,
	hannes@cmpxchg.org,
	herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	yosryahmed@google.com,
	zhouchengming@bytedance.com
Cc: chriscli@google.com,
	chrisl@kernel.org,
	ddstreet@ieee.org,
	linux-kernel@vger.kernel.org,
	sjenning@redhat.com,
	vitaly.wool@konsulko.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v4 0/3] mm/zswap & crypto/compress: remove a couple of memcpy 
Date: Tue, 20 Feb 2024 15:55:42 +1300
Message-Id: <20240220025545.194886-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The patchset removes a couple of memcpy in zswap and crypto
to improve zswap's performance.

Thanks for Chengming Zhou's test and perf data.
Quote from Chengming,
 I just tested these three patches on my server, found improvement in the
 kernel build testcase on a tmpfs with zswap (lz4 + zsmalloc) enabled.
 
         mm-stable 501a06fe8e4c  patched
 real    1m38.028s               1m32.317s
 user    19m11.482s              18m39.439s
 sys     19m26.445s              17m5.646s


This patchset applies to mm-unstable as recently zswap has
lots of change.

-v4:
  * introduce a helper for algorithm flags according to Herbert
  * fix cra_flags for intel and hisilicon async drivers

Barry Song (3):
  crypto: introduce crypto_acomp_get_alg_flags to expose algorithm flags
  mm/zswap: remove the memcpy if acomp is not sleepable
  crypto: scompress: remove memcpy if sg_nents is 1

 crypto/scompress.c                         | 36 +++++++++++++++++-----
 drivers/crypto/hisilicon/zip/zip_crypto.c  |  1 +
 drivers/crypto/intel/iaa/iaa_crypto_main.c |  1 +
 include/crypto/acompress.h                 |  5 +++
 include/linux/crypto.h                     |  5 +++
 mm/zswap.c                                 |  7 +++--
 6 files changed, 46 insertions(+), 9 deletions(-)

-- 
2.34.1


