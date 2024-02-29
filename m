Return-Path: <linux-kernel+bounces-87056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E69C86CEC0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB141C225B2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21C214BD57;
	Thu, 29 Feb 2024 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbFHJlAs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148A413F43D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222953; cv=none; b=Ahx8Nj5GaE1p+lucK1SAOx4IAApzSmYe+vu9PzF7haU34dbO0Lyben+VjfQCNcmoC8R/TjDpYmDGuEz/NHKPElKk5p8Fzhl++FQhz8bUAyJ8ceS8wJc5lXgeJM1Y8hkyh5nWp9M17wylWpNyxm7dSKXa3VbI6yPBhYN8CXFEolc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222953; c=relaxed/simple;
	bh=B46J4uzHUgJuznz2HROPAX865HM+JUojwgXeecuRwQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBkgLu7xKKOIOJXN857C+q5bOUyQPMxRXdS8VJJPLnu/ix40JhGNyC+CM8Pbuf4gSV0K9Vg1TPXbuj4DIkMPIwPBk78M9AAH380XwHw//DzMcAleUzQzcadeqUqxQCOR2JKwpDK3l6U53X5lRG6HnE0CR1lmmVGngspuEbj1qY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbFHJlAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E1EC433C7;
	Thu, 29 Feb 2024 16:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709222952;
	bh=B46J4uzHUgJuznz2HROPAX865HM+JUojwgXeecuRwQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pbFHJlAsZiqoeITfPabS31eKuzprLlvAKL81KrIstk0L9MPBkVlG50jgTB12pL1m4
	 IvhtSohR8x7shZxtr7ipMlz1GElIwd7CU8ZghsIPXUZ+JEzk3klVImTGCc4yF1DXud
	 AXHmOQfv7Rh6gM/C8yhGWg7WMU2y6jkwXvwO+FtB8v6BFo/Z0c5kTaCr7mEdPylG+s
	 /HKKYM+3DFGr4sIvDJ5wQOi7xj63Hq/8jEaEg16BIHdc68nAmDDHYzJrnKMp+1VakQ
	 UzrXvK/MT7h9K2tXMa+ttYiKdV40XGH4svQAasO7dwpQyYZhnOJw9W7/JR7P4Twmg7
	 3QgC2gbQpOAzA==
Date: Thu, 29 Feb 2024 11:09:12 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>,
	cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
Message-ID: <ZeCsKGwU96sKi_S_@sashalap>
References: <2024022639-wronged-grafted-6777@gregkh>
 <ZdytVTOgfvKBBvtn@tiehlicka>
 <202402271029.FD67395@keescook>
 <Zd8hPpP_6q_o8uQW@tiehlicka>
 <202402280906.D6D5590DB@keescook>
 <ZeA-281OudkWBhd_@tiehlicka>
 <2024022915-dissuade-grandson-ebd4@gregkh>
 <ZeBRZqJd5HAKaOfC@tiehlicka>
 <2024022913-borrower-resource-ecc9@gregkh>
 <nycvar.YFH.7.76.2402291605370.4159@cbobk.fhfr.pm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2402291605370.4159@cbobk.fhfr.pm>

On Thu, Feb 29, 2024 at 04:09:24PM +0100, Jiri Kosina wrote:
>On Thu, 29 Feb 2024, Greg Kroah-Hartman wrote:
>
>> It's pretty trivial to get root on most of the "enterprise" kernels
>
>Wow, that's a very strong statement you are making here, and I'd now
>really like to ask you to back that up with some real data.

Is something like https://www.suse.com/security/cve/CVE-2023-52447.html
a good example?

-- 
Thanks,
Sasha

