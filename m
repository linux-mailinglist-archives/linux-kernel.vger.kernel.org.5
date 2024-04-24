Return-Path: <linux-kernel+bounces-157738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3F58B1536
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DAEF1C2376D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1B7156F52;
	Wed, 24 Apr 2024 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qiVR3Fc4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BCE15699A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713994472; cv=none; b=Zhwpmv9CiC8P4br76tVP3sqQW4Mz6yGVyOhzfhGf3Y5hB1wa+JOUGLV34twt+Qm8BGF7Yh5citjnPTNW3laXWgCuJXLXQrledzuGVRCkPh+WYdrrO2CWJqxJXwP4GNKmkQ9f/CB/ycGPKr1ivR6wmZxHjUm5+yP3jsh374S8rdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713994472; c=relaxed/simple;
	bh=SrHYLs89xngbdxeCohwI49CaO37g9BgaojB8ExaVup0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpqNcejbvlCryUelxizaEPXQptk8iET4n5n9koFuiKN+zGlJpV58LncYE8npYy7pT6BE0RBGb0guXiAA9OLhaAoyjug8RLoryiQEzUk3LHnlmREm6jhzHGyaiuWpRgdxsU0aKOZ1SqFyFqBwt3LKAUpPubnM5d9y7WoE/TCq/PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qiVR3Fc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCE4C113CD;
	Wed, 24 Apr 2024 21:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713994471;
	bh=SrHYLs89xngbdxeCohwI49CaO37g9BgaojB8ExaVup0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qiVR3Fc4AVQcXSENBIatnhU6o6BmBxbHG1GhuxjzVlnWjy3cZG/FUQzYFCSBAFbyU
	 ajVFl3uzcGL7xTkm8rYAnyFfpmZ+zgFbolml/21CJZUTlFbHM9xPIg+/eJXAfXBnMv
	 c/7dYhJDqkpfz+nG8P8WUcEmZ5nXMWS0QuRSgWMU=
Date: Wed, 24 Apr 2024 14:34:22 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Cc: michal.simek@amd.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: soc: xilinx: check return status of
 get_api_version()
Message-ID: <2024042430-scurvy-swimmer-92f2@gregkh>
References: <20240424063118.23200-1-jay.buddhabhatti@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424063118.23200-1-jay.buddhabhatti@amd.com>

On Tue, Apr 23, 2024 at 11:31:18PM -0700, Jay Buddhabhatti wrote:
> Check return status of pm_get_api_version and return error in case of failure to
> avoid checking uninitialized pm_api_version variable from stack.
> 
> The issue is also reported by smatch on x86 as "warning: 'pm_api_version' is
> used uninitialized".
> 
> Fixes: b9b3a8be28b3 ("firmware: xilinx: Remove eemi ops for get_api_version")
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> ---
>  drivers/soc/xilinx/zynqmp_power.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
> index 965b1143936a..8570ab1a6857 100644
> --- a/drivers/soc/xilinx/zynqmp_power.c
> +++ b/drivers/soc/xilinx/zynqmp_power.c
> @@ -3,6 +3,7 @@
>   * Xilinx Zynq MPSoC Power Management
>   *
>   *  Copyright (C) 2014-2019 Xilinx, Inc.
> + *  Copyright (C) 2024, Advanced Micro Devices, Inc.

Really?  Your lawyers think that your 3 line change deserves this
addition as well?  If so, please have them sign off on the next version
of this patch submission so that we get their confirmation that this is
what they want to start doing for all AMD submissions.

From my point of view, this change is not ok.

thanks,

greg "I talk to too many lawyers" k-h

