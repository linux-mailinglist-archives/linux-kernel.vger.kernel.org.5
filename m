Return-Path: <linux-kernel+bounces-160108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F478B3935
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8391F2144E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDE0149C7F;
	Fri, 26 Apr 2024 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wq3WFSfS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8921487E7;
	Fri, 26 Apr 2024 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139744; cv=none; b=XfD5ZqITZDvWhaorX68U678J49cvdEQYGFY2SPdhyiDvH9Gmx4wjXDq8OQiERk45oJLKh8yvOztfT/XQbYRgZ81tHuClH+42NjXbWlRTr0g+B1OtIY2D7dKCw9+03vlYpSl6jyMiAmhRS+ZhDNyz1gDjpwNml0zYaGyXg2FnQ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139744; c=relaxed/simple;
	bh=UbY+ExOiqPp3H3piUK3cAIwA80EItQL1YsmY71g3gIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGhp/Sg2V8grGu/JIvkue8zucHwwVxqdPUz+mOnijDaD+1tQlgKUzDrhvcxOZwYJNvlOvoRFD04oJNxeDS4YL6snoPlti9SPZhbvWCeK5pT8n79jwvQgozg0mAQ0mhHVbPRls4uJ6vmRGojgsThC0IvVMFRpium3Tdvp21eJd/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wq3WFSfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D865C113CD;
	Fri, 26 Apr 2024 13:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714139743;
	bh=UbY+ExOiqPp3H3piUK3cAIwA80EItQL1YsmY71g3gIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wq3WFSfS2sElJ7Hs1e/HlvhMlSIefIBTNkW/FXDV7NZp9kYLCdddl1JH8flEXyQQZ
	 FBitLBASbbEpo80pF+5jodBDqTzniulOry9y46lTKQwSdwZdhIbMutmsFJQUUyTGFm
	 ADYvITYipGpV/rnDc7gqdxep4lwBnxz6bEc48ODk=
Date: Fri, 26 Apr 2024 15:55:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: lumingyindetect@126.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com,
	jirislaby@kernel.or
Subject: Re: [PATCH] serial: 8250_lpss: Fix memory leak in lpss8250_probe()
Message-ID: <2024042652-even-mud-476d@gregkh>
References: <20240426133959.1294012-1-lumingyindetect@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426133959.1294012-1-lumingyindetect@126.com>

On Fri, Apr 26, 2024 at 02:39:59PM +0100, lumingyindetect@126.com wrote:
> From: LuMingYin <lumingyindetect@126.com>
> 
> The return statements at line 347 and line 351 in the lpss8250_probe() function result in a memory leak of the variable pdev.
> Add a label named free_irq_vectors in the lpss8250_probe() function to release the memory area pointed to by pdev.
> Modify the two return statements mentioned above to jump to the label "free_irq_vectors" instead.
> 
> Fixes: e88c4cfcb7b888ac374916806f86c17d8ecaeb67 ("serial: 8250_lpss: fix memory in lpss8250_probe()")
> 
> Signed-off-by: LuMingYin <lumingyindetect@126.com>

Please stop and read all of the instructions provide, and then go read
the "how to submit your first patch" tutorial at kernelnewbies.org and
compare that to what you have been sending here.

You also keep sending stuff to quickly, patches should be, at the most,
sent once a day, and even then, that would be very quick.

Relax, take the weekend off, and come back next week with a proper
change based on the documentation.

thanks,

greg k-h

