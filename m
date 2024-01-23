Return-Path: <linux-kernel+bounces-35492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C478391F9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C71B223EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB6F5FEE8;
	Tue, 23 Jan 2024 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkFPbd16"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7125FDAA;
	Tue, 23 Jan 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022147; cv=none; b=WQP3ggfoYoj0JaXBODtQghv6EeSLVq9j1Av0nIuDgHfCPQpmijZ2s58VWtFUZiBNKzB3AKJ4AOiZzxCevBxuaLjvlLzmQSjqTdoo/g7oMO8nGcOZf0bTq8K8Tq1ozPzHhewe83dAGYU/cjsgFIjcnBmWpTbk8Khb42aPOIi6dOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022147; c=relaxed/simple;
	bh=c55w7bNYVc+/PvGNzvXmIarNgAUxg847kHKA77JNnc0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TyFKieN8kUeD9OcyVHppw0HZy1hAf4lIyA8s4WLcLiuc10zklSm7lU328JKeFSeiQMg8U5NzfZIKkFZuqTQlVrGvgiE0YX7/B8PUXyKrhEOUjSBydjBTfmnLrH8SyOlH1vIpinTZHMrUF3rCw8qxSI59NMlwbrjQtWqysRHBZss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkFPbd16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0AEC433C7;
	Tue, 23 Jan 2024 15:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706022147;
	bh=c55w7bNYVc+/PvGNzvXmIarNgAUxg847kHKA77JNnc0=;
	h=From:To:Cc:Subject:Date:From;
	b=DkFPbd16B7eo+m35zewPwpfGW8OFongXs9gXKgsc5czh3fGnGmNGKjI/CQGOeQ2Re
	 jCLea4BNT6AHbNFPilYwcfTvFYLswvelMQ56KeRZU8ukGee/n2ggQWhnZgFtPkEmbt
	 g1qTFagY7GhwHbYDoFH6LQ/e2v9UTJV4fW+thUlKh5u3KnT0aINbHJ+SSImjYrGZdL
	 SAYzQVwT/bKsAH3JO+vLeH9bIELLNM2znN5PeNk/UfO/6snR2riciBc4qlIgcJQpYr
	 g/6BgYxUx8njeLBVRgchNDpKi+Y3HXdcyfZZc2CPJBipIqaUIbhKNvuCgm3szHawzg
	 3PdMLdG8QWaYw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] tracing/probes: Fix probe event argument parser
Date: Wed, 24 Jan 2024 00:02:23 +0900
Message-Id: <170602214309.215583.16731124846112910621.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

These fix two bugs in the trace probe event argument parser, which I
found while I'm cleaning up the code.

One is just adding an error message to message log buffer (but it is
important to check the reason). Another is setting the size of argument
entry correctly with argument data updated by BTF.

Thank you,

---

Masami Hiramatsu (Google) (2):
      tracing/probes: Fix to show a parse error for bad type for $comm
      tracing/probes: Fix to set arg size and fmt after setting type from BTF


 kernel/trace/trace_probe.c |   32 ++++++++++++++++++--------------
 kernel/trace/trace_probe.h |    3 ++-
 2 files changed, 20 insertions(+), 15 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

