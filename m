Return-Path: <linux-kernel+bounces-151983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FE48AB6FA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D15B1F22790
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0567F13D276;
	Fri, 19 Apr 2024 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uu3KUtWi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F312AEF5;
	Fri, 19 Apr 2024 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564042; cv=none; b=RSk78jtauCBX63fyUkEUPma8UY6HMvhPrtF2Q9ZqF10idBOodAdOZMUnodc0zNidG3reZxFjct2EK96Kj58u0Zt+wjQpCwFHnjnKFd4bp/I0aVz2NqP70BB7YkZzbwdN4qCl/u7dCVTfoHsa/jihi0b1aNyCAIm7E2D0TmMzOgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564042; c=relaxed/simple;
	bh=e+RieVnA3hjN6enTEczMlaoz6mdoSbqpSZrNaU4Wc5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btiYBGCkF3HN9p6yutQj1r1sTXGZzFaslRpihbGxoakJ++3dY3PLsYJxNGt97dKAWrK7D+/NbdQBAXReN0zcxQADdByOuHxo9EzR4459pe93F3O3/OLKmrLmZdyXzSB3WrIKV9Jb2qQy+pQS6F6SSvmGBh0y0rA77azu0HvRqP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uu3KUtWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17FFC2BD11;
	Fri, 19 Apr 2024 22:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713564041;
	bh=e+RieVnA3hjN6enTEczMlaoz6mdoSbqpSZrNaU4Wc5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uu3KUtWiWvzm3piIOX3QhuF6wBcNs0cIInRxGD+UJpkiScGba3xQ4tfpXDGN+iPn+
	 aM4ASyLh+L0qoqt+5EDO6OLFhCh0mrAhWTVcLcTEsDaHnFpj3cZbDQLbvA4CLUFSeS
	 gtH9uMm6j9gdhl1lFxrwID/Yml9RRWlrs7vmowCOq6uGYSpjgCGto4sLuFdK4ZIN2B
	 vXlwnSNgVCOajAjH6gCTcubyLpEw8W1hD3GnNrSIpnDxnskFtE8tv9OKEQUhhcgP2y
	 CW/HUWlTr5NUYp4xhWMPG8BUNZKi67lMJCqN/b618yNznz9dzmjYiQJ33jhLX8yCv7
	 XM5nsCffiomSA==
Date: Fri, 19 Apr 2024 17:00:39 -0500
From: Rob Herring <robh@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Joerg Roedel <joro@8bytes.org>, devicetree@vger.kernel.org,
	Hanjun Guo <guohanjun@huawei.com>, iommu@lists.linux.dev,
	Len Brown <lenb@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Saravana Kannan <saravanak@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/4] OF: Simplify of_iommu_configure()
Message-ID: <171356401937.4050152.4689174677404854642.robh@kernel.org>
References: <cover.1713523251.git.robin.murphy@arm.com>
 <7467a9487b23ebae62d4bda73b9c736d3cb3c68c.1713523251.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7467a9487b23ebae62d4bda73b9c736d3cb3c68c.1713523251.git.robin.murphy@arm.com>


On Fri, 19 Apr 2024 17:56:01 +0100, Robin Murphy wrote:
> We no longer have a notion of partially-initialised fwspecs existing,
> and we also no longer need to use an iommu_ops pointer to return status
> to of_dma_configure(). Clean up the remains of those, which lends itself
> to clarifying the logic around the dma_range_map allocation as well.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/of_iommu.c | 29 ++++++++++-------------------
>  drivers/of/device.c      | 30 +++++++++++-------------------
>  2 files changed, 21 insertions(+), 38 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


