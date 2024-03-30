Return-Path: <linux-kernel+bounces-125596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D87892931
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 05:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C08E1C2134D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 04:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F8D847B;
	Sat, 30 Mar 2024 04:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTBQ++0c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D6079F0
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 04:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711771467; cv=none; b=tAou6h3RnXpOc5PMN06aWjBBp+3m5NepbXIp3dgiXzz1FeMbKf0Ex5gj2dI0F6qglWYzjCq6TXR4spNg+FvzeXKRrJZRQBUOEYlLv5BH6ZrTnz2+QbhxSCF/36Xi12wQ2lH4NR6jWOEu3voubHpG33n27x1YIrZFXx9yHILlKek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711771467; c=relaxed/simple;
	bh=5cOW6r9FoMB9QhzzO1fDqmEwJjI8wkjP7OBdnj0H/QE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ncJUtiLDZ00Plas2qumyRF51ZxRpicg+LivbmzWeSJyoNNOSUjo04RsO3DHbqoULyhAKpUeuQNbQq5/f+759E9WgPaCMiJvIlogU9FHuWie85LLAHJe81uWuv12BIADmUVI1XeAYzliqzGGaD2Bs+jB1vKOv5uv4GiBH2rfC2dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QTBQ++0c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711771464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gHqHBmlZCFlWpIV0o442DO/wsxDS7T9buxAA+MkmTJI=;
	b=QTBQ++0cKrpL0LOZL46okVDdAn2rQxZrPQuUNWwHqB3OgDwxm0bpU6atdClWkVmTKVj45k
	/ZBFFH22lGu0xPr1sKHa2KIAI0U8e38HDEQjUNWeTam5prlyCROQhHm9ECoe+n9CkVtgHv
	ZvgSZ7WziP3VtH7Ycrr5LiTRMyGQtxM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-A7GX45R-N4W0xWuSmwRMFg-1; Sat, 30 Mar 2024 00:04:20 -0400
X-MC-Unique: A7GX45R-N4W0xWuSmwRMFg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBDD7185A781;
	Sat, 30 Mar 2024 04:04:19 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.51])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CB63CC01851;
	Sat, 30 Mar 2024 04:04:15 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v4] staging: bcm2835-audio: add terminating new line to Kconfig
Date: Sat, 30 Mar 2024 09:34:11 +0530
Message-ID: <20240330040411.3273337-1-ppandit@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

From: Prasad Pandit <pjp@fedoraproject.org>

Add terminating new line to the Kconfig file. It helps while
displaying file with cat(1) command.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 drivers/staging/vc04_services/bcm2835-audio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v4:
 - cat(1) command usage in commit message.
 - https://lore.kernel.org/all/CAE8KmOxG=3sWKpeB5fdWTK-SCipS=JyDE-_DNgY--DtoSQZ0Qw@mail.gmail.com/T/#t
v3:
 - fix typo and note about parsing errors.
 - https://lore.kernel.org/lkml/CAE8KmOzcD+__7xdC7tegbHO9HEP48s7=reA4j-tvqVDwzHr+8Q@mail.gmail.com/T/#t
v2:
 - remove Fixes tag and cc all maintainers.
 - https://lore.kernel.org/linux-arm-kernel/20240311100920.1271545-1-ppandit@redhat.com/T/#u

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


