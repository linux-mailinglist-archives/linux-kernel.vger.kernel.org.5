Return-Path: <linux-kernel+bounces-34100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C451F837378
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0AA285942
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EF240BE5;
	Mon, 22 Jan 2024 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQAwLy/u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F63A3FE44;
	Mon, 22 Jan 2024 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705953845; cv=none; b=JJpuU38+oRYp/Mwm/7hwOf1jKbP2cRq2lDcsLw/4y4GigEFGIaMnxFeLujkSAysy40Yk+NXL5w6YqSk0JPKcD6Wzl4NatYUJTVopT2fYaA5Dcv7zzGCIbV6USxDkSofyYwtdPolPhzDqHdOapqmWy399oahwJ1V6EPIaxROYics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705953845; c=relaxed/simple;
	bh=DqCAIQYyLQtiRtdIQyFNxcTujon3m1C7VDl4g+mOOvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIZXddsw42b+u8hqXAcZ50pbdfIQ3zTJbMMJ5w2EukrCbN730q6haznE23uMrOuuwq32sty3Syd7X4YBhb8b7jU22eqGZ5ilqnRDQcsQzWuVIftcd9/1yVGLpGuXkUfyNqVNcUMdP42zrE1X8EyhQVT/jSE+dsiNUN/cL/Zakks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQAwLy/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5461CC433F1;
	Mon, 22 Jan 2024 20:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705953844;
	bh=DqCAIQYyLQtiRtdIQyFNxcTujon3m1C7VDl4g+mOOvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eQAwLy/uWO02Ef7F/clV8+0/xhihN6Z5+qIOiVfRonKQDTYoX2/HjIL1dV9N4nnLH
	 82k/2wx6gkTTPV9wRjp2ykRY5GfeKKK4f+/Cje2Wqpaa5GjNFUdAMOOUpMtzLS9yKw
	 DbAjXzfr835g6X3b8xHb0Di5aqsyUOFbzuqgy8lYEn5A3GvWkBrw3NwgMNBMo4liFL
	 /L1ksCJojLAKc+DkO7USTPPjC5qmVnrJcH5L67dm/lKhLrSeb+TUad8gE3TlrqtVUV
	 cm5Hfz4LQ7QXmgaB4YH0u1W/j+oV5f163f5LZU1+xDIN0PqOTL82OTG1Jx/ubjk+y8
	 zUOCZZISW0/HA==
Date: Mon, 22 Jan 2024 20:03:57 +0000
From: Simon Horman <horms@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"sdf@google.com" <sdf@google.com>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	mlxsw <mlxsw@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: Re: [RFC PATCH net-next 7/9] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Message-ID: <20240122200357.GF126470@kernel.org>
References: <20240122084530.32451-1-danieller@nvidia.com>
 <20240122084530.32451-8-danieller@nvidia.com>
 <20240122103100.GA126470@kernel.org>
 <DM6PR12MB45168A412E91A73A01965331D8752@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB45168A412E91A73A01965331D8752@DM6PR12MB4516.namprd12.prod.outlook.com>

On Mon, Jan 22, 2024 at 02:35:59PM +0000, Danielle Ratson wrote:

..

> Hi Simon,
> 
> Thanks for the feedback.
> 
> Ill fix that, something like:
> 
> diff --git a/net/ethtool/cmis_cdb.c b/net/ethtool/cmis_cdb.c
> index b27e12871816..888b02e6eade 100644
> --- a/net/ethtool/cmis_cdb.c
> +++ b/net/ethtool/cmis_cdb.c
> @@ -521,7 +521,7 @@ int ethtool_cmis_cdb_execute_cmd(struct net_device *dev,
>         }
> 
>         err = ethtool_cmis_page_init(&page_data, ETHTOOL_CMIS_CDB_CMD_PAGE, 0,
> -                                    ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH);
> +                                    sizeof(args->req.body));
>         if (err < 0)
>                 return err;

Thanks Danielle,

I also think something like that should fix the problem.



