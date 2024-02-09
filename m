Return-Path: <linux-kernel+bounces-60102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9214784FFDD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345AE1F23485
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A0D3610A;
	Fri,  9 Feb 2024 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xs//XXqW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3666F538A;
	Fri,  9 Feb 2024 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517637; cv=none; b=WkL6xPU5U6TBo5RWoGC+DEIfsMg2TIl9sxLjEMW/PiGZLjFJauleeYeL4ULKc2vi+5filP7kA+AcfbCE1eVjaGG2NsPd0fHGb70e5w+yp7SOmgL4KIi1PAn5E3ePXq8ts5sV28OTxhZhJZVgsZTqQvlxUkE/bKvA2I1qjL78cI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517637; c=relaxed/simple;
	bh=XKSPUWEMjH3vv5ObtYK5tHZ32yK2oms1MOCSVnvaXBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dv1tPQLLpE9Y8fqnVmsqFlNE/MPTpL4j9ViBWPGUMW9gqGrvNTNbQuTNdHi/+UJ4SKWVNywkf51oB+G2svP01Blk/9y6InapYvBXIk/aSa0JFiIH8ij6pg8SunORiYBDaHVvaZ2RD6sXLtKw5e68iFdRoM4ne7+gc4OiKcYsaH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xs//XXqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1577CC433C7;
	Fri,  9 Feb 2024 22:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707517636;
	bh=XKSPUWEMjH3vv5ObtYK5tHZ32yK2oms1MOCSVnvaXBk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xs//XXqWfXd1kOPFVH0FAG5j+y5njvDIJz/H/GBAwlwZc2hBhOAJcA95LBuxunAwE
	 K2PBBKcYjUfe262dL4Qps1duHltv4w6crA+CWukamxxWojctSm1fqMyBhv4ktaUQLg
	 MDnpjxpz5Ey6lp/Rl4Ei2dg8OiRT9ug0aZjWLjWFcXRnf15uA0NGKQipRuuRjoBP/7
	 U/F9hUgebbFLLs9WLeR3hTAWSViivY8qdxJMQPpJZRijl1LpPBUq89lhtmWJxx0kqp
	 IciWXsI4CytcnhUaDRZJFLZNS+Pu+ItTBU2Ki309lsUzncfj56iTsE6xsTjRlZ9ED5
	 ax7w9CV8aXioA==
Message-ID: <06b1be40-06be-4bea-b79c-ec869dd60a2c@kernel.org>
Date: Fri, 9 Feb 2024 15:27:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net] ipv4: Fix broken PMTUD when using L4 multipath hash
Content-Language: en-US
To: Suresh Bhogavilli <sbhogavilli@fastly.com>,
 "Nabil S. Alramli" <nalramli@fastly.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jdamato@fastly.com, srao@fastly.com, dev@nalramli.com
References: <20231012005721.2742-2-nalramli@fastly.com>
 <20231012234025.4025-1-nalramli@fastly.com>
 <e18c52e8-116e-f258-7f2c-030a80e88343@kernel.org>
 <4be64c29-f495-4fdb-a565-2540745d5412@fastly.com>
 <9d636726-514b-417f-ab46-6f570a563eed@fastly.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <9d636726-514b-417f-ab46-6f570a563eed@fastly.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/9/24 10:11 AM, Suresh Bhogavilli wrote:
> 
> Does that answer your question? Do you need me to make any changes to
> get your Reviewed-by?


re-send the patch enhancing the commit message with what happens for
different policies.

Would be good to get a unit test added to
tools/testing/selftests/net/pmtu.sh (ipv4 and ipv6)


