Return-Path: <linux-kernel+bounces-48285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BAE84599B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60A8291227
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DC75F49A;
	Thu,  1 Feb 2024 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4yClKMK"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CC45F487
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796311; cv=none; b=AD+gYGvvlyw6GJTUxYKF/Y2nr0Kr2IP1a63pygQqL/zjvuqxSLqKFfF8IrTCBaQQgXWtoQULq8lPV1gVorR7UxYxELmHBGSmMFgRm2ntSMMKf50fJkFOHh8ROtHYdnxW87a0FU9jHp0T7Cmw5eZaNaWrTEILRnDHMvun1xo1lno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796311; c=relaxed/simple;
	bh=AmgX4dnIIJccXjS/P1Fa4Yt9LuV8HcB1AwdQ1cxH5cY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQlUkyVoZW/JYmXZ2skKvCGNOtR0XguZ3lNsY85zuIRbZA2sJ/V06ErkUKegkIlk8HGu4fwjkJ1S3BXVu0k9YXyZbaCO/UE2Jb0MnG+RFHoo1A3vjW3xYz372b82xBZR9pFwt0FALzzdq/tI8tqoXInN7JEAAw1uutbE1WvCmCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4yClKMK; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5113186bd61so599913e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 06:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706796308; x=1707401108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WZVZh+TcA52yG10ogW2Ket+Nh8qPqugIsfHxx9AocE=;
        b=h4yClKMKfm4mphNXNUKlxA5U9SNT8ntv5DEBy13XNY6fgzoREM557ZTBQwpXIRv8/M
         44pQoNNyETPZyQvt6CPMW/dE8XJjeX1W2yRgVgaq68xqTztMs6K7v63jfDFaiDTG0ECE
         +uohDaUImzTYVCXIV+7fxR2xphlNlOFcVZGIT0x4h5T8ZybkdVsLYKPDSCOgPIvaOI6Y
         +sbK2nEz4Stuuzutpuyy8XZ4zJXsz0UIN6sSqwQhMI1u2ba1YmX/eU1B2NSagklGEleH
         XI9nOdOLTmGXRPSPhR/seF9mrfn1n7+J9mfnFt7s2k+j1q84zXINZbmhbIv+eDp1csY+
         RfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706796308; x=1707401108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WZVZh+TcA52yG10ogW2Ket+Nh8qPqugIsfHxx9AocE=;
        b=uYIUMJqeDMuOzHhVzeciqdtuHsrPMWtcW1cXuhnfUa0D1QnHgA+vJlVppTLEE0KDWz
         LJAjPfMzvHf9m7pOWyd6UpQNwHAuDqSBqJHVxX5q9JJNxcsdGe98XMcp5pVyYYoT83Ik
         EdRDJCxhn5t/UsF6p6jP+MOxCtgs3wIi7K26Pll0Cpw5EL3LIE9pJvfttf5/fX+kJ4LE
         qoat6+aVkXtBZNxfjtnw+i+Gx6u2Z0PHuca25rgimBUUb11g8xBOEdKgtVUWOQzNiM5M
         yA3J92E/afZlwTmweonfBT2E2KSRNmmte4PecYD19gK7tC17ftCWwr/6Y2Jn2UpvN89r
         8dHQ==
X-Gm-Message-State: AOJu0YwvNr/UzNKAr14SAmztz4wZVC358a1CJ/NITTA1/CDMpEQLPebY
	a4R6r6pmKfIKgP17PiOooOXzU2+N7iNP6RFUhlMWfPWeUntXd79F
X-Google-Smtp-Source: AGHT+IHDNg725o++Oss1URoSO/bNwqddYJfoLIxyC/NvU4fiiUKhP95xsRPWiW/MDXE7mhF//2V9Sw==
X-Received: by 2002:a19:ee18:0:b0:511:f41:dff6 with SMTP id g24-20020a19ee18000000b005110f41dff6mr1631947lfb.37.1706796307693;
        Thu, 01 Feb 2024 06:05:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWLIuEc/KXyagZpnA/pb3oIaHfKtvfYxL6bfR2s6TawoG6O+ynYoHrGEcGVDhp5UA+XvwrWNyZ7oSFjqM6L9+OK6jzGgWxsoiRMFJoMFIIqvK0fIXDzuIb9nbNcC48o9NqPLRztJ/wnb/e0pZFxqOfH0BLRCR3WkmFECkiqktJi+yYRwC+i2pg50la5cCJ5D5HTvMgIdK8qpx9JGE3gs7Z8V1eyUcOG
Received: from Ubuntu22.myguest.virtualbox.org ([46.121.140.152])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c290700b0040ecdd672fasm4451195wmd.13.2024.02.01.06.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 06:05:07 -0800 (PST)
From: Meir Elisha <meir6264@gmail.com>
X-Google-Original-From: Meir Elisha <meir6264@Gmail.com>
Received: by Ubuntu22.myguest.virtualbox.org (sSMTP sendmail emulation); Thu, 01 Feb 2024 16:05:04 +0200
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Meir Elisha <meir6264@Gmail.com>
Subject: [PATCH v2 1/4] Staging: rtl8723bs: Remove unnecessary braces
Date: Thu,  1 Feb 2024 16:04:56 +0200
Message-Id: <20240201140459.438479-2-meir6264@Gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201140459.438479-1-meir6264@Gmail.com>
References: <20240201140459.438479-1-meir6264@Gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

braces {} are not necessary for single statement blocks

Signed-off-by: Meir Elisha <meir6264@Gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index b221913733fb..5568215b35bd 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1548,9 +1548,9 @@ void _rtw_join_timeout_handler(struct timer_list *t)
 				int do_join_r;
 
 				do_join_r = rtw_do_join(adapter);
-				if (do_join_r != _SUCCESS) {
+				if (do_join_r != _SUCCESS)
 					continue;
-				}
+
 				break;
 			} else {
 				rtw_indicate_disconnect(adapter);
@@ -2432,9 +2432,8 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 		return;
 
 	/* maybe needs check if ap supports rx ampdu. */
-	if (!(phtpriv->ampdu_enable) && pregistrypriv->ampdu_enable == 1) {
+	if (!(phtpriv->ampdu_enable) && pregistrypriv->ampdu_enable == 1)
 		phtpriv->ampdu_enable = true;
-	}
 
 	/* check Max Rx A-MPDU Size */
 	len = 0;
-- 
2.34.1


