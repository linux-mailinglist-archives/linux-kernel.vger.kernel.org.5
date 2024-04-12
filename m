Return-Path: <linux-kernel+bounces-142188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA718A289E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CCBF1F225BD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AFB4E1D1;
	Fri, 12 Apr 2024 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="oUfvOicy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KLXxa4pl"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084F94D9F4;
	Fri, 12 Apr 2024 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908738; cv=none; b=N4N8cjmdQ1Gt3D5/DfVIrmSD60kXL0lbFp18oTbavdpKhs/BTH0ef5qvFhJv3zs2dwqzhSFRxVREJ8bWbZ+FydFm+cKI5qD8beJEjlvVxtZKuj9ONPkuUx3x7o3B0ncvBuGqgtT/BwtOd97R0GOQ9NZrV6B4ChK+aeeuWlRIJ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908738; c=relaxed/simple;
	bh=lmVnj/emWhVKwKCtmjKZRdhyHpBtd8H9cYECpX359ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXBnaEpZRJ30HzVucJsVO+yfxZShyyBq7FHMz6FMH4ITloud8vvu6J+GjHqLBA4hordrUAE4VEVCNknRoLIM1vw2/yXlUeXAauatxURxFXT2MAkfMIVQ/iF09sWgXwcb5OMIRCMDp0z7JLMjQ86GuXHAA5Hks5RO9Hq081WS1mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=oUfvOicy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KLXxa4pl; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1C28813802B1;
	Fri, 12 Apr 2024 03:58:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 12 Apr 2024 03:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712908735; x=1712995135; bh=s31rwbj8SN
	Bg4iN0/PPWZvrHHKOJYGRuoenfpsDBgto=; b=oUfvOicy7kexQHgq7JWRDtgeQ7
	rHw4DsCF4ji5rviHM1EDbSsmWQH7G2vJBx+KZbUAldiK/YDxZX4bMCl1pJhiN83z
	nDDfiy1zXM3EremULKvCdFTqSNd2VSh4by9JxG9YAzNRoBMfk28nGAjQdcJj6ma0
	ZzERQyFuesNCppMxpqDpkl4zxtIo0lOTxliSb0kOTl1RcKWcKTTDSHmOdU2zOv2G
	Iql8gAQQYIiCzgryMPWP4U3y2xJV8fnTRgfxI+9BkMuuQZcndtqo24SpdrR3PfBp
	UupMmOwSgeE2NtVaEsXzs9qYXnKLpffqZctwqFuA1tHBS1S+SZI5pDH20FkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712908735; x=1712995135; bh=s31rwbj8SNBg4iN0/PPWZvrHHKOJ
	YGRuoenfpsDBgto=; b=KLXxa4plzc/U5gbE57bVpuYdYtxYxHS03X01SRup9CBc
	oyTkh0/2dVvM6MugA6VRFd/mVq95vH7UovLY/ipNb6LpR+QUoL/Qy/5wEgBNGHJy
	dr4DuYW0+mbi5qAPm7vYPtYqDbuPMDmBWothllFriMJTOBHlDLmSqTajVOrXVSC9
	VHa6E4jE4o/FlOp+Y5rTVVJud5ItjcM3sxFbca+8FbBuWU+JjtDF5cgwgPKeSiTN
	D2W45HZ+GdVY1Ec7pYle3t7t/lZANsi2MFeY6A2ibi1PLPPhVn5XlnATt6llm8tF
	0EE5FJy/moPIHkVJhmndVqJl32fYn6h2iXWCFbCrdQ==
X-ME-Sender: <xms:vukYZsU0jeI1slJuUqvwdT8MNsnl2Hz91F1T1-XT_jgZWHAyw9Ed-Q>
    <xme:vukYZgmSGhdDcUvDsW0k43BPZg0N_dii5gTQvGkYFzRHhIBQfUvWZolqzK1EUkmSm
    TfzTmRzHxaLkg>
X-ME-Received: <xmr:vukYZgacMBviOUY1NFACLxQ-uybJhwncj9Yk7HpgQm3azGljQ3enL2ym9PsIaS05o6W_AkEhY0GAyQeL89_jttUxO3998VZHJR1IZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeitddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:vukYZrU-S47P-G5whlvP8vtnLYAa9wcbxiU-XdPVYsTiEjNA57bSYA>
    <xmx:vukYZmkVgDFXKXHb4PeXoTnImc-4iUX96SUVpCIIe5FwnWcPnAE0OA>
    <xmx:vukYZgcQeHJpt4_KotMmPXEj9I1Ok4M74EtmkeW7IsGJWlw626I-xA>
    <xmx:vukYZoGulublib9wY4My3LJJgB-f0urpdh2PyJzjgro0lddUpPuGzQ>
    <xmx:v-kYZvfTqjUFQYiGBXNpLtzZXi9UToZss17bRSTry1vUen3YcM_XkT0B>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Apr 2024 03:58:54 -0400 (EDT)
Date: Fri, 12 Apr 2024 09:58:52 +0200
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Fabio Estevam <festevam@denx.de>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <2024041230-slaw-subsiding-9e85@gregkh>
References: <20240412142547.3598ff68@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412142547.3598ff68@canb.auug.org.au>

On Fri, Apr 12, 2024 at 02:25:47PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   drivers/usb/misc/onboard_usb_hub.c
> 
> between commit:
> 
>   34b990e9bb54 ("usb: misc: onboard_usb_hub: Disable the USB hub clock on failure")
> 
> from the usb.current tree and commit:
> 
>   31e7f6c015d9 ("usb: misc: onboard_hub: rename to onboard_dev")
> 
> from the usb tree.
> 
> I fixed it up (I deleted this file and applied the following patch) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

Thanks, I knew this would happen, I'll apply your fixup when merging the
two branches together.

greg k-h

