Return-Path: <linux-kernel+bounces-37776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D6B83B4F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57EEE1F21975
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A9313AA59;
	Wed, 24 Jan 2024 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="BRNkX3mt"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262BA13A26C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136307; cv=none; b=s8P/mR2knttMhzfwI2NPxvxodjz9oqiKVXhx5Vy0IvQFD/k0MJGOHTKy6A/T//hskQcWyWgaIeW4HvKz12/qJOcddMSB6FnZe522H9oC14cXm48KhcjwUwXxaZmDgNg/QDjClE6CO3bMo4Aqoieg4rlQKgEExSvuvOF/5BlVDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136307; c=relaxed/simple;
	bh=O4oUVRv6jqrt3whAsGKLEujAtFvYsKLoccgExo0bZ84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bM+elrwKMlkAxxyrFOL+bJRv2XgfHKq4RdOIY4m4bk2nz2jRZk17bbyq95YFFohpFJwquVhV54CPTA3XWBirFsscGlsn0pKjezSqD2LaRkWAJaRWj3YU40pFzBHLykjn/qJvTCjWdEz8obk0WSoNb3iTviZJmW3IoHiLc5d+lgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=BRNkX3mt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d73066880eso38174585ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706136305; x=1706741105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQPFmmirFE8/ufGIcphQo/87vvOYqOFWOKLJtYmivTY=;
        b=BRNkX3mt0OPIXiOg0z+gkDEF2xLhim7eMr5CSATF2Ns6iKkZu7j/U3w8vMKhykDTWu
         8CH+H8Lu7ExM5P3J1pfHr2Kh7MqHXJMA9yykHQEZ9X8StltyitY1pBqGrommlQH5DtUA
         xQ4SJqcnIcJDxvEKJ+I4WLEWg/Hq6pH08XTQSUY2tth9BTXlhOuVtmjw+XUDLIiRwTId
         YIlg5PsBGQ2AlU66H9+B41llDFRWFmSxidD9WF3K7g60psTrN6Dbr3UlpeCO+w0LKW4t
         ro6lINknJo34gHCVw+INGDETYZy4xv5qh3UZ/A/Nu9/O8JMIsZnjqMHbUCuqf/0l2YF+
         FjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136305; x=1706741105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQPFmmirFE8/ufGIcphQo/87vvOYqOFWOKLJtYmivTY=;
        b=YMR7+6vKKLRHyMA9Gqxt2rMYl0riABzX0rsHlp5CdI9aYGjDOedZD03fcqJvo0lhyq
         bH7QPx36nIoRvVoxsE9wFc4gYpo9V4+4HChX14249v90N4CthrJKQC7Mj3z586hsclTJ
         nP9OcsjVdJFoiU0WHdyCbNJqab25tNP2nADHhUVYezzMfSR7a6XiQx3UWrZ3c/S+4Eie
         IsBjhr/Cv7oeljgKJ+00f5FGk8elimtv2q9+uspXbhl8bNUZQ+l7b2znL32uXlvYLJMj
         Ls1qTRBQe0Ym4RTIqtYVG/Zx0MLFJKsuqSENNWnSLgDrhbr7wVkgh/IqZfTDTsH3iefw
         T9zg==
X-Gm-Message-State: AOJu0YzI1CwuRmFJRiOrwF4o805mdIRS1BFzGpuCboHJzD14cdoAtamC
	ZiNKxGLsDHQEkY87l/wOyzcvBVb6H726KGfvZ5OL81SPusUL+RDEUsIJWnTH4Jc=
X-Google-Smtp-Source: AGHT+IGTaJWx/jEhojDAu7QFW93E4ApyrerpMoRHuUPVSnZW3mtaeYPMTWhT0NbuMUXhSAF32RjJ1w==
X-Received: by 2002:a05:6a20:7486:b0:199:a11d:921b with SMTP id p6-20020a056a20748600b00199a11d921bmr208352pzd.45.1706136305571;
        Wed, 24 Jan 2024 14:45:05 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c28500b001d73a2acc0csm6743987pld.283.2024.01.24.14.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:45:05 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 11/18] Staging: rtl8192e: Fix paren alignment for rtllib_disable_net_monitor_mode()
Date: Wed, 24 Jan 2024 14:44:45 -0800
Message-Id: <20240124224452.968724-12-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124224452.968724-1-tdavies@darkphysics.net>
References: <20240124224452.968724-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Join 2 lines to fix Warning: Alignment should match open parenthesis

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 60598b41fb9f..538689fb5580 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -361,8 +361,7 @@ void rtllib_enable_net_monitor_mode(struct net_device *dev,
 /* Disables network monitor mode. Only packets destinated to
  * us will be received.
  */
-void rtllib_disable_net_monitor_mode(struct net_device *dev,
-		bool init_state)
+void rtllib_disable_net_monitor_mode(struct net_device *dev, bool init_state)
 {
 	struct rtllib_device *ieee = netdev_priv_rsl(dev);
 
-- 
2.39.2


