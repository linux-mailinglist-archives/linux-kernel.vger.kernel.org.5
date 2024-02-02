Return-Path: <linux-kernel+bounces-49570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F369D846BEF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC8CCB2FA8F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F527F7CC;
	Fri,  2 Feb 2024 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XAtGc7il"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705917F486
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865784; cv=none; b=u1dSdzCLUnr9kh1IdQkuUJ2pN/DBEeub+JbzxxwJ2NHU258dvvyNeMRJPVXjJCw/u0FqKL1Lij8mAgTi/IfDJFiWLznvwdKcfP4eGud0MrFydlxamNo82O4Cmc3lV+vMiDdVdteURPg6SyxLUvBKNpU2dMSaSLpHgBmLsUYByrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865784; c=relaxed/simple;
	bh=d5iHkLoKQ8sjTlEpS17LaVao7OCj1mW9ysVyF9v8tcQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=Nn4ous9A+tPOV2snTAnY/ZtL8IQassWBGc52+QRC2alfoO4sPr6RZ3CmS0eTURrTocyEanm/UrENNTffTbBbVKEvjA022RFTAsmsc0E9SIYcroU4cPLQG0G2RHvlLq+ZLkWItzoREh9JfoRHXGK0ONq79WBoAPADPY8kx5UKzes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XAtGc7il; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604186a5775so22242957b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 01:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706865781; x=1707470581; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=daL4XB8bCp+vh8RMiM1+uZyeaTeJtdmdzdYfvAgKrYE=;
        b=XAtGc7ilxk0h7ynIvyZU5VI8VTyQGZglr2qGTG62aqFdmlLfYwVHLacjD/nhRI9pY9
         wJ2ULa7M+xT5sbv0BuARZz+rfqbOCyTO7f/IOS2uYXcQGeyL0cYFEDeJ8CxObozOK5Xq
         DDMoxqcsyVPpJ3BujiI7kQB92fCdV1eW7cgaX0WGIwlDL0nGAgc/t0gE/O7Re1v/WvVn
         Y0Ia/1BGoQM12GxVl4meMnBmizOmVVXTZtMiiuC7Nt17b6E0OZ1/vkRDRtvlSvbrCmiu
         mTUY/8OZ4r3UpNr+JpSoZcrzhBhLLmTcExpwjc9R/MlW8xtYbxU5C+XhRPVOc/4QoPk9
         uRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706865781; x=1707470581;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=daL4XB8bCp+vh8RMiM1+uZyeaTeJtdmdzdYfvAgKrYE=;
        b=QgtLV4CFvCvhFyIvbghjMdys9iOWKaDUlvQiiROY9Ta03CeA1aN+xK3hXpxWjfoyFU
         7+IfonFavwPS1V4Ks7EQMTJZ2FuLCBMNNiMYjWJpt7WIjyPsNCjjHl+G8YZbeNN7PUIk
         c1UIgG1KJfTsp1Y2E2jvHKCfRsVQt5g5a/s/PO7QyWGrsKIr9vSpLUYJJ0Od2r5SCZKM
         +q1E+SuzR6PHfOdRdf72y7jNsLn1EicPQtY3ZjenhMqnvTGsO1OJSRU8g3Pens+eNPvk
         AXJ78fTnppEiSk2lXvAfLx0vdtt/LlnMcVpA+LxQmXDFcIgrOLr5DPk+XlOoL/90RGlT
         x5FA==
X-Gm-Message-State: AOJu0YzwvRuohwA18oN2aO4hWLWz4n08rgwOfd6h7g/HSFdts00uZIHq
	WI12am1S/PY1/DlwjSKtp50ZsYRj+TO5rfdUeP1lsCBBkpEjMfkfUFsvc0sngJEtgxmWW0l4I6n
	Cy3EQ0S2XNenarg==
X-Google-Smtp-Source: AGHT+IGQPZ+QAI3nTjJcEAtdbpsI/TLmMfcBg/mRbiQVbb6wFyd6SkghlV26g5LFiwyJJT3RiC+0U/pbLbALrzY=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6f0:da10:9cb3:5b3])
 (user=saravanak job=sendgmr) by 2002:a05:690c:2911:b0:5ff:78d0:b4b2 with SMTP
 id eg17-20020a05690c291100b005ff78d0b4b2mr214000ywb.3.1706865781565; Fri, 02
 Feb 2024 01:23:01 -0800 (PST)
Date: Fri,  2 Feb 2024 01:22:49 -0800
In-Reply-To: <20240202092250.786276-1-saravanak@google.com>
Message-Id: <20240202092250.786276-4-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202092250.786276-1-saravanak@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v1 3/3] driver core: fw_devlink: Improve logs for cycle detection
From: Saravana Kannan <saravanak@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Saravana Kannan <saravanak@google.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The links in a cycle are not all logged in a consistent manner or not
logged at all. Make them consistent and log all the link in the cycles
(even the child ==> parent dependency) so that it's easier to debug cycle
detection code. Also, mark the start and end of a cycle so it's easy to
tell when multiple cycles are logged back to back.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e3d666461835..084d9648e254 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -125,7 +125,7 @@ static void __fwnode_link_del(struct fwnode_link *link)
  */
 static void __fwnode_link_cycle(struct fwnode_link *link)
 {
-	pr_debug("%pfwf: Relaxing link with %pfwf\n",
+	pr_debug("%pfwf: cycle: depends on %pfwf\n",
 		 link->consumer, link->supplier);
 	link->flags |= FWLINK_FLAG_CYCLE;
 }
@@ -1945,6 +1945,7 @@ static bool __fw_devlink_relax_cycles(struct device *con,
 
 	/* Termination condition. */
 	if (sup_dev == con) {
+		pr_debug("----- cycle: start -----\n");
 		ret = true;
 		goto out;
 	}
@@ -1976,8 +1977,11 @@ static bool __fw_devlink_relax_cycles(struct device *con,
 	else
 		par_dev = fwnode_get_next_parent_dev(sup_handle);
 
-	if (par_dev && __fw_devlink_relax_cycles(con, par_dev->fwnode))
+	if (par_dev && __fw_devlink_relax_cycles(con, par_dev->fwnode)) {
+		pr_debug("%pfwf: cycle: depends on %pfwf\n", sup_handle,
+			 par_dev->fwnode);
 		ret = true;
+	}
 
 	if (!sup_dev)
 		goto out;
@@ -1993,6 +1997,8 @@ static bool __fw_devlink_relax_cycles(struct device *con,
 
 		if (__fw_devlink_relax_cycles(con,
 					      dev_link->supplier->fwnode)) {
+			pr_debug("%pfwf: cycle: depends on %pfwf\n", sup_handle,
+				 dev_link->supplier->fwnode);
 			fw_devlink_relax_link(dev_link);
 			dev_link->flags |= DL_FLAG_CYCLE;
 			ret = true;
@@ -2072,6 +2078,7 @@ static int fw_devlink_create_devlink(struct device *con,
 		if (__fw_devlink_relax_cycles(con, sup_handle)) {
 			__fwnode_link_cycle(link);
 			flags = fw_devlink_get_flags(link->flags);
+			pr_debug("----- cycle: end -----\n");
 			dev_info(con, "Fixed dependency cycle(s) with %pfwf\n",
 				 sup_handle);
 		}
-- 
2.43.0.594.gd9cf4e227d-goog


