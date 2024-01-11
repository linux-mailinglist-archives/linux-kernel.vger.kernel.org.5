Return-Path: <linux-kernel+bounces-23455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190E582AD09
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94CA9B26687
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8654514F8F;
	Thu, 11 Jan 2024 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZEf06Me"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50D715482;
	Thu, 11 Jan 2024 11:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F119C433C7;
	Thu, 11 Jan 2024 11:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704971507;
	bh=jrjz1XxjlOKskncLo0svJMKugtaa7ZciuJ2FrB6L8Q8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cZEf06MeycSA/AXMtdWc1Lq8zuNUbrjNs0dW+DevuJt8qKC6YAKD9m9iLR1Q1hKEH
	 izjVuMF6hqpm4th1jLi2Q51b0Nu/POJM+nG3FmJ6AzLohMGxg+lnDi+iveGomOaC/j
	 UlE94FN5PsTdGEdpAVDcD8hacnjh0oMRkB1oPqTDHAITn2TQhGOjUVKWZUPI3BpyhC
	 ybMTh3aUf7yNiK6BLmMflw53/lbNPH0TVFJKSUleZiWPBpq7DwTbygRIqkFEx47P67
	 nbAxebZ9rrAr9xJdrMMDX8hC+cMHJ4njt039Vs5CGJFWU+64U4+a0VNQb5VehLzFP2
	 /kIqnkbyXM35w==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Andre Przywara <andre.przywara@arm.com>, Fuyao Kashizuku <fuyao@sjterm.com>
Cc: Jianzhang Mai <maijianzhang@allwinnertech.com>
In-Reply-To: <ZYuFbUUus9apiCpq@debian.cyg>
References: <ZYuFbUUus9apiCpq@debian.cyg>
Subject: Re: (subset) [PATCH] mfd: sun4i-gpadc: adaptation interrupt number
Message-Id: <170497150511.1690895.486576943676385399.b4-ty@kernel.org>
Date: Thu, 11 Jan 2024 11:11:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Wed, 27 Dec 2023 10:01:17 +0800, Fuyao Kashizuku wrote:
> The identifiers are used as IRQ resource numbers, where 0 is treated
> specially.
> 
> This fixes sun4i-gpadc-iio probe failed when request irq.
> 
> The backstack:
> 	WARNING: CPU: 3 PID: 1 at drivers/base/platform.c:451
> 	__platform_get_irq_byname+0xb8/0xc4
> 	0 is an invalid IRQ number
> 	Modules linked in:
> 	CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc6 #9
> 	Hardware name: Allwinner sun8i Family
> 	 unwind_backtrace
> 	 show_stack
> 	 dump_stack_lvl
> 	 __warn
> 	 warn_slowpath_fmt
> 	 __platform_get_irq_byname
> 	 platform_get_irq_byname
> 	 sun4i_irq_init
> 	 sun4i_gpadc_probe
> 	 platform_probe
> 	 really_probe
> 	 __driver_probe_device
> 	 driver_probe_device
> 	 __driver_attach
> 	 bus_for_each_dev
> 	 bus_add_driver
> 	 driver_register
> 	 do_one_initcall
> 	 do_initcall_level
> 	 do_initcalls
> 	 kernel_init_freeable
> 	 kernel_init
> 
> [...]

Applied, thanks!

[1/1] mfd: sun4i-gpadc: adaptation interrupt number
      commit: 112461517fa0cf4135bf242270c2923b61426b60

--
Lee Jones [李琼斯]


