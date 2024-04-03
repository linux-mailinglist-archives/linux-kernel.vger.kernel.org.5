Return-Path: <linux-kernel+bounces-130511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DA5897916
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCBEAB26EEA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F01B155314;
	Wed,  3 Apr 2024 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+fh0ZrN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA721401C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172999; cv=none; b=IkJUFfSQ0i5i8l+lGEpgCqKovXz1ASXQXWS6pZl5tZRvjghfrcmBMNWSjN72kluxrubboeX2cjrbaYuLgEjY9VHTI+CDMJW7FDjHf3LGlnQ7zfIhp6tZdJfoZhS35OpBBseg6vOaprlDlDb6YccfwPB/T7D1clX9qYYDEAQgTT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172999; c=relaxed/simple;
	bh=gOyQp5nt2wzrr0Cd2MttYVX7nXUfhx1MCYH85yWlPJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUu+N+KDFccBVpjF13/4f/zW8pa5C8DGwCV7v7njeSUDWPhTLU2VLtI/8LYbi3vbYZlu0I9sFPYVsHYfwYZf/N+FZUwTTPAG2OnuN1naZGaVlMJDZUg5TNSNOFZp6aMiKD5IInjmoG2x1Fsn8GP21nvn4UkKuVtYlEQpxXQg6hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+fh0ZrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BE3C433C7;
	Wed,  3 Apr 2024 19:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712172999;
	bh=gOyQp5nt2wzrr0Cd2MttYVX7nXUfhx1MCYH85yWlPJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g+fh0ZrN8dwf/figqelMDzl945oOdN8hwWUH2AHJi6ulfmpVN0FEpTs1Zi4itcO6i
	 Xy8sxzNhPdYFhk6d+/zXsGl2NZfrlz9B3fgWAYZmNyqE1EPIqz2ExioW/IT4YJBP24
	 eQnbI+AlrWcsqCqhi3OqpHY9JN8jkNc/4KdTRGUWliuBh3McHHM8Gmru0NWIEoF6cp
	 bmXzAzvoNE8gKzmc13KMWqGnkkM7vZcCrN8ZoePuLRqyj2oX5/GMuf+Q9Xw15GtWNG
	 qnXs9Ria+V3bwxh53TWaY/sXllXCnwi41YQqLTK6BZvO/fTZPZ/LBlmbZT/cXhbWOh
	 gsjS2XTLICEPg==
Date: Wed, 3 Apr 2024 14:36:36 -0500
From: Rob Herring <robh@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Frank Rowand <frowand.list@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH v2] nios2: Only use built-in devicetree blob if
 configured to do so
Message-ID: <171217296117.18436.10335458241355667114.robh@kernel.org>
References: <20240322065419.162416-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322065419.162416-1-linux@roeck-us.net>


On Thu, 21 Mar 2024 23:54:19 -0700, Guenter Roeck wrote:
> Starting with commit 7b937cc243e5 ("of: Create of_root if no dtb provided
> by firmware"), attempts to boot nios2 images with an external devicetree
> blob result in a crash.
> 
> Kernel panic - not syncing: early_init_dt_alloc_memory_arch:
> 	Failed to allocate 72 bytes align=0x40
> 
> For nios2, a built-in devicetree blob always overrides devicetree blobs
> provided by ROMMON/BIOS. This includes the new dummy devicetree blob.
> Result is that the dummy devicetree blob is used even if an external
> devicetree blob is provided. Since the dummy devicetree blob does not
> include any memory information, memory allocations fail, resulting in
> the crash.
> 
> To fix the problem, only use the built-in devicetree blob if
> CONFIG_NIOS2_DTB_SOURCE_BOOL is enabled.
> 
> Fixes: 7b937cc243e5 ("of: Create of_root if no dtb provided by firmware")
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Mark 'dtb' as __maybe_unused
> 
>  arch/nios2/kernel/prom.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

As Dinh has not yet picked this up, I applied it, thanks!


