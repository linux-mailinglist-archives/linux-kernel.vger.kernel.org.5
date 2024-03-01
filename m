Return-Path: <linux-kernel+bounces-88651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B8086E4D9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF301F2330F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414B670AF5;
	Fri,  1 Mar 2024 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0dtOfbh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B7A6F514;
	Fri,  1 Mar 2024 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308770; cv=none; b=LpW+KiVanSknrJvelQrPY1t9Y57R7yMzhc0E3jAdKbO6tql/b5Tc6m0eKNjPoQo8j2nn0ubih8y8w+f/bly5KjCU65j5Kv6tlXTtZJSeKSEVbD9xnjGukZSKlyS14957GbEsJPlajSIf4yCUOLY+cObG5D9fPMHuV5U3tsoYWUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308770; c=relaxed/simple;
	bh=AW5LPaRLd2WNob7gDn7GgQ9g+WbaQ19KIWIJ95J0jgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaT4NmSHjPCnqMT7uco2It7uXTMfM+Rc+cw7Cj/atIfhZhV/nQtx2UKpa4x1Xw4S67k7BDp/5ZER+eut9CrTzUpyiWo+jl3v/FHv/FnUcBOIznx9ofhbryO9A5NIAzPsmExn90ikUsJ06Uq1XSC5vonQytc+65vP4E4/OBj0wRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0dtOfbh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5374FC433F1;
	Fri,  1 Mar 2024 15:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709308770;
	bh=AW5LPaRLd2WNob7gDn7GgQ9g+WbaQ19KIWIJ95J0jgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z0dtOfbhaO8lem7tDOvoCmQfcsywj82P6xs0moIMHwJdDz/wwyq9ZzQO1uxJ52mrm
	 63JDKTQw9TDJlF3OijmdMN7RM6r1k9lAF6Twa/BAhXJjtw0X4CRvCJ/h5gcrWDTHn2
	 b+uVf4HzFZJFXz6hf5Lq8zQ/o3cSu2U0sXeKXa0jH9wuBpGXQ3Kf9xk7ruMW08ZF1H
	 bAVRp90X9v8Zp9BIGul4llRyV4Il700lBGlIgLuh7K2SlmLuK8bRgLfRqclXi+b9rC
	 /wnZz4yoeiXFZuHzVYahqAh0E5dtZHI2yhFFz8F8rjTChKje3uRxM9vAIsEJA4iB3W
	 hU0953AmDlIXQ==
Date: Fri, 1 Mar 2024 15:57:56 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dsahern@kernel.org
Subject: Re: [PATCH net-next 1/2] net: bareudp: Do not allocate stats in the
 driver
Message-ID: <20240301155755.GD403078@kernel.org>
References: <20240229170425.3895238-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229170425.3895238-1-leitao@debian.org>

On Thu, Feb 29, 2024 at 09:04:23AM -0800, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Remove the allocation in the bareudp driver and leverage the network
> core allocation.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


