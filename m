Return-Path: <linux-kernel+bounces-71949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C086F85ACED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DAD28986B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C537537E5;
	Mon, 19 Feb 2024 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4pBqOfs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9D1374DD;
	Mon, 19 Feb 2024 20:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373762; cv=none; b=GuWptwgmLoVvZMLHNltdN79mwpiw309ZG8LdcOn3/x7ne5KphFbzvjwvFD5TxyLjGhFudDUiOstlWVp2AlmdTJSkmnX6hRuYsrMpKGWFCBnMgzYa0u9tfuvi57gY0HEzUo3g0ves6Yb3alIH7CrsUkZkmWR5e9RbXpUJi1mXm6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373762; c=relaxed/simple;
	bh=VsTx0aE2ME+JtPusq/DUKNSQMeV9ej42eo9jPEH59N4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFyeos0s1WjzxdU+TZXAj60ylrPIJMGZhM1FG9O0EgvkxezC/Ks1CB0UBUuYc7HILnYKVwn4WqIMGdnJ9wMDEyvRBqzooMlA7DETFAz5agNUsuXYBMDyjsT6RA0RkfCTTpGDr8d3LB7c6rb3oxQDAylFho2wCzULdulekp6JMyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4pBqOfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CB8C433F1;
	Mon, 19 Feb 2024 20:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708373762;
	bh=VsTx0aE2ME+JtPusq/DUKNSQMeV9ej42eo9jPEH59N4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T4pBqOfsWnvkFGYilzvk1ALxJ/s+7tEa/dupinkCL1cWtD+KzKwp/LgRo7Low5qBW
	 WxWZqpJkhzXlGgB7GmVNq+nDeagb0RJjS9u02ErzHMUhdAaxL/iAmS7RL/40pQ7rTb
	 Y2sU520ng3CiG1hx4c4fQcboSJ9FnRtBKNBuIkQjibpoh2JbQ/VorDzy7+3VnnPxEy
	 h0BI6+G7DwEzionlPgTb7xwuS0Gs0GcG5I4kNfJeHeLZHG4vVVnKFVl2iqmNJwvf9C
	 h/8Z8JD9qZX3SwlKUy/h1y3TOuuO3MaHcT0B4UiA5JsBdOzN8KMnVH9uTQz5yJPR0+
	 ojkw8ix8CdnKw==
Date: Mon, 19 Feb 2024 12:16:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Breno Leitao <leitao@debian.org>, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org, Johannes Berg
 <johannes.berg@intel.com>
Subject: Re: [PATCH net-next v2] net: sysfs: Do not create sysfs for non BQL
 device
Message-ID: <20240219121600.03db3457@kernel.org>
In-Reply-To: <20240216092905.4e2d3c7c@hermes.local>
References: <20240216094154.3263843-1-leitao@debian.org>
	<20240216092905.4e2d3c7c@hermes.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 09:29:05 -0800 Stephen Hemminger wrote:
> Various compilers will warn about missing parens in that expression.
> It is valid but mixing & and || can be bug trap.

$ git grep ' & [A-Z0-9_]* ||' | wc -l
855

Let's not sprinkle parenthesis in correct code because some old
compiler somewhere may doubt our ability to remember the precedence 
of 14 operators.

