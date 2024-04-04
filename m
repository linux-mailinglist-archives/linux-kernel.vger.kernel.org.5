Return-Path: <linux-kernel+bounces-131067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E308982AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D36B23BF7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35A045970;
	Thu,  4 Apr 2024 07:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDA0Ke+u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979505A110
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217581; cv=none; b=ePaFyOj7Om6MCPDLMIiwzcItmEns70cYrCLfJBKkZcgE5yu/9Vi82TUltqMCMdBf2BNrryvBVEI04ohJ6wTgX8VaDcO/56PZnsHXnE3E6l8oMbcje8ExxSHjRDV65eSWU15GDkxd0iaGeinaJVYkRsbUz3XrrCTG+X4gNBvSmzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217581; c=relaxed/simple;
	bh=2HnoNe7Q3OK3XTXFhKQt4pnA/1fH8WuwGxxYk6DYH6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J88c8SQrzSlsPf/GsRosVsr6T2hVfbmqFG9gjJvzdxpK548PGHjbo+I3hIpAiRaq98iIX3swA2GDiNPvC5olIwBvS0K1+Qxkbp8fgy9ptZX4i8ePvVM4mLjVBv5BBIlGUc47OoTGlMYjfjskxMb5SN3EjgMoZuJAC+WC+wNixak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDA0Ke+u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712217578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ne5O+kLXAYiWdUCUDf3J7afXMactHb5xvcMlkba4fGY=;
	b=SDA0Ke+uOlWZJQ3Z7N2xabYiajWKnHNRzMaU/cCyBsgKw6Pe6Qm7wGCnb6GZJTBzs4rygY
	ljXwXEjJ7rMJu1kftmNLYNTWPCSDeasfx3uXPqRmkunak2mOIUbODiHc+V1fUIuH8OeuXM
	WUODVJUORZzWayOu7pa4WKzfg66r4qQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-PncMlps5OsaZhvpF4hXbMQ-1; Thu, 04 Apr 2024 03:59:32 -0400
X-MC-Unique: PncMlps5OsaZhvpF4hXbMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B46485A58B;
	Thu,  4 Apr 2024 07:59:32 +0000 (UTC)
Received: from ksundara-mac.redhat.com (unknown [10.74.17.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E17202024517;
	Thu,  4 Apr 2024 07:59:24 +0000 (UTC)
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
Subject: [PATCH v8] ice: Add get/set hw address for VFs using devlink commands 
Date: Thu,  4 Apr 2024 13:29:16 +0530
Message-Id: <20240404075917.4347-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Dear Maintainers,
    Thanks for the review and suggestions for my patch.

v7 -> v8
--------
- Added const keyword for the parameter ``mac`` in ice_set_vf_fn_mac()

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


