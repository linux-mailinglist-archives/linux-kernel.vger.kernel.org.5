Return-Path: <linux-kernel+bounces-27453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4686082F04A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA28F1F22F90
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634191BDF0;
	Tue, 16 Jan 2024 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAtzXzJY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26211BDE9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2876FC433C7;
	Tue, 16 Jan 2024 14:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705414173;
	bh=4ydtymXMzsDnSOyBPbuJxf3eGPdF/Liehn37NxPYoTE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=dAtzXzJYHwkkkK8DUxueiLhzQeH1jU2Is0q24/ttl42FZ9lUXWeIM+IQEnWHc+CqZ
	 u+uVooH6giGZyMItauJi08jXEnACq+NhmvI+gofV0HdKaZE/Rgz5yvsdXgA12lkkTr
	 oub+SgN7wjsbRbC6SvpI1Iiw2FHsE3Xl9L1/j+FQs49a+olcb45Gq81m/mKBxNf6EE
	 im7201FRi/xLWvQiLkUsQsRXadVOmJeQ47M7BiIE+Quq4Ts9dktMyE7J02JW/xgLO4
	 DRCWNdeIYUGjIjTczowooHMuolzW6Jw2j7FMcYaqL4cT+mttt/pkki3h60ab1M5yzG
	 1fDugXOoIwkCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15634C47077;
	Tue, 16 Jan 2024 14:09:33 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathanl.linux.ibm.com@kernel.org>
Date: Tue, 16 Jan 2024 08:09:25 -0600
Subject: [PATCH] seq_buf: make DECLARE_SEQ_BUF() usable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240116-declare-seq-buf-fix-v1-1-915db4692f32@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIABSOpmUC/x2MSwqAMBDFriKzdqCt4u8q4sLWpw6InxZFEO9uc
 ZlA8lCAFwRqkoc8LgmyrRF0mpCb+3UCyxCZjDK50trwALf0HhxwsD1HHuXmulKZLVGUtXUUy90
 j6v/adu/7ASG0Mc1lAAAA
To: "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
 Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Nathan Lynch <nathanl@linux.ibm.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705414172; l=1460;
 i=nathanl@linux.ibm.com; s=20230817; h=from:subject:message-id;
 bh=PDfnqK8MoD62TWn0JxiINKlWua/4QKsMFHUjf8S4QK8=;
 b=eWY/a5vMbGPcD8FCX6fA+B9jBCt4bD6+x6sOb6OUJ3z+QllNTc0jX2mvpktKNuyyowH9aUyQf
 n2a6Z9L3agPAbh4ONpXhTSYRoowvGZPqb1QzlG1dB0K5BgQmhXJ+HUC
X-Developer-Key: i=nathanl@linux.ibm.com; a=ed25519;
 pk=jPDF44RvT+9DGFOH3NGoIu1xN9dF+82pjdpnKjXfoJ0=
X-Endpoint-Received:
 by B4 Relay for nathanl@linux.ibm.com/20230817 with auth_id=78
X-Original-From: Nathan Lynch <nathanl@linux.ibm.com>
Reply-To: <nathanl@linux.ibm.com>

From: Nathan Lynch <nathanl@linux.ibm.com>

Using the address operator on the array doesn't work:

/include/linux/seq_buf.h:27:27: error: initialization of ‘char *’
  from incompatible pointer type ‘char (*)[128]’
  [-Werror=incompatible-pointer-types]
   27 |                 .buffer = &__ ## NAME ## _buffer,       \
      |                           ^

Apart from fixing that, we can improve DECLARE_SEQ_BUF() by using a
compound literal to define the buffer array without attaching a name
to it. This makes the macro a single statement, allowing constructs
such as:

  static DECLARE_SEQ_BUF(my_seq_buf, MYSB_SIZE);

to work as intended.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
Fixes: dcc4e5728eea ("seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_str()")
---
 include/linux/seq_buf.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 5fb1f12c33f9..c44f4b47b945 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -22,9 +22,8 @@ struct seq_buf {
 };
 
 #define DECLARE_SEQ_BUF(NAME, SIZE)			\
-	char __ ## NAME ## _buffer[SIZE] = "";		\
 	struct seq_buf NAME = {				\
-		.buffer = &__ ## NAME ## _buffer,	\
+		.buffer = (char[SIZE]) { 0 },		\
 		.size = SIZE,				\
 	}
 

---
base-commit: 70d201a40823acba23899342d62bc2644051ad2e
change-id: 20240112-declare-seq-buf-fix-9803b7e679bc

Best regards,
-- 
Nathan Lynch <nathanl@linux.ibm.com>


