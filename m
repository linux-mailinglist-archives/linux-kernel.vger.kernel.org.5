Return-Path: <linux-kernel+bounces-106506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B40B87EF9C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2AC1C21D02
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0DE56454;
	Mon, 18 Mar 2024 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jp0OdWez"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D6B55E6D;
	Mon, 18 Mar 2024 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710785855; cv=none; b=LDrLfMcEvwPAT4hfJDvwctf8cNQcCOOnO8bZJeeMOr/HbgCnqxA+NAHBfhIGDJl12W2oV3rFgXpWfANM2YL/lVET91Z3hM9uqn/C+M3zqSE3VyMANslykmwucL4e/16zFveosVDKYW5CTojfgHV/cixNMT4rI19e3yBtsC5hvVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710785855; c=relaxed/simple;
	bh=a9f3m/0RST/UgLyHMorH293F6iede9zSTkNz58mbzVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BedgKKOArYNIb6SqO+WAG++Zw34MnuC/+YqfWEt+6NQGIek7xdj3O7ag361QEDcWCc0bu8Ecpc1Bw8nZZ8JA7WAneYaWt+N6NmzgHHQI53XKURvlQlfccuiSeZuxk7TeOeNYdCeCjjLYeC054gt1GLAg2AYzfcwK/g713jkBRRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jp0OdWez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9155BC433C7;
	Mon, 18 Mar 2024 18:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710785854;
	bh=a9f3m/0RST/UgLyHMorH293F6iede9zSTkNz58mbzVI=;
	h=From:To:Cc:Subject:Date:From;
	b=jp0OdWez//fhYfTg9MLX5sY87RSdW3E8tNvIjRITdy7coaENf3NKrSrlr9TrqkDZU
	 mh84GqmQO8lOvdj6rlwb9Dldvuq7f86Qz9XgOHk0bVXeJWXG7rNt39FrE64t9cOU+k
	 yjRHc9Gmgg/e31cGXuioYkt/a4Rvi91Zz/T6XPYelmX5lWW/cnJG2WXHZYAbqPNC9L
	 hAkmWF+rN46+eb3XiOzBTyGHiFzN3pR9lc1XKedal/G3S6Pyc0KShtZquk1X2GYUTi
	 FF9EZjSUYPf6LJ8QPr6nJannQ9ZvZ9B+K4YJC3j22bNi0u3y82AnGvf+i0ebejwzFL
	 Y0ekIiaRfdaKA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	oleg@redhat.com,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 0/3] uprobes: two common case speed ups
Date: Mon, 18 Mar 2024 11:17:25 -0700
Message-ID: <20240318181728.2795838-1-andrii@kernel.org>
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

v1->v2:
  - rebased onto trace/core branch of tracing tree, hopefully I guessed right;
  - simplified user_cpu_buffer usage further (Oleg Nesterov);
  - simplified patch #3, just moved speculative check outside of lock (Oleg);
  - added Reviewed-by from Jiri Olsa.

Andrii Nakryiko (3):
  uprobes: encapsulate preparation of uprobe args buffer
  uprobes: prepare uprobe args buffer lazily
  uprobes: add speculative lockless system-wide uprobe filter check

 kernel/trace/trace_uprobe.c | 103 +++++++++++++++++++++---------------
 1 file changed, 59 insertions(+), 44 deletions(-)

-- 
2.43.0


