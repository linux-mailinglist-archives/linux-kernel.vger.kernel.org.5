Return-Path: <linux-kernel+bounces-38079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D2B83BAC1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B51CB24D96
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C169112E42;
	Thu, 25 Jan 2024 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udGMN9yU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF60F125D7;
	Thu, 25 Jan 2024 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168216; cv=none; b=KgKcDeZ2g1MOvs+PW7AeqovtMR+5aPKn//ASd7OmZ3kVhNcriGB5uRe/juHS45d9BLI0DkhzztD/gA+ejQOEKH+mc6BOLBsJBX+DkhRGuoPaRK5EY5QMT+Q+AGn21H71Br8cNsYoHvacmcn5QlQm05qnA6ZjYnPx05pfetw3BKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168216; c=relaxed/simple;
	bh=Q0JfeFCfMgWrfWnzoium/IVe2Po+3kpp7VAaqloEz1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxam6yaYXeYmaPPKAU4FJT47p2dUEvtAWhbqDwfTUqemIyn3T0riMnG+BSEZiHjwpovZDjIFZ1slEoMezGtmX0m3T6QTzgrSV97BuOFWtCJqopF5oNOwcq0iYIXgMo7OU+ZtwH615Sr+Mxg526mxqc3saEkWLFH3aWS99qXUREM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udGMN9yU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7012AC433F1;
	Thu, 25 Jan 2024 07:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706168215;
	bh=Q0JfeFCfMgWrfWnzoium/IVe2Po+3kpp7VAaqloEz1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=udGMN9yUHMrxmaVOhoVNPCuuuvuWNxMNgTYMLtmrJz/NohKEw40gPBGRhBk/o8z66
	 SunP1i24pgaoednuaG5F0URxtAEbFYmKrN7DQxL/d6lRtm2lJ73Tthj4pKgcfmHWi3
	 AdnAQPY1/9hH3bJlR/zHWLCX+L3FVD0dNnpDdW/SYjNEMPpDH90yd7ulOM3KkkpOq6
	 SE+jiunstsmfRYgX6YIB7AzVU0H9FoJ78OeMZwt21R/vpFuYIhv8uw988w0ER9Y5UK
	 BP7El39bEffgeKuj8WbQKV3dMX8XgshWr87G5PEh+J/T5P1vqAWS8Qp4MJVvujaz2A
	 fuQDuh1Cn24UA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rSuIL-000000005sx-1MRL;
	Thu, 25 Jan 2024 08:37:05 +0100
Date: Thu, 25 Jan 2024 08:37:05 +0100
From: Johan Hovold <johan@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, greybus-dev@lists.linaro.org,
	linux-iio@vger.kernel.org, netdev@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Alex Elder <elder@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lee Jones <lee@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, Rob Herring <robh@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] treewide, serdev: change receive_buf() return type to
 size_t
Message-ID: <ZbIPoW2LKXJVz3oV@hovoldconsulting.com>
References: <20240122180551.34429-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122180551.34429-1-francesco@dolcini.it>

On Mon, Jan 22, 2024 at 07:05:51PM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> receive_buf() is called from ttyport_receive_buf() that expects values
> ">= 0" from serdev_controller_receive_buf(), change its return type from
> ssize_t to size_t.
> 
> The need for this clean-up was noticed while fixing a warning, see
> commit 94d053942544 ("Bluetooth: btnxpuart: fix recv_buf() return value").
> Changing the callback prototype to return an unsigned seems the best way
> to document the API and ensure that is properly used.
> 
> GNSS drivers implementation of serdev receive_buf() callback return
> directly the return value of gnss_insert_raw(). gnss_insert_raw()
> returns a signed int, however this is not an issue since the value
> returned is always positive, because of the kfifo_in() implementation.
> gnss_insert_raw() could be changed to return also an unsigned, however
> this is not implemented here as request by the GNSS maintainer Johan
> Hovold.
> 
> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> Link: https://lore.kernel.org/all/087be419-ec6b-47ad-851a-5e1e3ea5cfcc@kernel.org/
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> #for-iio
> ---
> v1:
>  - https://lore.kernel.org/all/20231214170146.641783-1-francesco@dolcini.it/
> v2:
>  - rebased on 6.8-rc1
>  - add acked-by Jonathan
>  - do not change gnss_insert_raw()
>  - do not change the code style of the gnss code
>  - commit message improvements, explain the reasons for doing only minimal
>    changes on the GNSS part

Looks good to me now:

Reviewed-by: Johan Hovold <johan@kernel.org>

