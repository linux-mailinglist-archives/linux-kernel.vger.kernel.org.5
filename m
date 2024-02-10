Return-Path: <linux-kernel+bounces-60258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8805F850257
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 04:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A581F29330
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 03:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E49F5224;
	Sat, 10 Feb 2024 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RJK37S4E"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEAE15E99
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 03:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707534364; cv=none; b=ZqHCYMuQwRoC/Jp1W7p9sDcPxpt94yAlyT5euLJCqagZxH/Kh+aCOvo2w1EpkrtYuBto3cvGM6Pr6V0oCdRs7DQratilKKlZqckVnvxSbJgcOE9SqzLnXrznBQsBWNt3SHjILV7ic47WlnRdezxk1or4I8Zp3ZsheQSQDArTx0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707534364; c=relaxed/simple;
	bh=iEDFuhE8mOQtSS/B79HZRgChFrCS7/VJXwJaloRdLeI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=NIAd5qQV6DmF2dcWto5HZRkNvSj8iMXDGJWkDUBOzuwAoYHLSx86Je7Fn8UkUMgtTY9vI2z5zwm6s4YN51ccQ7saZHyMWl4bNGkMwRy/rmFXYSIjXCAM/TzY3hzHlx9Uah9g3Ljyi+lb5l2Hz9A4XGGNDsRopvcxOu4xerKHSaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RJK37S4E; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1d950445c0bso20535575ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 19:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707534361; x=1708139161; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5fSy7E0mRmW50qOB3N+Jt7mdFvxY1Kvxhhy9gLys//A=;
        b=RJK37S4EgogTgmG8r4v6aIVIVO9nqQFNXTAaU1tT2aRuHhL0IXlmIl3UcqVF0P+nsm
         20lzJw1/s5hMABm7QxC5NOEuI0hIdfErY1usuhpHFCs0tl5v9ZSOGus/z3zrFZDNoJqA
         aeHf+f3RprulHXkbfiOAkG9xeaSqswgPShQXHJX4WowQxb2st6Aawr7zPSr3WKOytRhj
         sRZeKsidmhC9xO5ufN2pHzlkWKYIDuLWEMGuf8b6o/YdM/FAu2yG4gUnCNY1Pf1No+ky
         Ct/NksQG/Xvl/EuAdjTuwk6zzJxITcV3MgNC/oqVGX4376xG64Ayaq3QSkO5Gq4SDDaL
         4xVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707534361; x=1708139161;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fSy7E0mRmW50qOB3N+Jt7mdFvxY1Kvxhhy9gLys//A=;
        b=dYwollj6jj75Y1I34u4P/gl7vcz0XLVPUas+G6fF9z1B+ry6SwucDphQ9n1X/jyXlN
         2PCLAIBQtJeTnfAbxKN5XPN+xKMuAupxO0zDn7lWmQGXw7BdSoVXaO1nglEhU34TppNK
         hzOfKwJwjpG8kxSAJe0iPAzxFSbNH0zG3D//cPmKzmFR067z3WQcmNOWDHDRwO9t0n4W
         wFee5J7gd1ngJEbF634mMVK+QlfkFmTnUWCYYnod3BCP4/VxGxOzr9m1rmcsSgF7Zi1T
         kNXDz2vsV1PNvgykkWG3i3Pz3P7Jw0M817SYziRglCgJlKQaS3TNF8YmEK24ohM6/b0w
         UlYw==
X-Forwarded-Encrypted: i=1; AJvYcCVmktN9HmPpC9rQmZV5DnGd0piQjemzQwrQtWQaVmYoJxEoOzOfDG+aaKDmtfzt7SZdC0hW4b5xRFqWyWATOFS8W6Xrws94Jsdj7c9Q
X-Gm-Message-State: AOJu0YwynZmWeFcKOgy0BMpQ5WH4QX8iHQ5QwbFoX0QX0t68R6vNqTia
	dHseJENbH8OLdyPFVPm3mWY/cvzucZBLnfZTWMNA3VVs2m0SGlTGcTIBzBIuwT7eEo2iz3Td2cr
	gwhHJ2wRsOaHMuQ==
X-Google-Smtp-Source: AGHT+IFWQd3ADLGIN9R/9xvZhHRJ+RPurPLpihD0sq3xyJZb/dJ7ssC6WTUszuSQfK+LYMB6XWbO5ag2vHFXWK0=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6b44:91e7:13e1:5d92])
 (user=saravanak job=sendgmr) by 2002:a17:902:d4ca:b0:1d9:5d39:9438 with SMTP
 id o10-20020a170902d4ca00b001d95d399438mr2814plg.4.1707534360849; Fri, 09 Feb
 2024 19:06:00 -0800 (PST)
Date: Fri,  9 Feb 2024 19:05:45 -0800
In-Reply-To: <20240210030549.4048795-1-saravanak@google.com>
Message-Id: <20240210030549.4048795-3-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240210030549.4048795-1-saravanak@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 2/4] driver core: Add FWLINK_FLAG_IGNORE to completely
 ignore a fwnode link
From: Saravana Kannan <saravanak@google.com>
To: Saravana Kannan <saravanak@google.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A fwnode link between specific supplier-consumer fwnodes can be added
multiple times for multiple reasons. If that dependency doesn't exist,
deleting the fwnode link once doesn't guarantee that it won't get created
again.

So, add FWLINK_FLAG_IGNORE flag to mark a fwnode link as one that needs to
be completely ignored. Since a fwnode link's flags is an OR of all the
flags passed to all the fwnode_link_add() calls to create that specific
fwnode link, the FWLINK_FLAG_IGNORE flag is preserved and can be used to
mark a fwnode link as on that need to be completely ignored until it is
deleted.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 9 ++++++++-
 include/linux/fwnode.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 33055001e08e..bd762d90dac0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1010,7 +1010,8 @@ static struct fwnode_handle *fwnode_links_check_suppliers(
 		return NULL;
 
 	list_for_each_entry(link, &fwnode->suppliers, c_hook)
-		if (!(link->flags & FWLINK_FLAG_CYCLE))
+		if (!(link->flags &
+		      (FWLINK_FLAG_CYCLE | FWLINK_FLAG_IGNORE)))
 			return link->supplier;
 
 	return NULL;
@@ -1960,6 +1961,9 @@ static bool __fw_devlink_relax_cycles(struct device *con,
 	}
 
 	list_for_each_entry(link, &sup_handle->suppliers, c_hook) {
+		if (link->flags & FWLINK_FLAG_IGNORE)
+			continue;
+
 		if (__fw_devlink_relax_cycles(con, link->supplier)) {
 			__fwnode_link_cycle(link);
 			ret = true;
@@ -2033,6 +2037,9 @@ static int fw_devlink_create_devlink(struct device *con,
 	int ret = 0;
 	u32 flags;
 
+	if (link->flags & FWLINK_FLAG_IGNORE)
+		return 0;
+
 	if (con->fwnode == link->consumer)
 		flags = fw_devlink_get_flags(link->flags);
 	else
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index c964749953e3..21699eee9641 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -53,8 +53,10 @@ struct fwnode_handle {
  * fwnode link flags
  *
  * CYCLE:	The fwnode link is part of a cycle. Don't defer probe.
+ * IGNORE:	Completely ignore this link, even during cycle detection.
  */
 #define FWLINK_FLAG_CYCLE			BIT(0)
+#define FWLINK_FLAG_IGNORE			BIT(1)
 
 struct fwnode_link {
 	struct fwnode_handle *supplier;
-- 
2.43.0.687.g38aa6559b0-goog


