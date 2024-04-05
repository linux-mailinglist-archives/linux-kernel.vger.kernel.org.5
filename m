Return-Path: <linux-kernel+bounces-133586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B57689A601
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E723282B82
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44196175569;
	Fri,  5 Apr 2024 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WalGlqB6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862AC17554B;
	Fri,  5 Apr 2024 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351883; cv=none; b=hbkwJqbIDi7o7kVtj6TZ+pAFZv5JGAO9CWqcdHjsnJZUf0Jo8bqJ8SIC+PeZAYTZHsf8XGqcBK2lr9lUr2Rfcnzax2onmkdt2LpuoF0BXlaE0jaxf8V/Pm4kBscU6Ujup0xt0lSVWEtcbcXU4IJdShOp8W1wwRzWiHdNn5v/LUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351883; c=relaxed/simple;
	bh=Wot6ma/gg8ednN0U6RXz9Cy+ni+Dlc7ehc3kD04ODV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsNbAImwiKzZyhDH8YjCeT8euXjOpSCfKjQJHa6ehzqClo+LHhjffyI49TnBi7KKivdYOKq7uAEtgQ/VxY94q854L7eptd8ajvYmgRniZvTDdYomFGrQR8tHi4Rz8xsFITZt/SZ9lEGpoWc+PhXUJxkA0+QSAaQI4fXfx5FGj/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WalGlqB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A51C43390;
	Fri,  5 Apr 2024 21:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712351883;
	bh=Wot6ma/gg8ednN0U6RXz9Cy+ni+Dlc7ehc3kD04ODV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WalGlqB6KhBW5HQq5Gs95gX4YgYlz4gAZaqKDMKP+d016xOF0C+h0bDa27/EXQc/I
	 arneBPLdXwQ5YYi/ks4Y/qqIlr+HQEnCpJaY4ir7KtMX/uUrp4d4jlWwLBl5JYZg6H
	 3YUGCxuOlEzpdXM8f9WkdQqivsyxtCFVb2W4sYi0DI3Ik9mVRa2PlMwuPmL/0ExjqG
	 gBkehcbpcqMYML/S7nqS40DV9VPn4Y0Cy9BgqPyi+9XtdSSNRAP3HKmJplFnyqfQ5U
	 /Gv7FChhsLR/0Pn9rVV/CY7Cu/b9YkNCg6ravtKWEzrScZu9NlIAzaE9EIpdETDeqo
	 mGxQ/ISSaimcg==
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
Subject: [PATCH 2/4] perf annotate-data: Fix global variable lookup
Date: Fri,  5 Apr 2024 14:17:58 -0700
Message-ID: <20240405211800.1412920-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240405211800.1412920-1-namhyung@kernel.org>
References: <20240405211800.1412920-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent change in the global variable handling added a bug to miss
setting the return value even if it found a data type.  Also add the
type name in the debug message.

Fixes: 1ebb5e17ef21 ("perf annotate-data: Add get_global_var_type()")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 043d80791bd0..1047ea9d578c 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1468,8 +1468,10 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 					&offset, type_die)) {
 			dloc->type_offset = offset;
 
-			pr_debug_dtp("found PC-rel by addr=%#"PRIx64" offset=%#x\n",
+			pr_debug_dtp("found PC-rel by addr=%#"PRIx64" offset=%#x",
 				     dloc->var_addr, offset);
+			pr_debug_type_name(type_die, TSR_KIND_TYPE);
+			ret = 0;
 			goto out;
 		}
 	}
-- 
2.44.0.478.gd926399ef9-goog


