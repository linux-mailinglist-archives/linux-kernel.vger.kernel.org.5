Return-Path: <linux-kernel+bounces-66555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FC6855E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B451C224AF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEA4179B5;
	Thu, 15 Feb 2024 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="eprXqSW7"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C0D1759D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989820; cv=none; b=PBzLquFeo4R5wvSDpVgM1m/v5j8EbL2wu9PId1jN5+6bQJydgYNfoRRuw1Z5LzFK1S6adTO21svUFSlAYWntvxob+tkSURHi/yEMMpj9CwVnEfYH1D5iujvoi9k/0gsA0/JZx0yputU9iQstMZluENUCBB+vDa47juX2aBZe/mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989820; c=relaxed/simple;
	bh=QFSJlfZ0cuy/SCkf7m23AisvA4XUownlEXQJ0SdvNmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nsQGWhDzXbRDsnx3xXFJiZ1PZTl/3oE4Gh+VQ5QfQSWvKSd+DdkrPUwt5FTNML5EWO8OHTN/KtNub00sMK6dZy8ZkLh6RMPn/N37YTmyp6OLBu5c0KvVlfrAB0KdILP5mttQOyAhqfyVSrXboKyv5vLMEtVUNzQPI5v4PJ8I1OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=eprXqSW7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3122b70439so71933466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707989815; x=1708594615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlOv7BRUYrcRJiYDdqOKsBmYsp7bUKSz0hes5xiUYu0=;
        b=eprXqSW7HbG27C5a4OluLa5l1kqssxi5bAQgTOSxQWrg5kfkDzBF+cvgmOj8EHsWYK
         lMjeceHXhP0nTIkLOLSMaK3zJBW37wf4WbrXokvP6xoxykqHT2LzcX9mIWudNnpju8vY
         xoC2xxFB1EFEY1lJncuUDY7oKmt6V7rxMq/i6hrvRpJPlHncn3i37d2EbU/bmHP4znvI
         jhMTzFA/WvmJ3ex+4BIHnbDs1Kz6g9vrPoDhVr9u3+pFhqYFU9fCL83GrEr1NehfmyB8
         mBw8Ll/IamKLSjMJq0jfwv7iN+bUF7Aiuw10UQNnvtBIGE/CUexRDonbhRMZ6iJYeH+t
         D78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989815; x=1708594615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlOv7BRUYrcRJiYDdqOKsBmYsp7bUKSz0hes5xiUYu0=;
        b=NYXUAPwp6bsRUZzNv5yRLkLfu7ZbFMSii6dFWfRlxGwL3RPhRKcv7ZaC0qNgXWGK3f
         RMP34bgg6X9ka2C66UfgaiSlXGQcexQ5WOzYu2wE/Y7YCo5XWCvfxNZhW8cmOfJZDv6t
         ZUZ7DebrCCPv0pAfSyeIEs+pcP4ZAqTZFPf0TcDQtBwXP9UDLxc35A7Z+9o4tlcNrRdl
         8VCtcvPSO9WQY9ponUcTh9q4k3nxJ7RQopfu+DtoKtMP69SKLpr7Yij6flkRpvHhvG0z
         9cx5QLFs4X62rBFrnAd3e5JwsOHbGntYImdKdAridPp5lB5vVnuxKX0GiEzs+lVcZMdR
         5jVw==
X-Gm-Message-State: AOJu0Yzb3Ci9btWS4J8gnvuxrnGrLS8+2gG+0Gm7GlViNqjphk65Z9th
	yc3qk8bpcwfDMsuqC9X81XGMcNO4xPXj//bOpaDO7m+rtqjDIpwzOcNisi1SZ1JY3BtBY6kfPxz
	g
X-Google-Smtp-Source: AGHT+IFp147rXeL/v+hUBunybZpFHkLKQGAb7OwuIF85O9OLg9OS7wvrtgVouk3T/iQW/vypc+5yKA==
X-Received: by 2002:a17:906:3bca:b0:a3d:6b5c:ab22 with SMTP id v10-20020a1709063bca00b00a3d6b5cab22mr852168ejf.64.1707989815555;
        Thu, 15 Feb 2024 01:36:55 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id rg14-20020a1709076b8e00b00a3d09d09e90sm362059ejc.59.2024.02.15.01.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:36:55 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 1/8] include/linux/goldfish.h: include linux/wordpart.h instead of linux/kernel.h
Date: Thu, 15 Feb 2024 10:36:39 +0100
Message-Id: <20240215093646.3265823-2-max.kellermann@ionos.com>
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

This header only needs lower_32_bits() and upper_32_bits(), but
nothing else from kernel.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/goldfish.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/goldfish.h b/include/linux/goldfish.h
index bcc17f95b906..8b2b3046f779 100644
--- a/include/linux/goldfish.h
+++ b/include/linux/goldfish.h
@@ -2,7 +2,7 @@
 #ifndef __LINUX_GOLDFISH_H
 #define __LINUX_GOLDFISH_H
 
-#include <linux/kernel.h>
+#include <linux/wordpart.h> // for lower_32_bits(), upper_32_bits()
 #include <linux/types.h>
 #include <linux/io.h>
 
-- 
2.39.2


