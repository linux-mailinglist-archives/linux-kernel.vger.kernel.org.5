Return-Path: <linux-kernel+bounces-61490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3013F8512D5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5E21F22546
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE573D98A;
	Mon, 12 Feb 2024 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="eIycTmV2"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907163CF42
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738947; cv=none; b=HwDyh4HuTeOTbq1A7V0dNUDWt/rFtmu11yqb6L6k4pF6iXOiA6MQJ1lG+ZhiCam7oGiI/pREtQGi4HF9SmhzaYfKyZO0mjNAM4mFhJguA3ppWqBclDByK8Z6tE8508J9N+7Ig0SLBQhBBB3X3wvn0CAH4QmHEn8GOa2FxaCWFNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738947; c=relaxed/simple;
	bh=FaWrvDRhCn6qo66e2LFY1/am/fRiqeQ00xmmtBjY9fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qVR5pkhZj4S5LGNOfNZRCkk1crvK51pY3t97DXLFdXBFOQDTffBL0PnhxjV8YL3JaYn1qfN1alWKC+sOoRdHnjDvKd6G9Myv7Mfsmuv/AO0g5AgIpkuHZBbopcgJC0VIvR9hYYRPbolBXYDLuU+aLWXoVcPt0To/JU16Sqxv90g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=eIycTmV2; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5610b9855a8so6980414a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738942; x=1708343742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhd0Wyk/ZgeZM/EU3KZ6LbkcM94I0OFOZkDaLa9LsZQ=;
        b=eIycTmV2JrToWcqablESKF35/cgEu/gFA6Wwmy0knNwV5mQUahf/CNfITqsIMsRF/D
         wWMDFTocGyUOgrAQDlXvz603U2bkcOKJXTyU1SLlinZiVWPFDxjDqxX49QJ6bvNAktu0
         Dq2VDBGYg/Y4/u5ngrhuJ/Xk+NOfQwMijU0J3Sfl1lDNjEt4JaHH01zUq06Yd/IWUeo3
         yQt3IJYH+Y+iozsKVtqVVYEJoeJAaQiQZjStfJrhDw66EQGK/34yGyNYfOrssdRSaE0V
         e8mcbn1kFIKqJKiNkZj2PfuMi747Zl0fBliNNmcHYEV0zImIq+4b14k/H96ITemKJmmi
         mk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738942; x=1708343742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhd0Wyk/ZgeZM/EU3KZ6LbkcM94I0OFOZkDaLa9LsZQ=;
        b=VBYi4mop9+k2sC2v+1WZRsaoosi9upjyfLoE93FKdgwNwJyXKwBUlUGW3lO0y4feSH
         49l266d/cd5VIoeNOL5ExDIkM065nEkdVKIRzio9cWA4M+SnCrBc4p54peO5rx9XV568
         EDsCAs7pRn8+vGtJqxNQJwKljws602XYf1RsO1MeGV8MX9qO78b3mNS1qzmyEyTEu3+h
         IziaVd0b5SLBotMHFgopSV2KmnFqCzX2EG3ZkaS5n9qqhZZEfx1aKD0PSMiDkmkygbj5
         gsWzLjJ85wZQsnervupV8zXzQPe3FPHqVHPfMiMVDj1ojFH9n2j1pkrggbvqdOXcIczi
         y0cA==
X-Gm-Message-State: AOJu0Yy5fv1O3t7EPhRh5eQYNAKYwxbhqJ3arY3NmKCkGtJOpCtCJArc
	YTVxebPS2+CmmEjPKSMS+XCXQl1tI8opdmPzWut1aV5iOu7XtJfxWtREJ60CCgC2tp6F/wobOef
	Y
X-Google-Smtp-Source: AGHT+IEC1SR/DxJxs59aMIjoXbVJ42TMv4N4qUHQUX9W5Rsf2/e25RTaSuMxwBqsVbVKnmYJCNseBA==
X-Received: by 2002:a17:906:d293:b0:a35:e5bf:b585 with SMTP id ay19-20020a170906d29300b00a35e5bfb585mr5021249ejb.35.1707738942622;
        Mon, 12 Feb 2024 03:55:42 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:41 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 29/35] linux/random.h: reduce dependencies on linux/kernel.h
Date: Mon, 12 Feb 2024 12:54:54 +0100
Message-Id: <20240212115500.2078463-30-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212115500.2078463-1-max.kellermann@ionos.com>
References: <20240212115500.2078463-1-max.kellermann@ionos.com>
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


