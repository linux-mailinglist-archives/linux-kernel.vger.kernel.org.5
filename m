Return-Path: <linux-kernel+bounces-151406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA958AAE6E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC5B1F21E71
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8FA85636;
	Fri, 19 Apr 2024 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhQPXqen"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19EB83A06;
	Fri, 19 Apr 2024 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713529764; cv=none; b=X2fD+xigqvTltNoE/6e3tX4q3/MBWbUWRJ3MJirj1G8+z2nMFPVTK+R3D7YfG5R+uPDyHm86ldOeJEgrYQCMldGL7jJa24SpSw8h3R/nmtMY7gP/ljgj0rCxJujwPjLYt++QXzQVpi3GAMBOe9qMYZ5S2JRHSJKKBLw6tGS0R3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713529764; c=relaxed/simple;
	bh=FsT2MKkbtTGAME/O+dE5EEcXNlp4yzREhMjQvwN8vR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJX07oVwSf5rek2sQuYq2Xmlc8jZEda8Qjo3SCEWqtn+cZwG78hJEHnnEGv5R7m6sK/aReFuvzZ9E7OmXFTAw5QH6Js6Us0qM5l4PfjomFj5OwkjNJvQcPfuBLB3yPjIerOT47mLRvdvBFV3448wJSBPv5n3vomYxTKhx9SV2BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhQPXqen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766C1C072AA;
	Fri, 19 Apr 2024 12:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713529764;
	bh=FsT2MKkbtTGAME/O+dE5EEcXNlp4yzREhMjQvwN8vR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PhQPXqen44zAoPEFPJsdkKh6BCq92RZTY1rOIfKS32iDoobsE2C72FJ5VurMJBIfl
	 IWxLqCO8W8Aeveig7AlKuA2quvBT2KavRUmkC9r59XLQLnaajIqDoAQE933GrmUTR5
	 6xcTklcIdltHEbFoxCCcDAmWxjY5+3aCjDrhRuiDkj/S9ehSNsh9q+NdffE5cbRp+7
	 J5sKxVC1SHiRRPj3Eol8Gdu+gXh2TTN5JOBlCpTfvX15nfOi3yptxlQnogLz+4cK7e
	 LYk11P5eGOQZRr2zo3HvFq4vy7h03VTr+PRR2oROB6U28cPVE9WS5kO8g3saQVyz1Q
	 HcDOmPVkypcGg==
Date: Fri, 19 Apr 2024 13:29:20 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Raju Rangoju <rajur@chelsio.com>
Subject: Re: [PATCH net-next] cxgb4: flower: validate control flags
Message-ID: <20240419122920.GZ3975545@kernel.org>
References: <20240418161751.189226-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418161751.189226-1-ast@fiberby.net>

On Thu, Apr 18, 2024 at 04:17:49PM +0000, Asbjørn Sloth Tønnesen wrote:
> This driver currently doesn't support any control flags.
> 
> Use flow_rule_match_has_control_flags() to check for control flags,
> such as can be set through `tc flower ... ip_flags frag`.
> 
> In case any control flags are masked, flow_rule_match_has_control_flags()
> sets a NL extended error message, and we return -EOPNOTSUPP.
> 
> Only compile-tested.
> 
> Only compile tested, no hardware available.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


