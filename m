Return-Path: <linux-kernel+bounces-117611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 815E288AD34
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373FF1F624DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBEA7F7E5;
	Mon, 25 Mar 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lQsiruC+"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4251E534;
	Mon, 25 Mar 2024 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388356; cv=none; b=GrvfWuhsK382Bnuyzb+qU6GMMDs4vqPQ6b1Lj+ahr4TRYMNCfk5v4Tx3CHEjQVWx87KodXGwlilKzJlVJXBxDb7LuuKYN6/gClLWfOfgYFzFXnqdLd8/2Kz5j/TawQ8fmj6P4RCGHVKm1omDqf3AxcAOoEAzzoMxGxlKmYf+KO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388356; c=relaxed/simple;
	bh=QPEBF84eE88+YdJFYseicHFa0CBVX+qcQXwPqlTEfGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OfxdyXgiPF5ZdG+QeC19uD+tsExEo5d+FoIbEZQmeg0lBLRP9++OZjpCHIRRcu6RCTsH5iL/r3mC5rdLXCRy/nY0yuTjw7F67Ncc4wmg0LoTmgwmI+2k9hcoDFQMi6Rlb1pYhKzNknioHPP5MRyp4qW+CKJTZicksM16U4wxeXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lQsiruC+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=63cbUxYgirJ/YEr84TXKagJ5rL0dwPUYDKl8NOveKNg=; t=1711388355; x=1712597955; 
	b=lQsiruC+mSHcuQqvWrBnJUmlWirkAGeOnoYRWmRE5sH0ATeRYTUJYRTOF1jJfsU3cdCf76XFhsY
	yt/UzPRaZlEUhDOzkM21UjOwJ1Oy5OAX5ukrfK5vMUtnHN+HHXR79B9opsuEs1N6wwe7XMqryOJsz
	hJkJPBB2gQhxS9Uh5GMsuBxfFyJSlqug2XEEh2+5e+mx/10KGOxZjYgi4bgpmrxNdua23fqFeNtTC
	SBiPejYCd24NYQQENsFs6qTOnYUhVmw3fT0oaUZW6gtiy187AwVq1yEOgyLU5ovmTg31peEMJZZcd
	o3eZj4wjW78yn6tm+6kvslDq1T7ZX1iYe59g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rooHu-0000000DzY9-2PtP;
	Mon, 25 Mar 2024 18:39:10 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] rcu: mollify sparse with RCU guard
Date: Mon, 25 Mar 2024 18:39:08 +0100
Message-ID: <20240325183907.7205bf36489a.Ic3ac66ff5d6a9bd8a610858060117e1364641a3f@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When using "guard(rcu)();" sparse will complain, because even
though it now understands the cleanup attribute, it doesn't
evaluate the calls from it at function exit, and thus doesn't
count the context correctly.

Given that there's a conditional in the resulting code:

  static inline void class_rcu_destructor(class_rcu_t *_T)
  {
      if (_T->lock) {
          rcu_read_unlock();
      }
  }

it seems that even trying to teach sparse to evalulate the
cleanup attribute function it'd still be difficult to really
make it understand the full context here.

Suppress the sparse warning by just releasing the context in
the acquisition part of the function, after all we know it's
safe with the guard, that's the whole point of it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: add a comment after discussion with Boqun

---
 include/linux/rcupdate.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 0746b1b0b663..6a3c52b3c180 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1059,6 +1059,18 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
 extern int rcu_expedited;
 extern int rcu_normal;
 
-DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
+DEFINE_LOCK_GUARD_0(rcu,
+		    do {
+			rcu_read_lock();
+			/*
+			 * sparse doesn't call the cleanup function,
+			 * so just release immediately and don't track
+			 * the context. We don't need to anyway, since
+			 * the whole point of the guard is to not need
+			 * the explicit unlock.
+			 */
+			__release(RCU);
+		    } while(0),
+		    rcu_read_unlock())
 
 #endif /* __LINUX_RCUPDATE_H */
-- 
2.44.0


