Return-Path: <linux-kernel+bounces-55232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350AD84B9BA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2941CB2F643
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB42D137C31;
	Tue,  6 Feb 2024 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEad+EnP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194B9135A6A;
	Tue,  6 Feb 2024 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232877; cv=none; b=FEv5ZF8X+nBrAhJ7u55yoLM4hzDRoexHEJ3bSOoWhaBs0hLw4ehWpYGOqxkgdqx5BThJLJsojxttaPpYFo+7aXhTAP4nJ7riEgu4iz7cqc1zX+iMp4/hhMebMeVrGltGoqJpMqqj3J3ikPGeYD5AENHQCpsuXZ2WZIrtv6LWW2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232877; c=relaxed/simple;
	bh=LyjQlt4G4x0nfdud4poStAqX33ymR17t5R2+B2AlI2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lgDjvlO9nFDfnOGAmVXI8ajVF3zDwk3pwxNz8H2bf5Ic8kgDlDZe5oRQ1TKni0GHYwKkSYbEqF3rFpf/zT5OzKbk1TfHJGNc1uBl960evrUWClAdKxHPzgH+3n3NIW/veghW0lyZ5/PDO+dKN0SDKNUriwhvqAQFRzrKFDkWrrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEad+EnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BF1C43390;
	Tue,  6 Feb 2024 15:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707232876;
	bh=LyjQlt4G4x0nfdud4poStAqX33ymR17t5R2+B2AlI2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CEad+EnPMUSBFizg/2pJsnkWPFwZP5QKGaQS7aD32TgLB2E8+yMr6sp0plnyZu3S1
	 QjlpUwXEt9SJGFNTASyqOKO0CWh+CQ61pEBVy4gY7SimuA0P/TP5/k5/oAyDN3d1jN
	 ShHLe0I7UtGcdYMPHVsbelbBV+mcEIKO5KPO433+98pSwAVMw0YBcU1NkLrn41z/Tc
	 rccytoFbjcT0KP+TGOwQaeha9IKR3PHjCw49qnCC98ZsYcPDPucak61ROR2CspRV7S
	 AqYFECKD8RQ1r3iWDZf6mV53A0Hg1xRdeypKXlsH9d6Zw+MEEEMTPXeTEHRAk7uwhJ
	 UaeoVypy3SEAw==
Date: Tue, 6 Feb 2024 07:21:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haseeb Gani
 <hgani@marvell.com>, Vimlesh Kumar <vimleshk@marvell.com>, Sathesh B Edara
 <sedara@marvell.com>, "egallen@redhat.com" <egallen@redhat.com>,
 "mschmidt@redhat.com" <mschmidt@redhat.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "wizhao@redhat.com" <wizhao@redhat.com>, "kheib@redhat.com"
 <kheib@redhat.com>, "konguyen@redhat.com" <konguyen@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jonathan
 Corbet <corbet@lwn.net>, Veerasenareddy Burru <vburru@marvell.com>,
 Satananda Burla <sburla@marvell.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, Joshua
 Hay <joshua.a.hay@intel.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew@lunn.ch>, Jacob
 Keller <jacob.e.keller@intel.com>
Subject: Re: [EXT] Re: [PATCH net-next v5 1/8] octeon_ep_vf: Add driver
 framework and device initialization
Message-ID: <20240206072114.244738a9@kernel.org>
In-Reply-To: <PH0PR18MB473460118D0FC68BE4B3BC45C7462@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20240129050254.3047778-1-srasheed@marvell.com>
	<20240129050254.3047778-2-srasheed@marvell.com>
	<20240131161406.22a9e330@kernel.org>
	<PH0PR18MB47345E3ADCC35D0ECA763DBBC7412@PH0PR18MB4734.namprd18.prod.outlook.com>
	<20240205154448.1c5a5ad8@kernel.org>
	<PH0PR18MB473460118D0FC68BE4B3BC45C7462@PH0PR18MB4734.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Feb 2024 07:42:12 +0000 Shinas Rasheed wrote:
> > > We do cancel_work_sync in octep_vf_remove function.  
> > 
> > But the device is still registered, so the timeout can happen after you
> > cancel but before you unregister.  
> 
> There is rtnl_lock inside octep_vf_tx_timeout_task (the work task
> function), which can protect from unregister_netdev, for such cases
> (code snippet for quick reference below):
> 
> static void octep_vf_tx_timeout_task(struct work_struct *work)
> {
>         struct octep_vf_device *oct = container_of(work, struct octep_vf_device, tx_timeout_task);
>         struct net_device *netdev = oct->netdev;
> 
>         rtnl_lock();
>         if (netif_running(netdev)) {
>                 octep_vf_stop(netdev);
>                 octep_vf_open(netdev);
>         }
>         rtnl_unlock();
> }
> 
> I hope this takes care of it? Please let me know if my thought
> process feels wrong. Thanks!

The problem I see is that if the queue is somehow overloaded or delayed
there can be a race where we cancel, then timeout happens, work doesn't
run for a while, and we free the netdev. So what I'm suggesting is -
hold a reference on the netdevice. That way you can be sure it doesn't
get freed and you can depend on the rtnl+netif_running() doing its job.

