Return-Path: <linux-kernel+bounces-60758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052E985092C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1381F23C49
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A334605BC;
	Sun, 11 Feb 2024 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ZhnjJBq9"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633695FF06
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654649; cv=none; b=qv/iaY53b7TW+QRoeH8LEkv+kcjRB+vfueJ9ZrCZvPjxzy+pqO94d7N4Kx+rnrJCgmJkz9SUovMPi6CpDfo6VgGsJZycfid9zVAterc7hZjWLfKmhOUQKyHt2RIZxTPYZxjZIyivZoyF17Q59bfxN4IGRQxnAgQT/4Cpkq0KVik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654649; c=relaxed/simple;
	bh=FaWrvDRhCn6qo66e2LFY1/am/fRiqeQ00xmmtBjY9fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oxSWNAUuU64xdltxN18pV/EbERjF2gOc8IgFg7ZwucVVUXpWYWwlpvFZJHPvE+h5XJGoTrKXbGp/OWietGq0VYarH8wrXLmMBSSjgQdtFF96R/t/vUXXQP6NHC1PPnhgdLAqYGxIKV2jesMFz51up3N74GB5u2BaD5NqE56IG2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ZhnjJBq9; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d0e2adfeefso18219681fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707654644; x=1708259444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhd0Wyk/ZgeZM/EU3KZ6LbkcM94I0OFOZkDaLa9LsZQ=;
        b=ZhnjJBq9UlbZIahyq8LYfJIU3IheyD12vYU0g98Givle61VZQr3I0hefCz5Y16Nm9V
         3q78+kZPHIPxA873Qmfe9JNhZH/hv/3zmcnfPvy0V5Ac61oXNAH/tH5oQoJsfvJ5p3hz
         ydHcDuitgUhtzxTrTrq8OJUBSo8EmU27uE7hxDcN8iXtDk4IOe/mdc5EdCZkmjmLn6qW
         tSYJziQR9ybARHH9XdOWJVqR6hNmgWzWXcK/1znP2ehlBUIW5bC30aWGfLDxO2cdvXgG
         57bp1fFaJxoq7LXx6UTZVHXrjmRzAKZIqZYKSBvsmzSoF0QSBNYqhTfHIUeEcr3bQHdH
         Bvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654644; x=1708259444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhd0Wyk/ZgeZM/EU3KZ6LbkcM94I0OFOZkDaLa9LsZQ=;
        b=AEbZwQ6cdh1mQC1ElTyJ1+HrUxK7PI+kK787hsw90v446C8TZ32/HJS+lbGyTtzIvT
         BjfPT7talud71KgqHuPgiXDYktjJ42dN3u/rWSb+5rZh0tmf9z7SuuKqzz4inx8Lw4nL
         BdsPH+Kp8HYyV3TBZm+VNkxexyqhLWzn8bpy5q/yXkiqXOZ8oKhKS+t5ORQet5vuTrYl
         8F2kOOuj/r80hHqLc/KL/wvYjURiuBip7JpXc6D+YVTitBBB5x9dsluIFaK/ev0ToT9z
         7yjUV5SptEFXsbQKDlcpOEvDZ4RInFYAIaEzIJExeRuQV+3FtYL8y3DSO116vQ0e7vZS
         TFLQ==
X-Gm-Message-State: AOJu0YyD2SuJWKCME7mH+q0pUnrHZkgHORiQgjhKybUgMPEgZk6A2JjM
	jHDpQUw+jJMOhsRkayNBh7HvjJIWt9+3O3uyWpQYKqY+VhWa75+M1t0znOFgJSLM941wyrgVk20
	y
X-Google-Smtp-Source: AGHT+IGe2JCDcv2zmH51jFGl38SlUOBmvxv1RcSyvmLnDS+lCsrshqS+1OGZ+4Y8ODu01VNPs4AB1A==
X-Received: by 2002:a2e:a498:0:b0:2d0:c322:7638 with SMTP id h24-20020a2ea498000000b002d0c3227638mr2437312lji.39.1707654643909;
        Sun, 11 Feb 2024 04:30:43 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id fj18-20020a0564022b9200b0056187ca4120sm1024611edb.10.2024.02.11.04.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:42 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 29/35] linux/random.h: reduce dependencies on linux/kernel.h
Date: Sun, 11 Feb 2024 13:29:54 +0100
Message-Id: <20240211123000.3359365-30-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211123000.3359365-1-max.kellermann@ionos.com>
References: <20240211123000.3359365-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/random.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index 70e5250f3bc4..3183025ddda9 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -4,7 +4,8 @@
 #define _LINUX_RANDOM_H
 
 #include <linux/bug.h>
-#include <linux/kernel.h>
+#include <linux/limits.h> // for U32_MAX
+#include <linux/log2.h> // for is_power_of_2()
 
 #include <uapi/linux/random.h>
 
-- 
2.39.2


