Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4217C613A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 01:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376524AbjJKXso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 19:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjJKXsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 19:48:43 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B139E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 16:48:40 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690bd8f89baso299324b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 16:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697068120; x=1697672920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fZzO6YTaJV0qoi4jnsT51ZDdw52HIuE18FHuP2cBJo=;
        b=GWs8H4GPfMM5mzErD7aVR49hUflIbzB6Mp5gyjZR0kOnPtXM1QXkmieGE4hQV0CLHN
         LilARLXa2LoksKSwjKnIpM3PNootQSj1CDm1jgy1L9/abt7WLNK2iNtsWqb/p1MptsVI
         lW7tK7Ki797w20bhiyHu3Eb3QlbUB7AqpQq1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697068120; x=1697672920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fZzO6YTaJV0qoi4jnsT51ZDdw52HIuE18FHuP2cBJo=;
        b=MFNLyIYDgVoTWzOmBYXMuxXS28AfzI6//6XZIbJIdEDtWJcX1R+FPdp6nyacSIRO6U
         aJFVejIpt4gM11CbNBL8SMjfbYvCEfHEFo1Rh7Bx7F2Q0EdAb0KgO5IjaffGPiZ9/Ay2
         kHX0NK2RkBx+0x+XayeAyayQuoHSFAYPDRWfd+AGoHtPcX3Kgx5kTllCgFGGtxoQlCTh
         zeP2f0RfXuG0m7k6QEx4XndiBu/BUf5G1NDvjW8Z1F7BGv1ELuTYmChKADR0bcP2xTu5
         L/UmKaEyJOmJkvw/TNiH7L079HW466jpCTVg8b3Vz1nW9WlB+98AHcPLiUQOABAn1YCR
         Gbvg==
X-Gm-Message-State: AOJu0YyYM4Hx+SKJBMIszd7YeoIx07NYHDEb7SvmEF2pVE5WB+P8X6Bc
        Fuhh91TUruGhZSkl/30bk9JErw==
X-Google-Smtp-Source: AGHT+IH7n0+1Hbon7uFg+Pyb/pPUwFdUxyN/LodG6gQ553s6pYqqG8GXmqgM1usNt1Llp5cxGSzWRQ==
X-Received: by 2002:a05:6a00:1388:b0:68c:a81:4368 with SMTP id t8-20020a056a00138800b0068c0a814368mr23630936pfg.6.1697068119984;
        Wed, 11 Oct 2023 16:48:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ka14-20020a056a00938e00b006a680745c8bsm5308310pfb.125.2023.10.11.16.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 16:48:39 -0700 (PDT)
Date:   Wed, 11 Oct 2023 16:48:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] qed: replace uses of strncpy
Message-ID: <202310111636.94AD8172F@keescook>
References: <20231011-strncpy-drivers-net-ethernet-qlogic-qed-qed_debug-c-v1-1-60c9ca2d54a2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011-strncpy-drivers-net-ethernet-qlogic-qed-qed_debug-c-v1-1-60c9ca2d54a2@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 10:20:10PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> This patch eliminates three uses of strncpy():
> 
> Firstly, `dest` is expected to be NUL-terminated which is evident by the
> manual setting of a NUL-byte at size - 1. For this use specifically,
> strscpy() is a viable replacement due to the fact that it guarantees
> NUL-termination on the destination buffer.
> 
> The next two changes utilizes snprintf() to make the copying behavior
> more obvious. Previously, strncpy() was used to overwrite the first 3
> characters of mem_name and type_name by setting a length argument less
> than the size of the buffers themselves. This enables, in a roundabout
> way, creating a string like "ASD_BIG_RAM" or "ASD_RAM". Let's just use
> snprintf() with a precision specifier to hold the name prefix to exactly
> 3 characters long.
> 
> To be clear, there are no buffer overread bugs in the current code as
> the sizes and offsets are carefully managed such that buffers are
> NUL-terminated. However, with these changes, the code is now more robust
> and less ambiguous (and hopefully easier to read).
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/net/ethernet/qlogic/qed/qed_debug.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_debug.c b/drivers/net/ethernet/qlogic/qed/qed_debug.c
> index cdcead614e9f..0a4fd1b04353 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
> @@ -3192,8 +3192,8 @@ static u32 qed_grc_dump_big_ram(struct qed_hwfn *p_hwfn,
>  {
>  	struct dbg_tools_data *dev_data = &p_hwfn->dbg_info;
>  	u32 block_size, ram_size, offset = 0, reg_val, i;
> -	char mem_name[12] = "???_BIG_RAM";
> -	char type_name[8] = "???_RAM";
> +	char mem_name[12];
> +	char type_name[8];
>  	struct big_ram_defs *big_ram;
>  
>  	big_ram = &s_big_ram_defs[big_ram_id];
> @@ -3204,8 +3204,11 @@ static u32 qed_grc_dump_big_ram(struct qed_hwfn *p_hwfn,
>  		     BIT(big_ram->is_256b_bit_offset[dev_data->chip_id]) ? 256
>  									 : 128;
>  
> -	strncpy(type_name, big_ram->instance_name, BIG_RAM_NAME_LEN);
> -	strncpy(mem_name, big_ram->instance_name, BIG_RAM_NAME_LEN);
> +	snprintf(mem_name, sizeof(mem_name), "%.*s_BIG_RAM",
> +		 BIG_RAM_NAME_LEN, big_ram->instance_name);
> +
> +	snprintf(type_name, sizeof(type_name), "%.*s_RAM",
> +		 BIG_RAM_NAME_LEN, big_ram->instance_name);

I actually think just replacing strncpy with memcpy makes more sense and
is what this code intended. It already assumes big_ram->instance_name is
always 3 characters (which it is):

static struct big_ram_defs s_big_ram_defs[] = {
        {"BRB", MEM_GROUP_BRB_MEM, MEM_GROUP_BRB_RAM, ...

        {"BTB", MEM_GROUP_BTB_MEM, MEM_GROUP_BTB_RAM, ...

        {"BMB", MEM_GROUP_BMB_MEM, MEM_GROUP_BMB_RAM, ...

So just copy those three bytes -- no need to call into sprintf for it.

>  
>  	/* Dump memory header */
>  	offset += qed_grc_dump_mem_hdr(p_hwfn,
> @@ -6359,8 +6362,7 @@ static void qed_read_str_from_buf(void *buf, u32 *offset, u32 size, char *dest)
>  {
>  	const char *source_str = &((const char *)buf)[*offset];
>  
> -	strncpy(dest, source_str, size);
> -	dest[size - 1] = '\0';
> +	strscpy(dest, source_str, size);
>  	*offset += size;
>  }

This one looks right to me.

-- 
Kees Cook
