Return-Path: <linux-kernel+bounces-90755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446E7870478
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1E24B221F7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0588341775;
	Mon,  4 Mar 2024 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaYX0rd2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BACA3FB02;
	Mon,  4 Mar 2024 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709563465; cv=none; b=UBI23rgCvJachXhrsrgcyNyfMP0sYqoDNrp8kuibOidHsGXId2WATxd+ssXIG8TkiYsXCrXghQDNRCdwfdwBIOo30UuoxFEVbIv2LoSUyoyvJDR0hG7vuONpAUKaLmFY56LFpzvK8p93/p3xI4QY337g5AN63yEUttal6pGsO34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709563465; c=relaxed/simple;
	bh=CIWlzzc56P2a2Q8cEBY3mQwiAhICjTm2fIKGkNrlf+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9TpbKFWqWKIBZeLnvqg7MYIscG8md4hD+u3ob9gsoaFzWXaA8t9zZ1NrHTGLYIUYEdU1Iy0JbtMkCCp0FlzcJIhl0cTX7WiPJxZL5FW7Kl7PFBA3i+estS1/pkA7eQx+dFmX4QNFQAeI4xHfyYrgEzr9w7nmbFoSdvwnqR82FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaYX0rd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD834C433C7;
	Mon,  4 Mar 2024 14:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709563464;
	bh=CIWlzzc56P2a2Q8cEBY3mQwiAhICjTm2fIKGkNrlf+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oaYX0rd2KQHS+m+uJGLZDqBX9AA781YzMFOBRtB2WMhbKdZumhhNjk3W40fZKclBK
	 tKW7W8HIDG3Hn5h3wJqxUqhl63BoV1E637nsx3iYars/M+6XxCHUXjBP0fiVGAgciW
	 GlZk1YWNzX96kEVtFWUwP7+nHMvBSWbCLlMueGnM4cN/UNdMLcEVg5NHkHZRxIxgf5
	 ynJVBl+YXjn7OZDj64V2aGz288m8ZHx+PkfIMPRhUE+az/mwFwO2LDNaLDjRx+tZDd
	 Dv8+BIClKI6d40BrhiTo0x+BuNigSTEPziH8k6ETdnQFJV3ZsJQiT8q/hO7gjqxDO1
	 fjgoRJVpI8NUw==
Date: Mon, 4 Mar 2024 08:44:23 -0600
From: Seth Forshee <sforshee@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, xingwei lee <xrivendell7@gmail.com>,
	sam sun <samsun1006219@gmail.com>
Subject: Re: [PATCH] 9p: cap xattr max size to XATTR_SIZE_MAX
Message-ID: <ZeXeR+2f/ozdamWL@do-x1extreme>
References: <20240304-xattr_maxsize-v1-1-322357ec6bdf@codewreck.org>
 <4091309.WcpKHNDlqE@silver>
 <20240304-zeitschrift-tagung-6f2a28e781bc@brauner>
 <ZeXcQmHWcYvfCR93@do-x1extreme>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeXcQmHWcYvfCR93@do-x1extreme>

On Mon, Mar 04, 2024 at 08:35:46AM -0600, Seth Forshee wrote:
> On Mon, Mar 04, 2024 at 03:19:58PM +0100, Christian Brauner wrote:
> > On Mon, Mar 04, 2024 at 02:35:07PM +0100, Christian Schoenebeck wrote:
> > > On Monday, March 4, 2024 1:42:43 PM CET Dominique Martinet wrote:
> > > > We probably shouldn't ever get an xattr bigger than that, and the current check
> > > > of SSIZE_MAX is a bit too large.
> > > 
> > > Maybe, OTOH e.g. ACLs (dynamic size) are implemented by storing them as xattrs
> > > on 9p server as well, and this change somewhat expects server to run Linux as
> > > well. So maybe s/XATTR_SIZE_MAX/KMALLOC_MAX_SIZE/ might be more appropriate,
> > > considering that this patch is about fixing a potential kmalloc() warning?
> > > 
> > > Worth to mention in the commit log BTW what the issue was.
> > > 
> > > /Christian
> > 
> > So the error is somewhat specific to filesystem capabilities which also
> > live in the xattr apis but Seth is working to get rid of them in there.
> > 
> > They currently use a special api vfs_getxattr_alloc() which is an
> > in-kernel api that does a racy query-size+allocate-buffer+retrieve-data
> > dance.
> 
> Yes, the patches I've sent does use vfs_getxattr_alloc() for fscaps
> anymore.

Sorry, typo above. My patches do _not_ use vfs_getxattr_alloc() for
fscaps anymore.

> 
> > That api is used for fscaps, security labels, and other xattrs. And that
> > api doesn't do any size checks which probably should also be fixed now
> > that I write this.
> > 
> > @Seth?
> 
> I agree. I don't see any reason that vfs_getxattr_alloc() shouldn't just
> bail out with an error if the size of the xattr is >= XATTR_SIZE_MAX.

