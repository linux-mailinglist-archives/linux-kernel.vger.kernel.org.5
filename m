Return-Path: <linux-kernel+bounces-79398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FC9862197
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C321F23474
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7704A06;
	Sat, 24 Feb 2024 01:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKwgcty8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B944817F5;
	Sat, 24 Feb 2024 01:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737131; cv=none; b=oiIfhT2EKdyD1QMcmnQa3OnUxVCdXl7mTWda0KkFbpUWF5feBjTuXCHPtHWxw81rj4fzGUlNii/BQsnUSJRLSTD8QFz2HkohFAYdRgeALW0xhMvkNHLnJM8f8K87qvdD+j7x2Iv2wADXS1+vOJ9n2L/m6KdcrSadqU+xWKTwCEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737131; c=relaxed/simple;
	bh=t+a3dnfPOx4IIRgsSK8ZjS4LDPymxs2saneliaxtiAI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmihWYLJmgoeYrdxB3jIQjBHeFiJgrKuqF6jSGZaqNE23CEOPuk7z3UTZLLiS32qoj7i1AvA+fwc5/tUEU40Ge6sw+NbMkW3j1ttR6PHGUZorS/eza6IFpO9anLJBrsEFsDiiqp8vb/tSOe+ZMCsTIe43wF4F2/OYAcGCMNTRhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKwgcty8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C49C433F1;
	Sat, 24 Feb 2024 01:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737131;
	bh=t+a3dnfPOx4IIRgsSK8ZjS4LDPymxs2saneliaxtiAI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qKwgcty81/ZnYzIwfilwTthfSCEWrkWCGo05LxbzB79HvDWq5LrQdFFYzCa0h9V39
	 /Aklm9osV/suDs8g2Q6suqPXRJEAUkiLn4Yd5yzhZoA2oogYzwymyxu7a/vPXCdo63
	 2Mv4eCjDKekmcSdTB1J99blmh8/aE8hrvSUmK0Vq4kUDo55t8NQzdovNdruJev5hzG
	 9xPSHpcL0UArzt1DTAxrC5zpQX8Z1Vq26oZ+SPwOcHKODFvAQ8M5gh0bGPFzhxHSl1
	 KQd1XYQ549x0i9yuE0cR6YnMKoZ+ASN9PL3zyZ5JQmZQMrUDyQOBOiZwUeGgZfhEq/
	 guOVIcFBmzbmQ==
Date: Fri, 23 Feb 2024 17:12:10 -0800
Subject: [PATCH 08/10] time_stats: shrink time_stat_buffer for better
 alignment
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873668069.1860949.912351762607273370.stgit@frogsfrogsfrogs>
In-Reply-To: <170873667916.1860949.11027844260383646446.stgit@frogsfrogsfrogs>
References: <170873667916.1860949.11027844260383646446.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Shrink this percpu object by one array element so that the object size
becomes exactly 512 bytes.  This will lead to more efficient memory use,
hopefully.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/time_stats.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/include/linux/time_stats.h b/include/linux/time_stats.h
index dc539123f7997..b3c810fff963a 100644
--- a/include/linux/time_stats.h
+++ b/include/linux/time_stats.h
@@ -63,7 +63,7 @@ struct time_stat_buffer {
 	struct time_stat_buffer_entry {
 		u64	start;
 		u64	end;
-	}		entries[32];
+	}		entries[31];
 };
 
 struct time_stats {


