Return-Path: <linux-kernel+bounces-100946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD7F879FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCAE28371F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5865C4AEEF;
	Tue, 12 Mar 2024 23:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7uFle32"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9709047796;
	Tue, 12 Mar 2024 23:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710287747; cv=none; b=FjCa1m2/1KenSyhtjZPrXfdHwDhg1lT8cmuXNYlmithJJWgo/s0SGkZe+oofzKXrayKr88+jvmarToOdOKp/EiSzRgE9GvG3s3anZflgbDvtANoanXEZbQ7BRcC1ppUapFQ6Tt2FkSr8b+KdLCE5TXac5xj/fsB+EJj5ihqc0Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710287747; c=relaxed/simple;
	bh=lWVOaAa1PbN4cR2qaaPG+mAy5NHELjQFGPdecwhzW0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlnFRgDs0R4x6tGIhZigBlw+GMI5T8JMcWyL0QIGq+IzeelyVMoq2eiwqIta0kIc6kSMvvPO4Bo07NJJX8v1o7gc1RMFbu051qdKnNThm/mMp/yRwCw2l0mwyL9dd12fGT956j6S8mKeUzL52cTiJ1+Xom9SKWz4DuZNcFpwigs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7uFle32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5DEC433C7;
	Tue, 12 Mar 2024 23:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710287747;
	bh=lWVOaAa1PbN4cR2qaaPG+mAy5NHELjQFGPdecwhzW0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K7uFle32iOGRXQBVt6IXGvExopg5GE2QahRWr0HC7sCN0DLj2W1D0+khFeKVybwtw
	 eQnOur50Hze75Sv2WyebymAWUcAotmIN+0c3LLAUJGL4whO4gXgqhByOJhTILmRh2w
	 AfzVhCafu83fa/EZ0gfUwPyApbCxPIOfN6fKiR+MBYM61vde6Pk78QPKOJOX2Ox22v
	 /MQMg/05/FOXqZUWjsL8Tc6zk79akPY2fzHRgrrX1XXJQUsYhBpYBeQlVpL+nXp96p
	 xNdtEtci5vOmi+F6tSj9c37fkJ5QPm8ptLgPiWWI1pElWDlVUMo5mBc0mUrL29bPcM
	 zMPc7O39yv5lg==
Date: Tue, 12 Mar 2024 16:55:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 alexandre.torgue@foss.st.com, andrew@lunn.ch, corbet@lwn.net,
 davem@davemloft.net, dtatulea@nvidia.com, edumazet@google.com,
 gal@nvidia.com, hkallweit1@gmail.com, jacob.e.keller@intel.com,
 jiri@resnulli.us, joabreu@synopsys.com, justinstitt@google.com,
 kory.maincent@bootlin.com, leon@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, liuhangbin@gmail.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com,
 paul.greenwalt@intel.com, przemyslaw.kitszel@intel.com,
 rdunlap@infradead.org, richardcochran@gmail.com, saeed@kernel.org,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev, vladimir.oltean@nxp.com,
 wojciech.drewek@intel.com
Subject: Re: [PATCH RFC v2 6/6] tools: ynl: ethtool.py: Output timestamping
 statistics from tsinfo-get operation
Message-ID: <20240312165544.75ced7e1@kernel.org>
In-Reply-To: <20240309084440.299358-7-rrameshbabu@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
	<20240309084440.299358-1-rrameshbabu@nvidia.com>
	<20240309084440.299358-7-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 Mar 2024 00:44:40 -0800 Rahul Rameshbabu wrote:
> +        req = {
> +          'header': {
> +            'flags': 1 << 2,
> +          },
> +        }

You should be able to use the name of the flag instead of the raw value.
Jiri added that recently, IIRC.

