Return-Path: <linux-kernel+bounces-165378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6588B8BF2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AACD1C22AAD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DFA219F9;
	Wed,  1 May 2024 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Od7WPu4L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835EE10958;
	Wed,  1 May 2024 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714574280; cv=none; b=iJWozvu1KjEBACLwvx9tJpkc4I9pVaCRpa2kwiM5r0O36Znan1XmcYB2muTJXYyjR387ZMummRtDTfGlZ/0Eie1gqdlWjrgCIpTNRYTD3Vo8e4nNdGYslcTSC9gImISY+EIUl2oVCByBoNCXRax37IiRxaNBzGEhigRWE5HPB/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714574280; c=relaxed/simple;
	bh=fnzipyC0KSPPMhA3lbz+NK9PDvP4bcqNMdwD//odq4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrGrYTwWXi1uhZnwyHHywUl/0lY2gOUJotPAiirMz6crypl/LdWwclV28QinS+vCMQctPCpBAy0nxpCUJnfXu5/qN1jQA+scLBkI8mdOadb8A/t0qqn+svzaFs2YO1bD8ox39+8enDRcw03EVTtrYQqyjNzDTHoypRvHgabqhrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Od7WPu4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EF4C072AA;
	Wed,  1 May 2024 14:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714574280;
	bh=fnzipyC0KSPPMhA3lbz+NK9PDvP4bcqNMdwD//odq4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Od7WPu4LpHp7dC74MWGloZCxyUgTJcbwQE7uXrlcaB2Qzyx2ykdEUnj7/HnRNSV9S
	 2ud/yCP3Qaay9o6GVvTMECZUHoICBCAESwIUprKLj2KLU76qqvKi814TwDtJyH+ENG
	 M962iZLsrY2VDrqdgyp3+/QGO9PrmnzFhwroc7DAXVsjBZUcOpUEgLAfdNY6+en3QI
	 H8LJSXksZ/aashA1j+neCJhoFiWH+ROQhao8+jGq4camGSaqhn+KgtMoByeKg4LKch
	 fZj6Bza5LVN5WkayXPrRm6He4Rz4RWKtKqUFRMjzKlX+J6XylWyd0gyKqAuK+/jUYS
	 XidC1tyP+aebQ==
Date: Wed, 1 May 2024 07:37:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Danielle Ratson <danieller@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "sdf@google.com"
 <sdf@google.com>, "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
 "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
 "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
 "paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, mlxsw <mlxsw@nvidia.com>, Petr Machata
 <petrm@nvidia.com>
Subject: Re: [PATCH net-next v5 04/10] ethtool: Add flashing transceiver
 modules' firmware notifications ability
Message-ID: <20240501073758.3da76601@kernel.org>
In-Reply-To: <ZjH1DCu0rJTL_RYz@shredder>
References: <20240424133023.4150624-1-danieller@nvidia.com>
	<20240424133023.4150624-5-danieller@nvidia.com>
	<20240429201130.5fad6d05@kernel.org>
	<DM6PR12MB45168DC7D9D9D7A5AE3E2B2DD81A2@DM6PR12MB4516.namprd12.prod.outlook.com>
	<20240430130302.235d612d@kernel.org>
	<ZjH1DCu0rJTL_RYz@shredder>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 May 2024 10:53:48 +0300 Ido Schimmel wrote:
> We can try to use unicast, but the current design is influenced by
> devlink firmware flash (see __devlink_flash_update_notify()) and ethtool
> cable testing (see ethnl_cable_test_started() and
> ethnl_cable_test_finished()), both of which use multicast notifications
> although the latter does not update about progress.
> 
> Do you want us to try the unicast approach or be consistent with the
> above examples?

We are charting a bit of a new territory here, you're right that 
the precedents point in the direction of multicast.
The unicast is harder to get done on the kernel side (we should
probably also check that the socket pid didn't get reused, stop
sending the notifications when original socket gets closed?)
It will require using pretty much all the pieces of advanced
netlink infra we have, I'm happy to explain more, but I'll also
understand if you prefer to stick to multicast.

