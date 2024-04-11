Return-Path: <linux-kernel+bounces-140211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A658A0CED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81AB62858DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AA4145B16;
	Thu, 11 Apr 2024 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjONS3jd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E813FD80;
	Thu, 11 Apr 2024 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829462; cv=none; b=fDOTUyZIXwQVdUPucZJLqFtuUokFnkjNYBnQf3Mr8dsTpM90SSp+koCXL47lSwiw/0DshzW/ftHpvUBCq8+yoLCNc3Uvr6CQKoBG143/4t8kny423KEUGyqEL/cwcOL1hEgbdt73iaTDbuLiADBJAG7Us+UruavppMjnKdRSHP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829462; c=relaxed/simple;
	bh=ddEn6dsY+sZMSzGOadf4LVubU2QOou4OVQtHAq+mQ3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+a795rGy9LdtJgYPqHmi8sTBPNfgojByKfB4L/pEQeOpZJLKZ1QV8Wl7T+33Nwiz3r5qVobijo/vV32RUIbD6dK3dKQl1RFKIKxnkS+ysFMwNfbI2poOAKkPfzmHoP9q9R68PfxifHt2CkM8ornRruQ8+Vup2/UHd0+bobFZgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjONS3jd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7B0C433C7;
	Thu, 11 Apr 2024 09:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712829462;
	bh=ddEn6dsY+sZMSzGOadf4LVubU2QOou4OVQtHAq+mQ3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LjONS3jdbec+kJkUr6xn5Zse32GJ9eoxLuA1zCngOPZItQj2TAX2AhhCADX3MPmb4
	 h8t73/28VeVDYus3M+Z4B1lgDxaVizr10J4Cvzq02gNFb4iyBNq0WjLdNGzn5qlA7W
	 AcvF6ZSzyCj/ZqdzenAzqQYNoAqhwteozNUpeReIWdu74CBS+xIXVpospm90rhKz6D
	 uBe0BeDmUnkHLQ9vhgTRlgDI648umeQ7bkyTxRIQEKuwwSV2lm9mNS0Zg7JfaEpczg
	 TebiNMsEHc2H4AVPhj7DhFmJwniGupTITYaPl+j9BUOpET/WhVqaC7MkMiICbI41gf
	 x8HxJcfOO3ETg==
Date: Thu, 11 Apr 2024 11:57:39 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: bpf: fix hid_bpf_input_report() when hid-core is
 not ready
Message-ID: <p33fpx76v6sbbp2sg73fktz27lcq54muaox7n62cir5bb6ydku@3rsmnybe3roc>
References: <20240411-fix-hid-bpf-v1-1-4ae913031a8c@kernel.org>
 <nycvar.YFH.7.76.2404111107370.5680@cbobk.fhfr.pm>
 <jdwmoghmwice2arahxdksjs224pssdtcfipxxrxhm3ujv6jfzc@n2s5nyiddjnt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jdwmoghmwice2arahxdksjs224pssdtcfipxxrxhm3ujv6jfzc@n2s5nyiddjnt>

On Apr 11 2024, Benjamin Tissoires wrote:
> On Apr 11 2024, Jiri Kosina wrote:
> > On Thu, 11 Apr 2024, Benjamin Tissoires wrote:
> > 
> > > Reported by linux-next:
> > > After merging the hid tree, today's linux-next build (x86_64 allmodconfig)
> > > failed like this:
> > > 
> > > x86_64-linux-gnu-ld: vmlinux.o: in function `hid_bpf_input_report':
> > > (.text+0x1c75181): undefined reference to `hid_input_report'
> > > 
> > > Caused by commit 9be50ac30a83 ("HID: bpf: allow to inject HID event
> > > from BPF")
> > > 
> > > I just forgot to put the indirection in place.
> > > 
> > > Link: https://lore.kernel.org/linux-kernel/20240411105131.7830f966@canb.auug.org.au/
> > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > 
> > Please also include Fixes: tag.
> 
> Oops, correct. I'll add the following (in case b4 is smart enough to
> pick it up by itself):

FTR, b4 is actually smart enough to pick this one up :)

> 
> Fixes: 9be50ac30a83 ("HID: bpf: allow to inject HID event from BPF")
> 
Cheers,
Benjamin

