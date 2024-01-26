Return-Path: <linux-kernel+bounces-39791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3926283D620
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5C5BB23A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A661C1DA4F;
	Fri, 26 Jan 2024 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uXq8Q537"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8969C1D52B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258989; cv=none; b=esuhfqlbnnA4mqmO/K5adAqN9ylILD5YuBmZBNt2Ir70PS4orL5TGtmPpOOJ/bcnnbXi5OrIypWId1YKiSxShoL+dop1txHiJOYAw4J/AtW2xVi84nSW56jQQRPM43EmS7nfVigeJP77JK3+3XGYHFNnrUvRA0JfAvjm2GYumdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258989; c=relaxed/simple;
	bh=brYXUQsH/TMsNFWCycIBH0uKvwRbXqVAUVOr5hAHiuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Agn/7fBbcKQAtgIq2cpaQyoE/LOjHMTMxx3ooY4U24O3OSkeKmJcQIHtEji3OdnBzcER9cl9P6zZ2pnL0+EloDNsCDkfmxp7H3EOqtoiz+BaMqz2Jg7+OXcJfqeJVAY/EPhTjXwMXILjxC4oKpaZAQ/gcbSqIeNdz9lONLetAJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uXq8Q537; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DAC40293E3;
	Fri, 26 Jan 2024 03:49:41 -0500 (EST)
	(envelope-from adamg@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=brYXUQsH/TMsNFWCycIBH0uKvwRbXqVAUVOr5hA
	HiuM=; b=uXq8Q537s3lv47lVM8jeymVzCHUyFpZO8r0tz7VvTIMy5+RcGp3yRvl
	A1oqftK7NhXIoJfTctWAMXDuXmKn9YYy1CrLcNNr67IwoB2qkSz19X98RFYPUmIX
	n6cF9nkwn1i+6ZtuHIlQgQq0ye/JBrxwwdgjxi1+xZP7IHou+aF0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D3799293E2;
	Fri, 26 Jan 2024 03:49:41 -0500 (EST)
	(envelope-from adamg@pobox.com)
Received: from pogo.deviceside.com (unknown [71.19.144.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A92C5293E1;
	Fri, 26 Jan 2024 03:49:38 -0500 (EST)
	(envelope-from adamg@pobox.com)
Received: from iguana.24-8.net (99-122-168-208.lightspeed.irvnca.sbcglobal.net [99.122.168.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: iguana@pogo.deviceside.com)
	by pogo.deviceside.com (Postfix) with ESMTPSA id 2571EC09AD;
	Fri, 26 Jan 2024 00:49:37 -0800 (PST)
Date: Fri, 26 Jan 2024 00:49:35 -0800
From: Adam Goldman <adamg@pobox.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: mask previous entry's type bits when
 looking for leaf
Message-ID: <ZbNyHg3TTWpjiieI@iguana.24-8.net>
References: <ZbJQ0JdbGixJouvn@iguana.24-8.net>
 <20240126011705.GA22564@workstation.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126011705.GA22564@workstation.local>
X-Pobox-Relay-ID:
 D6B655E4-BC27-11EE-8FCE-A19503B9AAD1-07713566!pb-smtp21.pobox.com

On Fri, Jan 26, 2024 at 10:17:05AM +0900, Takashi Sakamoto wrote:
> Would I request you to update the API documentation of fw_csr_string()
> as well and send the renewed patch as take 2?
> 
> 
> I have a mixed feeling about the change, but I'll finally accept it since
> we face the exception against documentation.
> 
> As you know, in Annex A of document for configuration ROM of AV/C
> device[1], we can see the legacy layout of configuration ROM (page 22).
> In the layout, the descriptor leaf entry for vendor name locates after
> the immediate value entry for vendor ID, then the directory entry for
> vendor directory locates. However, in the case of Sony DVMC-DA1, the
> descriptor leaf entry locates after the directory entry. It is an
> exception.

Hi Takashi,

Thank you for your review and feedback.

After checking the 1394TA Configuration ROM document again, I agree that 
the leaf entry for vendor name should be after an immediate value entry 
according to this standard. The DVMC-DA1 does not conform. We should 
consider its configuration ROM format to be another variation of the 
legacy format. This variation is not mentioned in Annex A.

I will update the API documentation of fw_csr_string() and send a 
revised patch.

-- Adam

