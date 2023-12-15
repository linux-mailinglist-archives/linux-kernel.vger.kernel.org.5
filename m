Return-Path: <linux-kernel+bounces-1473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7C5814F43
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E67CBB21E49
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91843FB12;
	Fri, 15 Dec 2023 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jay9ougN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34CA45C16;
	Fri, 15 Dec 2023 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=+iPdiJNdZVJJftJlmJirKXP1ftutRoMmfkmL/gnsteY=; b=jay9ougNBK8TghytFpUhx1y5b9
	mytxfXrEWaqLun8HqrByCIQ1KJ0tS9xj2hr6FQv+cYgraTC2H9B7+sgUyeQyhIkW8k9xY3UK6Ru9e
	4rvkSX87wxIV3VUZ9rwz/hyqc1dUXh5k2kUFk/CUKrZ3WAYsCk5QKrIAyKBc2NVcdEnZN++aoP+M6
	OHzIUAu/iE/b3akYMpojMKjJhfZTdLsfQxaJ9WnqemAlQxehX5MSBrair0xLWki721i04sG2QIV1V
	mjLODjZXsvIMQ01s0//xlPLmgdoRhFsQqNY2kx/vE7ou5/j9GOik77l6hJpuiyuMHHiBkfpT7S7R9
	chetLpkQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rECLg-0049yM-39;
	Fri, 15 Dec 2023 17:51:45 +0000
Message-ID: <387c75f9-e2f3-499a-bfb3-17b18398866a@infradead.org>
Date: Fri, 15 Dec 2023 09:51:44 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 1/3] net: phy: refactor and better document
 phy_speeds function
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231215132921.16808-1-ansuelsmth@gmail.com>
 <20231215132921.16808-2-ansuelsmth@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231215132921.16808-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 12/15/23 05:29, Christian Marangi wrote:
> Refactor the phy_speeds function to be more readable and understandable
> and add some documentation on it.
> 
> While on it extend it to take NULL speeds values to make it return only
> the count of speed modes in the passed mask.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/phy-core.c | 50 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
> index 966c93cbe616..9618d89458d1 100644
> --- a/drivers/net/phy/phy-core.c
> +++ b/drivers/net/phy/phy-core.c
> @@ -317,17 +317,57 @@ phy_lookup_setting(int speed, int duplex, const unsigned long *mask, bool exact)
>  }
>  EXPORT_SYMBOL_GPL(phy_lookup_setting);
>  
> +/**
> + * phy_speeds - return all speeds in mask
> + * @speeds: pointer to array where to put the speed modes
> + * @size: size of array where to put the speed modes
> + * @mask: mask of speed modes to compare with
> + *
> + * Take mask, test bit in mask with the settings table and compose the
> + * speeds array based on that as many as size permits.
> + *
> + * With speeds NULL, only the number of detected modes is returned and
> + * no array is composed. (size value is ignored)
> + *
> + * Return the number of detected modes in mask.

    * Return: the number of detected modes in mask.


> + */


-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

