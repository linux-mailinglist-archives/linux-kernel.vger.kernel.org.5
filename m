Return-Path: <linux-kernel+bounces-12215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE8881F170
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 19:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90B51B227DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7651E537;
	Wed, 27 Dec 2023 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+okM2UP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8DA1DFE8;
	Wed, 27 Dec 2023 18:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BF2C433C7;
	Wed, 27 Dec 2023 18:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703702157;
	bh=0siblmpSE3KVqzpkVehEyjAK/TXGvMOcCY6Sg22LjFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+okM2UPtZvpqDe2UxBEUhMFMY05kH1/mlKCbek+O2bzesZLs7yZVmy1hcDhscxY6
	 5oUBNI9vp6zmRW9vu8ZmOHdWiKuqpM7UZoiojjcQqamytmNifU3mqaOKez4TsRNLp7
	 /VJ5LXD5VLWeNb2N8vrNnWeaffF4jpDPCfIQ0HpR9G41q5NYbH6J/pyijpIMkc4tBH
	 7LF1nsxObXxnsbPOGNyvpLFY4mShT1jzpD+cRw5TdiklWxDKe2Y63Vkoic74VxLpbf
	 1qR/pfaGdQxMkKAiduWwWmdhqnFd/GLZBen4weUNLoc+RlWnQn8v27yrnOOSuRq4qy
	 KGPhIUqlsFXXA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rIYkz-00024a-0q;
	Wed, 27 Dec 2023 19:35:53 +0100
Date: Wed, 27 Dec 2023 19:35:53 +0100
From: Johan Hovold <johan@kernel.org>
To: Felix Zhang <mrman@mrman314.tech>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: do not mark valid bd_addr as
 invalid
Message-ID: <ZYxuiTYxToF7FpdW@hovoldconsulting.com>
References: <20231227101003.10534-1-johan+linaro@kernel.org>
 <f06dbc4d10ff5eb038228e9c7abb75c85514cf36.camel@mrman314.tech>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f06dbc4d10ff5eb038228e9c7abb75c85514cf36.camel@mrman314.tech>

On Wed, Dec 27, 2023 at 01:19:39PM -0500, Felix Zhang wrote:
> On Wed, 2023-12-27 at 11:10 +0100, Johan Hovold wrote:
> > A recent commit restored the original (and still documented)
> > semantics
> > for the HCI_QUIRK_USE_BDADDR_PROPERTY quirk so that the device
> > address
> > is considered invalid unless an address is provided by firmware.
> > 
> > This specifically means that this flag must only be set for devices
> > with
> > invalid addresses, but the Broadcom BCM4377 driver has so far been
> > setting this flag unconditionally.
> > 
> > Fortunately the driver already checks for invalid addresses during
> > setup
> > and sets the HCI_QUIRK_INVALID_BDADDR flag, which can simply be
> > replaced
> > with HCI_QUIRK_USE_BDADDR_PROPERTY to indicate that the default
> > address
> > is invalid but can be overridden by firmware (long term, this should
> > probably just always be allowed).
> > 
> > Fixes: 6945795bc81a ("Bluetooth: fix use-bdaddr-property quirk")
> > Cc: stable@vger.kernel.org      # 6.5
> > Reported-by: Felix Zhang <mrman@mrman314.tech>
> > Link:
> > https://lore.kernel.org/r/77419ffacc5b4875e920e038332575a2a5bff29f.camel@mrman314.tech/
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

> Thanks for the patch!  I have just tested the patch on my MacBookAir9,1
> with some modifications to make it patch with the master branch of the
> Linux kernel, and it works great!  The device is recognized by the
> system; and I can scan, pair, connect, and play audio just fine.  If
> you want me to send over the modified patch that I have used, please
> let me know.

Thanks for confirming. You should not need to modify the patch, though,
as it has been created against 6.7-rc6 and there hasn't been any changes
to this driver since rc1.

Johan

