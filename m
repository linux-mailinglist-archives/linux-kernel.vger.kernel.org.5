Return-Path: <linux-kernel+bounces-71881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FB285AC2E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA6F28270C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FDF524AC;
	Mon, 19 Feb 2024 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikdWH8ow"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDBF50A78;
	Mon, 19 Feb 2024 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371879; cv=none; b=R+J+2FaUv6hRuJtCnoJSUkudAKIE9Gw7J7ns7HbZK/lqzKKK0QJvxejUHQ+hLtd0rKUrCbaBIY9fOSJNc+mHuVWOvJg4VDqCpdclpOuNsyWzZ4wm1a+GmllaVKGcbnC5tyeD6/jKY+cnoXCUv3axQW2qpXsgTq12CVYGbGYe8Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371879; c=relaxed/simple;
	bh=zFv+mIURCJr6m8NzYGddF+Wy8clWunZga3El7GHeE7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LPMDuZKRxZ4lI92cc+onbZTwYYzOpLgKoLjBoDGjXxRJUee+6eSJoCsSHMkv4Lx8am6oXzVAYztIgrIA/5jheUBhhf+ijGhzwXhzQ/jGXTEso5XGvrNskqk06YG2U/1CZC3/AIl1HQCWkfsm/dHRynO7GEgsh7ofDywSE54yEXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikdWH8ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB52C433F1;
	Mon, 19 Feb 2024 19:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371878;
	bh=zFv+mIURCJr6m8NzYGddF+Wy8clWunZga3El7GHeE7E=;
	h=From:To:Cc:Subject:Date:From;
	b=ikdWH8ow4kGhBPhuc6EoKOEiI/go5FlEMizlJZZDIY6l6p3s1m2yanl3xGbhrsurh
	 GF4/4Dc5BpQEVNlWj0IqxFZVplRxB1Jq7UKv8+5mlwb5Cg0flI0wRA+hDwArbC9xn7
	 S50TjD9FPNb3zDkULmXwlQszg9R3nWD5E8yqY6hOmppplq5x+ntZbqgHAb8z4UVj1p
	 u6XFatBVsKsDLuZAFBlJuLYtIvijEyW6DufF+8yjyQoTOD2aoQM4SahMD+2f9PGCCU
	 ujt0LzzfrCE6aXapxNTk7XvKr8EZbAQgLapf3LSEmDa8+e0r90oyyrvYBB+aP6BM/K
	 VfnuhvqRLK8Qw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/20] mm/damon: let DAMOS feeds and tame/auto-tune itself
Date: Mon, 19 Feb 2024 11:44:11 -0800
Message-Id: <20240219194431.159606-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Aim-oriented Feedback-driven DAMOS Aggressiveness Auto-tuning
patchset[1] which has merged since commit 9294a037c015 ("mm/damon/core:
implement goal-oriented feedback-driven quota auto-tuning") made the
mechanism and the policy separated.  That is, users can set a part of
DAMOS control policies without a deep understanding of the mechanism but
just their demands such as SLA.

However, users are still required to do some additional work of manually
collecting their target metric and feeding it to DAMOS.  In the case of
end-users who use DAMON sysfs interface, the context switches between
user-space and kernel-space could also make it inefficient.  The
overhead is supposed to be only trivial in common cases, though.
Meanwhile, in simple use cases, the target metric could be common system
metrics that the kernel can efficiently self-retrieve, such as memory
pressure stall time (PSI).

Extend DAMOS quota auto-tuning to support multiple types of metrics
including the DAMOS self-retrievable ones, and add support for memory
pressure stall time metric.  Different types of metrics can be supported
in future.  The auto-tuning capability is currently supported for only
users of DAMOS kernel API and DAMON sysfs interface.  Extend the support
to DAMON_RECLAIM.

Patches Sequence
================

First five patches are for helping debugging and fine-tuning existing
quota control features.  The first one (patch 1) exposes the effective
quota that is made with given user inputs to DAMOS kernel API users
and kernel-doc documents.  Following four patches implement (patches 1, 2
and 3) and document (patches 4 and 5) a new DAMON sysfs file that
exposes the value.

Following six patches cleanup and simplify the existing DAMOS quota
auto-tuning code by improving layout of comments and data structures
(patches 6 and 7), supporting common use cases, namely multiple goals
(patches 8, 9 and 10), and simplifying the interface (patch 11).

Then six patches for the main purpose of this patchset follow.  The
first three changes extend the core logic for various target metrics
(patch 12), implement memory pressure stall time-based target metric
support (patch 13), and update DAMON sysfs interface to support the new
target metric (patch 14).  Then, documentation updates for the features
on design (patch 15), ABI (patch 16), and usage (patch 17) follow.

Last three patches add auto-tuning support on DAMON_RECLAIM.  The
patches implement DAMON_RECLAIM parameters for user-feedback driven
quota auto-tuning (patch 18), memory pressure stall time-driven quota
self-tuning (patch 19), and finally update the DAMON_RECLAIM usage
document for the new parameters (patch 20).

[1] https://lore.kernel.org/all/20231130023652.50284-1-sj@kernel.org/

SeongJae Park (20):
  mm/damon/core: Set damos_quota->esz as public field and document
  mm/damon/sysfs-schemes: implement quota effective_bytes file
  mm/damon/sysfs: implement a kdamond command for updating schemes'
    effective quotas
  Docs/ABI/damon: document effective_bytes sysfs file
  Docs/admin-guide/mm/damon/usage: document effective_bytes file
  mm/damon: move comments and fields for damos-quota-prioritization to
    the end
  mm/damon/core: split out quota goal related fields to a struct
  mm/damon/core: add multiple goals per damos_quota and helpers for
    those
  mm/damon/sysfs: use only quota->goals
  mm/damon/core: remove ->goal field of damos_quota
  mm/damon/core: let goal specified with only target and current values
  mm/damon/core: support multiple metrics for quota goal
  mm/damon/core: implement PSI metric DAMOS quota goal
  mm/damon/sysfs-schemes: support PSI-based quota auto-tune
  Docs/mm/damon/design: document quota goal self-tuning
  Docs/ABI/damon: document quota goal metric file
  Docs/admin-guide/mm/damon/usage: document quota goal metric file
  mm/damon/reclaim: implement user-feedback driven quota auto-tuning
  mm/damon/reclaim: implement memory PSI-driven quota self-tuning
  Docs/admin-guide/mm/damon/reclaim: document auto-tuning parameters

 .../ABI/testing/sysfs-kernel-mm-damon         |  16 ++-
 .../admin-guide/mm/damon/reclaim.rst          |  27 ++++
 Documentation/admin-guide/mm/damon/usage.rst  |  31 +++--
 Documentation/mm/damon/design.rst             |  20 ++-
 include/linux/damon.h                         |  89 ++++++++++---
 mm/damon/core.c                               | 120 +++++++++++++++--
 mm/damon/reclaim.c                            |  53 ++++++++
 mm/damon/sysfs-common.h                       |   6 +-
 mm/damon/sysfs-schemes.c                      | 124 +++++++++++++++---
 mm/damon/sysfs.c                              |  33 ++++-
 10 files changed, 454 insertions(+), 65 deletions(-)


base-commit: ecd6af887705c19e7367f9d3818ae712f4674168
-- 
2.39.2


