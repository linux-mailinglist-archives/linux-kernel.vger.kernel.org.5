Return-Path: <linux-kernel+bounces-39459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7189083D175
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43981C24E30
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F745800;
	Fri, 26 Jan 2024 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="03J8gHrI"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB6B4416
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706228762; cv=none; b=Z6u4MNOSS5cbr0E3Ac/73ct+Q0/Pk/TGGKQ8aKXvGNsLwu+HonYC2SHOsnpLQXLGxAy5R11lxEo0aq3/nvpt+X/VuPc92CmnLTHwcS0FhHSq/so1zZwGpJPr/jlHLivXSPSccac+fSba3/ljUNfBYw9rG1r7xH89v8fBh9YPQKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706228762; c=relaxed/simple;
	bh=6uc9Il8X4Kn9u6X/lHrXvQxTWpXcD8ov8vlLdijWmI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U0WfWWNyX08L7At/u0fcG4zDTOsrqYehNSTfARi0SLXKjwSOtF27wN51d7oI4YbFMaswUo9jy5i5QNYpnmiuN5ZSz9ve+ReC2qFvmWKjBgRlbBMuO/7S0x9BDJ1s1V/3RW0ROU1oL+bSDKle/tPQSxiTllGtghLQun8SS+2Y+Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=03J8gHrI; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bdbf401bd3so80748b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1706228760; x=1706833560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C3n8jP9y3uPiUHRGFsi0dJRm8wXS2AMvfgDp5gCgG2I=;
        b=03J8gHrIpmQpsE9x+BgZlC3yjvO4HdHQH+lw9Ewx6XxsPITXcBcm9et+zrLLldQrkP
         xoyTE0bOZBTtks+clEwklz5Q/ZLEO18mgmn0aLxedIqRww2nFBr/jjwgkPgu+AVyxX7h
         R9KPHx/SP53VHTJ6ksh4xOe7q02uP9cWf9RTT/VVsyTtFOXedO9dd/HWQVCDrT7wN//p
         wGYKOLi0rgq8o498bGpoEnw4mHRgDOHAP8L3Dwx05yyAt6umDWdObpzJUeYYfMPlTN/E
         jd4gTTfVXiCYOZmYFzpETHTgM6FLf23qkI0DyG0xKrhxCH6anzrUMlxLHKFm/RiI0zg6
         AkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706228760; x=1706833560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3n8jP9y3uPiUHRGFsi0dJRm8wXS2AMvfgDp5gCgG2I=;
        b=fPVh7+ZfuA1DCMTmXtjVuPKMoUzsRTGxr6+twtBgXtF0DJ5WxCakVvRiDKm5TLuTPl
         BFdozkQoXPJX6fFI2McwLHQljNT2PYVhmdTDegRJfkyNs7svtZhGLzbFL4z/XnQpkeNk
         ntFnVacypD0cHbK4lvjj4bYu5i6nYcthkNzipOL/xNz1iEqlfUv89BI96UqH5XghnmYa
         jlnOQlXMnHwfoUa7H0wlZC1+2oZ95nXxXnAg+VsWeTChzy6ipGkGkt++lCr3AgOGVSMw
         qp1DEbSxV7j92bH7NPlKMKdbbvSgG/vrAbtQXo81dd6CMoFz35zXVBtE94q957FyCT0F
         OU5w==
X-Gm-Message-State: AOJu0YwLvPEfYGz4noYVl14tcUsCrZslEhDU6fQXg+iNdLxqqX17kbR0
	mLI4b1ZeNuPULAi7rOmhLQb6UEFwP4kDLj5mmpJyCOuU+sFA6EDhI3wHDsHgud4=
X-Google-Smtp-Source: AGHT+IE/l4nfki79DW5euAJFiOpD3tcFfj8oyrIXPYUZx1gFWpArOG8xx095aAJtVb30fjNhU+gWgg==
X-Received: by 2002:aca:2103:0:b0:3bd:9d4c:de with SMTP id 3-20020aca2103000000b003bd9d4c00demr563865oiz.30.1706228760099;
        Thu, 25 Jan 2024 16:26:00 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id n13-20020a056a000d4d00b006dddd5cc47csm105379pfv.157.2024.01.25.16.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 16:25:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net/tun: use reciprocal_scale
Date: Thu, 25 Jan 2024 16:25:11 -0800
Message-ID: <20240126002550.169608-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the inline function reciprocal_scale rather than open coding
the scale optimization.  Also, remove unnecessary initializations.
Resulting compiled code is unchanged (according to godbolt).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tun.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 4a4f8c8e79fa..e335ece47dec 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -54,6 +54,7 @@
 #include <linux/if_tun.h>
 #include <linux/if_vlan.h>
 #include <linux/crc32.h>
+#include <linux/math.h>
 #include <linux/nsproxy.h>
 #include <linux/virtio_net.h>
 #include <linux/rcupdate.h>
@@ -523,8 +524,7 @@ static inline void tun_flow_save_rps_rxhash(struct tun_flow_entry *e, u32 hash)
 static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 {
 	struct tun_flow_entry *e;
-	u32 txq = 0;
-	u32 numqueues = 0;
+	u32 txq, numqueues;
 
 	numqueues = READ_ONCE(tun->numqueues);
 
@@ -534,8 +534,7 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 		tun_flow_save_rps_rxhash(e, txq);
 		txq = e->queue_index;
 	} else {
-		/* use multiply and shift instead of expensive divide */
-		txq = ((u64)txq * numqueues) >> 32;
+		txq = reciprocal_scale(txq, numqueues);
 	}
 
 	return txq;
-- 
2.43.0


