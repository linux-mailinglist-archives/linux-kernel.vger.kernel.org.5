Return-Path: <linux-kernel+bounces-71272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C5085A2BE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC8528519C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DDF2E642;
	Mon, 19 Feb 2024 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="dyBZRXMW"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474762D60C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344022; cv=none; b=Jg7IyguW1mBbYvNEq/71dhe6RDGFFUabgN0/S358GWKgsGvJgS5nzKU+kfJtDfuPGItddZmB8V8gqpjDWboynpsKP59JqBY8AMG8z57W/D9cyKEUtQeAA2GpLlQlwfgiCIt8ZvvvGT+FRrubdPsViIEngnIGig8MSM2FeMJBi8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344022; c=relaxed/simple;
	bh=GLhryFMKh2WBSRQ9ymMITx96mTFPQModMPS8GFFoJck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5wcCKmlbtCbGUwHXsC2530idlJeHs3nWsdy6pR6O00hPkzDwjrkWZKTNDk0eBrzk+o+byaW5LGmBfhdVcPn1GgucQBDC6KHjnQsIA1Bb93vCTncoI4dFbIiV7ljN9987hfoPAKWFLORiJ6LQ0q8onM2Qyb0g7Ut/RgY2Ohg6zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=dyBZRXMW; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-290d59df3f0so3605700a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:00:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708344020; x=1708948820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gf+/StpFhv1wGC+xwGNrw1gaGctxECTBqKAWS6tncEs=;
        b=XZ+LTog+enIjM+SvJ3Kncfkeqqe/lIEcv3rdqbmymkFzIE6yzGmMYmYmk5JuxXR+ge
         clKV8SfnNu+iiTD5ULe9r76Wn3akafOzuKM4M49HBRJH2dRWeC1czjKu+mneFNXffRNO
         5rq1RrlYmswfDV9T7YIxlagPMrE9gv9wZShZS9s6xYD+1rfYKzz+0mCYdLWW3YVXjUKy
         kLfx5UYSYssTadkX0mwp6Fr69tIQczxTcEHUDkLB6CPe58EPcpFQTMvGiSQf1WpNFweJ
         AuO+RKP63YNdLpGcAFHVFLm2NYPWZLQEl1+u6mC4GGqkCx+bOPnOhSVvzP+z+LsY6Gm/
         IHHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDhBWTuUxp8zMVMHQhv69zkROhrG05CvXLacyZ6P1eyookt9LfA36BHn9cyWM7yn3j4Vv5VZ6cZ8faMyau+14IEZcbL401115ewBS6
X-Gm-Message-State: AOJu0YzRUwey85h5EiQuVWviWfnw79AgimzXwUk5ymw98LkmKvTQobyT
	xyoJq9UxXZg12UFKewAuC9pklMWf8k0LMhnl7AmEyTWSfvdYmUh3
X-Google-Smtp-Source: AGHT+IFNkgrs0WjqZzv91XpPaxXipKnzdldZSX9cFjXqFrGXdIl/nBKQdCupMnIdFzxqYTYjZhgMVg==
X-Received: by 2002:a17:90a:d157:b0:299:64d8:10ef with SMTP id t23-20020a17090ad15700b0029964d810efmr3570926pjw.10.1708344019905;
        Mon, 19 Feb 2024 04:00:19 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ga16-20020a17090b039000b00299101c1341sm5082295pjb.18.2024.02.19.04.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:00:19 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708344018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gf+/StpFhv1wGC+xwGNrw1gaGctxECTBqKAWS6tncEs=;
	b=dyBZRXMWBqsYF0mkw1JOVVKr7LjZtp+N/CP6kCVEBiZGwvHqhO8DOf6pSeK8/nOlwsF4xX
	Ws/QMnuITHlDi8/RR6pA5f+YikmukPlPxbKnIMtZ84zThV1n1/Ll3h17Aj1Dh0viz1JJTI
	hFgj1RGkUiSCIqppNZz1qvbnhcBZhju+YeXj8/RngU7PheRyco/vej+CsP76lNPV4qox7R
	XhE3tRVeEzCWr3nz/fh6+W3wtG7TmpiRFSr3gsh5lP9fpv48IFwSazEyj8pxNm563p6t7u
	vqEm+SHbwHOSe7Tg6+MeUIIRCPsg+2wpG5pl5EjZm8Tq8a9F7PC4gMu8F8GLNw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 09:00:53 -0300
Subject: [PATCH drm-misc 3/3] drm/sysfs: constify the struct device_type
 usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-drm-v1-3-e2f2acb38bff@marliere.net>
References: <20240219-device_cleanup-drm-v1-0-e2f2acb38bff@marliere.net>
In-Reply-To: <20240219-device_cleanup-drm-v1-0-e2f2acb38bff@marliere.net>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=GLhryFMKh2WBSRQ9ymMITx96mTFPQModMPS8GFFoJck=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl00L1OvONJejDXxTcgfR0t3mBVczltwTUHMilv
 KpAEbMF1uaJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdNC9QAKCRDJC4p8Y4ZY
 pvpgEACCDwjMH28f3S5w9ZhS5pgJhWn+tr+Iyl3U4iDSAQTGJzcx+hVXpc1b2O4E/Vshu0Q8cIL
 YNab8jUI2lIIj/4EcNqfHgjNG9ZdMLtSHQ8dSb0/2dlUPtb0uQ6iYuLxd01Lno3X7OZp3BbBCve
 /GuhhKPstdnMUj+12pXjLaudbnHi/HUCFfLZJ3TKfpMSbSXkhrtWxWh1BM5ykAe63PtB8WcXaku
 mj22jMKbitllXfXHLHdjJlQqObQnXPRShhJq+EKOiI7KBDfd2ccDhI98EQymFxcY/MkmZwGtKy5
 6AINhniL0e7GWL6+4TJD5s/YLuwkIRl9xr0+dcfWVpG9gUs211bP0njrGPjKMnayAvsMBu6YqRp
 bomh2Snrxdpr/jbrCtjrQbQWKgebrB0m3a5l/vBFrVRLWbfqard90t8CwG3txHP0HAG3/nceqIy
 W0MrUsQ85cCtLTrmAowcqOUunHzUUHa7ciTZ76pojBM77XX4Jq1eV+/VBTYTK6VnRR0XYv4YUaP
 OeuRo+2wXxhAeAJMs8Qo8wIsGXs8CRbkTkUHWYHvkw4BcGzOFVLCLG2Z8PRGonw05JZw4mXkfXQ
 DkUmW7om5jKRZ0EWR8hjGUu/F+QAUWC2UVVbenPrH1IePqAGL3LnWIFoPYyaKpvyjk/y1bEJXDZ
 eDsv02Z2i8RS4sQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
drm_sysfs_device_minor and drm_sysfs_device_connector variables to be
constant structures as well, placing it into read-only memory which can not
be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/gpu/drm/drm_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index a953f69a34b6..6d72dfc4b25a 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -50,11 +50,11 @@
  * drm_connector_unregister().
  */
 
-static struct device_type drm_sysfs_device_minor = {
+static const struct device_type drm_sysfs_device_minor = {
 	.name = "drm_minor"
 };
 
-static struct device_type drm_sysfs_device_connector = {
+static const struct device_type drm_sysfs_device_connector = {
 	.name = "drm_connector",
 };
 

-- 
2.43.0


