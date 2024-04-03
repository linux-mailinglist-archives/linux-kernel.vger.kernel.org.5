Return-Path: <linux-kernel+bounces-129114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B08B896527
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A50DBB22E6F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1894EB3F;
	Wed,  3 Apr 2024 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKgMFb1L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B774D13B;
	Wed,  3 Apr 2024 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127468; cv=none; b=IYWQCZQZcGnpK5rb5v0PFag4bJdTJ9JkAobjIzYtQRrISRbKxusJmm9dxK0OulC+WkSLimAofoIqOXBm8rFYdg066X3BT95jGgXoiiaieBN//XYHLSpAcoC17MtqApbhbavYH4Rj4K4/gYHfCiFtiZu7aG5ynEfS1tA+fRc463c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127468; c=relaxed/simple;
	bh=fbZOLDqzBW01pkgVzzz9lY6WFq+xUAbH4ycObG2n23g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4+F2Zd/DVDiLHBLamHu2CmzEsh8edlMvzTeECsMFUeTm/2lB016LKvV0SLKwyrcHed2h148FdxhTzgE9rw8oLN9lNOhC7ub4GpF4a4UaymRk98Og7daiIL5FAhRZCbre91IcecFOm1GHcaD7HMNjlF8pGNo86nzQTgYfqvRQWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKgMFb1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FD2C433F1;
	Wed,  3 Apr 2024 06:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712127468;
	bh=fbZOLDqzBW01pkgVzzz9lY6WFq+xUAbH4ycObG2n23g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kKgMFb1LIKC+j12fSLiwqQs8xT+o/kbWNNrBZnG3jhYvs4OLj1OdJAfQ1Bqtl8hC3
	 fKDBDsWx5dc1govFBZwiglFI4+mcaAn1pJMO/BD0N8ZOsYSyq+UY/MlLan0omRTOvU
	 zaI9dQdmfjFycR//GJwrOruaOa4d3T2z3KsX+hdpaXipxih0pDJE0b6qAmG4puO4AB
	 G+UccV8B3xbL7Qz7Oa2ZVnwIMB0FvbEzypBOSQjnQyZ+3b0pjCUhvDFjcSDuD3ZLdM
	 UYldJINtlHZEzsiB42w/JTpfUHL7uWTkythxed30Fhd3lZJSwsdtMfZH2UU9LvQe2O
	 RR97BNR3gkzsA==
Date: Wed, 3 Apr 2024 09:57:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240403065743.GS11187@unreal>
References: <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <20240401123003.GC73174@unreal>
 <20240401075003.70f5cb4b@kernel.org>
 <20240402184554.GQ946323@nvidia.com>
 <20240402143607.0357d71a@kernel.org>
 <20240402224632.GT946323@nvidia.com>
 <20240402162106.11112e99@kernel.org>
 <20240402171535.552c59e5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402171535.552c59e5@kernel.org>

On Tue, Apr 02, 2024 at 05:15:35PM -0700, Jakub Kicinski wrote:
> On Tue, 2 Apr 2024 16:21:06 -0700 Jakub Kicinski wrote:
> > they carry little weight when netdevs or traffic which ends up in
> > netdev are not involved.
> 
> Clarification before this goes into "Leon's quote book"

I don't have one, should I start write it?
And sorry for listening and remembering what people say.

Thanks

