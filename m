Return-Path: <linux-kernel+bounces-111311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 985F7886A84
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D13B24C14
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21B13B2A4;
	Fri, 22 Mar 2024 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="bZegdW74"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CDE3612D;
	Fri, 22 Mar 2024 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103952; cv=none; b=mruf3NYNAwF6vQFfX0WbaQLtdI34NCoq8AzHx2KIL8x1/rZmnSG2dmHOKIUjDlztRX7cyeezs8J99VO9GCoLVy04A3kUy+CbuqIokezoGahHulu7eT4OToz0zE6E49j7zdoovOhzfip779lEw4IjA+PoQ2SpR7JZrggoHaA58sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103952; c=relaxed/simple;
	bh=pfiFWjLLasORuG7PCCaiQCBLxkCMS5xzTZ5YItPcLEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nudawYTMT5C8DzPIOlmOlQrVwiQTNs5h2lPMpcWEC5CtzJBBLNK/D+aPiZ4LncaC05IXALA1Ed681caWurYRM8zBdN97WIzlFT7dCVcpro+v/dSWPV3p4Ccq7hUJWKK3W7gM0l8W1hTQtPwR/+rEt4RcFY05QdE4VSxuAZgfgwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=bZegdW74; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1711103945;
	bh=HD112TNTbRVZLtfZOIpkn/lmLRdJwknsbN5jUYRctuc=;
	h=From:To:Cc:Subject:Date:From;
	b=bZegdW74w4kqZoMKtDP4hBjq5tJshHahtsugx7Gmt7f01Ectl+xVc2NjcS6HCA23o
	 xmNtuEKHKQ8jSs3iMWHYZYPrHRrcH6JoEjr6WubYrAuv3kcJoQwpge3cICm0J4i7V/
	 SCUVFMs8X1RqPanFlomTSmGTfjQ8ASIYi5t/Hm37AN2S0jg/C2Gbx7p+KsaOGd01WN
	 YLCh7QzQwqalrxnEcoAC05SUoEsjcOpCy3k7cQhVNs/D5fX1uDezQqgL/1nhlk+AWn
	 oWVkW+DTWuW7PRPbbXqrUy6YHRmqXtxVPfj0H02GrEQg4lZIqdHRnKT94LCAdG7qcH
	 8J/UgHfigZ3FQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V1Jj45xZRz4wx5;
	Fri, 22 Mar 2024 21:39:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <corbet@lwn.net>,
	<anton@ozlabs.org>
Cc: workflows@vger.kernel.org,
	<linux-kernel@vger.kernel.org>,
	linux-doc@vger.kernel.org,
	<linuxppc-dev@lists.ozlabs.org>,
	<tglx@linutronix.de>,
	<gregkh@linuxfoundation.org>,
	<torvalds@linux-foundation.org>,
	<ajd@linux.ibm.com>,
	<npiggin@gmail.com>,
	<aneesh.kumar@linux.ibm.com>,
	<naveen.n.rao@linux.ibm.com>
Subject: [PATCH] Documentation: embargoed-hardware-issues.rst: Add myself for Power
Date: Fri, 22 Mar 2024 21:38:40 +1100
Message-ID: <20240322103840.668746-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unfortunately Anton has left IBM. Add myself as the contact for Power,
until someone else volunteers.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 Documentation/process/embargoed-hardware-issues.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index bb2100228cc7..6e9a4597bf2c 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -252,7 +252,7 @@ an involved disclosed party. The current ambassadors list:
   AMD		Tom Lendacky <thomas.lendacky@amd.com>
   Ampere	Darren Hart <darren@os.amperecomputing.com>
   ARM		Catalin Marinas <catalin.marinas@arm.com>
-  IBM Power	Anton Blanchard <anton@linux.ibm.com>
+  IBM Power	Michael Ellerman <ellerman@au.ibm.com>
   IBM Z		Christian Borntraeger <borntraeger@de.ibm.com>
   Intel		Tony Luck <tony.luck@intel.com>
   Qualcomm	Trilok Soni <quic_tsoni@quicinc.com>
-- 
2.44.0


