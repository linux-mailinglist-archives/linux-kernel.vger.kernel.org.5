Return-Path: <linux-kernel+bounces-66367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F16B9855BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EA51F27C58
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5453101CE;
	Thu, 15 Feb 2024 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iE9KG+M2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4B9DDAE;
	Thu, 15 Feb 2024 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707982486; cv=none; b=DOMDk5jIuig1aXYda8ncJngcyvU+KslF3HCgaCgF4wTeXlFzrXkvJju5EM4vd0XziI0u78dm5nAaBmDGXW0OAmGEPUTrjCL1n+8VZkrUWGu7xn6yglP7NGdwKp35UV9EHDwL6/j0x6cGCM88xF71X99XPVxsc6sJeLjb8Pd0p10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707982486; c=relaxed/simple;
	bh=d+coCdfl5TyzHkk2WHZ+6VQlZcOEjRLYjvg5P+9S/hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkDnspBlCm/QWNZmsRQVvBT9zAdy6U+Ny9ug178zSym19bRjThb/5zE4gYuVQAMmkMa61SFekVQfy08/CkflC00iBXsy6tLs7jxzYbIXqcNglLUTB7g/1/UGPWSwXqlQZXLaYJiRPdTYG8tB1v+lJl3zgtDahlsHCIZ3AzjByJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iE9KG+M2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861E8C433C7;
	Thu, 15 Feb 2024 07:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707982485;
	bh=d+coCdfl5TyzHkk2WHZ+6VQlZcOEjRLYjvg5P+9S/hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iE9KG+M2oePyVUW3RrTA0ExjRqKVcdYIfbnqEtUrmCKOvA0eQ2MPYQhk99pnediQD
	 TknsEmBjtw7UbFKznE+PoJzrSX9j7C+uH4OrHqSjTehLZt8FWI13FOvIqrUYYsMR5U
	 qg3NZboZQhqFrvswRID5EYi1dNWSfXYoOeLbAz/mXq0fQnaRhow517pXOCwyb4eNIZ
	 fWUu83J1E8wkdWc6ssdus8cNUnrB1GORbs/l39QoUHc4Vb5EuAcfTBGA6wVb3lnol/
	 u20DWpibC0Wii+RMLczbYihIqWOq3dWoQYcOygFlTYSerrw9578QnJLjF5S8/+5Y4g
	 Br7dpYR86wGDA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1raWGv-000000002Gp-4Agb;
	Thu, 15 Feb 2024 08:35:06 +0100
Date: Thu, 15 Feb 2024 08:35:05 +0100
From: Johan Hovold <johan@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Andersson <andersson@kernel.org>,
	Jordan Crouse <jordan@cosmicpenguin.net>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm: Wire up tlb ops
Message-ID: <Zc2-qVd0gtErdbKe@hovoldconsulting.com>
References: <20240213172340.228314-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213172340.228314-1-robdclark@gmail.com>

On Tue, Feb 13, 2024 at 09:23:40AM -0800, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> The brute force iommu_flush_iotlb_all() was good enough for unmap, but
> in some cases a map operation could require removing a table pte entry
> to replace with a block entry.  This also requires tlb invalidation.
> Missing this was resulting an obscure iova fault on what should be a
> valid buffer address.
> 
> Thanks to Robin Murphy for helping me understand the cause of the fault.
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Fixes: b145c6e65eb0 ("drm/msm: Add support to create a local pagetable")

Sounds like you're missing a

Cc: stable@vger.kernel.org

here? Or is there some reason not to backport this fix (to 5.9 and later
kernels)?

> Signed-off-by: Rob Clark <robdclark@chromium.org>

Johan

