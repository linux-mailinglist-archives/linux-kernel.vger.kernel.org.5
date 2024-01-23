Return-Path: <linux-kernel+bounces-34717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8EE838688
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D10287534
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD9023AD;
	Tue, 23 Jan 2024 05:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNNxPNxc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBF12107;
	Tue, 23 Jan 2024 05:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705986423; cv=none; b=QGMFd1nVFwrnWB2oqvIW/fUtwgaxtqaHfNnu9/WW2DNahm6FGCDsYItLQbyOVUqBdpZgbAoAeVo3Mh1CTZyHL+8lBfS3qxqXTwou3Kq4+jlmceEZl9CCP9anL1ZA6xHTB6UoPM7TbuqWi00FJibgkSiw32ZtdmpSIq9nUSiFPxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705986423; c=relaxed/simple;
	bh=XX3LA4E4rJdlxLNkIg/Wk1MeSiT4eADZjmfxpCmQY9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUcowx5qm4CdI+pjCZbL2XxgDyIrp9zuHfhpe0bR4tPKM71sp7N9y486doHm9HJBBhnk06wLGRuhS4QF8zdavond/5Q//9SudZ9NdaQkey2VRSW5csawZGV3Rf4Algs3kyvSgMg+tBmgAFnGKJhtD70CaaZaglFRADDDTTyL9cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNNxPNxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03075C433F1;
	Tue, 23 Jan 2024 05:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705986423;
	bh=XX3LA4E4rJdlxLNkIg/Wk1MeSiT4eADZjmfxpCmQY9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eNNxPNxcEF0Y8CfRXIlvHMd8FJQq4l6Hf6Ct0VV1f3L7IP+Rb3aNV23ItuZ9T72ET
	 yc2upsGdeLoF0I4F3oE7lu9lPd0F0SM8JLZDG/wULHYk15YAoQU2FxZT8WTKizTSw8
	 9CoIONbWCpiwXeMdoaBUXinUgR/bioz2pD+6OHc1KByQ0ISZmcOpoPSsJ0avyUpwS+
	 j7rzN2+XKCqwBprleDsVqJNu2hgmf3xdQQNJxzJXlNgbvjraarc3X3UfcMWy4y4Phc
	 fPQ5V3pKwj0mHWArP8zA5ZZXu15heq18jO85SGdc99mT1t+wtjZ5WCd37JRBfGqX5f
	 nLD0yWCY2QoaA==
Date: Mon, 22 Jan 2024 21:07:00 -0800
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
Subject: Re: [RFC PATCH net-next 8/9] ethtool: cmis_fw_update: add a layer
 for supporting firmware update using CDB
Message-ID: <20240122210700.6e322eb9@kernel.org>
In-Reply-To: <20240122084530.32451-9-danieller@nvidia.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
	<20240122084530.32451-9-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 10:45:29 +0200 Danielle Ratson wrote:
> +	netdev_put(module_fw->dev, &module_fw->dev_tracker);
> +	module_fw->dev->module_fw_flash_in_progress = false;

The other way around :) Once you release the reference you can't touch
dev at all.

