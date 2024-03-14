Return-Path: <linux-kernel+bounces-103384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E725687BEC7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FAF6287D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7036670CA8;
	Thu, 14 Mar 2024 14:21:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052FE6FE0F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426084; cv=none; b=IViWT315Df1YquE01todT/S987sa4r1PDjgdyODAGkD779xt4EEZeBpjcSMSCYuUBm4jpdzK2xWYjOddFXNqYUB/PLn6W65UNzHg8H8kc6G4lFLKZZU2o0LY/MQGTzhl2h+yd45+BHA1vRHHW1QB3T5KxEgnHi/eqQ3kwPyyHyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426084; c=relaxed/simple;
	bh=QL6JFa2A3kh9PwqYA8gfLfmL2FQ7h1al6AGFkd/Ktr0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=PjhtHHDjFdItvX1XJH691F/NBg1RW/PeRWjcsvo2JE6dtupS22gOg28zSikv/pEv5Wi2H6MtWFqTLSFPv+YJ9VWorVN4PEFKm5LxAWB1mZze3PzHpycJy9RKMf7UkmpzF0Wt1OYZhcvPx1DvmsJ/p2Uam4yPZncbuTVtWxHuI94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D321C43390;
	Thu, 14 Mar 2024 14:21:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rklzb-00000002ddU-00K4;
	Thu, 14 Mar 2024 10:23:35 -0400
Message-ID: <20240314142334.863961009@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 14 Mar 2024 10:23:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chengming Zhou <zhouchengming@bytedance.com>
Subject: [for-next][PATCH 2/8] tracefs: Remove SLAB_MEM_SPREAD flag usage
References: <20240314142301.170713485@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Chengming Zhou <zhouchengming@bytedance.com>

The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
its usage so we can delete it from slab. No functional change.

Link: https://lore.kernel.org/linux-trace-kernel/20240224135206.830300-1-chengming.zhou@linux.dev

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index d65ffad4c327..5545e6bf7d26 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -731,7 +731,6 @@ static int __init tracefs_init(void)
 	tracefs_inode_cachep = kmem_cache_create("tracefs_inode_cache",
 						 sizeof(struct tracefs_inode),
 						 0, (SLAB_RECLAIM_ACCOUNT|
-						     SLAB_MEM_SPREAD|
 						     SLAB_ACCOUNT),
 						 init_once);
 	if (!tracefs_inode_cachep)
-- 
2.43.0



