Return-Path: <linux-kernel+bounces-71897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68AB85AC45
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E8AAB22598
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E35659B7E;
	Mon, 19 Feb 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rN+wAd4r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BDF58ABE;
	Mon, 19 Feb 2024 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371888; cv=none; b=NdWgradMnkSZpbcJ1n/LaJ8cg0viuIkhMat+PscEV7XqUEtNH5ilHmSfJYXxw0JbaqFIxthemUL5xMEiRJgTQG13eYyOAaLoC4uCph2kBd3rcOebOWIpnx6ph+sXD8bIIeBgtrLTSq/FOZP3i2G3IgDDVV+AcpVlQKo30H+YCqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371888; c=relaxed/simple;
	bh=dE+jqLZYW9QB5NiFklbDnZHaYSFDuOnT6wibaYvQ7fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V6CSpID45oPoL3UOUAIop8LyyzyOjdCMwgItGP8u7CaMmoh/AOBivPmYqFPOydJRZovqLJhcOuFR8Odon7OzQhsCKst0S4YELVZcGULNKASK1/ByvfMuwtSm0rYxEHou4bJVqgTLIeBhyeUnlPUyCc5REKIjnSJdgEmjQURtwgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rN+wAd4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A133C43399;
	Mon, 19 Feb 2024 19:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371887;
	bh=dE+jqLZYW9QB5NiFklbDnZHaYSFDuOnT6wibaYvQ7fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rN+wAd4rUpHbmoSCSt+/pVijeH1M2J+z3ioq9IiqpMA7SQFSRjct47t4BrxCbYLzm
	 g+NTWKrJdapNMH3m9ClPNCicsC8FXavIYUJ+PTZpM3XOUKOjufVIRPa+f6MVCL8FKx
	 mnvvP4UR8ztDA3EZAIC758uAZSZn6xL0EAMZAUfFtGXapQSihyvtpmetzNaC/Kghcx
	 UNloo8Ow4xzXJiJmt/6CbhAsy17pIVqzgkj0XUIKlijM/hF+Tkk2+/az2jLdwG67tG
	 ZGw7C9Tdx2lPuF00Kfz/OfYDrG79xQFFIGBkn/Tpc1eB2mhLP1THJX3eXJLAQ/kPEA
	 eQzcGIUVQS9rA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/20] Docs/mm/damon/design: document quota goal self-tuning
Date: Mon, 19 Feb 2024 11:44:26 -0800
Message-Id: <20240219194431.159606-16-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219194431.159606-1-sj@kernel.org>
References: <20240219194431.159606-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update DAMON design doc to explain the quota goal self-tuning, which can
be used by setting the goal's metric to metrics that kernel can
self-retrieve.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 2bd0c203dcfb..8c89d26f0baa 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -398,12 +398,28 @@ Aim-oriented Feedback-driven Auto-tuning
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Automatic feedback-driven quota tuning.  Instead of setting the absolute quota
-value, users can repeatedly provide numbers representing how much of their goal
-for the scheme is achieved as feedback.  DAMOS then automatically tunes the
+value, users can specify the metric of their interest, and what target value
+they want the metric value to be.  DAMOS then automatically tunes the
 aggressiveness (the quota) of the corresponding scheme.  For example, if DAMOS
 is under achieving the goal, DAMOS automatically increases the quota.  If DAMOS
 is over achieving the goal, it decreases the quota.
 
+The goal can be specified with three parameters, namely ``target_metric``,
+``target_value``, and ``current_value``.  The auto-tuning mechanism tries to
+make ``current_value`` of ``target_metric`` be same to ``target_value``.
+Currently, two ``target_metric`` are provided.
+
+- ``user_input``: User-provided value.  Users could use any metric that they
+  has interest in for the value.  Use space main workload's latency or
+  throughput, system metrics like free memory ratio or memory pressure stall
+  time (PSI) could be examples.  Note that users should explicitly set
+  ``current_value`` on their own in this case.  In other words, users should
+  repeatedly provide the feedback.
+- ``some_mem_psi_us``: System-wide ``some`` memory pressure stall information
+  in microseconds that measured from last quota reset to next quota reset.
+  DAMOS does the measurement on its own, so only ``target_value`` need to be
+  set by users at the initial time.  In other words, DAMOS does self-feedback.
+
 
 .. _damon_design_damos_watermarks:
 
-- 
2.39.2


