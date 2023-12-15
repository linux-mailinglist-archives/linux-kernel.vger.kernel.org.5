Return-Path: <linux-kernel+bounces-1087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A30814A23
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462C21C236DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9733033D;
	Fri, 15 Dec 2023 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H6hwq92X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ECC30641;
	Fri, 15 Dec 2023 14:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A407C433C7;
	Fri, 15 Dec 2023 14:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702649515;
	bh=xcqVasPR7/6/BGkmp20d/mwFZY/qYeQV954kXhulne0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6hwq92XJhZCx8YzkUspQ2BH8/Bmyvmss0bwdDEeI685r5m21J29uMKmzEeKRlHGf
	 gFtB8lAkg2zQd+t/qN4A5hvSsaF9WE8iyeEfKkXx0TQFMfFJwajt9rs2jMLAA5UQ2Q
	 ttSYSzrZbXILZ1muKg4Fnpy5jIEyvmZtvtb8oCHY=
Date: Fri, 15 Dec 2023 15:11:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
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
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1] treewide, serdev: change receive_buf() return type to
 size_t
Message-ID: <2023121544-hastiness-unhinge-b8d3@gregkh>
References: <20231214170146.641783-1-francesco@dolcini.it>
 <ZXxWX-Fw1InID2ax@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXxWX-Fw1InID2ax@hovoldconsulting.com>

On Fri, Dec 15, 2023 at 02:36:31PM +0100, Johan Hovold wrote:
> On Thu, Dec 14, 2023 at 06:01:46PM +0100, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > receive_buf() is called from ttyport_receive_buf() that expects values
> > ">= 0" from serdev_controller_receive_buf(), change its return type from
> > ssize_t to size_t.
> > 
> > Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> > Link: https://lore.kernel.org/all/087be419-ec6b-47ad-851a-5e1e3ea5cfcc@kernel.org/
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >  drivers/gnss/core.c                        |  6 +++---
> >  drivers/gnss/serial.c                      |  4 ++--
> >  drivers/gnss/sirf.c                        |  6 +++---
> 
> > diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
> > index 48f2ee0f78c4..9b8a0605ec76 100644
> > --- a/drivers/gnss/core.c
> > +++ b/drivers/gnss/core.c
> > @@ -317,10 +317,10 @@ EXPORT_SYMBOL_GPL(gnss_deregister_device);
> >   *
> >   * Must not be called for a closed device.
> >   */
> > -int gnss_insert_raw(struct gnss_device *gdev, const unsigned char *buf,
> > -				size_t count)
> > +size_t gnss_insert_raw(struct gnss_device *gdev, const unsigned char *buf,
> > +		       size_t count)
> >  {
> > -	int ret;
> > +	size_t ret;
> >  
> >  	ret = kfifo_in(&gdev->read_fifo, buf, count);
> >  
> 
> Why are you changing this function? This is part of the GNSS interface
> and has nothing to do with the rest of this patch.
> 
> Greg, please drop this one again until this has been resolved.

Now dropped, thanks.

