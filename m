Return-Path: <linux-kernel+bounces-45519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AA68431D8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010E91C24B42
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5153A36D;
	Wed, 31 Jan 2024 00:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rDtLZXD6"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F731859;
	Wed, 31 Jan 2024 00:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706660634; cv=none; b=VHnUGxcxUDLpRcYrQVzofFqTHiN2E7oDGi7VaqQQUC6/HbxPje71Bl5iOiLhvlGzkGQGeMvkJJcXggvppiDg1sl4CnGZW6JTr2U7+UND7nDZO0omFSsgHRrkOcDLrjYqf51xYQyxmdyLMn2Wu1fJpIBKjiCsBV7Si7TyIyH4eEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706660634; c=relaxed/simple;
	bh=c/eIPZvywtwvTLT9YSLVvlch++xEbKA446vc6uScEkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rP+y0hN4GpislUKogU3v1Lstx3Pw3ksOAErxDetVOljzINntaPXNgKEnkmYOllMf46qmnIFagoBY4LSUiK2QHXi5rhM9cWzFmUwX4i4MgfNqYLWIx9rVchzvsjR0uXt5zi3RQWf69bOwHF1FQEbjLagdIItwKv/MNmHu6Y2PFoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rDtLZXD6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OMoLdYC5GdVaaynp2LWvJ7jTSZFMs+neDTkz0sr2JQw=; b=rDtLZXD6C82pW8fFtqMrFK5g3Q
	/J6RXUnzSdDaFA4brvEZu+DjCazUIs7Icdeeed4Zpuo/BjJ5lzcwN7Cl5vjfYrsWdbcKbk4+9TOrV
	RO/59vpswj1S2BQ4ftNAWsCSGue3AeExxpgxD2MQw1yTWBclv9o6vEO9LfR+c0ZK+y6/IvbzsskM4
	cGOBfcyPRRWu1SyM9zJmQ6a8GI5Zo7GVD3g2hkBHkhu/ikydAH6i8XJSLdEqWpt4RWwoWRoLhhAwi
	PWkeGzZ4b0uLAPZ91UYL0G6Cw5+uwFfgH2ScHhgGOGbr4DYeLACQJpIE9pJm4CztJtVgC8DVmnqvd
	O587NUTw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rUyOI-001kOL-2I;
	Wed, 31 Jan 2024 00:23:46 +0000
Date: Wed, 31 Jan 2024 00:23:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] tracefs: dentry lookup crapectomy
Message-ID: <20240131002346.GN2087318@ZenIV>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-3-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130190355.11486-3-torvalds@linux-foundation.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 30, 2024 at 11:03:52AM -0800, Linus Torvalds wrote:
>  {
>  	struct eventfs_inode *ei;
>  
> -	mutex_lock(&eventfs_mutex);
>  	do {
>  		// The parent is stable because we do not do renames
>  		dentry = dentry->d_parent;
> @@ -247,7 +246,6 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
>  		}
>  		// Walk upwards until you find the events inode
>  	} while (!ei->is_events);
> -	mutex_unlock(&eventfs_mutex);

Unless I'm missing something, you've just lost exclusion with
removals (not that the original hadn't been suspicious in that
respect - what's to protect ei past that mutex_unlock?

