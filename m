Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85257C4455
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344090AbjJJWi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343968AbjJJWiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:38:51 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C19C6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:38:50 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79f9acc857cso221348339f.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696977529; x=1697582329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X7j1W3e+lGoZCZMgFqMWH4B2yEAzZ+/aTSC9fxHvMic=;
        b=lHCmuyLsgweSz9A2gkdHaIdHfVEUzeJB4VTRLqX1w0GDF8S5+G9Y+7WqlYrUwvfb0o
         Iyt6eyiNeryxoeSI3VmOHaoyfIECYFlwRMFbcyeA3z835nrbtJNvAzQLMEF1kBJyqwhT
         YzeBKHZ9CR2IAZLmW3VS3tgw2VUuWwpPZoC7kRshcZinc+2QtW/M1OhWtGy94eA7A3+D
         M5BVVIDRlQjTrPZsuSmcx9dAyd2S061dl0esCpAHVo5KquMDMb9uIqxoqbk8oXKOqWbR
         aWTMEJV2szeywzYIaCxbIp+LPNTsJCldt59XHS9jq2FUwgOtCfXCpFF0MriGYN2W2v4z
         sfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696977529; x=1697582329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7j1W3e+lGoZCZMgFqMWH4B2yEAzZ+/aTSC9fxHvMic=;
        b=j5YeQe4pF8oaA1+yIaBMmADIxXwEKlZlyS5d14ZZg4dW6bob80UCt0HM2bPcTeHEm6
         GeXBToSjw9fdxfWSTd6sarRTHOJaTWFf4zKtBhd+eHVtllBDqtz6slAoTaP+RAA2rbCR
         DT95KSApTJyQpNJ5HF428hu4A7V4yl/VGkjq9YGlzbZfeNhfLvV7OexD6ljolGLxIS4f
         VnKa555SSNyUMTygS0fgkCRidsFDLdALoWtYOuJeX2quDQpUdfJQRS1HpKupENDJ4v+t
         1GUKQ+fLFe60Q214Z3q1ZQdPA/VXN7wCWErsr9NbyvkzBCs3AdVnZAbC0GHynLeyzBnk
         21RQ==
X-Gm-Message-State: AOJu0YxxOsP0lAYcIHKIgctNu/Cpqi7I6uYnlSlScpCNNtnJgARyZETr
        BEsJl1D4C1TH24dH6qSi4rT+aw==
X-Google-Smtp-Source: AGHT+IH1AL7DMI2fWDPxGND2BRfTD6++5areXe5L931LevO2S8ZQprCtLI+3kD4KSwqKDVIdowL91w==
X-Received: by 2002:a6b:6b12:0:b0:79a:bbd2:8f5a with SMTP id g18-20020a6b6b12000000b0079abbd28f5amr21401252ioc.12.1696977529326;
        Tue, 10 Oct 2023 15:38:49 -0700 (PDT)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id u23-20020a6be317000000b007a278f16881sm3273529ioc.42.2023.10.10.15.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:38:48 -0700 (PDT)
Date:   Tue, 10 Oct 2023 22:38:46 +0000
From:   Justin Stitt <justinstitt@google.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] igb: replace deprecated strncpy with strscpy
Message-ID: <20231010223846.fxmqzdjelxfmio7u@google.com>
References: <20231010-strncpy-drivers-net-ethernet-intel-igb-igb_main-c-v1-1-d796234a8abf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-strncpy-drivers-net-ethernet-intel-igb-igb_main-c-v1-1-d796234a8abf@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 09:07:59PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> We see that netdev->name is expected to be NUL-terminated based on its
> usage with format strings:
> |       sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,
> |               q_vector->rx.ring->queue_index);
>
> Furthermore, NUL-padding is not required as netdev is already
> zero-allocated:
> |       netdev = alloc_etherdev_mq(sizeof(struct igb_adapter),
> |                                  IGB_MAX_TX_QUEUES);
> ...
> alloc_etherdev_mq() -> alloc_etherdev_mqs() -> alloc_netdev_mqs() ...
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
>  drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 76b34cee1da3..9de103bd3ad3 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -3264,7 +3264,7 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	igb_set_ethtool_ops(netdev);
>  	netdev->watchdog_timeo = 5 * HZ;
>
> -	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
> +	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
>
>  	netdev->mem_start = pci_resource_start(pdev, 0);
>  	netdev->mem_end = pci_resource_end(pdev, 0);
>
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231010-strncpy-drivers-net-ethernet-intel-igb-igb_main-c-b259e3f289d3
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>
Hi, this patch was bundled up with some others. It has a new home:

https://lore.kernel.org/all/20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com/
