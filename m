Return-Path: <linux-kernel+bounces-161618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A682B8B4EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1D6EB21570
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE004CE12;
	Sun, 28 Apr 2024 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="BdI+Kwc+"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16913EA69
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714345279; cv=none; b=VQjY/s31TKB4CqDGqeneIc5n+hKiVNfYcTfpwIBjLqM054ePbYGJo7l3t4vvAgxtE9rhIFBBTNoDYAu9BAYgd6BglMW3ZPZMupJq8J8G1gqC2xIThw8Ku+2vzbFXNYed45W5QBzMXIZQ2Lsefsen70yELJIjq3IMpnT2AwBaV8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714345279; c=relaxed/simple;
	bh=qzbElJMC0T7qSfJtoU+IySAY//rsTZHVGCNH5N8FREg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tkczhvts49xkz3ehb1kDx2qUbFVnuEUaRiSWIzzEDQbhlEJnzWZ9UT3J/fUvFc6QTZ1b7vtaL/wPWV7AqUOOzaHOtKrqU8cFuVEYsBgm5r3/FjSouiGIdekvrI6nnjP4obIpy4QrB/FDkk6JF7w7pGWOkBiWlXVOyqq1P1/+TLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=BdI+Kwc+; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2806448a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1714345277; x=1714950077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9XfsC6ZYdi5xKMG3rHTSygcdivJultsM/ltg3vPCwc=;
        b=BdI+Kwc+DnOAIcvNk28Kwf+pv6fHlEu88lDSUaRA9vhdKGWj1q4E0Oom0HNFn/AOe1
         IQVO6Ylb0yF17cgVIC3ZGwsEo8HYdaAw2YYYXxw+adwvt93CTCQ4XZK79LtO9yMGQ9UQ
         DvTmgwbFIN2r0LlZ3FEE0sSZO3kKxfW4DsQ1JmKmAOI3XBx4x9X0qlHuZ7D2JPiXp2kT
         zfBBE4K3ifH90bWVxMma+kjBXfQt/mSiFA4Vvy0dYpRTFIlf0DhJfZaXjePFprmT44zj
         FpetOXvyGSLmvD/bQ4RZfSjsZx5iIusnuaCWnqauJy4N8fMVYkj+1b4RPOizpEHLHLV7
         fUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714345277; x=1714950077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9XfsC6ZYdi5xKMG3rHTSygcdivJultsM/ltg3vPCwc=;
        b=IOfm9Jpvgp+n7JgM66F/Hj9bSQP6rcoNqpGONnfAE3xC2D49lbwobhJLeK50lam1bb
         bIoWxnFFHjxD9cPTAI6YETU4ot2ARuCt4Uz2lj5zdIaG4qyUCTV5NG/K1RiKa/XJvs0b
         bN+mevhLjI4Nc21RHG10Ms4BX4MGm7IeZgUZKsaumweHlXJhwHk8nljadPb8FPnVLK/Y
         rOiN78UR2DSV0+GqPDemmVsEBosZn8vDyXVLB99a5zpK6gWVoRXKcBzTnt+U7w+MWMmv
         D9hKDRWXotK4HtDEZlpOwAt9YoKwxtllawSN+pbeHVR35+iBFqopQcu4UnuCCIg+cLb9
         T7vw==
X-Forwarded-Encrypted: i=1; AJvYcCWK3nqnWExboZir8yj5UXPRFBPg8s+6JtuC7jsaCddGhVwtNfaIhntWxzql/+X5SDRDX2CqjzCxfAxQLVMdP6Zbsi5pF2d0VrzD7D9a
X-Gm-Message-State: AOJu0YzsePUt1JD3Z9Wu7BsDzhihl1W+mU9sWFcShAqay9gQDtInKgbG
	B99n73i6ZcmhNlHdVCzvD35nOyi/bDFkyAyHwLhKxucVSMH8EhTi4svoN+qxEEI=
X-Google-Smtp-Source: AGHT+IEoRWnrnLuQg0hpXBxurE5BZ9IutZO0Og+Id1NsGJ8nydwsynuDtWvY1KrFlVxU5qM9dV3g/w==
X-Received: by 2002:a17:90b:4b03:b0:2b1:50:cf05 with SMTP id lx3-20020a17090b4b0300b002b10050cf05mr3350796pjb.27.1714345277371;
        Sun, 28 Apr 2024 16:01:17 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090aac1000b002a27132ac02sm17860864pjq.2.2024.04.28.16.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 16:01:17 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 12/18] Staging: rtl8192e: Rename variable RxSTBC
Date: Sun, 28 Apr 2024 16:01:00 -0700
Message-Id: <20240428230106.6548-13-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240428230106.6548-1-tdavies@darkphysics.net>
References: <20240428230106.6548-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable RxSTBC to rx_stbc
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index bd66df620793..3f8860e91793 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -31,7 +31,7 @@ struct ht_capab_ele {
 	u8	short_gi_20mhz:1;
 	u8	short_gi_40mhz:1;
 	u8	tx_stbc:1;
-	u8	RxSTBC:2;
+	u8	rx_stbc:2;
 	u8	DelayBA:1;
 	u8	MaxAMSDUSize:1;
 	u8	DssCCk:1;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index d51a0daa9196..91c7415d5a2a 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -263,7 +263,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 	cap_ele->short_gi_40mhz		= 1;
 
 	cap_ele->tx_stbc			= 1;
-	cap_ele->RxSTBC			= 0;
+	cap_ele->rx_stbc			= 0;
 	cap_ele->DelayBA		= 0;
 	cap_ele->MaxAMSDUSize = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
 	cap_ele->DssCCk = 1;
-- 
2.30.2


