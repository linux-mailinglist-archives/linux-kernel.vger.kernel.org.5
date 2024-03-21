Return-Path: <linux-kernel+bounces-109628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E487881B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403741C216B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419E2BA28;
	Thu, 21 Mar 2024 03:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWY6btUx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DFC6FC5;
	Thu, 21 Mar 2024 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710992666; cv=none; b=RXnY+nY+j0Vlz+e0v8KJVWJ+J7ZGzgCJoUbT0Djw5zI24KptMeUAIToDYTU3Dp1pbNBeFxI3AHwlAy1rVFYlXr7AweZi2Um5sI017n+Wqj+U2rtJWK8iRdAPAw6GE9Jx4xl007mYl+yGLTTQEcrup2O1tW3fq3PGoJo/i6Bx7vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710992666; c=relaxed/simple;
	bh=+l6G01eCUl5Gixax34NKHd4Ib4Zzzbyh1A0DAfjMr/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ItXXYMW9j6SqIQd7UbCO90WPmR/GbFzBO9mV2vttKlvhbfgizw8CUOVR+7yqaPGVECHshjqk0i9cSB3Z7PNbix1QgKgKI7Wv7arcCCN7y2fy984kPKV9XtPsJJ+W3PUnZiw1p7C0Wa70FXfTb835vGSfEt3coxWaT69bGURB3uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWY6btUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7796DC433C7;
	Thu, 21 Mar 2024 03:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710992665;
	bh=+l6G01eCUl5Gixax34NKHd4Ib4Zzzbyh1A0DAfjMr/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jWY6btUxJH6gi6gBIF3xu62qAwvuRi6n1aBwzEN5pAQ2zH5mGOjZm60e51J6VDzTy
	 P8FHmG7bfUmzig9uL2BICMtgdFjqZtv9ap/N3wVjMg95LJ8YvrI9Hp0qeemyFiqQIW
	 8AZyGYfD/MMmJxCUZSKK3p0ABWnPCETbwMVaQlgMkELJr/4Ezmp5KcY8lCOI9Juax3
	 90KC50omagrdLUs2g9PUL19ATYpTY+cm90Hdf9GzgUZr44yD+31e0crCp1XajeNdqE
	 cB/jMFe1qLT1Tp4l/QZ08ckCPTcCAs8VMQ3eGilXkWc3KK3h9J7FgVo6n2Hv0QElQR
	 qFhSRKy36eVQg==
Date: Wed, 20 Mar 2024 20:44:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <xu.xin16@zte.com.cn>
Cc: <edumazet@google.com>, <davem@davemloft.net>, <rostedt@goodmis.org>,
 <mhiramat@kernel.org>, <dsahern@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <yang.yang29@zte.com.cn>, <he.peilin@zte.com.cn>,
 <liu.chun2@zte.com.cn>, <jiang.xuexin@zte.com.cn>,
 <zhang.yunkai@zte.com.cn>
Subject: Re: [PATCH v3 resend] net/ipv4: add tracepoint for icmp_send
Message-ID: <20240320204423.270570c2@kernel.org>
In-Reply-To: <202403211109183894466@zte.com.cn>
References: <202403211109183894466@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 11:09:18 +0800 (CST) xu.xin16@zte.com.cn wrote:
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> \ No newline at end of file

In addition to Jason's comments please make sure there is a new line at
the end of the file.

And please post v4 on Monday, net-next is currently closed.

While you wait have a read of:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

:)

