Return-Path: <linux-kernel+bounces-63549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7083985311E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A831C26737
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E9E4CB22;
	Tue, 13 Feb 2024 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMeYLfGS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD8543AD1;
	Tue, 13 Feb 2024 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829226; cv=none; b=l1V7llH0aCnQ+0a/iw6qhRhzOh6vbSO7XXfDiQUkeX+boAcnBFhDgvfgOel1uWf/h/9hcVWti+r6yAqgFGeqdF+AC2e8r+nDR7X7OiJkIpIVIbc9IzQUdyDSlmau5ptZdqSlI5IWXcGHyXTgqCxN/HZV2rrXyTsS92kzsGkxo0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829226; c=relaxed/simple;
	bh=iLASq6PGk0pCcLZpQwuo3+UhK6BRy553sU7kvPf0prQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dn9xLyphTKgOIPHjDpMSACpTGFRGGoX0sYcK/N6pK5oKh1+5c9pYZAM6XeByoRSEtyhiiqDi9Js8ae+09YuDLHaAi3DOO2OSUwF0mYlt0Mr47qeeuASjdNAsywLFNGV+a6EB79h+wGayuHH2jDFUR7XjjxBQ5uRYhKNrtbVDiwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMeYLfGS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707829224; x=1739365224;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iLASq6PGk0pCcLZpQwuo3+UhK6BRy553sU7kvPf0prQ=;
  b=RMeYLfGSuRDA0YtGikwwQgI/QB5RyZV8XQhfwD0kzVAHESzderioDCqC
   EydDLDWoNJ/q+pH18rTBDgUG0hfRE6gvZk82mdKC52zdPsT5hGFJaJa4Q
   EKwkDSSGRjfomhqcVbaI4w/Bx3p7swSGKE9KGHkOdxyxfkhzSnP8Wc7lm
   xltZAoYMf5X4PIt6Qmn7jYDqJ/JuEmJdddrhQ0E0tp0zOZjUi3TvWw7hJ
   /glbQr7DmDdLqDcDUjcM13QWseq9zYA9rQf4UHbCbToxbsmmUL/UUjlA0
   CtkRCisv0sIBBCsm4lTbSsOTsn2BzMcGuynndk0ow2Vbfm1QmXeDqSz8Y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1708879"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1708879"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 05:00:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935348366"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="935348366"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2024 05:00:19 -0800
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Prashant Malani <pmalani@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Emilie Roberts <hadrosaur@google.com>,
	"Nyman, Mathias" <mathias.nyman@intel.com>,
	"Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
	"Radjacoumar, Shyam Sundar" <ssradjacoumar@google.com>,
	Samuel Jacob <samjaco@google.com>,
	Uday Bhat <uday.m.bhat@intel.com>,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] platform/chrome: typec: xHCI DbC
Date: Tue, 13 Feb 2024 15:00:16 +0200
Message-ID: <20240213130018.3029991-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changed in v2:

The quirk is now wrapped inside an ugly ifdef CONFIG_ACPI :(
I don't have better ideas better ideas for this I'm afraid.

Side note! I will be away for the next three weeks (plus a few days)
starting from Friday (Feb 16).


The original message:

In order to use xHCI DbC we need to allow the USB to be muxed to xHCI
even when the connector is in device role. That's because in DbC mode
the xHCI is the USB device controller.

In the first patch I'm just adding symlinks between the USB role
switches and their USB Type-C connectors. That way the user space can
find the correct role switch simply by following the symlink.

The second patch modifies cros_ec_typec.c. I'm assigning the PLD
(Physical Location of Device) hash of the port to the USB role switch
when it's missing from the ACPI tables. That should make sure the
first patch always works.


Heikki Krogerus (2):
  usb: roles: Link the switch to its connector
  platform/chrome: cros_ec_typec: Make sure the USB role switch has PLD

 .../ABI/testing/sysfs-class-usb_role          |  6 +++
 drivers/platform/chrome/cros_ec_typec.c       | 19 +++++++++
 drivers/usb/roles/class.c                     | 40 ++++++++++++++++++-
 3 files changed, 63 insertions(+), 2 deletions(-)

-- 
2.43.0


