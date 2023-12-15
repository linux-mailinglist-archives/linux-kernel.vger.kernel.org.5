Return-Path: <linux-kernel+bounces-1042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C448149A5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A493A1C23C99
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CDB2F869;
	Fri, 15 Dec 2023 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrD3v8Uq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE7E30331;
	Fri, 15 Dec 2023 13:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FD5C433C8;
	Fri, 15 Dec 2023 13:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702648274;
	bh=fGVG2zzj6pzT9iK1XgpYVOHwKem4iYVgV0aQbGa3PGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QrD3v8UqIFJxXc8j8eX/CL6QTSLzOHhDiSwHp1PPIg0IgjFyfhPvDkpxkaU+/RBt9
	 pbPQJxIF1XT6/JEDiB62ZRM44tdT/NAo6XoxYMsQBRdnFli6zltKudD0JztCu2hTpl
	 R4OpNg1SM+eZ8POSKlPEF+hWE59by9BSJV/a0STDPDpuWWUreHwOKPdzGiX4MlAYxQ
	 DB+SiNrVDI2Eg8PoHglS7AnpTVSToUu5NywltYb11B+w8qTk71L9A88NbRCy3TE75l
	 uYQo4VY/TjtulP/w6nGpMkKMabcwEvSQd/7QSd4gI5gC1z63tyVogjQ/MHq3cakhKn
	 O65yCtrhcFQpA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rE8ar-0008Sk-1T;
	Fri, 15 Dec 2023 14:51:09 +0100
Date: Fri, 15 Dec 2023 14:51:09 +0100
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
Message-ID: <ZXxZzd1iBOCmnczH@hovoldconsulting.com>
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
> hello,
> patch is based on current linux next.
> 
> It has an obvious problem, it touches files from multiple subsystem in a single
> patch that is complicated to review and eventually merge, just splitting this
> would however not work, it will break bisectability and the build.
> 
> I am looking for advise on the best way to move forward.
> 
> I see the following options:
>  - keep it as it is
>  - break it down with a patch with each subsystem, and squash before applying
>    from a single (tty?) subsystem
>  - go for a multi stage approach, defining a new callback, move to it and in
>    the end remove the original one, likewise it was done for i2c lately
> 
> ---
>  drivers/bluetooth/btmtkuart.c              |  4 ++--
>  drivers/bluetooth/btnxpuart.c              |  4 ++--

> diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
> index 3c84fcbda01a..e6bc4a73c9fc 100644
> --- a/drivers/bluetooth/btmtkuart.c
> +++ b/drivers/bluetooth/btmtkuart.c
> @@ -383,8 +383,8 @@ static void btmtkuart_recv(struct hci_dev *hdev, const u8 *data, size_t count)
>  	}
>  }
>  
> -static ssize_t btmtkuart_receive_buf(struct serdev_device *serdev,
> -				     const u8 *data, size_t count)
> +static size_t btmtkuart_receive_buf(struct serdev_device *serdev,
> +				    const u8 *data, size_t count)
>  {
>  	struct btmtkuart_dev *bdev = serdev_device_get_drvdata(serdev);
>  
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
> index 1d592ac413d1..056bef5b2919 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1264,8 +1264,8 @@ static const struct h4_recv_pkt nxp_recv_pkts[] = {
>  	{ NXP_RECV_FW_REQ_V3,   .recv = nxp_recv_fw_req_v3 },
>  };
>  
> -static ssize_t btnxpuart_receive_buf(struct serdev_device *serdev,
> -				     const u8 *data, size_t count)
> +static size_t btnxpuart_receive_buf(struct serdev_device *serdev,
> +				    const u8 *data, size_t count)
>  {
>  	struct btnxpuart_dev *nxpdev = serdev_device_get_drvdata(serdev);

A quick check of just the first two functions here shows that they can
return negative values.

> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> index e94e090cf0a1..3d7ae7fa5018 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -27,19 +27,17 @@ static size_t ttyport_receive_buf(struct tty_port *port, const u8 *cp,
>  {
>  	struct serdev_controller *ctrl = port->client_data;
>  	struct serport *serport = serdev_controller_get_drvdata(ctrl);
> -	int ret;
> +	size_t ret;
>  
>  	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
>  		return 0;
>  
>  	ret = serdev_controller_receive_buf(ctrl, cp, count);
>  
> -	dev_WARN_ONCE(&ctrl->dev, ret < 0 || ret > count,
> -				"receive_buf returns %d (count = %zu)\n",
> +	dev_WARN_ONCE(&ctrl->dev, ret > count,
> +				"receive_buf returns %zu (count = %zu)\n",
>  				ret, count);
> -	if (ret < 0)
> -		return 0;
> -	else if (ret > count)
> +	if (ret > count)
>  		return count;
>  
>  	return ret;

So please do not apply this patch until the various implementations have
been fixed.

Johan

