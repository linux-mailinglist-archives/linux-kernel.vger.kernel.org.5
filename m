Return-Path: <linux-kernel+bounces-151465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC948AAF40
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7147B22650
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E665127B54;
	Fri, 19 Apr 2024 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E20lzisu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018BB41C66
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533116; cv=none; b=kFwAgAF63L5RDLzu9/Z8QzuDeyGoHz5XBVj49DKjoYi4hdXIsE1MAxd7TOpoG73RWhWLMi4mZHYryyWxP9HluS911kR+BuQjq2BMczK1i6bCwJjFEem9Pzo/aiDEmo8lx3Ickgk1i2Y9bQL3/PSDRDgMvXh7c3S9NEHDy8Fst+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533116; c=relaxed/simple;
	bh=c6YNZQMZa7y63US6bB3GnkhSoC9TcxPMDsK3wXIYReI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FBjyGvflwu/35Tq9w/UUvDnwaGJeVGKqM8O7Sw5EOAi5B7YraWScNd8sXszvEE9cNdhUkxxNrVkZv8XN19E+Iw7f0tPiDoPFsLmwhrYYoqQI+Ki/X1/6p6P09GENDok4P/oJ6roZMbgHaA3n/JjVauqohlrm1Q6eC1N6BjJTi0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E20lzisu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713533113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C1PyGSiVgUoNQKymy+4spZn2EEqSqTryQAUGgxHMSt4=;
	b=E20lzisuu4JXLoVtDq2mqjTguAmCxCCI7sZX7/Rc+nOAggBtlzmzdH5pkwbKIbJ5uyd1FD
	Wli+yQbzAwR4+/K2VX59jQlI0S5cd9+5hauZH3ban/GZJEiFsAQssYmYZO4Yi+KT7r+q2H
	+1tpCXkb0inF2LY6Bz0lCbW1aW9c06s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-ZAJx059IPQC5AJitI_IIXQ-1; Fri, 19 Apr 2024 09:25:12 -0400
X-MC-Unique: ZAJx059IPQC5AJitI_IIXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9EA248943AE;
	Fri, 19 Apr 2024 13:25:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.8.218])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 230D33543A;
	Fri, 19 Apr 2024 13:25:06 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	linux-kernel@vger.kernel.org (open list)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v4 0/2] kunit: fix minor error path mistakes
Date: Fri, 19 Apr 2024 10:25:00 -0300
Message-ID: <20240419132504.9488-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hi,

These two patches fix some minor error path mistakes in the device
module.

Changes
-------

v1->v2
* Add fixes tag
* Add imperative statement in the commit description
v2->v3
* Add a goto exit label kunit_device_register_internal
v3->v4
* Remove some changes requested by Marcus Elfring, as I was alerted he
is a known troll.

Wander Lairson Costa (2):
  kunit: unregister the device on error
  kunit: avoid memory leak on device register error

 lib/kunit/device.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.44.0


