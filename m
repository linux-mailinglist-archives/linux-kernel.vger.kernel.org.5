Return-Path: <linux-kernel+bounces-6374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E005F8197DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039EC1C22101
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5288D312;
	Wed, 20 Dec 2023 04:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZO4boCkN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91313C2C5;
	Wed, 20 Dec 2023 04:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hRpiRNthbi0FEEXfQIgCuS/Fo4kU6Hb7B5Oo8jMYEd8=; b=ZO4boCkNRdCaXqn7rNcAHkogad
	rBdVduQt32asqRfXQJJ4irUqKhbp+i0Z7ETf5BZeQgfr/2iORh2Yu91oKAxS36GNjkij26fVgj05g
	XbxyQxwJglRFe1kDfTtCWC8q44coP5kO+CvpHk3uHtlkrO+zlVvK2kkS5ZxlorpISEUr/zQ/cWoXI
	jnnn3b/s8aohCnl0ux/18uHnb8Q+bKtsNhNDdhYYXlhK11MOEbXhdEqSGmCJAXh4B9sBlTmdAzKyt
	nbXH5NRxLnxlOCpYYrg2AehW9yi6en+bWdy07IAAchT9q5IaxG6nlMNSte7g6aunF1rY8KXbFs9UZ
	VS1Se7DA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFoRm-00HFte-1S;
	Wed, 20 Dec 2023 04:44:42 +0000
Date: Wed, 20 Dec 2023 04:44:42 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs tree with the f2fs tree
Message-ID: <20231220044442.GX1674809@ZenIV>
References: <20231220104734.0979a9f8@canb.auug.org.au>
 <20231220111325.5dd55e47@canb.auug.org.au>
 <20231220013402.GW1674809@ZenIV>
 <20231220140529.3979085c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220140529.3979085c@canb.auug.org.au>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 20, 2023 at 02:05:29PM +1100, Stephen Rothwell wrote:
> Hi Al,
> 
> On Wed, 20 Dec 2023 01:34:02 +0000 Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > My suggested resolution had been wrong, actually - the way it's written,
> > link count drop should be conditional on old_is_dir, cross-directory or
> > not.
> > 
> > I think the right solution is
> > 	if (old_dir_entry)
> > 		f2fs_set_link(old_inode, old_dir_entry, old_dir_page, new_dir);
> >         if (old_is_dir)
> > 		f2fs_i_links_write(old_dir, false);
> 
> Ok, I will fix it up.

Backmerge with conflict resolution added to #for-next...

