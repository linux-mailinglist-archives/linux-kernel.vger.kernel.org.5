Return-Path: <linux-kernel+bounces-67211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C43A785680D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812D228E322
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FDA134743;
	Thu, 15 Feb 2024 15:37:54 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E345D1339B5
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011474; cv=none; b=YN97+rzzRtrlcaofmOvu6nQVyPpSyOnM8N9A6g93aBo9qmOo4kEIRQzVjCsbcx4a9NtzJOqoNULUUB3BtlG37SaDQry3BXozsGQeHY6mB/EWklckQ7qFv+zdzU8hbC8M9/s2quFD5gEmyzcxNRI+dNrN/qwqOUMQuguyzHARZa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011474; c=relaxed/simple;
	bh=O6k3+Kt9EY9aVhxjMtSqDSmcS8ddewY4b29TogNStAw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Vty7/+ib5PUw/cZpl+vNtgPIzcvrlTbgGKKQ/gzep6SHzDNDMFzCtIntunDbziRIK8JfXAxeWmOdUWe1IsjGkmxziK7fKhHgYzWmHfzBBjB8tSE4QDLsLsN9N5aVNg8pnh1nCZc2pSs7K+ndnYJ80bENfuLeojj7s7XGYXBGjqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-qSfwzd3LNeivXFSIUlv9Ag-1; Thu, 15 Feb 2024 10:37:42 -0500
X-MC-Unique: qSfwzd3LNeivXFSIUlv9Ag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E22983101A;
	Thu, 15 Feb 2024 15:37:42 +0000 (UTC)
Received: from gentoo.redhat.com (unknown [10.45.226.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A56AB112132A;
	Thu, 15 Feb 2024 15:37:41 +0000 (UTC)
From: Alexey Gladkov <legion@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [RFC PATCH v1 0/5] VT: Add ability to get font requirements
Date: Thu, 15 Feb 2024 15:37:19 +0000
Message-ID: <cover.1708011391.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

We now have KD_FONT_OP_SET_TALL, but in fact such large fonts cannot be
loaded. No console driver supports tall fonts. Unfortunately, userspace
cannot distinguish the lack of support in the driver from errors in the
font itself. In all cases, EINVAL will be returned.

How about adding another operator to get the supported font size so that
userspace can handle this situation correctly?

I mean something like this proof-of-concept.

---

Alexey Gladkov (5):
  VT: Add KD_FONT_OP_GET_INFO operation
  newport_con: Allow to get max font width and height
  sticon: Allow to get max font width and height
  vgacon: Allow to get max font width and height
  fbcon: Allow to get max font width and height

 drivers/tty/vt/vt.c                 | 27 +++++++++++++++++++++++++++
 drivers/tty/vt/vt_ioctl.c           |  2 +-
 drivers/video/console/newport_con.c | 21 +++++++++++++++++----
 drivers/video/console/sticon.c      | 21 +++++++++++++++++++--
 drivers/video/console/vgacon.c      | 17 ++++++++++++++++-
 drivers/video/fbdev/core/fbcon.c    | 18 +++++++++++++++++-
 include/linux/console.h             |  1 +
 include/uapi/linux/kd.h             |  1 +
 8 files changed, 99 insertions(+), 9 deletions(-)

-- 
2.43.0


