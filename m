Return-Path: <linux-kernel+bounces-109086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6A3881478
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41621F23109
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4245652F65;
	Wed, 20 Mar 2024 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLoO2ZkS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820E44F1E5;
	Wed, 20 Mar 2024 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948172; cv=none; b=EXmQ3wtzSRrhafnc+gBOB/dgPgklu4fAZnfYCF6U/0nk0seC/Pl5ty0GenHSYxdCA1QzWp7qbb0RejLstqocRtKnc3CGb2kQG3Lz7pvP4mJOpLRO1wIZ9dCTy3c/gyKNFiDwUg/CjtxQXQtxXMJaadWvsH92GNcrC3EFN1/qL98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948172; c=relaxed/simple;
	bh=TR0ElOCWlrACmeqJex852AV/Z/HsxEc3rXJRmzD19No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQF4JbqZQvpHKmbbrIKcLM5CN7lgfZSGC27hDS4p8bcxNzgAtDPdwmF91pus9UT74QzdcgmG3jZe6TS9kIOijSK/BcL6XKWDlcnpRQ9RaQb+pymvNpRKILsGT1+7m5808+NJa2pMGfclPcYOQ8RWYyLr0WUBT2AnptWjwKsdksQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLoO2ZkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0F8C433C7;
	Wed, 20 Mar 2024 15:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710948172;
	bh=TR0ElOCWlrACmeqJex852AV/Z/HsxEc3rXJRmzD19No=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLoO2ZkSapH4wny76mCgRSWlVx3wBIzFZktsCZKFQzpOaAbIksSEyQa5wykCmHfg1
	 NUmYfH/wVqlBtmig2kLAaHjWCtUEXlkDcE+6bL8O0T2kL2ZJPtC5iIYasSzL9KUlKr
	 BphAU/MVKoRKfI6cwq+BEkjk46HBIstlmX23wcIUqdjKlNw8o4xGWdPVf3yEx2rRhk
	 gHRBEdIPuYN9FHSln22Fpbl90TIno1SnHA5bAnDBCptVno212SUPTpqlbVmGZr34m7
	 LNKzaIU80NImSbgF36KILGQ+UaRCAdy73Kcx1wPBuxcVxVEjiLpf1hIsycJ22OMxFn
	 EVdznuK7ZWOBw==
Date: Wed, 20 Mar 2024 15:22:46 +0000
From: Simon Horman <horms@kernel.org>
To: Claus Hansen Ries <chr@terma.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>,
	"wei.fang@nxp.com" <wei.fang@nxp.com>,
	"yangyingliang@huawei.com" <yangyingliang@huawei.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"harini.katakam@amd.com" <harini.katakam@amd.com>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"wanghai38@huawei.com" <wanghai38@huawei.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: ll_temac: platform_get_resource replaced by
 wrong function
Message-ID: <20240320152246.GU185808@kernel.org>
References: <f512ff25a2cd484791757c18facb526c@terma.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f512ff25a2cd484791757c18facb526c@terma.com>

On Wed, Mar 20, 2024 at 02:19:15PM +0000, Claus Hansen Ries wrote:
> From: Claus Hansen Ries <chr@terma.com>
> 
> Hope I am resubmitting this correctly, I've fixed the issues in 
> the original submission.

For future reference, the text above probably belongs
below the scissors ("---"). But I don't think there
is a need to resubmit just because of that.

> 
> platform_get_resource was replaced with devm_platform_ioremap_resource_byname 
> and is called using 0 as name. This eventually ends up in platform_get_resource_byname
> in the call stack, where it causes a null pointer in strcmp.
> 
> 	if (type == resource_type(r) && !strcmp(r->name, name))
> 
> It should have been replaced with devm_platform_ioremap_resource.
> 
> Fixes: bd69058f50d5 ("net: ll_temac: Use devm_platform_ioremap_resource_byname()")
> Signed-off-by: Claus Hansen Ries <chr@terma.com>
> Cc: stable@vger.kernel.org
> ---
> v2:
>   - fix accidently converting tabs to spaces and wording in commit message
> v1: https://marc.info/?l=linux-netdev&m=171087828129633&w=2

Thanks,

Reviewed-by: Simon Horman <horms@kernel.org>

