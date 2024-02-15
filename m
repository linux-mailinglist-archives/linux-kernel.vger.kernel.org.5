Return-Path: <linux-kernel+bounces-66767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7DB85614A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2805A283DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA72D12B14C;
	Thu, 15 Feb 2024 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BafsBNQk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6E412AAE9;
	Thu, 15 Feb 2024 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995752; cv=none; b=UPtncIOgAfNUE4oac6Oe2+gMfvMC3JTdvkQxMv5t7x994qFpWAlETyM1KxGOg8SRgbWOq+bEP4FFh8PuruJaROBQs3bxp/MYFIhHN2gNCvQC3wVRDnLEt2vT4W8DrvffOeIRNkGpW+7ul4tU/MzZ4o7olK/eYG5wfSU1OCRyIao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995752; c=relaxed/simple;
	bh=9YZKXhWNfbF7aYFsNIbeRXnqZp6wq06HKB3/uvm1xT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hv8GYkmo+6Wrsosch9xH6U5d0Vy+JOK+CwOzXjCa9We2PwWazaWGuVP3QGev5Qnlw897P7/L0yZe3VTY7J7BwvIyXjZE2QzbQAxtrpqtqRZFatwqdyZx1HxDwQsRve9LYCaasCj3MVKvoqXV2EhmjwPpw0MV/1DnFhLoBsIal70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BafsBNQk; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707995750; x=1739531750;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9YZKXhWNfbF7aYFsNIbeRXnqZp6wq06HKB3/uvm1xT4=;
  b=BafsBNQkVEI5YxQE29N3vKSwPYVJxgz99TcU3/x/EdoVomtFtr2hiOD3
   L/YE0+5KlWGpVkz7Q/IZaLmomefNKZ41c6b/PBilZlxtx/QNJ9TnPGrvy
   RDEx7Yxx2blnseQO2ChX91OKXSCe7qUsNmLcsLa4A973cmfa776XHMGbt
   DnnoXKDh4wH9rcPzpBPucJ4AdCeajjJcanP3pk1a0Si/2eLtx7Y1AzTm4
   mQBWJOgHENCpLu5L0EtsjUzDV37Cm7ON/elaTB+0Kjjc59S1llys6eiJL
   rFsx6JreAexbnK87Ucd0bLAnM+xEKTxfjWqMpuU4iqBAmQCOR+uUyHln1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2191468"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="2191468"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 03:15:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3572590"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.150])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 03:15:46 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/1] tty: Don't include tty_buffer.h in tty.h
Date: Thu, 15 Feb 2024 13:15:38 +0200
Message-Id: <20240215111538.1920-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There's no need to include linux/tty_buffer.h in linux/tty.h.
Move the include into tty_buffer.c that is actually using it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v2:
- Fixed shortlog to make sense

 drivers/tty/tty_buffer.c | 1 +
 include/linux/tty.h      | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index f8883afbeeba..79f0ff94ce00 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -7,6 +7,7 @@
 #include <linux/errno.h>
 #include <linux/minmax.h>
 #include <linux/tty.h>
+#include <linux/tty_buffer.h>
 #include <linux/tty_driver.h>
 #include <linux/tty_flip.h>
 #include <linux/timer.h>
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 8c76fd97d4ad..2b2e6f0a54d6 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -6,7 +6,6 @@
 #include <linux/major.h>
 #include <linux/termios.h>
 #include <linux/workqueue.h>
-#include <linux/tty_buffer.h>
 #include <linux/tty_driver.h>
 #include <linux/tty_ldisc.h>
 #include <linux/tty_port.h>
-- 
2.39.2


