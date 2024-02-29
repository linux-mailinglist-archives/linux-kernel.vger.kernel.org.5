Return-Path: <linux-kernel+bounces-87147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB91686D033
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B881C21548
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774174AEF2;
	Thu, 29 Feb 2024 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gbbu2zVi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE606CBF4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226703; cv=none; b=C9jWflmzu+Fpf6AzKgc38ScUgN3vLQy0tISiO/hwoZE4XdY77QvksvzCvu3Ze6KPDZgvZllhP3kooIo1ghL8a6AfMIvrfUzhIaeW1EpfL6S2OYTTfKqXVNo+K0UdeeHZSqhIH5AiYgPLz7ATQ4jYEeBQrC1zKZZxx0xe37SLD4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226703; c=relaxed/simple;
	bh=hmzZB1RMnyCzUt+d63lCVZYeV1p79MWV8jAn56LJ9Lk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nKs/rWKheA+t5WwIfI8R/P86Xv/hlMFX+vWHHguFxZdcRDsKuEsyWFBGGmjZ8m3zhxpQYQ/H2xQIHDGgvpNk++Hb2zbBqyGD6DcwA2JlxTqTKj4lQR3JUyAcaLVdkPTPBFIkCzkosZgfEq5wGdsZquUofQsFBFWCRScrODQwhpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gbbu2zVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D06C433C7;
	Thu, 29 Feb 2024 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709226703;
	bh=hmzZB1RMnyCzUt+d63lCVZYeV1p79MWV8jAn56LJ9Lk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Gbbu2zVi2Xrpo9FcCdOMRlUJSeFmHGOhrTS2oFkR0lej/rYIEN5+uFi6K8XVT5ZQB
	 S348O0510nlb4YaaEfMgGtv+as+MKqYQ+ws5WStaYnBmJfoaUU2cwEKcvGmvBSVKHm
	 mAU9embj/4Ty8uy28mgAsCZS2X/H95vKdDXcFB6IK3ojpW+BeOQmL7KkVswOckU++F
	 psJXDobRY869trRSZwzqcQxN1ysGBK4Nq1dfnQTfKJpBsKv8noG1VXhE3Fzh/6BZgy
	 76CA4un00p7REo4GEnnOX7YkAYN8WmDfEbj48TPnazlbWnEcQd48pBNxMxe1wbFxff
	 EQLgFA6ffbLFw==
Date: Thu, 29 Feb 2024 18:11:40 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Sasha Levin <sashal@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>, 
    cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
In-Reply-To: <ZeCsKGwU96sKi_S_@sashalap>
Message-ID: <nycvar.YFH.7.76.2402291754020.13421@cbobk.fhfr.pm>
References: <2024022639-wronged-grafted-6777@gregkh> <ZdytVTOgfvKBBvtn@tiehlicka> <202402271029.FD67395@keescook> <Zd8hPpP_6q_o8uQW@tiehlicka> <202402280906.D6D5590DB@keescook> <ZeA-281OudkWBhd_@tiehlicka> <2024022915-dissuade-grandson-ebd4@gregkh>
 <ZeBRZqJd5HAKaOfC@tiehlicka> <2024022913-borrower-resource-ecc9@gregkh> <nycvar.YFH.7.76.2402291605370.4159@cbobk.fhfr.pm> <ZeCsKGwU96sKi_S_@sashalap>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 29 Feb 2024, Sasha Levin wrote:

> >> It's pretty trivial to get root on most of the "enterprise" kernels
> >
> >Wow, that's a very strong statement you are making here, and I'd now
> >really like to ask you to back that up with some real data.
> 
> Is something like https://www.suse.com/security/cve/CVE-2023-52447.html
> a good example?

- this fix is on our list/queue to be integrated into one of our kernel 
  branches, and was even beore it just got CVE assigned, as it references 
  a commit in Fixes: that we have present in one of our branches, but 
  hasn't been processed yet, mainly because we don't allow unprivileged 
  BPF

- you pointed to a fix for UAF in BPF, which definitely is a good fix to 
  have, I don't even dispute that CVE is justified in this particular 
  case. What I haven't yet seen though how this connects to in my view 
  rather serious 'trivial to get root' statement

Thanks,

-- 
Jiri Kosina
SUSE Labs


