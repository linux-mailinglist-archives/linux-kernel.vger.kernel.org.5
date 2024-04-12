Return-Path: <linux-kernel+bounces-141820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFF88A23DD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BAC4B23338
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AFA10A2B;
	Fri, 12 Apr 2024 02:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfrYjvO2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF320D2FE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890227; cv=none; b=Wp4hpRUTU4G1k287DMeB/vr/vyUZQPLTIIuLsBowJFe5SafEwrd8iix0OTOsq/mcboiXlTVMT881h2ugnmKbSWpdOBAbmI5ERPXKAp8wKAB9cTvjyuSks/DbigNf5SwyAbEOgLsvLS+v7qvtXsrxcVzkOZa52ACRAjl4gMhdwUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890227; c=relaxed/simple;
	bh=kjuxR8BzjV6OP/rkIJ1d1EwNgR/Yv1mV6uPaGcJvTIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXo+5VPdPWavJnUzrnPihzx4oSN7bi/TxRCPCWNZEx9RQFq9JfNMrjMVfIqzGoQ263jgARXI/YMwuUs5IBYqK27McxTaZ8i9HWRfLMjLOPQnMBD0Pu5OBb+bDgyCxWRnvCbERJXSzOKSA50DA1m/i2PHy5cog0FR8oNk3A18vSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfrYjvO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66ABC072AA;
	Fri, 12 Apr 2024 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712890227;
	bh=kjuxR8BzjV6OP/rkIJ1d1EwNgR/Yv1mV6uPaGcJvTIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HfrYjvO2m9VgxuM7NgZiMsDiuzHouTbjMiajCIR2I3hY0I+C1c+PHSiqPheAaW2y5
	 1QCm2fBdP6C5R/UDpIePxs9ZvZ3bqjUximnB0qYJb444NkI5MgAoX/kuC0+vXUhlis
	 wpg43bd6BE8HoYM9xfHgpP59SIHf7fh3ui0Fdgs/NXB3l3RAm3XMNzw6AFgAHd7pkb
	 TytTfnkh/el5xZjEKuW39ffbsACBjTzBRp4coUdZn2O/1A8SIe18LDpJLMaWwk/iVC
	 zRrXzCBLaLKbMQBlR5KxdWpTS3wM5IHLZrEffJlqrjqYa4LtmEuQPbzszegL7lrmq7
	 m2fEUyDpxShNg==
Date: Thu, 11 Apr 2024 20:50:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v5 4/6] nvme-rdma: short-circuit reconnect retries
Message-ID: <ZhihcIORmdMr0Yas@kbusch-mbp.dhcp.thefacebook.com>
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-5-dwagner@suse.de>
 <50a7e52a-c590-4281-9168-55ed7d5f2f3b@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50a7e52a-c590-4281-9168-55ed7d5f2f3b@grimberg.me>

On Tue, Apr 09, 2024 at 11:28:04PM +0300, Sagi Grimberg wrote:
> On 09/04/2024 12:35, Daniel Wagner wrote:
> > 
> > Returning an nvme status from nvme_rdma_setup_ctrl() indicates that the
> > association was established and we have received a status from the
> > controller; consequently we should honour
> honor ?

King's English vs. Freedom English? Whichever flavour or color you like,
both are fine here!

