Return-Path: <linux-kernel+bounces-27753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553B382F558
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EAE92864CD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7483B1D534;
	Tue, 16 Jan 2024 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RChRjd16"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C821D520;
	Tue, 16 Jan 2024 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433282; cv=none; b=PLsHY13PbDKymJnvK3pk8DgCFv6jTfmNwrrCVH2VLfPlYgSuUe2AkYjpNxbIoeEpXmsE0tEk8jxevEzUUmW5CS+dvDv8cVSGcaaks5QGPV97vUgGSD7/M4f/3CuoAkr14VpPhXnvgVBaNhRTwtbRaUj42GzVdFmoEIdUPkcgYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433282; c=relaxed/simple;
	bh=S+tXDDxWx+J/j4en03nSn/UORlk2dhCbx8Bmvhq5Nxg=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=fhYgLcBHh4TiqV4Vqc3ap/C/nSYkOcyKA2/acISM7l3qEPdf5RnaukBYzP7W1R7s4Pkoam8RajTULUaWfqmP3yA8thu5fuYdt9b9mnli8/DNnCtP9v1et5xIBH2uoFMS5ht86Vx1of8hShNVBPj1fxhhkhAV9X7AmmMoQHWftps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RChRjd16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E69DC433C7;
	Tue, 16 Jan 2024 19:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705433282;
	bh=S+tXDDxWx+J/j4en03nSn/UORlk2dhCbx8Bmvhq5Nxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RChRjd16P8cvAruigJLv4MHsh/YilJ2bOb9R1aj+udCSegILBSfBBj3VAhT+YGz1i
	 jNBolRokG10lt6dEV6OKUPu88QW4F5g6NJo2c2Bd/8n+2sPuaNH1pWSLeY/jjuT41V
	 Iuh53LrOl4yofiNBMlp41Hs37UO5ZAlH8J2HMgVF4XQrNZ5uMcqBUNvpryTlO/n4YT
	 ccGmckHtL5PE/PJDYCwJ3A0sx1hCZyIDhV0umGMp+uA2LXzDqzBM/ZJvo2Bi1S3P2I
	 LU4xawLEi8AucOB32v3uzm2sR+4jJOA8/F4w4UkPp+JVBet1vyyXETAZmugWGy5o8j
	 zmZABIyLnM1jA==
Date: Tue, 16 Jan 2024 19:27:57 +0000
From: Simon Horman <horms@kernel.org>
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, kuba@kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xudingke@huawei.com
Subject: Re: [PATCH net v2] tun: add missing rx stats accounting in
 tun_xdp_act
Message-ID: <20240116192757.GC588419@kernel.org>
References: <1705409818-28292-1-git-send-email-wangyunjian@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705409818-28292-1-git-send-email-wangyunjian@huawei.com>

On Tue, Jan 16, 2024 at 08:56:58PM +0800, Yunjian Wang wrote:
> There are few places on the receive path where packet receives and packet
> drops were not accounted for. This patch fixes that issue.
> 
> Fixes: 8ae1aff0b331 ("tuntap: split out XDP logic")
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
> v2: add Fixes tag
> ---
>  drivers/net/tun.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index afa5497f7c35..232e5319ac77 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1626,17 +1626,14 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
>  		       struct xdp_buff *xdp, u32 act)
>  {
>  	int err;
> +	unsigned int datasize = xdp->data_end - xdp->data;

nit: if you post a v3 for some other reason then, as this is Networking
     code, please consider arranging local variables in reverse xmas tree
     order - longest line to shortest.

	unsigned int datasize = xdp->data_end - xdp->data;
	int err;

..

