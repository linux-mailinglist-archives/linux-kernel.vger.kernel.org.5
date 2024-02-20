Return-Path: <linux-kernel+bounces-72525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F0C85B4C2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65FA61C213CC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BD25C612;
	Tue, 20 Feb 2024 08:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="J1Ey4bzc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E/uyVOSQ"
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909E85C5EC;
	Tue, 20 Feb 2024 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417114; cv=none; b=BvS/EHQxvnGYBmj2qZkq71lx36AvMRitwb1/7POgW0HwiCsE37P9rQAApk2MTiiJ150sQfICg+9UdQ98VsHj7smnJn3KjHdbAdQ7d5cOkaJQuDZGWYFvLsqDbxFCHs916PbJcqT4NFson8LK0YK52IVIsI0ZXCPtFZCf8vQjRKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417114; c=relaxed/simple;
	bh=44KeRkZzH8u0JWb+rtwwt50cYvGw2jgAcwk1Xl0K62k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjTtN9r8DXID/L0G8vdJ/8Jgs8UFnpFqSJ5Gv7YXTfV2jElxf0rzbHycoVQsjhFHJnF5UoPnLrC/wwrHWeOGCWZQecsxFS/FLHUb2oeNWGvdkOQjzNIrzg7bOGavtnso31sKK+kb2LNifpby/mIqmo2Pwp2yzDlKoM90MOyMvjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=J1Ey4bzc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E/uyVOSQ; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 1F0D11C000B7;
	Tue, 20 Feb 2024 03:18:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 20 Feb 2024 03:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708417109; x=1708503509; bh=+COxqRrpOa
	1q8DtKChWbtLiCltNvTLR+rShGMGaFue0=; b=J1Ey4bzcTQfhrh2poaEmtdg3NO
	yWEpM5lif/Ru5N/nQm9SirU0t+ElgAzx7YCbSvETUGWvPuk7bjWWtWFzF5mWmwcZ
	5D0iYApzceWE6H9gyXXRb/xIynEJVSBNjh5VbVZQ5rKX2gTLM6vCignUHime0W61
	jlis/oIwbGTt1SvEqYB0a1HYYksmWX+95XDBuYSxkIa9cLq7wrCOV6XhCRg8jbOq
	kthWB12UaIhzMCRzsu2GXEdTHDUM3pNl7mWaXIoXt6gsmOTaIL5xUpOgUJpfkwPJ
	WHgo0fVBwdGw2ibwsWHNF+0cLsApaUecRWZBwEpTLaZ9W3CitMa+670pmyGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708417109; x=1708503509; bh=+COxqRrpOa1q8DtKChWbtLiCltNv
	TLR+rShGMGaFue0=; b=E/uyVOSQTUds7hg6U+jyZcQgnxCrD2d0p9WOMGvNPE9H
	O41laAgFsyWNm2aSIzusG4IJXvTJTnekTR7wB/NOyvprtHMGtdUW82nRiZj+h9Td
	DQTgw6zJ5ye/E55HCOy2pMkz4o/1QOYX7pScE31RtqGwEct1+xWrs8tk8ZmE3Qbf
	tByppmx+sWiD9EMWeZhG8XGG4DcIoOdEWw/aUxr5hNKNP1WUov09afr3Webqq47r
	EF+ooIqX5RvVqe2JSvs8O3mKH/d5KFGLe1+cYmhHEl20aaQWJX5DMfxndFO57DMu
	GysMX9KoW1r+LJaFfxlxSRVLFNP28RE9AVxvBipZGA==
X-ME-Sender: <xms:VWDUZR5I1JsIEzHUdqK-Tp-IZudJk45H5jgVTxPq7Nha2G8nMuJS6A>
    <xme:VWDUZe7Ey9lZ8n2pSLD_idl03e0NaZcIylhmHAT-uuyRwvp3iSYtm8JjX8ncje8SW
    uaWQseg-oVd2Q>
X-ME-Received: <xmr:VWDUZYcFebVhWHe7d3RJwBR23njZCC6Jw79ObCsdL7iWpgweZ9doOp6_6wvoD-aGsYMq2zJZLzt1x5emDViRHBKTCoyS19JQ7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:VWDUZaIQ1m7_RB_TKse0Sau2EaU5l_sYjVCk6sfnfmnAp596Tb2BTg>
    <xmx:VWDUZVJlspFJAeFO5pwnwITeHhTpRk83LZzeNDdvqxt_D2Ga6_O6rg>
    <xmx:VWDUZTxse1SAVkSGIHe4_D3t_paa-WjKE6DuAS2PnTrfU1cY49tzQQ>
    <xmx:VWDUZXh1wpv0fbygKY3oGiaT3eMqnbPU3AGKZL7PRqeChkXE9ZTokmEVNBM>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 03:18:28 -0500 (EST)
Date: Tue, 20 Feb 2024 09:18:27 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the regulator tree
Message-ID: <2024022016-unmanned-devouring-603c@gregkh>
References: <20240220143142.540fe132@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220143142.540fe132@canb.auug.org.au>

On Tue, Feb 20, 2024 at 02:31:42PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
> 
> between commit:
> 
>   ec29a4d9b7c7 ("dt-bindings: regulator: qcom,usb-vbus-regulator: Add PM6150 compatible")
> 
> from the regulator tree and commit:
> 
>   ef6035d2f1f4 ("dt-bindings: regulator: qcom,usb-vbus-regulator: add support for PMI632")
> 
> from the usb tree.
> 
> I fixed it up (I have no idea if this is correct - see below) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

Looks correct, thanks!

greg k-h

