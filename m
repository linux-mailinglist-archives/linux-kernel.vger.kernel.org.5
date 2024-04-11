Return-Path: <linux-kernel+bounces-140762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 627218A18CB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2E2286449
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070F82942D;
	Thu, 11 Apr 2024 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vcofsKwE"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF08C175B6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849501; cv=none; b=R0Y15mZQSeX7RCFd9lq7BntFnkPoLkpIOYSB92+xkSaHf3bAHpLh6xhIApIg46SJK/ZixUEaQygi8wqn8wrD8AVd13bT4je2PFAQFczJz9IYRjhZEc3zEy87tFAaXKjkly/MAUCndAGtN06yf8KLpzbqEda2HpGwNbooI1BUoKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849501; c=relaxed/simple;
	bh=lByMAmP/bbUffqCYETCfwR/ZFzEcR8ezQkT43ZT+D/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcaiQwkJCzx2sXjuYnzuJiX37UUPDYjCk336oHMyKj/yTeh0wXdcbnhy1bRh6zbU5GUlbGT7/UUpF4k8BsaACBvlQeRhUOWhkrqDCMIb7MmIhwY3PMjVLzex9LZiGDdVYeUZARPAaIOsYMpWbeC8to23Ofj0FW7smBpeD4K+HD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vcofsKwE; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8839739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849498; x=1713454298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyjmCiDv8/AuWdWDdC9UIgQd/LSQc+QJ5y9KcOhexxA=;
        b=vcofsKwEh2jbb19x5tE7fdUMkxKQHR3rS+rCy4G9fX8dLsQJHfrSMQ10cBhj3hjj/g
         OOpHEw8muEfkHucV6Os2Wi3Ni8lig/0unEpG7IMZUF7hGhlXZgrwrM+OACK32hmVbOrc
         wwn+zy0IA4JJDHpkqbCvFFh1tT7AauMcIMxdpDotLaBvsIjw2BgGWWRVAI+eVuX7oX2P
         wIdXLfu9X165mVT5K6aAd+wxYnVza4HYtHhg0DyciAIkz6jvtNYGMlN4oWiW99jrQoPM
         5eSjqF1x3X13qPq8gnz4Hpz58L/L0NVaHWaL92BYk84sbDfCMRy3rCqQ3LUx2mU+IFFj
         GO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849498; x=1713454298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyjmCiDv8/AuWdWDdC9UIgQd/LSQc+QJ5y9KcOhexxA=;
        b=uKoPd4O5p7D+5+qV0ayKXFoIeYI0hA/jQjgOWceqa1kWkMNX22dUWWRkvHV8auYJR2
         610oTMr98YBG0pTq2q9WTCo2qx9nt0WbiOfpWUQeXUB07aWfDeQ3yfGxKPFfN/Dr0L0F
         hzcUZVpLmNKGU45uWkq/hW6bf42fK2CBcUMldZD6HR9lfbvMtyua+sCKabXI+jw45bxT
         XL1r/XP5yrvjk1m8RfaSj7A85b36kEKbngrieFa9TIHB6MWHm2Vs5zXtC4arfqs+JQlC
         vdsqZ6/fN7mkDaTi2NAc8EZPg8j8dAdzS4h29h4dHNrzsF4s3Qx9S4CL2W4nXMdCGoB1
         m+kg==
X-Gm-Message-State: AOJu0YyzbnR9wZ8Py17//qLvDY1cnQYvIeWk1k1va3Al/wTLMXn6+vXP
	wKdA0iRnzetl68fLW98wUYpnpJMCDtiYFc7xDjHvTXCuC1xpglLng/qdbTyRMZsE+xhx/R92HoP
	h
X-Google-Smtp-Source: AGHT+IF/Zv6/M+w5OgViYuucAryQKlmVBuJXmIK75XBDzS3pMuqbLpNdJs8sjmzCUnM4NMrqCLatpQ==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr1225ioc.1.1712849498660;
        Thu, 11 Apr 2024 08:31:38 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:31:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 006/437] fs: add uio.h to fs.h
Date: Thu, 11 Apr 2024 09:12:26 -0600
Message-ID: <20240411153126.16201-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most conversions will end up pulling in fs.h already, but not uio.h.
As the fs iterators will need that, just include it from fs.h rather
than need to add it everywhere. It's pretty natural to need user copy
helpers for read/write operators anyway.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index f75049fa1d50..5806cea7a3ac 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -45,6 +45,7 @@
 #include <linux/slab.h>
 #include <linux/maple_tree.h>
 #include <linux/rw_hint.h>
+#include <linux/uio.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
-- 
2.43.0


