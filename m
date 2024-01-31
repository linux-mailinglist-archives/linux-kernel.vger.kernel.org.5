Return-Path: <linux-kernel+bounces-45574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA54843294
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E7BFB23EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1D8139B;
	Wed, 31 Jan 2024 01:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aw/iDwt0"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130141C32;
	Wed, 31 Jan 2024 01:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706663577; cv=none; b=aaYxFE8qLxTQe8eO3+DP8tajtoFBDBPKFXBcVLN5xU1LO8LqNxNele9UVLBBSZGKUurh8cVA5K0yw6R77OKzSYYpftST9WwcvEslF1qqiuaOvu5HMrcjwpjQ8GTVuBNErlPcR5fKr/g8ky4WwL54nOoWROW2BpfYNUe6SEHkOEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706663577; c=relaxed/simple;
	bh=dEApJi9PEQyHSqV0Yx65sBvpyJJEQjEqNeAGYIZ7Q6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrnWyfihe7U+XHeQpRn0LdRN5ioKCLEslSEC/dNOiqmXS4y3c3DH5hq2OX7xsfMu5WcHXOsr/QfPrdNGtdo4SvqG16rthtTdr2BfLV/y8vVEvIwpYBFrLE4yffSZwQAESDTq1cNfJHNaTxpvr6k0I/Rm9h0Fc0MjzRORKH07YHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aw/iDwt0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tvJGjlrL3+/iLawTES3nBbeFVhzC+7i7j5qNH73zx0s=; b=aw/iDwt0pwz5EHcNO4TgpkaZ9c
	F7R6l8sVLdEGizRcGSvZQjR0Pvd8sAdy+Dq4Cin5pM1OmeifJl13SUEnuKNdDaYyvrkHXBDrog6C0
	6XA+L4ToT93O2QsGDmoTXenhRoG2AUsoI3/rC9wKDg1CLRZaM55LhanG+itGMsxEvkt+jhUjRZGMw
	EWmSJGACisOgZpAbx+ewz8rLHrg/b6V11dHLYSZk9AXpqs/iAqcbRFtrtfktlz2b+VN3nqkpskzyS
	8lYKwJq8xE6MaJp6METTL/o7rldwfaoYXId6glvOKxolPldNYwyHc7nr9uFj3YDo/HxzMYPVTLDH9
	KamD77SA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rUz9i-001ltx-0H;
	Wed, 31 Jan 2024 01:12:46 +0000
Date: Wed, 31 Jan 2024 01:12:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] eventfs: clean up dentry ops and add revalidate
 function
Message-ID: <20240131011246.GP2087318@ZenIV>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-6-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130190355.11486-6-torvalds@linux-foundation.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 30, 2024 at 11:03:55AM -0800, Linus Torvalds wrote:

> +void eventfs_d_release(struct dentry *dentry)
>  {
> -	struct eventfs_inode *ei;
> -
> -	mutex_lock(&eventfs_mutex);
> -	ei = dentry->d_fsdata;
> -	if (ei) {
> -		dentry->d_fsdata = NULL;
> -		put_ei(ei);
> -	}
> -	mutex_unlock(&eventfs_mutex);
> +	put_ei(dentry->d_fsdata);
>  }

I'd rather pass ->d_fsdata to that sucker (or exposed put_ei(),
for that matter).

> @@ -857,6 +847,5 @@ void eventfs_remove_events_dir(struct eventfs_inode *ei)
>  	 * sticks around while the other ei->dentry are created
>  	 * and destroyed dynamically.
>  	 */
> -	simple_recursive_removal(dentry, NULL);

That also needs to move earlier in the series - bisect hazard.

> + *
> + * Note that d_revalidate is called potentially under RCU,
> + * so it can't take the eventfs mutex etc. It's fine - if
> + * we open a file just as it's marked dead, things will
> + * still work just fine, and just see the old stale case.

Looks like use after free, unless freeing ei is RCU-delayed...

> +	return !(ei && ei->is_freed);

