Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17647C4442
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjJJWgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjJJWg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:36:28 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCB3A4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:36:26 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7a2a3fb0713so234739939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696977385; x=1697582185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fp1+19JThVDp5aV8ZmVBXvT9jXnK6YGxCfcTc284ZzQ=;
        b=SHjyVqsBKPTMwlV0lC4fzUyyQa1JFIIiGfTULar5DkF6EuFdmk9QiqZ5eRvezbU7XU
         ZHSeAJhzLbwUZwH+T1Vd29I7DlyutJjvfQH60HWr6Q9F+OcF5CvXGxV+EhnHErdG0Zvg
         qeNH9XvXj46BDGtDNXpFS2jXodRlmSdtKbwSQMLM1T1GScttYsLmgbJ7fJIOw5IW9bWn
         /O61iO83caXEbswsdwOHlU1OT0xFo4eG5vaygWV7RD5iMKYzW8u51A43hqF36+WSoYCe
         DpZ2OvVQeIe5aLwwN8wstCf8j+zK4A4wbqOTaEy6w1ZuV4bitGtvnDf7uEVyWJRD+lPZ
         08Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696977385; x=1697582185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fp1+19JThVDp5aV8ZmVBXvT9jXnK6YGxCfcTc284ZzQ=;
        b=fp7gMOzUeL1PatK48pYBKuKIoLJnKzoW36m7GNPOC/iJ9ViWZAHHltMclUq/+ALauG
         jDErXSfwEsuTSrV7gehjFD2CjKswYsxT6aiUcOtehFaqpTANUrQXD0jSpopxI601+33q
         vvFfVRQ7e9YaC4kS1ZF4yKLktldakcnPU9xA9l6+4GJkBmXnr0Gnn0yIOIUAHn3Hqhr0
         30se+qh1acXfxT5rS1wmGPecrN5KZg6yziFLtZIE5Kk22eldAAZ3QUBFv4LPMFs4AGuB
         AIBMqdIaRWdFw9m9mJqcOHigA+4kM0QbNETintSGmx//JoCOzVkgUMu4Py0TjvecpkNs
         Tosg==
X-Gm-Message-State: AOJu0YwbRLdbpENvyXOk6brjjN1IdNIKPZBXNrbIeMcLxhvL0TIzy2PC
        QHdX0+L9c83WtuF70XVA3rsHbw==
X-Google-Smtp-Source: AGHT+IEoHPDq/5iygy94KT86qlz3QZwHbRQso0lz7RaMmjKkCunaMgvNTfv7uf58Yir3pWdJMnT3eQ==
X-Received: by 2002:a6b:e704:0:b0:78b:b892:e334 with SMTP id b4-20020a6be704000000b0078bb892e334mr22796097ioh.11.1696977385502;
        Tue, 10 Oct 2023 15:36:25 -0700 (PDT)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id dp19-20020a0566381c9300b0043a1a45a7b2sm3051398jab.62.2023.10.10.15.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:36:24 -0700 (PDT)
Date:   Tue, 10 Oct 2023 22:36:22 +0000
From:   Justin Stitt <justinstitt@google.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] e1000: replace deprecated strncpy with strscpy
Message-ID: <20231010223622.tnurv2ujreo56qwz@google.com>
References: <20231010-strncpy-drivers-net-ethernet-intel-e1000-e1000_main-c-v1-1-b1d64581f983@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-strncpy-drivers-net-ethernet-intel-e1000-e1000_main-c-v1-1-b1d64581f983@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 06:35:59PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> We can see that netdev->name is expected to be NUL-terminated based on
> it's usage with format strings:
> |       pr_info("%s NIC Link is Down\n",
> |               netdev->name);
>
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
>
> This is in line with other uses of strscpy on netdev->name:
> $ rg "strscpy\(netdev\->name.*pci.*"
>
> drivers/net/ethernet/intel/e1000e/netdev.c
> 7455:   strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
>
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> 10839:  strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index da6e303ad99b..1d1e93686af2 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -1014,7 +1014,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	netdev->watchdog_timeo = 5 * HZ;
>  	netif_napi_add(netdev, &adapter->napi, e1000_clean);
>
> -	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
> +	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
>
>  	adapter->bd_number = cards_found;
>
>
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231010-strncpy-drivers-net-ethernet-intel-e1000-e1000_main-c-a45ddd89e0d7
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>
Hi, this patch was bundled up with some others. It has a new home:

https://lore.kernel.org/all/20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com/
