Return-Path: <linux-kernel+bounces-73707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE9185C670
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BC4283410
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99512151CC9;
	Tue, 20 Feb 2024 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="kULFM7iA"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF04151CD9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462868; cv=none; b=V+QFBO8ftg0sszpcQftnqTIB6fnVui25XOuFtG6oDSrBrqtstXN7U1rbnzIHaW2YVFpVuDOR5csdcntwGU9DW4c4R9OKGZjElUWajvIzK7AfkHzjcdY3oA9e5TefjFdj0hfeZXjFhOb9DvQ+N2J1EY01tCJx7i8CqgbQK5IJ4B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462868; c=relaxed/simple;
	bh=c8mj9GCK/VYC0uTtjPPbxdw6XzLVLtkaxBhdmNk2hx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UVYLt1KvwQf4LdkeTAIq0zmhUwHATH1rdpyu+207qIoEOCyMJ/wUUEK9YeqSBuwC8t5JON/x6nWVLtvqVjsEocQG2QKLsCeIiZADKv9L/pixf+9VazBM61/31HuLb8rVQzhykEvl0ZKchkJpCqg4FR64gPEnN5HzIDqavH9TlvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=kULFM7iA; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d36736d4eso2191435f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1708462865; x=1709067665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6cMX9apdIMaiuiffRRE+pqVp7mvVIBBBOysSz9lAvD8=;
        b=kULFM7iAaG3sISLY0+J6vPgniCsaexY7zQoSOY4D5mh3xTOqrabo/SoSnvz43abtMM
         9ZY4VhCp/uojmc6WPRXizRTkRzhUgJl1fHhY9Of5Z3LP0+Clxf4xH+p0iZVpsd8Q5KF0
         uvZUmiW0khDRiObV/qZNpwHuklnqEjRcD5FNyIygPmQ5xTXdfw8ZDdNolpa1AuJ3UbmZ
         j3zGUQPyPZxeK1XWwR6hKFVjw4dmcYGYHWNS3thgkNixnvcCLCJgA1BSUc1qZiz1co8c
         FWDLDurOwS/TvUqN35RreyfREkCRPZHiXOajYYdvg3UCSIBC34JZoR8M0hC6wTVd2j7i
         3NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708462865; x=1709067665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6cMX9apdIMaiuiffRRE+pqVp7mvVIBBBOysSz9lAvD8=;
        b=eWSFUJUukf7bnW4/A8awBfKBESMZDkjPC3sNAUTGz0WEX6PhHN6YeVqHpXn0k2yIh/
         drx86lh0ezlm6bcZI7WxWooD0Tuu+7Chyuu0pdkLsMvjDQIOakD46NJ766SoLsDiepI+
         TEanCUI2+GUVBaJ5v9zov2hCvnB16m+fT1foh0wetqu70a2NCuet9x9iPn7X9wzsY6gC
         mztMqymueOxQBxXmkRCf+fcvzJwU0y6msiV8ulHk5iQ8jGyC34+9eIoFLKZvBBcTDuTP
         HgZTUc/gtWTVcfscf8NBk3cnoRxCKlSWcUNh8gkLOyimCFvUBLJOgoOSjqaqimt88k+0
         2ryA==
X-Forwarded-Encrypted: i=1; AJvYcCXsno/sfz66M3ZwyhHV4Cp+NdujFNM6nGXuUSV264B8n6AJSEg2ORwbKu2vPnjDItRPbCjqqKa4gDXzWxfIAawrVktheCpE/GLz5MQi
X-Gm-Message-State: AOJu0YxtJo3Pb1Qi0PSHC6kedcjQVqhsKC+GFjNSLdOx67l7LGRmSG0w
	2wFk8UJ2mfo7fEp9Sm1GczQHgFCvdHTmjZD1EQjdXRGPbTiwPBdVXrLMsGirPA==
X-Google-Smtp-Source: AGHT+IErgWlxbM4BdSaWIPsAX1uxLZhgjdIUFq/bEci8UGzh3k8U7ttlHkzOJNEl3ibxUM/AJLvC5w==
X-Received: by 2002:adf:e548:0:b0:33d:26b1:c460 with SMTP id z8-20020adfe548000000b0033d26b1c460mr6979790wrm.39.1708462865208;
        Tue, 20 Feb 2024 13:01:05 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id ba1-20020a0560001c0100b0033d67bdce97sm3692599wrb.84.2024.02.20.13.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 13:01:04 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Dmitry Safonov <dima@arista.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH] Documentation/ftrace: Correct wording on trace_options sharing
Date: Tue, 20 Feb 2024 21:00:57 +0000
Message-ID: <20240220-ftrace-options-docs-v1-1-95448f535056@arista.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708462857; l=2812; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=c8mj9GCK/VYC0uTtjPPbxdw6XzLVLtkaxBhdmNk2hx0=; b=jXhDaX0neWOtUA+vokXv020wbVW5s7v4qUlz41JpacdByfyFhRhNBHxMSe2s1zii1Go3naEX6 fhLzBLV4kQZAv/CbQHlq6GNX0AzuUqNLt8NlxPhwJ78mYBzRKhH41I/
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

I'm writing just another net selftest, where I'm planning to check
tcp-ao tracepoints. As I want the test to clean up after itself and
affect other possible tests as little as possible, I'm creating an
ftrace instance with event filters. In order to simplify, going to
disable most of trace_options I don't need. And the current wording
made me think it's not possible to set per-instance trace_options.
And trying that in practice contradicted the documentation:

> # echo 1 > events/signal/enable
> # cd -
> /root/ksft-ftrace-4Py39Z/instances/ksft
> # echo 1 > events/signal/enable
> # cat trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 6/6   #P:2
> #
> #           TASK-PID     CPU#     TIMESTAMP  FUNCTION
> #              | |         |         |         |
>              cat-7568    [000]  491748.118710: signal_generate: sig=17 errno=0 code=1 comm=bash pid=6189 grp=1 res=0
>             bash-6189    [001]  491748.119003: signal_deliver: sig=17 errno=0 code=1 sa_handler=55c728d3bce0 sa_flags=14000000
> # cd -
> /root/ksft-ftrace-4Py39Z/instances/ppp
> # cat trace
> # tracer: nop
> #
> JZÊ<¿type: 154
> f>ï>¿type: 154
> -¸ó>¿type: 153
> vW.A?¿type: 154

It seems that since commit 16270145ce6b ("tracing: Add trace options for
core options to instances") it is possible to set per-instance
trace_options, with an exception to three of them.

Document the current state of affairs.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 Documentation/trace/ftrace.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 7e7b8ec17934..c79a6bcef3c9 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -3603,9 +3603,9 @@ The files in the new directory work just like the files with the
 same name in the tracing directory except the buffer that is used
 is a separate and new buffer. The files affect that buffer but do not
 affect the main buffer with the exception of trace_options. Currently,
-the trace_options affect all instances and the top level buffer
-the same, but this may change in future releases. That is, options
-may become specific to the instance they reside in.
+most of the options are specific to the instance they reside in, but
+trace_printk, printk-msg-only and record-cmd are affecting all instances
+and the top level buffer, but this may change in future releases.
 
 Notice that none of the function tracer files are there, nor is
 current_tracer and available_tracers. This is because the buffers

---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240220-ftrace-options-docs-81ecf05d07e4

Best regards,
-- 
Dmitry Safonov <dima@arista.com>


