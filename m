Return-Path: <linux-kernel+bounces-84103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C098C86A233
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C911F24486
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E624157E9A;
	Tue, 27 Feb 2024 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6RraZgA"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E2155A29
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071853; cv=none; b=INL/NqsAAFJoLYIzUvF8xANmOlvEPCOLu+k01k3R8okxQDnOoc1AB7Z2StgW4+zLdPh8iupcEqZnRRsTbWJsUVl/JsvaQGCU7RV9rdU5vutZqQXAH0bdC3zumciekH2Z5T7xWkI12rhmLFRtJwCDl4EbybL7hsBbnRYXQE1PPGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071853; c=relaxed/simple;
	bh=sD4PGbM5HqA6toI1/CAMqbYx9lSjxRaalfZB/ur59io=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dms4OWsPJLlt6MMiYrOtPXIUCVhKJ/3HRGViwQFQDEodRXC2g2i0G8INFhqpTiMr8+8sPRM/wlCfrxyF1xx0Phx8WuaKEat2aQrS3iv49P00kYI7Jj6uWTeyzzg1pz149YOc5cMQQFFyGhD5K8OKTcuHSAbBIMmjdTCDmYOJOiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6RraZgA; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33de6da5565so1137405f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071850; x=1709676650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieLYzymPNePmb67aE/EpZNATNNR4k3uKBe/0iiseYBc=;
        b=H6RraZgAYJAQovkkGi4bmyI+U647crDPHWVmTK7z3+GRJ6CIxXpe4mPEgonn+/7Gll
         k3RhKh95mYeN2QS+r6vwNd0MYVDbbchRljeopMEOrzpAOXtG8zON0SkbK6aHq+4Hqco6
         xWwAFew8CFZYXvomR9iP2kJ2DOOY5alc0YxhICC9KqgWNk7xuVfd86F1sbszTpIxN/6m
         eiquwqLapMvG9b0ab6E0ZEKvrQsGa8LXkpalrX+0eJsoxaYW87Co/6G5cPU2SlBDlQXN
         yqVDHt20hbcVhR8zWKp45ESkeT6XF34pYdRqnacpDUJb9lSxO2QCXa9hiN8TspK1Bnu6
         EPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071850; x=1709676650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieLYzymPNePmb67aE/EpZNATNNR4k3uKBe/0iiseYBc=;
        b=DzGCPPqBR0YrelaPsUvMGuiLkCjHgkdtT3syD67VFeQVUV/sutb34HA0q83nIepVX6
         wJkN654ow6OHmdiDguyHPGq7FkS9l0DCQ7wRvjH5zUCviCvq+/uOamcjD/jFGhUn5OeE
         JIr695Ox+ZHMoSteEn4OOHWeOtTzHhS4H/nDAMQDNXS+L9HiiUPWAO9z5E/yaz1TamQf
         5aX3BK5K9bwE5vlFu1IRW3EylaCfeWfCvjSN5rbXB/mkde/vzxvIDlori2kvpU7cXBSo
         i5B0xOPVfssq15vX6ICilFl/MABERjXIw1Zci0jPZVU5YPTlBEcGlEIwPwxL+I7rdUlZ
         n1pg==
X-Forwarded-Encrypted: i=1; AJvYcCVJR9LaW5VKqhVckrLfNKsk7457RZULhNsKZEDg+UG5VeZIiWEppDUtU8hLHmuIBL9Mdn2poaSpC3UR8asvFQ9PLN0d19D6CP4GTwiQ
X-Gm-Message-State: AOJu0Yw0aRT4OAqvF4fcctlA2fqLIQFnULmMJLtBEZcvKY6ZSyBxc5Rw
	vFqwlC1/KI2p+XerG9pGyUgyFcbk6SZ3nMlMvrgyP0qrRPEg4HgL
X-Google-Smtp-Source: AGHT+IGYtdr+FWlrBEQO3ynd5gZ/hRpOp74coj4n9RGoOw6Ao9Edw8bpDsgv1AZ56mQhX/jHXfSCNQ==
X-Received: by 2002:a5d:468a:0:b0:33d:50cd:4672 with SMTP id u10-20020a5d468a000000b0033d50cd4672mr6627351wrq.21.1709071850411;
        Tue, 27 Feb 2024 14:10:50 -0800 (PST)
Received: from YOGA.local ([2a06:c701:736b:f200:73a5:2235:8954:9b7c])
        by smtp.gmail.com with ESMTPSA id q2-20020adfab02000000b0033cf5094fcesm12562384wrc.36.2024.02.27.14.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:10:49 -0800 (PST)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] staging: pi433: Redefine F_OSC using units.h macro
Date: Wed, 28 Feb 2024 00:10:41 +0200
Message-Id: <20240227221043.532938-4-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227221043.532938-1-ikobh7@gmail.com>
References: <20240227221043.532938-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use HZ_PER_MHZ for a more robust definition.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/rf69.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index b3b8d1abd3eb..5a1c362badb6 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -8,11 +8,12 @@
 
 #include <linux/types.h>
 #include <linux/spi/spi.h>
+#include <linux/units.h>
 
 #include "rf69.h"
 #include "rf69_registers.h"
 
-#define F_OSC	  32000000 /* in Hz */
+#define F_OSC (32 * HZ_PER_MHZ)
 
 /*-------------------------------------------------------------------------*/
 
-- 
2.34.1


