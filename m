Return-Path: <linux-kernel+bounces-100416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9730C879731
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6381F222D8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C057C091;
	Tue, 12 Mar 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2vKUe73U"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9176997A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710256315; cv=none; b=DMDI1fr+N4OYQKTEVr1+xshnYLrL7GiHWz7+wcH4X9a4jjGX24L7Slnb9A053U5P9Lv4tCovXu+3ZPyF6p4id+N5g4iVqj+HdYDzgn1B6U+dIRdT7f+cORXpmtVYv6boJJOHg/cP0KhT73VmGjRDDglkOTV1qm9bgUWlycDV69E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710256315; c=relaxed/simple;
	bh=V7zXgBHa7JMrubQ33eVoCvMw3s3BKUf2E4GG2ktRgUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZjUPGx5ySqSjphCc4gZrCXG5EheA+7B8oBkjjEbPfD7R33z5faIGJ/LZbmMTmDOvYCwYK2mFUoNXYvDNQoeoNfCg0j49n7pSoAdRYXbU/WeRaZrH7Ae56SWIT2dwlQjiu19eICDPLeHq4Pbml51Roq6mT5kW5S+fjMUAVV8Gj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2vKUe73U; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BxMNXhCM/KFz8Y7nf+UlFxJyjujwiOzBHhW0CCs32LQ=; b=2vKUe73U2rA47MGpDb6wS6UmPu
	12gk6++6IwnZh39s7oWgiodpXE6OYU9haEvIxkfua7kV0nI8ERaptbRBULpbBPuSsKX354lD7eICG
	R5IeqC6Q3eNYyv211VVCKOHg5ZchLJ9nqu6JuTe5Z52aA+ZQ/W329CdUDxHfbcCwfMZE5f1c43ybz
	+xIgcnT0aCDY119+OFt0aWpuxE6R6vkmik6lazpgwZhVh/AUQKYiLojB/26aeInUS+CjzgVgg3oRm
	YbJITTikwyhlaJrkEsa0wmo+BOcRP/3SPqeZB4yjcgEkA3CJocSjy/hG2rJPbkXd+MYhwYFJq7sKl
	U6S5ncEw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3nE-00000006JDw-0WZV;
	Tue, 12 Mar 2024 15:11:52 +0000
Date: Tue, 12 Mar 2024 08:11:52 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Lee Jones <lee@kernel.org>, cve@kernel.org,
	linux-kernel@vger.kernel.org,
	Joel Granados <j.granados@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2023-52596: sysctl: Fix out of bounds access for empty
 sysctl registers
Message-ID: <ZfBwuDyzLl5M0mhC@bombadil.infradead.org>
References: <2024030645-CVE-2023-52596-b98e@gregkh>
 <Ze68r7_aTn6Vjbpj@tiehlicka>
 <Ze9-Xmn8v4P_wppv@bombadil.infradead.org>
 <20240312091730.GU86322@google.com>
 <ZfAkOFAV15BDMU7F@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfAkOFAV15BDMU7F@tiehlicka>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Mar 12, 2024 at 10:45:28AM +0100, Michal Hocko wrote:
> On Tue 12-03-24 09:17:30, Lee Jones wrote:
> [...]
> > > Backporting this is fine, but wouldn't fix an issue unless an external
> > > module had empty sysctls. And exploiting this is not possible unless
> > > you purposely build an external module which could end up with empty
> > > sysctls.
> 
> Thanks for the clarification Luis!
> 
> > Thanks for the amazing explanation Luis.
> > 
> > If I'm reading this correctly, an issue does exist, but an attacker
> > would have to lay some foundations before it could be triggered.  Sounds
> > like loading of a malicious or naive module would be enough.
> 
> If the bar is set as high as a kernel module to create and empty sysctl
> directory then I think it is safe to say that the security aspect is
> mostly moot. There are much simpler ways to attack the system if you are
> able to load a kernel module.

Indeed, a simple BUG_ON(1) on external modules cannot possible be a
source of a CVE. And so this becomes BUG_ON(when_sysctl_empty()) where
when_sysctl_empty() is hypotethical and I think the source of this
question for CVE. Today's that not at boot time or dynamically with any
linux kernel sources released, and so its only possible if:

  a) As Joel indicated if you backported an empty sysctl array
     (which would be unless you carried all the infrastructure to support it).

  b) an external module has an empty sysctl

HTH.

  Luis

