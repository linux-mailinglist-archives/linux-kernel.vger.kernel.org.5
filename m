Return-Path: <linux-kernel+bounces-150420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8292C8A9EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11476B23B63
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B63B16F830;
	Thu, 18 Apr 2024 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YuOnytQw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828CD16E89E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455251; cv=none; b=rjJE6hhAdrwnUKnfOD5+7sMy6zK9nhyYJ7ojA16SBI/Vkkh0wJyBo3YoUoLsr1AmQ0PpWOT9hiG0+uU7UAinVtil7qTfTjI/4IYl/7VoECFIBdzhG/DcxlgDiSBPE3dcRzdyp2olBOUoXPXZWO1TfbyNxQNyVud9UnDy4K4DrE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455251; c=relaxed/simple;
	bh=7FiDRpIVz9OT1TGiaNEnxUKLX0yRqoUywovgNql2V/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZV+mg8YoFOl+5eNG9p+1pq2NVp3FechgfMiQk3x2EKAnc2OCtNvAy+0WwI4VSuWieDjicb9zpaoRtbGqxZQJetUm8TtIQ8/yazoqYC8+amUOIdt9dK8xPWiRGTIH/GAaJXo/Y4Qtc+Pk1N6qaPhY+W2ZZbVeOIb6J7kLYzkuPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=YuOnytQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01F9C113CC;
	Thu, 18 Apr 2024 15:47:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YuOnytQw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713455248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mPUsA8w471gFFeYcvRttAa3beeKvBN+EzgReXd/Et7A=;
	b=YuOnytQwOt0SKs0Cm0lQTCZkKp1mSmKGcvQkl/pnFWIlhDAMKOWtICfzkIjSN/la464A2J
	6a36qfmjajf/BQOaQ3nm0HtFXQJgVjaAJz4YkqFmsIYj8HU1EJj91JNB0tbMsNvXKV/hiM
	rKG4X2dvClU5O5mkesiAO5Fzf0BxPQE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 00b403ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Apr 2024 15:47:27 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator fixes for 6.9-rc5
Date: Thu, 18 Apr 2024 17:47:17 +0200
Message-ID: <20240418154717.427109-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

This pull has two small fixes:

- The input subsystem contributes entropy in some places where a spinlock is
  held, but the entropy accounting code only handled callers being in an
  interrupt or non-atomic process context, but not atomic process context. We
  fix this by removing an optimization and just calling queue_work()
  unconditionally.

- Greg accidently sent up a patch not intended for his tree and that had been
  nack'd, so that's now reverted.

Please pull.

Thanks,
Jason

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.9-rc5-for-linus

for you to fetch changes up to 3aadf100f93d80815685493d60cd8cab206403df:

  Revert "vmgenid: emit uevent when VMGENID updates" (2024-04-18 14:47:23 +0200)

----------------------------------------------------------------
Random number generator fixes for Linux 6.9-rc5.
----------------------------------------------------------------

Jason A. Donenfeld (2):
      random: handle creditable entropy from atomic process context
      Revert "vmgenid: emit uevent when VMGENID updates"

 drivers/char/random.c  | 10 +++++-----
 drivers/virt/vmgenid.c |  2 --
 2 files changed, 5 insertions(+), 7 deletions(-)

