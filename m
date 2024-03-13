Return-Path: <linux-kernel+bounces-101261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE5787A4AF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14BD0282D94
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C3D1B976;
	Wed, 13 Mar 2024 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ih49E8xO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02EE1B273
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321192; cv=none; b=rSMHR7LJlWjcogz51S/HDGlhqjXsjzI/+id4/W2Qn4q8kEzdQo9/wDjgKBjazGIo3OPQVbKdjk9+bUeIgS2EBhh2JLkbr0tds+glFofM4W4liuM0iISsYdrw8bWDHA4u5B7OZsHrY+TsBz1Slrg/LRsAAqXOEJwY48pbULjBvtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321192; c=relaxed/simple;
	bh=r+X8328ipwFNBoJDjN8mGCRUW53I09V6HqgarOZveCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sSozKiWm0ksxQ4Iccrn5arHqiexSRvEZKTM1qy0/zqJREVYfFuZ8djlNmx2yMBfgKYEJCFFNVqun17vkFkcZg8YSuicnRx9aL9kRw3vMsQ8DBVddrHeHmmy/VhhE9YhRfyzIRCy8vvG4gsCHol2fpqavIztYCE7sROqP1L3zuKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ih49E8xO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710321189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=75HuuVuSW3xTNtHoVuj3UQkwioukSu4YrMFtPrMEBII=;
	b=Ih49E8xOELTaERdiXJhMTJittRIlaNtaxUQlqVRu0a9gN7wEulL4uS5IAuWTMYWK1C2FGC
	XT9h/1y4MVLGEDVQg7TN5qC29yGWf3RDDg1IkBqdLaNFL9PP1jtP6trMjDnN5VEIt58yoL
	4+M3vvqtpXU0JFazfl2SSPbJjE1xeQk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-k_PasUtlMR-xiIBjthuRCg-1; Wed, 13 Mar 2024 05:13:08 -0400
X-MC-Unique: k_PasUtlMR-xiIBjthuRCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 747BF85A58B;
	Wed, 13 Mar 2024 09:13:07 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.67.24.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B0D7C40C6CB1;
	Wed, 13 Mar 2024 09:13:03 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: florian.fainelli@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org,
	gregkh@linuxfoundation.org,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v2] staging: bcm2835-audio: add terminating new line to Kconifg
Date: Wed, 13 Mar 2024 14:42:59 +0530
Message-ID: <20240313091259.1413854-1-ppandit@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

From: Prasad Pandit <pjp@fedoraproject.org>

Add terminating new line to the Kconfig file.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 drivers/staging/vc04_services/bcm2835-audio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v2: remove Fixes tag.

diff --git a/drivers/staging/vc04_services/bcm2835-audio/Kconfig b/drivers/staging/vc04_services/bcm2835-audio/Kconfig
index 7f22f6c85067..7fbb29d3c34d 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/Kconfig
+++ b/drivers/staging/vc04_services/bcm2835-audio/Kconfig
@@ -8,4 +8,4 @@ config SND_BCM2835
 	  Say Y or M if you want to support BCM2835 built in audio.
 	  This driver handles both 3.5mm and HDMI audio, by leveraging
 	  the VCHIQ messaging interface between the kernel and the firmware
-	  running on VideoCore.
\ No newline at end of file
+	  running on VideoCore.
-- 
2.44.0


