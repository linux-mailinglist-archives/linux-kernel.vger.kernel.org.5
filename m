Return-Path: <linux-kernel+bounces-82365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE6C868345
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F671F2428F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C43131E21;
	Mon, 26 Feb 2024 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DN9gGZSk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47369131755;
	Mon, 26 Feb 2024 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983826; cv=none; b=VI7xWBK/xBAQvP/4ZV0P6aoscmuoVkh1mjZ1B8/QbLnUz93ZE7kN8jUI1tiwFBOqd4+VuRp91jAamzJtWVsJmookcIJPqm3ohaHtJNFguAmocO4lvdjRxvNS7CZ1UxPDq6NH2+XrxEoiX37Xq0OdGxYjBgYpULxfrb7d/i+Q96s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983826; c=relaxed/simple;
	bh=q4y2X/QHhahydjCVDTw5gR86bYLURECOrXgKn3n9zHw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ujWnHTJmWSTzZZAUyari/wq+kZ3lrCC25wneeRg2iUhKspkqbvszCVaqvUI2Z1osOn2LZZ78bgmwhuzZZHYNVgujavowMApef6FAnz8l85Qo4AIB2RT0VEIwY3Hg2rGnAUK3ffFT2w3IQckaClTpmO/VVqtkIqN3k6Xn3tBhsYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DN9gGZSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D540AC433C7;
	Mon, 26 Feb 2024 21:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708983825;
	bh=q4y2X/QHhahydjCVDTw5gR86bYLURECOrXgKn3n9zHw=;
	h=From:Subject:Date:To:Cc:From;
	b=DN9gGZSklIZq/UL0g1gMnm/1G7uMV4Pq7xaKNIzQiRzY4rogOw+Z97ncNaZDCWhNo
	 bNaUdnkPC1tWPVkJPoWnOc4qyK3sflxjRRxAniL/j0jqnaQ6xJ4STAxIGRYaPlqGsg
	 To4P/lN/7o4bGYVEfYWgxhQJT+OnSA4MDXMcggOQBai1b+BGIBp89P/ppKOXtMyFr1
	 Mq/V4P8NDXN63BVKhvFXs4SriHidViIPbBwK4IoHgq+NkRcFY6Fh1nhuZAi/tA0kMX
	 fCRLr/J2KPDxz0BdHLi8W3XA3f427qMUDXsqxZLNE3blThJhX8+ZSEriQWUhqyUMva
	 jbNWs34o7i6Ww==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] KVM: arm64: Store a cpu_fp_state directly in the vCPU
 data
Date: Mon, 26 Feb 2024 20:44:09 +0000
Message-Id: <20240226-kvm-arm64-group-fp-data-v1-0-07d13759517e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABr43GUC/x3MwQqDMAyA4VeRnBfoYunBVxk7BE1dkGpJNxFK3
 92y43f4/wpFTKXANFQwObXosXc8HwPMH95XQV26gRx5RxRwOxOypeBxteOXMWZc+MvoWMYwzkI
 +CvQ6m0S9/ufXu7UbGFEayGkAAAA=
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307; i=broonie@kernel.org;
 h=from:subject:message-id; bh=q4y2X/QHhahydjCVDTw5gR86bYLURECOrXgKn3n9zHw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl3QYNyJcuw5R7ZvMsPlX9Jct2g8pwbHrFBfsUoUkG
 dREKPm+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZd0GDQAKCRAk1otyXVSH0KsTB/
 9Km1/eQVR4Bymv26xJINCBgG9Os0SOmZYsDaaFD9cM9YQpJZtWE9rwtzx63a6KbZ2oTJzU6xSEIXd4
 8pNZ0Us8fXAX25i1xJ0/WRoZnL0upzJJu1rbPFmGE4qS81CwqbuLbMWvm6o4/1UhCBnzgcmJ4l9TQG
 mUhxFINAa4p82LL4o1XCbG8cdDPJrzaOGzR48ZfqKX+1xvfbTT5nk4iZIg3IKZ1ucOvQmyYFPoeCZB
 pjWPXLfzAU6qKt6YGzIUFWkzBG7D+ZWit17CvZG1WFnF7uMprMkHR8MNsaIb/ofRy4KZC/raBn0P54
 3R2SZ8Wfg4hptSjMEU/hz710chRvJS
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Simplify the binding of the guest state to the CPU when returning to the
host by storing a copy of the structure used to pass the state in the
vCPU data and initialising it during guest setup rather than creating a
new copy each time we exit the guest.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      KVM: arm64: Rename variable for tracking ownership of FP state
      KVM: arm64: Reuse struct cpu_fp_state to track the guest FP state

 arch/arm64/include/asm/kvm_emulate.h    |  4 ++--
 arch/arm64/include/asm/kvm_host.h       | 25 ++++++++++++-------------
 arch/arm64/kvm/arm.c                    | 14 +++++++++++++-
 arch/arm64/kvm/fpsimd.c                 | 29 ++++++-----------------------
 arch/arm64/kvm/guest.c                  | 21 ++++++++++++++-------
 arch/arm64/kvm/hyp/include/hyp/switch.h |  6 +++---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      |  9 +++++----
 arch/arm64/kvm/hyp/nvhe/switch.c        |  2 +-
 arch/arm64/kvm/hyp/vhe/switch.c         |  2 +-
 arch/arm64/kvm/reset.c                  | 14 ++++++++------
 10 files changed, 65 insertions(+), 61 deletions(-)
---
base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
change-id: 20240226-kvm-arm64-group-fp-data-0ae363ce24fe

Best regards,
-- 
Mark Brown <broonie@kernel.org>


