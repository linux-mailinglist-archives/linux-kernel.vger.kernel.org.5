Return-Path: <linux-kernel+bounces-40762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8FD83E576
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1B61F24C71
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D1445C0E;
	Fri, 26 Jan 2024 22:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="IOGcZYpw"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E698A2563D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308301; cv=none; b=YkMULNPCXStOVNpiR6R58HDS6HbR1FbW+TMaIuyuz0Myy8Wi9dYih1zE1ML3cAdt6slKUUgWUYVXGvfSbHvhwL4L7vI6RWstlggPap9NHGexYUSVsmXrwEdFtBwcsjXq1CFCKxzcYhPD9BrP0x/JQc/4R4cKtsxSVZIke5I2D3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308301; c=relaxed/simple;
	bh=dXw+xJPnXmVCBosVzmubmp25LSunaehvlrajPSDC21U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qc6bKB5N1Hlk7Spdj7Gi9kkRHiXaV2uCxvcdYoTs8za02Trw2wZgzleJ+491K6l0tL7tl8Fli7Js1fOYJsHjXiyoGYX5rUbW8petr+gUhBmwrit8tUEdeT2PIC2qb/HM1Xh3qp1gv1Xs0my5ponXMqgGJmyOPWbRgWDjIcenwdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=IOGcZYpw; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29065efa06fso920037a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706308299; x=1706913099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wRVZ/ZTl2OxdPtkwzwNCkdwel9KYX+X218syEA+ShU=;
        b=IOGcZYpwAE/CQ42waxBVmF2eO7n1LldEpAkQPlcOlllmHN+6iov3w+tpAifkXmPq02
         /g+bjkn57nWI7yBwGWuutc0+Oi1vEfT6PNElz/FgIYh/iXCODGWaKP/GS9UXxNSpeWyh
         2VtnIE2u+Y7NgZuOaksd/iIpp4n5aNFunC/1441evFXo+orgTQtozpk7F4OLQqYLU4dG
         cu223vC75TwVhoAlWos02qEmI4aVeQD7Ds9AqHNda4WG6lIqXKfT3BUyDsgQmzVPli7Z
         lLrZaJsVCH4W78bfUOil9xUb9ziVY3aZ0Bp4vv7fGtsor6Gk1E//MFzO699oeY+PZLBf
         iqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308299; x=1706913099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wRVZ/ZTl2OxdPtkwzwNCkdwel9KYX+X218syEA+ShU=;
        b=vUXqzy+CMPWeH+X0x9FUASvHg1+5D16QWAdDAjJF6w+BEAtpFQzJlanMI3O95lb/i/
         ChNc5icrOcLUkEuA65iWiXlNHG4oHr2/pAvR3NPvvD/Kq+lbp6U5HdcXxxhTJHhbR/D5
         l9gv/XV0MbiYT250pZ9rP+IZvUQFgLWku7wGzqDwMu0XAf5QgEGSRWFKCeCBz696QPVd
         ddlKR1UrQsjRyE1MMM/vSG9o/SFAgKVoc4eDdjCN4K7SARjV1/EVVPuKKYJDYgaak2kW
         dI5TsCJQKrKiJGXTKiF+QnLej2+fWb2QHGGGFin/Mi6jiVckwAmvJr2AUOShiMUJ7yof
         qqvw==
X-Gm-Message-State: AOJu0YzQ3sb0BYxeG9R2xaSyAmbAz+YXa8SVbzi5WJM3SIgl+hmFNZ2A
	RwZj89WBfR3hohsU/QHCbvcrnv2HCyEiYoEEtop/POPP8nZtHHAh/fWF63nvDWc=
X-Google-Smtp-Source: AGHT+IFB5b6nIl9AxF6VP8DLp5SQhPiettq8mA5bonkhbVfv6wjZamvDIl/IXkJPo5fCUjxOevuTaQ==
X-Received: by 2002:a17:90a:9311:b0:28f:fb55:4bf2 with SMTP id p17-20020a17090a931100b0028ffb554bf2mr568548pjo.94.1706308299263;
        Fri, 26 Jan 2024 14:31:39 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d0c100b001d8a8f431b7sm737909pln.300.2024.01.26.14.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:31:38 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 03/18] Staging: rtl8192e: Rename variable LPSAwakeIntvl_tmp
Date: Fri, 26 Jan 2024 14:30:51 -0800
Message-Id: <20240126223106.986093-4-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240126223106.986093-1-tdavies@darkphysics.net>
References: <20240126223106.986093-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable LPSAwakeIntvl_tmp to lps_awake_intvl_tmp to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No changes.
 drivers/staging/rtl8192e/rtllib_softmac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index cf855ba39c10..8a60bf3b7079 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1390,33 +1390,33 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 					       (psc->LPSAwakeIntvl + 1);
 		}
 		{
-			u8 LPSAwakeIntvl_tmp = 0;
+			u8 lps_awake_intvl_tmp = 0;
 			u8 period = ieee->current_network.dtim_period;
 			u8 count = ieee->current_network.tim.tim_count;
 
 			if (count == 0) {
 				if (psc->LPSAwakeIntvl > period)
-					LPSAwakeIntvl_tmp = period +
+					lps_awake_intvl_tmp = period +
 						 (psc->LPSAwakeIntvl -
 						 period) -
 						 ((psc->LPSAwakeIntvl - period) %
 						 period);
 				else
-					LPSAwakeIntvl_tmp = psc->LPSAwakeIntvl;
+					lps_awake_intvl_tmp = psc->LPSAwakeIntvl;
 
 			} else {
 				if (psc->LPSAwakeIntvl >
 				    ieee->current_network.tim.tim_count)
-					LPSAwakeIntvl_tmp = count +
+					lps_awake_intvl_tmp = count +
 					(psc->LPSAwakeIntvl - count) -
 					((psc->LPSAwakeIntvl - count) % period);
 				else
-					LPSAwakeIntvl_tmp = psc->LPSAwakeIntvl;
+					lps_awake_intvl_tmp = psc->LPSAwakeIntvl;
 			}
 
 		*time = ieee->current_network.last_dtim_sta_time
 			+ msecs_to_jiffies(ieee->current_network.beacon_interval *
-			LPSAwakeIntvl_tmp);
+			lps_awake_intvl_tmp);
 	}
 	}
 
-- 
2.39.2


