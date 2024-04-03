Return-Path: <linux-kernel+bounces-128932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3138961FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3CBD1C235DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E42168A8;
	Wed,  3 Apr 2024 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jl3xGZLw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4943DD29B;
	Wed,  3 Apr 2024 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107814; cv=none; b=vDl0Y1KDURI+X07d04JmT6ZtrCJqJ2R4afKEjaTgWfIlcmjjch2NChHvg/BxMc83tH5lDEEWQ3jw98ZXGzY7uxoUIN75XRhtveXCsMiXgKoaDvmbvBVXpira+GpfFetJEl2LBuKiE+wwq0zuslGyfMpDOb4osS1QjyRAGBtYN1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107814; c=relaxed/simple;
	bh=+Scx8EcFtqXCkuZhNG7HB6hgS11bWyDfN85ejbuaZGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ilTQ+FJ3sD9rRbyFpgnpf3zHxMb9hyxmazvYK4BZ11BXtdGFxYz1sJsMNsE856AXGQifzQY0HGYiMFFNdPpWkz8Gj8G/n9BIsObh83SxrRpgdkxvKIegDD1nB4AKFreOWKs3IGjtYJoseA1jBZAZNGD7+6/9VgJsQqiQAsef6As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jl3xGZLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994A3C433C7;
	Wed,  3 Apr 2024 01:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712107814;
	bh=+Scx8EcFtqXCkuZhNG7HB6hgS11bWyDfN85ejbuaZGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jl3xGZLwHRdq3HJ4l18gIV5tMaEgAQLiN2uE4FtRW4ODespwlXylnOqPRC9BmW6Dk
	 ERcsEkkyXl64D2zPJjBH074Q9jerK0TABNGhZ5vzoI6x2c3UOeUCdUd1ILAFFNXqxo
	 eiKNHlVpIm6vN59/qSYRpI1IWvMUb/82uleiNUPJssaSYeBHTa1GAAFMN/ix8AjVo6
	 xrGwVcoqeuQI/Irn0IP/13nu/wVX0sS4D3klZHw0/lFczJM4MortEkG5w+uEydsxFc
	 hJdL8AWAx4kAUmR3wR1o0MWB7TeaQeHmgfjUX9/VI4sVKMqeOu1xABnDKMAPZodS2d
	 ukKgR3g/zS1bQ==
Date: Tue, 2 Apr 2024 18:30:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Dave Stevenson
 <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH net v3] net: usb: ax88179_178a: avoid the interface
 always configured as random address
Message-ID: <20240402183012.119f1511@kernel.org>
In-Reply-To: <20240401082004.7412-1-jtornosm@redhat.com>
References: <20240401082004.7412-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Apr 2024 10:19:50 +0200 Jose Ignacio Tornos Martinez wrote:
>  	if (is_valid_ether_addr(mac)) {
>  		eth_hw_addr_set(dev->net, mac);
> +		dev->net->addr_assign_type = NET_ADDR_PERM;

Are we 100% sure we won't read back the random address we wrote earlier?
Maybe let's put the assignment under if (!is_local_ether_addr(mac)),
just to be on the safe side?

