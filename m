Return-Path: <linux-kernel+bounces-1026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912E481496F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18CE1B224E3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6212E40A;
	Fri, 15 Dec 2023 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tud6o92I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889CB2DB85;
	Fri, 15 Dec 2023 13:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C1FC433C8;
	Fri, 15 Dec 2023 13:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702647397;
	bh=subHRTKMwmMr0u+Qf2RNzCSmCaDcHEzfdzarxtD8z/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tud6o92I0jvVdrQ08FGKjdwhC80aUmMEmOH08YZYA7JMT2nqm5k4KKn6vBcUbxJjP
	 VmpYMMCDc/VLLrETSfv2FpWhSRRti1nAMypE+MNbCK/UR8mamGdHErStfqAZXkgaKC
	 qBv5XaksNxAOX6jipIaq1IbmkhKayDCxE6KAcyXAv3QSDdh51sfDh1IcgQiy2tAttY
	 WXgcpMVNiCj3RxJHmQEXR/hTQbtqjFGwwlG5b3BHtjTFBOyuVjwGH1S6sM6UqultwY
	 zXpxq3Nw1vqu3UFHQsvlUnunnipIRRlxvKbgttSUVa1ufg21iJkPpOgtx6sbhdvg9A
	 kjq2BdKV10YQg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rE8Mh-0008LA-2Z;
	Fri, 15 Dec 2023 14:36:31 +0100
Date: Fri, 15 Dec 2023 14:36:31 +0100
From: Johan Hovold <johan@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-bluetooth@vger.kernel.org,
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
	Tzung-Bi Shih <tzungbi@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1] treewide, serdev: change receive_buf() return type to
 size_t
Message-ID: <ZXxWX-Fw1InID2ax@hovoldconsulting.com>
References: <20231214170146.641783-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214170146.641783-1-francesco@dolcini.it>

On Thu, Dec 14, 2023 at 06:01:46PM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> receive_buf() is called from ttyport_receive_buf() that expects values
> ">= 0" from serdev_controller_receive_buf(), change its return type from
> ssize_t to size_t.
> 
> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> Link: https://lore.kernel.org/all/087be419-ec6b-47ad-851a-5e1e3ea5cfcc@kernel.org/
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  drivers/gnss/core.c                        |  6 +++---
>  drivers/gnss/serial.c                      |  4 ++--
>  drivers/gnss/sirf.c                        |  6 +++---

> diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
> index 48f2ee0f78c4..9b8a0605ec76 100644
> --- a/drivers/gnss/core.c
> +++ b/drivers/gnss/core.c
> @@ -317,10 +317,10 @@ EXPORT_SYMBOL_GPL(gnss_deregister_device);
>   *
>   * Must not be called for a closed device.
>   */
> -int gnss_insert_raw(struct gnss_device *gdev, const unsigned char *buf,
> -				size_t count)
> +size_t gnss_insert_raw(struct gnss_device *gdev, const unsigned char *buf,
> +		       size_t count)
>  {
> -	int ret;
> +	size_t ret;
>  
>  	ret = kfifo_in(&gdev->read_fifo, buf, count);
>  

Why are you changing this function? This is part of the GNSS interface
and has nothing to do with the rest of this patch.

Greg, please drop this one again until this has been resolved.

Johan

