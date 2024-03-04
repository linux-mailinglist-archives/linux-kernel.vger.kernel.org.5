Return-Path: <linux-kernel+bounces-90814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B058587055F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A0E1C21962
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9854247A79;
	Mon,  4 Mar 2024 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OX2NwF11"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EDC4653A;
	Mon,  4 Mar 2024 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565891; cv=none; b=JNjEabveeNaHe4xMfnxjFgiphnAy7mTpp9Sp8Nt7sSARDJZ8pDXZHLcGfZA0VkO6OueMKyXkGc2iZhJFejZI492pLcddvPrUlKAJ7bzfZtFL+SSraTusiPS9p53GFjoE5t5Hr2dYn3XBRa38jcHSrL2lvxZwOifLz6M+8tRoVbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565891; c=relaxed/simple;
	bh=N1JfdXgyaxSd4c/fdLzv44gAp2pZlsV4ZCg6XBxQnKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0NY+yyJcwm1yxZzENcJeleVJVy/b1WxcqSrZOtYRiNAXzrhRvQNUnpPzbcjB9FKIO0KzXDLii/qx7atW97kSVDuei6kZJQTrGQGjG7eGPX2Ep4Ts4tneO790M8/kSOvkv8BSNeLqBUPtZJ0TteKOfgBfOeJd+yj/ZiZb9maTNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OX2NwF11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCCCC433C7;
	Mon,  4 Mar 2024 15:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709565891;
	bh=N1JfdXgyaxSd4c/fdLzv44gAp2pZlsV4ZCg6XBxQnKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OX2NwF114dP1vGv3xCFxgAvAJK2k/1x1RApKZFIsPAByq9z7xAhDsd29VNt9XzVIO
	 4TbehB+V6LbEjw0Yf2tx0BDzE7pRMOej4x/4DB1ewe064WyFjF4xhUD6FDyF1v16LN
	 rZ87eYQKNvFBQtWhLGmK+EzcJmE8VBZNCPsJEuw98y231hfBEZEdfkbyyI888kng2c
	 B8SDOa8cDBSoIzP3MeNFTYzukgVel6/G9UFjpCOrq7WyL5Jw96IsoGqUEIfCGYu1LG
	 daoe8ukCR3vsixhy66NkAUk1JmJgjG4P7GMYJl2ZELgkhmqmNRo1tGrx9i2iri7Gx0
	 dwlQt5hEJoSLw==
Date: Mon, 4 Mar 2024 07:24:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Eric Dumazet <edumazet@google.com>, Kees Cook <keescook@chromium.org>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, <netdev@vger.kernel.org>,
 <linux-hardening@vger.kernel.org>, Simon Horman <horms@kernel.org>, "Jiri
 Pirko" <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, Coco Li
 <lixiaoyan@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netdev: Use flexible array for trailing private bytes
Message-ID: <20240304072449.0c10b397@kernel.org>
In-Reply-To: <ae6b1114-1c71-46f0-82e5-23b9f05df1bf@intel.com>
References: <20240229213018.work.556-kees@kernel.org>
	<20240229225910.79e224cf@kernel.org>
	<CANn89iKeJGvhY0K=kLhhR39NVbaizP2UBk0Vk0r_XCe2XMBZHg@mail.gmail.com>
	<9050bdec-b34a-4133-8ba5-021dfd4b1c75@intel.com>
	<CANn89iLSLPn5PyXNQcA2HO0e5jGYvHKhTh_9_EMmfbTJKZPfbg@mail.gmail.com>
	<77d3f074-8cb6-466b-ab31-a7b0bac659d0@intel.com>
	<20240301093517.428e5b5d@kernel.org>
	<ae6b1114-1c71-46f0-82e5-23b9f05df1bf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 15:32:51 +0100 Alexander Lobakin wrote:
> > 100% I should have linked to the thread that led to Kees's work.
> > Adding directly to net_device would be way better but there's
> > a handful of drivers which embed the struct.  
> 
> I think it's okay to embed a struct with flex array at the end as long
> as it's not used? Or the compiler will say that the flex array is not at
> the end of the structure?

Technically, yes. Practically it ties the lifetime of a refcounted
object to something semi-related with different lifetime rules :(

