Return-Path: <linux-kernel+bounces-16684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7090082426C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F008287ACE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0824722327;
	Thu,  4 Jan 2024 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkO1jlDh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523352230C;
	Thu,  4 Jan 2024 13:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98199C433C8;
	Thu,  4 Jan 2024 13:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704373422;
	bh=A8ZR/6SM/RSWKP/a/pFKacgU/Wu3j1mC0cFt4l1fwLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DkO1jlDhPRzTF+k92oCyoaddI2+urxW1BcFNpiArmjdZ6gqzrUSONj/6gCTpqqj+s
	 t4CTtzOS7wB8LLcoDlX6niyxoC6BhK42kmb9X/ke6IhnhdC3cgjE3hJYHeGKsgONW8
	 awHfUErrPmsT1IyF7SdNRqz8mFwiaVzmjY2F+DDqb3uS2HbgRZSFeOcu+Z3HWdJPNU
	 NFEruw1vhtyCcIDhc1snodZddb9kFHDobpmWp2KibokD/JHonBBUCFGtoImWRKSHFl
	 8uxVkHvOQH0GFq+fKgBGb+fWcAfriAHzjpa3TSIC7ATNHhUREmaRUIK0nW3rMEz6Lx
	 lmmzMqaTlvEkQ==
Date: Thu, 4 Jan 2024 13:03:37 +0000
From: Simon Horman <horms@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v3 2/4] net: phy: at803x: refactor qca808x cable
 test get status function
Message-ID: <20240104130337.GG31813@kernel.org>
References: <20240103124637.3078-1-ansuelsmth@gmail.com>
 <20240103124637.3078-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103124637.3078-3-ansuelsmth@gmail.com>

On Wed, Jan 03, 2024 at 01:46:33PM +0100, Christian Marangi wrote:
> Refactor qca808x cable test get status function to remove code
> duplication and clean things up.
> 
> The same logic is applied to each pair hence it can be generalized and
> moved to a common function.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/at803x.c | 65 +++++++++++++++++++++-------------------
>  1 file changed, 34 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> index acf483fa0887..b87293ee736c 100644
> --- a/drivers/net/phy/at803x.c
> +++ b/drivers/net/phy/at803x.c
> @@ -2037,10 +2037,39 @@ static int qca808x_cable_test_start(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static void qca808x_cable_test_get_pair_status(struct phy_device *phydev, u8 pair,
> +					       u16 status)
> +{
> +	u16 pair_code;
> +	int length;
> +
> +	switch (pair) {
> +	case ETHTOOL_A_CABLE_PAIR_A:
> +		pair_code = FIELD_GET(QCA808X_CDT_CODE_PAIR_A, status);
> +		break;
> +	case ETHTOOL_A_CABLE_PAIR_B:
> +		pair_code = FIELD_GET(QCA808X_CDT_CODE_PAIR_B, status);
> +		break;
> +	case ETHTOOL_A_CABLE_PAIR_C:
> +		pair_code = FIELD_GET(QCA808X_CDT_CODE_PAIR_C, status);
> +		break;
> +	case ETHTOOL_A_CABLE_PAIR_D:
> +		pair_code = FIELD_GET(QCA808X_CDT_CODE_PAIR_D, status);
> +		break;
> +	}

Hi Christian,

I don't think this can actually happen given current usage,
but if pair doesn't match one of the cases above,
then pair_code is used uninitialised below.

Flagged by Smatch.

> +
> +	ethnl_cable_test_result(phydev, pair,
> +				qca808x_cable_test_result_trans(pair_code));
> +
> +	if (qca808x_cdt_fault_length_valid(pair_code)) {
> +		length = qca808x_cdt_fault_length(phydev, pair);
> +		ethnl_cable_test_fault_length(phydev, pair, length);
> +	}
> +}
> +
>  static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finished)
>  {
>  	int ret, val;
> -	int pair_a, pair_b, pair_c, pair_d;
>  
>  	*finished = false;
>  

...

