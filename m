Return-Path: <linux-kernel+bounces-45549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEE4843244
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01582894BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1920EEBF;
	Wed, 31 Jan 2024 00:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QtIThWPs"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0A67EB;
	Wed, 31 Jan 2024 00:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706662093; cv=none; b=fH6gRsPX4TBYMU8abqanjVOr810EQx5yfSTCftpW0Vw+Yz4JyF4mz1DjqQ201UcGOi2bS98titaieRZmrORmFjyma1AayuAQtNwrpI+Ai2xSsnu8N2AYEXbN1WmG2/lBOvCR7UR2Og0njl+pegWrGGyv3Et9infI4O7qsn+sT0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706662093; c=relaxed/simple;
	bh=Y3ORv9uSKc/gzYNp8iwBsCBjJYn7exhDa5OECXnAf9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFldBzmO1CB5o5OEhZjl7726GjkhgubuBnFjJwtu8jltFGT/4mFXMn9HKm4SmK0TivyO1Oq1mM62f1OwN8fmVbT/TPWUFQcaFH0lk02G5al86hwOcrKtToEFLniZ45xYc9BQfUo5KCO8va/QUYBLtl3ZEsOEbi0iNr1gV9xx1sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QtIThWPs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GAADshofue1d9TTWA5jeSnqjUKHbX9U7EdljKoDoQEY=; b=QtIThWPs/nfJCH7Fl6lPpn7OVQ
	NvrhaD+J0eGAIeSX6nNE8ImsPYy1ThiY9k3V21ylbqCKerlpn6qjXV9AAOcAHd7qyGKfgd2VWB6QB
	51ET5JJk2Par201K1IIjaLugjU6i72/ujVLBL1wNLeJ2dQYSSyxhJkDLyRWu0vAS0nyqR3YU0y04L
	MyADV2U6XV+N33crvBsxjzhSuR14s/n+WjyN7BU/zUnBikaQ4v9HNyTClO0ARG/01dxi64s3gEn6w
	tyQ0nUhsIsdQ0xvS8h9iKweapatejslEpjKjdJF2BqgJF40HlTAR0vSJduK8MgzJIQkf3OLA+1kJm
	4iIaO/WA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rUylp-001l8u-1R;
	Wed, 31 Jan 2024 00:48:05 +0000
Date: Wed, 31 Jan 2024 00:48:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without refcounts
Message-ID: <20240131004805.GO2087318@ZenIV>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-5-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130190355.11486-5-torvalds@linux-foundation.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 30, 2024 at 11:03:54AM -0800, Linus Torvalds wrote:

>  	inode = tracefs_get_inode(dentry->d_sb);
>  	if (unlikely(!inode))
> -		return eventfs_failed_creating(dentry);
> +		return ERR_PTR(-ENOMEM);

That belongs in the lookup crapectomy patch - bisect hazard from stray dput().
Same for similar chunks below.

