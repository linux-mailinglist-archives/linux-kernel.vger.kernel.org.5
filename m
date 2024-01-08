Return-Path: <linux-kernel+bounces-19830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE69E8274D7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3089F283FFB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A9652F6A;
	Mon,  8 Jan 2024 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="HzQVztjN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E5B5380D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id DBCD8240029
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 17:16:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1704730590; bh=VhNI/VyHttpB6Dc+nOmQ0eI7dT/saNfHep5H24iJdO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=HzQVztjNExNwWDrBuHzEvHtkFFb6vD0OXysV/RE2YSQAQeRZRM4R2KPi1eqBI1IE0
	 BSv2xCrBjDcgcfMHIjpUhv7F7AXvuX8XRuiUkCupg5ER15Ex18/IoSvHTPiCypErA9
	 870DCFFhsdxf6Ku/I5Bdn4tyn4/jWmgW0j+pNBTZ19BpBQFy9thMKIBdX+Xy1LGjKn
	 ktiSoGhu0cJbFOuiyqcWbCl5Iv5BRsQl12Bl6+IAmoxmpSpOAEKunG3bM33lUuyF6b
	 w7VL9S2/9IFb4670o/kT67shDy+0J9nn2ZRyR2cEJqPySYA83y8pVs3zf3EgzSV+PD
	 zV6Uyu0OElw7A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4T7zhV4n4Wz9rxN;
	Mon,  8 Jan 2024 17:16:26 +0100 (CET)
From: Yueh-Shun Li <shamrocklee@posteo.net>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Yueh-Shun Li <shamrocklee@posteo.net>,
	Hu Haowen <src.res.211@gmail.com>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Randy Dunlap <rdunlap@infradead.org>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] coding-style: show how reusing macros prevents naming collisions
Date: Mon,  8 Jan 2024 16:03:23 +0000
Message-ID: <20240108160746.177421-3-shamrocklee@posteo.net>
In-Reply-To: <20240108160746.177421-1-shamrocklee@posteo.net>
References: <107b6b5e-ca14-4b2b-ba2e-38ecd74c0ad3@infradead.org>
 <20240108160746.177421-1-shamrocklee@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In section "18) Don't re-invent the kernel macros" in "Linux kernel
coding style":

Show how reusing macros from shared headers prevents naming collisions
using "stringify", the one of the most widely reinvented macro, as an
example.

This patch aims to provide a stronger reason to reuse shared macros,
by showing the risk of improvised macro variants.

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 Documentation/process/coding-style.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 2504cb00a961..1e79aba4b346 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -1070,6 +1070,28 @@ Similarly, if you need to calculate the size of some structure member, use
 There are also ``min()`` and ``max()`` macros in ``include/linux/minmax.h``
 that do strict type checking if you need them.
 
+Using existing macros provided by the shared headers also prevents naming
+collisions. For example, if one developer define in ``foo.h``
+
+.. code-block:: c
+
+	#define __stringify(x) __stringify_1(x)
+	#define __stringify_1(x) #x
+
+and another define in ``bar.h``
+
+.. code-block:: c
+
+	#define stringify(x) __stringify(x)
+	#define __stringify(x) #x
+
+When both headers are ``#include``-d into the same file, the facilities provided
+by ``foo.h`` might be broken by ``bar.h``.
+
+If both ``foo.h`` and ``bar.h``  use the macro ``__stringify()`` provided by
+``include/linux/stringify.h``, they wouldn't have stepped onto each other's
+toes.
+
 Feel free to search across and peruse the header files to see what else is
 already defined that you shouldn't reproduce in your code.
 
-- 
2.42.0


