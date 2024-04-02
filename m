Return-Path: <linux-kernel+bounces-127566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48781894DB9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95283B21E2F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9ED57880;
	Tue,  2 Apr 2024 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJz3ajES"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3E93E479;
	Tue,  2 Apr 2024 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046991; cv=none; b=IVlcZZYK39gEznzCud9uQsGd4hGQ1ukNre/vtgNZHm2KDrDhTiskpwGCu6jJdkJ8BL4yxhewpN0S6JlByDsa5odKKAngyEsHYdr0bm4hGrLztgkR0dwbn2j8EEs1/13Tni6ilnFPGE/1AnLrqApknVp1MgqmHp/0j92cFESkfTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046991; c=relaxed/simple;
	bh=Tgjd0CDwYwOTXcNopkSwsdl4O9xxv3uVMD5zmI8KlHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxX4xBxpf4cfc961MvvjCpeMiol2I2bZOlcIbrxcyOLS1qMiFj81WfD9RGeCIhCbX+qsHu/Jh/8jdprhY9qyY/Jm/B7AKb5t2WKMqeNqFuz7pBtY4M/9vBcAxqZeL4OLvRelBD/yHye8xgFO4ysOoJBMRFFFKNdzXdpLGmYibdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJz3ajES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BCEC433C7;
	Tue,  2 Apr 2024 08:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712046990;
	bh=Tgjd0CDwYwOTXcNopkSwsdl4O9xxv3uVMD5zmI8KlHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJz3ajESb40xBrf+1zV6Sn4eiV/xZGz/G0W0aOjo4/7hyNzePO/10G/U2oCX2SQvw
	 PkOlI7CXfsHEZko1vOGid16innOTsdNIxFOD7Ua+lauJ/wumnyMTPjIAJQylOogbHb
	 eqtpmdLNUaoJeLBJQIvYuj+ZL7xj6veAL99zTsXQm0Y3BHJ9yocjSrqlsD+dhNsUXm
	 L1yJ2gKMWabQD5OiGL/OV9Ny818LP1ylcIzSH7zYcHChV+4EID8lhnAobTZ3fGOy4h
	 5ttOCdSs2FVlfIQTB0mB5/edC+iXwXBaW6KwsR7gFJn08+aNxwADYdNSkFiRQba/H8
	 AvLIcyLBQcYMQ==
Date: Tue, 2 Apr 2024 09:36:26 +0100
From: Simon Horman <horms@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH net v3] net: usb: ax88179_178a: avoid the interface
 always configured as random address
Message-ID: <20240402083626.GN26556@kernel.org>
References: <20240401082004.7412-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401082004.7412-1-jtornosm@redhat.com>

On Mon, Apr 01, 2024 at 10:19:50AM +0200, Jose Ignacio Tornos Martinez wrote:
> After the commit d2689b6a86b9 ("net: usb: ax88179_178a: avoid two
> consecutive device resets"), reset is not executed from bind operation and
> mac address is not read from the device registers or the devicetree at that
> moment. Since the check to configure if the assigned mac address is random
> or not for the interface, happens after the bind operation from
> usbnet_probe, the interface keeps configured as random address, although the
> address is correctly read and set during open operation (the only reset
> now).
> 
> In order to keep only one reset for the device and to avoid the interface
> always configured as random address, after reset, configure correctly the
> suitable field from the driver, if the mac address is read successfully from
> the device registers or the devicetree.
> 
> cc: stable@vger.kernel.org # 6.6+
> Fixes: d2689b6a86b9 ("net: usb: ax88179_178a: avoid two consecutive device resets")
> Reported-by: Dave Stevenson  <dave.stevenson@raspberrypi.com>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> v3:
>   - Send the patch separately to net.
> v2:
>   - Split the fix and the improvement in two patches as Simon Horman
> suggests.
> v1: https://lore.kernel.org/netdev/20240325173155.671807-1-jtornosm@redhat.com/

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>


