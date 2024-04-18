Return-Path: <linux-kernel+bounces-150632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF628AA216
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6670E1C2182A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A1616F919;
	Thu, 18 Apr 2024 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdx6C5p0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F14E38DF2;
	Thu, 18 Apr 2024 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465210; cv=none; b=Nxx7l7/iTk2QXDL0eoaUwzkgQe4EuWskp6SqvwWLUqp19xYGFAwDXn61+Ea/gf+kuKNgQpULll4drS4sr+iTJIORSGp1hx3voaoy1M+pvm2zlpCquNC2DvuyNMURGpz+YKJXGUCuYemTwj/UKFwUimNxSVYU/O32HHR47NETER4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465210; c=relaxed/simple;
	bh=204nbJqwfowjdVgRKxlEgX34QlRPktyN8ChVjcJivxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CklbF+mSCO05MAJ7U1ZwbR1CEAu24mep7RcI5T/LcB0U+TZqSXqtUrk3OzikktbhfP3sOlObmIe4vLgsPbpHFa2Ur8LNKEmt2gIcxvCY9/UHmUdeAED5TZtXE74LW0juSo7tERItdg9n1f0v5DjDjJ39GwjfLXjIBBKfPF/1gRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdx6C5p0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C8CC113CC;
	Thu, 18 Apr 2024 18:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713465209;
	bh=204nbJqwfowjdVgRKxlEgX34QlRPktyN8ChVjcJivxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cdx6C5p0JdxXjHMFQPrQd8CMCnCke9amRGFdpjlXUMBvr3Wg/cL5N52o8UF5PzXKy
	 p+TCpIjCAjVSydPGL3UHaTTNl+UQvIn8splVLWXJ8sd0tBD7ygqFmEuxnZWp+1VJLf
	 mgx9Dnip294KJkWG8MI6/9m6aNkA7Q1zkvKuUobu2qfSw/KzsYvxhISJb6ozHB2Soa
	 P5CkEKRYkYBrIub/UE6hOGof8otPryWwe0yPtJg3HIwJ92MhJatKSsg6rY95W+vgU4
	 FDO+LVlQYxljyw8STQ4/2gcJzPLQLcqIbvAPuLI8mp7iXCy2ylEniYeGZhA55WbWrD
	 m8mefZq66SzTw==
Date: Thu, 18 Apr 2024 19:33:25 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:BROADCOM ASP 2.0 ETHERNET DRIVER" <bcm-kernel-feedback-list@broadcom.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: bcmasp: fix memory leak when bringing down
 interface
Message-ID: <20240418183325.GM3975545@kernel.org>
References: <20240418180541.2271719-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418180541.2271719-1-justin.chen@broadcom.com>

On Thu, Apr 18, 2024 at 11:05:41AM -0700, Justin Chen wrote:
> When bringing down the TX rings we flush the rings but forget to
> reclaimed the flushed packets. This leads to a memory leak since we
> do not free the dma mapped buffers. This also leads to tx control
> block corruption when bringing down the interface for power
> management.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>



