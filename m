Return-Path: <linux-kernel+bounces-118274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E7888B725
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C811C35302
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED00C4CB23;
	Tue, 26 Mar 2024 01:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMGh5IKl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6744E1A8;
	Tue, 26 Mar 2024 01:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711418209; cv=none; b=A3VCmLvAhUfpXPc0PvbRCMz9M8VSoNaMgARUMGXx8OUe8vYBRjVsZ8RmHsmppn5lHABfCokuXaOrNRLb2bzCUtZjADZZzdh8PDPxMTYJV/+KM71grON7y1mXRotbWETphEQNK+RGxXRkpKP91QfV5PUrauHU0GnQ/rJpkQTh0Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711418209; c=relaxed/simple;
	bh=lgp0ZYnoQLa2C4vtORXukYuZX/EsNsKnTcsgP/pcSlk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KNiP1zOhfXYGWXe4RtlWn9gRTX6QU2uHvufxu1OFsPPbN6nOWCb+F1Q5qErbB1bX0Uiw4WZYy/LmfDDwL7XTVP3JiDg6sNWqQpi57y4Jqid3/cfo53IeBBc9EnvHfmRJX7c9x3XnZu9nNZWg26QDR/7IMDYkwlT9t7aLBd9EHHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMGh5IKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52712C433F1;
	Tue, 26 Mar 2024 01:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711418208;
	bh=lgp0ZYnoQLa2C4vtORXukYuZX/EsNsKnTcsgP/pcSlk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sMGh5IKltb/la3sUkwTjVZYV+zf51F4xzgVmxOYLxYmCUQNTFPc6QDILoS+CBzWnR
	 6dPhHnL4lIOD3/MDPg+1cgF3EBvTM0B1OUd9RxAdXu6Rr+Sb4wHuKvN843Emr/k8b0
	 1bnwQVx66Z9WcsW+UEb7qPu8IfV/e+5pwaDDjZuv68X231PGXXHZnszMV3jn0Wl6Vz
	 4Y4oNsvjQ+vCijK2ErpDGCbF/QL/YBdd216qlZdfevlZb5n1SUQKOE0Zj5Em4EuDFl
	 6eJEv+Ow74rbbhcvFLqTXUKMSb3B0PcX2xEWWLsOwpJmHvjeeWNFYz8uG5a9mFnvU+
	 uVv1Z5md45nOw==
Date: Mon, 25 Mar 2024 18:56:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>, thomas.perrot@bootlin.com
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: macb: allow MTU change when the interface
 is up
Message-ID: <20240325185647.0ad674e9@kernel.org>
In-Reply-To: <20240325205401.GF403975@kernel.org>
References: <20240325152735.1708636-1-thomas.perrot@bootlin.com>
	<20240325205401.GF403975@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 20:54:01 +0000 Simon Horman wrote:
> I'm not sure that it is expected behaviour for an interface
> to reset like this when a change of MTU is requested.
> While conversely I think it is common (if not entirely desirable)
> to prohibit changing the MTU when an interface is up.
> What is the problem being addressed here?

Right..

> >  	dev->mtu = new_mtu;
> >  
> > +	if (reset)
> > +		macb_open(dev);

. imagine admin does this over SSH on a remote box and system 
is under memory pressure. Even ignoring the fact you're not checking
the return value, the result of changing MTU should be either having 
the requested MTU (success) or having the old MTU (failure).
Not "machine drops off the network" :(

