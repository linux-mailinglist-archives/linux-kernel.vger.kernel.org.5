Return-Path: <linux-kernel+bounces-120279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A3588D542
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41471C24E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E018B22F02;
	Wed, 27 Mar 2024 03:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Td97G1VF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB6C20B12
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711511862; cv=none; b=G4bPhJ8Y0jrD43LhV7gTTzX+Cn85vVNIoIokYdibcRI24h416Vz+k2/hJ6pdW/Ur9CfkwNNQwtbxWkRs58DOwqJ/4ntLb9Cw/xjU+GyC47RDrJIqvaUmgttLtMx9DQk8nODaNV9RJ7vZUbByECHTCTwu3QsazzX/u56x2opvQjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711511862; c=relaxed/simple;
	bh=9fQi5KXC0s6xQpQ1ecKNpw52GlrQLRFLup+PRGXrjPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cv3qrgRzpO5oHumi66FN+b3cIuY8i3UqYqECIlk33cD6Il8qUxDRI28AQ292auTmsHLtKTq9YnpWP2+4+eOS6MvnAGQFdhGmvHCK+9k/VxGSc4fxfvlfGOcjzPtnPfyyXrEZBFlRrA9lqJuopr1mFUrgRusCZ+vun0GiwkyZYu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Td97G1VF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6D9C433C7;
	Wed, 27 Mar 2024 03:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711511861;
	bh=9fQi5KXC0s6xQpQ1ecKNpw52GlrQLRFLup+PRGXrjPU=;
	h=From:To:Cc:Subject:Date:From;
	b=Td97G1VFycCA7eUcS1LejZ+9q6zyT2RquwALup5MBn3ZhdrYaCE/rX/UKrpVkkyTq
	 XcnWFcroIrUQHsrS4cQvMauW65g+cOB9O0rDx7ANIoDe9Ry1jH2WdG7C8IyohSwjtJ
	 deacWaJkR0FWKuP+fxfAdPeVsr+SXGDqiaCglg8RjHn6FbqH//aM+DgwKxoZoxM9CZ
	 xQEhHW1f4uf4JN91F2SZK+pZ+c766Y5Im9r9002wL86trGok+penThBm+Hw/0O1wtO
	 rc882Nyctp2pULv+ktgwdygALOcideWqKcoZGs9OJ5WC5aayYWiaDEiZIqDHEjk1E0
	 GrV2iHK6vPQDA==
From: alexs@kernel.org
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org (open list)
Cc: linux-kernel@vger.kernel.org,
	"Alex Shi (tencent)" <alexs@kernel.org>
Subject: [PATCH v2 1/2] objtool: remove unused file argument for init_insn_state
Date: Wed, 27 Mar 2024 12:00:46 +0800
Message-ID: <20240327040047.478695-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

Remove unused file parameter from init_insn_state(). to save a bit code
text.

Signed-off-by: Alex Shi <alexs@kernel.org>
To: linux-kernel@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 548ec3cd7c00..88ac3e2be2bd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -274,8 +274,7 @@ static void init_cfi_state(struct cfi_state *cfi)
 	cfi->drap_offset = -1;
 }
 
-static void init_insn_state(struct objtool_file *file, struct insn_state *state,
-			    struct section *sec)
+static void init_insn_state(struct insn_state *state, struct section *sec)
 {
 	memset(state, 0, sizeof(*state));
 	init_cfi_state(&state->cfi);
@@ -3814,7 +3813,7 @@ static int validate_unwind_hints(struct objtool_file *file, struct section *sec)
 	if (!file->hints)
 		return 0;
 
-	init_insn_state(file, &state, sec);
+	init_insn_state(&state, sec);
 
 	if (sec) {
 		sec_for_each_insn(file, sec, insn)
@@ -4221,7 +4220,7 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 		if (func->type != STT_FUNC)
 			continue;
 
-		init_insn_state(file, &state, sec);
+		init_insn_state(&state, sec);
 		set_func_state(&state.cfi);
 
 		warnings += validate_symbol(file, sec, func, &state);
-- 
2.43.0


