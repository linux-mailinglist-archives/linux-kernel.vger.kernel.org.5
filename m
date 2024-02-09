Return-Path: <linux-kernel+bounces-60059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4753F84FF54
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBD16B28E21
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D7E24A18;
	Fri,  9 Feb 2024 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcBCEuri"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B420DE8;
	Fri,  9 Feb 2024 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515986; cv=none; b=rW9W839hcxe/Qcf2kokBBSsJg67fdBQVfTPNoSY7WWS2lMhiQiG379JZWxBv+93YNil0wM+//3yvTzRRfkhgVXVJVVw3QvYm5jpk5nM/BeUFW1aSoa8iHMoSmm/EWRwrFnQY93M0Uc1b5+9Dujvwj55c8q6KIH0JcmFjdFY5NYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515986; c=relaxed/simple;
	bh=N+nalO7T63dk1WwyO167dEeC237jLd+fkrNm8eoIfRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWf7KDR8klQREDc9uyzba4Ut4O/6TpevQeDYqHC5hb3WY0EsbTD9PVgb2qZ3eKNuenZ7iR5syV0nSiDywvn6lW3pKxBoQq1fwpjXInw/nKPhblTbrfrUg05dJnD07QpKTzO+T/m80x+jZUVCoXIpeZMCLphXl8rwBgrxNwYvB5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcBCEuri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A3DC43390;
	Fri,  9 Feb 2024 21:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707515985;
	bh=N+nalO7T63dk1WwyO167dEeC237jLd+fkrNm8eoIfRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qcBCEurixvSanBDZzwL/H8t1HAlZhS40hckT9FvmrXI8rLg0aeNS/pHPXojJ6h2cP
	 DkHNV8JDpkLdHyD56aqjR8urUzxQEsH0Nh2dAciHBGEkN0dvT3UHFJgKOavQym4nRb
	 khtEgxNdLP2T5H5aVR833gVKMiP50GYc0VmSvZ5Halv9WJxUFNYt9ctfo67oRYworG
	 RYIDZx8HkznRW4XFBxFoZ745UaV3vgExTnxM/+coYSGX0eR8s+0C0BE0VQAOXa3fFb
	 cB4j+VZK6YH+xq5y6N7QkJY/XOa4KHh+0KFXf+q2K7C91Yz8kVIn2DTJbe4Dv+R9eH
	 ov2alAP0HkhHQ==
Date: Fri, 9 Feb 2024 13:59:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Ventura <david@davidv.dev>, Jonathan Corbet <corbet@lwn.net>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Xiongwei Song
 <xiongwei.song@windriver.com>, linux-doc@vger.kernel.org (open
 list:DOCUMENTATION), linux-kernel@vger.kernel.org (open list),
 netdev@vger.kernel.org (open list:NETWORKING [IPv4/IPv6])
Subject: Re: [PATCH v2 1/2] net: make driver settling time configurable
Message-ID: <20240209135944.265953be@kernel.org>
In-Reply-To: <20240208095358.251381-1-david@davidv.dev>
References: <20240208093722.246930-1-david@davidv.dev>
	<20240208095358.251381-1-david@davidv.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Feb 2024 10:52:29 +0100 David Ventura wrote:
> During IP auto configuration, some drivers apparently need to wait a
> certain length of time to settle; as this is not true for all drivers,
> make this length of time configurable.

Please CC folks who gave you feedback, Andrew's is missing.

Andrew, what do you think about just removing the wait?
Or decreasing it to 1ms?
It feels a little wasteful to be adding uAPI for something
which as you said is likely papering over ancient bugs. We'll 
fix the bugs which are still around and the uAPI will stay 
forever :(

