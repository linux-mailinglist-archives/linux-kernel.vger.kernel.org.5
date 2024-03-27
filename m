Return-Path: <linux-kernel+bounces-120399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F44888D6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E7D29EBE7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DD323754;
	Wed, 27 Mar 2024 06:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O4hLODQO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2271757E;
	Wed, 27 Mar 2024 06:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711522214; cv=none; b=UaUs2M3kbaNKy4y4p8Rl+LfgE0CiiyKuMtjiLVXWlW7I7AwIMn+F/0vhAZgSXb+uo2fkJgCUAachUeJZPNaXLRUEgUjJHOfAA0zhjPj0MlnKF7qj+fXmXlgf0/16UHChYwXY6GKHzFGdzMPJkbk5XSCLUiLiOdmlYwGdTrPeZ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711522214; c=relaxed/simple;
	bh=LCLR8DCIhO+h2T1EqlttdiL6XG1WU1sQmApsETK0Fko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FZiN+I8n3sOh/lPu/f2tPiWpdfGj8A8A+SvwoDskHlyzpr2xXF+EMnPJwhN+5n1tbxf19qbHIdEHoqc/1D3NbPX5OIAY8Klc+o//N00lejyHM3gBEXHB0209gPPlDoAMD/HAhHneZtVg9d7JKfyWvoBGEASypqbOTnSvqZqD800=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O4hLODQO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711522214; x=1743058214;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LCLR8DCIhO+h2T1EqlttdiL6XG1WU1sQmApsETK0Fko=;
  b=O4hLODQOsn1ckXJVcWOyWcjhhs9ZQf0DpiU8MS7Q1r6THNbT51lgOste
   63ofrYE62OPIx0XAytpEC1acZhgtjaTHsfMux3nqmqoaCGLITb6FVBWfb
   EVtn27Bw5amNhLjOnc8YsExLhfFPamhdtG7IxPqY+YCmrl4ZRe6GHiiMm
   7wznay0v8YxAf5ietAO5QGk2UByIA8Bd4YEQ/XSrkHaIRjC4cS0jEEjB8
   lWnN4H6c81ImYl+G/3Gk7xE5QAePAZJuAQKZ9t+McTz7CG5RSJ9bVVg+A
   yYEye0Lxj7qk/VLXg/7eUqhLfurCYh6YjJFXNSUrmGFjPndjPtjqVlF6U
   A==;
X-CSE-ConnectionGUID: d3g1Gd4nToeNNuqiqkpB8A==
X-CSE-MsgGUID: CI0p6WYPQFqiru7JlISKuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6736235"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="6736235"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 23:50:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="16578237"
Received: from dcai-bmc-sherry-1.sh.intel.com ([10.239.138.57])
  by orviesa007.jf.intel.com with ESMTP; 26 Mar 2024 23:50:09 -0700
From: Haiyue Wang <haiyue.wang@intel.com>
To: bpf@vger.kernel.org
Cc: Haiyue Wang <haiyue.wang@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1] bpf,arena: Use helper sizeof_field in struct accessors
Date: Wed, 27 Mar 2024 14:53:29 +0800
Message-ID: <20240327065334.8140-1-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the well defined helper sizeof_field() to calculate the size of a
struct member, instead of doing custom calculations.

Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
---
 kernel/bpf/arena.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 86571e760dd6..af5cae640669 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -37,7 +37,7 @@
  */
 
 /* number of bytes addressable by LDX/STX insn with 16-bit 'off' field */
-#define GUARD_SZ (1ull << sizeof(((struct bpf_insn *)0)->off) * 8)
+#define GUARD_SZ (1ull << sizeof_field(struct bpf_insn, off) * 8)
 #define KERN_VM_SZ ((1ull << 32) + GUARD_SZ)
 
 struct bpf_arena {
-- 
2.43.2


