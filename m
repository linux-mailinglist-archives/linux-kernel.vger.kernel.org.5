Return-Path: <linux-kernel+bounces-56916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3225384D15A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2AFA1F23597
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B2083CD1;
	Wed,  7 Feb 2024 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgoxrTrh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0052E83CBE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331339; cv=none; b=jQ2pWbO91+9P0/Sw+ah6MWQoqRdP7B5Me0MA1d7H/cdsAZDkSVgDnXlaPQXPiHWLT53EEY7qUM0bwBL4CQb0pGQvQOX8gWDBJm0NE/er0Tg2Od7yq/9kMjukh/PYvBDUQ55tunOP3UYTP0nCBT+wZxr5TdQ2qDHprX0AzzKD/OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331339; c=relaxed/simple;
	bh=nYX20/aGyNT7+m3RqCINirH/BlFMdF3vqKDQqvuouqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Am/TX4NbA3Lt/HUw6iIK23qaQcJwZ40E0FY5A45AKud1tzagIOS45qxmIeWiEK2g35aiJ3/kxjiKbvdSGFQ7W33S+WPl7tRZC8hiM7vtnw1Ow9KYa0/F59XTgl1QsYsHgx2Xt9QvSXl0hjDLzijqBmbNbdP/6UpsX7yHhoTmnhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SgoxrTrh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707331337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uzhXO96uioYuw+s+CgtOuyqJZRewhrPzSOw58rzbztg=;
	b=SgoxrTrhH4mVf1sXPVbcgeq5ckkRSnWexcRSFMO63+YENjH9R3paOwrLrV8J9xhta+9FoG
	RabOpbb/htf0lxbd+r0URkl/L8hM59dN8CgK3mosJhvsn2jUrtyG6VVg0eFhExrHcAM+la
	Z9rv5tbMYv4F66NjVbimMHxPsO8NyKI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-SOx90uyXOvy1n8fT4n9uqA-1; Wed,
 07 Feb 2024 13:42:13 -0500
X-MC-Unique: SOx90uyXOvy1n8fT4n9uqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3689A38212CF;
	Wed,  7 Feb 2024 18:42:13 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.32.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ADEB340C9444;
	Wed,  7 Feb 2024 18:42:12 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	David Jeffery <djeffery@redhat.com>
Subject: [RFC PATCH 0/6] async device shutdown support
Date: Wed,  7 Feb 2024 13:40:54 -0500
Message-ID: <20240207184100.18066-1-djeffery@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

This is another attempt to implement an acceptable implementation of async
device shutdown, inspired by a previous attempt by Tanjore Suresh. For
systems with many disks, async shutdown can greatly reduce shutdown times
from having slow operations run in parallel. The older patches were rejected,
with this new implementation attempting to fix my understanding of the flaws
in the older patches.

Using similar interfaces and building off the ideas of the older patches,
this patchset creates an async shutdown implementation which follows the
basic ordering of the shutdown list, ensuring the shutdown of any children
devices complete whether synchronous or asynchronous before performing
shutdown on a parent device.

In addition to an implementation for asynchronous pci nvme shutdown, this
patchset also adds support for async shutdown of sd devices for cache flush.
As an example of the effects of the patch, one system with a large amount of
disks went from over 30 seconds to shut down to less than 5.

The specific driver changes are the roughest part of this patchset. But the
acceptability of the core async functionality is critical. Any feedback on
flaws or improvements is appreciated.

David Jeffery (6):
  minimal async shutdown infrastructure
  Improve ability to perform async shutdown in parallel
  pci bus async shutdown support
  pci nvme async shutdown support
  scsi mid layer support for async command submit
  sd: async cache flush on shutdown

 drivers/base/base.h           |   1 +
 drivers/base/core.c           | 149 +++++++++++++++++++++++++++++++++-
 drivers/nvme/host/core.c      |  26 ++++--
 drivers/nvme/host/nvme.h      |   2 +
 drivers/nvme/host/pci.c       |  53 +++++++++++-
 drivers/pci/pci-driver.c      |  24 +++++-
 drivers/scsi/scsi_lib.c       | 138 ++++++++++++++++++++++++-------
 drivers/scsi/sd.c             |  66 +++++++++++++--
 drivers/scsi/sd.h             |   2 +
 include/linux/device/bus.h    |   8 +-
 include/linux/device/driver.h |   7 ++
 include/linux/pci.h           |   4 +
 include/scsi/scsi_device.h    |   8 ++
 13 files changed, 439 insertions(+), 49 deletions(-)

-- 
2.43.0


