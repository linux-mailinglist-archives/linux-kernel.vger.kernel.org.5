Return-Path: <linux-kernel+bounces-27310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A58682ED9E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9911C231CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA7F1B806;
	Tue, 16 Jan 2024 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0U/z0Je+"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739971B7F9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HDuqmhpkWHxT2M2pI/xOk7Pu42NAZCIU40/WZmESav8=; b=0U/z0Je+MXosykY6zSoUo4s8jD
	JK/PdzgW1Zzy6OZi8KGwD8Y2QQuTlTSyPpkkzuQ2ltD5fNvgVrkXqNDR9yhj8AE18qtzc5lXACY9/
	2FvIKU8u8IfjTAxNfTG58wXOZ2Px9a/7gPbUr9nr+m1FUFObWmrkcFKTSyOIguhMPEprbmn7BmPfO
	6LrAeA/eO9Kfrgfefj8NHbWdfSYoRFva2XoLGL9xOzbkn9TUdut8jQhBdRtE+7QBZZ+yyWEaQkgJ4
	fdaly8yM8fITkf9ee2ukTzN2js+Samar/NV4KySHQf+OVXBk54A12hKvtKtNZP2FpySY7sVBK7qrW
	uvepZy+w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52656)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rPhYM-0003Og-2w;
	Tue, 16 Jan 2024 11:24:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rPhYI-0003pb-Hq; Tue, 16 Jan 2024 11:24:18 +0000
Date: Tue, 16 Jan 2024 11:24:18 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Mackay <eric.mackay@oracle.com>
Cc: cl@linux.com, Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com,
	Valentin.Schneider@arm.com, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, catalin.marinas@arm.com,
	dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	robin.murphy@arm.com, vanshikonda@os.amperecomputing.com,
	yang@os.amperecomputing.com
Subject: Re: [PATCH] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
Message-ID: <ZaZnYrv/QThRjW2Q@shell.armlinux.org.uk>
References: <794a1211-630b-3ee5-55a3-c06f10df1490@linux.com>
 <20240115235911.80586-1-eric.mackay@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115235911.80586-1-eric.mackay@oracle.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 15, 2024 at 03:59:11PM -0800, Eric Mackay wrote:
> Whitespace issues aside, I have applied the patch on top of kernel 6.1.55 and tested on both a dual-socket Ampere Altra machine with < 256 CPUs, and a dual-socket AmpereOne machine with > 256 CPUs. Works as expected, with all CPUs visible and functional.
> 
> >   config NR_CPUS
> >   	int "Maximum number of CPUs (2-4096)"
> >   	range 2 4096
> > - 	default "256"
> > + 	default 512
> 
> Nit: the new default value should be in quotation marks, if we want to be pedantic

I can't find anything that requires the quotes - and as "range" doesn't
for consistency it seems that default shouldn't either. There's nothing
in the documentation that indicates quotes should be used, and looking
at the code, it's just treated as a string. The only thing that quotes
seem to do is to ensure that whitespace will be included.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

