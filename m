Return-Path: <linux-kernel+bounces-156224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3044A8AFFE2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B48D2B22766
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B36813C8F3;
	Wed, 24 Apr 2024 03:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKLBrxBE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B1813A269;
	Wed, 24 Apr 2024 03:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930153; cv=none; b=rqs65lynoWTtjo1yZpuz+utxrSuFajJpvVBVprdCyIdIOWHgWlh61et3nqL63CecFohouy3rXfgZA00qJQwrKrOfCb4QA7AyVicGmLNDCUh829vCQTJaVXajmAnXqDkomPDUj8Ct04Ktl9gTLJ+ScLAQDvAGgi3DerrogapJrvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930153; c=relaxed/simple;
	bh=s8JSpe5lXZIlrGkV5GrE8eLt0SRuwdFk9Gns8mE2/uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvldpornClj1oEbG0c0xAqrBfPex6PpRI2wYdO4eMZJirwn7lopVDBItu7db3LDetkDnZQjMyHQ5OVANC05wu5bCP6vGkVsTaJtjMyipSIqm7zuLoIhMpQg/d1DzpzXl973Lu0gfl8JKMNz1Rt9Mo60B+vSKYpGGG/3QRETjivw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKLBrxBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47F9C3277B;
	Wed, 24 Apr 2024 03:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713930153;
	bh=s8JSpe5lXZIlrGkV5GrE8eLt0SRuwdFk9Gns8mE2/uE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LKLBrxBE4M7LMlIiN0mpe0WQXkYqSkcPKHWIC0yWrZ2AIkZ/coaC7iUCQEMGzJUUA
	 1/rPwZJemR5Ur2J68hnvh9UaEfiTYrna3fV27pQ8gF5zkFQLRZBCvScXskr5VHxp1j
	 cxlsT++NSh96ve3UUgbGsnRAcWCaQLzVUu55lgMMvA+UyAqfjvY237MKgzkTsF9mp9
	 2sW2gpDdA0I+i8eQuh4nLMu48yzroqp8UBHWW/4VNSU1HHYHzYFGa3aFqZlUDrHPPz
	 yOjWh7cUnj+EpiV9Ug+U7qzQxbQy/ytauTBynUKUiTj8KQ6YQnDt5SWUPWHDSNpLtY
	 HSSQu1Cj51uCw==
Date: Tue, 23 Apr 2024 20:42:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Marius Fleischer <fleischermarius@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Leah Rumancik <leah.rumancik@gmail.com>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, harrisonmichaelgreen@gmail.com,
	syzkaller@googlegroups.com
Subject: Re: KASAN: null-ptr-deref Write in xlog_cil_commit
Message-ID: <20240424034232.GD360940@frogsfrogsfrogs>
References: <CAJg=8jz0X=CKR1POvF41oEumrq1z=MVWPdF2ECbzV6-rhht8-g@mail.gmail.com>
 <ZiGYbJezGZg6tGgq@dread.disaster.area>
 <CAJg=8jycPX=fQskUb=48g=AS7-uUNAVKZyZ+tyAC5uGYwfpabg@mail.gmail.com>
 <ZiWl2MG5f0wAp7mM@dread.disaster.area>
 <CAJg=8jyZuxsUX+oNU6O_L4LNOVs21xVKTDi8ywPfDbj+cAxegA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJg=8jyZuxsUX+oNU6O_L4LNOVs21xVKTDi8ywPfDbj+cAxegA@mail.gmail.com>

On Tue, Apr 23, 2024 at 08:05:22AM -0700, Marius Fleischer wrote:
> Hi Dave,
> 
> Thank you so much for your detailed explanations!
> 
> > > Do you think it would make sense to backport that patch to 5.15.156 (the
> > > LTS kernel)?
> >
> > That's up to the 5.15 LTS maintainers to decide. They also need to
> > weigh up the fact that xlog_cil_kvmalloc() doesn't exist anymore in
> > the upstream code base. i.e. we found other places that had the same
> > kvmalloc() performance problems, and so lifted that code up further
> > and used it in other places in XFS....
> >
> 
> Understood. Please allow me one last follow-up question. Did I add the correct
> maintainers/mailing lists to reach the 5.15 LTS maintainers? If not,
> how do I find
> the correct addresses? I used scripts/get_maintainer.pl as suggested here
> (https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html)
> to locate maintainers/mailing lists.

You got it correct -- Leah is the 5.15 maintainer of record.

--D

> Wishing you a lovely week!
> 
> Best,
> Marius

