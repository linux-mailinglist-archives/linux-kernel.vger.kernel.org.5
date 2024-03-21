Return-Path: <linux-kernel+bounces-109626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 860CB881B96
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419ED283BE8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D336B674;
	Thu, 21 Mar 2024 03:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO0sjH0V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE26D39;
	Thu, 21 Mar 2024 03:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710992382; cv=none; b=U3OYtAYfOM107XsGUQeHlLUBiBgkGaSIGMg3+jKnaBXbO6CEFhq5Cz8+PDzzof2kQu4i5nuE9RkY1akdSR+l8rTA26YrMhq5vI3liFjAXTBEwAib1UDEvys/48sGhqbf+MkIT/hCbs7D9U10pFpS8CG+ThsVG6fSItCvCk9Vl0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710992382; c=relaxed/simple;
	bh=NgxJz8/GSPa4b2iJMDM324FgVNSenq+WPseRkTzNdB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqQaSneZkvgQFkMsZbHVZumiosHNf+1WMsIDXNnu9XZgs7Bynsba7jUMujmxqaUVnMALEYEvRfKy487vbwmLjDlEgA7BsViPRQnAChfSpIv7ZgdEBBjCdwht3QcAa/1+oAK5/iVjK4QBbcsXZvbO7ZVLa4H9g5CFUiSy+9mqLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WO0sjH0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CF7C433C7;
	Thu, 21 Mar 2024 03:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710992382;
	bh=NgxJz8/GSPa4b2iJMDM324FgVNSenq+WPseRkTzNdB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WO0sjH0Vx1fxUpvANddcEPbuwbR5R7WVdXvtLu7J4iz/mOoOWiC+YTwZuwFessUx4
	 PMJvmYtGnczzaTFdpvkxHDBxAwKVVZvBHhRF75zU6HRytv27TUFrnCqCXy7dcAGsDf
	 pNzE5k4bfBlJHk2U750GvZTwKOi1QR2YmU5m6XEb7wBjZE4MsEWaNC+pVQYQwjZWnA
	 vcpeFizWoXOYHQpBFVeyhFHHIV30/KpJ/r1cCzQlKT5PxFf2KQ1Ol7bscPk9vX6Omi
	 K6ifnJuMeqx0ICSc42T4L2tymHMIOFvi0t7iR/Pv94N9wqNh/JqdtPQMvpnqGxF/7+
	 lzhe549sbEefA==
Date: Wed, 20 Mar 2024 20:39:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: delay procfs initialization after the ipv6
 structs are ready
Message-ID: <20240320203941.70facba3@kernel.org>
In-Reply-To: <20240320171858.2671-1-nicolas.cavallari@green-communications.fr>
References: <20240320171858.2671-1-nicolas.cavallari@green-communications.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 18:17:36 +0100 Nicolas Cavallari wrote:
> procfs files are created before the structure they reference are
> initialized.  For example, if6_proc_init() creates procfs files that
> access structures initialized by addrconf_init().
> 
> If ipv6 is compiled as a module and a program manages to open an ipv6
> procfs file during the loading of the module, it can oops the kernel.
> 
> It appears that we were unlucky enough to reproduce this problem
> multiple times already, out of maybe 100 boots:

I haven't investigated too closely but looks like this breaks
all selftests. Please run all net/forwarding selftests before
posting v2?

