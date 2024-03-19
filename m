Return-Path: <linux-kernel+bounces-107922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C71E880394
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17E51F256DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7205820332;
	Tue, 19 Mar 2024 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="Yw23IB9o"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0007E19BDC;
	Tue, 19 Mar 2024 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869871; cv=none; b=W9Lch6yuv+h2FMqrxnNAy3KywyPsaLI/ctplX0e41qdopeZ0MqjtBuhqPdWAQRy8Q5If3p1Agdv6tW1JMlLWiMHr1NnR4HdpdnWuel38tq1uJe1VSRDFXlIYRmcz8XKhV3e1MiEHveOCyKo3ab5EZYk1oQveBM/T4m5X3TUE2zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869871; c=relaxed/simple;
	bh=3SfnrzwmkkMF8R9JhbYStPD6FosPH0R9WbGo/F4C5jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddkIOmST5czSpzQEB0AiS8c190VCqoS5aceexd9in1/rKfpW2F/PKPxdXMv2tLmIu2h8ijuRavfRSwCStchv2cBz+iNpFz+SR6hGhXj2/kl8scahIf7Eqquygw9c/EiRzEp0npqOKffhiIRu4eruYdkFdYTbFdUT8gew+8U3Vr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=Yw23IB9o; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 8C49F6C5;
	Tue, 19 Mar 2024 10:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1710869867;
	bh=3SfnrzwmkkMF8R9JhbYStPD6FosPH0R9WbGo/F4C5jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yw23IB9oMmIiDLLw4cX4HvHYB6lxgOSm1IJBbODouWBF6Tdg9DIANXgrscEsrepIn
	 w05eEa0mr0polnd9iRwE9B69iugXx+h8TR/FTlvcRIZwBNtXDJfHVpjNVdn1GFUy9M
	 k6xGaqa1kNQcU91A5R5+pBy5Xq8yeo6zMG2TgW/I=
Date: Tue, 19 Mar 2024 10:37:45 -0700
From: Zev Weiss <zev@bewilderbeest.net>
To: Helge Deller <deller@gmx.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	linux-parisc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Florent Revest <revest@chromium.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Yin Fengwei <fengwei.yin@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Oleg Nesterov <oleg@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Stefan Roesch <shr@devkernel.io>,
	Josh Triplett <josh@joshtriplett.org>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, Sam James <sam@gentoo.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] prctl: Generalize PR_SET_MDWE support check
 to be per-arch
Message-ID: <c7bb388b-2c4c-4102-9b84-278f6c6855ee@hatter.bewilderbeest.net>
References: <20240227013546.15769-4-zev@bewilderbeest.net>
 <20240227013546.15769-5-zev@bewilderbeest.net>
 <Zd24aCps4xD28c74@shell.armlinux.org.uk>
 <e391cad0-7b98-4efd-bea1-cf5ab9c626bf@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e391cad0-7b98-4efd-bea1-cf5ab9c626bf@gmx.de>

On Tue, Feb 27, 2024 at 11:53:59AM PST, Helge Deller wrote:
>On 2/27/24 11:24, Russell King (Oracle) wrote:
>>On Mon, Feb 26, 2024 at 05:35:41PM -0800, Zev Weiss wrote:
>>>There exist systems other than PARISC where MDWE may not be feasible
>>>to support; rather than cluttering up the generic code with additional
>>>arch-specific logic let's add a generic function for checking MDWE
>>>support and allow each arch to override it as needed.
>>>
>>>Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>>>Cc: <stable@vger.kernel.org> # v6.3+
>>
>>PA-RISC folk need to ack/review-by this patch.
>
>I'm fine with patch 1/2:
>Acked-by: Helge Deller <deller@gmx.de> # parisc
>
>>Alternatively, it needs
>>to be restructured to add the arch_memory_deny_write_exec_supported()
>>override without touching the PA-RISC code, which then makes the Arm
>>patch independent of the status of the PA-RISC patch. That will allow
>>the Arm issue to be solved even if an ack is not forthcoming for the
>>PA-RISC parts.
>>>Alternatively, I wonder whether akpm would be willing to pick up this
>>patch set as-is.
>
>I have no preference, but I think both patches should be pushed
>together via arm tree or akpm.
>
>Helge

Ping...Russell, Andrew, any thoughts on how this could move forward?


Thanks,
Zev


