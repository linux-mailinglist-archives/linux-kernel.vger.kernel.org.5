Return-Path: <linux-kernel+bounces-165999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CA98B9479
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BFE28415D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FCD42056;
	Thu,  2 May 2024 06:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hs5/Y1gp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A9C36AFE;
	Thu,  2 May 2024 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714629616; cv=none; b=XRQywEQcnbZcTlY+BnwepoJZFxpt6qYd3qDwmI9zhmbn5A9N/nLQRTTwSooIlHHaPmKY6Q/paqEXQDcU5mT0RUt1DQ+YwRpTyjviuZojyhboKeMcXGhwXUBcUa4k6YszaNEOJ7qyWksGMLWM2MMHnZWRnHtVVesU5557Hw5KW+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714629616; c=relaxed/simple;
	bh=wBhNx/ENJ3dtDGzKbOpBhB0k32mIboB/9iNKvY4VhfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cM1Ow5beb7dNMbXmVOtzdWG+ju13aoggIW+wunG7cF2BPdj8ffHdcK7csp/mgs78mNHvm4uhOtj2460/VRhhvmGMsiEoDweV3+SfTugYaqtNyMQs95yr4ngMyv+OtOOiVp4nNQl8/roGzBw/4ehLOGdIDNl1WbjZP/PT0e7iyyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hs5/Y1gp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0E4C4AF51;
	Thu,  2 May 2024 06:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714629615;
	bh=wBhNx/ENJ3dtDGzKbOpBhB0k32mIboB/9iNKvY4VhfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hs5/Y1gpP3uEtaJBKNPkmeW54B0HZW29fmbLYQfgRdTIzAlU7pwW5SYG/ob3egHyH
	 gXmEt7gK/0KqbWJZuWM5FFiglpXX4ajDpzzhlJI976gdpCh8LZGKxYCyu+3qFb53Ah
	 GNCOSziTp/RR80ifewaD9o6rjkLPzZvr0UGYeUVus9lMv5jOSNowvgTwI9WDNgtIL8
	 OfU16zQwbIkxo0WpKdQ/W9axKErlQyoGuinKDK63TOyLLqgQArVx9UOpA8UXqJf1qy
	 bkYuz4uSF9hfUBEjXKd5v0+18n6SQIkMFNaFud5kOXFGx/vk9aKHqQY9Hij/5Zols8
	 KFv90TiSXgUfg==
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
Subject: [PATCH 6/6] perf annotate-data: Check kind of stack variables
Date: Wed,  1 May 2024 23:00:11 -0700
Message-ID: <20240502060011.1838090-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240502060011.1838090-1-namhyung@kernel.org>
References: <20240502060011.1838090-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I sometimes see ("unknown type") in the result and it was because it
didn't check the type of stack variables properly during the instruction
tracking.  The stack can carry constant values (without type info) and
if the target instruction is accessing the stack location, it resulted
in the "unknown type".

Maybe we could pick one of integer types for the constant, but it
doesn't really mean anything useful.  Let's just drop the stack slot if
it doesn't have a valid type info.

Here's an example how it got the unknown type.
Note that 0xffffff48 = -0xb8.
  -----------------------------------------------------------
  find data type for 0xffffff48(reg6) at ...
  CU for ...
  frame base: cfa=0 fbreg=6
  scope: [2/2] (die:11cb97f)
  bb: [37 - 3a]
  var [37] reg15 type='int' size=0x4 (die:0x1180633)
  bb: [40 - 4b]
  mov [40] imm=0x1 -> reg13
  var [45] reg8 type='sigset_t*' size=0x8 (die:0x11a39ee)
  mov [45] imm=0x1 -> reg2                     <---  here reg2 has a constant
  bb: [215 - 237]
  mov [218] reg2 -> -0xb8(stack) constant      <---  and save it to the stack
  mov [225] reg13 -> -0xc4(stack) constant
  call [22f] find_task_by_vgpid
  call [22f] return -> reg0 type='struct task_struct*' size=0x8 (die:0x11881e8)
  bb: [5c8 - 5cf]
  bb: [2fb - 302]
  mov [2fb] -0xc4(stack) -> reg13 constant
  bb: [13b - 14d]
  mov [143] 0xd50(reg3) -> reg5 type='struct task_struct*' size=0x8 (die:0xa31f3c)
  bb: [153 - 153]
  chk [153] reg6 offset=0xffffff48 ok=0 kind=0 fbreg    <--- access here
  found by insn track: 0xffffff48(reg6) type-offset=0
   type='G<EF>^K<F6><AF>U' size=0 (die:0xffffffffffffffff)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 68fe7999f033..2c98813f95cd 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1314,6 +1314,9 @@ static int check_matching_type(struct type_state *state,
 			return -1;
 		}
 
+		if (stack->kind != TSR_KIND_TYPE)
+			return 0;
+
 		*type_die = stack->type;
 		/* Update the type offset from the start of slot */
 		dloc->type_offset -= stack->offset;
@@ -1343,6 +1346,9 @@ static int check_matching_type(struct type_state *state,
 			return -1;
 		}
 
+		if (stack->kind != TSR_KIND_TYPE)
+			return 0;
+
 		*type_die = stack->type;
 		/* Update the type offset from the start of slot */
 		dloc->type_offset -= fboff + stack->offset;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


