Return-Path: <linux-kernel+bounces-93255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E973E872D16
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814671F28929
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1C4DDA9;
	Wed,  6 Mar 2024 02:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ylj4pOSC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B21633E1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709693905; cv=none; b=E9gKQ1R9sNGUTc3M6zjuHmCM+xG+x9OX/FNDf901VNbEyEZU7hMcn1aeNWmK/Im5/p6wqHAZYqvU1/qqy31QDHTaPUS7p6bYOBDwSKAIgl/nag/bZtMPK3EORT3rchmgqowuKSbNGCMFLNi6IM/8EHkn3hlszNxs4aL4jNYSt3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709693905; c=relaxed/simple;
	bh=a0OOWv2WSGmSbvPtvl2vO3P9ZD7k/by876B14jjFqP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qt3TaEZiNNf8+ct1oLgUpxSCljoRlUoR9rktvtLl5v9NH6vZXRt04PeNyZJMiV412SCARJpDldD+zDMLJkveCShLqmg5iPMAX+wiAsHIsimuXYmFugOKH5iOSH49R++ZoyPPzYXSVXC/X4zMTfMFhkNUfrIEqTcKp/+dOO7/rwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ylj4pOSC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709693902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NpaEtz8DypAu/ov2Q0LUUMD0B3ELzhFV6wWxCNb2Rjc=;
	b=Ylj4pOSCFcS/Fz00gBOCJLdk9EBqq2TYDAwiG5GIXEBIQHL9AtRedJ8aSp1c+0rWxc5Q3U
	VsmH3PEyX5NSZAs8tVuebuOWhSFQ9J+jqw0ffbUH4KZ6q/uuv9IHXoH+5s5+GdrAUZpIdR
	xVAhHzfUy/op1uZoLcpt9cFJmjrnj8M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-5dusHTwePVCJ3TuZP1Wrpw-1; Tue, 05 Mar 2024 21:58:21 -0500
X-MC-Unique: 5dusHTwePVCJ3TuZP1Wrpw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 945338007A7;
	Wed,  6 Mar 2024 02:58:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0BA0D111DCFF;
	Wed,  6 Mar 2024 02:58:15 +0000 (UTC)
From: Kate Hsuan <hpa@redhat.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	linux-kernel@vger.kernel.org
Cc: Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v4 0/2] KTD2026 indicator LED for X86 Xiaomi Pad2
Date: Wed,  6 Mar 2024 10:57:59 +0800
Message-ID: <20240306025801.8814-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

This patch added the support for Xiaomi Pad2 indicator LED. This work
included two parts.
1. Added the KTD2026 swnode description to describe the LED controller.
2. Migrated the original driver to fwnode to support x86 platform.

Moreover, the LED trigger is set to bq27520-0-charging for Xiaomi Pad2
so the LED will be turned on when charging.

--
Changes in v4:
1. Fix double casting.
2. Since force casting a pointer value to int will trigger a compiler
   warning, the type of num_leds was changed to unsigned long. 

Changes in v3:
1. Drop the patch "leds-ktd202x: Skip regulator settings for Xiaomi
   pad2"

Changes in v2:
1. Typo and style fixes.
2. The patch 0003 skips all the regulator setup for Xiaomi pad2 since
   KTD2026 on Xiaomi pad2 is already powered by BP25890RTWR. So, the
   sleep can be removed when removing the module.

Kate Hsuan (2):
  platform: x86-android-tablets: other: Add swnode for Xiaomi pad2
    indicator LED
  leds: rgb: leds-ktd202x: Get device properties through fwnode to
    support ACPI

 drivers/leds/rgb/Kconfig                      |  1 -
 drivers/leds/rgb/leds-ktd202x.c               | 60 ++++++++-----
 .../platform/x86/x86-android-tablets/other.c  | 85 +++++++++++++++++++
 .../x86/x86-android-tablets/shared-psy-info.h |  2 +
 4 files changed, 127 insertions(+), 21 deletions(-)

-- 
2.43.2


