Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4F67C445F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjJJWmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjJJWmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:42:03 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C297391
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:42:01 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-351365e47f6so21069895ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696977721; x=1697582521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NvHEYuzwR8RWQJwsOaEdhIqtkzlrA9r5/0O9OEN8OX8=;
        b=JGcMnWrX0oSgaDlISvKZsPtu+a3LIUuRpbUHgADv3v3Spoc4su8PKWYdYq+nvqp0mV
         Kh51icX2GP+PzSPcgi+j/sGNCxxOl80qWSboLjdvOWDp9q6HPW7GR/hC+vJuw2wt5IO6
         xIWUC7Ncs8dZe+OikIKfbxdSnJ6yrg4s2CkcVFB8piv6WvQ7LooQjNez3IAo38dXg10y
         UATFVXzfOef2vkgHc2hwYtlmbFnpBKFA+RrBqS+KpHQi02anDqSmuWrcRHz2BvatFWjx
         MjY64wYiB1/YnbsL/kbDL0DGNfiCABOxihAGwfO0ZnRCa02jlQkR7F8MbJ8/v7v308xA
         aQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696977721; x=1697582521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvHEYuzwR8RWQJwsOaEdhIqtkzlrA9r5/0O9OEN8OX8=;
        b=O156sbruZ0xNn+Is+FVEowRzirCWFRzWSBJtQb6DE8CJQFffw7AYMWkNPC9ufi724x
         WZk18LHFi3+E5LUpNRXqvCR5gR7oyG0RAPkVNR093TmBEPfvi8rzxGGAiB5uhPl8Q4/n
         YX0F5eHBvp4V85M4ST8sO0kjgDA4oX/rvFxR+ymoQ16UAw4Fy7WZBAGnz7bi3Jfr6gR/
         SD6D37CyktqZqzcuIfnF9xrepULJyzopRAld6Y1R1UpeHk2qVfFJhOJF2wz+u6OEWb+7
         2X9zRPCjsz2YnbKC7GCt0+xxSjUINghVStZOn2zeyudE3N18E0jYyZg2N/cnSQrAQFqn
         4QmQ==
X-Gm-Message-State: AOJu0Yw5yhgwW/f+9EVyJYdmdX2RFM0jXOXrrGeT14ytu/W4HEIWoBh+
        0yYxORBnktCWfE1+I7exGso3EPjLujLQqqaoqlw3+Q==
X-Google-Smtp-Source: AGHT+IHqBS/F5DigO4tHV0GMbrKCEUUTNodif2ztURMC6G0riAFV2RzwgdpbMg5Z+8Ni9JvwmbtsFA==
X-Received: by 2002:a05:6e02:12ea:b0:351:1647:5f7e with SMTP id l10-20020a056e0212ea00b0035116475f7emr25370364iln.15.1696977721050;
        Tue, 10 Oct 2023 15:42:01 -0700 (PDT)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id z12-20020a92cb8c000000b003515cdb8f23sm3805333ilo.32.2023.10.10.15.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:42:00 -0700 (PDT)
Date:   Tue, 10 Oct 2023 22:41:58 +0000
From:   Justin Stitt <justinstitt@google.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] igbvf: replace deprecated strncpy with strscpy
Message-ID: <20231010224158.ityyz3vgjfbblv6y@google.com>
References: <20231010-strncpy-drivers-net-ethernet-intel-igbvf-netdev-c-v1-1-69ccfb2c2aa5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-strncpy-drivers-net-ethernet-intel-igbvf-netdev-c-v1-1-69ccfb2c2aa5@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 09:12:00PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> We expect netdev->name to be NUL-terminated based on its usage with
> `strlen` and format strings:
> |       if (strlen(netdev->name) < (IFNAMSIZ - 5)) {
> |               sprintf(adapter->tx_ring->name, "%s-tx-0", netdev->name);
>
> Moreover, we do not need NUL-padding as netdev is already
> zero-allocated:
> |       netdev = alloc_etherdev(sizeof(struct igbvf_adapter));
> ...
> alloc_etherdev() -> alloc_etherdev_mq() -> alloc_etherdev_mqs() ->
> alloc_netdev_mqs() ...
> |       p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
>
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/ethernet/intel/igbvf/netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
> index 7ff2752dd763..fd712585af27 100644
> --- a/drivers/net/ethernet/intel/igbvf/netdev.c
> +++ b/drivers/net/ethernet/intel/igbvf/netdev.c
> @@ -2785,7 +2785,7 @@ static int igbvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>
>  	igbvf_set_ethtool_ops(netdev);
>  	netdev->watchdog_timeo = 5 * HZ;
> -	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
> +	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
>
>  	adapter->bd_number = cards_found++;
>
>
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231010-strncpy-drivers-net-ethernet-intel-igbvf-netdev-c-aea454a18a2d
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>
Hi, this patch was bundled up with some others. It has a new home:

https://lore.kernel.org/all/20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com/
