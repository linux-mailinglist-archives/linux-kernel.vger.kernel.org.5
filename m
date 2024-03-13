Return-Path: <linux-kernel+bounces-101445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1038A87A729
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5371C220F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4563F8FB;
	Wed, 13 Mar 2024 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XomIDXYv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684F83D0DD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710330109; cv=none; b=p3knTxDxJcbZT7Qaka9uiNjpqODjWJMgS//YBIUy00MtubCRlF00mYWJd2ef1f56nS0UH0/mBVqR13+z+fqpsTjRVWf0BlIKntfVoYWENX9ZzFVWKhkSizqNa4kC0uVEK2YV09vGqtlzijNFpXUSp4aW0YIukHxw+OyIIfgZnQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710330109; c=relaxed/simple;
	bh=EP+UBSw06WyqmjbcslJ6kU71eJXTJxmwhp+wzAOZGc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GCvxHpNRFyCFnfoumjurq9ofLm1xeiA2odsU0/rlYDgUiqiLK44YRKZ7CidbEBswUsYS7xSijJqtp9JziiQV8lXNhgcZfdR6A58qOf6TRQmtpOoJID8yIlCK/3Roy0K/KMP+5SJrD3bHlbxH3VbsjAucrQTwvnhxf3qD/AmGwcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XomIDXYv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710330105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=phzUMfeINh6dbuyeZg9sPFnUlzhipZ5AmTkMI6GYbLo=;
	b=XomIDXYvGcOkFQXTV8Exls+y4/VTypDEyXyxt0LP8LcRV8dCk9rlXdyw+ypzdlI2RiUE1H
	fgPu/Q8BxyyAJC1lfXiehq07591Rk32JVYHpH8f6jIOABmChNILg80Zfk9zSnZ51Heu6sw
	FCRmuC6/rwjZXN1OxY5k/JTWSGKH4Yk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-yCpaULeNMjO4ZqHSiwzyAA-1; Wed, 13 Mar 2024 07:41:40 -0400
X-MC-Unique: yCpaULeNMjO4ZqHSiwzyAA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8039A89C56B;
	Wed, 13 Mar 2024 11:41:39 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.67.24.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A7339C44421;
	Wed, 13 Mar 2024 11:41:33 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: dan.carpenter@linaro.org
Cc: florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org,
	gregkh@linuxfoundation.org,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v3] staging: bcm2835-audio: add terminating new line to Kconfig
Date: Wed, 13 Mar 2024 17:11:26 +0530
Message-ID: <20240313114126.1418453-1-ppandit@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

From: Prasad Pandit <pjp@fedoraproject.org>

Add terminating new line to the Kconfig file. It helps
Kconfig parsers to read file without error.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 drivers/staging/vc04_services/bcm2835-audio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v3: fix typo and note about parsing errors.
  -> https://lore.kernel.org/lkml/CAE8KmOzcD+__7xdC7tegbHO9HEP48s7=reA4j-tvqVDwzHr+8Q@mail.gmail.com/T/#t

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


