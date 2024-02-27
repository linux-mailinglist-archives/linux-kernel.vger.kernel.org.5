Return-Path: <linux-kernel+bounces-82634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8187B86877A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6EC5B258AA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34FF2C85A;
	Tue, 27 Feb 2024 03:03:14 +0000 (UTC)
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200C82C198
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 03:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709002994; cv=none; b=a8+w7j3VxYbf+YlC4KSYxTJCpCQR3VZaF5t40RxshVsNHSVR1lrIenMiQvBcFXnbVrV01xDpZCKffLiJtsbv3G7PFkUkhYLRgrutzPM9I1Gbn+GJJxtqu2RImf08eMYogY46LDTOqFmbv85nCCvrWT/kYXTlZpK5P29SAIl/6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709002994; c=relaxed/simple;
	bh=DY8u0TYto4aeAduUrtq135WGTjcoSdC+IXz6XRCNMTc=;
	h=Subject:MIME-Version:Content-Type:From:Date:Message-Id:To:Cc; b=WjHjPFN4UB2u0sACt04As6L5Fo098f7/t1j4Z0HLoDfwa7b5NfLIc5r/Sqza44MWR8zhcP2NUBl4LwBJAlUs8/U58Rkd5e88Yqp53TqzqjwAVgQqQs2zSUaX8rbJ12jQm3UeE/6Xg0NwZNSLkDNbb70XZBm4tYAnnX6wrLFMu6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Subject: [PATCH 0/2] mm/zsmalloc: simplify synchronization between zs_page_migrate() and free_zspage()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAN1Q3WUC/w2LQQqAMAzAviI9O5hlevA3Xa06mFNW9KDs7/aWEPKBSk2iMHcfVHmSprOYDH0HvF
 PZxKXFHNBj8IiTe/WgnE82uMhy5dtF5AFXP4Y1BrAzkoqLlQrv9pY759Z+pn8dvmoAAAA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Tue, 27 Feb 2024 03:02:53 +0000
Message-Id: <20240226-zsmalloc-zspage-rcu-v1-0-456b0ef1a89d@bytedance.com>
To: yosryahmed@google.com, Sergey Senozhatsky <senozhatsky@chromium.org>, hannes@cmpxchg.org, nphamcs@gmail.com,
 Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709002985; l=1565;
 i=zhouchengming@bytedance.com; s=20240220; h=from:subject:message-id;
 bh=DY8u0TYto4aeAduUrtq135WGTjcoSdC+IXz6XRCNMTc=;
 b=WkUVQbxbtoRQXjW/10v7MndbdXFUoW/g0x8wWemSA1Gwtsdawmeta3E9eNGhjqqeVOXcN3Ftn
 4pe7vXyGdJcDerKNnZ/kdZz3Htz0zixmuRPxEadnX5V6nFYGNoQSuBi
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=5+68Wfci+T30FoQos5RH+hfToF6SlC+S9LMPSPBFWuw=
X-Migadu-Flow: FLOW_OUT

Hello,

free_zspage() has to hold locks of all pages, since zs_page_migrate()
path rely on this page lock to protect the race between zs_free() and
it, so it can safely get zspage from page->private.

But this way is not good and simple enough:

1. Since zs_free() couldn't be sleepable, it can only trylock pages,
   or has to kick_deferred_free() to defer that to a work.

2. Even in the worker context, async_free_zspage() can't simply
   lock all pages in lock_zspage(), it's still trylock because of
   the race between zs_free() and zs_page_migrate(). Please see
   the commit 2505a981114d ("zsmalloc: fix races between asynchronous
   zspage free and page migration") for details.

Actually, all free_zspage() needs is to get zspage from page safely,
we can use RCU to achieve it easily. Then free_zspage() don't need to
hold locks of all pages, so don't need the deferred free mechanism
at all. This patchset implements it and remove all of deferred free
related code.

Thanks for review and comments!

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
Chengming Zhou (2):
      mm/zsmalloc: don't hold locks of all pages when free_zspage()
      mm/zsmalloc: remove the deferred free mechanism

 mm/zsmalloc.c | 206 ++++++++++++++++------------------------------------------
 1 file changed, 56 insertions(+), 150 deletions(-)
---
base-commit: ccbd06e764bac9bbf6b4e91c700fe6dd28f08fb3
change-id: 20240226-zsmalloc-zspage-rcu-b2c12f054fb4

Best regards,
-- 
Chengming Zhou <zhouchengming@bytedance.com>

