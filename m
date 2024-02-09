Return-Path: <linux-kernel+bounces-59059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5CE84F0A7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D745A1C22E5C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39BD657C3;
	Fri,  9 Feb 2024 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ip52rqeC"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A45A657AB
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 07:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707462589; cv=none; b=VtZbpjL/bUnnTzOVB/wAQNn0uaer1mL/md3QOyYOhDjQckNH50RM9jwMBF1bnjoqCnQcrkWi72zJduAovJaYSV7+FdfgkfQuNstosF9LEU8qybXkzrUW9y1JLvac/RPj75eAXk26TeuuadKXMIrDlJEax2euKA49z2wJXvSMF/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707462589; c=relaxed/simple;
	bh=Q0X0MIWz596nOjuI5ehDFAtn9dxEZXwNG9nSazvV+8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q6NuWHms3jys0FwfRz6HUcVoadSgGiP/m4mHWDe0x71uxrBLSWsGLDYVexdeVzsSxSG/Dgh5OS3V1W59oCrLtaKuMGJpj8EuYbD1z+eeyg0Ds/ZstVrRjQa1ZYPzvBt0RloE7ZYMEpyQCOMnnmxPbYfvhvJ69KNXMRI1PMTCrW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ip52rqeC; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707462584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qSzX0INNFk+/IxT9nO7GVCJEW9cvWtprz6XblZoooLc=;
	b=ip52rqeCrIJZxKh6s7RJRBbmN7fgi4TPA8gqxpCTIVWuTcq2nNJxuKbMCi34EgGsqahVnv
	nk8vdgSf0KQ6jpJVYus7wl/iuoM631shzW46cHa5skCvSMC4Tsz9p4QnZsFeu9iRE/cBwq
	2bBPPq9AUUptfj4cFywDxPjlLpd1QRg=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	fuyuanli <fuyuanli@didiglobal.com>
Subject: [PATCH] kernel/hung_task.c: export sysctl_hung_task_timeout_secs
Date: Fri,  9 Feb 2024 02:09:35 -0500
Message-ID: <20240209070935.1529844-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

needed for thread_with_file; also rare but not unheard of to need this
in module code, when blocking on user input.

one workaround used by some code is wait_event_interruptible() - but
that can be buggy if the outer context isn't expecting unwinding.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: fuyuanli <fuyuanli@didiglobal.com>
---
 kernel/hung_task.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 9a24574988d2..b2fc2727d654 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -43,6 +43,7 @@ static int __read_mostly sysctl_hung_task_check_count = PID_MAX_LIMIT;
  * Zero means infinite timeout - no checking done:
  */
 unsigned long __read_mostly sysctl_hung_task_timeout_secs = CONFIG_DEFAULT_HUNG_TASK_TIMEOUT;
+EXPORT_SYMBOL_GPL(sysctl_hung_task_timeout_secs);
 
 /*
  * Zero (default value) means use sysctl_hung_task_timeout_secs:
-- 
2.43.0


