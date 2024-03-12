Return-Path: <linux-kernel+bounces-100782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A43CB879D2B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D211F2241D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1152A143C40;
	Tue, 12 Mar 2024 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ox0nReLD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2F67E10A;
	Tue, 12 Mar 2024 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710277361; cv=none; b=WRpWAOcuOA0rvwwsgie1w9sPyE3/yGdwUS9juKk4SU3Nz4JiUdwd0UA/nA9UCY2g149lzb4TjAlMhFX6tm0zr5SOkIRmBJkmP9bQfP0astZb7YOxVUiqQgNPqx67/wZ3MZ7qJUqJNulbtnF4bl9ZSt66pUV5RcNPPK8kYuH2+7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710277361; c=relaxed/simple;
	bh=YlNA7A0sYPEuL9IKdifj0rW3/JYLzAH/grxbO4vJ5O0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VH0uWCfZh8c2SG6cnIGDGNUa8c6qvkbB4iNXs5UDe635BEfUzCIF2lD5bUvltu77lu8wRpfm5t8xUbMf9rYr4WDnjTgxvHFGdU2+7dTJoESSlHF+26BKTkY4BOKK9UfGMz5TkSBCkDBz0e/KfRXXKpzRbihb3884UgB+Fi0GRMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ox0nReLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A206AC433F1;
	Tue, 12 Mar 2024 21:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710277360;
	bh=YlNA7A0sYPEuL9IKdifj0rW3/JYLzAH/grxbO4vJ5O0=;
	h=From:To:Cc:Subject:Date:From;
	b=ox0nReLDeVd3EpvJMY/kz/bsPA3yTNvQ4A3p03uIMcopsoiToYMYhCEiDVdUAVRuv
	 JMKQrpPWO+Z1XLZ5efh9OXHyme8+H1u+dd92AmGS7Z+T85BNwiCa3VVUsYuHM8dsFo
	 j1m/IVuy+3i1g18Knq4VTEMazsZOefqowYwmoUgK6NSA+uOgSo6M+Kjg2viqYMCkgn
	 87oKz8G7EP43y3m7DBMMFtPM+F6R8Zurdx3C7ktVx6VbMg65djb4GDKWXhiiVcjJvw
	 dJxGwk5ANPksNNexYCD9zxEHpgEZhhb8NrSxIE29vnRorqc2XsMuoWR/8TXTk8eL1s
	 o2Uog59yzlAcg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	oleg@redhat.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 0/3] uprobes: two common case speed ups
Date: Tue, 12 Mar 2024 14:02:30 -0700
Message-ID: <20240312210233.1941599-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch set implements two speed ups for uprobe/uretprobe runtime execution
path for some common scenarios: BPF-only uprobes (patches #1 and #2) and
system-wide (non-PID-specific) uprobes (patch #3). Please see individual
patches for details.

Given I haven't worked with uprobe code before, I'm unfamiliar with
conventions in this subsystem, including which kernel tree patches should be
sent to. For now I based all the changes on top of bpf-next/master, which is
where I tested and benchmarked everything anyways. Please advise what should
I use as a base for subsequent revision. Thanks.

Andrii Nakryiko (3):
  uprobes: encapsulate preparation of uprobe args buffer
  uprobes: prepare uprobe args buffer lazily
  uprobes: add speculative lockless system-wide uprobe filter check

 kernel/trace/trace_uprobe.c | 103 ++++++++++++++++++++++--------------
 1 file changed, 63 insertions(+), 40 deletions(-)

-- 
2.43.0


