Return-Path: <linux-kernel+bounces-116809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4045488A426
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFDDA2E3846
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE9218AFDC;
	Mon, 25 Mar 2024 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PUbUHezR"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9816E1ACB77;
	Mon, 25 Mar 2024 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361799; cv=none; b=AudN3ylA29xw8wU/3vDk+sO25Yk/wHbts3AlMLk+vDyKON76vdUaEUinL3glMuyFZBB7x/TF949MKj3G1jtw0a1jOLX5/F02DRwHx04kWSFHFz/djbgwIyXnQxAparMzcianBqGZ+M1tKPqTAlcxXwhFX3RkyNAYr8JSzq+/ewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361799; c=relaxed/simple;
	bh=0RpxAlfsTTpZ18SLcYlG63CQKxOj+cDiBmE5wqvl2Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OAnZDhIRUD0C4RIgyMurRAwR2ULjGNKSKSljRlkYd58Boz65IRFCN5619kVbvDi4a4nFUMzS/oy8nIL4eQLS1CD56LK9dpMGuFDzAF8p8K0OFiRjq3He37UBp0iWdYg9KjYAWhjOH+pwocEtKELaT/ybRsi89MF3XvZFbfAj8f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PUbUHezR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=kU5G/SYQB29JQ7t1aVhtssF0LtE6ImGeMC6/pp/A0i8=; t=1711361797; x=1712571397; 
	b=PUbUHezRnTsuWBNbzxiG7yc16rceBgxCg2Mg5iOvWOJpzh6HZBwgT0xSxUnRw4cpfURBgTjHLwo
	IWvbC7x/Zt0hhSHLsDN91B/qwNIp7yBqrGI2txUM0KfcftSo/Ia0187/kHlJXmakXO+nis+d0i1qS
	TO26ZjfB9Kq0gh/ruk1GgfEcZ+MiJIt6kBynGsyFCz/277VPklo1Fs/OqSdIRdGohMNe0Xl3PAT7i
	wfItBwdEbm/zyhmcXRKIu9UukDXN0zIIm7DMIUNFV3F+Tkqu+Gxp42a0Wi/k82EHO0nE/enBd0iq1
	UVdXJP5OXQE5OPwR8MUhpJsX3S64WE6/rttg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rohNX-0000000DkVp-2KEN;
	Mon, 25 Mar 2024 11:16:31 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] rcu: mollify sparse with RCU guard
Date: Mon, 25 Mar 2024 11:16:27 +0100
Message-ID: <20240325101626.41584-2-johannes@sipsolutions.net>
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
 include/linux/rcupdate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 17d7ed5f3ae6..41081ee9c9a7 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1090,6 +1090,6 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
 extern int rcu_expedited;
 extern int rcu_normal;
 
-DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
+DEFINE_LOCK_GUARD_0(rcu, do { rcu_read_lock(); __release(RCU); } while(0), rcu_read_unlock())
 
 #endif /* __LINUX_RCUPDATE_H */
-- 
2.44.0


