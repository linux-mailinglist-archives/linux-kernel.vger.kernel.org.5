Return-Path: <linux-kernel+bounces-142003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 674DC8A25FE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF5EEB22C57
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58893224E8;
	Fri, 12 Apr 2024 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMKwx+4F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A9E1F619
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712901159; cv=none; b=A31AzT7HsRjpCKtmzQS/oDt/rqkmrN6j7t6o6OvnuJSyeUaakr5lPlGCd61JMxNKTwQiqVZfDE67VjdQkp+zqSm0wNpgDBPYnMY47LJqHQVUDVrqVxSzHKUjvDkFjzfmpASSKf5gsT25NOgC8K8exxXV+mQQJl2CEuEYR+UFL68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712901159; c=relaxed/simple;
	bh=H9QkVgIaTXuRRxzxwtJd4JwaXeL1DnlT6JVDAalK1JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdXW5qP5TZ0oZK7c7uswuvjh9YwpGO4Frcixus76/UUuAOOIXVuSPQ8G1z8n6agYIVjfMm/gHK+q90QpCh5uv89a8IOtYK8Nt9P/CkK/vBjxvXlolNwfSccdsVsKzBPBG6WHDTw3XNlrPN8MkLhyfULPII0u9qywDqzjbTQlUEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMKwx+4F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712901157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CwC6OQPgF4b+I6G3StI86HjGTViKeERT7qsmBlfmiBg=;
	b=NMKwx+4FKKU/eNc//44nIQqJkQPpGF9cH5oFR8b5Yr6liz0SjX1dYwIGtNH9/ZjJ9SOntu
	7vYLGcK0PwCD8Sp7f2rJ79/faDi9Rj727aoX1y2aRpzHcwX6LiiMzdGacOdqaMAd9VgcoC
	dtAjkBl1B2JnOrdMGrvyrg3r+zkyKrQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-g9AtMGLrM4ipx-CG-opLAw-1; Fri, 12 Apr 2024 01:52:31 -0400
X-MC-Unique: g9AtMGLrM4ipx-CG-opLAw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CA7D881E66;
	Fri, 12 Apr 2024 05:52:31 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.234])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B610240C6CC1;
	Fri, 12 Apr 2024 05:52:28 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v3 1/2] misc: sgi_gru: indent SGI_GRU option help text
Date: Fri, 12 Apr 2024 11:22:20 +0530
Message-ID: <20240412055221.69411-2-ppandit@redhat.com>
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

Fix indentation of SGI_GRU option's help text by adding
leading spaces. Generally help text is indented by two
more spaces beyond the leading tab <\t> character.
It helps Kconfig parsers to read file without error.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 drivers/misc/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

v3:
  - split patch in two, remove 'default n' attribute
v2:
  - CC public mailing list
  - https://lore.kernel.org/linux-kernel/292030286.5066638.1712899322325@mail.yahoo.com/T/#t
v1:
  - s/\t/ / at line #431
  - Private mail to maintainers in MAINTAINERS
v0:
  - private mail to maintainers in MAINTAINERS

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 4fb291f0bf7c..04df5a0ee931 100644
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
-- 
2.44.0


