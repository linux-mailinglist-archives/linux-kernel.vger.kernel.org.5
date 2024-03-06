Return-Path: <linux-kernel+bounces-94046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 081DE873901
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A906A1F23DB1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B79E132C19;
	Wed,  6 Mar 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVWWsexe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C252131759;
	Wed,  6 Mar 2024 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735201; cv=none; b=N18UvqoW5xLZNCrNh3OWvXqJxpO09Jhb0R+FmjlmD4pCBSqytix+uAO57JESvuYELPLV7q4meH5qAx3khIN6InGZZ9pKBFINGuy25EjoOWC3XgKNqhrPQoOAJmwUTwZHjBnz2mhtLKYw6Dy5nnhsJnAelQ2HJlQrUn4kQfx83Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735201; c=relaxed/simple;
	bh=CvQGHmWgOnsOTN4nRgF7DFatpkWfraS3t2qrVvApk14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFXGfS4FqnjhlRlukoLsNb8jwAziaFUZV+fCFqYDF9TokqMak5b++HlGaSmhxECmWTV0UPMmUMGuMbGpKvF7U3qW1oSaJNOOYZIayie9vQY5gw3OFVWt8OBrL8ii4hFhDs/V91QeFiv9uxMknq6enPIU0KlwgKzh3d0R3ip0CAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVWWsexe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BBDC433C7;
	Wed,  6 Mar 2024 14:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709735200;
	bh=CvQGHmWgOnsOTN4nRgF7DFatpkWfraS3t2qrVvApk14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qVWWsexejXTXdMwUVX+jFW9ip/xjVh4qPvLSTAWGD6bf2LV6/etQYZWwQ4HqcgABk
	 qecK8zq5ybarJwt9MnLg8u3m6zHJS98+I/jYeARtuu7rNSwmNe70WTUagcxHKGK/mC
	 dyLwuqulQ3kr8kGulGWx42i4gzCA/aw+t62tIIFa95Iw9AlMo4ZHmgTZrj9jk8dzeW
	 d7bYZk1SDI7P2qDg9OCKCeu+yv+NoGa0xqDwgZCoELX2+NwPCQ+zMuSNpdV8eccqpS
	 rvx3S7BE2HhA0y0zijKMQYRTQn7E0WQfxhwpkWkBWFCceDXN5qkFksNSxNpZyzu6pu
	 OcWHWd+8er0ZQ==
Date: Wed, 6 Mar 2024 19:56:36 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Shalini Manjunatha <quic_c_shalma@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Raghu Bankapur <quic_rbankapu@quicinc.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishna Jha <quic_kkishorj@quicinc.com>
Subject: Re: [PATCH V0 0/1] ASoC: soc-compress: Fix and add missing DPCM
 locking
Message-ID: <Zeh9HMcWxfgPJS1T@matsya>
References: <cover.1709720380.git.quic_c_shalma@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709720380.git.quic_c_shalma@quicinc.com>

On 06-03-24, 16:23, Shalini Manjunatha wrote:
> We find mising DPCM locking inside soc_compr_set_params_fe()
> before calling dpcm_be_dai_hw_params() and dpcm_be_dai_prepare()
> which cause lockdep assert for DPCM lock not held in
> __soc_pcm_hw_params() and __soc_pcm_prepare() in above flow
> when ever we play compress offload audio playback use case.

where is the patch ?

> 
> To fix this issue added DPCM lock and unlock in both places of
> above code flow mentioned.
> 
> Shalini Manjunatha (1):
>   ASoC: soc-compress: Fix and add DPCM locking
> 
>  sound/soc/soc-compress.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> -- 
> 2.7.4

-- 
~Vinod

