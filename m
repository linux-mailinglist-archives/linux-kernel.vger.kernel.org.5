Return-Path: <linux-kernel+bounces-168276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 028FE8BB622
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341CB1C20941
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699FA12FB08;
	Fri,  3 May 2024 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6yvp+1o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F5912F383;
	Fri,  3 May 2024 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772216; cv=none; b=ene6OZUkzD9ZlJITj8Eumza7C4uLR15LndlAlgFiPnZE7r02eyejzm7iWe9C+xnDPmUNQGC7GNDg02paXBTwVLmb8O+233O8VwXlrmCidUp4RNITkDKWBWIxBs7jNU8PC86DW9sxqtRLtgINF9dtOEjOm1EKylDyKpsjj1HIRoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772216; c=relaxed/simple;
	bh=oJxbG4iY5MyfxFSePgZ5OYJPB8lo3UrJt32E8U7juLs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQd2t2ik4ItDv3x3tYopr5FUYvGI4pae8E5/PXPHxHWUDcx9f9BmoBlSCikGnHlDIC8rkouuB4zg3txYEqtQlp2RC1OpMIzZx8N70GdXRt+TwB+ZhrSTOwTIlm2mmJR+8C7+so03+NlVeZGF8o/ozSpWBk6snhWOfbxAEQjFBEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6yvp+1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD247C4AF14;
	Fri,  3 May 2024 21:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714772216;
	bh=oJxbG4iY5MyfxFSePgZ5OYJPB8lo3UrJt32E8U7juLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H6yvp+1o9rEoCh6PRS62OY8NaRXlf2To9Z940HIrR8qjT10QbMU2zhYGIr7kB+pIl
	 znh0FVGv6grs9F3m0S8MonRqJE9be4r/dfn4dsWIPQh5jYQnsPEBZstx6kBxew8IBt
	 9t48TZx6ngGRGeMcHrjww+zxIGK1xMSkaOXFN8W411C5BI8rAr35QrjF7cgRxtGyss
	 ysUHH9rME9fPa2t5AJYITgTBWemWaySP4SGrHpxbXNBC7Dso3Ju2m93M2hTAOLRGaO
	 bbyILPq6arDtav+jI+XF0VaUpQXpos+ozYNvqiHGifulyDiCciaGtpTZ6l50dyshCK
	 LXtrK7+sJcAYA==
Date: Fri, 3 May 2024 14:36:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
 jgg@nvidia.com, leonro@nvidia.com, Andrew Morton
 <akpm@linux-foundation.org>, Tal Gilboa <talgi@nvidia.com>, "open
 list:LIBRARY CODE" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] lib: Allow for the DIM library to be modular
Message-ID: <20240503143654.6843f43e@kernel.org>
In-Reply-To: <60ac51d1-da8a-4108-97c0-2d1ca8dc997e@broadcom.com>
References: <20240503002540.7154-1-florian.fainelli@broadcom.com>
	<20240502175815.4f1619c6@kernel.org>
	<60ac51d1-da8a-4108-97c0-2d1ca8dc997e@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 May 2024 20:19:27 -0700 Florian Fainelli wrote:
> Looking at "[PATCH net-next v11 0/4] ethtool: provide the dim profile 
> fine-tuning channel" it seems like Heng took care of making all of the 
> newly added functions EXPORT_SYMBOL(). The only thing I see missing is a 
> "select DIMLIB" from config ETHTOOL_NETLINK, do you see something else?

I think we refer to the default DIM tables from net/core/ to clone
them at init time. But we can move the init function into DIM itself.
That's probably for the better.

