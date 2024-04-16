Return-Path: <linux-kernel+bounces-146225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18648A6267
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B8C1F22349
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168D02E40E;
	Tue, 16 Apr 2024 04:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWCynFmo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5392F12E4A;
	Tue, 16 Apr 2024 04:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713241769; cv=none; b=rBVdbl9RaYFNt9slK0LJMppDQWCuG7qcl5MGYLJJQvx0w5MQzND/T6bZSuG3F5trl/D74Y0LcdNaC6WPFrCXW278AaPDxDt1Fu8JMTWrUhiMVprYp5x4gD4Ocss5QjbnV96MKqmz1vVeLCyJ6c3fW5iM38WdmSmcExDOzXHlwfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713241769; c=relaxed/simple;
	bh=fDIsLiFBv8WZkqMSX9IWNo7S8e9UOXd1bRwfNm5CC3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhLCmB/s4xzbtuBOw2hrABYalHygZTyj5MRImiAyfWRBNNQrTtdCsl+Tx3ZqiTf4eX/CSNYAJXxdOW0uwHfFZO+L5HysT2M2kZYKhdCIWEyFHgrURleJlXFOZ6hV0MaFIhQVTWrWNMBXlJLoKcOFXpHwo4PPMT8pNKWNoMEn/WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWCynFmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FD8C113CE;
	Tue, 16 Apr 2024 04:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713241769;
	bh=fDIsLiFBv8WZkqMSX9IWNo7S8e9UOXd1bRwfNm5CC3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LWCynFmoZTqD8CzHXe/yWkLg2Z8Enrvqsmu+vuSdkmpF1+qTq3LLzqy2MMdiAorFA
	 R1TBLMmNAnonVhA7kqX9P21xAapEKfTxqS7rYOFT+0Yi4odoPe9SzDjjl3flrQXZMq
	 3Is5HVO9g5nW7vDRgmNH8gRSzeoOQoHbe8+waj2Kx0Xw7Rr6gljswc6cEL2mrPy0wZ
	 Ays+K0Uaywhok6rRYyPdIBqHWqs0v+koFP6ZI0dBpN7plFTj7OTo4t4AaL3wkw0Z4q
	 QMhNUvfNrTxzmS4NN7papqKK1690+8GmKB606CnL7huEyGLlFxYBhbvH51oZ1NZFgp
	 +Zqetax5Z+kUg==
Date: Mon, 15 Apr 2024 21:29:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <corbet@lwn.net>, <linux@armlinux.org.uk>,
 <sdf@google.com>, <kory.maincent@bootlin.com>,
 <maxime.chevallier@bootlin.com>, <vladimir.oltean@nxp.com>,
 <przemyslaw.kitszel@intel.com>, <ahmed.zaki@intel.com>,
 <richardcochran@gmail.com>, <shayagr@amazon.com>,
 <paul.greenwalt@intel.com>, <jiri@resnulli.us>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <mlxsw@nvidia.com>, <petrm@nvidia.com>, <idosch@nvidia.com>
Subject: Re: [PATCH net-next v2 07/10] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Message-ID: <20240415212927.2c87ddca@kernel.org>
In-Reply-To: <20240415120717.1251864-8-danieller@nvidia.com>
References: <20240415120717.1251864-1-danieller@nvidia.com>
	<20240415120717.1251864-8-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 15:07:14 +0300 Danielle Ratson wrote:
> +	page_data->data = kmalloc(page_data->length, GFP_KERNEL);
> +	if (!page_data->data)
> +		return -ENOMEM;
> +
> +	memcpy(page_data->data, data, page_data->length);

coccicheck suggests to use kmemdup() here:

net/ethtool/cmis_cdb.c:504:19-26: WARNING opportunity for kmemdup
-- 
pw-bot: cr

