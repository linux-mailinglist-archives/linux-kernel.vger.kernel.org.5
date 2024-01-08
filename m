Return-Path: <linux-kernel+bounces-19231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B41826A0D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CBC1F24B83
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C9812B94;
	Mon,  8 Jan 2024 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Y+cn/bo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XqA4yX00"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D4912B71;
	Mon,  8 Jan 2024 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Jan 2024 09:01:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704704464;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dyxas6APHfzo9ugShPXhkzsrATg+NmwaWDa+0Gt9Lvs=;
	b=1Y+cn/boN8dLNVv6zEVb2/BLwzKX1Ba441831wXTIv14c7UPHuYm/fEWS2ZSZiaCRyPAyY
	99uSvUWOLLyMXjk4TF0R0fImIXgZeBjMmhMjN6FYx5ak+KYXKlSmYhLmrZ1MofCBais9k6
	CTAEhFj6wMUFbqK/AWuZIk3OTsyYX1W25+D522YISeNkWr56Y+aSyS9yjVSVbeDSZNhBi9
	YEh4XW+8SIqgM88WP0ayK2trl8dZNBVH0e17lKhZ/HyquJm5NlvuafwwIRluBU+Bs+3Y+D
	qX+oBZkPK3mc1dFydIhytme7FOKrmxusEDYO0L7+EHnDcTCLgsHRW30gg+3CCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704704464;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dyxas6APHfzo9ugShPXhkzsrATg+NmwaWDa+0Gt9Lvs=;
	b=XqA4yX00ob9xNMGUC5ctqwURGJ0GqxO2lRTH8ia/9KRYTTT7bsxPIbZg5CxT3qoVp6W7Z4
	frG4HssbHuKuj1CA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/mutex: Clarify that mutex_unlock(), and
 most other sleeping locks, can still use the lock object after it's unlocked
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Jann Horn <jannh@google.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231201121808.GL3818@noisy.programming.kicks-ass.net>
References: <20231201121808.GL3818@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170470446336.398.8996133670425061216.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2b9d9e0a9ba0e24cb9c78336481f0ed8b2bc1ff2
Gitweb:        https://git.kernel.org/tip/2b9d9e0a9ba0e24cb9c78336481f0ed8b2bc1ff2
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 08 Jan 2024 09:31:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 08 Jan 2024 09:55:31 +01:00

locking/mutex: Clarify that mutex_unlock(), and most other sleeping locks, can still use the lock object after it's unlocked

Clarify the mutex lock lifetime rules a bit more.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231201121808.GL3818@noisy.programming.kicks-ass.net
---
 Documentation/locking/mutex-design.rst | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/locking/mutex-design.rst b/Documentation/locking/mutex-design.rst
index 7572339..7c30b4a 100644
--- a/Documentation/locking/mutex-design.rst
+++ b/Documentation/locking/mutex-design.rst
@@ -101,12 +101,24 @@ features that make lock debugging easier and faster:
     - Detects multi-task circular deadlocks and prints out all affected
       locks and tasks (and only those tasks).
 
-Releasing a mutex is not an atomic operation: Once a mutex release operation
-has begun, another context may be able to acquire the mutex before the release
-operation has fully completed. The mutex user must ensure that the mutex is not
-destroyed while a release operation is still in progress - in other words,
-callers of mutex_unlock() must ensure that the mutex stays alive until
-mutex_unlock() has returned.
+Mutexes - and most other sleeping locks like rwsems - do not provide an
+implicit reference for the memory they occupy, which reference is released
+with mutex_unlock().
+
+[ This is in contrast with spin_unlock() [or completion_done()], which
+  APIs can be used to guarantee that the memory is not touched by the
+  lock implementation after spin_unlock()/completion_done() releases
+  the lock. ]
+
+mutex_unlock() may access the mutex structure even after it has internally
+released the lock already - so it's not safe for another context to
+acquire the mutex and assume that the mutex_unlock() context is not using
+the structure anymore.
+
+The mutex user must ensure that the mutex is not destroyed while a
+release operation is still in progress - in other words, callers of
+mutex_unlock() must ensure that the mutex stays alive until mutex_unlock()
+has returned.
 
 Interfaces
 ----------

