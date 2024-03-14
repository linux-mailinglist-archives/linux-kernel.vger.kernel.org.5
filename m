Return-Path: <linux-kernel+bounces-102747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D76C87B6D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E4C1F21898
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6844453BE;
	Thu, 14 Mar 2024 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BEIJUDTD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BF44A15;
	Thu, 14 Mar 2024 03:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710386646; cv=none; b=GIsbet5jrodpkGR7I4G5Mx67MtYSjCzn10rl2PVh3jE/7EAkyXyBAoVHYshs3gqOEthVO4oFeRUbbyriTiCFoVkwR+1Hv3ko1YSdX+7rX+ke3UguIxq+eGWvmoyqJzWkJK1AYdMVDmC4Rht3m6mamljydguvGz1A+s0MWp6kiYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710386646; c=relaxed/simple;
	bh=eZuRvmWgcpTPPgj9ycM/o+D8oj337tsMLnQUeUVCjfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuoPwiegSywbfpQKkCYK/oIVcTqAjnOH5WVQIXTaLfsyqX+dWkmDMQfJB0WaDYpzJkYBWO4Ai6Gyypf9J9JItQuALpQIRWit8J7HMQi6hqb7k5dE4xlR2xzi7mJQprDhecgPqybbMrgMMWdLVvh8vvWvAebdmWNy7l4dcDsXQpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=BEIJUDTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCE4C43390;
	Thu, 14 Mar 2024 03:24:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BEIJUDTD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1710386643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eZuRvmWgcpTPPgj9ycM/o+D8oj337tsMLnQUeUVCjfg=;
	b=BEIJUDTDI/ypsK5HykKPz4+WDrslSA51yjHA2iwec+V+FwVONbwptMVhFFYauWOvj7SrF+
	S9uL0mR9pLpOCn0AXRRe8AERsw7DWP6Zkfn0tfRYBNme/w0DRQMIoSX43AT7Wnnvg+n0Im
	bAH+sMJanbAJ4J4Q48s3atRF7K5dXUc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a62e8f60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Mar 2024 03:24:03 +0000 (UTC)
Date: Wed, 13 Mar 2024 21:23:58 -0600
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org, dsahern@kernel.org,
	"open list:WIREGUARD SECURE NETWORK TUNNEL" <wireguard@lists.zx2c4.com>
Subject: Re: [PATCH net-next v2 1/2] wireguard: Leverage core stats allocator
Message-ID: <ZfJtzhKJV4yo3LRF@zx2c4.com>
References: <20240308112746.2290505-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240308112746.2290505-1-leitao@debian.org>

I applied this series to the wireguard tree. Thanks for the patches.

Jason

