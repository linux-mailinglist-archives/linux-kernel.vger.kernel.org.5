Return-Path: <linux-kernel+bounces-52825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0279F849D17
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC5A1F2612C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4452C1A5;
	Mon,  5 Feb 2024 14:31:43 +0000 (UTC)
Received: from davidv.dev (mail.davidv.dev [78.46.233.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC092C693
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.233.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143502; cv=none; b=WyexcppPH51eR6ZH5YVSfzlKWlU36YwR525iLQNZdrDB1MQkCPL98KpnFiiHPAs4I2dWtsUUdMLCDchFE80h3IWZJYCbiRofpWEN2w5tcwaXoEqKGRdQGZFrASeqIm40HAHNnEVARFEgpANADkpN1Iq7fdXnldRGIm6dA3/lpR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143502; c=relaxed/simple;
	bh=GGTif6QrhiFR3v2KdIfHhHcqC9cZcUSFm6BvXU/Sy0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/MUW7w8BRfXu6k74fNimzcaTeUo1MymxSKtKPWG1lxNpa/A8jsqW9g1i+4ugwTMM2U0VtyUzml/3hp4rwBvI/4MllGDRRbxoFay/aM4OUq2/DB+KD78Gsgdbudsr8s5aVX8vRXyJ0wLAIsqn05xXzBixMmwvmNH7qgf2a2Blng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidv.dev; spf=pass smtp.mailfrom=davidv.dev; arc=none smtp.client-ip=78.46.233.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidv.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidv.dev
Received: from [192.168.2.153]
	by mail.davidv.dev (chasquid) with ESMTPSA
	tls TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.2, envelope from "david@davidv.dev")
	; Mon, 05 Feb 2024 15:31:39 +0100
Message-ID: <bfbad418-f8c6-4cdf-97b5-5c13044539e8@davidv.dev>
Date: Mon, 5 Feb 2024 15:31:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: make driver settling time configurable
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jonathan Corbet <corbet@lwn.net>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Xiongwei Song <xiongwei.song@windriver.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240205114609.440597-1-david@davidv.dev>
 <1e08910b-8ae2-4985-8423-45a1a823cefc@lunn.ch>
From: David <david@davidv.dev>
In-Reply-To: <1e08910b-8ae2-4985-8423-45a1a823cefc@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/5/24 15:06, Andrew Lunn wrote:
> On Mon, Feb 05, 2024 at 12:44:40PM +0100, David Ventura wrote:
>> During IP auto configuration, some drivers apparently need to wait a
>> certain length of time to settle; as this is not true for all drivers,
>> make this length of time configurable.
> Do you see this problem with multiple drivers, or just one in
> particular. To me this seems like a driver bug, and you are just
> papering over the cracks.
>
> 	Andrew
I don't know of any drivers that may need to wait -- I noticed
this code path being hit when building a minimal kernel that only
had a virtio network device.
At least for the virtio device, the wait is unnecessary and bloats
the time to boot a minimal kernel from 15ms to 33ms.

     David

