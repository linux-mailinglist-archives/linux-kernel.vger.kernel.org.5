Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF17B7C4448
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjJJWhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjJJWhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:37:14 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AF898
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:37:12 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7a2cc9ee64cso243864239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696977432; x=1697582232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7KEiEpOZzZFI+Ee/8SqyvOUW+DenGZx3h9JZJySH7A=;
        b=ujRPBvL8FvS9zMAsblp5yT3zR5RvbRxFDvYPkoIoEcVvUXTudEgMr/ph7+5dU8+PWB
         8LzNQXcKiunwLB76i3jPsQx+RUBsAX1rJIx8whLt5DDil0ZVQzNzt6FlCgLs2e6cRqxW
         MG1fU8tFisdnJ8cHXXXAk9PPG+qbUSizuSzdXHdLpKu1+DkaIE+gH9chCrBZcVcrCqCX
         LhQblVLpEv8UPEqCZn52ixsDRc6wPv9sJV+HlLYa2rto4qi63wvT6qmevZNmJC1Z5JrU
         wqCX4c4+RWM+rjhp1EQygxSNPFg5GG8KNq2xBRZTCc3kn5gpzPaH9PeR63Eg0AdhXG7m
         VHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696977432; x=1697582232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7KEiEpOZzZFI+Ee/8SqyvOUW+DenGZx3h9JZJySH7A=;
        b=gknnQYmC8WKc+1MK95tleUmaTYL130XBer+xr9svPh/KuOA2jdx50o3NyHHo5FeIRF
         rpGhGJbithvml94OlFPdSOYzyP4dtJ4CaqMEXumnp1Z9WfKi47uVbl/96JQkH81JUyn5
         rQLzAuo+pI6PdXeIg5HtSV24MTHEuFducfXxV/lsXLIFM2zat46dKL/I6eN4MHvZdbJd
         v+hIrCfU705yTU0bmNdkTPQV2Du9d/inTueKAb0fIqx84A20xcsX06YYQR2BpTeYJk7J
         Zwp1fnrX9AOzz/RHiVX8bqTKfCQcGsKt0KCfWKUih0dg6FqJSDDymNseX+SUILmZfuga
         E/cw==
X-Gm-Message-State: AOJu0YwG9xUNoRNE3OjkT/PsrUHAmmQ5fSP+nE2iaMPnXD8o7+/1RiJl
        oGKGXnqWHl8fALLY3gXpH7sDzQ==
X-Google-Smtp-Source: AGHT+IEJloSK9+Eu6q8mKS5r36VH2nOerdRMot+Hr6r6WmCNCHggUejrdLlT5nQV+4mLGFpYxPMDoQ==
X-Received: by 2002:a6b:5b03:0:b0:787:1555:efca with SMTP id v3-20020a6b5b03000000b007871555efcamr22044276ioh.5.1696977432213;
        Tue, 10 Oct 2023 15:37:12 -0700 (PDT)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id p2-20020a02b882000000b0043cb3818dffsm2962711jam.3.2023.10.10.15.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:37:11 -0700 (PDT)
Date:   Tue, 10 Oct 2023 22:37:08 +0000
From:   Justin Stitt <justinstitt@google.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fm10k: replace deprecated strncpy with strscpy
Message-ID: <20231010223708.mwju62xvxgmv6mbf@google.com>
References: <20231010-strncpy-drivers-net-ethernet-intel-fm10k-fm10k_ethtool-c-v1-1-dbdc4570c5a6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-strncpy-drivers-net-ethernet-intel-fm10k-fm10k_ethtool-c-v1-1-dbdc4570c5a6@google.com>
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

On Tue, Oct 10, 2023 at 07:53:32PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
>
> Other implementations of .*get_drvinfo also use strscpy so this patch
> brings fm10k_get_drvinfo in line as well:
>
> igb/igb_ethtool.c +851
> static void igb_get_drvinfo(struct net_device *netdev,
>
> igbvf/ethtool.c
> 167:static void igbvf_get_drvinfo(struct net_device *netdev,
>
> i40e/i40e_ethtool.c
> 1999:static void i40e_get_drvinfo(struct net_device *netdev,
>
> e1000/e1000_ethtool.c
> 529:static void e1000_get_drvinfo(struct net_device *netdev,
>
> ixgbevf/ethtool.c
> 211:static void ixgbevf_get_drvinfo(struct net_device *netdev,
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
> index d53369e30040..13a05604dcc0 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
> @@ -448,10 +448,10 @@ static void fm10k_get_drvinfo(struct net_device *dev,
>  {
>  	struct fm10k_intfc *interface = netdev_priv(dev);
>
> -	strncpy(info->driver, fm10k_driver_name,
> -		sizeof(info->driver) - 1);
> -	strncpy(info->bus_info, pci_name(interface->pdev),
> -		sizeof(info->bus_info) - 1);
> +	strscpy(info->driver, fm10k_driver_name,
> +		sizeof(info->driver));
> +	strscpy(info->bus_info, pci_name(interface->pdev),
> +		sizeof(info->bus_info));
>  }
>
>  static void fm10k_get_pauseparam(struct net_device *dev,
>
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231010-strncpy-drivers-net-ethernet-intel-fm10k-fm10k_ethtool-c-8184ea77861f
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>
Hi, this patch was bundled up with some others. It has a new home:

https://lore.kernel.org/all/20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com/
