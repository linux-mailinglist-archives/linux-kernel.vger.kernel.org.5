Return-Path: <linux-kernel+bounces-150150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 920D08A9B04
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8B41C20752
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710DE15FA91;
	Thu, 18 Apr 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCz1GL0A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E01F14291B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446286; cv=none; b=ZvOT5GUvvranGW5Lq5fzESPeai1BQyCwRxGrj5goNr3WOFAX5PEgm6ujmS+w1cWEC9JAWkpDAWnak4CFQrvMQJR3BD31qHQNLw8GJUjxAS14hVq14K7WoLYdODjfD7zf9SbeR7jPSfQ5EoOD3NXSOsizJIdObkJ6JdEn+FQ833U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446286; c=relaxed/simple;
	bh=DXGn4qVv3QckU8tQRWbJr0FqwlVzB+OywFLorem+Pzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GqCCT7IGav2jXasKG5RNk8NFK2yQ0P/CgSdRggMUJuiLIFWzv4RY2FOTJQYzAkz5OXU4lDsRAVSTk+OnFevfwNqaG7N9SetcTJySAV99cUTRz3QgiK5ASiunvj+Jwq7VDlzVc2GyFzJ8XtB6b5eBlmcj4BKoWLoMAaYRwvMZlLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BCz1GL0A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713446283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=flXWdtTxGnWZOnWp6rT3waOHYiUoEw2A69kXCBp6sk4=;
	b=BCz1GL0AlzhzTQrNwq2gFQrG2ayGBmm6LcXLxJO8jkBaH0x/sRbSXMZ+JsKyhvPNiV/KW4
	YTwXpNu4q9XR3fRarGMLQTVNk5FpRouHlsYDTO7ttDd0SzIjQD1LbaUmyIXh6i1UhaT5sy
	lyEJ0cyCzjNWuIEqZGQ59TkArASxE/s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-JogV6t9rPumfDMhvbxkkvA-1; Thu, 18 Apr 2024 09:18:00 -0400
X-MC-Unique: JogV6t9rPumfDMhvbxkkvA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78D99834FB3;
	Thu, 18 Apr 2024 13:18:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 53BDAC26D24;
	Thu, 18 Apr 2024 13:17:58 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	linux-kernel@vger.kernel.org (open list)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 0/2] kunit: fix minor error path mistakes
Date: Thu, 18 Apr 2024 10:17:51 -0300
Message-ID: <20240418131754.58217-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hi,

These two patches fix some minor error path mistakes in the device
module.

Wander Lairson Costa (2):
  kunit: unregister the device on error
  kunit: avoid memory leak on device register error

 lib/kunit/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.44.0


