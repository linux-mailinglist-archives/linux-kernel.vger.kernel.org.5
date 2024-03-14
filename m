Return-Path: <linux-kernel+bounces-103641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C935887C259
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849D2282834
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3540074BFF;
	Thu, 14 Mar 2024 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twFNsMJC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE51745E0;
	Thu, 14 Mar 2024 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710439186; cv=none; b=QAttnJo2Ec6UVD793CbvaBUwaao0/OWz4tYRoO0VWyMuCbCtloIvGQbFGYJ5MpO8vszT0oO43hzDzfDdNjo0Xg94rf3C+Iims0lHhTQ3S3fDxpIDYbWl7uVGBMSYSQZipk31BgobJiYSMh1ywtaLWl2g5qpHZzpNIvUEkNtCfJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710439186; c=relaxed/simple;
	bh=dFDNZyuAIw8aoddhMktOJ3szGAzk6RfcWq45ln5FMe4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnauaqID28UP9cMQuCtmlBZ6lnYj6bu2iiSnzoF5EBqmCn3wGCZx/c/MoV3SBf3apmyjuLGDSLFCDoSKyZzZOHQC3+OMspUXWpgRH/DwxbFB6w6Aodk32qnjLMItPXPoJMdyqv0rPiAZtOdRLIoiP9nJIwnvrKrxqxIkLfMmjcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twFNsMJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF39C43394;
	Thu, 14 Mar 2024 17:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710439185;
	bh=dFDNZyuAIw8aoddhMktOJ3szGAzk6RfcWq45ln5FMe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=twFNsMJCiGgqQPBRH+4sna9vJbTvsAR38YxtKDQ+ZH5WcjXKioLnMbjIf3WDstNJ9
	 NJn10+85Xa/qTS+9L8JgsEr6LGCKo8apeMrSirXG4EPi2MH/Z0Edo5Dei+yebWQUWn
	 tkNhWqnx4c95ip13RpDX29NlV6kqskruuw42KSg23kquOGEqWQXTuXA1CNPGcg+fUj
	 y/qB86vsvzqaOb6aVbYgORyujsX/klDB4BT0Wz3tbpG7dGbfHpRy8e6qIx/lKQwT1n
	 viAklUi8yZKvPahjV9AeN7Pc7k3nlQkcn8dUbwHlVMlmD0WvqcEUCFc5vETrzonEAq
	 0eWENzM0L7qQA==
Date: Thu, 14 Mar 2024 10:59:43 -0700
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
Subject: Re: [PATCH RFC v2 1/6] ethtool: add interface to read Tx hardware
 timestamping statistics
Message-ID: <20240314105943.7bc6f2ef@kernel.org>
In-Reply-To: <87v85ovj4d.fsf@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
	<20240309084440.299358-1-rrameshbabu@nvidia.com>
	<20240309084440.299358-2-rrameshbabu@nvidia.com>
	<20240312165346.14ec1941@kernel.org>
	<87v85ovj4d.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 10:01:49 -0700 Rahul Rameshbabu wrote:
> You need the pad to match with ETHTOOL_A_TS_STAT_PAD (which similar to
> other ethtool stats currently defined). Otherwise, you run into the
> following.... mm-stat and fec-stat are good examples.

I don't understand.
Are you sure you changef the kernel to use uint, rebuilt and
there is no ETHTOOL_A_TS_STAT_PAD anywhere, anymore?

