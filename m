Return-Path: <linux-kernel+bounces-63291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC62852D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719791C23322
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2196136AE4;
	Tue, 13 Feb 2024 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8BmoHJO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5722A3613A;
	Tue, 13 Feb 2024 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818365; cv=none; b=NFLbc0k7XTsRIYJ0wCATwhj2iVo/1wnb/gTUXNen2MQb+6veDKe+gWyuUJf07a6V8YlRkQVFEgsxKrWyVDWyNSeUT1MTSl1IFLUedK9uZ1T0QlDCUtphAJMIMcp/TemkvEbdYtubDbYr8ZWPZFuOCQuElS3x7FoWdypNJByqZ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818365; c=relaxed/simple;
	bh=UNaT/TcOOYKTpTEIwTZQopiZeqe91jixzxP3/uh8vag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GP4zIPLNjTLwcU7wib1igCEiAr7WP+/QVhvLfuofuvP8+h9uN01jA+5W2yjEJweO603WyAwfrQgeT9Q84E7jB2ujX5UIUXWN0dmFB6NBPlIFSL5SMH6R8V6ZDlWif/USXpl1+xSc8BnXtSShuyrm5+adFc4WN2SQvg5aYzLVf3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8BmoHJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A4CC433C7;
	Tue, 13 Feb 2024 09:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707818364;
	bh=UNaT/TcOOYKTpTEIwTZQopiZeqe91jixzxP3/uh8vag=;
	h=From:To:Cc:Subject:Date:From;
	b=P8BmoHJOB+QEfz31J05kpFoB7sp1M81dAD0VI+fCLeuU4u7JwYZu4z/Lo8dFZuj4L
	 YeF8Uj8nMqakhnaHLSZXdBrNXg+brjp5MgjwL3QsI5pjBlbyy1Ctw58pJvRP9h1Par
	 g8rEI9q8Kc0tDQOeJsoBbtKghIYWMpWsDPDYPHsZl2XBrfT81BoLsSXaAfAPgH2UNP
	 JOIzRErOZ9PI5qX5OmOYmV57JZnHNAUuK+p4XerQLkaXU20jwHziCCI3ndJfr3tCHn
	 hjNDHIA7dSQpLCoW5V91D6GLDAyXA9tbM4U+kKMGHqSftd+Aj0z95LfY67kGk2mwOo
	 IewacrGqVADfQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Denis Efremov <efremov@linux.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] floppy: fix function pointer cast warnings
Date: Tue, 13 Feb 2024 10:59:07 +0100
Message-Id: <20240213095918.455478-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-16 complains about a control flow integrity (kcfi) violation
casting between incompatible pointers:

drivers/block/floppy.c:2001:11: error: cast from 'void (*)(void)' to 'done_f' (aka 'void (*)(int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
 2001 |         .done           = (done_f)empty
      |                           ^~~~~~~~~~~~~

Just add another empty function with the correct prototype as a
workaround.

The warning is for code that was added before the start of the normal
git history, but I tracked it done to an early change in the reconstructed
linux-history.git.

Fixes: 598a477afe06 ("Import 1.1.41")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/floppy.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index d0e41d52d6a9..2ba0ba135951 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -530,14 +530,13 @@ static struct format_descr format_req;
 static char *floppy_track_buffer;
 static int max_buffer_sectors;
 
-typedef void (*done_f)(int);
 static const struct cont_t {
 	void (*interrupt)(void);
 				/* this is called after the interrupt of the
 				 * main command */
 	void (*redo)(void);	/* this is called to retry the operation */
 	void (*error)(void);	/* this is called to tally an error */
-	done_f done;		/* this is called to say if the operation has
+	void (*done)(int);	/* this is called to say if the operation has
 				 * succeeded/failed */
 } *cont;
 
@@ -985,6 +984,10 @@ static void empty(void)
 {
 }
 
+static void empty_done(int result)
+{
+}
+
 static void (*floppy_work_fn)(void);
 
 static void floppy_work_workfn(struct work_struct *work)
@@ -1998,14 +2001,14 @@ static const struct cont_t wakeup_cont = {
 	.interrupt	= empty,
 	.redo		= do_wakeup,
 	.error		= empty,
-	.done		= (done_f)empty
+	.done		= empty_done,
 };
 
 static const struct cont_t intr_cont = {
 	.interrupt	= empty,
 	.redo		= process_fd_request,
 	.error		= empty,
-	.done		= (done_f)empty
+	.done		= empty_done,
 };
 
 /* schedules handler, waiting for completion. May be interrupted, will then
-- 
2.39.2


