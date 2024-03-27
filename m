Return-Path: <linux-kernel+bounces-120478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E8988D821
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F394D1C25533
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940EF2C6BD;
	Wed, 27 Mar 2024 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izE0/7RP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC0538A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526265; cv=none; b=okJPwV73nTNTThMrDE0sZxKE5+GTBwywkM7VnN3kW4oqcSvKPcCZa+EFdT37FV8S2ykmhXDYMnxEiWK7VHc3Z6Qay3fxa2mPMkW18OU/ZUh6qRs6dDwpb92O+ePxxTGohvMV8ZWSqFVOmrQXfJAZZr3I1aXVZnE1cT4r1X4tkNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526265; c=relaxed/simple;
	bh=ffUFzXQAag0alG3z4MwNgX5emJ6TtN0A/5cPjs1ntuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pxgzuxlgqgsD694bdL34vbi3XSwYgeIo6aqCD4K5kKKCkWGlNZ5/RW3iKUx/O/sVtJAU2ojbLf3sP3OKmDoHXmhwcLtaU/XmLjN0x1XSChev2LLWXsQooZVtu0IE15YfWPnOHFykkuT7N8CZZvtqfohokfgfFAr0ku+sFnN2X7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=izE0/7RP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711526263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jz1vvdFD+Eq8cb9G2Bv1kGIJT1qi79TE/Yvgly9pFp4=;
	b=izE0/7RPT+8rm+sLWZg8XF+BDPUjKxNfaZp/n3QijuNYaLCMkyQpOog2pI4DXbIUHllSFC
	KP9w1svogdJUA/ApYNg8wgdlQMf+pHg0xUUHbI+cKSzAopGDqiDzChI3Y9MeTNXdZP2AwZ
	4K1sM5yMYYKbauQawrPoxniFITdi0g8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-sAbaLoo_N5ubFQQrgTYL3w-1; Wed, 27 Mar 2024 03:57:40 -0400
X-MC-Unique: sAbaLoo_N5ubFQQrgTYL3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C692101A523;
	Wed, 27 Mar 2024 07:57:39 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.224.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E0233C1596E;
	Wed, 27 Mar 2024 07:57:37 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mschmidt@redhat.com,
	aleksandr.loktionov@intel.com,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH iwl-next v2 0/7] i40e: cleanups & refactors
Date: Wed, 27 Mar 2024 08:57:26 +0100
Message-ID: <20240327075733.8967-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

This series do following:
Patch 1 - Removes write-only flags field from i40e_veb structure and
          from i40e_veb_setup() parameters
Patch 2 - Refactors parameter of i40e_notify_client_of_l2_param_changes()
          and i40e_notify_client_of_netdev_close()
Patch 3 - Refactors parameter of i40e_detect_recover_hung()
Patch 4 - Adds helper i40e_pf_get_main_vsi() to get main VSI and uses it
          in existing code
Patch 5 - Consolidates checks whether given VSI is the main one
Patch 6 - Adds helper i40e_pf_get_main_veb() to get main VEB and uses it
          in existing code
Patch 7 - Adds helper i40e_vsi_reconfig_tc() to reconfigure TC for
          particular and uses it to replace existing open-coded pieces

Changes since v1:
- adjusted titles for patches 2 & 3

Ivan Vecera (8):
  i40e: Remove flags field from i40e_veb
  i40e: Refactor argument of several client notification functions
  i40e: Refactor argument of i40e_detect_recover_hung()
  i40e: Add helper to access main VSI
  i40e: Consolidate checks whether given VSI is main
  i40e: Add helper to access main VEB
  i40e: Add and use helper to reconfigure TC for given VSI

 drivers/net/ethernet/intel/i40e/i40e.h        |  30 ++-
 drivers/net/ethernet/intel/i40e/i40e_client.c |  28 +--
 drivers/net/ethernet/intel/i40e/i40e_ddp.c    |   3 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  36 +--
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  29 ++-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 205 ++++++++++--------
 drivers/net/ethernet/intel/i40e/i40e_ptp.c    |   6 +-
 .../net/ethernet/intel/i40e/i40e_register.h   |   3 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  98 ++++++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   3 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  14 +-
 11 files changed, 282 insertions(+), 173 deletions(-)

-- 
2.43.0


