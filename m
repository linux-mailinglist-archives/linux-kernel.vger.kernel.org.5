Return-Path: <linux-kernel+bounces-150635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD03E8AA220
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F536B2282D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADC8178CEC;
	Thu, 18 Apr 2024 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY50xFiE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498ED16C438;
	Thu, 18 Apr 2024 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465506; cv=none; b=LprRBf1VSH2/WeCDSzwzmZF+GD09mwqNPGqH6L3IMPhdzx03oyBQlbZvBCpq+kkWMbo9D7m1VAdn6VisSgeLYLEtH273kLBLF382/Z4yQ0n4JWb+Fvn0mIs55rdhX+mgMchWHpYzy77mp65fUFFMKwKQrO5Vvj/7hxLp/EuoEl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465506; c=relaxed/simple;
	bh=/2OgoxKDBN2MBqE0ejk+VYzE32r/z0A9/r00iV40u6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+u8dALcToC/P8Txvyk2dYtrs8t6clW1XOp7ngAovFHYw8Ws46sJYfftvHAqEqc7nnv8W8MvS77gpudy81j3jjPgWvLORXgPscTG+45TuoIDIgM8vmH7xfHHX0N/1UsibdbhdNQE2K7fx+IuhUWDxqrk+/DIEQaRpkc/eQm9PLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY50xFiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9172C113CC;
	Thu, 18 Apr 2024 18:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713465505;
	bh=/2OgoxKDBN2MBqE0ejk+VYzE32r/z0A9/r00iV40u6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DY50xFiEN1LZrv32izTmTxre69moJG1xz2gJyKl5XZlU6bS6GLyp7mKbtYqVpKzXD
	 V+/hUUFQ1UgQx5kjZZg7L7wGBm8kVVL2OYPl+DpWOlKr6FQiKslX23aFFQgDLUf+H/
	 Nc8PBofvbJoH7SLWyaKOc9ztpFGBYoHZ5x7t6ji3GXSuieSScSZ24vKJF40s321UO7
	 Q+qjB3qNZQVCU8I8HxKLk81/JDTIGsHh52YaFkgHQfSaH3IbVvWRwqJPcV8Wy3QPDg
	 MicUAWf1dGGZ38hbz7/sbajyezfMfUxYNklgvcURlWMlk12SPawnnuJ8Bd8kNdTYjz
	 wV0RAYLvVCF0w==
Date: Thu, 18 Apr 2024 19:38:21 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH iwl-next] igb: flower: validate control flags
Message-ID: <20240418183821.GO3975545@kernel.org>
References: <20240416144335.15353-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240416144335.15353-1-ast@fiberby.net>

On Tue, Apr 16, 2024 at 02:43:35PM +0000, Asbjørn Sloth Tønnesen wrote:
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
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


