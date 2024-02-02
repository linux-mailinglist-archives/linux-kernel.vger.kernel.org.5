Return-Path: <linux-kernel+bounces-49316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B66FD84689A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8DBF1C220A5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7374A179A6;
	Fri,  2 Feb 2024 06:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFgEKrM5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD317755;
	Fri,  2 Feb 2024 06:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856973; cv=none; b=lXvyu0cAw/xxDKKwHzf07VmWxNQWTg3qq4gUUNWou13Iw/d9CZVqpJMSVOei2lAC3jHrAONXoZvlXfP0lPuwOiVqCpohYu7zZfiJk6gKtSAwx9fpqdjMis0P8xCgmOK00gTkavIkVU/gMXIsIvghaj1OG6jkGcSO+6mb7F49nFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856973; c=relaxed/simple;
	bh=zh855z9zkcp82mqscxhofAUAlll2wwDk2/8ndqNudGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTKWp91PtU062uDAQloOj43r8LFdxUjzFzi3MzmL6gQcWZ0KqkVq2irigxTshr+K23BMM90DPpBbv90oTHzQ5lH4thbQjGKHcsbg3Rkfa/qgGNuyTeaY7Yd+jX9VGBbYDVRrBE7wVyy35p+OXifXAP9yqrcDnw/RaBYp6RbCUAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFgEKrM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7240BC433C7;
	Fri,  2 Feb 2024 06:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706856973;
	bh=zh855z9zkcp82mqscxhofAUAlll2wwDk2/8ndqNudGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JFgEKrM5wTITV5azZ2L6F8afa5eFIYHYdLzpw31YAcYR868VOQ4TDnFbC4fhj2Jmx
	 RfQZ1Hvihyw6XGtCweIMchTGuv+VATe4pmExZ/TxBAUMC70k61HOAVSYYXY9+hpuX2
	 3nw+vzq4CDMssgtsWrwNqwnUj8TQouzM+NtS8yJJsMdOPG1FwKtJJsgybizSX35u2F
	 4F5RPgzaYT4+JKrrCZWxUNgkNUTfRTvrYISst3cJ3VLNoJ6nY/iAH+vTf4EA8Etgqg
	 AV3Zpcw/Z9ux2H0JpmqvmSO4/oSCv0HQtpNkVZQEcfuG+eE9SwbTQmPnPqtrMHrXy9
	 qetFvHcDPPMeg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 01/22] tty: vt: make rgb_from_256() slighly more comprehensible
Date: Fri,  2 Feb 2024 07:55:47 +0100
Message-ID: <20240202065608.14019-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202065608.14019-1-jirislaby@kernel.org>
References: <20240202065608.14019-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* make the parameter unsigned, as it is expected to be unsigned,
* make the computation easier to follow -- step-by-step, and
* don't use 85 / 2 which is only a reduced form of 255 / 6 (by a factor
  3). Unlike the former, the latter can be understood.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 65cd40cac96b..7d42f148559a 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1588,7 +1588,7 @@ static void default_attr(struct vc_data *vc)
 
 struct rgb { u8 r; u8 g; u8 b; };
 
-static void rgb_from_256(int i, struct rgb *c)
+static void rgb_from_256(unsigned int i, struct rgb *c)
 {
 	if (i < 8) {            /* Standard colours. */
 		c->r = i&1 ? 0xaa : 0x00;
@@ -1599,9 +1599,12 @@ static void rgb_from_256(int i, struct rgb *c)
 		c->g = i&2 ? 0xff : 0x55;
 		c->b = i&4 ? 0xff : 0x55;
 	} else if (i < 232) {   /* 6x6x6 colour cube. */
-		c->r = (i - 16) / 36 * 85 / 2;
-		c->g = (i - 16) / 6 % 6 * 85 / 2;
-		c->b = (i - 16) % 6 * 85 / 2;
+		i -= 16;
+		c->b = i % 6 * 255 / 6;
+		i /= 6;
+		c->g = i % 6 * 255 / 6;
+		i /= 6;
+		c->r = i     * 255 / 6;
 	} else                  /* Grayscale ramp. */
 		c->r = c->g = c->b = i * 10 - 2312;
 }
-- 
2.43.0


