Return-Path: <linux-kernel+bounces-99539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F398789BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905BF281CCA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987FA56B6B;
	Mon, 11 Mar 2024 20:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBmyi/Im"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95B56B62
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710190482; cv=none; b=e+vbzOM7wXnUqB36nasniFU9NyUmHjiaRERU8eVOV0fb/Vsgai9BvhtxE+qTwiqZlBJoB4iNR/NcGRY0f7gjcioG4+vEg/vvwioxhOs8e06KOZzXzfh0V2udUdCQxLxVBaL1/PA/ZPUtmE66bAowe5aGS3sQPjOmC2ln4K1qqhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710190482; c=relaxed/simple;
	bh=YU11Yyx/GV6+raNPxgvVUEPSsQhbFePARTHkUxpcNsE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oyG6Q/eHZDUvhs9wcPAmGqoacc3RljrlUR89/uGG9URxAW7ru+qYJFrR+la7XBpUlyRWJD7IPVhFMXUGN7VNjNuljNG5BknwGvcBTVOrY2vB0whj7TEAwYO4EhEJtwsrkSZZoyWirHh3//tvfslU30h0mNKINFykBFuNkmDHSs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBmyi/Im; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E694AC433F1;
	Mon, 11 Mar 2024 20:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710190482;
	bh=YU11Yyx/GV6+raNPxgvVUEPSsQhbFePARTHkUxpcNsE=;
	h=Date:From:To:Cc:Subject:From;
	b=CBmyi/Imfeir8BtV7AWkfXFU856FtxiFcUvcoKgQRcNpQ6U470d+bj0RDtCiBGtpB
	 yCfgwXfh61EDd76cfaQ2zP8ttQKKHsEYrx35cnf9ugVWHHs05aJs6VVqKiScuKkg4Y
	 irCTxzuKWEFnH2pNlg5sYGNlx99a4MktZuVJej4ujRC+J3yn/KO3Tjsetv2OXvNvg3
	 WkZFZvfeLxTVe4vHBNdh2LnG8YIO4JqkIKWfUH0CpHgmg6O5Rc/cBaFxUJFODFpwvc
	 y6ix9T4OGysVLjdzyg1BC+IaDRJGFLldiftqOPvK492dz0i7q/hmUqHq+t2YvZUHBe
	 XeHco0wr70JXA==
Date: Mon, 11 Mar 2024 17:54:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf beauty: Fix dependency of tables using
 uapi/linux/mount.h
Message-ID: <Ze9vjxv42PN_QGZv@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Several such tables were depending on uapi/linux/fs.h, cut and paste
error when they were introduced, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 04d89d2ed209b4dc..d3a568abc38919e8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -499,19 +499,19 @@ $(fadvise_advice_array): $(linux_uapi_dir)/in.h $(fadvise_advice_tbl)
 fsmount_arrays := $(beauty_outdir)/fsmount_arrays.c
 fsmount_tbls := $(srctree)/tools/perf/trace/beauty/fsmount.sh
 
-$(fsmount_arrays): $(linux_uapi_dir)/fs.h $(fsmount_tbls)
+$(fsmount_arrays): $(linux_uapi_dir)/mount.h $(fsmount_tbls)
 	$(Q)$(SHELL) '$(fsmount_tbls)' $(linux_uapi_dir) > $@
 
 fspick_arrays := $(beauty_outdir)/fspick_arrays.c
 fspick_tbls := $(srctree)/tools/perf/trace/beauty/fspick.sh
 
-$(fspick_arrays): $(linux_uapi_dir)/fs.h $(fspick_tbls)
+$(fspick_arrays): $(linux_uapi_dir)/mount.h $(fspick_tbls)
 	$(Q)$(SHELL) '$(fspick_tbls)' $(linux_uapi_dir) > $@
 
 fsconfig_arrays := $(beauty_outdir)/fsconfig_arrays.c
 fsconfig_tbls := $(srctree)/tools/perf/trace/beauty/fsconfig.sh
 
-$(fsconfig_arrays): $(linux_uapi_dir)/fs.h $(fsconfig_tbls)
+$(fsconfig_arrays): $(linux_uapi_dir)/mount.h $(fsconfig_tbls)
 	$(Q)$(SHELL) '$(fsconfig_tbls)' $(linux_uapi_dir) > $@
 
 pkey_alloc_access_rights_array := $(beauty_outdir)/pkey_alloc_access_rights_array.c
@@ -597,13 +597,13 @@ $(mremap_flags_array): $(linux_uapi_dir)/mman.h $(mremap_flags_tbl)
 mount_flags_array := $(beauty_outdir)/mount_flags_array.c
 mount_flags_tbl := $(srctree)/tools/perf/trace/beauty/mount_flags.sh
 
-$(mount_flags_array): $(linux_uapi_dir)/fs.h $(mount_flags_tbl)
+$(mount_flags_array): $(linux_uapi_dir)/mount.h $(mount_flags_tbl)
 	$(Q)$(SHELL) '$(mount_flags_tbl)' $(linux_uapi_dir) > $@
 
 move_mount_flags_array := $(beauty_outdir)/move_mount_flags_array.c
 move_mount_flags_tbl := $(srctree)/tools/perf/trace/beauty/move_mount_flags.sh
 
-$(move_mount_flags_array): $(linux_uapi_dir)/fs.h $(move_mount_flags_tbl)
+$(move_mount_flags_array): $(linux_uapi_dir)/mount.h $(move_mount_flags_tbl)
 	$(Q)$(SHELL) '$(move_mount_flags_tbl)' $(linux_uapi_dir) > $@
 
 
-- 
2.44.0


