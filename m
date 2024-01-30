Return-Path: <linux-kernel+bounces-45233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 719B9842D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B0A1C208F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1DE71B53;
	Tue, 30 Jan 2024 19:56:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95B071B2B;
	Tue, 30 Jan 2024 19:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644604; cv=none; b=pn0OLlpRTe2P4SIaamcSQN320VUK/gZzZZGsrI3saJLDqwH5mfUARH/GPrwtFFsClqYrWunz/waGUlROk/iDtINVCRjFLZAHi5GvJw2KLXqe9ZS1DtMOW9Mi/GeTIqfu1qsRHPsGRqBD5opPUWeADzhanH757c236ADpSIMLr3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644604; c=relaxed/simple;
	bh=SLu7uhmKIIMNyprfYtwziS/mgqFfszhz26PKqZn0p+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqwv+j5cuBXw8AbT1tpz3ZI/H8MHoHQxwaaYnYkuZ8phtQXUM1A+bo+kGqH8zecNzSSsUcE++9H81grS6ZtOZF8LVr81DSObw9O1a2mA8btNVXnUNqLDbSXkas3I+ZG9dXfJ0nqdMleZnK0Zr6pfcuA0rMpdnL7rJKNoSt4djkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6962C43394;
	Tue, 30 Jan 2024 19:56:43 +0000 (UTC)
Date: Tue, 30 Jan 2024 14:56:55 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] eventfsfs: initialize the tracefs inode properly
Message-ID: <20240130145655.073ff344@gandalf.local.home>
In-Reply-To: <20240130144802.6e1a8cf8@gandalf.local.home>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
	<20240130190355.11486-2-torvalds@linux-foundation.org>
	<20240130144802.6e1a8cf8@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 14:48:02 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:
 
> The ti is allocated from fs/tracefs/inode.c that has:
> 
> static struct inode *tracefs_alloc_inode(struct super_block *sb)
> {
> 	struct tracefs_inode *ti;
> 
> 	ti = kmem_cache_alloc(tracefs_inode_cachep, GFP_KERNEL);

I could also just add __GFP_ZERO so that all of it is initialized to zero,
and then we don't need to assign NULL to any part of it.

-- Steve


> 	if (!ti)
> 		return NULL;
> 
> 	ti->flags = 0;
> 
> 	return &ti->vfs_inode;
> }
> 
>

