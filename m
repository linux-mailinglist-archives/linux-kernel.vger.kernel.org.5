Return-Path: <linux-kernel+bounces-1011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B99814932
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6411FB2211E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC9A2FE32;
	Fri, 15 Dec 2023 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Yo+W8pt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6B2E842;
	Fri, 15 Dec 2023 13:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AADC433C7;
	Fri, 15 Dec 2023 13:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702646810;
	bh=00ZkD0cu7HBjZVGkRek2lsYzXAxF35Yjjr+hicSHu5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1Yo+W8ptX+67SOYAVONFRcrHI+q2aCFD7vEjWVSvPiznqrNEBN0RX7AuxQA8Fq9o3
	 JJ3FNRJdXfsJ1lSkc+ATqb8/6/Ogg1HVpfhKJNCDv8PhCin6QqABrwy3PGC7WSyanW
	 q3/sJsi8ph1KA5HU1TJgqgS1QPZxq8wiwlyCJz+Q=
Date: Fri, 15 Dec 2023 14:26:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, greybus-dev@lists.linaro.org,
	linux-iio@vger.kernel.org, netdev@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1] treewide, serdev: change receive_buf() return type to
 size_t
Message-ID: <2023121535-coveting-destruct-f567@gregkh>
References: <20231214170146.641783-1-francesco@dolcini.it>
 <ZXs94Mf1eOMCmGpT@francesco-nb.int.toradex.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXs94Mf1eOMCmGpT@francesco-nb.int.toradex.com>

On Thu, Dec 14, 2023 at 06:39:44PM +0100, Francesco Dolcini wrote:
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
> > hello,
> > patch is based on current linux next.
> > 
> > It has an obvious problem, it touches files from multiple subsystem in a single
> > patch that is complicated to review and eventually merge, just splitting this
> > would however not work, it will break bisectability and the build.
> > 
> > I am looking for advise on the best way to move forward.
> > 
> > I see the following options:
> >  - keep it as it is
> >  - break it down with a patch with each subsystem, and squash before applying
> >    from a single (tty?) subsystem
> >  - go for a multi stage approach, defining a new callback, move to it and in
> >    the end remove the original one, likewise it was done for i2c lately
> 
> whoops. I just noticed Greg applied commit 475fc6e2de6f ("tty: serdev:
> convert to u8 and size_t") that touch the exact same files without much
> of an issue.
> 
> Probably the "keep it as it is" is just the way to go.

Yeah, looks good to me, now queued up, thanks!

greg k-h

