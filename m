Return-Path: <linux-kernel+bounces-155186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A9E8AE673
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB817B21ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53185127E12;
	Tue, 23 Apr 2024 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="wAMpHfTi"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC1985636
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876045; cv=none; b=HsHJKChp3LRI5PCW5o5GR1mEM0iElniEnDDe1FArSSIKSJsb/XeXLJFLP7RWwUoZ2tZq20e8fi5WpaqOHXJe0nODB9Wgc16Af6vj7kahOpWfZMC5jn0CIFqPx+/1i7asSrTKj06HG1y9d8LsgxITCa/UrYWxRcatoGOlktucDLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876045; c=relaxed/simple;
	bh=dcFudAJRx+f5pYaL/Lsq9uyJRb9BSt+U6iB8hAy3sFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Javc5iK7iIM9Js251C9YfdNd/WvDbZaqcwMItYOEhIfjxUivrgRPNTplSvi5ZW6bThC6J+ZRMwsjzOHDECjGo70/iAAsoJO0GlHtPfzTaW+ddSVC1KDzO1bvyNB2MIPFjJQwq4bQXl4LarFKcg1+KmomzwCgms8Jst88/iLjXXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=wAMpHfTi; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713876031; x=1714480831; i=spasswolf@web.de;
	bh=uk5lBQjqGg+l8o6LIfCPDB41CLO4iYZN9q8xF3nEm9I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wAMpHfTiULSoXvv7vV2uW1ouDuWz0s39beSWmqAtYr7+P3WZ+rn9yf1oRfoEOC3N
	 wW68HKTUKcpzNiG379k3MeP5zmyo5Z1dPPXUeB7UBDPAxMZaqc7PO1uD4oD4v5h1A
	 IqjBNKG5ZgYVR8ybOoJBq/Ax1l78bhFWkgZbl/gflvR55cEC1/2WTEZojNY8UD5r0
	 pCeCvJqVtmFhXeRIiPjEupJaf2sF9bDqsSshfJHx1ObGanIGPmqKIcEPj0i8QcxUW
	 PaukPtyPfoo/sn17LVRsWJStifqFRZwuXvvuIK9xs3mtyPlhuJ0WHGdb0z3oVapC0
	 jNURTAEC/2oQbrDcjg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1Mft7j-1sedvy0pmj-00fye8; Tue, 23 Apr 2024 14:40:31 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: slub: Fix compilation without CONFIG_SLUB_DEBUG
Date: Tue, 23 Apr 2024 14:40:21 +0200
Message-ID: <20240423124025.193812-1-spasswolf@web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aJtgG5XjvnpVUDQqYIGZOmf3x0G/ZXd8flVpOPOhapU5tIT8nzg
 ndodTqOE2SHqbltLcH/W3/bzIplcQuLa2jwQrG2TAK0xJ3zHhRVxMjRI3Y9TGAD3BR7MHxv
 ymm/IQ2TvVWcuh80E58EiPgkHTc+r1c1FYGtE5mmY9tutP/6gXH3ukP04NtVnvq4m2HxV7o
 jTlD39KmJJwp5MPoJnQeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q34wlOvMt0c=;BVUMuW6vvd6A1LiVuJo8p522QlI
 Ekbm7NOD9glCWSVlJU9F/QPqP4VfJ52JOYcm2PsUYCdlHudW10uBnYBmbseeIioevdLjIay6C
 ilMmUPyWKd4/8dcW9ptWjMRbTPLyIPW44JifH6MIcQNUCcQAmGznUx0zrXnzcjc88lnYlt1XG
 WkfnoJcK1gUvmSshYUFIpNBCmJel+cD1UDecpDdvzYRYWRFQCP0OTJWivzglao4PJoZxqZPK6
 NGXOwrbyu9DvArHHFBq2GRejPYceHPMsnyoIp+iCD8cPk9LCCCRWf6gI1u9hAKFDBtniwX0Pw
 wb+yByLt+bPi8+Yk6V1TrBEgjtCbonlBOeP+Pm/CWZDCuekP0Gty8E7hf9wfTmxpv3i6eoWPj
 MSqAuInshruxIF80x9ydKqEsdpbQtPRQDnkygOdptKKTOiwkgQfdXyjwGBFyD87A6/a7B/7yp
 25FaOK0VcG8Wc+kifuelcazDqJoihgDDyTA3IKKmc/rmkgx04iHIt2Vd1JDb2u3G74DNxjIvl
 ydyvKW/mQQJxpf2BDE0CLpgm7Km/DP1Y+ba5P/Yz1jMS2UcJQAQDlPVqIe/B7G4sGTkefghBR
 lTpoFce7+JvnPgkWclhJCwVKdkHW9mnjn0+tkBWuLldHmgg9pjL/4BAQ+YjzaSPQnjXZ7lUV5
 UmdwVE8UNX8qACwFrDkWC64uh9W1+5kCCBazqlZJCd/Bzik/L5iJxJNorMHCbCE+B2upFaVal
 wNgfHVDHZ2ZQ8Pw1ikgzqnylbozQzz4IjcO5+mtdP+t/gkYN8h+jLCPVqCAtJTROiWnt7et1l
 qjYI9FkoiwCDh7N9ujzbVCarUFljvPtV9PWiBvsEQ+EiI=

Since the introduction of count_partial_free_approx the compilation of
linux fails with an implicit declaration of function =E2=80=98node_nr_objs=
=E2=80=99
because count_partial_free_approx is compiled when SLAB_SUPPORTS_SYSFS
is defined even without CONFIG_SLUB_DEBUG. As count_partial_free_approx
is only used when CONFIG_SLUB_DEBUG is defined it should only be
compiled in that case.

Fixes: commit 1c5610f451be ("slub: introduce count_partial_free_approx()")
Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 mm/slub.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a3b6f05be2b9..a547ed041bc7 100644
=2D-- a/mm/slub.c
+++ b/mm/slub.c
@@ -3226,6 +3226,7 @@ static inline int node_match(struct slab *slab, int =
node)
 }

 #ifdef CONFIG_SLUB_DEBUG
+#define MAX_PARTIAL_TO_SCAN 10000
 static int count_free(struct slab *slab)
 {
 	return slab->objects - slab->inuse;
@@ -3293,10 +3294,6 @@ static inline bool free_debug_processing(struct kme=
m_cache *s,

 	return checks_ok;
 }
-#endif /* CONFIG_SLUB_DEBUG */
-
-#if defined(CONFIG_SLUB_DEBUG) || defined(SLAB_SUPPORTS_SYSFS)
-#define MAX_PARTIAL_TO_SCAN 10000

 static unsigned long count_partial_free_approx(struct kmem_cache_node *n)
 {
@@ -3332,7 +3329,9 @@ static unsigned long count_partial_free_approx(struc=
t kmem_cache_node *n)
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	return x;
 }
+#endif /* CONFIG_SLUB_DEBUG */

+#if defined(CONFIG_SLUB_DEBUG) || defined(SLAB_SUPPORTS_SYSFS)
 static unsigned long count_partial(struct kmem_cache_node *n,
 					int (*get_count)(struct slab *))
 {
=2D-
2.43.0


