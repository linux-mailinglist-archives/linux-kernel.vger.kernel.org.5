Return-Path: <linux-kernel+bounces-936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8FE81483B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0861C20A05
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818F82C6AE;
	Fri, 15 Dec 2023 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="igWRNlss"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7622C688;
	Fri, 15 Dec 2023 12:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36F3C433C8;
	Fri, 15 Dec 2023 12:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702643993;
	bh=WCwkUfGneDdEsgyaN5oZ8zIYVst2kezCHOcj9c+nyWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=igWRNlssctqmH8PVEui0+PkNrsBgWdT/exRLQ46Y2ZU2ZjyFLs5y9uwS1ypy4VWrg
	 NJxbo9lxe6K1OVORMMLuyAHXS4YEzYGm88ZkVHtlgtCBi4qZJlyHwDxQkB190GnRbM
	 auv0ZUSODWdB3arfVDUg3sEgkUoaq2MBIyP4MAuA=
Date: Fri, 15 Dec 2023 13:39:51 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH v2 2/3] usb: xhci-mtk: fix a short packet issue of gen1
 isoc-in transfer
Message-ID: <2023121539-dowry-ambiance-51e3@gregkh>
References: <20231215073431.8512-1-chunfeng.yun@mediatek.com>
 <20231215073431.8512-2-chunfeng.yun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215073431.8512-2-chunfeng.yun@mediatek.com>

On Fri, Dec 15, 2023 at 03:34:30PM +0800, Chunfeng Yun wrote:
> For Gen1 isoc-in transfer, host still send out unexpected ACK after device
> finish the burst with a short packet, this will cause an exception on the
> connected device, such as, a usb 4k camera.
> It can be fixed by setting rxfifo depth less than 3, prefer to use 2 here,
> the side-effect is that may cause performance drop about 10%, including
> bulk transfer.
> 
> Fixes: 926d60ae64a6 ("usb: xhci-mtk: modify the SOF/ITP interval for mt8195")
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2:
> use 'rx-fifo-depth' property;
> add header file 'linux/bitfield.h' to avoid building error on some ARCH;
> ---


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

