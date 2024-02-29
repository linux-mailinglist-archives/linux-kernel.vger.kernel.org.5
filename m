Return-Path: <linux-kernel+bounces-87189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3057286D0DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05541F2425E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3631D70ADE;
	Thu, 29 Feb 2024 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOoVxgBv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC3C70ACB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228290; cv=none; b=tqTnP6Snif8WQQSS+olFn1bhEn/HlW+1j1mGEbNnYNLNEG+jY3dRFNQr4Wj5BSfpDBpEOaelmomRVwejcqFWErR7MPv2RicyZW53cGV22lZo7xFb4UpghoECfSwGSakopPPNueJ3rZbCNT9lN+InM4v7pNVeXvKNLpegYrBOGp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228290; c=relaxed/simple;
	bh=tUITHwST1lYVxq/4qPfl41pArvRGDhecffC7VYCP++Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq1oi8XirZ46pEsJvxpIQabCLAFBYmDnDRMnIGCU5pnis6h3J2oAyWCFkMBYpZp8ELJAW3biS9AqF6JtZk21kj2ZC1gvQprkbk53ezSDEjhszwd+gMSV56bFC+60vuzxKBUOrVDIBDtym4oUe1h3kzI9EH/M7wzHUuaddOGWl3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOoVxgBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD13FC433F1;
	Thu, 29 Feb 2024 17:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709228290;
	bh=tUITHwST1lYVxq/4qPfl41pArvRGDhecffC7VYCP++Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KOoVxgBvv3gSAu10U8qKAoKX7/KA6hFp0mJrhMOTvVkkwJ3GcVpQnbhfwrq/tGg5T
	 korFgRDcJj6S8pnzFLFT1FZu3KD6OBfqFKOpITNT288Pc4UgkHb3f/jRQfFjTlLb4O
	 bhwVc1XBb5LJH4QGwgIxfGgO2V81UymBcsmv5XLqfMP1cbXNLH0jCIoDmxPN6Jmt9m
	 O5XVjopeeRJaaK9WeRlTifJoaqSFX2Eq4WR2FSlVPa6UnP+L1t/MShmS25rZ/xyRdu
	 ojm98sDXHu97OeXUjPaekU2y7LyaDJjpilhas8DdMqRfQerkjU/LSOIWJ/thlQw1IH
	 72YQNIpMUNS/Q==
Date: Thu, 29 Feb 2024 12:38:09 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>,
	cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
Message-ID: <ZeDBAW16ZbjNJWkn@sashalap>
References: <202402271029.FD67395@keescook>
 <Zd8hPpP_6q_o8uQW@tiehlicka>
 <202402280906.D6D5590DB@keescook>
 <ZeA-281OudkWBhd_@tiehlicka>
 <2024022915-dissuade-grandson-ebd4@gregkh>
 <ZeBRZqJd5HAKaOfC@tiehlicka>
 <2024022913-borrower-resource-ecc9@gregkh>
 <nycvar.YFH.7.76.2402291605370.4159@cbobk.fhfr.pm>
 <ZeCsKGwU96sKi_S_@sashalap>
 <nycvar.YFH.7.76.2402291754020.13421@cbobk.fhfr.pm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2402291754020.13421@cbobk.fhfr.pm>

On Thu, Feb 29, 2024 at 06:11:40PM +0100, Jiri Kosina wrote:
>On Thu, 29 Feb 2024, Sasha Levin wrote:
>
>> >> It's pretty trivial to get root on most of the "enterprise" kernels
>> >
>> >Wow, that's a very strong statement you are making here, and I'd now
>> >really like to ask you to back that up with some real data.
>>
>> Is something like https://www.suse.com/security/cve/CVE-2023-52447.html
>> a good example?
>
>- this fix is on our list/queue to be integrated into one of our kernel
>  branches, and was even beore it just got CVE assigned, as it references
>  a commit in Fixes: that we have present in one of our branches, but
>  hasn't been processed yet, mainly because we don't allow unprivileged
>  BPF

This comment touches on two points raised in this thread:

Greg's point that instead of taking all the fixes, they end up in queues
waiting to be processed, which means that the trees en up being
vulnerable during that time.

Kees's point that exploitation is rarely a single issue coming in to
play, but is usually a long chain of different exploits coming together
to achieve a goal.

>- you pointed to a fix for UAF in BPF, which definitely is a good fix to
>  have, I don't even dispute that CVE is justified in this particular
>  case. What I haven't yet seen though how this connects to in my view
>  rather serious 'trivial to get root' statement

Yes, the patch reads like a fix for a UAF.

-- 
Thanks,
Sasha

