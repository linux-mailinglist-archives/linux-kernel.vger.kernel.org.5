Return-Path: <linux-kernel+bounces-63953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458278536B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766611C2313B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEB15F866;
	Tue, 13 Feb 2024 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s0xIVI1x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FD1BA57
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843519; cv=none; b=rRytgebkpX4XHDAL8OLdMBoauP2i2FiK06gdA+8kLquv5ejCz1tuRpfaxXlG6aZkovyK/poxXfMDYE6sbHbG7wp3YP461ghO41VswkF1kfhGHSHY3W8E5c9BKEZafVOqRisNxcVPp87D4ogu+mmCggXTOG2GD1PCt3mwP//sJ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843519; c=relaxed/simple;
	bh=3Wn8/Zpy2yG+SGHLWljK9Yqwsf7+Mdog6KEdCJChDDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDk8O3TSQ5bDmc1aryfMcDnRQdqVwjhtofdGoLxfwCclSCmJjve2FgtJ25sq0tnQx1cs81jEdC6ODwXMwTkvNrZGefEvth3O7hcNh2uYhwVQxDDWaB3ONl2nIA4ucn/MuZj1xTaPizIssXgczOVe82imeJlNbSKC4r/x6e+31ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s0xIVI1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B057C433F1;
	Tue, 13 Feb 2024 16:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707843518;
	bh=3Wn8/Zpy2yG+SGHLWljK9Yqwsf7+Mdog6KEdCJChDDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0xIVI1xlNQikSPIEeFcoD00sp9Ncwn4enoJJcqn5Gss2X59mBL7XOARYaHfAp1Ks
	 fuu589elkaQVv9qCK5N99t969mrSNjBLjZhazjntwksAAR7WMCiAI3Y9EawP+naEDc
	 sZMQEMgMgyVhDAoTkJRVT09lOT2PXIr7CFHJEGPA=
Date: Tue, 13 Feb 2024 17:58:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Maxwell Bland <mbland@motorola.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, catalin.marinas@arm.com, will@kernel.org,
	dennis@kernel.org, tj@kernel.org, cl@linux.com,
	akpm@linux-foundation.org, shikemeng@huaweicloud.com,
	david@redhat.com, rppt@kernel.org, anshuman.khandual@arm.com,
	willy@infradead.org, ryan.roberts@arm.com,
	rick.p.edgecombe@intel.com, pcc@google.com, mark.rutland@arm.com,
	rmk+kernel@armlinux.org.uk, tglx@linutronix.de, gshan@redhat.com,
	Jonathan.Cameron@huawei.com, james.morse@arm.com,
	awheeler@motorola.com
Subject: Re: [PATCH] arm64: allow post-init vmalloc PXNTable
Message-ID: <2024021300-gently-ether-3978@gregkh>
References: <CAP5Mv+ydhk=Ob4b40ZahGMgT-5+-VEHxtmA=-LkJiEOOU+K6hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP5Mv+ydhk=Ob4b40ZahGMgT-5+-VEHxtmA=-LkJiEOOU+K6hw@mail.gmail.com>

On Tue, Feb 13, 2024 at 10:05:45AM -0600, Maxwell Bland wrote:
> Apologies if this is a duplicate mail, it will be the last one. Moto's SMTP
> server sucks!!

This shouldn't be in the changelog, it needs to go below the --- line.

Also, your patch is corrupted and can not be applied :(

thanks,

greg k-h

