Return-Path: <linux-kernel+bounces-35174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96498838D19
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A59EB28A75
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E345D72F;
	Tue, 23 Jan 2024 11:13:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45E85C91A;
	Tue, 23 Jan 2024 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008402; cv=none; b=r/cYTnmBuOVT53uKwAHiIKUodmWQ+QcbOh26htJ4AYbA7A+iz7XiSh2o6W2QJw+lnj7Vo7V2BWW7f6GkKS8l2D/p5Mr0ExEbg+4d3Bzd4Mcrx8+YzwmtzlNPyxmyYBE9EsYWEEUfyfZ5hcB2q3vSvvJqL+EHC6nWTlQQFT8f2aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008402; c=relaxed/simple;
	bh=UYWReQW9UpugO0v/i1SILTLzGmv7pXpZJGlihgITteM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0gDPUs4NUGvosOz/64KTnZsgBrP5C8sP3XofV+0ZMMoxKbu56lQ1nFu9SRFwIZrYQn0rWaqGUHgLn/jw4M/IHQh2/bPEd7jszns+8mBT5dVFxaMuhkxtYSqFdOZXN8mGYYak2kD704aGgJCZYzj1sTnLlxxK/9r5FtOqvLTYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C32AF1FB;
	Tue, 23 Jan 2024 03:14:05 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 360543F762;
	Tue, 23 Jan 2024 03:13:19 -0800 (PST)
Date: Tue, 23 Jan 2024 11:13:16 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, sboyd@kernel.org
Cc: cristian.marussi@arm.com, mturquette@baylibre.com,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 2/2] clk: scmi: support state_ctrl_forbidden
Message-ID: <Za-fTES4owsmmxgO@bogus>
References: <20240121110901.1414856-1-peng.fan@oss.nxp.com>
 <20240121110901.1414856-2-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121110901.1414856-2-peng.fan@oss.nxp.com>

On Sun, Jan 21, 2024 at 07:09:01PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Some clocks may exported to linux, while those clocks are not allowed
> to configure by Linux. For example:
> 
> SYS_CLK1-----
>              \
> 	     --MUX--->MMC1_CLK
>              /
> SYS_CLK2-----
> 
> MMC1 needs set parent, so SYS_CLK1 and SYS_CLK2 are exported to Linux,
> then the clk propagation will touch SYS_CLK1 or SYS_CLK2.
> So we need bypass the failure for SYS_CLK1 or SYS_CLK2 when enable
> the clock of MMC1, adding scmi_no_state_ctrl_clk_ops to use software
> enable counter, while not calling scmi api.
>

I would rewrite the commit message something like:
"
    clk: scmi: Add support for forbidden clock state controls

    Some clocks may be exported to OS agent, while certain configurations/
    access to those clocks are restricted to the OS agent by the SCMI platform
    firmware. For example:

    SYS_CLK1-----
                 \
                 --MUX--->MMC1_CLK
                 /
    SYS_CLK2-----

    MMC1_CLK needs to set parent as part of it initialisation and enabling.
    SYS_CLK1 and SYS_CLK2 are exported to the OS agent. The clk propagation
    will access SYS_CLK1 or SYS_CLK2 based on the configuration. However,
    we need bypass the failure to access SYS_CLK1 or SYS_CLK2 when MMC1_CLK
    is accessed and enabled.

    Add a separate scmi_no_state_ctrl clk_ops where the calls to the SCMI
    platform firmware are avoided if the access is not permitted.
"
No need to repost.

I need Stephen's ack to take this together with scmi clk changes.

--
Regards,
Sudeep

