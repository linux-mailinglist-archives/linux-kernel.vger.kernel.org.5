Return-Path: <linux-kernel+bounces-133268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDE589A17A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D52E1F21398
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F0C16FF48;
	Fri,  5 Apr 2024 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fX4f7mvk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC21DFE4;
	Fri,  5 Apr 2024 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331509; cv=none; b=kFkY5pHm8D/wbUrvWyrNb+IPH996GimiWjmg+beAIqUP/4f8EU33kvKoyFf6Ax3z9HI/5i8EEgFa3nmc27y5rABgVWTSWMnXR/u9Mz1Aps/PmYy8QjzeTyTKVkGBM8cpZgiQLObLdL5n3zcZ0n+YjJRK4c+0KPzqOtf3axkEec0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331509; c=relaxed/simple;
	bh=SLR/RVRSymKoE8wF+rB14kjDMnu4WghtYjbSERDK7kg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNUhnZPsZENDWem3dkAftHUK+qcChLE99W4W2u97F8oMbCVf1skXJ5KiflwprwoWlbVIEvIwd6s87DyoqlSRFeFaSKozQgbvemW/rJ8Ax7OZmvYVQHhljAmsRzIYfyhlDxsHQQvtnh0OBU4DIfaIRFnumeTc+ANaK5zooVK2I+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fX4f7mvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD3CC433F1;
	Fri,  5 Apr 2024 15:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712331509;
	bh=SLR/RVRSymKoE8wF+rB14kjDMnu4WghtYjbSERDK7kg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fX4f7mvkILOTifgU94c7k7RInvoSeEfBhfb3dTGvIQH773WAHwc68TazUGQBVCaV3
	 X4019oi99/HUzjvdxnpgiXDkYtJj84lJgEiDl+eEh9eZQWPlgp1CI0u4TR4XhFcwkV
	 Eoo9QveOFSkplinw+nIOS+CVVcOu7zVdA7kyT7F0TGV8AKtWrj7AICqkyVvmjNdCKI
	 JkOK1g5NqCyK3rwAPLGC6CZHT6hwU0Mf59t/c45oTDhgwtbcQ5JQEYbAdCbmEgs3As
	 L5AmSAU+duyTnN/z+huGHv/7f7+csyiCf7loGfbLwfaua3UuDp9kzaQh2OQdAsa4pz
	 DXTNqPR1LRhmQ==
Date: Fri, 5 Apr 2024 08:38:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>, David Ahern <dsahern@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christoph Hellwig
 <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>, Itay Avraham
 <itayavr@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Aron Silverton
 <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240405083827.78cc1b20@kernel.org>
In-Reply-To: <20240405111306.GB5383@nvidia.com>
References: <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
	<20240322154027.5555780a@kernel.org>
	<1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
	<0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
	<20240402184055.GP946323@nvidia.com>
	<83025203-fefb-d828-724d-259e5df7c1b2@gmail.com>
	<20240404183305.GM1723999@nvidia.com>
	<20240404125339.14695f27@kernel.org>
	<20240404204454.GO1723999@nvidia.com>
	<20240404143407.64b44a88@kernel.org>
	<20240405111306.GB5383@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Apr 2024 08:13:06 -0300 Jason Gunthorpe wrote:
> As I answered to Anderew, a lot is functional behavior not so much
> "tunables". The same way many BIOS settings are not all tunables but
> have functional impacts to the machine. Like enable SRIOV, for
> instance.

Thanks, SRIOV is a great example:
https://docs.kernel.org/next/networking/devlink/devlink-params.html#id2
Literally the first devlink param on the list.

"We will flash it for you" seems to be what vendors like to offer.

> Even for dataplane tunables - you know there are micro-architectural
> performance tunables set in the special Meta NICs that are wired just
> for Meta's special use case? Apparently that is actually perfectly
> workable.

The only "tunables" I'm aware of were for the OCP Yosemite platform,
which is an interesting beast with 4 hosts plugged into one NIC,
and constrained PCIe BW. Which is why I said the "tunables" are really
about the server platform not being off the shelf. Updating NIC FW
to fix server compatibility is hardly unusual.

> It is really strange to hear you act like "Meta doesn't need
> provisioning or tuning" when the NIC Meta uses is *highly* customized
> specifically for Meta to the point it is an entirely different
> product. Of course you don't need provisioning, alot of other people
> did alot of hard work to make it that way.

:) When you say *highly* I think I know what you mean :)
It'd be unprofessional for us to discuss here, and I really doubt 
you actually want to air that laundry publicly :) :)

> So please don't use that as a justification to pull up the ladder so
> nobody else can enjoy even a semi-customized device.

So in this thread I'm pulling up the ladder and in the fbnic one I'm
not (as I hope you'd agree)? One could hopefully be forgiven for
wondering to what extent your assessment of my intentions is colored
by whether they align with your particular goals :(

