Return-Path: <linux-kernel+bounces-118045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C3288B2E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14013246D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86826EB52;
	Mon, 25 Mar 2024 21:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RuYzC9qi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5236D1B3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402500; cv=none; b=t7Py0te2IJq1l+X7m+l0/hw/PyrV2GQaWwSfVjPM7KV0+KJaXt9NVVwOolPScC5zH6xVh5KoD3+sK8wJBaytj0QrrfbEtwWPSJagEjtNlzWieKZUc1Mu9CWeGHQ5gZnXAgKXxl7VPF42w9JSAN+GAX5qaO6SH3B4jJug4IqK6fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402500; c=relaxed/simple;
	bh=I4mvest4t4KAdCw70D9fYPAhnxVyoihg1UAIm7CADd4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ArOjhi7B9dh2DsGmV5R+sDftqIeAU2DXvZ3UavDdqgcoggmt6QQsw0gredWGeUJQvL2BdHqOtE5ToymGKY/610XFFNkW42WKkgrJq296b8y+wvV4VQwLCdp3YLKHFepum5RhnOc1ar7UvSpksGDhKcE+sY78eBw3wQmjvNX1B1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RuYzC9qi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3598C433F1;
	Mon, 25 Mar 2024 21:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711402500;
	bh=I4mvest4t4KAdCw70D9fYPAhnxVyoihg1UAIm7CADd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RuYzC9qi9PxrQjHu5e8RejI3EH7Faq2g134nOGIYQZlXoyNgWUYw0q0EZ/MygXK01
	 L5+RuD1304D8nIN86WlXmWaVRQGr8O5xAIw/JljEu78Vj6NbjisCmasnHyYF4yJBKn
	 ZjPepCvv5cHV7Ix1DEuf68XuNuZ5Xw+eI9PvWejw=
Date: Mon, 25 Mar 2024 14:34:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chris Li <chrisl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Yosry Ahmed
 <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Chengming Zhou <zhouchengming@bytedance.com>, Barry
 Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v8] zswap: replace RB tree with xarray
Message-Id: <20240325143459.8ca399708bbbc7eda997585d@linux-foundation.org>
In-Reply-To: <CANeU7QkDuXeR8MzKvnPcN5odkpDQJ3bMW_nSRHbZGffPkiXW-Q@mail.gmail.com>
References: <20240320-zswap-xarray-v8-1-dc08ee9f8744@kernel.org>
	<20240325133546.ffd728d1c309ba58eadb179c@linux-foundation.org>
	<CANeU7QkDuXeR8MzKvnPcN5odkpDQJ3bMW_nSRHbZGffPkiXW-Q@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 14:29:41 -0700 Chris Li <chrisl@kernel.org> wrote:

> > That fix is cc:stable so we do want it to have a clean run in
> > linux-next before sending it upstream.  So I'll drop this patch
> > ("zswap: replace RB tree with xarray") for now.  Please redo it against
> > latest mm-unstable and of course, be sure to preserve Johannes's fix,
> > thanks.
> 
> Sure, I will wait for your mm-unstable update that contains Jonanne's
> fix then re-submit a new version.

Thanks, I pushed it out a couple of minutes ago.

