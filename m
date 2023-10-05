Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A027BAF30
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjJEXMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjJEXJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:09:40 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76897D5E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:09:27 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c60778a3bfso12438685ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 16:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696547367; x=1697152167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DoiIVSH2H/7Ehkj4/Ha1iKcbnVhKAH6CyOO+EjLparg=;
        b=ZTUg87L3qbyY/YdSC6Uv7LNgY63RUIaMacDUOJOoCzkdsw6c4iIwqfpyFRD9hSlsAp
         GrRihCD7NLnNKPkWWlz5TmNeOoN1cqBr4wxyNVsi4j/AoALqQ48jGzWJ0h2wgQFEEC9O
         lqpwzvT9FASKKWWYpk/corpZu6Hou9HK24jGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547367; x=1697152167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoiIVSH2H/7Ehkj4/Ha1iKcbnVhKAH6CyOO+EjLparg=;
        b=EiRCuTiJ6CgiVMWAwyxU7cvTBUJ2n48piG48GkrU3PMwv2KbN5MpUYelGm3n9Y0Snu
         2t0uI+m3r58FmQSfj4CJ/bpGynz+csBk0X+1W/OmiPFxRDU5824Fn6MQAdGM+FLfcJET
         b1HR62PbkRnMl5NtzwOp3exq9su+C3oshVodviWaXK/9dAncAgrqFa+6KiA2zJLeQW/w
         bHBu2vaYN2zUp1y/4xOUF1wgD/44S5Fkb9ViK1f90C8hZR4qF15Au4qQAZMpVFAppkTD
         BKetACBLwsizhMMbYZRX8GP2YqDeca4aCCCWfx8tztCaubo/DAYGBEXXKrQD3uZPS0eT
         i0KA==
X-Gm-Message-State: AOJu0YyB0MGSAquOgoYjbvqrRgQBu5cat7wrd0cF357w6dK6utmHuJPt
        WKA/tXyVmkhNdiKu1nEKvm75Iw==
X-Google-Smtp-Source: AGHT+IHcq5uCc483ikwSlkpjgM2nwnjHkpTW/XMhjMaTpuHs/FjHne5CGBFVVASfL01xWH04NCQt/g==
X-Received: by 2002:a17:903:22c3:b0:1c3:cee1:cc8e with SMTP id y3-20020a17090322c300b001c3cee1cc8emr7994677plg.68.1696547366933;
        Thu, 05 Oct 2023 16:09:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ja14-20020a170902efce00b001bd62419744sm2318235plb.147.2023.10.05.16.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 16:09:26 -0700 (PDT)
Date:   Thu, 5 Oct 2023 16:09:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bna: replace deprecated strncpy with strscpy
Message-ID: <202310051549.D76C508541@keescook>
References: <20231005-strncpy-drivers-net-ethernet-brocade-bna-bfa_ioc-c-v1-1-8dfd30123afc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-brocade-bna-bfa_ioc-c-v1-1-8dfd30123afc@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 09:05:42PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> bfa_ioc_get_adapter_manufacturer() simply copies a string literal into
> `manufacturer`.
> 
> NUL-padding is not needed because bfa_ioc_get_adapter_manufacturer()'s
> only caller passes `ad_attr` (which is from ioc_attr) which is then
> memset to 0.
>  bfa_nw_ioc_get_attr() ->
>    bfa_ioc_get_adapter_attr() ->
>      bfa_nw_ioc_get_attr() ->
>        memset((void *)ioc_attr, 0, sizeof(struct bfa_ioc_attr));
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
>  drivers/net/ethernet/brocade/bna/bfa_ioc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/brocade/bna/bfa_ioc.c b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
> index b07522ac3e74..497cb65f2d06 100644
> --- a/drivers/net/ethernet/brocade/bna/bfa_ioc.c
> +++ b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
> @@ -2839,7 +2839,7 @@ bfa_ioc_get_adapter_optrom_ver(struct bfa_ioc *ioc, char *optrom_ver)
>  static void
>  bfa_ioc_get_adapter_manufacturer(struct bfa_ioc *ioc, char *manufacturer)
>  {
> -	strncpy(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);
> +	strscpy(manufacturer, BFA_MFG_NAME, sizeof(manufacturer));
>  }

tl;dr: please use:

	strscpy_pad(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);

sizeof() will not work correctly here -- manufacturer is a char *,
so this will always be sizeof(unsigned long). Which begs the question,
why is an unbounded string being passed here? Yay fragile API.

I notice bfa_ioc_get_adapter_manufacturer() in drivers/scsi/bfa/bfa_ioc.c
does this:

        memset((void *)manufacturer, 0, BFA_ADAPTER_MFG_NAME_LEN);
        strscpy(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);

So, I think we should follow suit (but use strscpy_pad() instead to
avoid the partially redundant memset).

I also note that the "manufacturer" argument comes from many possible
structs, not just struct bfa_adapter_attr:

drivers/net/ethernet/brocade/bna/bfa_ioc.c:2761:        bfa_ioc_get_adapter_manufacturer(ioc, ad_attr->manufacturer);

	struct bfa_adapter_attr {
	        char            manufacturer[BFA_ADAPTER_MFG_NAME_LEN];

drivers/scsi/bfa/bfa_ioc.c:2698:        bfa_ioc_get_adapter_manufacturer(ioc, ad_attr->manufacturer);

	struct bfa_adapter_attr_s {
	        char            manufacturer[BFA_ADAPTER_MFG_NAME_LEN];

drivers/scsi/bfa/bfa_fcs_lport.c:2630:  bfa_ioc_get_adapter_manufacturer(&port->fcs->bfa->ioc,

	struct bfa_fcs_fdmi_hba_attr_s {
		...
	        u8         manufacturer[64];

This is unexpectedly large... I was expecting either 8 or
BFA_ADAPTER_MFG_NAME_LEN:

drivers/net/ethernet/brocade/bna/bfa_defs.h:31: BFA_ADAPTER_MFG_NAME_LEN    = 8,   /*!< manufacturer name length */
drivers/scsi/bfa/bfa_defs.h:259:        BFA_ADAPTER_MFG_NAME_LEN    = 8,   /*  manufacturer name length */

(But it seems not a problem, since it's memset() before...)

And there are more that I've check, since I also found this macro:

#define bfa_get_adapter_manufacturer(__bfa, __manufacturer)             \
        bfa_ioc_get_adapter_manufacturer(&(__bfa)->ioc, __manufacturer)

And there are multiple implementations of bfa_ioc_get_adapter_manufacturer(), it seems.

-- 
Kees Cook
