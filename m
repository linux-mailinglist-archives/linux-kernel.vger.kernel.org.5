Return-Path: <linux-kernel+bounces-109631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FF1881BA2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A257A281F79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F13FBA4B;
	Thu, 21 Mar 2024 03:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trvVzPXI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF1AB651;
	Thu, 21 Mar 2024 03:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710992764; cv=none; b=WH3zhjPnKGheVUUnR1OsWHMNg1ddMhoJ3S3KL8HMUfXO+O05gLzZzwsRilvv+ATk8YdQDX9TAtx0fz2T8H3lghJbQHnKrgJw6LG00WJkOVFI8DFvjI5Qq+e4QgGEyaDOQVjXWknwYgNIjm4gBTx7bieCex/lfdqfCWSPvSN3gyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710992764; c=relaxed/simple;
	bh=bwid3uwKWHuUNT9wA19C7cl1ryQUBQSJA1FQcFOtxnE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iagPZ9m/91lDIhh35GaDjSGDZeOoDz1izSfivIGxweOubZMEK/sN7VM+gLyMsZn1glQy3RwhxJi5q/l3alzUjKDA1jSwaANe3ShGe/GB0TFOEjgIYtdj4RXoPXTRuycuJhssmxT/Qu9Fg3fNhCHUuDnuM5VwwWEF08QjN3TjTXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trvVzPXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014D5C433C7;
	Thu, 21 Mar 2024 03:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710992763;
	bh=bwid3uwKWHuUNT9wA19C7cl1ryQUBQSJA1FQcFOtxnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=trvVzPXI+hS8/hfoisdeodsAoz8BsbzpM+9oedrBNyS616bHlDU6Z3FrXdZm85mdD
	 EZ1IClPq0vDJLftlZ871oyE7P1NBLOlgC34rIUmlVaeCUBHdkn8hv14Sg6W60XGmzp
	 0dGU6tQO07ePCpgxQs111SBGv1qeT1brjDN6y0tHA8MAM0ZLJj6DBDRcpqB2BSH7CT
	 P7yYN40hCo2b9NDP7Qiu4OzlKVjneu4/sPybCx6hjvRvrfjAJ1C5HPM5zhWGEh38MJ
	 FfhDalCvQwu2NS/JjklpTRlIsIDaTTudrp7h4p7kC3BYcI9xGCQ5KvbYo9GR2Ci7f/
	 zaLHXnJ/Pqu2A==
Date: Wed, 20 Mar 2024 20:46:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Duanqiang Wen <duanqiangwen@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 mengyuanlou@net-swift.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, maciej.fijalkowski@intel.com, andrew@lunn.ch,
 wangxiongfeng2@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: txgbe: fix i2c dev name cannot match clkdev
Message-ID: <20240320204602.59687f28@kernel.org>
In-Reply-To: <20240321020901.443642-1-duanqiangwen@net-swift.com>
References: <20240321020901.443642-1-duanqiangwen@net-swift.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 10:09:01 +0800 Duanqiang Wen wrote:
> txgbe clkdev shortened clk_name, so i2c_dev info_name
> also need to shorten. Otherwise, i2c_dev cannot initialize
> clock. And had "i2c_dw" string in a define.
> 
> Fixes: e30cef001da2 ("net: txgbe: fix clk_name exceed MAX_DEV_ID limits")
> 
> Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>

No empty lines between Fixes and Signed-off... please.

And please read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pw-bot: cr
pv-bot: 24h

