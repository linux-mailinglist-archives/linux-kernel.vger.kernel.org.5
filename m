Return-Path: <linux-kernel+bounces-90719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBEC8703E2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9071C2272A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CD53FB31;
	Mon,  4 Mar 2024 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezyxueCn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F167543143;
	Mon,  4 Mar 2024 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562004; cv=none; b=ujKo/jBF2hthkP/BrgWiOCfzFVTtr/DyCRcOQwrh8/D7L/x8/iJaJoZq+YaBOv83wajpBvqlkC5a64I72aBuarLY3LLjJ6EhmkLeu9sPRBXbMCNIrtb6ZkcNYXMIxwibe8MCv3EB+HeBh7m2AdKD+HSMTGoGnCs55TxH6HmYP5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562004; c=relaxed/simple;
	bh=RWlnDWKxXqq0n6k2lqfqFDqVfl1QcGSZnt0Kub/OHIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJLUzanVqdfFaU3xlBByDj/A8g4XZH0mn7+HtVH6nxLO5S/EEWw6d5jOunZYovNWH789PHrE7trkV+J72dj63kMFlf1dNDF7UdrqLu6zZ9Yx5OJAdWIv38iMLwdxj9OIJ4RMSztIK4rAPphFG4PWr0TWkJtR4vlgP0DHGzEoKLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezyxueCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AC2C433F1;
	Mon,  4 Mar 2024 14:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709562003;
	bh=RWlnDWKxXqq0n6k2lqfqFDqVfl1QcGSZnt0Kub/OHIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ezyxueCnepsSMhtIU1EkDKZZWjembdsnrrGf7YGBqiPa45+cfkaD/+E/kCEydbtv+
	 zgXgGdDXC1akH+0im/gMfwC6sqioPi8iZvjnCPUZfngNZTDQMHgwXb11mjLsFLLJ+t
	 fv+ZrPgRwh9ksUz9CgxX9X7zSwQwymRO6ENbq7xsmMuK8s2MVQ94zXmH47iOeUqxgH
	 kMxQf+ujxlPADV5KNzMOWdXuFETp9EhXMxd8646TpVuWWlIQGaUNW0p28R2KCyMA0x
	 JPwxQphlaV0aWHYitgG8zWMjed1u/1NU6KO/PPAS2+gGo9oVLkJ7yfEQq4QO4BfV8H
	 mI/VIdb8dEWTw==
Date: Mon, 4 Mar 2024 15:19:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xingwei lee <xrivendell7@gmail.com>, sam sun <samsun1006219@gmail.com>, 
	Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH] 9p: cap xattr max size to XATTR_SIZE_MAX
Message-ID: <20240304-zeitschrift-tagung-6f2a28e781bc@brauner>
References: <20240304-xattr_maxsize-v1-1-322357ec6bdf@codewreck.org>
 <4091309.WcpKHNDlqE@silver>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4091309.WcpKHNDlqE@silver>

On Mon, Mar 04, 2024 at 02:35:07PM +0100, Christian Schoenebeck wrote:
> On Monday, March 4, 2024 1:42:43 PM CET Dominique Martinet wrote:
> > We probably shouldn't ever get an xattr bigger than that, and the current check
> > of SSIZE_MAX is a bit too large.
> 
> Maybe, OTOH e.g. ACLs (dynamic size) are implemented by storing them as xattrs
> on 9p server as well, and this change somewhat expects server to run Linux as
> well. So maybe s/XATTR_SIZE_MAX/KMALLOC_MAX_SIZE/ might be more appropriate,
> considering that this patch is about fixing a potential kmalloc() warning?
> 
> Worth to mention in the commit log BTW what the issue was.
> 
> /Christian

So the error is somewhat specific to filesystem capabilities which also
live in the xattr apis but Seth is working to get rid of them in there.

They currently use a special api vfs_getxattr_alloc() which is an
in-kernel api that does a racy query-size+allocate-buffer+retrieve-data
dance.

That api is used for fscaps, security labels, and other xattrs. And that
api doesn't do any size checks which probably should also be fixed now
that I write this.

@Seth?

