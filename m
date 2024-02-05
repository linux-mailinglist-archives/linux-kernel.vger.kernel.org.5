Return-Path: <linux-kernel+bounces-53013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA3A849F88
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524741C225F3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16D43A8F9;
	Mon,  5 Feb 2024 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="nE3v+/WT"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF3528DD1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150801; cv=none; b=Z5vcr/1ff1lYkYuvcDoMoG5b0MxRgYr5iGcUOH2n6Umd2lrrJvvJ1L5XWZXqWjowFv9pTxC9EpRgJMJMjlW2UjyGpbcazTwfmT02z6m90GTeg6fW5VmiKmZGlgqxaexpN7VX4sOyN4Ir0+AezwaH7sdNlIthagItHEIvayhEchA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150801; c=relaxed/simple;
	bh=2cQXhUPiMEW3Ok85h1EHeLAdBpbDxsZrxdUiLgoGxIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyFJsK2gn6CvFwq+6Oeyo8oex7V4i841bjA9jXNv+sMeyGt3aMauhI7VYFIeLitUD00rJw+pWwnIvrylhGmnhSuRkeNRm40nfVIJcAtwiCt4KfRQ0lgDJjtL8aF2JaWHicWdHLR+AFZ1XdyYar16yPE/bTqOYBhKd6XgvPBcmYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=nE3v+/WT; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-236.bstnma.fios.verizon.net [173.48.82.236])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 415GWnNj014106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 11:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1707150772; bh=a9P4gllJIaKyhZehWwj32p0bctAew6koUJX5fapQ3pQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=nE3v+/WT01Gk5V/Z68qPKmJcM7hU6ejzRJNb5gfCRDRr0HScBgSzNJukgqr/k+WWD
	 rRoJJmzmB3fH1Krx1choGfJD9GfDXIG0u+d4aloWquXQuYOj67M5jEEX7/KDOOM2U8
	 srGpfV2gk3U51xYuSpkrLmlDojg2+2aHrxoV60sWXTekEc2DjptjmjkkkzbrmjBHO6
	 YA155/K7Ggk38BKkPTOmRzkfmDAidILGgFd1KOxJCou/DoMyL3vK8/EYWbYvrwVHsK
	 H9RqCdUnL3r/a16CoFcJdL7zQ+AJVeERboPxKV0QgpLH3ukrC1POhSkKpZCxbtNK++
	 2LnW75jaVcM6g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B733815C02FD; Mon,  5 Feb 2024 11:32:49 -0500 (EST)
Date: Mon, 5 Feb 2024 11:32:49 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, jack@suse.cz,
        ritesh.list@gmail.com, john.g.garry@oracle.com, djwong@kernel.org
Subject: Re: Running out of inode flags in ext4
Message-ID: <20240205163249.GE119530@mit.edu>
References: <ZcCztkt8KtMrsvPp@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcCztkt8KtMrsvPp@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>

On Mon, Feb 05, 2024 at 03:38:54PM +0530, Ojaswin Mujoo wrote:
> Hi folks,
> 
> I'm trying to rework the ext4 atomic write patchset so we have similar
> semantics as discussed here [1], which would look something like:
> 
> 1. we call FS_IOC_FSSETXATTR to enable atomic write on inode
> 
> 2. In the setxattr path, we need to mark the inode with
> atomic_write_enabled. XFS does it via an on disk inode flag which is
> straightforward enough 
> 
> However, on ext4 we are almost out of 32 bits of inode flags and I don't
> think it's possible to add any flags2 field or something (iiuc, ondisk
> indoe doesn't have scope for expansion).

We still have some unused flags.  For example,
0x01000000. 0x04000000. and 0x08000000 are still unused.  We are
starting to get close to full, so we need to be a bit careful since it
is very much a limited resource.  But we're not yet at the point where
we need to worry about trying to reuse flags like EXT4_EOFBLOCKS_FL.

Cheers,

							- Ted

