Return-Path: <linux-kernel+bounces-88536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E2E86E30A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430431C220D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF276F071;
	Fri,  1 Mar 2024 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Yn0vncsx"
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40306EB65;
	Fri,  1 Mar 2024 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302208; cv=none; b=AhEH3EAO66zZbA5mRlvMtqyKwAZ4v1Zojj160lbYr8rWWVMoMUnxisYYn46BGXIsieJ85OAMD0C/LCQ+ofZEzFpzvQk9n3zYcLyDElNWp+qNJPGyQ6onyBgB1ztVK1LOY/yMVqa7+osRr1h1AUKfIfIJp1YyqFHZYDgwp7a6nww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302208; c=relaxed/simple;
	bh=Yn8PAVQZDEahDI1C6nYRu+1FfTfzyoG3NcBHlImQJyE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WOlbCPXNOIq7t3S/M5TThkF5Yv4eAwTsjbhZyehYjaVXzJUF9L39wnr5hvspMKLzzhwJxZY8rZestHHuN/jkTjANU6PTZBTRp5bbDrYgzxJx40l77XRkjgq1MHC/sHOBXj1joEatfr3lQwXifvnPJJ/xIAN8J+9BlYLWGpSnArU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Yn0vncsx; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=cNKCv7n4aGUPwLauAKt9/n/pHUv3rMRFBlgrU2nAOu0=; b=Yn0vncsxVYYZlrt6tekcx9JowO
	D8kGNVctfs1NZQbNncdP/xdlGllhL+aO+f/+ghO+GHS7cL1OmfcIqFrHgR80cnubm+9NLsugfs5uo
	8qKX0s5kpY7R2w5X65HRAfPMEwy/9h5Q/XNPlR/B8k8VkruUNgY8FGEv+DLe+tGDm+fLgQ1xIr6JR
	BTyx1zm50pH4Ltw+792bUpE59l2/sTCT96tJTNeeCUaCk8vucSre6FjkM6+H0rNWVqPVtP5QuBgc7
	YaFOj+C2k3Txgm4S4pVE2l/GmzStmFB9I7ZKP2PPXXrVADA6F2DjmXICNpwAPm0jbWQbpLLnasmcd
	ARs4J9TA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rg3aE-000BB0-NS; Fri, 01 Mar 2024 15:09:54 +0100
Received: from [178.197.248.31] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rg3aE-000DLL-2o;
	Fri, 01 Mar 2024 15:09:54 +0100
Subject: Re: [PATCH net-next 2/2] net: nlmon: Simplify nlmon_get_stats64
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 dsahern@kernel.org
References: <20240301134215.1264416-1-leitao@debian.org>
 <20240301134215.1264416-2-leitao@debian.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b284da00-1eda-a352-8062-a2d81cdc24f2@iogearbox.net>
Date: Fri, 1 Mar 2024 15:09:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240301134215.1264416-2-leitao@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27201/Fri Mar  1 10:25:20 2024)

On 3/1/24 2:42 PM, Breno Leitao wrote:
> Do not set rtnl_link_stats64 fields to zero, since they are zeroed
> before ops->ndo_get_stats64 is called in core dev_get_stats() function.
> 
> Also, simplify the data collection by removing the temporary variable.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

