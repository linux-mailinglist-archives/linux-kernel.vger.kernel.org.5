Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A38180932D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443964AbjLGVNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjLGVNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:13:50 -0500
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83D01715
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 13:13:55 -0800 (PST)
Received: from [192.168.1.18] ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id BLgtrBr3hMO0QBLgtrRMmD; Thu, 07 Dec 2023 22:13:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1701983634;
        bh=JnltmePhGEbdAkrEgv3g36oINGYUM5lmCn8S7mA4KXk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=eoU0XRzH9tVdA0RymcgDqEHkccEylBESxl10B/20sw3t8Y3RRBfD51BTQWG3YEDGl
         SdGsPMgNs/9E4rdkSnpPuguZzjq6iJManwx6fUhFU9JSSYwZwIfpS0gBR7oTxbywMB
         kFWqH9G9pHNrcvKFIe/zJ/d/olyN2VNe8FdmRJNBTg20bLsIZaod9P+p8Aa1kPV6Mc
         ptkKHcDRMPn+9KUBNRyAxs0uKnOqdbjuUGZd5/vABuIf5qoCokut9xtAkQFtkGTfXz
         572wKuiQQyeKUCCB6TtsywSiebOWHHON8MV6sj08BFNj/z5/JH+4P9i2WEh/+1LhBi
         ex/hHSb/AA4ZA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 07 Dec 2023 22:13:54 +0100
X-ME-IP: 92.140.202.140
Message-ID: <72a89724-9dad-499a-a0ed-ad9d046d235d@wanadoo.fr>
Date:   Thu, 7 Dec 2023 22:13:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa: Fix an error handling path in eni_vdpa_probe()
Content-Language: fr
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <a7b0ef1eabd081f1c7c894e9b11de01678e85dee.1666293559.git.christophe.jaillet@wanadoo.fr>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <a7b0ef1eabd081f1c7c894e9b11de01678e85dee.1666293559.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 20/10/2022 à 21:21, Christophe JAILLET a écrit :
> After a successful vp_legacy_probe() call, vp_legacy_remove() should be
> called in the error handling path, as already done in the remove function.
> 
> Add the missing call.
> 
> Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/vdpa/alibaba/eni_vdpa.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> index 5a09a09cca70..cce3d1837104 100644
> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -497,7 +497,7 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (!eni_vdpa->vring) {
>   		ret = -ENOMEM;
>   		ENI_ERR(pdev, "failed to allocate virtqueues\n");
> -		goto err;
> +		goto err_remove_vp_legacy;
>   	}
>   
>   	for (i = 0; i < eni_vdpa->queues; i++) {
> @@ -509,11 +509,13 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	ret = vdpa_register_device(&eni_vdpa->vdpa, eni_vdpa->queues);
>   	if (ret) {
>   		ENI_ERR(pdev, "failed to register to vdpa bus\n");
> -		goto err;
> +		goto err_remove_vp_legacy;
>   	}
>   
>   	return 0;
>   
> +err_remove_vp_legacy:
> +	vp_legacy_remove(&eni_vdpa->ldev);
>   err:
>   	put_device(&eni_vdpa->vdpa.dev);
>   	return ret;

Polite reminder on a (very) old patch.

CJ
