Return-Path: <linux-kernel+bounces-77601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5EC8607F7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6581C20A10
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5ECB673;
	Fri, 23 Feb 2024 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WA36HLS+"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69CCB657
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708650294; cv=none; b=dFDlPwu9uIlxDUNLRf8mtw/g6Mq82+kXzshdC9u5Pk2BzWS+S/80ree3DhAdHExvKBhR8CNlXzDstrpQHK2VaFtWw/iZkdCOTRNbYXsaKFnZ4M1CBddQ7VQMyZ3ljfJ4JewY/k1gkhcq/AR96PCw/QTfp9Ybok08tT58spmF5CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708650294; c=relaxed/simple;
	bh=z+h1yXxJcUa7Q+rt4Z5SzcMtHfpQaYLneY32ZhvvCDU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c2HSOAaZBfj3z33yzd9mWcejIsVcYN11VEDwi4hX7z+AJc9IZJcD9EfReL+DsC/1IEpyWHIjyw2DxxezYb9Q58AZSsJ5dd1XvaI8i7Hv7jPwAar4pBY1LiKlz8nl3ROc6RIobaRPTLhgdr37KRd5LOaDR17wrYOhL5w2+8NRiVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WA36HLS+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b2682870so570988276.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708650291; x=1709255091; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXcGLp3XklPDGcQgU4Tvmf4Q43ky22vQ6sErhij3a6c=;
        b=WA36HLS+J5v+rQdbMhr2IpkjNfrT9BewdgAGiw3HJjBH/Yiyvza2XQVVutXYo72ZBe
         5zhZzC5e2YMEyf5z0oCyX+irfTq3s6eavAsqI5N0NamkxlJgikK21wvwla40E6W2Sunv
         J9NRokaAi8oLPeJpc/sT+HlN6xMY/1JUXrSj94DzcZ7wl05IN7NYhlW6d8rJulCr6vzH
         2epKbRkJQJWMpj8xEtJ/JfAVg5xGVJHr/Cv6bsKT2Uz3M0i1DGxcsSTrPBgAsp4sqSJu
         8oCxa8iElsg/CN/aiY4M0+SXl93Epc47A7GrkORbrIwY4SC3g9yalOyxGjBxALmlTluw
         NFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708650291; x=1709255091;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXcGLp3XklPDGcQgU4Tvmf4Q43ky22vQ6sErhij3a6c=;
        b=U6exhF5FAjcEuV4M5walnh5ePqXxLJ7v4rLboTI6wRuhmlJ7ZRz0RDkADUSZ8DYh8d
         W5+F85k5iZ8M8aW9SrGxca/MruTsy7NE+rPN8V3AT9lLZNMsT+DgIQvhZZGvbtqLmVy9
         MI+vl0fNFEJFSbyvI+5/maDH9qz6Cg7d1J6vbrbHuRJIyH2hTNCvb+24dTn0LNm/l+I5
         cpsaz5eL4/KP9PVJ4g2jfitHSFSzKuwKbdXI2O3enpx1drtAwQsXvfusbDeVnaP2elV4
         Ub5ZJOL6Q8hncnlRH448PQSSllrmPYB+pYPXWS4UF0iqKZm0X15GRGm2Fy36TILS9MMy
         Uuug==
X-Forwarded-Encrypted: i=1; AJvYcCVG6AWApSzxiE7oNnQJmZ5h3BA/B7pgWiPG3G+/pKjXPB9x0kYW+xlBbWL3JLw3WtRUtZQA9uYmUjppdhJKJy98DkDgDK+deds7skld
X-Gm-Message-State: AOJu0YwqDTBnzE1Z+VZXT98mDlJHjI87vSbwYk1r0u9QftJ0MACB89/D
	Ebbqy6EiIO/dnUQ8ZthGtyVogD3ee6CVgsZcEBi64oCs9mY78tarP8VSOFPk1uNrjbjdHXJcjJS
	B0g==
X-Google-Smtp-Source: AGHT+IG03PrEw0HtTG4m+Bmf4i5fWw4eM9SL3vavSQOaa0Hr4Q3QsF3Zw3M2mOiSLiC8G1EsDy9aVF5f8J8=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6902:18ce:b0:dc6:fec4:1c26 with SMTP id
 ck14-20020a05690218ce00b00dc6fec41c26mr202150ybb.1.1708650291721; Thu, 22 Feb
 2024 17:04:51 -0800 (PST)
Date: Fri, 23 Feb 2024 01:03:25 +0000
In-Reply-To: <20240223010328.2826774-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223010328.2826774-1-jthies@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240223010328.2826774-2-jthies@google.com>
Subject: [PATCH 1/4] usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Clean up UCSI_CABLE_PROP macros by fixing a bitmask shifting error for
plug type and updating the modal support macro for consistent naming.

Fixes: 3cf657f07918 ("usb: typec: ucsi: Remove all bit-fields")
Signed-off-by: Jameson Thies <jthies@google.com>
---
Tested by building v6.6 kernel.

 drivers/usb/typec/ucsi/ucsi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 7e35ffbe0a6f..469a2baf472e 100644
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
2.44.0.rc0.258.g7320e95886-goog


