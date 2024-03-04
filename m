Return-Path: <linux-kernel+bounces-90457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 763E986FF6C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319D32850A2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131DE39859;
	Mon,  4 Mar 2024 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GXfakCda"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E35E38FA0;
	Mon,  4 Mar 2024 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549338; cv=none; b=QQJGnWL+U0WAvfogMA3ALzd8TXbsRivgnPseY1npoz8D+1KlNNH6xXobFpynXPfnilQlShv1HfRIlEGu0LNkG5pkSU9XUr/LSwfUaM+STPtIJwdZkiqiIpbbXGwCKr8BMvB2QlRBGRGdt4x8sYnCGREyUSoV/LedMR6Tbux0HjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549338; c=relaxed/simple;
	bh=9CRzSnUxCADHGSf4ROldZkRv1p7amv4W/QBk5HAlgIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iv/c3GQXhyjiM2TCwTq09TolNPvcsCqCY+xfbX3qCKlJQb6ZPeZ3PzT2KmPpcNR/gQINDyil6oQtHF6fEMKNaLlfSn7tYkm581knfSIfhAlftoN7MgWODPx4xWgSja+yhgb5LyBpiJtvGHlciZ/qQa0BGF8l5INkGEQlGRPCC9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GXfakCda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83B3C433F1;
	Mon,  4 Mar 2024 10:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709549338;
	bh=9CRzSnUxCADHGSf4ROldZkRv1p7amv4W/QBk5HAlgIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GXfakCdaeON+xoPZzd9ddQQQAOjxak1Wx+/JTj8pSNiQdkFeSDTOa8oJShfagW7cf
	 FyxYBxdUuzaj+2AReqyQSNZJIovulnFyLFwyAlWXV+cattPgu+10STcfSTFc20t9i3
	 wSnubIqJwumJLQkMt1J5gxwNUe7a2qNY7SPuy+XU=
Date: Mon, 4 Mar 2024 11:48:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
	vbabka@suse.cz, dhowells@redhat.com, surenb@google.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	# see patch description <stable@vger.kernel.org>,
	Huang Ying <ying.huang@intel.com>,
	Naoya Horiguchi <naoya.horiguchi@linux.dev>
Subject: Re: [PATCH] mm/huge_memory: fix swap entry values of tail pages of
 THP
Message-ID: <2024030444-unfreeze-crystal-1ccf@gregkh>
References: <845ca78f-913b-4a92-8b40-ff772a7ad333@redhat.com>
 <bc1a5e36-1983-1a39-4d06-8062993a4ca4@quicinc.com>
 <ZczLoOqdpMJpkO5N@casper.infradead.org>
 <f2ad5918-7e36-4a7c-a619-c6807cfca5ec@redhat.com>
 <30ea073d-0ccf-46e1-954d-e22f5cbf69f7@redhat.com>
 <1ABD022A-35FC-4A6E-ADAD-36F3D745FB91@nvidia.com>
 <42be658c-cb13-4001-aae4-8d8275a84038@redhat.com>
 <ECEF5EF8-3328-43AD-9E0B-7AE325368CB7@nvidia.com>
 <07A26237-B17E-4418-9A19-E86F450B9695@nvidia.com>
 <acdf3d44-b20e-8491-6302-bfb1b354bc62@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acdf3d44-b20e-8491-6302-bfb1b354bc62@quicinc.com>

On Wed, Feb 28, 2024 at 09:06:19PM +0530, Charan Teja Kalla wrote:
> Thanks David/Zi Yan,
> 
> On 2/27/2024 9:45 PM, Zi Yan wrote:
> > So likely we'd have to fix the stable kernels:
> > 
> > 4.19
> > 5.4
> > 5.10
> > 5.15
> > 6.1
> > 
> > That's a lot of pre-folio code. A backport of my series likely won't really make any sense.
> 
> So, I assume this is a consensus to have stable-only fix for this issue.
> 
> > 
> > For v6.1, the fix would like below?
> > 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index c93dd6a31c31..c5968021fde0 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -423,8 +423,12 @@ int folio_migrate_mapping(struct address_space *mapping,
> >         if (folio_test_swapbacked(folio)) {
> >                 __folio_set_swapbacked(newfolio);
> >                 if (folio_test_swapcache(folio)) {
> > +                       int i;
> > +
> >                         folio_set_swapcache(newfolio);
> > -                       newfolio->private = folio_get_private(folio);
> > +                       for (i = 0; i < nr; i++)
> > +                               set_page_private(folio_page(newfolio, i),
> > +                                       page_private(folio_page(folio, i)));
> >                 }
> >                 entries = nr;
> >         } else {
> 
> Similar to this is what we had tested[1] internally and observed no issues.
> 
> Can this be taken to 6.1, please?

Someone needs to submit it properly and get it reviewed by the relevent
maintainers.

thanks,

greg k-h

