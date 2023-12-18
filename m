Return-Path: <linux-kernel+bounces-4475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C96817E03
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7FCB1C21829
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF5D768E4;
	Mon, 18 Dec 2023 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQfMty3r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C56E760B3;
	Mon, 18 Dec 2023 23:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD17C433C7;
	Mon, 18 Dec 2023 23:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702941563;
	bh=jz2D1HTTnvEfO7luxuGZDmFgmCccQ/8d9eqpMPiagIE=;
	h=From:To:Cc:Subject:Date:From;
	b=FQfMty3rKGcMRGiCFhNF/8By0LJBuehsUIlEc012N7BdQZbSAxVx6+t30BLbXHbYE
	 irb40fbCYkMv3ygXAIOIWPgOgvK+Xgd4xSSEc+UhCihHi8ihC0ARxT0szXhHH6QZzd
	 NGPvbHSkk6IEMag/r7njT5jd5+P2P1QQStyJvAAVlZNX/kFCK1EB3cFqNajkAR0zYj
	 RuY/CbHH8+L/PSJvzs9A9EIYfFnRqmKxHEVzfPENHgygZ6G9pWjZrwi5QLkJ6Yccvw
	 2HB2K39TZ9dzxBPQx49F91CHr22UpicE+FBBzR+T3+O7Wypt/5MiXgOUTwanE9Yg9o
	 6CJS4C14bQPFw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/3] timers & RCU: Fix TREE03 stalls
Date: Tue, 19 Dec 2023 00:19:13 +0100
Message-ID: <20231218231916.11719-1-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
has introduced an issue with RCU. This is a proposal to solve the
situation after realizing that fixing that on the timers side wouldn't
be pretty to say the least.

Oh and the last patch is absolutely irrelevant to the issue...

Frederic Weisbecker (3):
  hrtimer: Report offline hrtimer enqueue
  rcu: Defer RCU kthreads wakeup when CPU is dying
  rcu/exp: Remove full barrier upon main thread wakeup

 include/linux/hrtimer.h |  3 ++-
 kernel/rcu/tree.c       | 34 +++++++++++++++++++++++++++++++++-
 kernel/rcu/tree_exp.h   |  8 +++-----
 kernel/time/hrtimer.c   |  3 +++
 4 files changed, 41 insertions(+), 7 deletions(-)

-- 
2.42.1


