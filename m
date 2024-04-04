Return-Path: <linux-kernel+bounces-131980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2905898E35
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6C31C280DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AAE13174D;
	Thu,  4 Apr 2024 18:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o1RU9G+L"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062AE130A58;
	Thu,  4 Apr 2024 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256312; cv=none; b=HKjTbIoZfXNtP1Kd+wSzDXfVuTpYkstoBQMGsMqNsCk5O9DEPePFPjdslEU2H7Sp3NjkcqbZe7/iGecCYMDTJ3aBQZ0f2cZNUtre9UwuFAnUkwiDwOPoQNii33+Cfv9dRrCHdBPvMJTxU46iZni+jaWOh5gVkqq3o+UyEBSzzKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256312; c=relaxed/simple;
	bh=9jCBrhNstJ9OpeTiONJ72P8Fyi5aZIC9DGHF2/FQClA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVq83gDXhkRY8rQPGqBSBLj1niNRfLBdUbql9bJhZaZXV4+nS2M15Tpn5YfoSKjnIfIbtlFQNoCymk5eYe2eU3lcuKC1OcCJCpcrZsfnx6nTzcDcR/LUUhJo+PTV1Cea7DXmq04xYLWlySni8SDmCSjVqKRdKKKanMs/vUkL7BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=o1RU9G+L; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LRi2qzcVuKZxMgmroXul3qTCG1ZWNhOj3m2ExKQ8xaM=; b=o1RU9G+LGIsnurLagzL4CCX6/t
	Uypb4+Q+/nrr+m2V/GMjYuvjvn3JS8TPj/3EgLnIx4kDbvb2L3htC873DGDsn0trQOZDrym/TPX92
	5/RqcbcR7QkbW0bnvbA0PXH6Cipcan9bdILsQC/ER8xQXvFSJdBkxUo+4+teVZUrItXU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rsS52-00CD25-O9; Thu, 04 Apr 2024 20:44:56 +0200
Date: Thu, 4 Apr 2024 20:44:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <b8f2f824-e8da-4767-a378-b20bc42d4e8f@lunn.ch>
References: <2024032248-ardently-ribcage-a495@gregkh>
 <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG>
 <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184055.GP946323@nvidia.com>
 <83025203-fefb-d828-724d-259e5df7c1b2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83025203-fefb-d828-724d-259e5df7c1b2@gmail.com>

> > There are something like 600-800 configurables in mlx5

I keep seeing that 600-800, and thinking that 2 to the power 600 is a
very big number, assuming they are simple on/off configurations.

Does any user actually have the 'optimal' configuration? How can they
even know?

	Andrew

