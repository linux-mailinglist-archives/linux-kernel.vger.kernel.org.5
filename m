Return-Path: <linux-kernel+bounces-89645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B2386F389
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 04:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5E71C21059
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 03:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DD86FBF;
	Sun,  3 Mar 2024 03:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1miZE4Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DD353A1;
	Sun,  3 Mar 2024 03:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709437518; cv=none; b=GKOfNa/1k9+iyyZAFVmtlQ2KA0XIdnQ0sZM7z6D6jTPwQZ0iHNmTg0k6LQMb5/BOpjafpPY0bzMvgeLyQk+HIovwOfNQOXmA2susYSUZ7pZogHtjYgyZvLS93m8IbyGrLjlWapqquCYa7ZvS23G0ZTpbCWVZVPXZ+t7GK+zcn+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709437518; c=relaxed/simple;
	bh=rts/lVDckMzzpLYjiDKtKTi125Xis6GAc708vPjYWuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OnZURV1fU6EbOADcqj9gAIwJ/GDWTKfYFIoZFMDX7azjx971jnjQIlUg4aZc+l5LWMvqxXBMrfSNxKH3wf/U/XkvqE4PWM8zk0yd2BY1v5P3b1lpe6ClFNQtGnkdbeMqyxhv/u+KIcCrR8YXabRSDF29mnINPltZt9oV2cTJA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1miZE4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F02C433F1;
	Sun,  3 Mar 2024 03:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709437518;
	bh=rts/lVDckMzzpLYjiDKtKTi125Xis6GAc708vPjYWuQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I1miZE4QpnNSwrXLz1oyX5HlH4GR4ahNIRwe//9ZlqtkbwIDfLd+oFR4OreLkOEgz
	 x7YSCuFT239GPKIiiDly/fEGiX25PjDKfPtB+t8nnO/+18xVg345ZJ7ExeflIguCIy
	 nWil3PlI4BLbJBSL6PUsEVxI+tWLfQHzGSboggdk4s7X5fJXziIQrcFl9eOyorbPDW
	 oVFI/sAkxlTVQNlYxbIFgYwm3kqk1WS7iNKi9SF1BbY/uekg0dZGAWnG6hGuil+507
	 +hvewSBcYvnW5H9NcW3wOA0Uulx5FrO06xs3+CIC/GaQPPoAUQ6JM2m7LgAVkJkhKz
	 OQdENwPXMTa9w==
Date: Sat, 2 Mar 2024 19:45:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: fuyuanli <fuyuanli@didiglobal.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net/nlmon: Cancel setting filelds of
 statistics to zero.
Message-ID: <20240302194516.09ed483b@kernel.org>
In-Reply-To: <20240302105224.GA7223@didi-ThinkCentre-M920t-N000>
References: <20240302105224.GA7223@didi-ThinkCentre-M920t-N000>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Mar 2024 18:52:24 +0800 fuyuanli wrote:
> Since filelds of rtnl_link_stats64 have been set to zero in previous
> dev_get_stats function, there is no need to set again in ndo_get_stats64
> function.

Please spellcheck the commit msg.
-- 
pw-bot: cr

