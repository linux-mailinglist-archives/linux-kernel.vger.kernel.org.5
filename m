Return-Path: <linux-kernel+bounces-143500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE1C8A3A3A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E307283E73
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 01:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA9A18039;
	Sat, 13 Apr 2024 01:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4qtFcMa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905E91758B;
	Sat, 13 Apr 2024 01:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712972684; cv=none; b=WfX8Hd5e4XUD4gW5PbCPrrhFeOvHeldo+Y1mCSXq9upoiOmtDMwRlZWpes2CC7oZb9NbgMHZ7RbGgvdJj/jcXGs8Hbzdhtc91rwHFYU60flrIjOBtFbaWTKP2oOwxLdwt01yh55axM29CgNDgul1dj+kmVQaTvgVGEOOR03WnRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712972684; c=relaxed/simple;
	bh=sGErZXyr/YdrYfCuD5psfBudy0tjfQVP+V5GzMrYuk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2+30cjSnD5FwPUmil4Cn/ci0XkLqvhuo4nLQlY438WXIJc9cqcOXE0wOiqtBOm65qyHrRs/W/yLiYWK/MmVhmlSGkT8WAy6QmKV9jRKgHX4O8HmvrTvFZamL55aWb5VEhE0pfCnwbY1sTXOqScxk0de2TqlTPpwwLGwMACUOZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4qtFcMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3191C113CC;
	Sat, 13 Apr 2024 01:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712972684;
	bh=sGErZXyr/YdrYfCuD5psfBudy0tjfQVP+V5GzMrYuk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q4qtFcMacjqD98Dkv4BFueEEQ1M5YqRHiDswvRgAkd7QUNYmC8SoKE+cVZzRl1g5+
	 xLcULigzqPGMxkgHR++YfSH0PElXc2JrueYkeZPX8oH+Nz695Nx/IQH6IOR5tEEU+L
	 kA7wmUIO2NKaCsS7ijiYPoz0kt1px2m4o1KpxhNro1ysrW0FOZd6RQrgP2KfwHQ9lO
	 +BLKcclvEb71FjKFlgyHEy/nVcDT4gWF+HZblXn3pkgtwzeivbntFY76sX2+LYkRET
	 4cqCjrWeGhUDEs0TccvElWYtZBDUNcs1ZZjSvs+WLdS7YyD8XJaDjoqzfg1rVffjOV
	 iN/mzkpTo0kqg==
Date: Fri, 12 Apr 2024 18:44:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Cc: Hariprasad Kelam <hkelam@marvell.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "davem@davemloft.net"
 <davem@davemloft.net>, Geethasowjanya Akula <gakula@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>, Linu Cherian <lcherian@marvell.com>, Subbaraya
 Sundeep Bhatta <sbhatta@marvell.com>, Naveen Mamindlapalli
 <naveenm@marvell.com>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [net-next PatchV2] octeontx2-af: map management port always to
 first PF
Message-ID: <20240412184442.26417b54@kernel.org>
In-Reply-To: <BY3PR18MB47373F66158D5E98147EDFCDC6042@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240410132538.20158-1-hkelam@marvell.com>
	<20240411195532.033e21fb@kernel.org>
	<BY3PR18MB47373F66158D5E98147EDFCDC6042@BY3PR18MB4737.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 12:07:40 +0000 Sunil Kovvuri Goutham wrote:
> Agree, that there is no concept of management port in Linux.
> From Octeon hardware pov, there are multiple MACs and each MAC (internally called RPM) is capable of supporting multiple interfaces (called LMACs).
> Let's say there are two RPMs on the board and RPM0 is configured to 2x50G and RPM1 is configured as 4x10G.
> When kernel boots with this config, let's say the interface names are eth0, eth1.. eth5.
> If user is using 'eth3' for NFS, DHCP, SSH etc (ie for device management purposes) and then if user changes RPM0
> config to 4x10G, then in the subsequent boot the same RPM1:LMAC0 could be named as 'eth5' now.
> Customers have reported that their scripts are not working in these scenarios and they want some predictable naming.
> 
> What this patch does is that, RPM:LMAC0 which customer is using for management port is always mapped to 
> same PCI device, so that interface naming remains unchanged irrespective of different RPM configurations.

You should try to associate a devlink port with the netdev, that will
give it appropriate predictable naming. (Failing that, just implement
ndo_get_phys_port_name directly, but really devlink is much preferred).

