Return-Path: <linux-kernel+bounces-96508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C2A875D3F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9821F21E5C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC34F2E62E;
	Fri,  8 Mar 2024 04:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4spbCkn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB2B1E487;
	Fri,  8 Mar 2024 04:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709873247; cv=none; b=E6gm4xHzUaT43pfZtB9luuH4eX6YyzU7PgeAaHp31hpTX81bYuHemqCoKeAYwatey2aCWZHuIRzypSnKUjeg+qMmtnNGKBG8QO3Qt3kQ+78q834bKtoCw+4k4mPGJHbLFIM78AqE4E9bT2yXHvrjbq5kNrVcNJRMm/BHD831Vzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709873247; c=relaxed/simple;
	bh=mov2suGwYSotDcil8OtlRhObFutbrPEMy0JCqdY2T1w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjwXrh/mZ0NdlCT5oFIO4VaxwW1AclaEwBAUlhUCu8ic7OxCHmScOH8tfDrfGc/P2vsE+zcUM2mtd9rjFOjrmfY+jR7q9QbWg6wvG1owLCCHq3ESbpspwGQg18geQoUWHM1iUPFutUUVjnw9vFEl7TLKRqxhrLzT5aluISTWMw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4spbCkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17224C433F1;
	Fri,  8 Mar 2024 04:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709873246;
	bh=mov2suGwYSotDcil8OtlRhObFutbrPEMy0JCqdY2T1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A4spbCkn3HzV/GF5B7akHbt5i9qAw2bbSfPjSIMm7slD9p85X3DT3/Z9zORg3h6l1
	 CGzva2VFdHClrWUJJsHZW1FtTYepQg3GxIooVwGKnAtXQL5WU8c0ZZ/Hc9erzDkuRx
	 lkKHw/Ih6GUsIYqCFGibUSPFLPVsIQ6bSsZn0WukhGlCPUuDNQjQ4MyIPsk9fwQTeB
	 9tWnQOaYntQ/Fz9rYTBvCDH07eZbxLiGdJeZoJMDwZP/m7NMJiXNxJs453Uwm4mME/
	 8fdLfYXm57ybJ+BMkZWv1fQfKlVt9XM4IsJn+oHVlJzYqtEGTcdLnrzqgFArb4hAmm
	 FOQ2aeYT91kOw==
Date: Thu, 7 Mar 2024 20:47:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
 <sbhatta@marvell.com>
Subject: Re: [net-next PATCH v2] octeontx2-pf: Reset MAC stats during probe
Message-ID: <20240307204725.4dddcc9d@kernel.org>
In-Reply-To: <20240305082707.213332-1-saikrishnag@marvell.com>
References: <20240305082707.213332-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Mar 2024 13:57:07 +0530 Sai Krishna wrote:
> +int otx2_reset_mac_stats(struct otx2_nic *pfvf);
>  
>  /* RVU block related APIs */
>  int otx2_attach_npa_nix(struct otx2_nic *pfvf);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index e5fe67e73865..a91f5b7e84c6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -1124,6 +1124,24 @@ static int otx2_cgx_config_linkevents(struct otx2_nic *pf, bool enable)
>  	return err;
>  }
>  
> +int otx2_reset_mac_stats(struct otx2_nic *pfvf)
> +{
> +	struct msg_req *req;
> +	int err;
> +
> +	mutex_lock(&pfvf->mbox.lock);
> +	req = otx2_mbox_alloc_msg_cgx_stats_rst(&pfvf->mbox);
> +	if (!req) {
> +		mutex_unlock(&pfvf->mbox.lock);
> +		return -ENOMEM;
> +	}
> +
> +	err = otx2_sync_mbox_msg(&pfvf->mbox);
> +	mutex_unlock(&pfvf->mbox.lock);
> +	return err;
> +}
> +EXPORT_SYMBOL(otx2_reset_mac_stats);

Why the export? I see only one call to this function and it's right
below..

>  static int otx2_cgx_config_loopback(struct otx2_nic *pf, bool enable)
>  {
>  	struct msg_req *msg;
> @@ -3048,6 +3066,9 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	otx2_qos_init(pf, qos_txqs);
>  
> +	/* reset CGX/RPM MAC stats */
> +	otx2_reset_mac_stats(pf);
> +


