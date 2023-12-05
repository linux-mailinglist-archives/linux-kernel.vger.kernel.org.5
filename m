Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7510D805C38
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345984AbjLERR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjLERRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:17:24 -0500
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495B8A1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:17:30 -0800 (PST)
Received: from [192.168.42.20] (p5de457e6.dip0.t-ipconnect.de [93.228.87.230])
        (Authenticated sender: wse@tuxedocomputers.com)
        by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 01B7C2FC01FB;
        Tue,  5 Dec 2023 18:17:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1701796648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=waunzxouAu+EhVCebQmRlGhPFC3Fc2GsLS9nml3O+7Q=;
        b=BDy8Ub4llOR5f3HkIivg25SIFVoVgVyNtDJQs4Zk2UpJnMmgz8oRbfTvpIObN8NfcR9ZL6
        RmLKAC/D7/Va+XxBt2meQFz8oVupjFgnMjC9+AvwVNDubJHdURZjm4TFpHQcR7+JD3t6sb
        utDdS8KhuUB4OPVHyi+6y2TPeowmOOY=
Authentication-Results: mail.tuxedocomputers.com;
        auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <12d32e8e-e20b-4023-8299-39d2a69c0cd9@tuxedocomputers.com>
Date:   Tue, 5 Dec 2023 18:17:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Add sleep quirk for Kingston drives
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Georg Gottleuber <ggo@tuxedocomputers.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230920085210.22573-1-wse@tuxedocomputers.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20230920085210.22573-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 20.09.23 um 10:52 schrieb Werner Sembach:
> From: Georg Gottleuber <ggo@tuxedocomputers.com>
>
> Some Kingston NV1 and A2000 are wasting a lot of power on specific TUXEDO
> platforms in s2idle sleep if 'Simple Suspend' is used.
>
> This patch applies a new quirk 'Force No Simple Suspend' to achieve a
> low power sleep without 'Simple Suspend'.
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
> Cc: <stable@vger.kernel.org>

Want to leave a gentle bump here. Any issues with this patch?

Kind regards,

Werner Sembach

> ---
>   drivers/nvme/host/nvme.h |  5 +++++
>   drivers/nvme/host/pci.c  | 16 +++++++++++++++-
>   2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index f35647c470afa..74f74b459f5fa 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -156,6 +156,11 @@ enum nvme_quirks {
>   	 * No temperature thresholds for channels other than 0 (Composite).
>   	 */
>   	NVME_QUIRK_NO_SECONDARY_TEMP_THRESH	= (1 << 19),
> +
> +	/*
> +	 * Disables simple suspend/resume path.
> +	 */
> +	NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND	= (1 << 20),
>   };
>   
>   /*
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 347cb5daebc3c..b4e6f0d21a44c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2903,6 +2903,18 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>   		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
>   		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
>   			return NVME_QUIRK_SIMPLE_SUSPEND;
> +	} else if (pdev->vendor == 0x2646 && (pdev->device == 0x2263 ||
> +		   pdev->device == 0x500f)) {
> +		/*
> +		 * Exclude some Kingston NV1 and A2000 devices from
> +		 * NVME_QUIRK_SIMPLE_SUSPEND. Do a full suspend to save a
> +		 * lot fo energy with s2idle sleep on some TUXEDO platforms.
> +		 */
> +		if (dmi_match(DMI_BOARD_NAME, "NS5X_NS7XAU") ||
> +		    dmi_match(DMI_BOARD_NAME, "NS5x_7xAU") ||
> +		    dmi_match(DMI_BOARD_NAME, "NS5x_7xPU") ||
> +		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1"))
> +			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
>   	}
>   
>   	return 0;
> @@ -2933,7 +2945,9 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
>   	dev->dev = get_device(&pdev->dev);
>   
>   	quirks |= check_vendor_combination_bug(pdev);
> -	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
> +	if (!noacpi &&
> +	    !(quirks & NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND) &&
> +	    acpi_storage_d3(&pdev->dev)) {
>   		/*
>   		 * Some systems use a bios work around to ask for D3 on
>   		 * platforms that support kernel managed suspend.
