Return-Path: <linux-kernel+bounces-152078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65E18AB882
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629972822EB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1C2610E;
	Sat, 20 Apr 2024 01:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+ILx3mQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0692205E1D;
	Sat, 20 Apr 2024 01:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713577734; cv=none; b=Ovo3bc0GwzEHYPQ0KZP6UnIM+eVZMSrRy4NWiBf4e+xMbk/Jfd7NKhB1BSk1jpqiIrhX0a9f896NmL4oiLwOoQEErIq/tng5hCvcg0nUrZxJTOOct/lj3ROPUf/FKNC5xgVBwwOqCzKhiPYTqqFZkFhtmLkDPNvxWZp6G90hL/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713577734; c=relaxed/simple;
	bh=ik3G7vkeW0E61S/ZaBaByGKXdcNuQmCv9GExNSXbmIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Up6vZmMQpfKvixF/Oz3tE6x1SVThriDeeoJTYnAOnMTy+tEWQ0eCE1uBlEoL6QySmG6vN9U/FOjjvzfcWCtad3vVzvw97kontq6XwILKWfttbOJQ3RQ5KuKRbleLSRBaVMFvr13XQdRBF8Q5syV+5AFkftBxSIxLrpKwTu3mglA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+ILx3mQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C816C072AA;
	Sat, 20 Apr 2024 01:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713577734;
	bh=ik3G7vkeW0E61S/ZaBaByGKXdcNuQmCv9GExNSXbmIQ=;
	h=From:To:Cc:Subject:Date:From;
	b=B+ILx3mQlB782/3YDGn06XYKMpGenMoykt99N8xguDS6SbbTJuU4pAW/0urZRslcZ
	 TYW2d0f2hIEUFd8EeMEJyNXrMgGRJHp/joxmtb7WxXvwdGAis6RgyvISx9DU4d6GIA
	 E3qDV7gs6BRwoDpFRMwfmniMK0xHUgQNOiOP52jFpursXLC80czIFpwWnpVIm65mye
	 NYA5MnAjAhwQ+8vEw+aTEEmgZ6lPsYDdP97f2Gtfeff1TC4ItnxUEdKJbylUld2I4K
	 OhtVfXjKYsWIdTpYc3sNpT52lmGLyng0NiUNueJv1BCXPg4Kg0RiEP07bvgkkOglxe
	 lizHdeUqfhKaQ==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.9-rc4
Date: Fri, 19 Apr 2024 18:48:52 -0700
Message-ID: <20240420014853.87829-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to d3e8a91a848a5941e3c31ecebd6b2612b37e01a6:

  clk: mediatek: mt7988-infracfg: fix clocks for 2nd PCIe port (2024-04-10 20:50:26 -0700)

----------------------------------------------------------------
A couple clk driver fixes, a build fix, and a deadlock fix.

 - Mediatek mt7988 has broken PCIe because the wrong parent is used

 - Mediatek clk drivers may deadlock when registering their clks because
   the clk provider device is repeatedly runtime PM resumed and
   suspended during probe and clk registration. Resuming the clk
   provider device deadlocks with an ABBA deadlock due to genpd_lock and
   the clk prepare_lock. The fix is to keep the device runtime resumed
   while registering clks.

 - Another runtime PM related deadlock, this time with disabling unused
   clks during late init. We get an ABBA deadlock where a device is
   runtime PM resuming (or suspending) while the disabling of unused
   clks is happening in parallel. That runtime PM action calls into the
   clk framework and tries to grab the clk prepare_lock while the
   disabling of unused clks holds the prepare_lock and is waiting for
   that runtime PM action to complete. The fix is to runtime resume all
   the clk provider devices before grabbing the clk prepare_lock during
   disable unused.

 - A build fix to provide an empty devm_clk_rate_exclusive_get()
   function when CONFIG_COMMON_CLK=n

----------------------------------------------------------------
Daniel Golle (1):
      clk: mediatek: mt7988-infracfg: fix clocks for 2nd PCIe port

Pin-yen Lin (1):
      clk: mediatek: Do a runtime PM get on controllers during probe

Stephen Boyd (6):
      clk: Remove prepare_lock hold assertion in __clk_release()
      clk: Don't hold prepare_lock when calling kref_put()
      clk: Initialize struct clk_core kref earlier
      clk: Get runtime PM before walking tree during disable_unused
      clk: Get runtime PM before walking tree for clk_summary
      Merge branch 'clk-rpm' into clk-fixes

Uwe Kleine-König (1):
      clk: Provide !COMMON_CLK dummy for devm_clk_rate_exclusive_get()

 drivers/clk/clk.c                          | 173 ++++++++++++++++++++++-------
 drivers/clk/mediatek/clk-mt7988-infracfg.c |   2 +-
 drivers/clk/mediatek/clk-mtk.c             |  15 +++
 include/linux/clk.h                        |   5 +
 4 files changed, 156 insertions(+), 39 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

