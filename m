Return-Path: <linux-kernel+bounces-120466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFD688D7FD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D3829AB4F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695512CCD6;
	Wed, 27 Mar 2024 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGE283kE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5CC2C1B4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525726; cv=none; b=e2nmrrENPNSAGYdP38MK/TzfwUEg4JfnfWjlgzSotwGL3nhoZORiScnLJgSlscrA2QfqBeerTf7q0wgNMmLw8cYhmW8ho4iu1JOlI8Vt4M9RQIUL21xt+MmOU17mUz++0bZZQvyaWLKDs1lPh4ro9aXnvnOnDpwS6bAQXzGlOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525726; c=relaxed/simple;
	bh=4sl0oSN1BXFDdtolW8v8qbePP+GxgJ1NSQEbU86HuFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZL9XMLRbbprHnyj9SLW4eJZtu0fAGEGuE8J09a5DzOXpmgsgDHJ4fD2HTuv9kheqaNNKHJRw/vUwhx2XWqjIKNllSA6Wv8yV2rpWiVksM9GlQ05BPL/6tQwxPhaVdWu+XntorcA3EjiBtZ9L3Ej8IbUuxWkEkGxzl8P1kEAVHWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aGE283kE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711525724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0yBaS1hfGcIJ0g5TQWCk0L3glJvaFE4LWtb3UsOxD4A=;
	b=aGE283kEVQWNHW5XrAnBtR2OugjtvVKsnEcws5rxrwP3ArK4DK3Z7510OqhbfjAMeNqtFv
	psgx71onjRInA4LCDzLZJK03uMSSeZ/cl0WZ9nA4gMhDz6Pd/l+8jbDbGXNjw8SIh77phF
	KTkvPqmCHN5Bosl/VMtqSvAxa85wKKo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-sv2Iot2kNQKb-W_tfZ0jdA-1; Wed, 27 Mar 2024 03:48:40 -0400
X-MC-Unique: sv2Iot2kNQKb-W_tfZ0jdA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0EF185CE42;
	Wed, 27 Mar 2024 07:48:39 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.224.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0C62F492BD4;
	Wed, 27 Mar 2024 07:48:37 +0000 (UTC)
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
Date: Wed, 27 Mar 2024 08:48:25 +0100
Message-ID: <20240327074833.8701-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

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
  i40e: Enforce software interrupt during busy-poll exit
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


