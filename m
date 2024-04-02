Return-Path: <linux-kernel+bounces-127626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D41EC894E99
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68F05B21FDC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C3158107;
	Tue,  2 Apr 2024 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDBLF8YA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5295732B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712049790; cv=none; b=ZMVZspr8P1hT4RlyRuzhRwmDWBbG3jYuN5Bp4GXHhE2fawvVGPOW3IQbJgt1Ums6cweorqCfHy0/1qLYKA6T3pLu9RMEdn6PaVpad6gwTsWvoTzCTAm7NimqWCfYoYOt63Eal8TK4zGTcmYxsqDEXCvLMa2lY8d1zl7rVEf0/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712049790; c=relaxed/simple;
	bh=2pzoB0R1l4BvIwrmQanEGaLv93obYpgqMFHKKona2lE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pTbMwzBxx/PW1rTy/GxHnzEtt+oroGKYkVxhxN3RxnoeYtQzv/96XlpylSDShu/gAsHi6dBOxE3/iFsdGeqliIojOqSio+z/4Opz+TpNzn+WAyXT6veDqOJSg5ZK0CqH9tKV3qf3VtqS1sihbTmZgkVDd6Jib3so2hmuY/jkd04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDBLF8YA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712049788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mPRN7R9lh26MvPps2r6V6QRCUDsWvQ9Nt6UYtfHL0SM=;
	b=fDBLF8YANVi3Qq1YJ7mnhtuGKVs6PZmUhtQpnYLgBtSz1PZPFsWTc9FlACXpIekON7FJYq
	7BmzW4dBlwRvDWjLY/whqj4gmWvG7S1DtoAoaUYfWaSQU4OM/9YcST5G83Jw2DDzMBfjZp
	dcP7dXnshflerxHYhM9a2u1lRCQ0p1Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-06wZo3tqMmKfKGCFN73DQw-1; Tue, 02 Apr 2024 05:23:04 -0400
X-MC-Unique: 06wZo3tqMmKfKGCFN73DQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2192E85A58E;
	Tue,  2 Apr 2024 09:23:04 +0000 (UTC)
Received: from ksundara-mac.redhat.com (unknown [10.74.16.172])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 347E32166B31;
	Tue,  2 Apr 2024 09:22:56 +0000 (UTC)
From: Karthik Sundaravel <ksundara@redhat.com>
To: jesse.brandeburg@intel.com,
	wojciech.drewek@intel.com,
	sumang@marvell.com,
	jacob.e.keller@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: pmenzel@molgen.mpg.de,
	jiri@resnulli.us,
	michal.swiatkowski@linux.intel.com,
	rjarry@redhat.com,
	aharivel@redhat.com,
	vchundur@redhat.com,
	ksundara@redhat.com,
	cfontain@redhat.com
Subject: [PATCH v7] ice: Add get/set hw address for VFs using devlink commands
Date: Tue,  2 Apr 2024 14:52:53 +0530
Message-Id: <20240402092254.3891-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Dear Maintainers,
    Thanks for the review and suggestions for my patch.

v6 -> v7
--------
- Addressed Smatch and checkpatch issues

v5 -> v6
--------
- Changed data type of vf_id to u16
- Used container_of(port, struct ice_vf, devlink_port) to
  get the vf instead of ice_get_vf_by_id()/ice_put_vf()

v4 -> v5
--------
- Cloned ice_set_vf_mac() to ice_set_vf_fn_mac() so that the
  parameter ice_pf is used instead of net_device of vf
- removed redundant error handling

v3 -> v4
--------
- Released the vf device by calling ice_put_vf()

v2 -> v3
--------
- Fill the extack message instead of dev_err()

v1 -> v2
--------
- called ice_set_vf_mac() directly from the devlink port function
  handlers.

RFC -> v1
---------
- Add the function handlers to set and get the HW address for the
  VF representor ports.


