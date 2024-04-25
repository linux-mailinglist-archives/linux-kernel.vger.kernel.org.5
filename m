Return-Path: <linux-kernel+bounces-157891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE558B1830
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F761C24105
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2F8AD49;
	Thu, 25 Apr 2024 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwhqtkYT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C060D4C7B;
	Thu, 25 Apr 2024 00:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714006318; cv=none; b=tQAs8bktxQqRTMw+YrwW22NWkAWfOWZ4ZN8TUWURMY4oENCemrTv6n8+EKhk93Op7ySK4vj4kIpkSB1HjfJPnkE9H/f0/K7OqFYuJbxGLpox0gR/a7oTJde7wd4dvRtJ/fTBdbcQOOxQ9ga2gjOx+80efF4EVMZiN5ocW6/NJhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714006318; c=relaxed/simple;
	bh=46mCUHG3XUnFa6d7tBAIJFcTt/fWfv/oNt7QX7k73LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUjUySJOQI5axom585lMj7Abj6D4om+Xk6DkoZLSFz+7qjJG4TMm48CeJfPsA4RHMO0qvf3P31LBI4Qm5srF459t+8misHTlZ5us2ZPWmkzcmUOmoV2RBjXCk0eVAywwC8wCjHx9R6dfM1spMaMO07IkwJFWJfQEYY5RT8Wywyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwhqtkYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4375DC32782;
	Thu, 25 Apr 2024 00:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714006318;
	bh=46mCUHG3XUnFa6d7tBAIJFcTt/fWfv/oNt7QX7k73LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZwhqtkYTiRSahlNP2D07Y1XWzeGXNos4PpGa+PxDJfLjtMaYAum7L+UxvtbpF/uXO
	 rknaQpufh6ML83UzZ/AD0aeGWAhQbNdo3W/h6HXQ/BonexWKko9ULzMOou3QEr4RqD
	 u6VlKmnC83gx5lktDkXjjloC3B1VePuIkROcHGdhdkuGD4bi6qUi9QQI9bd/QWuUaU
	 hK2TH+6cSqJ/hFgCKfDXbSFXzchUD2Jrx5t4cJYJe5WCciUD7n+j3ket5IN37TKTc+
	 BO+KZXsDTGF3tMcBe3SvdzSIzIueWfxTIqKI4hC3M7tzcSx29J91MxO5hG8Ki7wq+C
	 qEluc2iFVA35g==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/2] perf annotate: Update dso binary type when try build-id
Date: Wed, 24 Apr 2024 17:51:57 -0700
Message-ID: <20240425005157.1104789-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240425005157.1104789-1-namhyung@kernel.org>
References: <20240425005157.1104789-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dso__disassemble_filename() tries to get the filename for objdump (or
capstone) using build-id.  But I found sometimes it didn't disassemble
some functions.  It turned out that those functions belong to a dso
which has no binary type set.  It seems it sets the binary type for some
special files only - like kernel (kallsyms or kcore) or BPF images.  And
there's a logic to skip dso with DSO_BINARY_TYPE__NOT_FOUND.

As it's checked the build-id cache linke, it should set the binary type
as DSO_BINARY_TYPE__BUILD_ID_CACHE.

Fixes: 873a83731f1c ("perf annotate: Skip DSOs not found")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/disasm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 412101f2cf2a..6d1125e687b7 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1156,6 +1156,8 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 			}
 		}
 		mutex_unlock(&dso->lock);
+	} else if (dso->binary_type == DSO_BINARY_TYPE__NOT_FOUND) {
+		dso->binary_type = DSO_BINARY_TYPE__BUILD_ID_CACHE;
 	}
 
 	free(build_id_path);
-- 
2.44.0.769.g3c40516874-goog


