Return-Path: <linux-kernel+bounces-32857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4FF8360FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7B21C23563
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD84482F4;
	Mon, 22 Jan 2024 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ8ycbh1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203EB482E1;
	Mon, 22 Jan 2024 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921536; cv=none; b=WIjFPxRXeUhwnmlR8h4TCbkp+juMSSJHx8GZ6yarbrRrrneodVz4HDWbMvZn0gJliwQqwZRDkos7gHZN3S4Hpvf52pwNLUEEiZSr3jOPGuEXHjmsjhigEN9QETbePtCifYBPLiU4/bk5F7CthOgAevO4c6IHm4RehS2NXHOch3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921536; c=relaxed/simple;
	bh=HM6oOD75oHPqpqMW8rxMiXIKMk1zokz1oJrkOtXB2eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0rimzgoTmWglEcjhqrGUbqeSc5WGNi8Qez8r3cyOsrXWF+xkGSVVB0Jyvq7MFpVFkzDCcVZekmYrwLKNSWOmXUIbIeYd/aXeHTOWKO7Sc41Ig9siaCwAUrmiSwsh0ehmgSYZgBGGVFhh7CTewFQMTPbHAM9CK7TdI3rhrAdgpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ8ycbh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06F3C43394;
	Mon, 22 Jan 2024 11:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921536;
	bh=HM6oOD75oHPqpqMW8rxMiXIKMk1zokz1oJrkOtXB2eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZ8ycbh1vaVpOwbXTGw72jivcESzoInm/cc09XLmO3uIOkYTnp1e3DyqGJhY85Twy
	 E2UmqYtZhAwlHikJ/Q3Ft+mHtl8ZxWOOoOCdFaiAQl9tZdyjzUfjVoRj4snChqzmOG
	 5EC6B9cJIG4V+XdstDoPqhxc7Njve5Ipptx1xjyrFKXQdKH+gfBWySUoDqZ8kPAyCz
	 H5EHD7fqfKap23WX6gglopaJlNkKXZN9EpFs0qBz+ydVvIpzCkYLlwqP4Riux/Hhfn
	 sYbKjEyb/iT3Efon/ifhBYNWPhOShv1a6JI2Oo0yCbMAtq+RQMt3U/UZSaiALs7ROH
	 xAn4+3Pz20OlA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 43/47] tty: vt: remove consw::con_getxy()
Date: Mon, 22 Jan 2024 12:03:57 +0100
Message-ID: <20240122110401.7289-44-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122110401.7289-1-jirislaby@kernel.org>
References: <20240122110401.7289-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the previous patch, nobody sets that hook. So drop it completely.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c     | 20 +++++---------------
 include/linux/console.h |  2 --
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index f6fa76c0eb5b..cbe1a1106d53 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -593,18 +593,12 @@ static void con_scroll(struct vc_data *vc, unsigned int top,
 static void do_update_region(struct vc_data *vc, unsigned long start, int count)
 {
 	unsigned int xx, yy, offset;
-	u16 *p;
+	u16 *p = (u16 *)start;
+
+	offset = (start - vc->vc_origin) / 2;
+	xx = offset % vc->vc_cols;
+	yy = offset / vc->vc_cols;
 
-	p = (u16 *) start;
-	if (!vc->vc_sw->con_getxy) {
-		offset = (start - vc->vc_origin) / 2;
-		xx = offset % vc->vc_cols;
-		yy = offset / vc->vc_cols;
-	} else {
-		int nxx, nyy;
-		start = vc->vc_sw->con_getxy(vc, start, &nxx, &nyy);
-		xx = nxx; yy = nyy;
-	}
 	for(;;) {
 		u16 attrib = scr_readw(p) & 0xff00;
 		int startx = xx;
@@ -627,10 +621,6 @@ static void do_update_region(struct vc_data *vc, unsigned long start, int count)
 			break;
 		xx = 0;
 		yy++;
-		if (vc->vc_sw->con_getxy) {
-			p = (u16 *)start;
-			start = vc->vc_sw->con_getxy(vc, start, NULL, NULL);
-		}
 	}
 }
 
diff --git a/include/linux/console.h b/include/linux/console.h
index b2d8621cea57..fa2cd81102b8 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -96,8 +96,6 @@ struct consw {
 			enum vc_intensity intensity,
 			bool blink, bool underline, bool reverse, bool italic);
 	void	(*con_invert_region)(struct vc_data *vc, u16 *p, int count);
-	unsigned long (*con_getxy)(struct vc_data *vc, unsigned long position,
-			int *px, int *py);
 	/*
 	 * Flush the video console driver's scrollback buffer
 	 */
-- 
2.43.0


