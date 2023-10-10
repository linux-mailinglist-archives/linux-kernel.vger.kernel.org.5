Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215DC7C4464
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjJJWmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjJJWmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:42:51 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F76399
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:42:49 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-79fca042ec0so248062239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696977769; x=1697582569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5epg5slVi2ZMZ2XCdkm8B/4iSOhQb3T0qsBgHlWnKI=;
        b=G5I1941gI6rQBPq7eXyI3NrqWeXDwQ7ztwIrGkYXd0AISTMJnQ5Lf/XpUXcgL8yQ90
         68Zd8oaptqJ2l2MK61Igc7ZZu4Hy0EOMszfT//Wo8HPX8nJh7q3tQ9xyGxEi7lvSP8jS
         KCWVbsoMg2s4zZFUhlVfxiVo4Lx0p9Lm0YXjfqqPAHq9ke+gwaO0FSZPSa0ocOKZ/52z
         baz3RIrYElun1W7JzYEJ3tATUE1Ejwb68dxevy3RjdtbbB9Wupo5TXdcvBQGoJHeWG67
         +ogZPATQEs93U4yDCR15PKJsPIJQiWmYTimV5zUPxBOob20v5VdnXVGZQTiwdBbpBRRe
         CE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696977769; x=1697582569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5epg5slVi2ZMZ2XCdkm8B/4iSOhQb3T0qsBgHlWnKI=;
        b=QUgAhZSQyRMQYnSMbfJUJFzPYVNJVCeVJ2FviEp8CEBviEDg68bd/7GPo0TUXYRyCN
         hKq2GQeoUfmOeqFJSVsChy2dvIwmlY8CU5GRoNoXUXVgNANSEDsmJTdHdN4ythrio+j5
         OhQte+QO86LUpoOMWSMnAzrOBUgde8sMG/5sPdghzoCpg1JDfp8fAjT36LClP5j7nYnH
         2wxnTPm/imLXtHSp8dDdrGnBdhRnM/7BHx2il/nd9vP1Bd+r/doxn1pVGJpacyVtp/13
         eCWvy2cz8tqECdSZ1Ks39wtDDy9Lp/pCAnemw/7AaCP9Ao2DQKnQBcnFCPY+WqkVZNW5
         QxYA==
X-Gm-Message-State: AOJu0Yyk7fQsx/NsPxb7peuHPS+I1p6YOSQOaM6hMARAuPA/O9eAAafa
        Rt0E0Na35o4Wf9lG6gjkU3X+Qg==
X-Google-Smtp-Source: AGHT+IGYNa3gzIhjt40GIF5yGfmofKxjAmOdD0gzDqAUw0ZpUfFc3Tji+MMCm1XS+RHalBJ6bgVecQ==
X-Received: by 2002:a5e:dd0d:0:b0:786:7100:72de with SMTP id t13-20020a5edd0d000000b00786710072demr20110506iop.16.1696977768722;
        Tue, 10 Oct 2023 15:42:48 -0700 (PDT)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id ee24-20020a056638293800b004332f6537e2sm3057256jab.83.2023.10.10.15.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:42:48 -0700 (PDT)
Date:   Tue, 10 Oct 2023 22:42:45 +0000
From:   Justin Stitt <justinstitt@google.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] igc: replace deprecated strncpy with strscpy
Message-ID: <20231010224245.i57oix72csm7kjp7@google.com>
References: <20231010-strncpy-drivers-net-ethernet-intel-igc-igc_main-c-v1-1-f1f507ecc476@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-strncpy-drivers-net-ethernet-intel-igc-igc_main-c-v1-1-f1f507ecc476@google.com>
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

On Tue, Oct 10, 2023 at 09:15:39PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> We expect netdev->name to be NUL-terminated based on its use with format
> strings:
> |       if (q_vector->rx.ring && q_vector->tx.ring)
> |               sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,
>
> Furthermore, we do not need NUL-padding as netdev is already
> zero-allocated:
> |       netdev = alloc_etherdev_mq(sizeof(struct igc_adapter),
> |                                  IGC_MAX_TX_QUEUES);
> ...
> alloc_etherdev() -> alloc_etherdev_mq() -> alloc_etherdev_mqs() ->
> alloc_netdev_mqs() ...
> |       p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
>
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
>
> Let's also opt for the more idiomatic strscpy usage of (dest, src,
> sizeof(dest)) instead of (dest, src, SOME_LEN).
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 98de34d0ce07..e9bb403bbacf 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -6935,7 +6935,7 @@ static int igc_probe(struct pci_dev *pdev,
>  	 */
>  	igc_get_hw_control(adapter);
>
> -	strncpy(netdev->name, "eth%d", IFNAMSIZ);
> +	strscpy(netdev->name, "eth%d", sizeof(netdev->name));
>  	err = register_netdev(netdev);
>  	if (err)
>  		goto err_register;
>
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231010-strncpy-drivers-net-ethernet-intel-igc-igc_main-c-26efa209ddb5
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>
Hi, this patch was bundled up with some others. It has a new home:

https://lore.kernel.org/all/20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com/
