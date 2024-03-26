Return-Path: <linux-kernel+bounces-118551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE9F88BC86
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E982E2A22
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E94C1C698;
	Tue, 26 Mar 2024 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kKWd982T"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166481B960;
	Tue, 26 Mar 2024 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441991; cv=none; b=mZVCsuASM2MPzRiTWxcyAJ5rmSUSr+SFdh/2vRZpRjD4zt3bTXK5WPqHgbGQeeGMhqhZLedog7xK+EBG3I3J7M+g6ZxSrlySwbJaz1JwpGHMp6fMbD6C/SAd2vOc+iUT2WmkZJ5JVgIYmQsTFnVlk2xuBxcVwj7JMdLtCeOZwNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441991; c=relaxed/simple;
	bh=X7+4KVzj+INVftb1XPxFrElhvElDi9XhXhgLUeP5tao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TooqZ+YFAXMnYbSRAKeT2zcDXI35Ga2uL+Bdz2oCVuEkAD874++mqA1Pcj6WUK3bkJIIX9gmakaIqTaNKClHzatONX8nxTPBxrrSm7kxxIqT8BRJ8C6YwTdYQufKD7Czot2SOY4Xg6HJ1uYQahmkR0yM1PJN6VHIBnCR6N3JO58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kKWd982T; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711441988; x=1742977988;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X7+4KVzj+INVftb1XPxFrElhvElDi9XhXhgLUeP5tao=;
  b=kKWd982TTAYtK/vc62R/bUI3ELGf821NFAy8GMlSASQWwF8zvNWGmgM5
   RZLZY+TQmt0r7faNHS4yStBspZ5ti66Ci5vpk4gxuhaazMtzuv64F6IHE
   O4ZC4Eo6MBuvZE0QKL9jio+oDQwxkGwGQLXoigE05zw0ebR5UzZ+wpbAE
   5o5ks7pBJtO+YnWBpaRjt2TQeqdB4lnK3YfU1+DMnmrpBsDtPNHA/BE6y
   sQlPw7McWWScw24mEWVntNL1RhCKBhM55Drfe3W2txFYXeUh8iF8K8T5a
   dk4An80gH+KokMERCuNNvuGjzWmub/SbxJImxVP6D3NbK/k66+I8xJiiP
   Q==;
X-CSE-ConnectionGUID: lE2J/7VFSXOQH1Urhd9cNg==
X-CSE-MsgGUID: OTeUt5m5SuSGZoiUvRQrqw==
X-IronPort-AV: E=Sophos;i="6.07,155,1708358400"; 
   d="scan'208";a="12729617"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2024 16:33:02 +0800
IronPort-SDR: 3Bp5sqZG2tGrfTjcBo3vuK/zcntrqHwUuoVUQ8m5LN83IezjhlFuwmJMhuLDdDjiftcnKOOPTy
 D5RDeoGF2P6g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2024 00:36:07 -0700
IronPort-SDR: 1all28SjAlzNAWcIc9eIcOQqSKdriePZ4touIxj2Ab+pE7cRKsNbKX+PVTPeoqUiyHkpWdr1Z5
 oFCp0mXoidJw==
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Mar 2024 01:33:01 -0700
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 0/2] Remove support for legacy UFS
Date: Tue, 26 Mar 2024 10:32:48 +0200
Message-ID: <20240326083253.1303-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UFS1.0 and UFS1.1, published in the early 2010s, were more of a proof of
concept rather than a mature functional spec. Toshiba was the only
device manufacturer with the most accomplished phy team to come up with
a small UFS1.0 device. Alas, there were no commercial platforms it can
be paired with. Even UFS2.0 that was published in 2013, didn't really
make it to the market: too moot to take effect. It's not until UFS2.1
that was published in 2016, were a myriad of devices and platforms
flooded the market. Designated to mobile devices, dictates a rapid short
lives for those platforms. Hence, we can safely remove those pre-UFS2.1
pieces of code.

Avri Altman (2):
  scsi: ufs: Remove support for old UFSHCI versions
  scsi: ufs: Remove legacy tuning calls

 drivers/ufs/core/ufshcd.c   | 169 ++++--------------------------------
 drivers/ufs/host/ufs-qcom.c |   3 +-
 include/ufs/ufshci.h        |   7 --
 3 files changed, 16 insertions(+), 163 deletions(-)

-- 
2.42.0


