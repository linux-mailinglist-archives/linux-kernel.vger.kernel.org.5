Return-Path: <linux-kernel+bounces-108045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF8C88052E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F04BB224C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DB039FD6;
	Tue, 19 Mar 2024 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htL7sS/v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344A13A1A0;
	Tue, 19 Mar 2024 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710874643; cv=none; b=eJxkz4/a8GgqqUJ193G8kOl4h1UxzbMm9ywhnGUtJN1ne8QZ/4PzpG2TrXD2IARpPvaww458hud2GrVKWElOeqhQoTQVMGB15rRro/xQrQUbp2j3ri1uS9QSxz2pCuJmne4AYCct0TTCXiCvEh3oLCC5qEYxNrjoOa0kaMWjORg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710874643; c=relaxed/simple;
	bh=DohZWk5SdjMZAo5MvMKcWFKm/CihtRTRKj5i8fvpu/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6faNXSyfiVl0ehLxzTWhxbkUSI1tQeq6LX6YJtBolyLcim8+Mb2/AEbgU5mvTvwueDEeorKjAFLgrCSOanqty4CWZIK5CHt4KPz7sEHke8Qooc+ixLfb/lmDxnnC/iLXYYA1dD2/Ym8FZDKrWlnWZbeGyDpiDXthDGz8OOFH30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htL7sS/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D0FC433C7;
	Tue, 19 Mar 2024 18:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710874642;
	bh=DohZWk5SdjMZAo5MvMKcWFKm/CihtRTRKj5i8fvpu/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=htL7sS/vHj8iZVyw0dlzwOo2Jwwqt0Vh1gs3NX6alrD/V7o9xavNBnsuqISHfJ4IO
	 VY/dAJVm9DRVsYjRY+7pup1mnlrhHUIHAqAKNIU4tYb3MKgTP/V67X7Xacm3jqfdRw
	 H4WColn29j5lMBALyUbviVFk9ZCtDnDnfBUfwmzLP6Bh5xqtuiA6Y0vL8MqCYnkNFV
	 c6FxrJLK5+vLde9OoHV9x4QKmEwDdqMmEVxrrv6SKmc9pfxHD00qqIaGThhNNdTFjQ
	 +Rc3fL6Q0LSCIotbuvDIvkbXpHfguqqc+zLWR/VzJur2xd3eGrL0dTCWWnSDbOuEFV
	 nKJqbeuM34l9A==
Date: Tue, 19 Mar 2024 18:57:18 +0000
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC kspp-next 3/3] idpf: sprinkle __counted_by{,_le}() in
 the virtchnl2 header
Message-ID: <20240319185718.GO185808@kernel.org>
References: <20240318130354.2713265-1-aleksander.lobakin@intel.com>
 <20240318130354.2713265-4-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318130354.2713265-4-aleksander.lobakin@intel.com>

On Mon, Mar 18, 2024 at 02:03:54PM +0100, Alexander Lobakin wrote:
> Both virtchnl2.h and its consumer idpf_virtchnl.c are very error-prone.
> There are 10 structures with flexible arrays at the end, but 9 of them
> has flex member counter in Little Endian.
> Make the code a bit more robust by applying __counted_by_le() to those
> 9. LE platforms is the main target for this driver, so they would
> receive additional protection.
> While we're here, add __counted_by() to virtchnl2_ptype::proto_id, as
> its counter is `u8` regardless of the Endianness.
> Compile test on x86_64 (LE) didn't reveal any new issues after applying
> the attributes.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Hi Alexander,

with this patch applied ./scripts/kernel-doc -none reports the following.
I think that this means that the kernel-doc needs to be taught
about __counted_by_le (and __counted_by_be).

../virtchnl2.h:559: warning: Excess struct member 'chunks' description in 'virtchnl2_queue_reg_chunks'
../virtchnl2.h:707: warning: Excess struct member 'qinfo' description in 'virtchnl2_config_tx_queues'
../virtchnl2.h:786: warning: Excess struct member 'qinfo' description in 'virtchnl2_config_rx_queues'
../virtchnl2.h:872: warning: Excess struct member 'vchunks' description in 'virtchnl2_vector_chunks'
../virtchnl2.h:916: warning: Excess struct member 'lut' description in 'virtchnl2_rss_lut'
../virtchnl2.h:1108: warning: Excess struct member 'key_flex' description in 'virtchnl2_rss_key'
../virtchnl2.h:1199: warning: Excess struct member 'qv_maps' description in 'virtchnl2_queue_vector_maps'
../virtchnl2.h:1251: warning: Excess struct member 'mac_addr_list' description in 'virtchnl2_mac_addr_list'

..

