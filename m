Return-Path: <linux-kernel+bounces-71270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E145A85A2B9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78EED284F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F722D04B;
	Mon, 19 Feb 2024 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="r2yqU9sK"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA024364BC
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344019; cv=none; b=BXvczg8jm9+gc3tzSg+CPEh1whCW0/FBzdOLlUN6YYUdfLqp25bRSSZWPKLFt7RGZwvPX/gNWnxGKAw4TRnhHXaf7MLuzwL10ZRo/JMs9EYwAjw0ctlgTMrldWG93Drvq0/bq+HAtMtOTxrkQEXjj7bN/wO/2w3dSIYB/+pE/2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344019; c=relaxed/simple;
	bh=Zbpl54vz+j7VK1lL7d8GEo/58z6p6dU/i6sdwxlkH9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iJomkBpwAdifidjoRaOFSw/CObJIyq6HS9VMKmKWTUR9Fv+So1PfeLdt2nYTthAjXkhT650ztyaFfyY0+Fbub6m1mi9vV7xaRfkgGLV6oQFK3fZxMa6DZOh9FliMBNDSP7/61prBYANvsnrnPSFtI2Heh7l/IrW/jab68roWmdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=r2yqU9sK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dba94f9201so24217905ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:00:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708344017; x=1708948817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ceTuhqP93bH+p1U/4Nuj7uzSb4ni/tc46LUJgesgV0=;
        b=gvLgmfAoF+k5h4RRrTcvKJTEf6vgbCOV7A10b8cgMDoXNOz91IEbw923WpfSIgF3xk
         dEMlweq3i82xwLuEeghVLIdu3r5kzeGTzZZQ1KBqqPoMjqeKB4FN9p+Xo5D9a064uXzM
         7OiC4/dND9jgpzaJiIZODdA0e5AoUzbgsb5FNZ1Ah/zGV1ZLy2A5iAN7PRWC4ZRfjZRu
         tfjig68RbvYK06ozWyMyv+lHBqwG2Pudf6MZs/893nZ1vITL4MXLM0OBhZv52BgoiZXS
         +o3X0fCl+VFDui1aiu6IYKZ9DhZhAD73rggb26uImnwQ6oKnP8R8LDBvnmgmYXsUA98N
         5nGg==
X-Forwarded-Encrypted: i=1; AJvYcCWkVna/9c/DhTtRsR+SDOLIpqQcITisIjmVQq1G07VfJcI0yYPvv2zyZq9fA5LsfYq1AVX/RIbBGFNIEQaSUBT1GTSq/GDryN9MBffD
X-Gm-Message-State: AOJu0YxQQ+v9SMwMY8ksAKQRuKS3Yv+mEmvVbvViYMQdmkB/aPdPSvVi
	o9rH05qwHCpMuN5RSbk/KpiwGyP/mpicTzgZhI7lfoNqk1cN2JQB7Tz+KfsBW4PpoQ==
X-Google-Smtp-Source: AGHT+IEN9ChGeMnDJJIbUUp1Te4f0gqEOgxdvDik2FSQpy1djK61w/k2ZmjVgWA4Jr3lObS/PF3Bnw==
X-Received: by 2002:a17:902:d511:b0:1db:cf8c:d3c1 with SMTP id b17-20020a170902d51100b001dbcf8cd3c1mr8097410plg.57.1708344016487;
        Mon, 19 Feb 2024 04:00:16 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902c70300b001db86c48221sm4224248plp.22.2024.02.19.04.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:00:15 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708344014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ceTuhqP93bH+p1U/4Nuj7uzSb4ni/tc46LUJgesgV0=;
	b=r2yqU9sKWtNvOwenunllWDUFpDxanXCUgWNClVjK6HldtqKIL6EouJxLqOOE7WbSj7ACGQ
	uZI/bKP5PiznKj5n1NgSOzNwI7h6oUDtkqCG6W97HplmmSVbHR1hYT5wmrLXlpHyYQ7ehl
	ubzYWXldNTTBIYzrKebII0jKPHY8lZiZ1QEzzErOjLQAT2/czCjxHpywP6Uo5LwimlZRau
	KM9vltFTs3RsiRWc1t/Xq/3ikG+bIb6v9PzUv2jEGBIzAE1qY9KbuRXcDiqAJ+bkQwyHBL
	vl9WVBMfRLUt/GzVRC/+cPzHzDQv509mzlsfG9ieiXO5FRITSdBAHa6dtTzrSA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 09:00:52 -0300
Subject: [PATCH drm-misc 2/3] drm/privacy_screen: constify the struct
 device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-drm-v1-2-e2f2acb38bff@marliere.net>
References: <20240219-device_cleanup-drm-v1-0-e2f2acb38bff@marliere.net>
In-Reply-To: <20240219-device_cleanup-drm-v1-0-e2f2acb38bff@marliere.net>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=Zbpl54vz+j7VK1lL7d8GEo/58z6p6dU/i6sdwxlkH9Q=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl00L1Yti36lbOzneUCF80ZmSkp/FO9XDLY3YU2
 JB1FS7moZaJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdNC9QAKCRDJC4p8Y4ZY
 pmu2EACilPwO+2JjpT7yUaLrxh0L/LqgGXLvq7nb3RkrM5xqys7r5yIwmqj5OphsgF9WlwSXxCt
 0KXP5J4ly0XfKtgI4IbSXeUlo2zXyqjG/qzYG4OQoS6v+V6v2+UuC2ax0L+pQC6EkKX979/eOSG
 io/NTZczgf5T8NeevmG/AIL7QgTtfkwtu0ZPT6gzExzL/5C+z3Mpeg2uiJM5XSSjJV8kv0pSa2a
 REUmpVtpCgIrdgRirp7bNcQk0fk15i3djGHQYhvgjoIlmC8oAnD/oS//tEq7SWmUgcI0LxQLT4G
 Sn31Tb3w6oXvsIAZFJKPKXAvblQIdB9furVbQD+QBUdrd7YbW79f6TDH3N+/6wAPipPuUn5T0Ju
 5sLycEeCWHy2+oErhGAYIGSeAfejS/2qHcy0y0f8zZuYNSkmH6zhd2yo+Vlm+Lo7XbtGRG0x/5m
 ZO3GJSNrGflLsCljf4BiPK7PJR6PVl4AAqyrTHD5V3pEbMZioFagpfitLtpH5/XdWWgFgQ8AfPT
 iQ84DADLdt3cBf2mReZRSXcq+xaaTmxGqGaubQMcudRz4Bz/34hJMi/qVZJuPlgtM+1bHvNDakO
 Ak6Bey4i9tCdQypPwuKEiJu1gfkVuVIDrbcqEc/g5XoZZEInDKCnU7fdStoc3Xt/j67zeDo8DcE
 23urScHg0588jKA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
drm_privacy_screen_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/gpu/drm/drm_privacy_screen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_privacy_screen.c b/drivers/gpu/drm/drm_privacy_screen.c
index 6cc39e30781f..088a30b3b488 100644
--- a/drivers/gpu/drm/drm_privacy_screen.c
+++ b/drivers/gpu/drm/drm_privacy_screen.c
@@ -363,7 +363,7 @@ static struct attribute *drm_privacy_screen_attrs[] = {
 };
 ATTRIBUTE_GROUPS(drm_privacy_screen);
 
-static struct device_type drm_privacy_screen_type = {
+static const struct device_type drm_privacy_screen_type = {
 	.name = "privacy_screen",
 	.groups = drm_privacy_screen_groups,
 };

-- 
2.43.0


