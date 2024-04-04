Return-Path: <linux-kernel+bounces-130891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35636897F07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6331C1C271C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1FC38DFB;
	Thu,  4 Apr 2024 05:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="RXf66Y2m"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC58C1CFA0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 05:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712206976; cv=none; b=e7sQexEgn5Dvq/rOEeeHeAE1F/7VQOBxThpKAJIp/CKVFa44QLrYV3kwa4m7G53xriBVHa1EgGTB5VKDIG86qSCnni8jwRfCPnMsthY45mghjK/oxky7ww62LFm725nDAa+WCVXLO8L+PG4o0x22NS454WXTqlY5deJ1JQYbkEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712206976; c=relaxed/simple;
	bh=gLk9WBGQMhRzD+UZauXPhtHxi5DGfP2yF2TpdHZr8rA=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=OkmmL9hv0lcFoQgqLYCzzf+cXDphqsndq6O6ZF95kyYaPqwxza68THY6eB1szFFIXscN1Lb4xTToYS+8ZIlms7Kjb9DGcnTe8wA1ImhPpROEK2XOJX4Rry4mOiNLib0ZvhWYIeNYxsnsQsNckJEYJSPbQyGtApakPp7zSz1y3EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=RXf66Y2m; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712206962; x=1712811762; i=efault@gmx.de;
	bh=oOX9SnEbIf0w1VMcYYoATarHCLHil4Iy3g8GvrnyEU0=;
	h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
	b=RXf66Y2mijs9iU4birVk42GZ42Ia0B9xZATLp5AB64zC5Xg/8HLyzE1xGOE943Wv
	 QcIE8Yzv90+daumoTTW7MrBOvskX6JHynIg9rvfXivL4QGgKszl72ySBrx5yBxThH
	 hLD3nE86SVWar+UI7ZEwzXihKHqSeRkoVVLSYGae3OlDp91Ar+xuOEV3AC3NeyvVm
	 mtF0IvoUO72XlEmyZslpABUrIVPMJAbIJ1f9oZrkSnh8xVroDF0xjiXo+AdFF55cW
	 xOJjOaP0YZZKLD9aKlpUNng+/C4gGgXXOSgNpK+YTHJAOHJ+Rxiq//jszu2EgJ6al
	 Bc1HxiGmNLew8davdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.51.26]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9MpY-1svI7K1y4K-015Gdn; Thu, 04
 Apr 2024 07:02:42 +0200
Message-ID: <68731eaeb522ced5319e3c1e45f03cdca5c8fd2a.camel@gmx.de>
Subject: [patchlet] locking: fix trivial f70405afc99b RT build breakage
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Date: Thu, 04 Apr 2024 07:02:41 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JEfvvZhfDa2gMmACDjQO9HxqN+hxtxjoXBbeth6A3iFnXOtcsnT
 8Nhiyq6XUVY9dXUgokOSXRhmrYprRQGKDddLiOKfjUGR5MdLV46P7rtZzMf1Lmg7LOZL9um
 Cc73YOb1K3zJj/RsVP3/Uqit1y/HI53BKW1AGr1GhXcx4IIisVp8mi1MtbLxRwk9Yi5IsBm
 ijqGhvYgGHb46ZdmOn8SA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cTGXMd7LcL8=;YawPW2zyMUOBBsQHdnBrAk7j+B6
 TDtuZwU+Zw7cRiZc7q5RqShEnfJHbeU/2d6g+ohf/dAQ0/klnHkds5Q6v2S0uPY0VkmX2H4+t
 nLfvq179QJV37O/Lc6YkB5CsUBGwFBEp9hriYoc/5TTXF/rjhK+g+az8wUacx1y5EyoXKwe0b
 zXpkAuHFV9uiJUFKXF+ugoOXqy1ds1ZO2fWTXg3KdRZyMlrOOUx6c1mZTlQPAjbF7GTcXmL+N
 5PZCm79Dx/WiU5dOPC9WZ3xubul2z/MphL5CjZNdQjtKkWR3JhEXNUBsAOgOnQn7ZKkxFAVP8
 PrmB0PjolgJ/37oCa4YqF8hGEDO9vnSB+s0mqUnXB6MPazlsBne3CHdxehEvv9FX16vQQB9w2
 YgqMobLwkxZXfL+dXpDWOHoAWRTd0KWdrmazLiTzSrgdZb8bXkdkQv6tpQ+ORcCd0+21CPPbe
 LsuaYDxF01FLFfUfi1pEfEi6233jbQ3UdyFwqih+JEzPZ1iAmeryUNBMehyKlqzc+/N5UfOtt
 gweT7hgVRv+vT9ROsoW62q4t9nSXei9iEdpdeEyCwNtK/O4hQfZmyMxKrJ/BDA/19QP0tLqE/
 eaVrG6BzDtLJRI1Psy7Y8mK5T9S8aRqcQIVWiy3YgkHNwCjVtYauXeIFwh71Z7eEuyV9oKZFq
 wIFXABFpNL+MMeTiakRcCgPzdKeLXDhg9hF0D4vN7cohHQSUm2eLHiYtwENOWxBDB0ASfDM+A
 eAk7gkEgHdA3kHC0K5ZG1Y0g0jGtn6BpM78fZN7Ve/bTcuz+du2rXx9YW5oqknz5MplYuRDJJ
 A5rqBBJCNkO1uKmzKL5D+rA5Ivb+625T/WtafvSlXEbOs=


Two trivial RT build issues arrived along with f70405afc99b: WARN_ON() bei=
ng
undefined as added to include/linux/rwbase_rt.h, and the wrong parameter (=
typo)
being passed to rw_base_assert_held_write().

Fixes: f70405afc99b ("locking: Add rwsem_assert_held() and rwsem_assert_he=
ld_write()")
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 include/linux/rwbase_rt.h |    1 +
 include/linux/rwsem.h     |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

=2D-- a/include/linux/rwbase_rt.h
+++ b/include/linux/rwbase_rt.h
@@ -4,6 +4,7 @@

 #include <linux/rtmutex.h>
 #include <linux/atomic.h>
+#include <linux/bug.h>

 #define READER_BIAS		(1U << 31)
 #define WRITER_BIAS		(1U << 30)
=2D-- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -174,7 +174,7 @@ static inline void rwsem_assert_held_nol

 static inline void rwsem_assert_held_write_nolockdep(const struct rw_sema=
phore *sem)
 {
-	rw_base_assert_held_write(sem);
+	rw_base_assert_held_write(&sem->rwbase);
 }

 static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)


