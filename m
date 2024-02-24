Return-Path: <linux-kernel+bounces-79412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2258621B7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED241F26BA2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE314C85;
	Sat, 24 Feb 2024 01:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siWXoDh6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170048F58;
	Sat, 24 Feb 2024 01:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737366; cv=none; b=DjTV/sWmWXc3/5GAtV0y2RPE1xfHQkHd7/ntwJwjxPtM/EA4BC3tyNy9hYjFVeDyXw4mFWGef0jF9v7lY3rL31MUWAtP1fihQCtfGevg3S0nN2oxVVHWLVAbikGVJHGFCneDfdn/8DHP2e46Sv9DXujn2ZoFKsHEZNT+NVnCJMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737366; c=relaxed/simple;
	bh=YYvJrol7FIU10J6nT0nMYbutoEnKpSEot6WG6TgCjxk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bx7nO/Y7Ho8lzfwQ6/RxXYguG6wHyWFZkKAwUuerf1k4pKbRN9f7pu4oHeaitK6gCofASXzXX2tE/avWooqi2g86S0jXhuwiWCY0FAIFrFjPROisU7wTTWlAeInuUyVdkqHTtF51khG4ftFhTegffyYDg3D92xUJxtFDhL88Lq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siWXoDh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E1CC433C7;
	Sat, 24 Feb 2024 01:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737365;
	bh=YYvJrol7FIU10J6nT0nMYbutoEnKpSEot6WG6TgCjxk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=siWXoDh6HKxNuMQh5M7rE1hVP1E5wpey2YEybBYnNWE/9LU+eI9Bmzv8YuZPPY5Ga
	 niL92Oeea4JW8Xxx0gLfm+tNFNYZ1fJ+OLoXrf7o/IQ2mUlWPzp4mymg9KeGBiqXPI
	 +tKLMlzk3lYQi0+je4XHYWem+oLy9nTGTQ6l4u0X44qD3tvX6TPOtGHW0n3SZahXlG
	 ZEjGuGxCpIMlGVgvHdjwG6SDPVto5W5E2MVqzGkGf2r/og/F+6ySumL6qmGbso4kXO
	 HR2Icls/gjq93UGTa6PUkpg/oXJqjAlEkxNKWJ0Nmv5Wa0vLZlljzI23hPJPMELc75
	 1iRL7T6dTjDoA==
Date: Fri, 23 Feb 2024 17:16:05 -0800
Subject: [PATCH 09/10] kernel/hung_task.c: export
 sysctl_hung_task_timeout_secs
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: fuyuanli <fuyuanli@didiglobal.com>, linux-xfs@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <170873669034.1861398.8097801489286284855.stgit@frogsfrogsfrogs>
In-Reply-To: <170873668859.1861398.2367011381778949840.stgit@frogsfrogsfrogs>
References: <170873668859.1861398.2367011381778949840.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Kent Overstreet <kent.overstreet@linux.dev>

needed for thread_with_file; also rare but not unheard of to need this
in module code, when blocking on user input.

one workaround used by some code is wait_event_interruptible() - but
that can be buggy if the outer context isn't expecting unwinding.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: fuyuanli <fuyuanli@didiglobal.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 kernel/hung_task.c |    1 +
 1 file changed, 1 insertion(+)


diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 9a24574988d23..b2fc2727d6544 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -43,6 +43,7 @@ static int __read_mostly sysctl_hung_task_check_count = PID_MAX_LIMIT;
  * Zero means infinite timeout - no checking done:
  */
 unsigned long __read_mostly sysctl_hung_task_timeout_secs = CONFIG_DEFAULT_HUNG_TASK_TIMEOUT;
+EXPORT_SYMBOL_GPL(sysctl_hung_task_timeout_secs);
 
 /*
  * Zero (default value) means use sysctl_hung_task_timeout_secs:


