Return-Path: <linux-kernel+bounces-84281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7D586A488
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AEA1F23A74
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF49EBB;
	Wed, 28 Feb 2024 00:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="U6p2glzx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cDdZIMye"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9845FA29
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709080912; cv=none; b=RIIRESCDb9uN6YurPBx7n/hvM/pI9DITk4yFJ08PDZWm7fe+aoGwBEwwPMbvnXVeIDPHh4HbRrRig/jk3yH/G9+GQOE/vXOcMJTJ3hcNXkk7AQUPQ9yKhPuZoYKndM+cSTWTheA4Tmo7xW12x+NK9nm1nuaT4Zp1Et/6mgZCvIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709080912; c=relaxed/simple;
	bh=uvPzc7bb6ZukcCQyicPCB5FPrObLt4fqmoj5lLiVrhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZ7RY/jobVMCaZ/y6vE3y/guwYsHwzOL5C9tiGx/jDZlPyl8XCAMUitsq4iCLPg9wYHFe15lpIG/yXcHoa/z4lZqVp0Dk/Ktqbhyr4h+DZHBetUvPi+XbztzsMQYgh+v1hYvJC7r2AUkJoNqsAHMTjuIjO0F3+R2+aizfvfMitM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=U6p2glzx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cDdZIMye; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 93A025C00C1;
	Tue, 27 Feb 2024 19:41:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 27 Feb 2024 19:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1709080908; x=
	1709167308; bh=VUViz7u7gfm0YiAV3AIRkcwATKbvLRy2xU8f9D5/5yM=; b=U
	6p2glzxmUEdUh4YrymU7mmmUVocvbGrPDDiZwE2n4Q3cexuN4C3exWi1Mh9MlPU7
	MRbsjI1NHPtMq3aqs2MCugBYWTcRI7S7MwUPrQLgNewKg2DkZ1znASInIOiJkLOS
	rnuaKRANNvPkUP0fHta5GmBjVGoCGitB/B5ykDOnglJoXCi/KVb3LSezIGh4QD12
	cNsfk2GcQEnj+hFthlQBr1U0iFowf6kuN354udcMkGhYc2oR6bCFyJv9MiPJY0PP
	Ta4IV/d81dR5E90cqVDTxxBXvwaDQmdx8cCeBN6iop3qva6GKuW9jtiZtav4r7t0
	j1+AQUUMO/7rjcEhliKPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709080908; x=1709167308; bh=VUViz7u7gfm0YiAV3AIRkcwATKbv
	LRy2xU8f9D5/5yM=; b=cDdZIMyeNpXC+zRHxPN9M8sQpikxltOBtbV1N34hBGJw
	K2UJ33hjmP3X4KWzZ2l52hV6YqkjaqiEqIVTT+tVswDTeceJ8cz/kw0YKx0FYAzm
	R8H4ENuY+4Px2aYUvST/J7j/xEEZVaMeq0YOG8jA4rk4m4SaVVGgCKwtP1B84+Hq
	zHipjIYnc5uZQlhcC3su3LdJ+Qk/lDD+lFIyJNnX5759FceRzD8vQd20zMWlFjTH
	sr5m3BiLcPwzepcT08xs7+lD6h7FEDLSQe01r2V+7Bkpi7nCYmOT986TVZprDBlN
	cTAf+w4w8Eio0EQMS6CbHgFlKmNfmE0Qog7Wwv2Fhg==
X-ME-Sender: <xms:TIHeZQkh6n2WafZYxlQ6s5m2JqmgD--BSkyMnapLO7LDRU0AeLrW9w>
    <xme:TIHeZf1CoIAr1kDFJB5bjYkDnoV6_yXAc2vchXzR2yNmXpckwmwF_9Vv6sFukpwoz
    8czC0400bDY0EPjNOc>
X-ME-Received: <xmr:TIHeZeorCN8WxYE0CW7FlkRcWEgPT1UmCkSd9P0i5Vj94vnyHIG6DJ8Wwrz4LV6TVaCSpNvocUS1bJufV-ic2aTaldCvBGrepA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeeigddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfhfgggtuggj
    sehttdertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqd
    htrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeej
    hffhgeeutefhfeeugfeggeduhfekffduhffhheekhfdtveefhfejjefftdfgjeenucffoh
    hmrghinhepshhouhhrtggvfhhorhhgvgdrnhgvthenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttg
    hhihdrjhhp
X-ME-Proxy: <xmx:TIHeZclaivrRWFDYnhQMbGUJB4Tf0xSnNT-fOQoUeE09CyYlRR9OcQ>
    <xmx:TIHeZe0BCTZovytQUYHpnI1JJMdQBe9NKhW4BE2U7oJI-9Syro_yog>
    <xmx:TIHeZTtc8-ZwjWJyIdAgz8LTKrrpl8PLbn43IRIueVoKRjOQa2R9-Q>
    <xmx:TIHeZT-WnEvm9kLwWbE9AJyLfx_GFjRYkBCQ6oui8YOTn-kj9hC4SQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 19:41:47 -0500 (EST)
Date: Wed, 28 Feb 2024 09:41:44 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Adam Goldman <adamg@pobox.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: use long bus reset on gap count error
Message-ID: <20240228004144.GA72391@workstation.local>
Mail-Followup-To: Adam Goldman <adamg@pobox.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <ZdxH-mjmd09jmYZN@iguana.24-8.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdxH-mjmd09jmYZN@iguana.24-8.net>

Hi Adam,

Thanks for your effort and the patch. I would like to send it to upstream,
while found some nitpicks.

On Mon, Feb 26, 2024 at 12:12:42AM -0800, Adam Goldman wrote:
> From: Adam Goldman <adamg@pobox.com>
> 
> When resetting the bus after a gap count error, use a long rather than 
> short bus reset.
> 
> IEEE 1394-1995 uses only long bus resets. IEEE 1394a adds the option of 
> short bus resets. When video or audio transmision is in progress and a 
> device is hot-plugged elsewhere on the bus, the resulting bus reset can 
> cause video frame drops or audio dropouts. Short bus resets reduce or 
> eliminate this problem. Accordingly, short bus resets are almost always 
> preferred.
> 
> However, on a mixed 1394/1394a bus, a short bus reset can trigger an 
> immediate additional bus reset. This double bus reset can be interpreted 
> differently by different nodes on the bus, resulting in an inconsistent gap 
> count after the bus reset. An inconsistent gap count will cause another bus 
> reset, leading to a neverending bus reset loop. This only happens for some 
> bus topologies, not for all mixed 1394/1394a buses.
> 
> By instead sending a long bus reset after a gap count inconsistency, we 
> avoid the doubled bus reset, restoring the bus to normal operation.
> 
> Signed-off-by: Adam Goldman <adamg@pobox.com>
> Link: https://sourceforge.net/p/linux1394/mailman/message/58741624/
> ---
> 
> --- linux-6.8-rc1.orig/drivers/firewire/core-card.c	2024-01-21 14:11:32.000000000 -0800
> +++ linux-6.8-rc1/drivers/firewire/core-card.c	2024-02-12 01:16:15.000000000 -0800
> @@ -484,7 +484,17 @@
>  		fw_notice(card, "phy config: new root=%x, gap_count=%d\n",
>  			  new_root_id, gap_count);
>  		fw_send_phy_config(card, new_root_id, generation, gap_count);
> -		reset_bus(card, true);
> +		/*
> +		 * Where possible, use a short bus reset to minimize
> +		 * disruption to isochronous transfers. But in the event
> +		 * of a gap count inconsistency, use a long bus reset. On
> +		 * a mixed 1394/1394a bus, a short bus reset can get
> +		 * doubled. Some nodes may treat this as one bus reset and
> +		 * others may treat it as two, causing a gap count
> +		 * inconsistency again. Using a long bus reset prevents
> +		 * this.
> +		 */
> +		reset_bus(card, card->gap_count != 0);
>  		/* Will allocate broadcast channel after the reset. */
>  		goto out;
>  	}

In your report, you referred to the section of 1394 specification about a
mixed 1394/1394a bus responding differently to a reset (8.4.6.2). I think
it preferable to add the section number in the code comment.

Additionally, for your investigation, you added the debug print to get the
timing of bus reset scheduling. I think it useful for this kind of issue.
Would I ask you to write another patch to add it? In my opinion, the case
of mixed versions of 1394 PHYs in the same bus has more quirks and the
debug print is helpful to investigate it further.

And I'm sorry to be helpless to your work. I have some IEEE 1394 hardware
for consumer audio equipments, but the most of them is relatively new and
support 1394a already...


Thanks

Takashi Sakamoto

