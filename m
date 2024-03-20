Return-Path: <linux-kernel+bounces-109032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAED8813B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7507B1F2373E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22AD495CB;
	Wed, 20 Mar 2024 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzvDEUdO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23472481DD;
	Wed, 20 Mar 2024 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710946447; cv=none; b=S7rncgvQE65U/4x/cYz7c9GBwuLI6LKMgeeGET9Anbc3nhlY8SLKBwQel830YBvhTZwnQzxgxgDnHL7Dib/ngERs+utRhAZD4K1oSEOzFOXafns9zaGtfxpFFtnal+Pds8/QHc/h15xHbeeUKIge0Ek8EaE+ekLOTLV+JuaTqTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710946447; c=relaxed/simple;
	bh=loyUyYPPgYDAM4zA8eNu7gfFV9TKe1TcyUwp2cBWpKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BXxcWeiaMnPvBtYDAVlLvbmQO4rhAT9l56d7Ku3m7S6DxgzP0K43A5gPY5SsdioWqvjOdlpFNZ+S/U4pin9uvEjFe3Kop4dsxKmyhq70xlpjDh2KH3zhRZ4TyVRiA8eT5XsFjIkCIMHRfLE7CYjXfUtYSx7YmkFgLR8hcYLGC6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzvDEUdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAC1C433C7;
	Wed, 20 Mar 2024 14:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710946446;
	bh=loyUyYPPgYDAM4zA8eNu7gfFV9TKe1TcyUwp2cBWpKw=;
	h=From:To:Cc:Subject:Date:From;
	b=RzvDEUdO+EOD2lFahaSQ4wKCF/jQQcyZT+FQ9V2lNPKMfmC3fjh4MPffwL4bX/JW4
	 sUvLwUfsG55Iymz/sN/Zs+kWS1vXFBdCZaZhtYF4ON2JzWd6iTU0orBE6abjg0gAXX
	 UwqgEcd+cDtnp/68KxTitIPU+fUekXhmVd/jwzjCs9CQqodq891TX5WzEs/XqWPeu3
	 1tn82oGU5s5TSP/B0yCJVipY/DBLoA64OjYCI21XqphSE4mSUpOwsuul9YQ+3BVT+P
	 xeoZjeTwlkKQNYzWpTD76DwPZYP0jvr5S4wckpQN8suSI8B7hN18FvMmp4U7lAUrdr
	 qukbpJ/+jbnUA==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [GIT PULL V2] tracing/tools: Updates for 6.9
Date: Wed, 20 Mar 2024 15:54:00 +0100
Message-ID: <20240320145402.650357-1-bristot@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Steven,

[
   I rebased my queue on top of the v6.8 tag.
]

Tracing:
        - Update makefiles for latency-collector and RTLA,
          using tools/build/ makefiles like perf does, inheriting
          its benefits. For example, having a proper way to
          handle dependencies.

        - The timerlat tracer has an interface for any tool to use.
          rtla timerlat tool uses this interface dispatching its
          own threads as workload. But, rtla timerlat could also be
          used for any other process. So, add 'rtla timerlat -U'
          option, allowing the timerlat tool to measure the latency of
          any task using the timerlat tracer interface.

Verification:
        - Update makefiles for verification/rv, using tools/build/
          makefiles like perf does, inheriting its benefits.
          For example, having a proper way to handle dependencies.


Please pull the latest trace-tools-v6.9-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/bristot/linux.git
trace-tools-v6.9-2

Tag SHA1: e8d5e0f38601c3718874d95db2a0020ab1c454df
Head SHA1: a23c05fd76cf4ad27e0c74f7a93e7b089e94a55c


Daniel Bristot de Oliveira (4):
      tools/tracing: Use tools/build makefiles on latency-collector
      tools/rtla: Use tools/build makefiles to build rtla
      tools/verification: Use tools/build makefiles on rv
      tools/rtla: Add -U/--user-load option to timerlat

----
 .../tools/rtla/common_timerlat_options.rst         |   6 +
 tools/tracing/latency/.gitignore                   |   5 +-
 tools/tracing/latency/Build                        |   1 +
 tools/tracing/latency/Makefile                     | 105 ++++++++--
 tools/tracing/latency/Makefile.config              |  30 +++
 tools/tracing/rtla/.gitignore                      |   7 +-
 tools/tracing/rtla/Build                           |   1 +
 tools/tracing/rtla/Makefile                        | 217 +++++++--------------
 tools/tracing/rtla/Makefile.config                 |  47 +++++
 tools/tracing/rtla/Makefile.rtla                   |  80 ++++++++
 tools/tracing/rtla/Makefile.standalone             |  26 +++
 tools/tracing/rtla/sample/timerlat_load.py         |  74 +++++++
 tools/tracing/rtla/src/Build                       |  11 ++
 tools/tracing/rtla/src/timerlat_hist.c             |  16 +-
 tools/tracing/rtla/src/timerlat_top.c              |  14 +-
 tools/verification/rv/.gitignore                   |   6 +
 tools/verification/rv/Build                        |   1 +
 tools/verification/rv/Makefile                     | 207 +++++++-------------
 tools/verification/rv/Makefile.config              |  47 +++++
 tools/verification/rv/Makefile.rv                  |  51 +++++
 tools/verification/rv/src/Build                    |   4 +
 21 files changed, 650 insertions(+), 306 deletions(-)
 create mode 100644 tools/tracing/latency/Build
 create mode 100644 tools/tracing/latency/Makefile.config
 create mode 100644 tools/tracing/rtla/Build
 create mode 100644 tools/tracing/rtla/Makefile.config
 create mode 100644 tools/tracing/rtla/Makefile.rtla
 create mode 100644 tools/tracing/rtla/Makefile.standalone
 create mode 100644 tools/tracing/rtla/sample/timerlat_load.py
 create mode 100644 tools/tracing/rtla/src/Build
 create mode 100644 tools/verification/rv/.gitignore
 create mode 100644 tools/verification/rv/Build
 create mode 100644 tools/verification/rv/Makefile.config
 create mode 100644 tools/verification/rv/Makefile.rv
 create mode 100644 tools/verification/rv/src/Build
---------------------------

