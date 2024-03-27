Return-Path: <linux-kernel+bounces-121619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CFB88EAF0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DFE6281496
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EE9130A50;
	Wed, 27 Mar 2024 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwYmau2c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD4C4F890;
	Wed, 27 Mar 2024 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556230; cv=none; b=USqcwfCEHDt1uLM3AwznLeAob0nrPOPCNBLzUOuEmS6pDwThpJJOiDgUK08nwmvsTdLBDy1jRMfEg7Ec83+YnEdccia5YzogWe/vwtKeSjH0rLzGyzERvPidKhrTDkl2/fpjSRTfJx0QEpLMLfpO+uV8ntgZUVookLIIGAjRldk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556230; c=relaxed/simple;
	bh=f61So1Ws0SkXaOlt+8mMWwfTLUxvYSQ7nKISq+0qW/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/MZybNy9vzsXX3OcCPCJRUu0Lppu3sBPmVGLphmaA989Jh+3O50izCPmXubfvZLJhCzZMDKT0fAcDx9Og54DJZa2CfXWsBZRTgkH53patp8T8a1kiNRZwe65Kuus7gMG5Qn7p3ioufO4R0fkR7ikWNM8Nd5AraZzuYQv5btJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwYmau2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B22C433C7;
	Wed, 27 Mar 2024 16:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711556229;
	bh=f61So1Ws0SkXaOlt+8mMWwfTLUxvYSQ7nKISq+0qW/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BwYmau2cQyr+8vTxiCxY9LvjzuGCkA/QJKuycvxKZt0fc1iTkZiFx/wTI86Ci8ZZ/
	 rU3wcvTLPgZklkueylDcFpGULYZ+6yg7PKMZSDTAKgMF/cOUe79kf0jVTZY5ljN0Ua
	 f8pJ/EfUFN2sRyre4dfbeGOr4RjhTLDPKqHK6xoDLGn6vMKcdQquFjkBmvyi5A8jtK
	 UlAW0nANLW6z/eMsESsMEhQy3X9MEcOJ0uxsexTe+6cDC227KsX0uk/KTeG31dLCR+
	 5Cqeke57J2SD4BQnLa+Lo3p0rARIpKgRpCzDC/rtQWDcf9QvXo6Sz56XeKcvLl798s
	 jCb/01fXIEwmw==
Date: Wed, 27 Mar 2024 09:17:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Breno Leitao <leitao@debian.org>, Kalle Valo <kvalo@kernel.org>, Jeff
 Johnson <jjohnson@kernel.org>, <keescook@chromium.org>, "open
 list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>, "open
 list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER" <ath10k@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ath10k: allocate dummy net_device dynamically
Message-ID: <20240327091708.553f2251@kernel.org>
In-Reply-To: <00b1703a-47d7-4dc1-a3cd-f07f1a24db92@quicinc.com>
References: <20240319104754.2535294-1-leitao@debian.org>
	<9fcdb857-da62-4832-ae11-043fe993e4ad@quicinc.com>
	<20240321072821.59f56757@kernel.org>
	<5039256c-03eb-4cda-8d11-49e4561cf1ef@quicinc.com>
	<20240321151744.246ce2d0@kernel.org>
	<Zf2ceu2O47lLbKU3@gmail.com>
	<20240322082336.49f110cc@kernel.org>
	<ZgQvTTnMoBn2oG1K@gmail.com>
	<20240327074516.624b7ecf@kernel.org>
	<00b1703a-47d7-4dc1-a3cd-f07f1a24db92@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 08:42:55 -0700 Jeff Johnson wrote:
> On 3/27/2024 7:45 AM, Jakub Kicinski wrote:
> > On Wed, 27 Mar 2024 07:38:05 -0700 Breno Leitao wrote:  
> >>   -void init_dummy_netdev(struct net_device *dev)
> >>   +void init_dummy_netdev_core(struct net_device *dev)  
> > 
> > Can init_dummy_netdev_core() be a static function (and no export)?
> > alloc_netdev_dummy() is probably going to be the only user.
> > 
> > I'd also lean towards squashing the two commits into one.  
> 
> And once all of the conversions are complete, won't init_dummy_netdev() no
> longer be used and can be removed?

That's right, it should be removed. But it may take another release
cycle until we can do that, depending on how quickly the patches
propagate :(

