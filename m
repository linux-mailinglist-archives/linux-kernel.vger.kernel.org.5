Return-Path: <linux-kernel+bounces-80495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D672A8668ED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139911C222E8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBFA1DDF2;
	Mon, 26 Feb 2024 03:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="kHVcaBJ5"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF2A1CF89
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919801; cv=none; b=VXOXQZ62ahLHilBirh6h+7afPD2vg1aATz8oCJONPkC8DSsD3pGXOT56zWnolqOMJXtRsNTOcQTmmrfnKJGpoSpe6u9hFfCldPFc6nbFhHp7Z2SjxVzXApUilHwFrSEOw4uxLjF7BQ4gJHflv9hVuPpbIxrnopHGn71+Zf2GegA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919801; c=relaxed/simple;
	bh=5UTZENADYSafTSPQU2VUV2qEUU18GbFa5AoXANlDffs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BRahIVlF6TOeYr10V66twK0TW3kTyu+gbp2CVumpHpAbsdtHCzlZ2O0OuTDItJzzz/b2NIVJzDXmXzln2l1VBrGi14XmunTatEq1hvkXr1bTzcm/RVfuNsxOk44hFgNY+wkKFEdMjVRHvwDKeGBzuSIauMfD3hwcVBRgM5PQPQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=kHVcaBJ5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d8da50bffaso12132385ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919799; x=1709524599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvEq/4HtoRyMkGAVi+SaB+InStERkdUsUVR8Hmese24=;
        b=kHVcaBJ53bUaGRsxcMoC/cMpBAgH5h3EZ67uuZmFxy/spHaNXN5Av8VtnY4K50UsGE
         h6YuYDKONpWRqv34DRHKfJ4V7490+2Y43yJ5jxWxGfHKrIUz6fNygM6JR2K3wmhGkI4r
         EgYDp6BKGkmDETYw9ckyTIGoiDI4hPKU/taY5NjS6Og9hrW1elbNH5g1ZBqjhElEk4Ep
         L/gjZjDBXrUIEEc7h1tL+tB94xN/hvja0vdNt9f79+OwwO5Uu1i+WOKf8zlGMJDY7lxk
         XQDFv9lK1vbpOYVuue8wgH2Inz5sZcqhLs2UokM7DvnhGboaVx6AXD0OoLY8TPZJTWdB
         Yg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919799; x=1709524599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvEq/4HtoRyMkGAVi+SaB+InStERkdUsUVR8Hmese24=;
        b=uPQRVL7Q0ehdBPBwJokpwmqwrYLqPfzgaR60/QlZD5G5Pm4pBInK71tEkfbWuMNQwP
         r0oVjDhwY92qRkPXCQadzNgCw25XNLG70VvoxMnqkIwZyjbsHbpVCm+Nj73D2EuSkNtM
         foqBp36yoNh7i0EVkDVK0hYNMJACJnEK1oSD9NiKw66NnECnrpLxPQFNEsNqedtng1jA
         dG9ADv9MIuEO4HvX2b5gPNd9VIWqDU8FhfuvIEWHff0fMv+B9adzfuAYE7+Hd7SX9uER
         Y+eN37V6vni0xaG3j3huPWfaRjVIXgwFniRbz0Rp0RbPTmRl3r9/J7uPmWqgYQ7IfnAN
         YNfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuoKtq3Ru4prMsC8dNtTSYLSMMr8Cb7F9agez/0zxKLndKRmbXCCdDPwhbwrMgXHK7DOezrpKQ/95MNdexFjp8JfFZQ3uMAQ2Qjgfd
X-Gm-Message-State: AOJu0YyixaxJVbnoNLGwTVM3cMJ3pCYDnIuJMH7uUt9ysbnHCriHWexd
	cRrL6R9F+smK2iLTW5eK/skIUOc4qH1VfHZr841WfTE/ce5Yk/FRVpcsEcmpTwI=
X-Google-Smtp-Source: AGHT+IFeETMJPiDj3wjN3T4WC0l1V7tOhDRDO/JWTCmHfPU45i6rPMKBMNEcqVnX49bFNf3fPz3XaA==
X-Received: by 2002:a17:902:d891:b0:1dc:6fec:15d8 with SMTP id b17-20020a170902d89100b001dc6fec15d8mr5065930plz.47.1708919799615;
        Sun, 25 Feb 2024 19:56:39 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8a93fa5b1sm2897615plb.131.2024.02.25.19.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:56:38 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 13/20] Staging: rtl8192e: Rename variable AironetIeOui
Date: Sun, 25 Feb 2024 19:56:17 -0800
Message-Id: <20240226035624.370443-14-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226035624.370443-1-tdavies@darkphysics.net>
References: <20240226035624.370443-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable AironetIeOui to aironet_ie_oui to fix checkpatch warning
Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index e59cd2792389..ff912cdac9bd 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -818,15 +818,15 @@ rtllib_association_req(struct rtllib_network *beacon,
 	}
 
 	if (beacon->ckip_supported) {
-		static const u8 AironetIeOui[] = {0x00, 0x01, 0x66};
+		static const u8 aironet_ie_oui[] = {0x00, 0x01, 0x66};
 		u8	CcxAironetBuf[30];
 		struct octet_string osCcxAironetIE;
 
 		memset(CcxAironetBuf, 0, 30);
 		osCcxAironetIE.octet = CcxAironetBuf;
 		osCcxAironetIE.Length = sizeof(CcxAironetBuf);
-		memcpy(osCcxAironetIE.octet, AironetIeOui,
-		       sizeof(AironetIeOui));
+		memcpy(osCcxAironetIE.octet, aironet_ie_oui,
+		       sizeof(aironet_ie_oui));
 
 		osCcxAironetIE.octet[IE_CISCO_FLAG_POSITION] |=
 					 (SUPPORT_CKIP_PK | SUPPORT_CKIP_MIC);
-- 
2.39.2


