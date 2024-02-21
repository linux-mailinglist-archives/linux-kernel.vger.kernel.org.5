Return-Path: <linux-kernel+bounces-74571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B47585D622
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44672284160
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B003EA71;
	Wed, 21 Feb 2024 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZXXnSreM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A903D3A1;
	Wed, 21 Feb 2024 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513051; cv=none; b=L2r8flYGBxUPYjDrd/cyYPDQEVojOQcZI/yo18k8z9snYa/TxNmJ00bUUSXCVMntLd6q9+INqt62l3WFTwXO176FeuxESBGg4sJqRmqSngmPJ3y5jGprbq0lV8cGUJpZDl6gPWlOxS0d3bf0TYLtL1Vc6OSFfRmhc4sWK/G6PTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513051; c=relaxed/simple;
	bh=C1Ipxz+S16Qg2MJDx5VYOE+RjL+OrQCdY2m3px6eY+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlG92UWck5n0Uv2H/ytQDyCXuZaHVRCI3I7egm+FAh3+5rX0x+TgNl2G/0rg3SJREGERguLE7e/Bm+gnM6VsaMIYFyVIayp/7WDemcpOZXDJqwFJu/wohwVsFoB+uKtG9KKh4rms2Pt3UGZdAOP215hdpsjn2g7iq39WvU+f0Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZXXnSreM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B933C433F1;
	Wed, 21 Feb 2024 10:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708513050;
	bh=C1Ipxz+S16Qg2MJDx5VYOE+RjL+OrQCdY2m3px6eY+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZXXnSreMyEkh5WuKXE5riH1IWkbU/zmf9iF0XKW2PETpi4Pq2POrhKZmFwVyezSc+
	 PTrRjWp9UDICUxawwlcTDzmyt6UxSbiCg7odez4qbnT9bKt6oANCqtF/NBcHHIAF9b
	 SH0+Nfh55usNSP4O0UIi18Gh4eNAtC4qcNShuRZQ=
Date: Wed, 21 Feb 2024 11:57:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: stable@vger.kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
	fw@strlen.de, davem@davemloft.net, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, alexey.makhalov@broadcom.com,
	florian.fainelli@broadcom.com, vasavi.sirnapalli@broadcom.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.4.y] netfilter: nf_tables: fix pointer math issue in
 nft_byteorder_eval()
Message-ID: <2024022115-vixen-brought-6058@gregkh>
References: <1707108293-1004-1-git-send-email-ajay.kaher@broadcom.com>
 <1707108293-1004-2-git-send-email-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1707108293-1004-2-git-send-email-ajay.kaher@broadcom.com>

On Mon, Feb 05, 2024 at 10:14:53AM +0530, Ajay Kaher wrote:
> From: Dan Carpenter <dan.carpenter@linaro.org>
> 
> commit c301f0981fdd3fd1ffac6836b423c4d7a8e0eb63 upstream.
> 
> The problem is in nft_byteorder_eval() where we are iterating through a
> loop and writing to dst[0], dst[1], dst[2] and so on...  On each
> iteration we are writing 8 bytes.  But dst[] is an array of u32 so each
> element only has space for 4 bytes.  That means that every iteration
> overwrites part of the previous element.
> 
> I spotted this bug while reviewing commit caf3ef7468f7 ("netfilter:
> nf_tables: prevent OOB access in nft_byteorder_eval") which is a related
> issue.  I think that the reason we have not detected this bug in testing
> is that most of time we only write one element.
> 
> Fixes: ce1e7989d989 ("netfilter: nft_byteorder: provide 64bit le/be conversion")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> [Ajay: Modified to apply on v5.4.y]
> Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
> ---

All now queued up, thanks.

greg k-h

