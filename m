Return-Path: <linux-kernel+bounces-54227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359C184AC8F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D3D288849
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D8F73194;
	Tue,  6 Feb 2024 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntZ8TfnI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F6A1E87E;
	Tue,  6 Feb 2024 02:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707188221; cv=none; b=OYhE8Vj6rW8BoNJ5OuxpxBNKQ8Tz4goISZvMb2Txs+shkQzuAxvQ26LrPKZPjJXgs88wR0UJTyx0Zs1/DKRUVb5bsF7gJ01c1is5xUF4jsCOsgtgLK4UbKrkiEJYSx436wD0ev65s8az6idT+EENbDQYrym20/3dmdDhRlCB0m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707188221; c=relaxed/simple;
	bh=HmtNX7BbgjVirQJOWQ5+9UqPhN2PgLjMAc9W23kPAGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IFoUC1NB+aFsB2DzgcTV14zp3MhGItH5NkmQqHCx1wG3IbQNxfHp15oMETpcJO9umL8q6CceAf1cyrg7LCsmvbKy4y1Qror0YuiHHQncyWfrjEkLndCwf5NJnL/HnPOK+VQJJa78TAlhr1j+p4Aajq4+KEvYG+bxmZ+nxc2xKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntZ8TfnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871AEC433C7;
	Tue,  6 Feb 2024 02:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707188221;
	bh=HmtNX7BbgjVirQJOWQ5+9UqPhN2PgLjMAc9W23kPAGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntZ8TfnIyqeLdw9lHRGoflP8j9Cmq15Ar3I9cWYWl5PHrhn8ZjhVmB2bTIdwIlby/
	 vdF3xBbqUIy59dcd21K8BrhHr+69chx1qc3W/b2/js/LAIgeshG88kHFmkKzkkz2MW
	 Ce3gg5Whv3WEkI1H6SgxNwsx5Z0MI3JPdt94c5wBTuE0ALuwE4LO5iQUdmnIQ3TET1
	 Czz2m7bwwGu3clopjmL+JtMZq97yGWJpEy49DzlfJc9sz6srK1XJ23UI6PJQKEda+4
	 62hRdjER15h+TII6l1orz6Lxq+nGxo2z4uKD7/MGS2zu6r6rKRHsVx1wReCgHQIXIC
	 ko6fADKzdamGQ==
From: SeongJae Park <sj@kernel.org>
To: cuiyangpei <cuiyangpei@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Date: Mon,  5 Feb 2024 18:56:59 -0800
Message-Id: <20240206025659.203155-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129121316.GA9706@cuiyangpei>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Cuiyangpei,

On Mon, 29 Jan 2024 20:13:16 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:

> On Sun, Jan 28, 2024 at 08:28:04AM -0800, SeongJae Park wrote:
> > On Sun, 28 Jan 2024 17:13:00 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > 
> > > On Fri, Jan 26, 2024 at 12:04:54AM -0800, SeongJae Park wrote:
> > [...]
> > > > So, 'update_schemes_tried_regions' command is firstly handled by
> > > > 'damon_sysfs_cmd_request_callback()', which is registered as
> > > > after_wmarks_check() and after_aggregation() callback.  Hence
> > > > 'update_schemes_tried_regions' command is still effectively working in
> > > > aggregation interval granularity.  I think this is what you found, right?
> > > > 
> > > Yes.
> > > > If I'm not wrongly understanding your point, I think the concern is valid.  I
> > > > think we should make it works in sampling interval granularity.  I will try to
> > > > make so.  Would that work for your use case?
> > > > 
> > > It's much better than working in aggregation interval.
> > 
> > Thank you for confirming.  I will start working on this.
> > 
> 
> Great, looking forward to seeing the progress.

Just sent a patch[1] for this.

I also updated DAMON user-space tool, damo, to use this improvement[2].  I hope
that to help others who using DAMON with their own tool to easily understand
how they can get the improvement from this patch.

Also, please feel free to ask any questions and/or help.

[1] https://lore.kernel.org/r/20240206025158.203097-1-sj@kernel.org
[2] https://github.com/awslabs/damo/commit/75af3a1c0b3e79cd3207f0f8df5b5ac39f887450


Thanks,
SJ

[...]

