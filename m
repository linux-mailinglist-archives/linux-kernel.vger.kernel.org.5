Return-Path: <linux-kernel+bounces-142002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B323A8A25FD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4574F283CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD081C29F;
	Fri, 12 Apr 2024 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvWFjWy7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3755C1BC20
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712901155; cv=none; b=MobcQcD09woaw6l8Qvus/yiidCi+zrU7rW0RARfVhqWuqTQve/wWqS1huwV0GbpYROqX3L1XEcCFzWwnpbxIov+Rz2w9CpkbMq+pe2gwgZpwwOsaQU30YtZU/yO0IfmgrX1ZCboyBZ7mJkwJMbfS960Do+GLf8NoQdYYn9L4AOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712901155; c=relaxed/simple;
	bh=V621O0YRTWbLI+BhzFycCGaega5dEzrZXvidb2hQxco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZunSwVO5xdBghqCGhsLIcbf5c0y/MT0mtfFZlQv7gC1Abo4lj1VcCymKck4dWOEYIDTgmNZtUt3hUebZpN3Xe5PACMgJL5oTZ+9HvSP6mn3EFepoXpIh5EB1I88p+HgceGF9nVcKCQpjxbXbrFN95NbdQZ43TfWLISXqHw/eHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LvWFjWy7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712901152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g8I83xiAT6OHXZ3IKzixSSQQN+C4HTF6lAFLzGsf/Zk=;
	b=LvWFjWy7qA1eYJ8+bY7iOscH/2ha4IPEv8o55OMNNDDYTWeoOiinSz5cbaGo3Ajv/blIgp
	fXW0H3Mma9E/lauZqXrx0DMSkPUVtpnW+7jIfGg4wGaz6jNLKWoWkl34g1jwHHg23BSu+N
	WEG7+/t8z2eGYvwkP5f51/GwaofUSlY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-_9W3wrWKMLa8bEwYfdm1UQ-1; Fri, 12 Apr 2024 01:52:28 -0400
X-MC-Unique: _9W3wrWKMLa8bEwYfdm1UQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 235D4830E75;
	Fri, 12 Apr 2024 05:52:28 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.234])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E4E140B4984;
	Fri, 12 Apr 2024 05:52:25 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v3 0/2] misc: sgi_gru: fix Kconfig option text
Date: Fri, 12 Apr 2024 11:22:19 +0530
Message-ID: <20240412055221.69411-1-ppandit@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

From: Prasad Pandit <pjp@fedoraproject.org>

Hi,

This patch series properly indents help text of config option
and removes a redundant default value attribute.

Thank you.
---
Prasad Pandit (2):
  misc: sgi_gru: indent SGI_GRU option help text
  misc: sgi_gru: remove default attribute of LATTICE_ECP3_CONFIG

 drivers/misc/Kconfig | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

-- 
2.44.0


