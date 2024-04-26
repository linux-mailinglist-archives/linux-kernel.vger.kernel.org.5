Return-Path: <linux-kernel+bounces-160150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BC08B39E1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0F05B243DA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCD5149E0F;
	Fri, 26 Apr 2024 14:25:38 +0000 (UTC)
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8767148851;
	Fri, 26 Apr 2024 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141538; cv=none; b=A7ndpt9yu6tH7OCUtWhbIWUXf+LuBNlAlEd1/DhHnqWEmkQzTpIOcrkFAjcaZ4ln9eMsOgLiis7TvT5qcjX7RbQmm2lrAiPfUx80Q7qOug56Yhz7yWEfnkRx96S7qoMoXtyojsqjrUTmj85z+x4a8BhzdgMhK6WTScbXGQAVn4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141538; c=relaxed/simple;
	bh=XeY32zytxyK7zQRbZB3onsZxGjG8vSkf2m/k0DWkSq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGgtx1hPmcnFn/8j3CHHtXdW2thDjKItAWWS6omXzmZXq021dJ1hBNIojhrOvsyNUfIDraBhT4vc/AbYVF6TsgG06amjISNfKTLcf9V/Bt8JlAGp2hCeEzwf+YGNJGZC61uvxE8rRB4DYWTVWkwU/jIvrJU6jVxXeTcXqXvAqFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from mgb4.. (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id 7FBCB4260E;
	Fri, 26 Apr 2024 16:16:26 +0200 (CEST)
From: tumic@gpxsee.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH v5 4/4] media: admin-guide: mgb4: Outputs DV timings documentation update
Date: Fri, 26 Apr 2024 16:16:19 +0200
Message-ID: <20240426141619.8866-5-tumic@gpxsee.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426141619.8866-1-tumic@gpxsee.org>
References: <20240426141619.8866-1-tumic@gpxsee.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Martin Tůma <martin.tuma@digiteqautomotive.com>

Properly document the function of the mgb4 output "frame_rate" sysfs parameter
and update the default DV timings values according to the latest code changes.

Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
---
 Documentation/admin-guide/media/mgb4.rst | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/media/mgb4.rst b/Documentation/admin-guide/media/mgb4.rst
index e434d4a9eeb3..b9da127c074d 100644
--- a/Documentation/admin-guide/media/mgb4.rst
+++ b/Documentation/admin-guide/media/mgb4.rst
@@ -227,8 +227,13 @@ Common FPDL3/GMSL output parameters
     open.*
 
 **frame_rate** (RW):
-    Output video frame rate in frames per second. The default frame rate is
-    60Hz.
+    Output video signal frame rate limit in frames per second. Due to
+    the limited output pixel clock steps, the card can not always generate
+    a frame rate perfectly matching the value required by the connected display.
+    Using this parameter one can limit the frame rate by "crippling" the signal
+    so that the lines are not equal (the porches of the last line differ) but
+    the signal appears like having the exact frame rate to the connected display.
+    The default frame rate limit is 60Hz.
 
 **hsync_polarity** (RW):
     HSYNC signal polarity.
@@ -253,33 +258,33 @@ Common FPDL3/GMSL output parameters
     and there is a non-linear stepping between two consecutive allowed
     frequencies. The driver finds the nearest allowed frequency to the given
     value and sets it. When reading this property, you get the exact
-    frequency set by the driver. The default frequency is 70000kHz.
+    frequency set by the driver. The default frequency is 61150kHz.
 
     *Note: This parameter can not be changed while the output v4l2 device is
     open.*
 
 **hsync_width** (RW):
-    Width of the HSYNC signal in pixels. The default value is 16.
+    Width of the HSYNC signal in pixels. The default value is 40.
 
 **vsync_width** (RW):
-    Width of the VSYNC signal in video lines. The default value is 2.
+    Width of the VSYNC signal in video lines. The default value is 20.
 
 **hback_porch** (RW):
     Number of PCLK pulses between deassertion of the HSYNC signal and the first
-    valid pixel in the video line (marked by DE=1). The default value is 32.
+    valid pixel in the video line (marked by DE=1). The default value is 50.
 
 **hfront_porch** (RW):
     Number of PCLK pulses between the end of the last valid pixel in the video
     line (marked by DE=1) and assertion of the HSYNC signal. The default value
-    is 32.
+    is 50.
 
 **vback_porch** (RW):
     Number of video lines between deassertion of the VSYNC signal and the video
-    line with the first valid pixel (marked by DE=1). The default value is 2.
+    line with the first valid pixel (marked by DE=1). The default value is 31.
 
 **vfront_porch** (RW):
     Number of video lines between the end of the last valid pixel line (marked
-    by DE=1) and assertion of the VSYNC signal. The default value is 2.
+    by DE=1) and assertion of the VSYNC signal. The default value is 30.
 
 FPDL3 specific input parameters
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.44.0


