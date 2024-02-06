Return-Path: <linux-kernel+bounces-55611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A7484BEF6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9073289ECB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AC71B942;
	Tue,  6 Feb 2024 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huyQB7Nv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4451BDED;
	Tue,  6 Feb 2024 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707252745; cv=none; b=fSRWeILBch8pF/KAgK9MLttnDNaBkDG8xNKbjwFlIdLtOv4u42D+3vddPARrF134rEd3HnclFjCPw6Yp8TdqKciyws9ysqRjLBQmip2FuW5tAxtvLgrOT3HddGmWRpTqWmmYR9BwM4Evp0lcLi9T/SaAaOqFhpKPrPtir9nFw2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707252745; c=relaxed/simple;
	bh=1FwVNnvMIETmmu3FksPs2T9xVBKZlTMIKKKVkLkI3FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzGreLEEUYAyD5YqzNSsLuWkAQpb9C+yUS3OWBt6jsppPEdY0/BQ4XomReBVdxdHKXT6956fUnKcUTUJHhxXEXKJfiv+8CVTeHABSiHkKBHeivQXqTKRnz/QcxN0AJHZDujVYlrUTuj3R4wbPNaIKcIxJSpMbAlgpIaw4KNY5og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huyQB7Nv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51A6C433C7;
	Tue,  6 Feb 2024 20:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707252744;
	bh=1FwVNnvMIETmmu3FksPs2T9xVBKZlTMIKKKVkLkI3FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=huyQB7Nv4eEO9Me+W/DBz9A0Vww3VVQDQ0fydvGFqV8qH/AWFZR0hRUkH0O8+TQ4s
	 +y1Dy1oKrJ3h+eHQhR8Qa3q6RFQgzwRcJBBtLnONsul5mtCSICH0evikya50VaN8Sn
	 YiwZUEhVsO65QoAJi03HPhMhSeMMwgAVSPud84YFXYevf1zyNe09+SYC6zBD3o1XYg
	 ctwVIwRVYrH3bLrYuYRugl95laRR9mfcoDZusG4u6iHSxIra7jQZ1fKdo6F3DbGuBV
	 CWMkdmxvXLu3k6jBZpmiTz3JNCn5kTdPaTUZfi03X68HDX8GJ6btyOrrao2g7PvJjy
	 P3oi3ms78iw6A==
Date: Tue, 6 Feb 2024 20:50:50 +0000
From: Simon Horman <horms@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH net v2] lan966x: Fix crash when adding interface under a
 lag
Message-ID: <20240206205050.GK1104779@kernel.org>
References: <20240206123054.3052966-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206123054.3052966-1-horatiu.vultur@microchip.com>

On Tue, Feb 06, 2024 at 01:30:54PM +0100, Horatiu Vultur wrote:
> There is a crash when adding one of the lan966x interfaces under a lag
> interface. The issue can be reproduced like this:
> ip link add name bond0 type bond miimon 100 mode balance-xor
> ip link set dev eth0 master bond0
> 
> The reason is because when adding a interface under the lag it would go
> through all the ports and try to figure out which other ports are under
> that lag interface. And the issue is that lan966x can have ports that are
> NULL pointer as they are not probed. So then iterating over these ports
> it would just crash as they are NULL pointers.
> The fix consists in actually checking for NULL pointers before accessing
> something from the ports. Like we do in other places.
> 
> Fixes: cabc9d49333d ("net: lan966x: Add lag support for lan966x")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

