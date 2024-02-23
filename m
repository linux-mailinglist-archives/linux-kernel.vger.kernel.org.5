Return-Path: <linux-kernel+bounces-78561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8EA86150B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7AE4B21DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DF26AF81;
	Fri, 23 Feb 2024 15:02:20 +0000 (UTC)
Received: from queue02a.mail.zen.net.uk (queue02a.mail.zen.net.uk [212.23.3.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F341C76
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.23.3.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700539; cv=none; b=fhFUF37v/56QtzDwW7lNYoqhUCWyc/iVvYtz+XoXvYhsYolxXIh/Ot0m0jastTwHArQpeMEjK/8WQ21YKm60N3cKuEmoAoHQtBUDjWfsbqPaic/McXwf6kEsvw7eApswZiLJqRXr0mM1r8KmyIf5mZj1s5CXLkgtaTieRxEV5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700539; c=relaxed/simple;
	bh=/cLHYZZ6PldVNqvvFBCjmN34dbuA1TWWS/tli9lxHSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uTkxpqW2Yf4CKDaV7WBrQni5fV6MrI8fZOqDy4vvf9VG8q/LBUfVtDAcJ1aX6dGMkMAVx1UZiIFeYAkL/W3QMermjaIGBeNzPxCVTAiaw2xlUb44jD2RCGZ52ZZ/wSjA7nd5w/2wN/U9Gaj56lRmSrlGTM+ToIV1eFBjftbW+7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems; spf=fail smtp.mailfrom=starlabs.systems; arc=none smtp.client-ip=212.23.3.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=starlabs.systems
Received: from [212.23.1.21] (helo=smarthost01b.ixn.mail.zen.net.uk)
	by queue02a.mail.zen.net.uk with esmtp (Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1rdX3u-00BOzE-6W
	for linux-kernel@vger.kernel.org;
	Fri, 23 Feb 2024 15:02:07 +0000
Received: from [51.148.147.4] (helo=starbook..)
	by smarthost01b.ixn.mail.zen.net.uk with esmtp (Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1rdX3n-00AVCM-Hr;
	Fri, 23 Feb 2024 15:02:00 +0000
From: Sean Rhodes <sean@starlabs.systems>
To: linux-kernel@vger.kernel.org
Cc: Sean Rhodes <sean@starlabs.systems>,
	Jean Delvare <jdelvare@suse.com>
Subject: [PATCH] dmi: Adjust the format of EC versions to match edk2 and Windows
Date: Fri, 23 Feb 2024 15:01:58 +0000
Message-Id: <a2b3d8253c5915619cd70ff884e1b57e4b0bbead.1708700494.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-smarthost01b-IP: [51.148.147.4]
Feedback-ID: 51.148.147.4

Currently, Linux displays the raw bytes for EC firmware versions, which can
lead to confusion due to formatting mismatches with other platforms like edk2
and Windows.

These platforms format EC versions as `%d.%02d`, ensuring that the minor
version is zero-padded to two digits. This discrepancy becomes particularly
noticeable with version numbers where the minor version could be
misinterpreted, such as interpreting `1.02` as `1.2`, which does not clearly
distinguish it from `1.20`.

To align Linux's presentation of EC firmware versions with these platforms
and to minimize confusion, this commit adjusts the format to `%d.%02d`,
matching the convention used by edk2 and Windows.

Cc: Jean Delvare <jdelvare@suse.com>
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/firmware/dmi-id.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
index 5f3a3e913d28..5bb921c4f62d 100644
--- a/drivers/firmware/dmi-id.c
+++ b/drivers/firmware/dmi-id.c
@@ -114,12 +114,20 @@ static ssize_t get_modalias(char *buffer, size_t buffer_size)
 		if (!c)
 			continue;
 
-		t = kmalloc(strlen(c) + 1, GFP_KERNEL);
-		if (!t)
-			break;
-		ascii_filter(t, c);
-		l = scnprintf(p, left, ":%s%s", f->prefix, t);
-		kfree(t);
+		if (f->field == DMI_EC_FIRMWARE_RELEASE) {
+			int major, minor;
+			if (sscanf(c, "%d.%d", &major, &minor) == 2)
+				l = scnprintf(p, left, ":%s%d.%02d", f->prefix, major, minor);
+			else
+				l = scnprintf(p, left, ":%s%s", f->prefix, c);
+		} else {
+			t = kmalloc(strlen(c) + 1, GFP_KERNEL);
+			if (!t)
+				break;
+			ascii_filter(t, c);
+			l = scnprintf(p, left, ":%s%s", f->prefix, t);
+			kfree(t);
+		}
 
 		p += l;
 		left -= l;
-- 
2.40.1


