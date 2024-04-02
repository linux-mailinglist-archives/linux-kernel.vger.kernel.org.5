Return-Path: <linux-kernel+bounces-127558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E907D894DA1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A931C21B55
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D598405CF;
	Tue,  2 Apr 2024 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4xrcOTT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB8E1E525;
	Tue,  2 Apr 2024 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046819; cv=none; b=gVtjYkOo6Xjna0mUHUPY/r6te4kHXcvq7g9mfpABMAedcHJNi6nHSoqiQ4kj7ZI7P9arn1p9phXpAYratbeOq3t39mtFpHtop31HT4BtY9VawyRDLW9nPnA14q9pIBEZXd/xxMmJVxWLBXUk1me7NEVFbUHdmEj5PJwOQ20EN5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046819; c=relaxed/simple;
	bh=bXyppnTsq/tBX5BGx9iSKNg3xb6/ovlVg4bpOhE0X14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdC/aP3qBN+FHaIzufAvLOE2YqKSEnu9Wmk/YHP2vXSkkb7OQGWwOu3YXTd1yKTuBmahgm1xMGho+StlsROwUvgrgsbnTbpI3HX6quVM8d9+c6MrjFaipi6AzLNYK25Rsjlum3HHeQ2iyOhsYGpJeb/GjqOXWGlAggZ6HxfUu7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4xrcOTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E616C433C7;
	Tue,  2 Apr 2024 08:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712046818;
	bh=bXyppnTsq/tBX5BGx9iSKNg3xb6/ovlVg4bpOhE0X14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4xrcOTTfgxGpqGUxxTpuZVUl7cT4mU6NxiFC920NGVCiHoIpwjBG6cGAY4vtnKSw
	 4bAh/XQWzg5AIbj5RJXD6HsflDLKeqoy2npzxF4aXu3A4imLUKq0FgSMF0iceQ/L5B
	 UqlPU+YTmoC0Zfog3WxK+ksd20xPQxkQc4Wffcry+SCvIJ/jWbUgAfr0FHgOb4KFrr
	 y2jIrjszos9ncX/K5kFImzQNHeXFUF6VHJwLLFcu0A7N6oz47V0ZQK49pkHogcwsc+
	 HB68Y7KwRVDw1XmQAkeCVIs8nNOgLDVJgWdQoFhNemEYwrUwD/bPmzogXd9yk8NOtx
	 XBXSQvRTCVmTg==
Date: Tue, 2 Apr 2024 09:33:34 +0100
From: Simon Horman <horms@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] net: stmmac: mmc_core: Add GMAC mmc tx/rx missing
 statistics
Message-ID: <20240402083334.GM26556@kernel.org>
References: <20240401024456.41433-1-minda.chen@starfivetech.com>
 <20240401024456.41433-2-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401024456.41433-2-minda.chen@starfivetech.com>

On Mon, Apr 01, 2024 at 10:44:56AM +0800, Minda Chen wrote:
> The missing statistics including Rx_Receive_Error_Packets,
> Rx_Control_Packets_Good and Tx_OSize_Packets_Good.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Reviewed-by: Simon Horman <horms@kernel.org>


