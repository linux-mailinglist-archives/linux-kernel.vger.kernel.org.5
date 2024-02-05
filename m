Return-Path: <linux-kernel+bounces-52799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0515A849CC4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A3128789B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE952C688;
	Mon,  5 Feb 2024 14:15:23 +0000 (UTC)
Received: from davidv.dev (mail.davidv.dev [78.46.233.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA992C1A0
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.233.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142523; cv=none; b=s2l7aGBmB2uOP6Os+7osHZdDJkl2US3AraN4AW5DYWZj6aSykAZLNnQeR6bAxAVpJ4d2JQJmM9okAH+l7VS0rtUNepclNS7PmVoKjXqxtYSiC43EUHIqvNrbM6SfjVvJeuKXTp9LA7L8uomaU3ZxJ44gbKF1Rbld9SntV/kVZYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142523; c=relaxed/simple;
	bh=1sx6S6RZmWWktS32CzO/twbFEx823PgRG5frnIJerJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyLFF1adTWf1EoAFBUKADwWKMJN/WUZ5yfmHJHCxXgu64PMjph+YQit4OQDzv69VmQ26DWYj6oExe5lcw5G2nSqthFlkQYH88GT1gc6+SeaaDL3EgRXttZdWLLcikEhpSsCm0kv+Wsg6CWECiecyxkHVVRlE58F9nJCYvSS801U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidv.dev; spf=pass smtp.mailfrom=davidv.dev; arc=none smtp.client-ip=78.46.233.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidv.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidv.dev
Received: from [192.168.2.153]
	by mail.davidv.dev (chasquid) with ESMTPSA
	tls TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.2, envelope from "david@davidv.dev")
	; Mon, 05 Feb 2024 15:15:19 +0100
Message-ID: <0789be46-b8d1-4ca6-801f-dfe95b1032d3@davidv.dev>
Date: Mon, 5 Feb 2024 15:15:18 +0100
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
Content-Transfer-Encoding: 7bit

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

I haven't seen any problems -- I assumed that some drivers need to wait, 
given


