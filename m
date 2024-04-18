Return-Path: <linux-kernel+bounces-150620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3B98AA1E6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0701C21EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A039C17AD71;
	Thu, 18 Apr 2024 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inJZhHmw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCFB17A902;
	Thu, 18 Apr 2024 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713464176; cv=none; b=H7RvVtOoss3qC8DPn9o8S8+w2uYdIgpbiRI4Zp6Pz6lyZEjObmkn+2UF+L8hzYaJJod7IEuQCBA/hqqbn5kFZrL3sbbbf+vNM2Hu/tjrVmBa2TTTQ0VdpL9j7XScGHE29VLSIBr+H3Py4lMlxO+l00YCadeJYjUtlHec9unp6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713464176; c=relaxed/simple;
	bh=U//bNMwj46u+pNDDm3f3gXeA3lT286CbaTYsp6xkRkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usp35MZ7OICnN8gvs3NeidESO41am/oSLxEZzfYeNsdWILr2t/cufuvogFcPwcYabTMDz5GhvoYKRZNIHp8sQMEQeol+3oOTPDVK19lhyI4eqkg1vyClXK/Gr8Mhx8oHQ6jwyzwkcet7RfO1lHFCOnchkTyEYRWUCBZcwZf04H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inJZhHmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63084C3277B;
	Thu, 18 Apr 2024 18:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713464175;
	bh=U//bNMwj46u+pNDDm3f3gXeA3lT286CbaTYsp6xkRkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=inJZhHmwRj45vDADU2vkaxHZlX8+mG3kpjPu1SA39silVJUfsozbVmbauqEQlT0L/
	 dxswf7SFXOVBQlks8DmEmBHKJ80XjA0u9a9449zVgkqdTETe4YxHVy2luQegT6tlDb
	 g7y50H7hog/r8B7qlthQmq+/rxwTiXFfzQ+cxaQqu9TaMVo50YGmUh0fNYcwBlPfqo
	 u9HxwEi4uViZ2ki42s+q3e3tqxMGdWfLGjSSSdVzav8X0ueWwQnNSeDr2XAwzP8mA7
	 HYzH3mlApRa9jnhpnbSQTr8feNvlnEBkaYF6LVpMg3bmjJas+NkHvWHYhYOKfG0jG6
	 28YFWbxmkBtow==
Date: Thu, 18 Apr 2024 19:16:09 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH iwl-next] i40e: flower: validate control flags
Message-ID: <20240418181609.GK3975545@kernel.org>
References: <20240416144320.15300-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240416144320.15300-1-ast@fiberby.net>

On Tue, Apr 16, 2024 at 02:43:19PM +0000, Asbjørn Sloth Tønnesen wrote:
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


