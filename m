Return-Path: <linux-kernel+bounces-76742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABA485FBD8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6E7286251
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4F514AD33;
	Thu, 22 Feb 2024 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lm3cwuGb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642CE148FFF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614362; cv=none; b=BwEqMszhw/bZGbW4H/GwIp3d8L6ULjswpcTFD4vaRN89JxDhYg0Df3yYUMaT3G4BDeQi+OuP5v5KUVQihDjHy3BtZF+3vdlLMn6V6BaiYSP+yl/FtFZScrYBNx3WRXWBzc0+ejESVZ5fnvplrnCHX+IwDOdUcBLIpGs0kejxGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614362; c=relaxed/simple;
	bh=LrVPZWKPvAwwNnJBB+ZsEXFSkibSCPFppTM1oYFKraw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nh6VALXFv5YcJI8wBDmx68It3KvoyAmCE1svUclZ6Fadv9/hXx2xOGd+u2DxHAH0KQMfb1k6fACyuxf1tcfeTcAf8/+xa3Iz73yvQl8PsIBhb0Wrca7+PzeDTSGtwacX8yCI3RKO0sNOVo7aiuu8Ihk44K3QX97+siKoIjuX1Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lm3cwuGb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708614359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K1qX5Dv03TawtMyhU4ox9jjO9nXnBiVGZNH0InUyUNk=;
	b=Lm3cwuGbg+IwvfG/BI0VqeJ3pmvt93J+iUAjAbMYkKoQzWLPpKHe5RHSCbkRCl9/t8Uhzp
	cQbPXVV3lkZuRHwyAj5wsKWpj8ivcaoQ9m/LKAtDNoX/G3iTKocUmRPN+wZydIc3AOidhV
	58iEhqEHu3s8BUdsycEulLrE1xffNuw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-HNe1d8dePnGUIWX7MVU-cw-1; Thu, 22 Feb 2024 10:05:55 -0500
X-MC-Unique: HNe1d8dePnGUIWX7MVU-cw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DBDE848530;
	Thu, 22 Feb 2024 15:05:55 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F23D7111D3D9;
	Thu, 22 Feb 2024 15:05:53 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	George Stark <gnstark@salutedevices.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/4] locking: Some locking code cleanups
Date: Thu, 22 Feb 2024 10:05:36 -0500
Message-Id: <20240222150540.79981-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

 v2:
  - Add Boqun's "Reviewed-by" tags & twist the mutex patch as suggested
    by him.

This series contains a number of cleanup locking patches.

Waiman Long (4):
  locking/qspinlock: Fix 'wait_early' set but not used warning
  locking/mutex: Clean up mutex.h
  locking/rwsem: Clarify that RWSEM_READER_OWNED is just a hint
  locking/rwsem: Make DEBUG_RWSEMS and PREEMPT_RT mutually exclusive

 include/linux/mutex.h               | 8 ++------
 kernel/locking/qspinlock_paravirt.h | 2 +-
 kernel/locking/rwsem.c              | 6 +++---
 lib/Kconfig.debug                   | 4 ++--
 4 files changed, 8 insertions(+), 12 deletions(-)

-- 
2.39.3


