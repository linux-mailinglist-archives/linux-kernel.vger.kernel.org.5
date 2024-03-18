Return-Path: <linux-kernel+bounces-106133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CDA87E999
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27BF2817CB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E161A3839E;
	Mon, 18 Mar 2024 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWTkPGmy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2545931A76;
	Mon, 18 Mar 2024 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710766249; cv=none; b=Xcx+gWxyBlWrtfZJsi3qdmGd5BvvgA1WQIx5nZ7Ryr28RQscgW1zT1HvbLA8cnVWiVk52GenVtv01iiKceDklZBySsB9pWttMOyouIDvUS5V9nJtrtHQNtkH/rmWdZKYWMmpCMBYhwF7o2fy1JMJhKVpxHtczxJnEnyG2n9ZWFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710766249; c=relaxed/simple;
	bh=FfpEdy/3DfxIs0rtGzH0FTeKiUqpKUCFyzXPxPdRWd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWlcdgynXyK6PfnP0AoctqO2WJKF2FYcXgVNfBONjXxYRktWV8G5bH5o+XDhXeoduniOYhuJ8cdeKEQom79824/teouk8srkvpi1PCcK2f53rmd+i6bTZL0jEgSKJJDgM8xR+fsBkadG3o9fZ57XEDy/dZbcboJ+TQGu0LnZyEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWTkPGmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DD7C433F1;
	Mon, 18 Mar 2024 12:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710766248;
	bh=FfpEdy/3DfxIs0rtGzH0FTeKiUqpKUCFyzXPxPdRWd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWTkPGmy6BQ44hg0M96PgJXfYQwjAD9eR5uH3uUjIQ/uPz2JeIkfDbpUOi6AMV77A
	 GduQMpgQAA1sKSoO5FZCgyigsOni8QFKBbUF2BVXabYFQWR/WYUkcei3sHMMGhKPSS
	 2KULh1eX3ip5jvz5//eSLL2tC8/6dhz3eJP3pLUgYr6fWqed/wGWtRSe6T78RNL/px
	 9aRGeL/UnfQ3Whs6Gcf4pwZIaeDxLjpcBUjtmBHsR2TiccKl9DHw3c21z2L5i9B8Zr
	 uoyjw4CcwxrjvDfZYfcNoCPT2qlBF6di7zX5UU4FMsZ5qQysO+5J/3Gp2dLydR1X+p
	 jap3C0GEQUOJA==
Date: Mon, 18 Mar 2024 08:50:46 -0400
From: Sasha Levin <sashal@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	"David S . Miller" <davem@davemloft.net>, benve@cisco.com,
	satishkh@cisco.com, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 10/12] enic: Avoid false positive under
 FORTIFY_SOURCE
Message-ID: <Zfg4ppen73m7XCNf@sashalap>
References: <20240229204039.2861519-1-sashal@kernel.org>
 <20240229204039.2861519-10-sashal@kernel.org>
 <Ze9xpwnt/54DkIOM@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Ze9xpwnt/54DkIOM@duo.ucw.cz>

On Mon, Mar 11, 2024 at 10:03:35PM +0100, Pavel Machek wrote:
>Hi!
>
>> From: Kees Cook <keescook@chromium.org>
>>
>> [ Upstream commit 40b9385dd8e6a0515e1c9cd06a277483556b7286 ]
>>
>> FORTIFY_SOURCE has been ignoring 0-sized destinations while the kernel
>> code base has been converted to flexible arrays. In order to enforce
>> the 0-sized destinations (e.g. with __counted_by), the remaining 0-sized
>> destinations need to be handled. Unfortunately, struct vic_provinfo
>> resists full conversion, as it contains a flexible array of flexible
>> arrays, which is only possible with the 0-sized fake flexible array.
>>
>> Use unsafe_memcpy() to avoid future false positives under
>> CONFIG_FORTIFY_SOURCE.
>
>This prepares for future chagnes, but I don't believe we'll port them
>to stable.

Dropped, thanks.

-- 
Thanks,
Sasha

