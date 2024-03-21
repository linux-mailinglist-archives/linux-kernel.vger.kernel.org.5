Return-Path: <linux-kernel+bounces-109775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE74A88558B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5381C21277
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D9F1DFD2;
	Thu, 21 Mar 2024 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VjHE5wvW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D605F41E4E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009015; cv=none; b=hpUlkRyRGr+ge9etQspJpTEuRv7IT/6vYcDvdzf544cIV3hF7jvpthqMbK+wMuMx1eHQXLZSDqbgW5HoXAW07/ITB/kqBCB4kWh2ZZ4fxJNMxMauZPs4Wd4EhdUy9JU/elw5xKllmLGzMAZNV2g0uMMFXbDyt+sflSuEdEjIFeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009015; c=relaxed/simple;
	bh=+Mm+6jpJmyXFW/THWAVO/dtwVFwixZ6ckZAHYj76i1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KWGn/gySrjaOkpsJS1xZbNPbPatQOENIRNDzmneFv/ruP+kIiACqSTfGsB3xukgWxVobwDmT4Tb24S2Z1j4/milGNngHAWSPI5X2p2cWaP5e70iExa6o5HBZxMH2TGzTa7hiq0E8+0DGVdbnJWzl6njbw2p9gi0P9vTby3a96pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VjHE5wvW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711009012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1nZmh/jwo6v3OqQ8SYcKAELLaS9OFz7pGZrI8EdfDco=;
	b=VjHE5wvWtyMKSJjxxBVhgbTqj0BCIGoSp+bgfJ10+LMERCB8cEFuA9APEtjgsdgynom73K
	sGntnDrMzOk3/9hHmsN0Rd1PZuWZYqbJ8RAdn4xsPugiFxabjYlNjL5sMjhGdqVL6t8WWt
	jS6gdBpbib0tlGlHzKoM3gKJ0Jb8V6g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-OiBPrs-5OmuMWVaRFoX0Vw-1; Thu, 21 Mar 2024 04:16:45 -0400
X-MC-Unique: OiBPrs-5OmuMWVaRFoX0Vw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC0CF85A58C;
	Thu, 21 Mar 2024 08:16:44 +0000 (UTC)
Received: from ksundara-mac.redhat.com (unknown [10.74.16.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BE6C41C060A6;
	Thu, 21 Mar 2024 08:16:37 +0000 (UTC)
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
Subject: 
Date: Thu, 21 Mar 2024 13:46:24 +0530
Message-Id: <20240321081625.28671-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Dear Maintainers,
    Thanks for the review and suggestions for my patch.
In this patch v6, I have used container_of() instead of
ice_get_vf_by_id(). Also since the ice_set_vf_fn_mac()
is a copy of the existing function ice_set_vf_mac(),
except for the parameters, I didn't absorb the review
comments on that. Please advise if the validation checks
needs to be modified.

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


