Return-Path: <linux-kernel+bounces-43487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CCF8414A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39C0289371
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19906153BC4;
	Mon, 29 Jan 2024 20:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8/yf7dE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545C64CB24;
	Mon, 29 Jan 2024 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561271; cv=none; b=aG8/0PngKIADpJ7g33Y2TyIbaisWwx+uZGnHbDWaATKAlC//0Sz7/8WSSw8Np7W3CpjUIwERWMA50ae82CA1JmrFO+6p2rOprpRgNWYHmtR6GZGt8UDawtkYFF7LvTMlGcP8Akr4Jnpr/MaMrmMcAqwUl7oZAmbXC2eDeNMaDTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561271; c=relaxed/simple;
	bh=50VqBVKc9VWmL0t3XkRWKFQhuYMqelJQTXlLgczVW0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pY8sNXFK+++Ptw/2trn5+gXelIuu4yWHkqG9gFioWI/0yZ2nXF8anWICwX9ySTuJAMlNdbKdGolX3uES0qOurDfmhYS5uYiSi4i1Xr+0NYU57Ouy/SQNLHr26guGawHtvBV6Gk2DCfR5FwqNR02FfDFwqWaQN9Ohplkp82cerSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8/yf7dE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6339BC433F1;
	Mon, 29 Jan 2024 20:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706561270;
	bh=50VqBVKc9VWmL0t3XkRWKFQhuYMqelJQTXlLgczVW0k=;
	h=From:To:Cc:Subject:Date:From;
	b=S8/yf7dEwWGQ/Vw4PVgzNQMCYL+WNoyrm3RX0oBnlUg2mv3Cuxaz9OqQUZNRuuPWK
	 GB2B3mol09/oDzrnf+dxjQUQiAI1WLpd8qarnIaa+PvZPkfuZCQfHRerbK8fHz/Jpg
	 oh0lsJtviRx9WRGag3qT2POeoaslf+MeBjgglTp8v/JVUkwRdyO9tRY+I6AbHLvr1Q
	 CLlgdY0A3ZrIRXA7sKanLqzjHWWQ5C/z6Obg3MA2zgsvm3I8UF/yzXr4qvbHBN6hEp
	 JG3lR0Uy5UiaAjSbPQREqyiG+rofoVF9LVeXxAsevkVfnizZy8lPjeScSH3QEkrpG4
	 tcQu7hLayVQhw==
From: SeongJae Park <sj@kernel.org>
To: lsf-pc@lists.linux-foundation.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] DAMON Updates and Plans: Automation of DAMON tuning, tiering, and VM guest scaling
Date: Mon, 29 Jan 2024 12:47:49 -0800
Message-Id: <20240129204749.68549-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,


Thanks to the discussions and feedback that we received last year from the
LSF/MM/BPF 2023's DAMON updates and future plans session[1], DAMON made many
advances and yet more future plans.  I'd like to again share/discuss the
followup changes and status we made so far after the last year's session, and
the future development plans on LSF/MM/BPF 2024.

A few topics would be shared, including below.

User Aims-oriented DAMOS Self-tuning
------------------------------------

I shared "feedback-based quota auto tuning" as the top priority item for 2023
in last year's session.  Fortunately it made some progress.  A simple feedback
loop-based quota tuning and user feedback interface have been implemented and
merged into the mainline from v6.8-rc1.  By the time of LSF/MM/BPF 2024,
hopefully the remaining part of the initial idea, specifically making DAMON
feeds itself, will be implemented and merged in the mm tree.

I'd like to share the implementation details, discuss remaining rooms for
improvements, and find future extension opportunities.  Hopefully DAMON
monitoring parameters auto-tuning would be one of the future works to consider.

DAMON-based Tiered Memory Management
------------------------------------

I'm personally not working on this topic directly, but apparently a few folks
are exploring DAMON usage for tiered memory management.  Some academic
papers[2,3] exploring the opportunity have been published.   I shared a rough
RFC idea[4] of it based on the self-tuning in November 2023.  Recently SK hynix
has also adopted DAMON for their CXL-based tiered memory management
solution[5], and sent patches for their work[6].

I'd like to provide a summary of the ongoing works and updates on my idea.
Hopefully early proof-of-concepts level implementation of my idea would be
shared in the session.

Access/Contiguity-aware Memory Auto-scaling
-------------------------------------------

This is a new idea which was not discussed in last year's LSF/MM/BPF.  The main
purpose is to implement an access-aware, efficient, reliable, and simple to use
memory over-subscribed VM guest kernels.  Specifically, it will steal guest
memory based on access patterns in a contiguity-aware manner and report those
to the host as free to use.  The PSI-based stealing aggressiveness auto-tuning
may be used.  It will also apply a 'struct page' overhead reduction mechanism
to the stolen memory.  We're currently thinking about memory hotplugging and
vmemmap remapping as candidate mechanisms.  For simple usage, the interface
will be similar to that of virtio-balloon, which is widely adopted.  The first
version of the more detailed idea[7] has been shared before.

Because it is still at a pure idea level, not much progress until LSF/MM/BPF is
expected.  This item would be primarily for the future plans part.  That said,
at least a second version of the design will be shared before.  Also hopefully
early proof-of-concepts level implementation or some test results will be
shared.  Since this is expected to be more for future plans than status update,
I hope to have more discussions for getting design level concerns and possible
collaboration chances.

Misc
----

If time allows, I would be able to cover more follow ups for items that I
shared as the future plans, and the feedback/questions I received from the last
year's session.

- Merging DAMON user-space tool in the tree
- DAMON documentation improvements
- Write-only monitoring
- THP memory footprint reduction
- DAMON-based working set size report
- In production DAMON usages

[1] https://lwn.net/Articles/931769/
[2] https://arxiv.org/abs/2302.09468
[3] https://dl.acm.org/doi/10.1145/3600006.3613167
[4] https://lore.kernel.org/damon/20231112195602.61525-1-sj@kernel.org/
[5] https://github.com/skhynix/hmsdk/releases/tag/hmsdk-v2.0
[6] https://lore.kernel.org/r/20240115045253.1775-1-honggyu.kim@sk.com
[7] https://lore.kernel.org/damon/20231112195114.61474-1-sj@kernel.org/


Thanks,
SJ

