Return-Path: <linux-kernel+bounces-51642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D096848DD6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79281F21EA4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F17224CC;
	Sun,  4 Feb 2024 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GzASrPZK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904DC22324;
	Sun,  4 Feb 2024 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707050970; cv=none; b=sSEcXLoK/eJakhqFBzjsJTcgTgQSf0OwNFLOm/AFMp1bbTiA4GfV7ljg4xBUCno7Y+s6sFlMI7ZyvsXWiDUXr77f+HPq8qNMvrj2swM9KX6I1MQXcc4RPp9XkBbP/d5q1ou3xyZUnt2+PnccY1m442lPQV5ttDsJuLBM1NV1FWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707050970; c=relaxed/simple;
	bh=gUZBPH+Qg38es2p3VpEwSE2fsHOlCA6vxiqsLf++OPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaAOlhEY+F216Y1RR6+VEn4xkSCHg+5Vgd/be7lXX3RoAq2Lp+Yk3hqSu3XvlsoyHbDBBqSKB4LLQa/RDo7wJxETJxdiJ/dap7Ns04nCcAq9SkS/q1Y09YrE5xVzJXZmDINemlfNzohl4gPqQR9lqY46VQ8GhV+bhD/dt/xCuIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GzASrPZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01F8C433C7;
	Sun,  4 Feb 2024 12:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707050970;
	bh=gUZBPH+Qg38es2p3VpEwSE2fsHOlCA6vxiqsLf++OPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GzASrPZKR7IqMu37ITeam/SecpAP05q3ffbf/Yq+Pu1+oNXErX35EnR6lJzOSB5K/
	 POZ7E1IN/ewdrEOeaMSKAYZyGJ2/7JUxneJvYj8375rFpqxKDsEkszl1uqqYMK8Hvr
	 qYddI5mdocDGdx1rNjoVchJLaltRyLjVFTphYs1I=
Date: Sun, 4 Feb 2024 04:49:28 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?0KHRgtCw0YEg0J3QuNGH0LjQv9C+0YDQvtCy0LjRhw==?= <stasn77@gmail.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6 000/326] 6.6.16-rc2 review
Message-ID: <2024020410-bungee-number-f643@gregkh>
References: <CAH37n11s_8qjBaDrao3PKct4FriCWNXHWBBHe-ddMYHSw4wK0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH37n11s_8qjBaDrao3PKct4FriCWNXHWBBHe-ddMYHSw4wK0Q@mail.gmail.com>

On Sun, Feb 04, 2024 at 07:43:24AM +0300, Стас Ничипорович wrote:
> After trying again to create the ipset with timeout option I get a kernel panic
> # ipset create throttled-ips hash:ip family inet hashsize 1024 maxelem
> 100000 timeout 600 bucketsize 12 initval 0x22b96e3a
> ipset v7.20: Set cannot be created: set with the same name already exists

Odd, is this also an issue in Linus's tree, or only this one branch?

thanks,

greg k-h

