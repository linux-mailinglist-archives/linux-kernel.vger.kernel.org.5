Return-Path: <linux-kernel+bounces-167022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DF68BA383
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4A41F24F24
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66B21CD00;
	Thu,  2 May 2024 22:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GXlHVmV3"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D312C1BC2F
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 22:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714690421; cv=none; b=EwATZBgRJGkeH2djFC7BThgpK2paZTDVdBifrkaMU1LQw+d0qGI2BEElC2vKczFWPMQ3hqzK6kDAldGIQjiGJg3LNyeTmliVunQOcZ4S44uYOT/285zrfO0Acp+H6nSDY4XcRROPcnD0FA2DIl36eAeCttLNBtoSKFHJADLHyHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714690421; c=relaxed/simple;
	bh=9EIDvlKn8H06U3Ns7X4JkY7FQixrkq70JScwUwcT+Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWBZrlyn+fBqXH3DeBsx98IDiIm5qE/M+A2h85IwAvqAlF3PNArziE139FGuRmWnQTwY3KNBYH2C3t33oxEFrqp/MekfCoHPM6Ze4XwYaFrDodNOvwAvQmplxajgAQcc4HYzqMk7xLJCbYRHWXkU6b5z5WNv6/wiZ+19RTEnYyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GXlHVmV3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e651a9f3ffso46083355ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 15:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714690419; x=1715295219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+CbTYcuXhAHq3pBgBZF2uLGBq5IUxFnRXQZTgCCuoI=;
        b=GXlHVmV32OySEyfV2tzM7/Zcoi9qf2XbShd3IE5te99M4XGjmb8J3ysGDFySvO7HIv
         vrNel25xbPgx7HNUQiV2speMTI9EWLue/TrCaIBTqLOi+XZfgihfJIeWAAVy08HbJfqL
         YprL+VAkMM6uFaXU5wbt/9fBVGbkGwuZE2tLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714690419; x=1715295219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+CbTYcuXhAHq3pBgBZF2uLGBq5IUxFnRXQZTgCCuoI=;
        b=hTS6gpFFi9/jYdUh1Rn4gY63lvzGdT8JrEMMfS2gmXSEMxD7gnbuSoMomKq/5SFpv7
         8I2KaQOSOJh7152ejWtNf3RLE1hzoYG8UojSqn04U4tnOt0u5rKxl4gImLsBuD8Md3xK
         jsaevZ2nli0ulb5CLQfracqep68OAp5J0IgIt8NHx43PTB8ZZ+s7Hofoki+J1wNDnACP
         OHEsixpa5OStfu0nt2UAVFRkhXJKaXm3D4Wh0/mLgQ7pDI0BgxLWTV0xLxXRuGO5/v1v
         7hUQxK7yU9DyZG+gXapfrfDfcHVXxqmQRybX9V20TGM/aMUc0OneUShwSoJ663FcQQew
         DsOg==
X-Forwarded-Encrypted: i=1; AJvYcCVfQ+kkOgFpiV4O37PyKkd2jg2bXUDPLwJLbueUsP6dyFFv6S6p2fJDaDjit+74Hsxm5A1Awqn+LbLzreMppQiEx/rW20VlITB1X6U4
X-Gm-Message-State: AOJu0YzyYM6PwrwAO/HBfXpy6GtsEMhZA2Ax2f7TpGy3tv/eNC7xx0bj
	3MF+hNn/AwQpiPxiCTsbJAfoIjCnDqiJtLt72EvTyxARXXAfH74i57+hTom+bw==
X-Google-Smtp-Source: AGHT+IE828cNgqxiTXs3gOeTLsF+43jhO+3qFfjtUspZftTwhCEXBNu2gvO6RoHEZi05oN6gZOpuIA==
X-Received: by 2002:a17:903:264f:b0:1eb:bc78:1ef5 with SMTP id je15-20020a170903264f00b001ebbc781ef5mr950791plb.17.1714690419185;
        Thu, 02 May 2024 15:53:39 -0700 (PDT)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id q8-20020a170902dac800b001eb3f705ddasm1861884plx.255.2024.05.02.15.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 15:53:38 -0700 (PDT)
From: jeffxu@chromium.org
To: ryan.roberts@arm.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	dave.hansen@intel.com,
	deraadt@openbsd.org,
	gregkh@linuxfoundation.org,
	groeck@chromium.org,
	jannh@google.com,
	jeffxu@chromium.org,
	jeffxu@google.com,
	jorgelo@chromium.org,
	keescook@chromium.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	merimus@google.com,
	pedro.falcato@gmail.com,
	rdunlap@infradead.org,
	sroettger@google.com,
	surenb@google.com,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com,
	willy@infradead.org
Subject: [PATCH v1 1/1] selftest mm/mseal: fix arm build
Date: Thu,  2 May 2024 22:53:31 +0000
Message-ID: <20240502225331.3806279-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240502225331.3806279-1-jeffxu@chromium.org>
References: <20240502225331.3806279-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

add include linux/mman.h to fix arm build
fix a typo

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/mseal_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index ca8dbee0c612..41998cf1dcf5 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
+#include <linux/mman.h>
 #include <sys/mman.h>
 #include <stdint.h>
 #include <unistd.h>
@@ -29,7 +30,7 @@
 # define PKEY_DISABLE_WRITE     0x2
 #endif
 
-#ifndef PKEY_BITS_PER_KEY
+#ifndef PKEY_BITS_PER_PKEY
 #define PKEY_BITS_PER_PKEY      2
 #endif
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


