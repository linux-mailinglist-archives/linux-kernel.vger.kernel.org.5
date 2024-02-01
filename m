Return-Path: <linux-kernel+bounces-47768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F0084528B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663B21C25BE5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE4D15A484;
	Thu,  1 Feb 2024 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnQABFsH"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2B6158D8B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775526; cv=none; b=CKFfCJmi2zB577l/vIftkh9D8brenbc8lpp3zEl+q9adItuYD7wMfcW4l4vxyW96EiUMWqrtxNaH9ga3ePRMG1Fqr7o+jXVzkaXJv2Og6ke+xZavBZM4gOX8mgwXnDzsQ2DLD0RdlPkwdVyTpm0mtoA48NwUMSHaAnytJj4npQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775526; c=relaxed/simple;
	bh=FETEX9eqmzzdwsflyz/twcnhehtjGEh191nHrECpPkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyFNUyH+Jfz4dG6jRqOXutDFQE8u6xaqqyh8nLC8uQ7Qw6IR9p8hbqdnnNa2wQlfvCY2xNgM22aS5+KPOx+A+AlI2EvzTsNItXelWio7lYy9nm2Rs2qbdBBn4b4yZD9lxWaZcICcJGGZ4cpBN9lVhPjkcWg8Jb4ab6xa4Np/fYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnQABFsH; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a350bfcc621so73089766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706775523; x=1707380323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOlyK86/Jl9rG4TqRWXLT9mehwaragdtILIuDCfPgVU=;
        b=DnQABFsH6R4jUIvrD2G1vcYlzeV9gldNkvGpyLPabd4/ytqMEnGTktfD6kIwtw5FMQ
         lPSi0TYKOVL+9FUQ8utibNe4MySnDG/IWu0PGY+6j5/hFNSh/WmDIOO5++JuUAEDzPx5
         R5GeXRFvrByOndr+TM29jrKa6SNWt9TY61hCcSJytoqsoNyiqCME0aA7msbPHsACP+xi
         mhkVR8V6Y3u5lkn5HnsXUfCuyGDSHzwJfWn/rRI30gZeDX7IaR0IJ3tuC0CkQ8TX76sR
         AnhBHEJh74EzD5S+ix76ER8yrLVEtAmSKz99bK702lHEir4K2tzm7vCcXg/xQa0G/TZn
         /bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706775523; x=1707380323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOlyK86/Jl9rG4TqRWXLT9mehwaragdtILIuDCfPgVU=;
        b=FI4zbnh9PSGp05uEFvaV25OSKe6yvJtBD+xqlln6RxPCCO8GkkaSwNDWVSZGvG8VLR
         shOCL3ae3Mck+razf2T2QDFjAalQJ9YPbPUNI6Wg/eqwKHJpdvU4JDmHlc3le2Zyjm9v
         cnjm9TTGmqDpdBdQEtr/iG6mxBuIKbWsypYgfE7MGrbeTAhXU9XWnoLzZJHxZt/wNw+4
         alL/fZquxFZjxe+I/fe1szVsBmxP9ImF6N6lpboSOJbxKifIkPHIjJsgDK87DrpUCuMk
         jAdmpq0zaop327iFNekpneGcdPUad3r/djDQwknUobLQjIPWKIg6EgADWPq+P4kEd8Iu
         vr5A==
X-Gm-Message-State: AOJu0YzZVg0R4jgviFk2nbluD3JfV3D/CiT6aFPP/BnPMp8JmjMA+rNr
	OxLZD3+p3Tus7iF6zcWF4z9aAhVnbYXYLkHwyos9VAqTXNT/8X9B
X-Google-Smtp-Source: AGHT+IF0DhWGDbjBvEh7CKTzLrlHoDnGtWXn+a9/CbtlYL68LP6YIumtsg3AmOrxZ96DJvfC8AF+cw==
X-Received: by 2002:a17:906:4f84:b0:a36:6dc6:d9c7 with SMTP id o4-20020a1709064f8400b00a366dc6d9c7mr2625892eju.4.1706775522544;
        Thu, 01 Feb 2024 00:18:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXWJSrbehShnkDAJ8GlYl5l8hM1r2LrNh5MxK8BEZPmjmmDhtv++WPsuj6qw2GT5UyL7FAznpseI0+qqFtGrVnv0tpPxEEsmd9o33fDFBtVkyqLyofTO2K76H8+YQmHvzf/uflqdWEPb9oFySBHNFA8tvN3AkTM+/lUNbQiqMV4D50UApM=
Received: from localhost.localdomain (ip-77-25-34-59.web.vodafone.de. [77.25.34.59])
        by smtp.gmail.com with ESMTPSA id p7-20020a170906784700b00a310f2b4b91sm6954069ejm.48.2024.02.01.00.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 00:18:42 -0800 (PST)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: rtl8192e: remove return from void function rtl92e_set_channel
Date: Thu,  1 Feb 2024 09:18:23 +0100
Message-ID: <20240201081824.6998-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201081824.6998-1-straube.linux@gmail.com>
References: <20240201081824.6998-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove return from the void function rtl92e_set_channel.
Found by checkpatch.

WARNING: void function return statements are not generally useful

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index e1bd4d67e862..18b948d4d86d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -714,7 +714,6 @@ void rtl92e_set_channel(struct net_device *dev, u8 channel)
 	if (priv->up)
 		_rtl92e_phy_switch_channel_work_item(dev);
 	priv->sw_chnl_in_progress = false;
-	return;
 }
 
 static void _rtl92e_cck_tx_power_track_bw_switch_tssi(struct net_device *dev)
-- 
2.43.0


