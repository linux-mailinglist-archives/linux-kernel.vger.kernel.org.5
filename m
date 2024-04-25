Return-Path: <linux-kernel+bounces-158777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECDD8B24C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98CBB1C21404
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E65714A087;
	Thu, 25 Apr 2024 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3AFF0CL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFFC14A4C7;
	Thu, 25 Apr 2024 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057932; cv=none; b=EG3+puDp73PJDV1u2HmxEW6BIrwkG2qXIzWJwZnKPvSbOwKzQPX3DCgQuO+jvjtuMcgkZbBdRIoYx0wWZTyavv5LG7/cYt26l57iUfILmUt7AvVJV+cRJapiYI68liy7PgO/j8Hwkg6WQufcaRp+8eVUBfrtGRp/Jp0xbSgobnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057932; c=relaxed/simple;
	bh=+4WZg7ltQ/nKn/3n5Lxfd0tgRyDFFG9Hsx//0IFMHU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9wODqj9cLpV3i0o6HMMMfsXVWBRqyElPW7jtoHUAk1/7WKns3CMY5jTLPwuVjR4D6fS7CN8zx4ry9ToUhjxkpVfcCUvtuqfNLXLi1wXVssSlLEvZBUs6/tHjMgWUYw6xZuMPS5KTEH/tKLHzxXeA6PaYAFliU+jmDhfYbxpdPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3AFF0CL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5639FC113CC;
	Thu, 25 Apr 2024 15:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714057932;
	bh=+4WZg7ltQ/nKn/3n5Lxfd0tgRyDFFG9Hsx//0IFMHU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k3AFF0CLVCw8mQoNaTeLZF9Nd5vtq7lpje4Opb91mzSxhit6PtH1N4kl+zPvAG8LT
	 q4yA5616eSCCSYaMZDifSQnb2R4OyBsJ/mBdreynpz+5E2Ax8ZYE3IM8he/jfN4Lwu
	 UxFmuGz03c79Pv9QoqAU/sBfhwqXEzHjHh9UvZ15A9JWpTH9a+DcEiZdLbup0PymfP
	 oEsv8qT0rqlv95sLs9gxjjz0VpH13/MDwI75T/d7gf7tFcscPHODd5xcEpozZpGpgw
	 FFeh6Wpx+RYYE6VOT9RJy7k+bkdAbeXOd6NHIO6c3ZrF+FKNf8WeC3FJlO4qAaa/iS
	 nLH3zSo1XTpXQ==
Date: Thu, 25 Apr 2024 08:12:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <xu.xin16@zte.com.cn>
Cc: <horms@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
 <rostedt@goodmis.org>, <mhiramat@kernel.org>, <dsahern@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <yang.yang29@zte.com.cn>, <he.peilin@zte.com.cn>,
 <liu.chun2@zte.com.cn>, <jiang.xuexin@zte.com.cn>,
 <zhang.yunkai@zte.com.cn>, <kerneljasonxing@gmail.com>,
 <fan.yu9@zte.com.cn>, <qiu.yutan@zte.com.cn>
Subject: Re: [PATCH net-next v6] net/ipv4: add tracepoint for icmp_send
Message-ID: <20240425081210.720a4cd9@kernel.org>
In-Reply-To: <20240423172339974p6mbS7jpKDyLRbzUZSpAn@zte.com.cn>
References: <20240423172339974p6mbS7jpKDyLRbzUZSpAn@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 17:23:39 +0800 (CST) xu.xin16@zte.com.cn wrote:
> +#include <trace/define_trace.h>
> \ No newline at end of file

Please fix.
-- 
pw-bot: cr

