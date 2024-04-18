Return-Path: <linux-kernel+bounces-150637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 537258AA224
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080DB1F2182D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A41E17967F;
	Thu, 18 Apr 2024 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBDr+AbG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D58316C845;
	Thu, 18 Apr 2024 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465576; cv=none; b=X/Zh5vhG7Q3lBsuuh/EjqNuHQS4pGIXNhv+sBugzzkehNgK70afnGbnvLKmB3M6UbaTUK8k3XquKnwfcF6Y+GP+B9JshlBO9d99iy4c3ebt6VzNhIq6xVQxb0sZupbaYIX5ax9uyETv09YhSTYDPgfZglK34WGF7zYupXWEZ+aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465576; c=relaxed/simple;
	bh=x6lJS0NA7gStQdsKP4gCf9gYcQbe5tpoNsr9tDbm544=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WibI18AaKGcdjC066uCYNe0v6tLki0o1DylTvQMWyw8lpX5OMZ4XOq6rMtOlw7MHmjeUFPwpQCyWeILJ5DMqpsRiSPKxh6DjbbOgFfAWIn9x81BCCVRV893yelK+qGyM7oTfAhoI3dyiIgejocNrnBMuKzRSsG9roIOijhpB6uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBDr+AbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1694DC113CC;
	Thu, 18 Apr 2024 18:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713465576;
	bh=x6lJS0NA7gStQdsKP4gCf9gYcQbe5tpoNsr9tDbm544=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBDr+AbG2T3QYewowJUP6w7Kw+9SbCxxx+yj1PJLE9c4jjXcyBN5LLmcKydXEYJg3
	 NkGlojFgq92aTTGDrOWUtXi3WoHOW1TKDYjNzc5BAFQ4fFTgyVMnrd62NMUur8qTWY
	 rWtQHhN7Ky3uG6pDXYNFgDBaRuRYOfWL6fx0KxOcCezK6dbUK4Eee8JhS+qpmbBT+E
	 ah0LQ3c0zPANMZtDsRd892PjKERv9ekVgypV1G/sC6Vab4FIcrLZe5R5GlGDNGC3U8
	 IK1rZIyC0Zq/Mmzvive2UWnlRvfxRfcAsNvdMVmgFlZCmbPYhvQaV72f4Wtxc19Rp+
	 hSIEOfVopz5Ww==
Date: Thu, 18 Apr 2024 19:39:32 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH iwl-next] iavf: flower: validate control flags
Message-ID: <20240418183932.GP3975545@kernel.org>
References: <20240416144325.15319-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240416144325.15319-1-ast@fiberby.net>

On Tue, Apr 16, 2024 at 02:43:25PM +0000, Asbjørn Sloth Tønnesen wrote:
> This driver currently doesn't support any control flags.
> 
> Use flow_rule_has_control_flags() to check for control flags,
> such as can be set through `tc flower ... ip_flags frag`.
> 
> In case any control flags are masked, flow_rule_has_control_flags()
> sets a NL extended error message, and we return -EOPNOTSUPP.
> 
> Only compile-tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


