Return-Path: <linux-kernel+bounces-138584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1124489F40D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4AF1F2C68B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D8A15F402;
	Wed, 10 Apr 2024 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmJGkZwR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E71915E7F3;
	Wed, 10 Apr 2024 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755170; cv=none; b=MFv5kMvvWq6MhAX6pOO8cBnE4+xSYfpCQulplP+x6vxZ4g/XH8PjGU9sFSBDosoCgqNF36gDA2CC4goftmN5D74foTKR5DDpYDQkUYObPIi9hrWJdraiWr9XwVCKDw0lc6PUbTVP0LQPeyuRg5dKPaOMNfFHCow/7rNokxXXyzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755170; c=relaxed/simple;
	bh=7se5ngO8xSqrBrYVcIfdidvmDgbPuUTqHOL6en4qQVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSEm0WdNgSgO3wikbkEtfF3dtZlqKMzMTUxRtibv/vF9eMsZTzdE5NYmF6kMxSSihpSsOxeYbdVqGrZyHg0b6M090pWFTSj6DhKWyq3Dg/A6rKs2hKT9nFDpbMTn8itEg5KGQ/hcRfpkrF79PGmckB+EHiF4YdI1B/2wlcHF4kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmJGkZwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CDCC433C7;
	Wed, 10 Apr 2024 13:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712755169;
	bh=7se5ngO8xSqrBrYVcIfdidvmDgbPuUTqHOL6en4qQVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AmJGkZwRmpXPRRQRM8thAnRLozPe+7AfndnUdcZZjePLeBqE8gLDqV85hwYfru1no
	 OywxqhbWaSMnd3geADvxVHDihAnBTTlpe3zWU2AQqUGTklC9CXatBt/hMDMU6xnl83
	 ZCVybJQcpQqGwcrXHwZqziKzpgF/lT1iAOV4PF5sthyOEkvFCmE7ah0ddmOkMGhnLv
	 ZOu1TSWObnVHMGJUNiqJYdGI3zNFrS7y9V2hum085QrwnmtI42NgBuo1YlQbnu+ntn
	 AWt2FurM4UTJX/+NHbbvvWNgsSof58OjhWS1ZgYxI6tI/Wk1STSbcr/PaSgQ9RuUVE
	 jSXLbC/s/+2DA==
Date: Wed, 10 Apr 2024 06:19:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, John Fraker
 <jfraker@google.com>, netdev@vger.kernel.org, Praveen  Kaligineedi
 <pkaligineedi@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Shailend Chand <shailend@google.com>, Willem de  Bruijn
 <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, Junfeng Guo
 <junfeng.guo@intel.com>, Ziwei Xiao <ziweixiao@google.com>, Jeroen de Borst
 <jeroendb@google.com>, linux-kernel@vger.kernel.org,
 kory.maincent@bootlin.com, andrew@lunn.ch, richardcochran@gmail.com
Subject: Re: [PATCH net-next] gve: Correctly report software timestamping
 capabilities
Message-ID: <20240410061928.712ff9a3@kernel.org>
In-Reply-To: <87jzl5akh5.fsf@nvidia.com>
References: <20240408180918.2773238-1-jfraker@google.com>
	<661550e348224_23a2b2294f7@willemb.c.googlers.com.notmuch>
	<20240409172838.247738f3@kernel.org>
	<87jzl5akh5.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Apr 2024 21:40:46 -0700 Rahul Rameshbabu wrote:
> > My gut tells me we force drivers to set the ethtool op because
> > while at it they will probably also implement tx stamping.  
> 
> I think the logic should be the other way (in terms of the
> relationship). A call to skb_tx_timestamp should throw a warning if the
> driver does not advertise its timestamping capabilities. This way, a
> naive netdev driver for some lightweight device does not need to worry
> about this. I agree that anyone implementing tx timestamping should have
> this operation defined. An skb does not contain any mechanism to
> reference the driver's ethtool callback. Maybe the right choice is to
> have a ts capability function registered for each netdev that can be
> used by the core stack and that powers the ethtool operation as well
> instead of the existing callback for ethtool?

Adding a check which only need to runs once in the lifetime of
the driver to the fastpath may be a little awkward. Another option
would be a sufficiently intelligent grep, which would understand
which files constitute a driver. At which point grepping for 
the ethtool op and skb_tx_timestamp would be trivial?

