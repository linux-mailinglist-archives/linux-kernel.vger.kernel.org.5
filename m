Return-Path: <linux-kernel+bounces-118356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2800B88B964
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51921B234D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9929012A17F;
	Tue, 26 Mar 2024 04:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="d0XGAgRn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ofr96o99"
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6318D21353;
	Tue, 26 Mar 2024 04:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711426789; cv=none; b=NaruWN7mWZ5M56mBoVfNcwhaAv7HECyZg5Q4K18wU1tURtrrCUpmKGhYUPyN+tRPRVE029sOQvKX+DQKFhCfotO+4sjZ6Y4D94okHocyJILu+WCBUCsjbocJLpIHDScHDOzgtuwzsbL33twOVnGEOdNe90fSlaQwQpNccBsOFQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711426789; c=relaxed/simple;
	bh=9QLdc2K63VnoKqFkK5mVPbkfNcY0gFA7MHCGI4J+NHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0gIu8sOZLLy+Za0janknr+rYc7BrFxccBY1X7j7rF8/Myua5b9xRKQEC0nKynd3WCy6WbEsxRlSGDScWe7fbN/nD/QICHNzNyByNWDCEO9JQN96iQW/5njZWKv5bBzacbnMLFo0DqKYpa6PISTopm7lc11j9sXmsFV4hUTKm1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=d0XGAgRn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ofr96o99; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 30BAF18000B9;
	Tue, 26 Mar 2024 00:19:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 26 Mar 2024 00:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1711426785; x=
	1711513185; bh=TT6J81xAiZUuDsQWd9ABaj4hlEzDlXvyJDw3uKeZE4E=; b=d
	0XGAgRnUX/SpXskLPOgDm46idTKhNSW8mQ2EmXy2f7AvQ9tZfPAsWymBmn+QlEE2
	IllDpgcXbQnRffR/mu+3MYRSET+8MnkFeemg+C5gye6XCQWSulycctKArNLyqCKs
	8dvpsAmxoUDTyCu14m91Hg6MNPol6wiAEtx8d+LbdXY5Z+oqpxACtiLx2GqpV9r6
	6d3DRkGrhrtnzE3WnkdXaIvyifhoEKPw0qM3F6QP/iloPNHx58ISuj/48FCnnNQi
	u/3S1rzeOWJP7LjcOlAeHzs4PCntdxSfiV2fRXydicX95jonnFDvjZ6VlgtR6tFH
	ocJmE/d2DFux0I+HdR8uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711426785; x=1711513185; bh=TT6J81xAiZUuDsQWd9ABaj4hlEzD
	lXvyJDw3uKeZE4E=; b=ofr96o99qsHLVlNXCAZyd3LU9JEseKIHMv7eC1RMVS5e
	+EDWxzZmh4NB0MUFJGQa6n4npCwoUMr01D8ZOT9reorLlV2NAPPemkiR4SiNLTvF
	LT1V89Q+Krpu1+eOmxwqeIuNrX9dHVTyMOat7hMDvBjiiN+SpKdpMhebtZywy98G
	CW5e7mBoP4SY6VU8OJdpwgyyNhW/cGMRfCIXMx4VNdy6EGWT3ufgpWtsQMs9aCRz
	ZZ3Hbi7VK/1A1Ga7Sd93PZcGkTTQvMdZpbXYUBfWXQYQW5m04GGALYbkqHXf9Efs
	Z65ssIdOaQ2iSuMpru1qoiNeb3z9CUWck61fODzA1w==
X-ME-Sender: <xms:4UwCZpLouFRNYiqnuik4b8ks8DGZvnV5SSgWbgAYdGE77YEEV0s9hA>
    <xme:4UwCZlJOPH70pxL2W7jnwK__AVLHzTSIru2VmRF_qJHhj6cZr1hAoQJoOHYspHohA
    7X81hQwH8KAn-1N95o>
X-ME-Received: <xmr:4UwCZhtdAzVCwGdyE17zaS6S51tEBDy4OLfZ1rYUo1PWxA6YT70S7vfN4JFCU3WudMqqqsZ2DV69nDJJIMKw0svvuGEn9uXrtfE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeehhffhte
    etgfekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeuudekueenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:4UwCZqZS3Bsf3gJXHTUAAcM2EFJmSQqX8v5ISEe09pSzQrdZy7ytUQ>
    <xmx:4UwCZgYZXDCq7mZWssSno2bRh5rQdTjvXGl9C_LO_qo8-lzdWY2msw>
    <xmx:4UwCZuCnIBy3BLF5laZAarIUQP9JCoODXlMx6e5kVAOSq3rOMNau6A>
    <xmx:4UwCZuZL2MWXrAmZENCG02s5Fn7wS_rafueOlLLdf6T1oVbla-h3gQ>
    <xmx:4UwCZvwiOrat0zjOe76hS0XwESBBaFtDMCFuOCgIu1FHottTWZ-wrxt6Pw0>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 00:19:43 -0400 (EDT)
Date: Tue, 26 Mar 2024 13:19:41 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] firewire: Annotate struct fw_iso_packet with
 __counted_by()
Message-ID: <20240326041941.GA122990@workstation.local>
Mail-Followup-To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
References: <ZgIrOuR3JI/jzqoH@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgIrOuR3JI/jzqoH@neat>

Hi,

On Mon, Mar 25, 2024 at 07:56:10PM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  include/linux/firewire.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-next branch, since it demands no code changes to the other
subsystem.


Thanks

Takashi Sakamoto

