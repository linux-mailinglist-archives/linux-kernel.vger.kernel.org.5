Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917D87ADE8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjIYSTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjIYST2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:19:28 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AF495
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:19:22 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3ab2a0391c0so4537425b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695665961; x=1696270761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iTuU49n18VYSBeYT+lBU1flo4trajW5dqzu15DzOflI=;
        b=INAhMXKS0Y91O/3G22ZY5gdu0G60yWxbkhL6vXaSpbulgFnal56SN9tSoM+TRQFaDw
         fb32mMWhictORyrkvXvpbc5Dfxox+vI8tpbMmUOrdBEA4DdzMB5asYIq218wKjjioRJG
         Ob31OicQpsNKEdxvpB4BSZmx8V1BbdJC2dv6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695665961; x=1696270761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTuU49n18VYSBeYT+lBU1flo4trajW5dqzu15DzOflI=;
        b=qSFFZqF1Tclq0GZweGOvOH2B2oVHvRYx19e1O0i2cJzv00ItSaV5xqFqYnggbgK237
         b2VtPlo0INMPPXftkJUnCaRdVnJyVW0lTSFD91eRM6NZnp2TsSGLXwfKgfELI7xLwHRB
         EwwIlT0Yc5JVfHLJ1JeTFzj2+diWwKQB4U4y24y6OyyC62jIQJVHJRF0F9/DYHJrIbAq
         73DN8sXS+fyI5T9FVS3K634EgN5dxN6WdpUxacehnw9igcp82adBdexQ6Orw3lyZlEXC
         hT/1jhvznogY5aFWM59yWUcgFrrdPVpUkcBqy93ryI5KIXLhzdPUQDdao1t6JZRloLIq
         8zpQ==
X-Gm-Message-State: AOJu0Yxjo2JjFG4DteNCFXbSQlHRGDjKMRQNlqPtM1arbL//Q0Jarw4A
        OPtmF/V7Zqc+fDcH83KhdnwRQRcnO62oRtsNX/c=
X-Google-Smtp-Source: AGHT+IHx6BfOfHDMJM4u4SbWnBpvZYEK3N4VRzJDRxi/bvyhpBGykczqAdZZ1m/m8+89wVmMWrEqKg==
X-Received: by 2002:a05:6808:2094:b0:3ad:f536:2f26 with SMTP id s20-20020a056808209400b003adf5362f26mr11219365oiw.18.1695665961389;
        Mon, 25 Sep 2023 11:19:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j26-20020aa7801a000000b0068be3489b0dsm8616363pfi.172.2023.09.25.11.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:19:20 -0700 (PDT)
Date:   Mon, 25 Sep 2023 11:19:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dm ioctl: replace deprecated strncpy with strscpy_pad
Message-ID: <202309251109.5AEBF4369@keescook>
References: <20230925-strncpy-drivers-md-dm-ioctl-c-v1-1-f0bfa093ef14@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925-strncpy-drivers-md-dm-ioctl-c-v1-1-f0bfa093ef14@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 06:54:51AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect `spec->target_type` to be NUL-terminated based on its use with
> a format string after `dm_table_add_target()` is called
> | 	r = dm_table_add_target(table, spec->target_type,
> | 				(sector_t) spec->sector_start,
> | 				(sector_t) spec->length,
> | 				target_params);
> ... wherein `spec->target_type` is passed as parameter `type` and later
> printed with DMERR:
> |       DMERR("%s: %s: unknown target type", dm_device_name(t->md), type);
> 
> It appears that `spec` is not zero-allocated and thus NUL-padding may be
> required in this ioctl context.

Yeah... this one was a bit odd. I see the memory being filled from
userspace in copy_params(), so it's unlikely there was any kernel memory
content leaking, but I think the old code may have been buggy:

		strncpy(spec->target_type, ti->type->name,
			sizeof(spec->target_type) - 1);

I can't find any reason to think that
spec->target_type[sizeof(spec->target_type) - 1] would be %NUL after
this code runs.

get_result_buffer() is basically:
        return ((void *) param) + param->data_start;

then:

        outptr = outbuf = get_result_buffer(param, param_size, &len);
	...
                spec = (struct dm_target_spec *) outptr;

and before that:

        r = copy_params(user, &param_kernel, ioctl_flags, &param, &param_flags);

        if (r)
                return r;

        input_param_size = param->data_size;
        r = validate_params(cmd, param);
        if (r)
                goto out;

        param->data_size = offsetof(struct dm_ioctl, data);
        r = fn(file, param, input_param_size);

Notably validate_params() %NUL-terminates some _other_ strings, but
doesn't clear the param->data area.

So I think this is actually fixing a bug too, but I can't quite tell.

Regardless, the change looks correct:

Reviewed-by: Kees Cook <keescook@chromium.org>

> 
> Considering the above, a suitable replacement is `strscpy_pad` due to
> the fact that it guarantees NUL-termination whilst maintaining the
> NUL-padding behavior that strncpy provides.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/md/dm-ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> index 21ebb6c39394..e65058e0ed06 100644
> --- a/drivers/md/dm-ioctl.c
> +++ b/drivers/md/dm-ioctl.c
> @@ -1295,8 +1295,8 @@ static void retrieve_status(struct dm_table *table,
>  		spec->status = 0;
>  		spec->sector_start = ti->begin;
>  		spec->length = ti->len;
> -		strncpy(spec->target_type, ti->type->name,
> -			sizeof(spec->target_type) - 1);
> +		strscpy_pad(spec->target_type, ti->type->name,
> +			sizeof(spec->target_type));
>  
>  		outptr += sizeof(struct dm_target_spec);
>  		remaining = len - (outptr - outbuf);
> 
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20230925-strncpy-drivers-md-dm-ioctl-c-ea5c10e77981
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook
