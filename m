Return-Path: <linux-kernel+bounces-75657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B3785ECF8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726691C22084
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AC512A174;
	Wed, 21 Feb 2024 23:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kdO1X11a"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CC412A14C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558244; cv=none; b=Xnn6iu3AMAQTiIRf90teGombPQsEkFz3MuC39gx1Ix/gbWNDmDrK6T8qKrRxTOAEbCu1PTXuzyyesBrv1gSv/JSOz+dpNfEPMVmpppA0n6fuShNkoifPpXSS+vuE7QPRR7QdO7ihnCrCc21rtteIZL5O9R3bcTzNwIc7fgqWqYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558244; c=relaxed/simple;
	bh=/z8Eu/KeLJ7IbgMJCENA0qx1maElopa30GOhgYXJfiQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=slSmRmNY5z9XaYVZ3pF3VmpO+SrgzcQjysYWoQWMYgq21qTMOxT/pCchnQm35BhaDt0omjpiBW04VBLr3LTYX4ojOJYlCrOfl+khEq1UkmSH0F6Gk8opt0h6G5/AYQdyWuwkz1shYMjLix2LIEr1S/eL5b2V3C53uB+hsPYsx3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kdO1X11a; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so8207955276.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708558239; x=1709163039; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hz8i/GyBU5B3ALvYkkFzM0iQaG+ZmlRW+5k11B+Bktg=;
        b=kdO1X11aIl4Lz7Ab4W0RtCxTzU56PzthcPHHI74ohhv9ewWe1BQvHC+DrAEh+cbjhr
         Fp+9Eu+WgZzFYjDQ0JtVpWAXOa0AGSg4Do7kj84E/1KhFejG9QjzkAXrYgmpBsB5umwu
         dONIbsErrDxfNkSphy/oxoI6zfmxkQsfBZA4T3Z/Pj0jBxb2ujm6H6b+Z3t0513bG45o
         bOugM0UE7EdMZ47G1OEC1baI0WygVYOA38IsnHN9oyd4+TLn80jLmpSmIJh6kLeHBghq
         5J/22fDE24RDjzKWl5ysDngxe0v3oNmAWd4NSqw0Yrdz517/0UNIfWnVp5ckce2Tqy/y
         f4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708558239; x=1709163039;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hz8i/GyBU5B3ALvYkkFzM0iQaG+ZmlRW+5k11B+Bktg=;
        b=HLqGnP83jBAOmgmw99rdvj0jn5zGJZpyyEys1918XiFUW+3mfFaew9Su7lC6l4NpmQ
         wn07Zl/JeJ6VcrsQR9ebVhsu9AQRPCg2Odp2vsGIrQ+AvA3L95OijK8YKWbAT+OkoyIC
         tBAYfdu+O+9sW50mHqTsiV6aiu0pukZo0ImGQ3+25iQ4t9i8yJGnsdh3atFJtWHMGA7j
         JpEWRAejBVbr2g2/nPolOp42ooLp+2FDBa+elEbmXJR/aBiSkFhm3TS/BXDF+nBEFt26
         Wvk2NGyyeb6dKeU8D+5k7Wrx0R7O69I5t9ek22TiEPMf7AF4Yj9gSjHI6Rs3IdCglx0g
         FxhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMI3vSOcb8Nw2ngUWM+8SEsTXL8HaSVGLMaUhE1dfKlQgiHrT6fwKsx5HQeOMQVisepnb6dxXqzvdx/FQoumL7XxA99IR9440MaaiY
X-Gm-Message-State: AOJu0YzwTKU/gTzJ6XAxgHhlPOVEEd0N/dRgoZTN98fKYultYzaU8Iy1
	PbURNTGhOuK2bS3ptYCMZrCsZvDcNEIDxQdPg8UamNDw12aRS4JBToSe+IXfmJEeb+7yFrj+V/O
	/O+/+rZa/j3+mWg==
X-Google-Smtp-Source: AGHT+IGuXvzZvHNy3QVBTSonIzoMI+/Ao4vwqXbJbM4MrGhiQqoRVqm8N48cIuXQlz43p2euWLuAKXmE4OX5I0U=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:4e1e:336a:2b30:13fe])
 (user=saravanak job=sendgmr) by 2002:a05:6902:72d:b0:dc7:3189:4e75 with SMTP
 id l13-20020a056902072d00b00dc731894e75mr30785ybt.3.1708558238961; Wed, 21
 Feb 2024 15:30:38 -0800 (PST)
Date: Wed, 21 Feb 2024 15:30:22 -0800
In-Reply-To: <20240221233026.2915061-1-saravanak@google.com>
Message-Id: <20240221233026.2915061-3-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221233026.2915061-1-saravanak@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v3 2/4] driver core: Add FWLINK_FLAG_IGNORE to completely
 ignore a fwnode link
From: Saravana Kannan <saravanak@google.com>
To: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Saravana Kannan <saravanak@google.com>
Cc: kernel-team@android.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
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
index adeff041d472..fac017657d25 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1012,7 +1012,8 @@ static struct fwnode_handle *fwnode_links_check_suppliers(
 		return NULL;
 
 	list_for_each_entry(link, &fwnode->suppliers, c_hook)
-		if (!(link->flags & FWLINK_FLAG_CYCLE))
+		if (!(link->flags &
+		      (FWLINK_FLAG_CYCLE | FWLINK_FLAG_IGNORE)))
 			return link->supplier;
 
 	return NULL;
@@ -1963,6 +1964,9 @@ static bool __fw_devlink_relax_cycles(struct device *con,
 	}
 
 	list_for_each_entry(link, &sup_handle->suppliers, c_hook) {
+		if (link->flags & FWLINK_FLAG_IGNORE)
+			continue;
+
 		if (__fw_devlink_relax_cycles(con, link->supplier)) {
 			__fwnode_link_cycle(link);
 			ret = true;
@@ -2041,6 +2045,9 @@ static int fw_devlink_create_devlink(struct device *con,
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
2.44.0.rc0.258.g7320e95886-goog


