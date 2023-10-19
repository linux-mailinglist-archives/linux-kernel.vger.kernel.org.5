Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0321B7CEF51
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjJSFsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjJSFsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:48:00 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2284911D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 22:47:58 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57ad95c555eso4270566eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 22:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697694477; x=1698299277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LHnQ4ZKZoaOJV3l4XUHkBLyFFjTJvcv5ctVeQO+EOoI=;
        b=BScxuSjU1tN8RG7REYbkpQsN/gjlJOIvo4nuTJngz/+YjIBlnxn1R+AShbC4MOlilt
         xhmvHTUVCD4onrT7hCFTGQfAldFbudd28nfsIlwsO59nL3qi/RqrGvfT9E9+koJIEMbW
         XBrcqxjTukOF0Azoty3rbORiNQ6OdbLVI9qnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697694477; x=1698299277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHnQ4ZKZoaOJV3l4XUHkBLyFFjTJvcv5ctVeQO+EOoI=;
        b=mtuv2PM8piA0hy1oY+Le1kAzRf6/WMuCoqbTUJIEDCM+9LgteA3/XepYHWW3IzucBu
         C+Z8tH0U2RCTpq3Ah94liQg/042VscZ/Woyrq1weQBpMRlr1CglyqiCgcDw/8E1UmvwW
         t30Fd7/HELjnPfqM4+jwkPdY/tpoBMRtedAHClAnW+Mld/583F1dkByx6DXJqn7VLagV
         tpWtTtLxOf9Mw2ZPj/hjsyFvR/GSJNQ4yvQ5b+n08Cqgoh1XCtNKvfDYTrWFCBFN5rbO
         +fEYiBzjUzxs+hK5U5mm84b1F1B+F0i3qRCZYeq3+gOUw8yO7XbF1WkPzyyko+/VMhmb
         q/YQ==
X-Gm-Message-State: AOJu0YxG7tF6JSCkOtrj0Y4WwPU3ZkKwYqQJ3CuMgwZCcZT2DCMILdyw
        zZT+udVdgndqCU/XDlfHkDojwvEyM/YlmzX7fmI=
X-Google-Smtp-Source: AGHT+IEu5PHDRWVUI0+QX9JrLp+wZUJ1GzmUN+Qx4C1JP4SsZPYFUoT1fuhYI5qBjJPg/eBSdZrWhg==
X-Received: by 2002:a05:6358:7e16:b0:143:8c4e:283b with SMTP id o22-20020a0563587e1600b001438c4e283bmr1422228rwm.0.1697694477305;
        Wed, 18 Oct 2023 22:47:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r2-20020aa79882000000b0069344caf840sm4422330pfl.18.2023.10.18.22.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 22:47:56 -0700 (PDT)
Date:   Wed, 18 Oct 2023 22:47:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-fabrics: replace deprecated strncpy with strscpy
Message-ID: <202310182237.C256F5B54D@keescook>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:48:49PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect both data->subsysnqn and data->hostnqn to be NUL-terminated
> based on their usage with format specifier ("%s"):
> fabrics.c:
> 322: dev_err(ctrl->device,
> 323:   "%s, subsysnqn \"%s\"\n",
> 324:   inv_data, data->subsysnqn);
> ...
> 349: dev_err(ctrl->device,
> 350: 	 "Connect for subsystem %s is not allowed, hostnqn: %s\n",
> 351: 	 data->subsysnqn, data->hostnqn);
> 
> Moreover, there's no need to NUL-pad since `data` is zero-allocated
> already in fabrics.c:
> 383: data = kzalloc(sizeof(*data), GFP_KERNEL);
> ... therefore any further NUL-padding is rendered useless.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> I opted not to switch NVMF_NQN_SIZE to sizeof(data->xyz) because the
> size is defined as:
> |       /* NQN names in commands fields specified one size */
> |       #define NVMF_NQN_FIELD_LEN	256
> 
> ... while NVMF_NQN_SIZE is defined as:
> |       /* However the max length of a qualified name is another size */
> |       #define NVMF_NQN_SIZE		223
> 
> Since 223 seems pretty magic, I'm not going to touch it.

struct nvmf_connect_data {
	...
        char            subsysnqn[NVMF_NQN_FIELD_LEN];
        char            hostnqn[NVMF_NQN_FIELD_LEN];

Honestly, the use of NVMF_NQN_SIZE as the length arg looks like a bug.

struct nvmf_ctrl_options {
	...
        char                    *subsysnqn;
	...
        struct nvmf_host        *host;

struct nvmf_host {
	...
        char                    nqn[NVMF_NQN_SIZE];

ctrl->opts->host->nqn is sized as NVMF_NQN_SIZE, so this is like saying:

	strscpy(dest, src, sizeof(src));

Which can go wrong when dest is smaller than src, but that's not the
case here. It seems ctrl->opts->host->nqn is expected to be a C string:

drivers/nvme/host/fabrics.h:        strcmp(opts->host->nqn, ctrl->opts->host->nqn) ||

And subsysnqn seems to be the same size:

drivers/nvme/target/core.c:     subsys->subsysnqn = kstrndup(subsysnqn, NVMF_NQN_SIZE,
drivers/nvme/target/core.c-                     GFP_KERNEL);

So these really look like bugs to me. Perhaps a follow-up patch to fix
this, if nvme maintainers agree?

Either way, strscpy is an improvement:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/nvme/host/fabrics.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 8175d49f2909..57aad3ce311a 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -386,8 +386,8 @@ static struct nvmf_connect_data *nvmf_connect_data_prep(struct nvme_ctrl *ctrl,
>  
>  	uuid_copy(&data->hostid, &ctrl->opts->host->id);
>  	data->cntlid = cpu_to_le16(cntlid);
> -	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
> -	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
> +	strscpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
> +	strscpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
>  
>  	return data;
>  }
> 
> ---
> base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
> change-id: 20231018-strncpy-drivers-nvme-host-fabrics-c-416258a22598
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook
