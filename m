Return-Path: <linux-kernel+bounces-125636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D778929E7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE0A282EC5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3A2C154;
	Sat, 30 Mar 2024 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k8l97VZ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0F8BA57;
	Sat, 30 Mar 2024 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711789774; cv=none; b=sGA47sKGRz1NCfjOGXb0QhL9POJUuAQ/iGabufH7PwRdiFmh1ehL9J1a3QR+VAOHwYkzKxYPsr9DcMWLJGu+9YhB2ecIGfD86v+GLUu4onRajW8fAZw+BYHs11Nk7H6xQHGNXeuDOo265RbAcB2HYFPf+V3xHqBK+hUhpjRMJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711789774; c=relaxed/simple;
	bh=xreq82aGzQ3JmBuEJlKHp0cTF0bfinus9BUKu+7kd5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdwES2SuZv2Wu7XpjMA/SVgOq1o3URhep4H+Wxyr6iHgn+pi0h0pPNbKviwaysafFUqwvgYmej+CE1X6LSViNzMszK5BtRF0nCO5phYoO/35HKgtTDD1iHQByeojriUYXOzhIt1TAMWI5/3m7Jv3XJxcUtf13MUAUlCbheiab54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k8l97VZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2315C433F1;
	Sat, 30 Mar 2024 09:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711789774;
	bh=xreq82aGzQ3JmBuEJlKHp0cTF0bfinus9BUKu+7kd5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8l97VZ7gFFFSU5qXSw2gg04x+YsKwGS8ISNYB0XDiQDA2bDDdB8HUzjNEGJ0YKe5
	 5BHQB5gh9DqojaFlUMDDh3ecGqEUGKG0Oz6pzjdZMR+esZ+FMbXTUV7KR8848dTK3R
	 3vL7zzkKx5Ex3Ru6rNpWT92PGZu5M8JD4hg12StY=
Date: Sat, 30 Mar 2024 10:09:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "GONG, Ruiqi" <gongruiqi1@huawei.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org,
	Jon Ringle <jringle@gridpoint.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Weiyang <wangweiyang2@huawei.com>
Subject: Re: [PATCH stable 5.10 5.15 v2] serial: sc16is7xx: convert from
 _raw_ to _noinc_ regmap functions for FIFO
Message-ID: <2024033023-scorch-volley-7265@gregkh>
References: <20240330012520.1904970-1-gongruiqi1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330012520.1904970-1-gongruiqi1@huawei.com>

On Sat, Mar 30, 2024 at 09:25:20AM +0800, GONG, Ruiqi wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> commit dbf4ab821804df071c8b566d9813083125e6d97b upstream.
> 
> The SC16IS7XX IC supports a burst mode to access the FIFOs where the
> initial register address is sent ($00), followed by all the FIFO data
> without having to resend the register address each time. In this mode, the
> IC doesn't increment the register address for each R/W byte.
> 
> The regmap_raw_read() and regmap_raw_write() are functions which can
> perform IO over multiple registers. They are currently used to read/write
> from/to the FIFO, and although they operate correctly in this burst mode on
> the SPI bus, they would corrupt the regmap cache if it was not disabled
> manually. The reason is that when the R/W size is more than 1 byte, these
> functions assume that the register address is incremented and handle the
> cache accordingly.
> 
> Convert FIFO R/W functions to use the regmap _noinc_ versions in order to
> remove the manual cache control which was a workaround when using the
> _raw_ versions. FIFO registers are properly declared as volatile so
> cache will not be used/updated for FIFO accesses.
> 
> Fixes: dfeae619d781 ("serial: sc16is7xx")
> Cc:  <stable@vger.kernel.org> # 5.10 5.15
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Link: https://lore.kernel.org/r/20231211171353.2901416-6-hugo@hugovil.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> ---
> 
> v2: Backport to both 5.15 and 5.10
> 
> The mainline commit dbf4ab821804 ("serial: sc16is7xx: convert from _raw_
> to _noinc_ regmap functions for FIFO") by Hugo has been assigned to be
> CVE-2023-52488, but for stable branches lower than 6.1 there's no
> official backport.
> 
> I made up this backport patch for 5.10, and its correctness has been
> confirmed in previous communication with Hugo. Let's publicize it and
> merge it into upstream.

Now queued up, thanks.

greg k-h

