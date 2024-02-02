Return-Path: <linux-kernel+bounces-49626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F05CA846D19
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA8628DD94
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9267D3F5;
	Fri,  2 Feb 2024 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lqqk6dyP"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5470B7CF00
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867810; cv=none; b=JPRx3ZBIGvHLEGevd9VPVoS6+pgQGb8JFfoFv5C/tXgWbVBA9bzs3AfoiE7UOOys2cBvb4DhR2SiA6FVF1yxMOa3eSI9mm7ypEMpqxSugiJ5ci9WrIM6CGkAr9RuzFrs+8RAeM3x1NTzw7RJ1i0hekSUOrw7S5R6FnzFAQA9W3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867810; c=relaxed/simple;
	bh=PUyaVOGSZrND1vU/Y/HUwXG66UDPip9IiA9OmTvHwRg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=D/lN0i5Iui4sqLEyW8/rGs/plYiVlWhjxjPvV+F97fZ4uWMuHRkN7V8UDSOoVl4cd3/1fbgow4GxdZKp6coVCnD5MN1EqcsRvSwwq/475QBH3TEXRX1p0mKagzku8/Xn/TYxhogHNeFeYaZnXs6PwgsJW9IUaAeyNcdpIU3lVIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lqqk6dyP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6041e5b4367so26879837b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 01:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706867808; x=1707472608; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ba2yXh5DewPcQ6DrcZcbJKuvXFjQcRv+6+4rV8JAEgE=;
        b=lqqk6dyPh6MBo7rPnlvLGhhf4J124KWEJUkmhXShy8UGFWh7t/0oaSiJRNGimqRpp0
         95+tMzms/m6mSS+qpRZ61474vBIuoeedDsqOHvopA6KF+vmzSMBINTFJqhbqMTKNVqGj
         85hgTI7tMukc4vHfQGJLgJvvAqWLQOT5pAnVevm+7r+KlOT6W4fSNRxEwZ41LvlCmaWv
         SLGZgOkDB0Ll47r/6Qulc7DHKSqz5HIjxGAIebTHYCtruDXcQ5xKFynn6l1jL7B1yro6
         IejLngtRw/2nmLD6TPzVSkUSCU3kp4nt8YKReeE2JbSC13W7GI+IiMww/1nqt6vbzL/b
         U7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706867808; x=1707472608;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ba2yXh5DewPcQ6DrcZcbJKuvXFjQcRv+6+4rV8JAEgE=;
        b=BCWkoTWrFuut/1VmLpw/SPhYDbQE/MQPr6JP93juV9wUjk0O4a2k//1HDLFbxjchdk
         QQaffJSrzJeGYvR1ZrOpSf4FfepSNK7ZLQjiejOufinNdf3WOs8TMXV5VXfwZi1p1DDn
         8ABrZi4bGJ4WZN5fdDjrcCIMl69Yd1Ni61+aV6XinX6FiQyvKoLiskah0wmsUjUrzftd
         hVwjLOBSJQMQf29MHCiyzmm5pHBeOoli9CZnjHS0DLLweOAEBLCpFnl6s3/egyZGNUIB
         AlEUPPHjTT6AYzr3rwZYsUPp3I+4dLqDcHPeiXWldAvNe3aopJ4sX36djbv4ChDAcUyZ
         S7GA==
X-Gm-Message-State: AOJu0YynJy/1MQTVIBBNeyFuxmtu5ijQkhqRRfSIwQNMHFA1SGy52k41
	o4qrFFeoJZ6GdlvqGyS0GKVlgoQFgDD1kzlrpSTs2jYD8tVq/qxheIkYNW0Hdge09FXhFh4+lbi
	MG3/MSAOlcEEEmA==
X-Google-Smtp-Source: AGHT+IFD2LR07FZCDULJxL4IMyHTQCjMDcdj9zpu+KAQZw9+WZqlAZrYDRbbn2uBw8VwnOYfyKVwwrdqky2AYM4=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6f0:da10:9cb3:5b3])
 (user=saravanak job=sendgmr) by 2002:a81:79cd:0:b0:5fb:7e5b:b877 with SMTP id
 u196-20020a8179cd000000b005fb7e5bb877mr1223600ywc.7.1706867808385; Fri, 02
 Feb 2024 01:56:48 -0800 (PST)
Date: Fri,  2 Feb 2024 01:56:35 -0800
In-Reply-To: <20240202095636.868578-1-saravanak@google.com>
Message-Id: <20240202095636.868578-4-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202095636.868578-1-saravanak@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v2 3/3] driver core: fw_devlink: Improve logs for cycle detection
From: Saravana Kannan <saravanak@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Saravana Kannan <saravanak@google.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The links in a cycle are not all logged in a consistent manner or not
logged at all. Make them consistent by adding a "cycle:" string and log all
the link in the cycles (even the child ==> parent dependency) so that it's
easier to debug cycle detection code. Also, mark the start and end of a
cycle so it's easy to tell when multiple cycles are logged back to back.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e3d666461835..9828da9b933c 100644
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
+		pr_debug("%pfwf: cycle: child of %pfwf\n", sup_handle,
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


