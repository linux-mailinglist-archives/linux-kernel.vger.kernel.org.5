Return-Path: <linux-kernel+bounces-80572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939EF8669C2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F77B280F39
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA1B1BC27;
	Mon, 26 Feb 2024 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="pvMVWPlS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TQvYe11i"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122C91B948;
	Mon, 26 Feb 2024 05:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708926918; cv=none; b=Jd+84pNgf41f5vjxjgNxC7hJVgwdqcIwUuuAT6xC4RHUkfksAz1pdDxQNHlJIvnqXJSdsrQ2G4srWnj46Pgpd5W1rK1RUrOVY+j69iTG/axr8NUONoTmF+iWiq0+U47UUc5yoLjcCqSHB1xplSZdlQCuVDKpIGpGLshpW9zr22M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708926918; c=relaxed/simple;
	bh=fy6n2B11bj8BHwmPda9oPPtrOuLCPxKAdjF5V8vy9iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXthfRnUWG+HHoEQF9KajpNUQbgX+by1b58knss/kkTOrE/MPfW/EcRZcyafEjEcetPjdkQ8FYM/cE7alsVHtsaocgdHvhZhVO+RbW44IOVQBR2IZryuLyI7Xf5h4/IE6JeR0NvkeZutLTV1WN6MQLelCrmT2CVMScuae2W6iuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=pvMVWPlS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TQvYe11i; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 44C791800070;
	Mon, 26 Feb 2024 00:55:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 26 Feb 2024 00:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708926913; x=1709013313; bh=iRvmjiltPE
	gYqexys6lGrcGkVv1cgy6XWRPUSaQKs6M=; b=pvMVWPlSxhCVYoZTOkKeGeuXdd
	ZuYeZhnOMweHpDtsqjX08OzV1/Riew0qoEk1YV8kacWPpP8SNZFcfpPAtp6m2wz5
	zlb4sCMZDZpHbsGuyopOBOCKx63k00HJP+0Tk0s6jCE1iOCLwN9pVVTzw82mpUbs
	TQShXqx4EKeEeRtKInDruypRjuR0od9wOqvXN8K7UjyrecrArrmWAe43XLemr3/4
	8CfwUUmxjG2W+lFaxCuQWIf5v8EZqUOFMPVslqxmBbLqIwPT2VVzsN2/ECb5jv35
	r6uKowb4lAW5zldYHpu++GHBo6zTZVse3p+HBDrFQJVeuvHwmBEffQfaK+5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708926913; x=1709013313; bh=iRvmjiltPEgYqexys6lGrcGkVv1c
	gy6XWRPUSaQKs6M=; b=TQvYe11ib1w8pP+1JIxHgni9Gsu375reIHKeyo900mXl
	JqKLw7IkvzEnWjGfX+/Bh+HhtxeuTh9St1JBiAj6nFYu8+ljUG/7oMgISIETfWC2
	ZQa0PEIGJGYZmRK15SWgu/tcPGTFn8krA766machdIk+3qS300jX0MTasIXunGSf
	TyrshNDOl1VyQX3wweuBzxhXGT6B18L2h52KQPnu7wvGTI7R8GrGzsRC4WXhiTor
	HWtjIfGw0hJIo71sck8B0yjncejC1ykotDzmjazhlE5cFoZaPnYeOQtyJPtQr72g
	TAEW0uJa0eQcg53DxVS958PkpoYlOyCDeMGHbanmHw==
X-ME-Sender: <xms:wSfcZZccd1y-qSjGl_mjXVlwija4U8WgzE9fXt002GFUbAvnTWUeNA>
    <xme:wSfcZXPykPfJDkK-zrF0v_z18-aTIwHNAKmn5cBpeVScSx4vyzB62s1JQTlK7yphJ
    yxeq-94IqID8Q>
X-ME-Received: <xmr:wSfcZSjl7tX-1C_MhPJ7I5ZkUNXYOYaf6kyn0YCq-VcUk_auFWS5pAlJFqRlbqS3_7KdZFHFLtMhhhtQvNxj-1wx5u4RDQf8_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedugdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:wSfcZS_uXO7tmwFHecMBfZFRDs44y081I88ZHrAYajKePc07hjhr4g>
    <xmx:wSfcZVtoJ438ur761tsYW-ijuLFV_rYqwL-UBpY_K4ctzOwD5gpbHw>
    <xmx:wSfcZRHNUyBzB6P_EKUvfjUvyeRFcMjIaV4G3HIFwMUjmHrUo5PjEQ>
    <xmx:wSfcZWnHdB9m7cgrouOv3WEhUViLusod75lkLcPXgb21HT0W3HCNH8ZcoYo>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Feb 2024 00:55:12 -0500 (EST)
Date: Mon, 26 Feb 2024 06:55:10 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <2024022655-dweller-shining-fc54@gregkh>
References: <20240220143919.40257e7b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220143919.40257e7b@canb.auug.org.au>

On Tue, Feb 20, 2024 at 02:39:19PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   drivers/usb/roles/class.c
> 
> between commit:
> 
>   b787a3e78175 ("usb: roles: don't get/set_role() when usb_role_switch is unregistered")
> 
> from the usb.current tree and commit:
> 
>   9a270ec7bfb0 ("usb: roles: Link the switch to its connector")
> 
> from the usb tree.
> 
> I fixed it up (I think - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Should now be fixed up in my usb-next branch, thanks!

greg k-h

