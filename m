Return-Path: <linux-kernel+bounces-150932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC788AA6D8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 04:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8C71F228CB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4739153A1;
	Fri, 19 Apr 2024 02:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtBII6e3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808A84C6B;
	Fri, 19 Apr 2024 02:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713492477; cv=none; b=IyCI/LN3Gueo1wON1t2X+9he8Bv3axXCQWByEp47fkC8FjFOOgv2P6a483ARCwj8b56NtitH9sZpTu+IkbU/jYtKG0c+HITg+PITEbPi78OJzbbGJj2bJuNu/qNjsRq0+QAWwZPtcKoLIkmQODj4WmYkXy2Snlch0uHTYWJr2WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713492477; c=relaxed/simple;
	bh=X72OXuYe/3hsHFyy+rxRJlE3PBWjqR3xc0lDbLCji8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kf/J+c4j/ERLcuGZsJ+jLfjg1/m/nht0c3t1tRGFSDK/LWzzXYhKqGI07JXi4JTSj1OSMAkAIDR8L61QsQwZOWeNXzSsFWNEp93S5e748tsKtH2jTCumicpzNyE9NEZ5JDNYLCm8dWvGv+P/Pqa5C7G6lSAKHf73pBW5BfOJyhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtBII6e3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A447C113CC;
	Fri, 19 Apr 2024 02:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713492477;
	bh=X72OXuYe/3hsHFyy+rxRJlE3PBWjqR3xc0lDbLCji8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jtBII6e3f2HENWd7KuoNwDTV/183CC8TqBRqKBFlWw3RR7ZlnOMUaes5Zl8FESj5P
	 blHKTMKQ1ThMO5FWY1r4AAahCDh0p2P6XFgnCePQZkHpaioLH+qpcBCYiZPbJrp/Tn
	 MGmEYmhCVT6GeCmyupPI59S6FqBvhZTctZgxb1mJD5laEGbgX5PAoESbINhGNyGfg2
	 NEitM6tsbbeH+lt4mR5Mb2F4CRqOBGkK0ICYdZUngNoO/czJizgeXvuFwdkk9x4otQ
	 fznTWROR9Ex13jXHKw9LMbQCf7XFSC+sY9E/sPO9CyNvxPIwBgFv2G7Gh+PPPappJa
	 0dSo1syYE99qg==
Date: Thu, 18 Apr 2024 19:07:55 -0700
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
Subject: Re: [PATCH net-next v4 03/10] ethtool: Add an interface for
 flashing transceiver modules' firmware
Message-ID: <20240418190755.1865fcaa@kernel.org>
In-Reply-To: <20240418103455.3297870-4-danieller@nvidia.com>
References: <20240418103455.3297870-1-danieller@nvidia.com>
	<20240418103455.3297870-4-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 13:34:48 +0300 Danielle Ratson wrote:
> +  -
> +    name: module-fw-flash
> +    attributes:
> +      -
> +        name: header
> +        type: nest
> +        nested-attributes: header
> +      -
> +        name: file-name
> +        type: string
> +      -
> +        name: password
> +        type: u32
> +  -
> +    name: module-fw-flash-ntf
> +    attributes:
> +      -
> +        name: header
> +        type: nest
> +        nested-attributes: header
> +      -
> +        name: status
> +        type: u32
> +        enum: module-fw-flash-status
> +      -
> +        name: status-msg
> +        type: string
> +      -
> +        name: done
> +        type: u64

uint?

> +      -
> +        name: total
> +        type: u64

same?

> +enum {
> +	ETHTOOL_A_MODULE_FW_FLASH_UNSPEC,
> +	ETHTOOL_A_MODULE_FW_FLASH_HEADER,		/* nest - _A_HEADER_* */
> +	ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME,		/* string */
> +	ETHTOOL_A_MODULE_FW_FLASH_PASSWORD,		/* u32 */
> +	ETHTOOL_A_MODULE_FW_FLASH_PAD,
> +	ETHTOOL_A_MODULE_FW_FLASH_STATUS,		/* u8 */
> +	ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG,		/* string */
> +	ETHTOOL_A_MODULE_FW_FLASH_DONE,			/* u64 */
> +	ETHTOOL_A_MODULE_FW_FLASH_TOTAL,		/* u64 */
> +
> +	/* add new constants above here */
> +	__ETHTOOL_A_MODULE_FW_FLASH_CNT,
> +	ETHTOOL_A_MODULE_FW_FLASH_MAX = (__ETHTOOL_A_MODULE_FW_FLASH_CNT - 1)
> +};

The next patch uses these names for notifications and patch 9 for the
action. The YAML spec should contain basically this same info.
Not sure why the spec ended up with two different nests.
Just translate this enum into YAML:

    name: module-fw-flash
    attributes:
      -
        name: header
        type: nest
        nested-attributes: header
      -
        name: file-name
        type: string
      -
        name: password
        type: u32
      -
        name: pad
        type: pad
      -
        name: status
        type: u8
 ...

And you can use this nest in multiple operations, using the attributes
members of the operation to narrow down which members will show up
in given op.

