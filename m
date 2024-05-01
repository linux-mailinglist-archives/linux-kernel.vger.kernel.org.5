Return-Path: <linux-kernel+bounces-164861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6548B8415
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6C328263C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169FF79FD;
	Wed,  1 May 2024 01:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9npMldq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511483D71;
	Wed,  1 May 2024 01:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714528506; cv=none; b=Om0sasFvieHE75t1FgCz5wp4RR2hWZbd8cjqioK45Cm+3JUf043RumaKFblMY5cBQJ93hzgQdPKi9oldogQ+mdUr6OVuMRIXACx5WJAdz8/soAjjfrXkUHf2jpjtOCknAXvxq5A6y/ofBs0ldglXpjGEHAOh5gr7S2UZVNfWqJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714528506; c=relaxed/simple;
	bh=gXphdExXNMePnkalOlgA0cuTep/eYDBMFevA9jJIp0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtV4Yrul3N6K9rQf4dG4AMX+Qd8mX4EIpUjJDIATUCSTQCXtHqPkgBAsjJLQfIG68bvApUgSABfMfrnvhigYocQpvD2hfXdjpMDMvi1ipVlRPFMpMRxI1PNLi15FJgQ4Y24wJdTkiyAv3AMQ78YFRz/XYgVPwVNRvwkG1JCkupU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9npMldq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21F6C2BBFC;
	Wed,  1 May 2024 01:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714528505;
	bh=gXphdExXNMePnkalOlgA0cuTep/eYDBMFevA9jJIp0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h9npMldqn+1OkYqC7OX4dH6o70lP5n1RwxmsOJ3orG2fAQSEVSjbvmBVXcKqLw4cg
	 1OziBi2V4t3OcmpDTAKhw9qwAewr/nkdyVWkFlO6+RTRP+qmZFgGVCL8epZhql9l2R
	 u/7lp3kAnwoEkNab6snJX3ZwwYr5bAOiYmxSpK6134wBclh3gWYgnDAZRA1l1uZPtP
	 lQqdfNF+yfQQWeagE+M/TdQhCHdCCxBrZFi2lyiNyEJgur30fWOVTKBfAwkJDTAWMX
	 JQJy6FhdQ5KvKuSaIo7fIgVmQzbanu2XVA42DDtlMcaBKE6KeBDObuLjX1wsrL2BB1
	 gvGA0IpoyWxNg==
Date: Tue, 30 Apr 2024 18:55:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <xu.xin16@zte.com.cn>
Cc: <edumazet@google.com>, <horms@kernel.org>, <davem@davemloft.net>,
 <rostedt@goodmis.org>, <mhiramat@kernel.org>, <dsahern@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <yang.yang29@zte.com.cn>, <he.peilin@zte.com.cn>,
 <liu.chun2@zte.com.cn>, <jiang.xuexin@zte.com.cn>,
 <zhang.yunkai@zte.com.cn>, <kerneljasonxing@gmail.com>,
 <fan.yu9@zte.com.cn>, <qiu.yutan@zte.com.cn>, <ran.xiaokai@zte.com.cn>,
 <zhang.run@zte.com.cn>, <wang.haoyi@zte.com.cn>, <si.hao@zte.com.cn>
Subject: Re: [PATCH net-next v8] net/ipv4: add tracepoint for icmp_send
Message-ID: <20240430185503.57e2f9aa@kernel.org>
In-Reply-To: <20240429171557482x0zswaWhCLkpHecR3bZqb@zte.com.cn>
References: <20240429171557482x0zswaWhCLkpHecR3bZqb@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 17:15:57 +0800 (CST) xu.xin16@zte.com.cn wrote:
> Introduce a tracepoint for icmp_send, which can help users to get more
> detail information conveniently when icmp abnormal events happen.

Rebase please, it doesn't apply. And please put the change log under
the --- delimiter.
-- 
pw-bot: cr

