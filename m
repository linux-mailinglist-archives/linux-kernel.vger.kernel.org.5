Return-Path: <linux-kernel+bounces-81784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 777CA867A14
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7461F2E80C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6605E129A74;
	Mon, 26 Feb 2024 15:21:34 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3FD128368
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960894; cv=none; b=stYAm6TFRotRpEX2smBB6h8A4jyTBOtbSSPSBIj8aiN68CofMSxHzYfG60Sti72WEVaOT2ZXduQZn4S8rrDB/RhUvpkXPNHgYPPKGvfS94SidVBxM/LoUfM5bTMFOBlui9pZbC8/G79ISdHN5eO/njc3Pge9xRQ0GtB5ojJQcUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960894; c=relaxed/simple;
	bh=qtJdJKQ0dYNLQicmz2IhIWYeRf4DPy/Z8Un/D7cH+6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTbSDgb3JIeca+H2550eDH9SY2gzGld6wpe2QxwXXK7U/KEzHcZvwgz7cYwMOSy6LNWAYQdH+uF/ynVP0HdNA9JM/+GNw9Z65x0Q3omDU8/Kc3mQVsoeu2BMmeuyWuaKmns1wGSW+XuvG0KJPWkq9EGt59qyJF8OBJQueXlr2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-CGkQoEueMhK85phMJc9dTg-1; Mon, 26 Feb 2024 10:21:22 -0500
X-MC-Unique: CGkQoEueMhK85phMJc9dTg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE92085A58B;
	Mon, 26 Feb 2024 15:21:21 +0000 (UTC)
Received: from gentoo.redhat.com (unknown [10.45.224.64])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 23B80492BD7;
	Mon, 26 Feb 2024 15:21:21 +0000 (UTC)
From: Alexey Gladkov <legion@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-api@vger.kernel.org
Subject: [RFC PATCH v2 0/5] VT: Add ability to get font requirements
Date: Mon, 26 Feb 2024 16:21:09 +0100
Message-ID: <cover.1708960303.git.legion@kernel.org>
In-Reply-To: <cover.1708011391.git.legion@kernel.org>
References: <cover.1708011391.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

We now have KD_FONT_OP_SET_TALL, but in fact such large fonts cannot be
loaded. No console driver supports tall fonts. Unfortunately, userspace
cannot distinguish the lack of support in the driver from errors in the
font itself. In all cases, EINVAL will be returned.

In order not to hack the KDFONTOP interface, I suggest adding a new ioctl to
obtain information about the capabilities of the console driver.

This is the second version of the patch with the fixes pointed out by Jiri
Slaby.

Previous version: https://lore.kernel.org/all/cover.1708011391.git.legion@kernel.org/

---

Alexey Gladkov (5):
  VT: Add KD_FONT_OP_GET_INFO operation
  newport_con: Allow to get max font width and height
  sticon: Allow to get max font width and height
  vgacon: Allow to get max font width and height
  fbcon: Allow to get max font width and height

 drivers/tty/vt/vt.c                 | 24 ++++++++++++++++++++++++
 drivers/tty/vt/vt_ioctl.c           | 12 ++++++++++++
 drivers/video/console/newport_con.c | 21 +++++++++++++++++----
 drivers/video/console/sticon.c      | 25 +++++++++++++++++++++++--
 drivers/video/console/vgacon.c      | 21 ++++++++++++++++++++-
 drivers/video/fbdev/core/fbcon.c    | 22 +++++++++++++++++++++-
 include/linux/console.h             |  2 ++
 include/linux/vt_kern.h             |  1 +
 include/uapi/linux/kd.h             | 13 ++++++++++++-
 9 files changed, 132 insertions(+), 9 deletions(-)

-- 
2.44.0


