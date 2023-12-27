Return-Path: <linux-kernel+bounces-11963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A095E81EE42
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E3F1F21CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D37044378;
	Wed, 27 Dec 2023 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSe30+oL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFAB43179;
	Wed, 27 Dec 2023 10:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E423C433C7;
	Wed, 27 Dec 2023 10:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703673322;
	bh=CLApfWGlPigge9o3aRXGuWQYw9nh9nmKCHBY6z1XJXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CSe30+oLZFgsf5gy58cS+JuPIOHfXK1FNnKMt8yZaGgjyuk1PJaruqVAPuT3cUTnn
	 fcCur28tApDHwHXYCdB73W5b7gnOhQ4YfpZRgY4zPKuQQ3LdBc7+WkIm+5vGnNI3Q8
	 e5iMyqRUifybvINZxNWHvqPgxyIzcDZxA/YEFSNrTojSFkBAFTamNI4REEFr3Vm6kX
	 ITE+Gl7/mWKxYeWQ6JtuDZCS+t/QACbimdEYj8/CPoJAVaZmVBPtmg9UBASc/reVGi
	 Q1XcQhi/Sul+fOVTqtu8ogNOswgfPdwFrEqYGNjnFGo+Kqwi2gQli9ziRdw5DauMtY
	 QL1oFm7C+aS7w==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rIRFs-0002tg-2p;
	Wed, 27 Dec 2023 11:35:16 +0100
Date: Wed, 27 Dec 2023 11:35:16 +0100
From: Johan Hovold <johan@kernel.org>
To: Felix Zhang <mrman@mrman314.tech>
Cc: linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
	marcan@marcan.st, bagasdotme@gmail.com, sven@svenpeter.dev,
	alyssa@rosenzweig.io, marcel@holtmann.org, johan.hedberg@gmail.com,
	luiz.dentz@gmail.com, orlandoch.dev@gmail.com, kekrby@gmail.com,
	admin@kodeit.net, j@jannau.net, gargaditya08@live.com,
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel
 MacBooks
Message-ID: <ZYv95BOowY38NesX@hovoldconsulting.com>
References: <aaa107865f4cbd61f8f9006fd3e7ac43b5d1bdad.camel@mrman314.tech>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaa107865f4cbd61f8f9006fd3e7ac43b5d1bdad.camel@mrman314.tech>

On Mon, Dec 25, 2023 at 03:21:04PM -0500, Felix Zhang wrote:
> Starting v6.5, Bluetooth does not work at all on my T2
> MacBookAir9,1 with the BCM4377 chip.  When I boot up the computer,
> go into bluetoothctl, and then try to run commands like scan on,
> show, list, it returns "No default controller available."  I have
> tried reloading the kernel module, in which the log outputs
> "{Added,Removed} hci0 (unconfigured)."  With this patch, I
> am able to use Bluetooth as normal without any errors regarding
> hci0 being unconfigured.  However, an issue is still present
> where sometimes hci_bcm4377 will have to be reloaded in order to
> get bluetooth to work.  I believe this was still present before
> the previously mentioned commit.
> 
> I would also like to thank Kerem Karabay <kekrby@gmail.com> for
> assisting me with this patch.
> 
> Fixes: 6945795bc81a ("Bluetooth: fix use-bdaddr-property quirk")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Felix Zhang <mrman@mrman314.tech>
> ---
> v4:
> * Adjust the format to pass the CI (again).
> * Shorten description

As explained here:

	https://lore.kernel.org/all/ZYv8tp3fMiAqK8OI@hovoldconsulting.com/

I don't this is necessarily the right fix. The BD_ADDR quirk property
should not be set unconditionally but it is still needed for devices
that lack storage for a unique device address.

So the following fix is needed either way and is probably all that is
needed here:

	https://lore.kernel.org/lkml/20231227101003.10534-1-johan+linaro@kernel.org/

Johan

