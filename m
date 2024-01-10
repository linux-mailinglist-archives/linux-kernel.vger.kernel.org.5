Return-Path: <linux-kernel+bounces-22438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59459829DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55780B270A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA344C3BA;
	Wed, 10 Jan 2024 15:40:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC6B4BA8F;
	Wed, 10 Jan 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 819312F4;
	Wed, 10 Jan 2024 07:41:15 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBF743F64C;
	Wed, 10 Jan 2024 07:40:27 -0800 (PST)
Date: Wed, 10 Jan 2024 15:40:25 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sudeep.holla@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, ranjani.vaidyanathan@nxp.com,
	glen.wienecke@nxp.com, nitin.garg_3@nxp.com, chuck.cannon@nxp.com,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 2/2] clk: scmi: support state_ctrl_forbidden
Message-ID: <ZZ66adlVpON9zVbH@pluto>
References: <20231207093345.581048-1-peng.fan@oss.nxp.com>
 <20231207093345.581048-2-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207093345.581048-2-peng.fan@oss.nxp.com>

On Thu, Dec 07, 2023 at 05:33:45PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Some clocks may exported to linux, while those clocks are not allowed
> to configure by Linux. For example:
> 

Hi,

> SYS_CLK1-----
>              \
> 	     --MUX--->MMC1_CLK
>              /
> SYS_CLK2-----
> 
> MMC1 needs set parent, so SYS_CLK1 and SYS_CLK2 are exported to Linux,
> then the clk propagation will touch SYS_CLK1 or SYS_CLK2.
> So we need bypass the failure for SYS_CLK1 or SYS_CLK2 when enable
> the clock of MMC1.
> 


So I was puzzled a bit at first (as said) by the fact that here we
silently swallow the failure if the SCMI Clock cannot be disabled, BUT
then I spotted in include/linux/clk.h

	/**
	 * clk_enable - inform the system when the clock source should be running.
	 * @clk: clock source
	 *
	 * If the clock can not be enabled/disabled, this should return success.

..so I suppose it is fine for the CLK framework at the end.

My next remaining question is why are you not doing the same when
(ret == -EACCES && clk->info->state_ctrl_forbidden) for atomic_ops ?

I.e. in:

	clk-scmi.c::static int scmi_clk_atomic_enable(struct clk_hw *hw)

Any particular reason (beside not needing it in your particular case...)

Thanks,
Cristian


