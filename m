Return-Path: <linux-kernel+bounces-130481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF4C8978B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95B41F283F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1900154BF0;
	Wed,  3 Apr 2024 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4LPiThB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAB433D5;
	Wed,  3 Apr 2024 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712170817; cv=none; b=EvIiNIV54R3QePJWlSZ0Y0U1pJmstCyK4GbxPvCK7odq2PtphxG5XYuTqV2OMc1KQo3Ldt2vH0USo5CyvFaSN9RM97G+a74S/gnaZPlbXHMZgf06MjUBeTLEh4H6rP7bMJIIsmDlyiVLm8eyEBDJp7x+OyvZA/4UfvKFy/PYAKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712170817; c=relaxed/simple;
	bh=FnLc0xjDH7xNagiFVGl2kwxCv3sFYAI/lw1UPhyLSrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm5QotppTaLTW+7U/GN7LKpB3kTINxTsrzzzq4SToOGgxq8UTVwDBnquJH730VyM6dso7UqiSToXQiom8TAn1cjV3mQSqaeQYtD4H05jd6hejbDAr0uLWsZSLIS1dEiVLX1++zeXZ1ts989bNjbo7g13MRgImlpxbK2BqfRlSBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4LPiThB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9924C433F1;
	Wed,  3 Apr 2024 19:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712170817;
	bh=FnLc0xjDH7xNagiFVGl2kwxCv3sFYAI/lw1UPhyLSrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S4LPiThBG3HUF7CSutkW+X3s2u3nuz5JpTXVJ0T7xZ9gS823TACgNXlkrYWVyuc+C
	 pvvLfEjERuGCuDdrZCRDJWph1K8qazaYSV4WlldF9VDovQfr7XgCHU7pmX33jB86Fj
	 FG44XgEUJxc+TQ7tZ0UUzMDr02BtXjXZfZEtK640QeeMda7+xtg7JU+v/nfL3oO5sc
	 sDEMl/UZVdGZZ5ZxOAuZ851bJD3zbuNaSY5X898X2HuyTzFlv1LQhZohpgs7CD0sFC
	 5ne62XjZDPVqo4H/Ys4/2RHIRGnDQD8gAn5ubWXcpr3VQn6H6neNmYQf4V6uzp9yAF
	 n765LCf27h0uw==
Date: Wed, 3 Apr 2024 22:00:12 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240403190012.GV11187@unreal>
References: <2024032248-ardently-ribcage-a495@gregkh>
 <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG>
 <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184832.GO11187@unreal>
 <cefa2b9a-4227-969e-d31e-c19a552b9c1c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cefa2b9a-4227-969e-d31e-c19a552b9c1c@gmail.com>

On Wed, Apr 03, 2024 at 01:26:50PM +0100, Edward Cree wrote:
> On 02/04/2024 19:48, Leon Romanovsky wrote:
> > On Tue, Apr 02, 2024 at 05:32:44PM +0100, Edward Cree wrote:
> >>  you're getting maintainer pushback.
> > 
> > May I suggest you to take a short break, collect names of people who
> > participated in this discussion and check in git history/MAINTAINERS
> > file their contribution to the linux kernel?
> Whether you like it or not, Kuba is a kernel maintainer.
> And thus, semantically, a Nack from him is "maintainer pushback".
> That remains true regardless of who else in the discussion is also
>  a kernel maintainer.
> 
> If you had an actual point, feel free to explain to me, without the
>  veiled language, what was so 'inappropriate' about my posting.

Language, tone, and content of your email were inappropriate:

https://lore.kernel.org/all/0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com/
..certain vendors whining...

^^^^ Language

.. possibly they thought devlink params would just get rubber-
 stamped — and now they're finding that the kernel's quality standards
 still apply. ...

^^^^ Tone
EVERYONE who participated in this discussion knows about kernel's
quality standards.

.. Patches aren't languishing for want of reviewer resources; it's just that it
 takes *submitter* time and effort to bring them up to the quality level
 that's required, and occasionally the vendor has to (shock! horror!)
 tell the world what one of their magic knobs actually *does*. ...

^^^^ Content
This paragraph alone shows that you completely didn't understand the
discussion here.

Thanks

