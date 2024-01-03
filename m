Return-Path: <linux-kernel+bounces-15620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5731C822EF5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F451F24AB8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE6419BDF;
	Wed,  3 Jan 2024 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fz03eCtE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB07C19BB2;
	Wed,  3 Jan 2024 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=B6mFRE7y+AFa7z4uxe9OX4CxoJLcZgIi5f2fGVeY1X4=; b=fz03eCtEYIROoSjL2PoKk34UaN
	nWIZ8y3I80Du2ekglxO782pzI84U2yxmPVHbGBKyPrlBb4wGHiThgnDXehKr0g5e9aXpbOPednXbl
	ZSyJQX7p4d5D2KRI8j5iC887n8AO8prjw8AF3WmTtSMYWvC1lUr6u3DO4OHTWaSTP7ts=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rL1hV-004G7n-7m; Wed, 03 Jan 2024 14:54:29 +0100
Date: Wed, 3 Jan 2024 14:54:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, olteanv@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, przemyslaw.kitszel@intel.com,
	rmk+kernel@armlinux.org.uk, kabel@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH net-next v2 0/2] net: phy: Use is_phy_driver() and
 is_phy_device()
Message-ID: <46528573-b584-4e37-82c9-f8fc4e0428d9@lunn.ch>
References: <20240103025334.541682-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103025334.541682-1-yajun.deng@linux.dev>

On Wed, Jan 03, 2024 at 10:53:32AM +0800, Yajun Deng wrote:
> There is only one flag that can be set in struct mdio_driver_common and
> mdio_device. We can compare the probe of the driver or the type of the
> device to implement it. Hence, these flags in struct mdio_driver_common
> and mdio_device can be removed.
> 
> Introduce is_phy_driver() and is_phy_device(). Use them test the driver
> or device.

I'm still not convinced this is useful. Please expand your commit
message.  One things which might convince me this is useful is if the
PHY drivers can make there struct phy_driver structures const.

Also, please break this patch series up. You should be able to add the
helper is_phy_driver() and make use of it, without changing
common. You should be able to add is_phy_device() without changing
common. So do these little steps first. The current code is hard to
review because these changes are all mixed in with everything
else. Once you have done the preparation steps, you can then do the
mass change.

    Andrew

---
pw-bot: cr

