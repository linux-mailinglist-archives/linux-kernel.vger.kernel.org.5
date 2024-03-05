Return-Path: <linux-kernel+bounces-91589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7379E8713FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108691F22D61
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C5F2941E;
	Tue,  5 Mar 2024 02:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dy4CZCVe"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2C133CD2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 02:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709607512; cv=none; b=YuS3RQUVuszIXpNqsCvrSumaiBLtuaHAHB96jumPBgxV4vsRHB/AETJx6BudaXjWJXniwY4WOXAW2XDTU1VZ4LMZglvOnblfM9vtfp/5HK7RqQD16geU32PrHuIHTFfWD2N2XiTj22Qha4G+28pKINQTxevJDTg/Z9nh0Fjh9vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709607512; c=relaxed/simple;
	bh=y9r4LteBqMH04QeMzH5ZRb8WL1DNQ8oIZpGiIGECeXY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D1FLZeWlBoGaVy98HwhNt5qbFo7ZcqdJIERsiCR6Qs+hRLu9T4qOmik/Ylah+XFtARCWfrWduOfQSU3yq55uHGZOrBPXSd6BijM2Auvv5bOXSqXJXwxC9B+POjSbzfG1t9Ja79rMNmLM3sR7cSidK1RfENeS5cxSXm7Cte5aZ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dy4CZCVe; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so5647828276.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 18:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709607510; x=1710212310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7eOdHJCXhPfTrzPjBN5+OXdUaTW8sE8Q3b3My/raac=;
        b=Dy4CZCVe6YM3yt/0TbGDzz54ppXCl4VbIDX9HVuMhbF8XDYBKaai4J4zbmAbnYsuub
         u1vRM2HOUfUFFfH9QICaOpQebL4y7htcBzc2SAsY1a0ehIrpRk+wKsDVx6xbY3A+Z1cR
         G+DPD2QLZy+mUQOA+fFcGgpmOCL+8rhAUZKXDeSRBqd0zhrKWQ2CMdVQlxaI4zdK7P2g
         BrJa0Q3FNEXk8ZmX4KXxekdQRvMGTZ061+6PeYG0Zhxb//JSospGHzJ5i0tgdbNolvJB
         iKVAP28elHCyg1gOPiAZqjbj9/zfl3jbz/v4DA4+fqwVfPYLdnMTlJOtVlC5s4l36j7R
         Gd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709607510; x=1710212310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7eOdHJCXhPfTrzPjBN5+OXdUaTW8sE8Q3b3My/raac=;
        b=Z2wRf9t+J7D5WFyxW8YGDQVGFohKQ1TkDvBmhq/UR9ZLT95/ojla2h1fyXZXnXK54F
         inHFIGp3yAl6ghhcRSCysl+E2NABp2CFiiWADYpuWBnX3EnsPYl4ZWmYc6YibyPLXYnf
         /+RqdHoUFMSxJBPF2CfUOGjJzy1Y5txC84hZpwkRjWbXtkLBHxxJC7jhKgRNhM+edp8N
         LweeaWRPRcXZ9RxD/PqNYDyOKpmN+mpp0OjadbPfTSVU6JUG3Xenv+icxHuOMMoNkoTl
         ofaL+qTqwBKfGanqcvvwLvhKHLqtZGOqBBUHaCloczAWJTRoo5As6OdDuozqe8lyeKLV
         ovvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgIggq+uEWXRTL0HyVs3wtEOom1PXRDhEf3Exfk69clCpjzEmPcl8mMgo9LQt0Qrg0O/5dKIg6Gdl7c8p7nisIZvtc4BauycwUKdks
X-Gm-Message-State: AOJu0YxsgY+XzgoJRcCYq5ClOaZIMoNlWqyguvdRKfptA9eNaQpzcknk
	FxwKWUf+y9GuOamcGn7xTBcTyB9SJ8yysoIxrmXjnWRAgtffaADv1UzSuehFN8v3dKKMnLtFe3G
	cug==
X-Google-Smtp-Source: AGHT+IEogZ5CBaQQ1Pxlsyr4kO/zwOsDzoA40G/l0PfELA3rCnlArqT1Dqnlc8Fvf/0OV9x4yFlIYI1+7V0=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6902:1009:b0:dbe:387d:a8ef with SMTP id
 w9-20020a056902100900b00dbe387da8efmr370628ybt.1.1709607510093; Mon, 04 Mar
 2024 18:58:30 -0800 (PST)
Date: Tue,  5 Mar 2024 02:58:01 +0000
In-Reply-To: <20240305025804.1290919-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305025804.1290919-1-jthies@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240305025804.1290919-2-jthies@google.com>
Subject: [PATCH v4 1/4] usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Clean up UCSI_CABLE_PROP macros by fixing a bitmask shifting error for
plug type and updating the modal support macro for consistent naming.

Fixes: 3cf657f07918 ("usb: typec: ucsi: Remove all bit-fields")
Cc: stable@vger.kernel.org
Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Jameson Thies <jthies@google.com>
---
Changes in v4:
- None.

Changes in v3:
- Fixed CC stable.

Changes in v2:
- Tested on usb-testing branch merged with chromeOS 6.8-rc2 kernel.

 drivers/usb/typec/ucsi/ucsi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 7e35ffbe0a6f2..469a2baf472e4 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -259,12 +259,12 @@ struct ucsi_cable_property {
 #define UCSI_CABLE_PROP_FLAG_VBUS_IN_CABLE	BIT(0)
 #define UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE	BIT(1)
 #define UCSI_CABLE_PROP_FLAG_DIRECTIONALITY	BIT(2)
-#define UCSI_CABLE_PROP_FLAG_PLUG_TYPE(_f_)	((_f_) & GENMASK(3, 0))
+#define UCSI_CABLE_PROP_FLAG_PLUG_TYPE(_f_)	(((_f_) & GENMASK(4, 3)) >> 3)
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_A	0
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_B	1
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_C	2
 #define   UCSI_CABLE_PROPERTY_PLUG_OTHER	3
-#define UCSI_CABLE_PROP_MODE_SUPPORT		BIT(5)
+#define UCSI_CABLE_PROP_FLAG_MODE_SUPPORT	BIT(5)
 	u8 latency;
 } __packed;
 
-- 
2.44.0.rc1.240.g4c46232300-goog


