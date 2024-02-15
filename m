Return-Path: <linux-kernel+bounces-66558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23123855E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32B3281985
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2196C1B956;
	Thu, 15 Feb 2024 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="TQG+iyxn"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8523417BA6
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989823; cv=none; b=tCiZQn5YHzHOy63+b+dartyquc8zEOB4xkR2wkdV5tBg+HRZxucsXL6XwsIisrGFt9H8/C6k17ZXGNO63BFvoHC0RtbZq4XmFM3NmZV3XHAZ7xhydup3V8raT/SPaXfmynccc6sW6EnsyF6KkTXOYiCMVIi71irzMB/h/PY5g9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989823; c=relaxed/simple;
	bh=xUBeVNY5mqTWjVsqFsHwlt9icptll46YRyGdat/hD6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QQUUlCHALk2Kx1GjCxTxNdYWdWW2O6oOPLec7kcgMI3GBWgZSwRlRg0DHQYxDT2jPQPNjw1vTo25TVVRr4CgDLDxqOjvbsL9g+PAY8cuYg5rM/uf4A2e7+T9BGdllJoUu45w8lDJM56hqhvigq1yOuShg7tlbswmDeQ7QpL6HEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=TQG+iyxn; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a30f7c9574eso82267666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707989819; x=1708594619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GL6ddD5YKfOqRj2RNy6xNtOts5S4Jrg36FUNpDVDuuc=;
        b=TQG+iyxnc/h06yz/3oGbWd5uEICugybXWLY+DMR1HZM9OXiQOmAIVM/Mt5DSyaxZKA
         UT236ix3YDlFcspWvEMqo8PLTQX/5nJolB7Ga8pYCWb/KU5Twr7ILXTU4wdYtlbrB78p
         BKmPvKvWHSB4bMT4Ffq2pv8xhRG0lAp5bs2nCacyAoBt061MhDHOMQI7i9q+sbGEmgjW
         snuqUevNA3esDClhjSwTUrHUSZvuHihi41qFaq5bWfuYK8RvgeRoAC++81Amu9Q2Jh7s
         10a8g9jHsRVJmgzftATFe9T5qSkLSyG2IMwm+WBSLhDlAvcbCfnmyhAJgS8+kd5dj05u
         ak1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989819; x=1708594619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GL6ddD5YKfOqRj2RNy6xNtOts5S4Jrg36FUNpDVDuuc=;
        b=S08FcO0oel/EOCeIlE5U1c7SjZndG7QC92HvAehvE+q8j3bVRZ3f/noYCZMj5D0+Uz
         GXOXZvS/GXGHqbzklwxPr0Gcq1vrgxJoRai8iVtjJuxZgfDQedQzCuKi/Cv2crXYKMoH
         jZFwD+zlyWPtFvgtXQd5uGv2j1GzKdXB22rHahVznD4TWVGIZ9HPoNPGwd4UiPdMBtl3
         RIIUlD3pqtW2j9ieiT20QDE1dSHh2my+hkQUFdtWH11D1TxVODWj2iGGt60usmFaY3Rz
         +Gk+aOty+uF8XEDlgdStet/faXChdAh2ZwMURD+vqsHPKQyIoZcrD+ISsdj5fTciu1gf
         7LYw==
X-Gm-Message-State: AOJu0YyiiAccA958jgKLPWsb/5u84offjo5a84m8yfCLfawzaDGrXqYZ
	A6ckKz69jUxkTDszLcVdy8xCaSRybfntpf/9wKJcUTy8b9ZUT0BKcFqDt9HBv085Snj9NxH0qRn
	O
X-Google-Smtp-Source: AGHT+IFKovbvRD4nM7jYJAm/c/6mKzcl/mhel0DkVeHVpthVNm9Y0BUq/Ofiw38jouZkypaeeI6laQ==
X-Received: by 2002:a17:906:f9ca:b0:a3d:2cce:a8df with SMTP id lj10-20020a170906f9ca00b00a3d2ccea8dfmr758183ejb.36.1707989818839;
        Thu, 15 Feb 2024 01:36:58 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id rg14-20020a1709076b8e00b00a3d09d09e90sm362059ejc.59.2024.02.15.01.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:36:58 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 4/8] linux/random.h: reduce dependencies on linux/kernel.h
Date: Thu, 15 Feb 2024 10:36:42 +0100
Message-Id: <20240215093646.3265823-5-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215093646.3265823-1-max.kellermann@ionos.com>
References: <20240215093646.3265823-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This header doesn't need kernel.h at all, but if we remove it, the
build breaks because kernel.h includes limits.h and log2.h, which
random.h needs.

list.h is also removed because it is not needed at all.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/random.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index b0a940af4fff..3183025ddda9 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -4,8 +4,8 @@
 #define _LINUX_RANDOM_H
 
 #include <linux/bug.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
+#include <linux/limits.h> // for U32_MAX
+#include <linux/log2.h> // for is_power_of_2()
 
 #include <uapi/linux/random.h>
 
-- 
2.39.2


