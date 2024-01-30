Return-Path: <linux-kernel+bounces-45132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9F7842C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5225D1F25758
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063BB78B65;
	Tue, 30 Jan 2024 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S3nVabP8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE1F78B4D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640395; cv=none; b=U3vTXOL2Pt7p8cPV4Vm7GthpLrEOi9X6RBotXGvSelHJt/PSEqqujfdUx0cqrVJruNoyACT3BN5/mUFs/5dZsJFzvBUgj5mV/2mlInRMSmSrBZ9eysuU4hEgk9lfdoyfJM1s4/yEnXWeX5xPm5YC0YQRSjwkA9pyddguIaSNYWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640395; c=relaxed/simple;
	bh=TYryKQ6Sza7hEPkyS5IKoJzK2LP8DjvU7jvBfEjpBxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=huimKqGlYp/p5VzFnonfcKg2rWVE4D+DbMtczq6y+GeD2LPl6kpY4m8LJ6sDDtKEzufIe315WTXkFz0fgL80xa7WPmFIduWY7GCn8MBi2CJ7/Igydu04/VdiV+i6Qcd9PHWdSyZSNN5iZcZZRbDbDcKzZsgx8s1KvcT2PeihGtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S3nVabP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E49C433F1;
	Tue, 30 Jan 2024 18:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706640394;
	bh=TYryKQ6Sza7hEPkyS5IKoJzK2LP8DjvU7jvBfEjpBxk=;
	h=From:To:Cc:Subject:Date:From;
	b=S3nVabP8zfzQDZjSPHzhoj0sixm19miQTVDcAbtX+lLYusw9AhcgejzQD2PBapHGi
	 DCzL8LhxVgvIuREgOyArY2CPnwx5AME4LHpR9AcHMdP2HY+GZkV5D8G2wx07870ASy
	 R43HhU9CK0zCDSq5MoEdHIva7df69z6ZbdCLp3zs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 0/7] Soundwire: clean up sysfs group creation
Date: Tue, 30 Jan 2024 10:46:26 -0800
Message-ID: <2024013025-spoiling-exact-ad20@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 48
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=TYryKQ6Sza7hEPkyS5IKoJzK2LP8DjvU7jvBfEjpBxk=; b=owGbwMvMwCRo6H6F97bub03G02pJDKk7XZgUpkw/8i1mjpf5vskd1XsEu3VXlSzQ2nfY7cxM1 Zn/N7x50xHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQATEdBgmKdh8S49pX36Ec0z t1h3TZwk5Hhl2wOGuXLrk/Z/mxsiY7F+odgGlu8n/maoTgQA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Note, this is a redone version of a very old series I wrote back in
2022:
	https://lore.kernel.org/r/20220824135951.3604059-1-gregkh@linuxfoundation.org
but everyone has forgotten about it now, and I've reworked it, so I'm
considering it a "new" version, and not v2.

Here's a series that adds the functionality to the driver core to hide
entire attribute groups, in a much saner way than we have attempted in
the past (i.e. dynamically figuring it out.)  Many thanks to Dan for
this patch.  I'll also be taking this into my driver-core branch and
creating a stable tag for anyone else to pull from to get it into their
trees, as I think it will want to be in many for this development cycle.

After the driver core change, there's cleanups to the soundwire core for
how the attribute groups are created, to remove the "manual" creation of
them, and allow the driver core to create them correctly, as needed,
when needed, which makes things much smaller for the soundwire code to
manage.

Comments appreciated!

thanks,

greg k-h

Dan Williams (1):
  sysfs: Introduce a mechanism to hide static attribute_groups

Greg Kroah-Hartman (5):
  soundwire: sysfs: move sdw_slave_dev_attr_group into the existing list
    of groups
  soundwire: sysfs: cleanup the logic for creating the dp0 sysfs
    attributes
  soundwire: sysfs: have the driver core handle the creation of the
    device groups
  soundwire: sysfs: remove sdw_slave_sysfs_init()
  soundwire: sysfs: remove unneeded ATTRIBUTE_GROUPS() comments

 drivers/soundwire/bus_type.c        |  5 ++-
 drivers/soundwire/sysfs_local.h     |  4 +-
 drivers/soundwire/sysfs_slave.c     | 64 ++++++++++++++---------------
 drivers/soundwire/sysfs_slave_dpn.c |  3 ++
 fs/sysfs/group.c                    | 45 ++++++++++++++++----
 include/linux/sysfs.h               | 63 ++++++++++++++++++++++------
 6 files changed, 126 insertions(+), 58 deletions(-)

-- 
2.43.0


