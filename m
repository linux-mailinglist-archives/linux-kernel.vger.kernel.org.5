Return-Path: <linux-kernel+bounces-79898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3444D86286C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 00:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1ACF1F214EF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 23:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB384E1CC;
	Sat, 24 Feb 2024 23:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWf3ruTV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ABF4E1A0;
	Sat, 24 Feb 2024 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708815988; cv=none; b=S0uCPqdT4dfu+qybFEY7dYRCoSFn3VxzOcvNsCSlYiZcl1x9zJp8dXSOxIuUNts4OreyWzcIgS0uzKgNDLokWudJhfa4g3mZt+PbCAeCoMhbJDAuKkP+hsUWaauAMb+G0HV5z0D62D4vgFX9I2wJSLpSSag/8o7tckicma/om2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708815988; c=relaxed/simple;
	bh=ipZ3S6x+zDFBWffwDlpccmDom9xodFz7XMd0jmhcrwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fGajisVKNrOkAfEuaHluS7ePeHZ/hiX8QhstZoaFLZTXHwoI8+QC6P4U6d7nJ3DwfSxXeasWZHOv3N9wHdDDf8H6Rz9xfovFxt+0M1dQuGLCrp4lNKQ7znTl0RWFuTLL3kGOq61m9gR0bua+LHKss9aEv7VdPUZawjnwbSOdNo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWf3ruTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59801C433C7;
	Sat, 24 Feb 2024 23:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708815988;
	bh=ipZ3S6x+zDFBWffwDlpccmDom9xodFz7XMd0jmhcrwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nWf3ruTV4tptHvrjYGVCqoqVlUqPmLz5kimBfDtwgWYhYmgRqWXqsHnZtjPC6YC89
	 QdeUxof0G17IUytB7tHCfsiOqY5hkaDavptZJoHkI6UeUdrAvvp25s215Qb8gox/Yk
	 1xYqiIylIjyqA2xKDzV/ISpcOAe9E8+BAG8F/1vNhGKnAVKdjogsNNLi/f69LMqtZa
	 io8MYydrWuFUBtWIyuPIZAgDaZyBx8SSon8tU/WpnYkKRFqf+GcHgNgvrW0m9Kl7jh
	 9JukdM8/eUpvG2YyiAlUqYmv6Abbj/jXtvb+4bJ+0F8ytFqCwkTns/3hV0qvrd/ITY
	 3V/JP+k9wEEaA==
From: SeongJae Park <sj@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: corbet@lwn.net,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	SeongJae Park <sj@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2] Docs/mm/damon/design: remove the details for pageout as paddr doesn't use MADV_PAGEOUT
Date: Sat, 24 Feb 2024 15:06:26 -0800
Message-Id: <20240224230626.49710-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240224224751.4673-1-21cnbao@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Barry,

On Sun, 25 Feb 2024 11:47:51 +1300 Barry Song <21cnbao@gmail.com> wrote:

> From: Barry Song <v-songbaohua@oppo.com>
> 
> The doc needs fix. As only in the case of virtual address, we
> are calling madvise() with MADV_PAGEOUT. But in the case of
> physical address, we are calling reclaim_pages() directly.
> MADV_PAGEOUT on virtual address is much more aggresive to
> reclaim memory compared to reclaim_pages() on paddr region.
> This patch removes the details so that the description can
> apply to both cases. And we don't need to couple with the
> implementation details.
> 
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  -v2: decouple with the details according to SeongJae
>  -v1: https://lore.kernel.org/linux-mm/20240224215023.5271-1-21cnbao@gmail.com/

Thank you so much for your work!

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

