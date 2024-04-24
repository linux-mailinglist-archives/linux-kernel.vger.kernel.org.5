Return-Path: <linux-kernel+bounces-156488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B65A8B0332
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0886628660F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593AC1581E2;
	Wed, 24 Apr 2024 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxUUqjRh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903F2D29E;
	Wed, 24 Apr 2024 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943681; cv=none; b=QYAmfEtxoBBsoOgS65xOGqoRof0lSmQ1fMUd88MXaf2ZXt+nYK2TB1VcvR8Wdg9rtK0kmxDa8NGyMUcrThwbS4+oW1QhzYgknXrzVFIFNjwrPHW/70CdALIqef0yV/mBuV0iCbEQ/JiqtvLVxoNU6z+d3vTgLG/jYOiNGsV21C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943681; c=relaxed/simple;
	bh=U+9Jy2HriAOq6JXv5BGv9/GxjLWl2uRiHVloYWp9ZZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tomxKFOgrTlWuRoDjBXBkbtwN9vPaxXbs5H8TC+A6X0CxWeRtXF6Pa2H5s9q5GtIzv49HZUnCQxPR8D7mbFQ43cmvkJft+RyFS7geTPL/rLiAMsyWw/n7MDsFhdx88LVmBP4JuUHU7hm9PfXA1yQcF0AsZ2Qx0D3lFS+l5JB3o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxUUqjRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100A7C113CE;
	Wed, 24 Apr 2024 07:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713943681;
	bh=U+9Jy2HriAOq6JXv5BGv9/GxjLWl2uRiHVloYWp9ZZU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KxUUqjRhBW+OETFzFCjR+bkMsSiWfWuuPcQk3Up9p9/DJtc2Vu/LcHY5lQxenI9E+
	 ScjKkspowKMEIm0JGDIDY+kc7SpyC4GRwrveXMd3V4VSvz9upW/TcEoeg8fpSj0D0S
	 UEcKiRv9J4Y3d5X6J88+Ia6wBt9+okihtgae9NAb6aSySo1lttI9IOhJ7KrAPvVTuX
	 thKOG3RP39eUAAygVORjrSHj3l+twr+shTdb8Q9OVL7Mbl+S7lBW86+JsTAOpvgG+P
	 h8orAMZAS49pfbfBBl+c5xTo+Pz+q7ZfFUr1B99BWUt+Tmrwwi6YDFQwhQga1sccMn
	 oKi5+/K9+eQPA==
Message-ID: <8d69e3dc-97e9-4672-a741-d31daeaf8388@kernel.org>
Date: Wed, 24 Apr 2024 10:27:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix signedness bug in
 prueth_init_rx_chns()
To: Dan Carpenter <dan.carpenter@linaro.org>, Roger Quadros <rogerq@ti.com>
Cc: MD Danish Anwar <danishanwar@ti.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, Jan Kiszka <jan.kiszka@siemens.com>,
 Diogo Ivo <diogo.ivo@siemens.com>, Rob Herring <robh@kernel.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <05282415-e7f4-42f3-99f8-32fde8f30936@moroto.mountain>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <05282415-e7f4-42f3-99f8-32fde8f30936@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/04/2024 19:15, Dan Carpenter wrote:
> The rx_chn->irq[] array is unsigned int but it should be signed for the
> error handling to work.  Also if k3_udma_glue_rx_get_irq() returns zero
> then we should return -ENXIO instead of success.
> 
> Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

