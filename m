Return-Path: <linux-kernel+bounces-106789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1925487F3CD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE556283079
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867F25C8F6;
	Mon, 18 Mar 2024 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPANvSqk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EB55C60F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710803259; cv=none; b=GPfMJ10+V5AJA9rZtIrfTKATwGrK5pbxRXinhhosGwqz1YIiOhe6M6I0pn5tHCgu0qENbaRYUoO+nsLBlH60rGowb0ZAXdSRh0lX1O0SCvMTvzgxTIpdg039yq4LG7GiKdThLqTDU1YJ+LYzazQkO7AiyMc5sPOwhE1Klw8ZWe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710803259; c=relaxed/simple;
	bh=/GsU4md20h5GtxNTvVf/IwLQnWFTT9IX981orGbtJlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ld80+g9k3Yd60izv5RmmGfcnUjVPCrn+lAzaA2nv4whJLBam+gCVn/VyZDOQ0OkpsH1OT48YldaY2E6/gr6MGh2I2uGEP7yd7/bTxmKdLE1pNp0u56HFrUUF4y53Ii9kSwLAskFiFjdYlpHkr6gwvB9qXI8k79EMOT6tUFI8+f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPANvSqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80687C43330;
	Mon, 18 Mar 2024 23:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710803259;
	bh=/GsU4md20h5GtxNTvVf/IwLQnWFTT9IX981orGbtJlI=;
	h=From:To:Cc:Subject:Date:From;
	b=mPANvSqk77ldGrOumasfg3z+V7c4Qilby/k7urgNgUmPHYOSJAJsrVJ6SEXQJagaq
	 ndqJYNYbAEvjYW2I4NBbfWLv+YmkfJ/KJpMY0jCj08r6DVAr53mRpxGMieT1xcFICG
	 qx5nTnmdeTnERzpg2/vo3twB3oWebljkBnfPZxDTiMtoYP+a4QHOhqKZMG2vGTk2Kr
	 OBrHG3kTRbElkCRip4GH9F2kARJCJ7jZnKgxuJW7qtwHEg2pGFhpqkAyzFUA+afrSV
	 CZk8jAFuxLuyNDOztPhKCuJNN72gaGbvH00BEnaocXhKXMb/XELukS1GLbpYhehEn1
	 kGa1RCIcHzBhA==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 0/2] timers: More fixes
Date: Tue, 19 Mar 2024 00:07:27 +0100
Message-ID: <20240318230729.15497-1-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Paul reported some rcutorture's TREE07 splats. This set isn't claiming
to fix them (yet) but here are some issues I found on my way while
reproducing and tracing.

Thanks.

Frederic Weisbecker (2):
  timers/migration: Fix endless timer requeue after idle interrupts
  timers: Fix removed self-IPI on global timer's enqueue in nohz_full

 kernel/time/timer.c           | 12 +++++++++++-
 kernel/time/timer_migration.c | 11 +++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

-- 
2.44.0


