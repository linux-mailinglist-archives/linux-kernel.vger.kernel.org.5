Return-Path: <linux-kernel+bounces-102546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA45C87B3B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181571C22C26
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A424554BCF;
	Wed, 13 Mar 2024 21:43:51 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 0D8B053E07
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366231; cv=none; b=EoNjfqqR9alP0Yj0+hltyGypwh+jBhcm8jT5hdsIVR9BY4h5n/zVEpUyTpofnSwf6bULnj5D9Km7g1XiAtD1QKq9oYlS+8T3n9GIANWQ2doOpquHngQQp2ThSQ6BCCpmNTXrrwhO4CLkQ8wToqBY3SQiKqo5LXC9jolCz1u6scI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366231; c=relaxed/simple;
	bh=r4i5ta+jYDvR8K3Bx4rs272ug04BSW8OU6QwJrAcKeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOwrKCtaM/f4Q7CBB5+SvGenHeJz+ltuc6s/rwd0uoLBzYqB6eXtR1S8S9guqrAsYmzgUt8S1ZXvCqFzDOj2DTgTg4xsfzGYHvSKCup02qdew34kQO4MjslrMBZ+BD8NexSksT1xDoQWXzE/lq6LDNWi5+SqrR96e1b1G8IuzrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 430978 invoked by uid 1000); 13 Mar 2024 17:43:41 -0400
Date: Wed, 13 Mar 2024 17:43:41 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Tejun Heo <tj@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
  Greg KH <gregkh@linuxfoundation.org>,
  Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs: sysfs: Fix reference leak in
 sysfs_break_active_protection()
Message-ID: <8a4d3f0f-c5e3-4b70-a188-0ca433f9e6f9@rowland.harvard.edu>
References: <CAEkJfYO6jRVC8Tfrd_R=cjO0hguhrV31fDPrLrNOOHocDkPoAA@mail.gmail.com>
 <e9d710fc-eace-44de-b3cc-1117c3575ef7@rowland.harvard.edu>
 <2024030428-graph-harmful-1597@gregkh>
 <416a8311-c725-419a-8b22-74c80207347f@rowland.harvard.edu>
 <9c2484f4-df62-4d23-97a2-55a160eba55f@rowland.harvard.edu>
 <ZfIKwFSmw-ACj_jO@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfIKwFSmw-ACj_jO@slm.duckdns.org>

The sysfs_break_active_protection() routine has an obvious reference
leak in its error path.  If the call to kernfs_find_and_get() fails then
kn will be NULL, so the companion sysfs_unbreak_active_protection()
routine won't get called (and would only cause an access violation by
trying to dereference kn->parent if it was called).  As a result, the
reference to kobj acquired at the start of the function will never be
released.

Fix the leak by adding an explicit kobject_put() call when kn is NULL.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Fixes: 2afc9166f79b ("scsi: sysfs: Introduce sysfs_{un,}break_active_protection()")
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: <stable@vger.kernel.org>

---

 fs/sysfs/file.c |    2 ++
 1 file changed, 2 insertions(+)

Index: usb-devel/fs/sysfs/file.c
===================================================================
--- usb-devel.orig/fs/sysfs/file.c
+++ usb-devel/fs/sysfs/file.c
@@ -463,6 +463,8 @@ struct kernfs_node *sysfs_break_active_p
 	kn = kernfs_find_and_get(kobj->sd, attr->name);
 	if (kn)
 		kernfs_break_active_protection(kn);
+	else
+		kobject_put(kobj);
 	return kn;
 }
 EXPORT_SYMBOL_GPL(sysfs_break_active_protection);

