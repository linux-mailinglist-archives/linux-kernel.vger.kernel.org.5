Return-Path: <linux-kernel+bounces-13265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD8C82023D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 23:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4AE1C219E4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 22:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9119F14AAF;
	Fri, 29 Dec 2023 22:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOCJwh5o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC1314A9E;
	Fri, 29 Dec 2023 22:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19148C433C8;
	Fri, 29 Dec 2023 22:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703890321;
	bh=jA/D7U42zKQCqXGdQ5da1seauDiv5W9RuorKy8W1/so=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZOCJwh5o6HR+HCr+YuMGg+gS4qa45h71d12lE/zKoOAQN6ani7mwX25H+ngrUhRES
	 EEja2TCvKHhvrpECJ62Fr7eJhIvord+LB82dP9ECjr6aDl4uRWZuyIVo3GuCpXxc1X
	 tycmVD6oA3PMMfyRO6LJH4BZ71oybLoq59t432xjie7ZAIZcIZZ5Sc4StPAURDcp2l
	 E+aty5vedrFBoSHDEes8+YMeX/XTvjouXKTZAjL+s6NKqKx1n/mfjjlba1zApRUItp
	 xl1RMi/7YBvQOPYUw02tfudL9P1N5tRJH16YBwAOhmqMlTfA/Em943Gl+E3zpCOJzN
	 KPy1VXnztYhHg==
Message-ID: <d2f328c6-b5b4-46d0-b087-c70e2460d28a@kernel.org>
Date: Fri, 29 Dec 2023 15:52:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] net/ipv6/addrconf: Temporary addresses with short
 lifetimes generating when they shouldn't, causing applications to fail
Content-Language: en-US
To: Dan Moulding <dan@danm.net>, alexhenrie24@gmail.com
Cc: bagasdotme@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, regressions@lists.linux.dev
References: <CAMMLpeTCZDakqdkxm+jvQHxbRXhCYd4_PK+VVqMAmZHjSPuPRw@mail.gmail.com>
 <20231229163339.2716-1-dan@danm.net>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231229163339.2716-1-dan@danm.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/23 11:33 AM, Dan Moulding wrote:
> I think a maintainer will probably need to make a call here and decide
> how to proceed.
> 
>> TEMP_PREFERRED_LIFETIME is an administratively set variable: The user
>> can change it to whatever they want whenever they want, and the
>> operating system can adjust it automatically too.
> 
> Agreed. And the behavior it seems you really want is to prevent the
> user from administratively setting it to a value that is lower than
> REGEN_ADVANCE, so that it won't stop generating new temporary
> addresses altogether.
> 
> But preventing the user from configuring it to a value that is too low
> is different from generating new temporary addresses with preferred
> lifetimes that are greater than the currently configured value of
> TEMP_PREFERRED_LIFETIME. I still believe it would be better, and would
> be in conformance with the RFC, to simply not allow the user to
> configure a too-short TEMP_PREFERRED_LIFETIME instead of tinkering
> with the lifetimes of generated temporary addresses.
> 
>> It's fine to revert the commit for version 6.7 (after all, I think
>> everyone wants a break for the holidays). Hopefully by version 6.8 we
>> can agree on a way to support users who want to randomize their IPv6
>> address as frequently as the network allows.
> 
> FWIW, I think the desired effect you are seeking makes sense and is
> the right thing to do. I'm just not convinced this is the correct way
> to do it. But I'm not a maintainer and also not an expert in IPv6, so
> I'm definitely not the right person to make that call.
> 

Send a revert before 6.7 is released which will most likely be this
weekend.


