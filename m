Return-Path: <linux-kernel+bounces-97287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C97FF876849
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F68F1F2199F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3450364B8;
	Fri,  8 Mar 2024 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcftqML4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F118567A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914839; cv=none; b=MrztNP0JwsfFrBrD8PpYrA1wDyr59mhF9zQgKCNjWTy0uhtbf0etoOEJvL+5R47a5rVM+m+PXRnIFsDrjULXeD2+o5/ENh3JUQ1iWtRQCwjtMz5WgaTltW3Q9LLPsqRCF5rjK9HqGcpDqXN2F92mHGf7scDgaVXRM4zn9XQoJ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914839; c=relaxed/simple;
	bh=ErpHc1wY2DdF0bf6Q9UhJU+DPezctKIzUn/CC0SyCKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GO4iLEYHOYy7tVOZ2yPtEBN5Xi2wxySMxXgBSco4tT61FczoPyOvj/0h3AmLcgKHePTkBSlW6xEex/9Fae8HYzuFHR3VmEdcw+SY288RiY0RtFlrJBabuAT/lUrHAhZtql+ScG1Lkh11l761mTkVD8EIxAWuAsAR/KzAznpl36U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcftqML4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635FFC43390;
	Fri,  8 Mar 2024 16:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709914838;
	bh=ErpHc1wY2DdF0bf6Q9UhJU+DPezctKIzUn/CC0SyCKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcftqML4aYCJ5wrz0uu5BBH9gaoV9MvwoV276F4S11oCaZqboUhjY8CrCn9U6yMt3
	 Xao+TGXrMjCwLUM5qGHwZDJOgDnpU2P6MdClwIi+W9iY1TX5nF2k+1+45NXAy3Mqlr
	 kMWjz5Klrr0zJpfnI55ZhI4/OngZE2BSVSXLPSOgT+Vy4ABF8ABkGjquar8msAzYlc
	 XIS5Nka79VrF+wDO9D1Bzp0OSHCZUNJuvk7bqBk6aU6fiJkW3lKdXP5/yNLDSA0I+Y
	 m9RC9e37ZqNK5HXUqJO03WQNcq3fkf9Zi37RMERRKsRJRRbkb8O1Bn4XYA+Jz53+N/
	 SCdzMMMdTZV7g==
Date: Fri, 8 Mar 2024 09:20:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme: fix reconnection fail due to reserved tag
 allocation
Message-ID: <Zes61DCKaSF9qmb7@kbusch-mbp>
References: <20240308015435.100968-1-brookxu.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308015435.100968-1-brookxu.cn@gmail.com>

Thanks, applied to nvme-6.9.

