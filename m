Return-Path: <linux-kernel+bounces-142004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8028C8A25FF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9C2283F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D572C184;
	Fri, 12 Apr 2024 05:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVFcsNzy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E842200D4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712901160; cv=none; b=B+b+Mg60+9WZAJ4P3XNwCGX/BrKSi2NBEPHxdmsh1hsO4xVf6DMduDbah/wqAfHCNhDZuGpPiYXxvRSb1QcTKSVIK3c4PumI/5PMhGmV+6e6oAF7pGNJfuSPmP4mpsRyRv+JmFNeH9I0u8O3NcN3HkNGQgKoev6s52BDshjH/cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712901160; c=relaxed/simple;
	bh=fQZ3CTzWDtKAJOtK6INITCIqA0+tZ1SzE0hBMmgq6Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4RniaACC9F/8iHlBh3Jd/hZQB0EVlJBckL9ph3tgb9RIwa4L9UXooUWTRhVOG3K7S2LxtBA+TgTLjZGBLX30VXbKtuSI33BX3jPTTFvO/ns3i1rYyvkomEIao0p8AGSgNL7ZXEjIBdGoqeJOHJrViffQb+cElIb0GD6K1ZfDsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVFcsNzy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712901158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCAyfsgEOD6+h0HvaJXuRu+FSXi8VmWM3ai0nhH01c4=;
	b=BVFcsNzyompzwa1QxE8LHsmThfIO656CTq79dTJH4uCrBiqdOqtUsRy8BIzYcWlypz1bR5
	Pn03H8tMLo6LJs4ITEhi95AuwmauwNq62pRn/jZJU4nE8dL+6SwESROyQB9umsUkQqONvw
	bX85Jj6UkjcY39+AB9J1ozFDFc4OupA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-BB6yarW6MNGEh2MPd4Mrhw-1; Fri, 12 Apr 2024 01:52:34 -0400
X-MC-Unique: BB6yarW6MNGEh2MPd4Mrhw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41F61830E78;
	Fri, 12 Apr 2024 05:52:34 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.234])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C759C40C6CC1;
	Fri, 12 Apr 2024 05:52:31 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v3 2/2] misc: sgi_gru: remove default attribute of LATTICE_ECP3_CONFIG
Date: Fri, 12 Apr 2024 11:22:21 +0530
Message-ID: <20240412055221.69411-3-ppandit@redhat.com>
In-Reply-To: <20240412055221.69411-1-ppandit@redhat.com>
References: <20240412055221.69411-1-ppandit@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

From: Prasad Pandit <pjp@fedoraproject.org>

Remove 'default n' attribute of 'LATTICE_ECP3_CONFIG' option
because it is redundant. 'n' is automatic default value when
one is not specified.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 drivers/misc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

v3:
  - remove 'default n' attribute
  - https://lore.kernel.org/linux-kernel/292030286.5066638.1712899322325@mail.yahoo.com/T/#t

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 04df5a0ee931..b8f8461edfed 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -428,7 +428,6 @@ config LATTICE_ECP3_CONFIG
 	tristate "Lattice ECP3 FPGA bitstream configuration via SPI"
 	depends on SPI && SYSFS
 	select FW_LOADER
-	default	n
 	help
 	  This option enables support for bitstream configuration (programming
 	  or loading) of the Lattice ECP3 FPGA family via SPI.
-- 
2.44.0


