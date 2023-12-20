Return-Path: <linux-kernel+bounces-6395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEC781985A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCCF1C2495B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5848211C84;
	Wed, 20 Dec 2023 05:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bPdecnAx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9566EFBF9;
	Wed, 20 Dec 2023 05:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84096C433C7;
	Wed, 20 Dec 2023 05:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703051877;
	bh=n0ckWVr2p5ZoAOLCgKU6Bdxii8DiBrVLcshx8Gs1Gv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bPdecnAxw7khdyUI/WPAvwDX+64JC81cBxPIJZKCTcx1rFPLt/MPfyi6gBs9UhpxT
	 vuV6PuhPcLbQvgtBBSe3BMNSvM3/NvD5V86aQfgarfmfC7BuD8+eN4uxTzcsnYg92n
	 f9hAvwW/2HahH0NUxgo5zde7eshHtu+qkEvKp8Xc=
Date: Wed, 20 Dec 2023 06:57:54 +0100
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
	linux-kernel@vger.kernel.org, Eddie Hung <eddie.hung@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] usb: xhci-mtk: fix a short packet issue of gen1
 isoc-in transfer
Message-ID: <2023122033-footprint-impose-9989@gregkh>
References: <20231220025842.7082-1-chunfeng.yun@mediatek.com>
 <20231220025842.7082-2-chunfeng.yun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220025842.7082-2-chunfeng.yun@mediatek.com>

On Wed, Dec 20, 2023 at 10:58:41AM +0800, Chunfeng Yun wrote:
> For Gen1 isoc-in transfer, host still send out unexpected ACK after device
> finish the burst with a short packet, this will cause an exception on the
> connected device, such as, a usb 4k camera.
> It can be fixed by setting rxfifo depth less than 4k bytes, prefer to use
> 3k here, the side-effect is that may cause performance drop about 10%,
> including bulk transfer.
> 
> Fixes: 926d60ae64a6 ("usb: xhci-mtk: modify the SOF/ITP interval for mt8195")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v3:
> add Cc stable

Why is a patch that you are marking for stable inclusion (and I am
guessing inclusion in 6.7-final) in the middle of other patches that are
not marked as such?

Always split out bugfixes from other things so that they can go through
the two different branches, one for this current release, and one for
the next one.

Otherwise you will have to wait until 6.8-rc1 for this bugfix to land,
which I doubt you intend to have happen.

Please fix up and resend 2 different patch series.

thanks,

greg k-h

