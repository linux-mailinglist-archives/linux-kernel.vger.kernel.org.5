Return-Path: <linux-kernel+bounces-164864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570B88B8426
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A6F283F9B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18C78C06;
	Wed,  1 May 2024 02:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJg1SnMW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B2463C7;
	Wed,  1 May 2024 02:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714529001; cv=none; b=PgtGd5MbuebZpNJ2kcA8yRa6oFG+NdiodmSKuXTF1uwKeSp47DuPlkhcJGTJAZiQM3LPNgwAXHx7+fD6Bwgxmk+jAc/2O2SrN4q6Ook6WSGPf/hecnWEq8eBBarBq4ydKBiRLFZM+LK7Tun9+ggojC4YjwosCTU0u9W3QH0EKpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714529001; c=relaxed/simple;
	bh=ZcMpz/Wv8CT3mvGrg/z6E1WF+I8cLy7mpj6GPX9bvDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfXoaxcinSrPWdkAFd2moe4z+D5H82Ex2BcwXYxMCsA+MKklGGLC5pzZ7VXHAP43QiEalGCKcrx7dBKG9mfRReJHAxaFFNp0ST3fdzpn7zE18zzSZb7pNYNP7DpjJDgLfszr4796SlznxG9eeXgoQPsb+FbhkoUz5z0XgrnGVKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJg1SnMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F9DC2BBFC;
	Wed,  1 May 2024 02:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714529000;
	bh=ZcMpz/Wv8CT3mvGrg/z6E1WF+I8cLy7mpj6GPX9bvDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FJg1SnMWFvXGH83pF5VqXLSHYYTM1REsS8WC6rtBJYbYf5DJG0gcpUQCehrFQdSPp
	 SK2q96NbHsaWv8mHbTby0SM4E018eltJ2zEUHQDHbytYFU22fY89UE6nTbXHRlec01
	 Gw+xeXftaIhvn31fjr4eADCEyUzj08azlCn842F4l6eIuSBVhMYt+d4Tvc5/WTTrS+
	 wHf8AVlmONb/M6FWNJT29ctz76j33UUmEicKtMoLqozu21PkUdHseI+GFTVGaaPnxU
	 Hf1FqakBFeiQbsIGroylFly57dgWXZxmqW5lqckLSHauQ++181ajspKfHA0sFdcydG
	 u3xGE73+f9x3A==
Date: Tue, 30 Apr 2024 19:03:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, leit@meta.com, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: loopback: Do not allocate tstats
 explicitly
Message-ID: <20240430190319.13296ace@kernel.org>
In-Reply-To: <Zi-k2cAjbSMdIDjs@hog>
References: <20240429085559.2841918-1-leitao@debian.org>
	<Zi-k2cAjbSMdIDjs@hog>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 15:47:05 +0200 Sabrina Dubroca wrote:
> (nit on the subject: you mention "tstats", but the code actually uses
> lstats. I guess that's not worth a v2)

Good catch, corrected when applying - 3b5933e99c32 ("net: loopback: Do
not allocate lstats explicitly") in net-next.
-- 
pw-bot: accept

