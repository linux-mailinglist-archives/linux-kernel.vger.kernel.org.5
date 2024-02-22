Return-Path: <linux-kernel+bounces-76608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF0B85F9EF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A910C289AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8D0134CFA;
	Thu, 22 Feb 2024 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba1xJzgy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E78A133405;
	Thu, 22 Feb 2024 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608973; cv=none; b=GgtqCmP7iRR6lBjzrRKDrzH0+24HFw8GyVAepiWXSbp2n00MfXV3lGuhHj35SJ5Nbjx+AR2OeWw+tKDz78bFrazwbZQ+ZKSI2RvqWB+bS6RghcZ5bx/Nsx8Gip4gxndbOIlVKLOmcoNd1mpSMfI1ECdTLW1VwO7zyVWvuTdVKpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608973; c=relaxed/simple;
	bh=qXyG+CrrwaY763OMJTaQBN38j/QXGJ46vvzoRAe2F6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvvP86zMK8giheKhgevmmM+aS+B3qscS1xgthbshdMrps6iuVoYgy72HYmPprDdDLu2yhsKYALBQfJLm+SzMk6fO7lo0I7Ozk6gNm9ghBkYlrJg4m+w8dtDYVYgsk/yYXXzmEFxfEAM/chr5vWB6wtYpfz6w52MeyE3yd23BMPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba1xJzgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5012DC433F1;
	Thu, 22 Feb 2024 13:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708608973;
	bh=qXyG+CrrwaY763OMJTaQBN38j/QXGJ46vvzoRAe2F6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ba1xJzgya3V5tCPUeOhReeB5QYbSyk2WosQ4D53fMFh69AeX88EPMbikxQoxS5umh
	 ujLCDjVXoJ7Lmh9ljkC7b1Tl78VBUyvVOkKSgMWVDcDr7n5dskxNBiuHNeQcO33zwD
	 re9p5/RV9gWLEUYst4+gIKXtgKsZ+QVpmwfRoG+ZLu3F2E+mV0MUcYXcaTbFBO70ts
	 TrWN+vNc+g8TWNR6edgMDD99RBsB5nLCe4vPDqfmE++dl28b8qyrDnCrDaC50q4j1l
	 3nsHAC+kM1R0kDWtOY4++GWKv8BRErRRjxQTC7oOsY37qmfKhLr/o1fgq1d5xzd0T5
	 yXnsJhJTX76Ww==
Date: Thu, 22 Feb 2024 13:36:09 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ipv6/sit: Do not allocate stats in the driver
Message-ID: <20240222133609.GC960874@kernel.org>
References: <20240221161732.3026127-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221161732.3026127-1-leitao@debian.org>

On Wed, Feb 21, 2024 at 08:17:32AM -0800, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Remove the allocation in the ipv6/sit driver and leverage the network
> core allocation.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


