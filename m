Return-Path: <linux-kernel+bounces-162694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFE38B5F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9C71C21EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F6185628;
	Mon, 29 Apr 2024 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="lpAw96FC"
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990AE1DA23;
	Mon, 29 Apr 2024 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408622; cv=none; b=nUkbmstQNwSKZs93600Z0HEVm1H2Aa5TrsWv/npm+t67nuTlveSChtIelhCwNV5VetbyNdj3b8Xspjw0Ua/xB034A6xWtJ+L6+iPuSebdzlHoPqIUyyVTcdrfS4P4V1QqpEule4qs/2lgsFWwUZbcbXrShQix4uWI73Gvd90wmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408622; c=relaxed/simple;
	bh=GgbnJ2uyHhln7lnt6LGmn6tsCC7xILAAm0bvDzHW3Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PuOMDLS8CALiqbUiUysvMihB8vV9+alRHj41Eawy/MbhVDNw75qIAKw1Y9lYNAcgKyDkmLvOKIsC+KjYwh9hlDtHkyfWByITzFz/4vmMBx0xWsY5+Il5a9ju5/rhaha35hJKWFFt+NQIO6qpYRLjKNNYlcILINLWp6ntdZXLukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=lpAw96FC; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gWMCZexn4RteI9COZUts2t/BaJMozgbrr3bR8ZgmLfQ=; b=lpAw96FCpWs8KLgHuinZjVQwel
	FMOwKp/HirLlZeoYNDUWYwzBIRSsEOKJxuXXUBxISMLkPV/drXd0FQErvfVJeYHMDqYiEGvKXYieZ
	gfxA0tWQUnHX1M4SVWTnQUlPhZBnCMFrOl57I/Ul0uqoJpoLzJ7+dOv1xnPawiH76utFaxufFLpMi
	O2ViGlM7NBHodI8chHcaUHm6V4aBPk+8y96ivN02XBOxlk/KpN1FuV3iu19A2slDikPJZ1s++1F4+
	POghbukADBIkXTd6+209dOudHj5PZEXMEXO7OCJzF49OnKsgthG3mzzq6qR0vI1AO5uI69YGI5ETg
	f97tAsyg==;
Received: from [167.98.27.226] (helo=ct-lt-2504.office.codethink.co.uk)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1s1TNp-001jlJ-AS; Mon, 29 Apr 2024 16:57:37 +0100
From: Ivan Orlov <ivan.orlov@codethink.co.uk>
To: naveen.n.rao@linux.ibm.com,
	anil.s.keshavamurthy@intel.com,
	davem@davemloft.net,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	corbet@lwn.net
Cc: Ivan Orlov <ivan.orlov@codethink.co.uk>,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] docs, kprobes: Add riscv as supported architecture
Date: Mon, 29 Apr 2024 16:57:34 +0100
Message-Id: <20240429155735.68781-1-ivan.orlov@codethink.co.uk>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: ivan.orlov@codethink.co.uk

Support of kprobes and kretprobes for riscv was introduced 3 years ago
by the following change:

commit c22b0bcb1dd0 ("riscv: Add kprobes supported")

Add riscv to the list of supported architectures.

Signed-off-by: Ivan Orlov <ivan.orlov@codethink.co.uk>
---
 Documentation/trace/kprobes.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/trace/kprobes.rst b/Documentation/trace/kprobes.rst
index e1636e579c9c..5e606730cec6 100644
--- a/Documentation/trace/kprobes.rst
+++ b/Documentation/trace/kprobes.rst
@@ -322,6 +322,7 @@ architectures:
 - s390
 - parisc
 - loongarch
+- riscv
 
 Configuring Kprobes
 ===================
-- 
2.34.1


