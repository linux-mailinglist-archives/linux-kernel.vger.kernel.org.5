Return-Path: <linux-kernel+bounces-66556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A548D855E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85531C22561
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8DD18637;
	Thu, 15 Feb 2024 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="MFFOGtBB"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C54A1759E
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989821; cv=none; b=WfQqIWTJdbEoiFwLQ/5kKgxM1Ji6b/mK4oFNBO96TZ3Ie7F666JJNGtUmOJgT5Cxl2PInmbW9XUGDeHVrgz69YEY+s04RJYZ+kuS8BTnHyAx+9mstR1EKHuBpBW8IAEbEw2ezEvhvGHT2Xss5n4bnvjO6UxsyNl1E88lzOYiVrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989821; c=relaxed/simple;
	bh=lWTPwBKh6CAzhCcPD0ePdAhVQq7zZq5SFvy6M4Uovwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ac2UpuAT6Y/L/uXKc99AwaRte+7Z319gZAzoTa/bJrVUQFCqrgbf3yGb/uGsuJOOCRcEQgLS1VpgtjBmkTVP/8UkyxVGDAjwkd0FwqIiHo33MhXvS6G/U/yPnQaN6AitxPaftbU+2NHJjwdjwB6h8WinKkRXj8KCMY2Qbfbr4kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=MFFOGtBB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a26f73732c5so80773866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707989817; x=1708594617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0xEyIIS/tv0UXDMyOsQAyxi6COhgq9kYeUYOeDXc8c=;
        b=MFFOGtBBjEeZO+VC59RR9FXkmH3YMjuSJYDhEsJ6PU7dYhYDf4mtkjkkbL45e+dpDw
         d10P05S6/xx9hwYfscGR3CUQ2/qaUA5MEET5XR6J4rI8gUrwQu4haCveBp4T4FI8LPxD
         N6HO1CpQZYD4NIE2eAOzFJiUNlOjgwgNT7qd0j2ElVpspB9YdX/yjoTs/uGl+OneBRvv
         QpN0TLkXRHDMX7ZC44SFINNbzVbWzkZ+ISHEZZAPRaI5AWx6OMCWuhNEfHcM9ugGH+r0
         kVEVtRc4aJV4PapyHw/f24I0WO5fsVbCph00kX7+NT+OicOB8DQyrFc/JicKykQpISW5
         OD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989817; x=1708594617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0xEyIIS/tv0UXDMyOsQAyxi6COhgq9kYeUYOeDXc8c=;
        b=XPU9NDWEGGlgJRhfPvI84IIAHJNgScoGKpaUfhKrymQq9qQBEksTRZq3l1y/K8L2VL
         pX4Baru731YpmErM8gMidbzjxvgcv7tRY/D98+dKbfKPgSpj3ok9vQZlb77ebhwQZIJ3
         CdwXS/XxFesnApcGFlzk0WN2pM3wRvJLRAaZxS/+BXQcDetceaQCEYlMUNFcwZf5zsn5
         dS2HLAJQN4OoHCIlxo6UpgK1E9/dzZG07Mi20jnXruHrV/Hd/6xGChSqWXEenN3aXarX
         Ly3ddiWThuzRKJhb9vJbweoltLfeRxc3mDbA+gOl3VWQqkZwbex5fqReyOZjKKvRgErL
         2VPw==
X-Gm-Message-State: AOJu0Yw06GSOzsad/fE1jksmNCQJR0H+CfTZmhFjo8ReYrQisHRmVBUv
	n702tvkuwPghKlAkXpAozmdkAhzRXzpKPDFbFkEk9ypY3l8H1inQtr1fXfTegZEYHLwXQc+DsZO
	j
X-Google-Smtp-Source: AGHT+IHFm7jDUJt+CrTpA4FBEWfq/7UW2/LEyOXohhylCos4LIsb8QXyQk6urj5P09j6MTjQtLxkmg==
X-Received: by 2002:a17:906:4ec1:b0:a3d:1170:e6e3 with SMTP id i1-20020a1709064ec100b00a3d1170e6e3mr873474ejv.14.1707989817485;
        Thu, 15 Feb 2024 01:36:57 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id rg14-20020a1709076b8e00b00a3d09d09e90sm362059ejc.59.2024.02.15.01.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:36:55 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 2/8] include/drm/drm_fixed.h: include linux/wordpart.h instead of linux/kernel.h
Date: Thu, 15 Feb 2024 10:36:40 +0100
Message-Id: <20240215093646.3265823-3-max.kellermann@ionos.com>
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

This header only needs lower_32_bits(), but nothing else from
kernel.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/drm/drm_fixed.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
index 0c9f917a4d4b..ff9a91fa40b6 100644
--- a/include/drm/drm_fixed.h
+++ b/include/drm/drm_fixed.h
@@ -25,7 +25,7 @@
 #ifndef DRM_FIXED_H
 #define DRM_FIXED_H
 
-#include <linux/kernel.h>
+#include <linux/wordpart.h> // for lower_32_bits()
 #include <linux/math64.h>
 
 typedef union dfixed {
-- 
2.39.2


