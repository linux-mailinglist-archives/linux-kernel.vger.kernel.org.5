Return-Path: <linux-kernel+bounces-84173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC4486A357
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90991F2CAE1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1A555E49;
	Tue, 27 Feb 2024 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OokqbN+N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A141E86C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075424; cv=none; b=gldXLJwMN+sNgO24e177ZIFtW9lA6lLrhZWv43VYD39C2T6nuMH1rGhEg4ClChsnpm4rtb24hzrgJTRCeS303RoXE6imiYQKNR7kb6d92/LiYE25fOTdlJgfUPuK/cypDujgSXiB3BiXzj5sF2Uh2U+Z/ibLrRnhfOPqtj+Gesw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075424; c=relaxed/simple;
	bh=2Zu/4aOYHJfMZrZsAi4wwJT6oXvDhC3db+qOeGHNze0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dhRVlBXTftzuNtLF3zXDQXjTLvh2GIAAWrGMYikIDsLkyG+r1FZG/4BOjkKD0jIhxz842K80pdrNta60h3s/jUEu1W9HSe6+EQOL9RSze7iuwB9H8g1KKJfDcWTZU0Ncom5avkWj83w2nykbhdznYdenGgqcnADoeOiJ0azs8Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OokqbN+N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709075421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CEjmzJpVSyBoFSIf7RLeIIAtbyUoK+NsIL3LszTcLGg=;
	b=OokqbN+N6tL5eSivkbDXDoKx86w+exupK3bG6nJedVCFx49/nDZp8ooMWBG1dr41GrZB4w
	V6EymthPlRRoHYjwbYRAgz+soNEwqVLBZSVydXSnf27xBdbciPBeq+qtLAs/BjeVne0brb
	cU5HDRqRD1QpbOszniwt5spr8Eh8q/s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-ZnooZ0FQOLmoyr-9dMnihw-1; Tue, 27 Feb 2024 18:10:19 -0500
X-MC-Unique: ZnooZ0FQOLmoyr-9dMnihw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-412b0d34a42so1140605e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:10:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709075417; x=1709680217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CEjmzJpVSyBoFSIf7RLeIIAtbyUoK+NsIL3LszTcLGg=;
        b=HC7nsOwqa13rgy0bqWsXNeTbI8tgs9ZNeVWY8ZkeoYVvXD7Ijze871A3dfkZftxxCU
         j1R2JxOQ2ddVw4nXExk0jCSIWgafZIksj+FkdBy0FfLqekAEZFJ0OICPcFJlME+36xcl
         wr84pIjUpmIRQxVGswn2yIbHB5NtrAz9mCrFjslV+FZJJ0+de+Qxjf1dT93IaeNGbGY1
         KazC5BYsag3xwb7Fy+UyZxNf0ZgsPit9xqqRIOtpznzgF3I2/rYNU6lM+DF4LerRA7dm
         XPP2lIlImdsHoURuSOqrSf5TVWQYjt8s32o7dWq6BKmuRJfED8kYZTWZxKd46R+49Tcr
         N3eg==
X-Gm-Message-State: AOJu0Yx32LEo56DkqBV1NF75OOskcn+dugYWkEqcSLoP8BWIOA7cWihe
	wse1+YjJinNRTtEWq2YLsXISCHx0S9hwNZkR7kMnS8IhxuIAHYvv88L7l1cpSjVPdX9nJMSc15H
	Jr1qherhhtu9/BwgpNSi0XNQPZmDqDJ9JyH7ZZzBIfWDnAulPuN+jYMqA720azOfKqzx1J7eF5o
	roQVPMNWRc2ErBcUI8CSDkwbe4zwtNI2yBUP7x9WAL42kR
X-Received: by 2002:a05:600c:1ca6:b0:412:8844:d067 with SMTP id k38-20020a05600c1ca600b004128844d067mr564943wms.18.1709075417623;
        Tue, 27 Feb 2024 15:10:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhOZW3h53Ut0lE9SF3ZazzYrnUfl1tHFokp8XqrYCbyvaykoNjZR8gAvjNym21oGsrlf1HhA==
X-Received: by 2002:a05:600c:1ca6:b0:412:8844:d067 with SMTP id k38-20020a05600c1ca600b004128844d067mr564927wms.18.1709075417269;
        Tue, 27 Feb 2024 15:10:17 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c4fc800b004129ed6f9cbsm187533wmq.4.2024.02.27.15.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 15:10:16 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: javier@dowhile0.org,
	Andrew Halaney <ahalaney@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3] driver core: Don't set a deferred probe timeout if modules are disabled
Date: Wed, 28 Feb 2024 00:09:02 +0100
Message-ID: <20240227231001.648698-1-javierm@redhat.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no point to schedule the workqueue to timeout the deferred probe,
if all the initcalls are done and modules are not enabled. The default for
this case is already 0 but can be overridden by the deferred_probe_timeout
parameter. Let's just skip this and avoid queuing work that is not needed.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v3:
- Just skip setting the deferred_probe_timeout parameter when modules
  are disabled (Andrew Halaney).

 drivers/base/dd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 85152537dbf1..48a45860d2bb 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -266,6 +266,13 @@ static int __init deferred_probe_timeout_setup(char *str)
 {
 	int timeout;
 
+	/*
+	 * If loadable modules support is disabled, there is no point to
+	 * set a timeout for the deferred probe and schedule a workqueue.
+	 */
+	if (!IS_ENABLED(CONFIG_MODULES))
+		return 1;
+
 	if (!kstrtoint(str, 10, &timeout))
 		driver_deferred_probe_timeout = timeout;
 	return 1;
-- 
2.43.2


