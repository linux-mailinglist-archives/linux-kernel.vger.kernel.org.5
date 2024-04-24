Return-Path: <linux-kernel+bounces-156103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150738AFE01
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481161C227BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C75813ACC;
	Wed, 24 Apr 2024 01:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZzuuqTjr"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AC6134A5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 01:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713923327; cv=none; b=bou6ggE8mk3mjVtLvEypyX9sg6RdvibkKUOhtOwzmx7bBLtXD/hv2SvRHF7DbXCir00eR3BeQ7B+jLJOEZuhiqaDBynm66RFcjXqGm4Q4LMcLKmR7yfacnNXlCWehVAd98h0N4P5lEgPKV7mMwcntRHYPLehYPxOqC4/CQyPF3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713923327; c=relaxed/simple;
	bh=DkEhHOa1YOY/idk5PLSaPlY0Gz579FEwlh+ZoODqcWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e9JIk+iWHedNfVR/sWoivNyYKs1vbj0oejz9dVtIl2/syUO5RlIh0g99vccgJXVJMZ8mnDHNRTig97DkL005+Vzt1dJA68ngY5E4X1uCQ2Rtpdm16GFRhO4K9FoyArlD+XRue4QfBPUfMcL4yIm+ffA5pML/yed+BwTcnG7qnTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZzuuqTjr; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de4645bee83so11383367276.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 18:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713923325; x=1714528125; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8GjkODbBEJ1z1TWojaRQYVjYLRHWjXoJ2bOwq1fsJLc=;
        b=ZzuuqTjrou1v1lQ2g0S4HoyRkZ1lSJKLigPx7YYftFUFPgENZKSY+JAAcL9oxF51tB
         7GYGBuJhussNiMipAQRxBr8+7GZ0EJKRDzsN/eI1RTHQkd78DwCc+ATZz8ikHH9rHkAQ
         WsDC+wwaLxAML9rDQjkg4L5XXM5YeyTttXIz81L31tbrwOyCWV4O+VPQN1tzjWcvRPva
         8TKtPnNJPKWd1Ycd29EcJqqSVGiiXNHLigdw4TmJzienMaiiCNJkW8f6u7cAWqb1A0YJ
         UQQLJwk1x9c6OJc4n762CToOgojwGSxRfc0oKO++tWV7w5F+yf0j9Ei7mKCcoiamSAVO
         KvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713923325; x=1714528125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8GjkODbBEJ1z1TWojaRQYVjYLRHWjXoJ2bOwq1fsJLc=;
        b=A0Gu2gKFxUiveXXTunUghLEk/OaqfpRywm2k6dHJ/ZZgrPaQEjjjoyHfFlMenVv4/E
         1ZQeNBmVmhmaRSQP297bn9q2hASsNlGXoNQOH+7UWsE/VAGFdip2fnNQ05Wbqhv9JdW4
         WyAFID6tA/tmvhXYyauOF0M9pasj8KNJ/uXn5Csy1PF03hFkIQjuc7GQbrP3QHR2nwDx
         ovex5ZxtQcbrElitXoc10Secm94SrBroL5qCEKPNHORkwVhZ0yyH7FnrfPUhUbjFAqFl
         nCrtz3elEbon/roYqKW77InNpvVsseF/s4786KsyYz6uQuwlcYJoi5kmz9ljbjO8cbTS
         cUgw==
X-Forwarded-Encrypted: i=1; AJvYcCVRmyjVCa7S1GXx2UGdtLg8+M3Q5ZbMC+lsB2cxnE38j7XC0CqNDM8UxeznsG3LnMQJAkywUC/sD/ih8yrfYne0Fc4lVE2N4ku7I/qq
X-Gm-Message-State: AOJu0Yz9X9cGFXRsLb34KnXjHRA9wZWD2CKhfbfy+fXNMaHx6gnlxfer
	co831w57LrcUNdtkRG3mfeCMTscsc9xaUOb4zZLw1uDaUf1xzYwp39b4kAbRg21EDFCnlJT5S2k
	oSw==
X-Google-Smtp-Source: AGHT+IHqRn99HKG8GFzllw4oydn6oguqocBMLsNVpEhT3sxDknYY5ILkKUekAtW/lYM18qpYQB6w/FSUoaQ=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6902:218d:b0:de5:c2b:389b with SMTP id
 dl13-20020a056902218d00b00de50c2b389bmr104786ybb.5.1713923325627; Tue, 23 Apr
 2024 18:48:45 -0700 (PDT)
Date: Wed, 24 Apr 2024 01:48:18 +0000
In-Reply-To: <20240424014821.4154159-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240424014821.4154159-1-jthies@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424014821.4154159-2-jthies@google.com>
Subject: [PATCH v2 1/4] usb: typec: ucsi: Fix null deref in trace
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

ucsi_register_altmode checks IS_ERR on returned pointer and treats
NULL as valid. This results in a null deref when
trace_ucsi_register_altmode is called. Return an error from
ucsi_register_displayport when it is not supported and register the
altmode with typec_port_register_altmode.

Reviewed-by: Jameson Thies <jthies@google.com>
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
Changes in V2:
- Checks for error response from ucsi_register_displayport when
registering DisplayPort alternate mode.

 drivers/usb/typec/ucsi/ucsi.c | 3 +++
 drivers/usb/typec/ucsi/ucsi.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index cb52e7b0a2c5c..f3b413f94fd28 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -361,6 +361,9 @@ static int ucsi_register_altmode(struct ucsi_connector *con,
 		switch (desc->svid) {
 		case USB_TYPEC_DP_SID:
 			alt = ucsi_register_displayport(con, override, i, desc);
+			if (IS_ERR(alt) && PTR_ERR(alt) == -EOPNOTSUPP)
+				alt = typec_port_register_altmode(con->port, desc);
+
 			break;
 		case USB_TYPEC_NVIDIA_VLINK_SID:
 			if (desc->vdo == USB_TYPEC_NVIDIA_VLINK_DBG_VDO)
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index c4d103db9d0f8..c663dce0659ee 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -496,7 +496,7 @@ ucsi_register_displayport(struct ucsi_connector *con,
 			  bool override, int offset,
 			  struct typec_altmode_desc *desc)
 {
-	return NULL;
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline void
-- 
2.44.0.769.g3c40516874-goog


