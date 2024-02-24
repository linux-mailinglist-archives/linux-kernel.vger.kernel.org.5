Return-Path: <linux-kernel+bounces-79828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D872862741
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6011C21609
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62944CDFB;
	Sat, 24 Feb 2024 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBr4HgWU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27D44879B;
	Sat, 24 Feb 2024 20:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708805544; cv=none; b=OmM39PEtnYDCNoO8AZZC86xn/L1NIzHupur4ymEtSE6rpaKdz+ViM2GSiyNKZhhakGt4a6tfibNqV3+ZGzIrdg9cxzYntgYH3cHo7xAm7I1httbzYrvG18IGzlneJPo1VpD4XtTRqfklmANYdXmm/7LUYws8xbZbh6vMQcUT0VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708805544; c=relaxed/simple;
	bh=WDOLZasr/fMaFo5Uetg09r0Mt7rM6tIyzGnsV6eeaQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DUt+7n5HjJ1kH2wOSoEqKdXLq5TVQw8Bnfv/+3zMWqJkg5RXg6Mea2Zgy2Zeyv8btFA28HuK1lp77Vfpp4nXTPA9GPULh/2upe1UutTWmF3uEOhKe/fcvfwqr9S8ca3s4NzXko1MeNgLJiVQldGpMcv75e7WJ+llEl6B1lL7t0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBr4HgWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DA0C433C7;
	Sat, 24 Feb 2024 20:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708805543;
	bh=WDOLZasr/fMaFo5Uetg09r0Mt7rM6tIyzGnsV6eeaQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KBr4HgWUK5fXSfNw6venvBGXohAKoc8LP0ELTHOnh2t2A1v0aVzXGmhqGPmKmSGxU
	 3X+vbPq+le9YnIt8JrqSNAdITRudd6SbOV0S/U3LvsGt814GQS0uf5ENINVlQWjErZ
	 bGS+qLwIiKC3UcvD7TD7EUmJlj6WGDVuTUD/BX3s8Fo5SmRdhUY2PioiuKpyjudYcc
	 jVLrI9YgJY5sXnLAp8jtP9Sd4zlMozvR8WcjGor6Cu5mmDtwdpTL+ruZDwd0UnwcrV
	 XZZcg4QGLAbNV8w+3cn/uYNror9ZEBLRiCx4c83NSboBCtVOql6VUa6ETgHjpFXOV+
	 qQux8MJPSHmsw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Barry Song <21cnbao@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH RFC] mm: madvise: pageout: ignore references rather than clearing young
Date: Sat, 24 Feb 2024 12:12:21 -0800
Message-Id: <20240224201221.46450-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240224190724.45681-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 24 Feb 2024 11:07:23 -0800 SeongJae Park <sj@kernel.org> wrote:

> Hi Barry,
> 
> On Sat, 24 Feb 2024 12:37:59 +0800 Barry Song <21cnbao@gmail.com> wrote:
> 
> [...]
> > 
> > BTW\uff0c
> > Hi SeongJae,
> > I am not quite sure if damon also needs this, so I have kept damon as is by
> > setting ignore_references = false.  MADV_PAGEOUT is an explicit hint users
> > don't want the memory to be reclaimed, I don't know if it is true for damon as
> > well. If you have some comments, please chime in.
> 
> Thank you for calling my name :)
> 
> For DAMON's usecase, the document simply says the behavior would be same to
> MADV_PAGEOUT, so if we conclude to change MADV_PAGEOUT, I think same change
> should be made for DAMON's usecase, or update DAMON document.

Thanks to Barry's nice explanation on my other reply to the patch, now I think
the change is modest, and therefore I'd prefer the first way: Changing DAMON's
usecase, and keep the document as is.


Thanks,
SJ

> 
> 
> Thanks,
> SJ
> 
> > 
> > >
> > > Thanks.
> > 
> > Thanks
> > Barry

