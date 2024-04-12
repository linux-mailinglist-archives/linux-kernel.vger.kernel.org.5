Return-Path: <linux-kernel+bounces-141947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A73F98A256B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CA72849FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28872171A7;
	Fri, 12 Apr 2024 05:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUsXzDne"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEF0C13C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712898316; cv=none; b=YmAgUSYfGLZvf/+0jiaituPA51egOH0FwPQGq6STisIg+9W8TvxgcA8RqEu83iwrzulXYacrq0AIHZcZpXQJkhqcmuQ+E5JJW6zTxdZN3KT0tC+rle1WziqlDEIwHrzXj/L+Q2dW3Ssqys7uU/mkzhz9B3yvP/Erb4NTWBXiu9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712898316; c=relaxed/simple;
	bh=hHye4bTUTBgmU8tBonLurTw3SGHuJD6j8I3NctLFwfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nUdHAa9gZNkM6oaGUxac9cNKW7WIwqNst+d8DzlCFKfQp/sl3dbZkbz3FeuHvx1Cfk1Fz0m5UmMFIzPu/vANMe8pIhDkugc6VSOb6BXk4wrDk7S76kHwFtSfqBFWQVvuYCmP/uPll+bWU8pfqoEg2Yv0KhCw3GD7hPwLDHNPPJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUsXzDne; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712898313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mr72RAo7gJ8rDJAU0j1amZPX+o33LavMHds6jau7jYY=;
	b=hUsXzDney3R3KVb8vgNvLUq1vNeHRBSyR/7JXDwTxUOoiLOG8zQdJmXKabk4c+yRoM9KrB
	U3f2cFD4TcUzxPofkQYUWoITs/Z+JHFRakx9chggNIOXGa3FSaWJhcarJ+ncaCmiCJPzbY
	9KBlsumzjq5xJZZ+Xy2eqjcC0rFKPDk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-CdNCkq_4Pke-gIsAOkZg1g-1; Fri, 12 Apr 2024 01:05:09 -0400
X-MC-Unique: CdNCkq_4Pke-gIsAOkZg1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8B488007AD;
	Fri, 12 Apr 2024 05:05:08 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.234])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A7DF210E47;
	Fri, 12 Apr 2024 05:05:06 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v1] misc: sgi_gru: indent SGI_GRU option help text
Date: Fri, 12 Apr 2024 10:35:02 +0530
Message-ID: <20240412050502.65326-1-ppandit@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

From: Prasad Pandit <pjp@fedoraproject.org>

Fix indentation of SGI_GRU option's help text by adding
leading spaces. Generally help text is indented by couple
of spaces more beyond the leading tab <\t> character.
It helps Kconfig parsers to read file without error.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 drivers/misc/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

v1:
  - s/\t/ / at line #431
  - CC public mailing list

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 4fb291f0bf7c..a6565c42a7b9 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -293,21 +293,21 @@ config SGI_GRU
 	depends on X86_UV && SMP
 	select MMU_NOTIFIER
 	help
-	The GRU is a hardware resource located in the system chipset. The GRU
-	contains memory that can be mmapped into the user address space. This memory is
-	used to communicate with the GRU to perform functions such as load/store,
-	scatter/gather, bcopy, AMOs, etc.  The GRU is directly accessed by user
-	instructions using user virtual addresses. GRU instructions (ex., bcopy) use
-	user virtual addresses for operands.
+	  The GRU is a hardware resource located in the system chipset. The GRU
+	  contains memory that can be mmapped into the user address space.
+	  This memory is used to communicate with the GRU to perform functions
+	  such as load/store, scatter/gather, bcopy, AMOs, etc.  The GRU is
+	  directly accessed by user instructions using user virtual addresses.
+	  GRU instructions (ex., bcopy) use user virtual addresses for operands.
 
-	If you are not running on a SGI UV system, say N.
+	  If you are not running on a SGI UV system, say N.
 
 config SGI_GRU_DEBUG
 	bool  "SGI GRU driver debug"
 	depends on SGI_GRU
 	help
-	This option enables additional debugging code for the SGI GRU driver.
-	If you are unsure, say N.
+	  This option enables additional debugging code for the SGI GRU driver.
+	  If you are unsure, say N.
 
 config APDS9802ALS
 	tristate "Medfield Avago APDS9802 ALS Sensor module"
@@ -428,7 +428,7 @@ config LATTICE_ECP3_CONFIG
 	tristate "Lattice ECP3 FPGA bitstream configuration via SPI"
 	depends on SPI && SYSFS
 	select FW_LOADER
-	default	n
+	default n
 	help
 	  This option enables support for bitstream configuration (programming
 	  or loading) of the Lattice ECP3 FPGA family via SPI.
-- 
2.44.0


