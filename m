Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7F17BAF47
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjJEXWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjJEXUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:20:49 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFE62108
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:18:28 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3ae35773a04so1010497b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 16:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696547907; x=1697152707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+MzswgELJWyE4HvVCrp29nzFh/L1Jc6Rtaa/JFCP/Q=;
        b=ZSj0Dq7kvdgnzBsKVyad1cLSdIJxqm3r3xIHtXTx2PfANEzLb3FSnJ6aTKwP9WvKI2
         /FB7noCbnYEMcjkmDb6dyPMQmQ0JkQGR0pylVWRBO3wZzNJfMAFqETJ0dsZ+46gSRykq
         lBXjAE9v2mlrnjq4MPIBfCT4hpMf6qfqSm9rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547907; x=1697152707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+MzswgELJWyE4HvVCrp29nzFh/L1Jc6Rtaa/JFCP/Q=;
        b=QNh6NQP6YdhuhvqfqCKMa0YD4EbDYYhJtYnU7oa8nLHLxDN95NLV6oLQIYTmFH7hdI
         NIkHdsX/gQooHXc8wIvapNa2cdUeuvktYs0Hc3dAIubYfQKbLJX9hEJ3uycPx3b1zXrQ
         THXMjVZvrIY73rTr9+m/n7A+dX6fiJawl6htIHRz3MdE/WYf3hTeMLv2lyUFzhDkO/n5
         nG6yxqC5LjlFD2540dR/wMD0u6NfTDwN8zpAYLwSHiP1giO4ti47BX7p3StYplB/3XEy
         hjCgPbLW+Jthgw3l+kK3Hwa1iYfhuv/sFrVwWSka9b6ilVX5vksTzHNoG8MXF8WfTKjK
         zEIA==
X-Gm-Message-State: AOJu0Yw3PQBPI9wUZzlax2oR1+vnLBG4Fh2nmm5fZeThUoQjFgzp4Zgy
        bRBINqPxBtKDsroIKQh70XGFkw==
X-Google-Smtp-Source: AGHT+IHGoNiuevjMInyHI3QzyPLyVu1ZpjZXrQHOjn6YWfgQenTUDzLdtnZOe3kcEPnafe0ghnCLmQ==
X-Received: by 2002:a05:6358:7e87:b0:13f:e3eb:53a6 with SMTP id o7-20020a0563587e8700b0013fe3eb53a6mr5785371rwn.30.1696547907255;
        Thu, 05 Oct 2023 16:18:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a19ce00b00277371fd346sm4462196pjj.30.2023.10.05.16.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 16:18:26 -0700 (PDT)
Date:   Thu, 5 Oct 2023 16:18:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] liquidio: replace deprecated strncpy with strscpy
Message-ID: <202310051617.3C4A40C5@keescook>
References: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_vf_rep-c-v1-1-92123a747780@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_vf_rep-c-v1-1-92123a747780@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 09:55:06PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not required as rep_cfg is memset to 0:
> |       memset(&rep_cfg, 0, sizeof(rep_cfg));
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
> index 600de587d7a9..aa6c0dfb6f1c 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
> @@ -638,7 +638,8 @@ lio_vf_rep_netdev_event(struct notifier_block *nb,
>  	memset(&rep_cfg, 0, sizeof(rep_cfg));
>  	rep_cfg.req_type = LIO_VF_REP_REQ_DEVNAME;
>  	rep_cfg.ifidx = vf_rep->ifidx;
> -	strncpy(rep_cfg.rep_name.name, ndev->name, LIO_IF_NAME_SIZE);
> +	strscpy(rep_cfg.rep_name.name, ndev->name,
> +		sizeof(rep_cfg.rep_name.name));

struct lio_vf_rep_req {
	...
        union {
                struct lio_vf_rep_name {
                        char name[LIO_IF_NAME_SIZE];
                } rep_name;

Yup, sizeof(rep_cfg.rep_name.name) == LIO_IF_NAME_SIZE.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
