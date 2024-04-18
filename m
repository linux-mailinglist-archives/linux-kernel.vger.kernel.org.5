Return-Path: <linux-kernel+bounces-149839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F948A9691
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5463AB2312D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131BE15B15B;
	Thu, 18 Apr 2024 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCzH687B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45244125D6;
	Thu, 18 Apr 2024 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433543; cv=none; b=OeSzxktGXimtOGEjZZsNjT2szUZbS4ycUodI/Q4hlL1T8yDX94G7LHrFktzKI3qLst1LKUTeaMKo6A2AfNDEnxDHfLlbk7VtQoWEVMl0ofqd+SDYE199YPsilocfk228y/tESaDxhN4q8d8qldNnWMIuPXVweHc6a3Yg/iaiTPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433543; c=relaxed/simple;
	bh=flsCAe3Wcgtkzg6kErNrgWEmiLRjAq0+Pae7CbLV5is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKRjuaZj9H+TbLuv5hWeIA0Lqc/2vco5odvRymBMLapxph8Pvit8IaYEaoAC6T1OJih/uRgPCjCQTsa6F3MMb4NG1uftPdoEvtVD+TMgkJ0ftCg8NrhuAkGOQvqiatrbTGibw97M4YUdCuVsA0HJZ1gci6gNpYtNcJYEsej4L8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCzH687B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02867C113CC;
	Thu, 18 Apr 2024 09:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713433542;
	bh=flsCAe3Wcgtkzg6kErNrgWEmiLRjAq0+Pae7CbLV5is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OCzH687BEIR2lOzj+dxsfZqUYFtlL0+ielMEWO9Nd8Fb9rYZvXGC06xUAAKE0xTC2
	 ODsVKHYQpTsPo+4ErswN3F55s4JiL+Joxebuu3eAnzRr3qV0GSRYyTlLavz5OjgkFC
	 6LL/l7TN1+Q8jKfePQg5nRlURZkuxbPb9eEwxHqvVGH25vJEM0Dtja8dxWjCNUmc1/
	 C0Lpj5CRI6NRad/dy+GGuT/7l6ytsvLALQIuRPPMIEClIodtrQFv+F7ukJy7R+84PZ
	 Zi5yGytX4EUlRGmrc1bwC1zGznPaBiZOOV/70+TAT645DE3/RRLWyvJol6fKW33/UQ
	 x/nQeIDi73EXQ==
Date: Thu, 18 Apr 2024 10:45:35 +0100
From: Simon Horman <horms@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	linux@armlinux.org.uk, sdf@google.com, kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com, vladimir.oltean@nxp.com,
	przemyslaw.kitszel@intel.com, ahmed.zaki@intel.com,
	richardcochran@gmail.com, shayagr@amazon.com,
	paul.greenwalt@intel.com, jiri@resnulli.us,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mlxsw@nvidia.com, petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH net-next v3 07/10] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Message-ID: <20240418094535.GB3974194@kernel.org>
References: <20240417085347.2836385-1-danieller@nvidia.com>
 <20240417085347.2836385-8-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417085347.2836385-8-danieller@nvidia.com>

On Wed, Apr 17, 2024 at 11:53:44AM +0300, Danielle Ratson wrote:

..

> +/**
> + * struct ethtool_cmis_cdb_cmd_args - CDB commands execution arguments
> + * @req: CDB command fields as described in the CMIS standard.
> + * @max_duration: Maximum duration time for command completion in msec.
> + * @read_write_len_ext: Allowable additional number of byte octets to the LPL
> + *			in a READ or a WRITE commands.
> + * @rpl_exp_len: Expected reply length in bytes.
> + * @flags: Validation flags for CDB commands.
> + */

Hi Danielle,

I'm fine if this gets addressed as a follow-up,
but the Kernel doc above should include documentation
of msleep_pre_rpl and err_msg.

Flagged by: ./scripts/kernel-doc -Wall -none

> +struct ethtool_cmis_cdb_cmd_args {
> +	struct ethtool_cmis_cdb_request req;
> +	u16				max_duration;
> +	u8				read_write_len_ext;
> +	u8				msleep_pre_rpl;
> +	u8                              rpl_exp_len;
> +	u8				flags;
> +	char				*err_msg;
> +};

..

