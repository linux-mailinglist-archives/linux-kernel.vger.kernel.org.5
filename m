Return-Path: <linux-kernel+bounces-8109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E91081B243
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C2D28877C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A57219F4;
	Thu, 21 Dec 2023 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="peRf5dwv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35768219E4;
	Thu, 21 Dec 2023 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bhUM1XijalfIIIJGc6XtFDdiTTA83ZKMMJW0N2PSJ5E=; b=peRf5dwvFRD8WvXs6Z1Jv+lm33
	2s6gLOzX6ieSPJym3uodnNNcv5tgAS1xPHktD36vAWi8AzYsHtBx/GWobLW2AUJtOGoScRGqdRsKW
	5n5opFOfsR1jZtcpvqnrBnBctByjfZi2wcV35PUV3pyOukIZYFlRb/KhLAPpGKryXsp8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rGFGJ-003Udl-8V; Thu, 21 Dec 2023 10:22:39 +0100
Date: Thu, 21 Dec 2023 10:22:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Gan, Yi Fang" <yi.fang.gan@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	John Stultz <jstultz@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Looi Hong Aun <hong.aun.looi@intel.com>,
	Voon Weifeng <weifeng.voon@intel.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Lai Peter Jun Ann <peter.jun.ann.lai@intel.com>,
	Choong Yong Liang <yong.liang.choong@intel.com>
Subject: Re: [PATCH net v2 2/2] net: phylink: Add module_exit_stub()
Message-ID: <0f85171e-cb9c-47dd-bb7d-f58537e24a54@lunn.ch>
References: <20231221085109.2830794-1-yi.fang.gan@intel.com>
 <20231221085109.2830794-3-yi.fang.gan@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221085109.2830794-3-yi.fang.gan@intel.com>

On Thu, Dec 21, 2023 at 04:51:09PM +0800, Gan, Yi Fang wrote:
> In delete_module(), if mod->init callback is defined but mod->exit
> callback is not defined, it will assume the module cannot be removed
> and return EBUSY. The module_exit() is missing from current phylink
> module drive causing failure while unloading it.

You are missing justification it is actually safe to remove
phylink. Maybe Russell King deliberately did not implement
module_exit() because it can explode in interesting ways if it was?

	Andrew

