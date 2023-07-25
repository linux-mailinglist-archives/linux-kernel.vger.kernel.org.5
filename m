Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA75760DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjGYJBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjGYJBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB614173D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690275607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10mn6aaFkPn0YdbwxtxpcKgA3YVJpkmRIrntoqjJVBU=;
        b=LkmgIj/FtCdgmkwQ48vRnOw9E9gLRfNt1nYr6M1/yHFBF/BeO1wYfFkPPD2bv0zXuHmqc6
        M+X7w6QfzoYUkT9ZCv0UUdMtZFPiOOTRGXX+OGZgeqDGb/xAv/pKkS4p36JCYcObQfDpCC
        HTVKZrvRyvijDEyqNpV2JdVW2VhsrMw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-TZdUSMPZNzWwOdNOBncfjA-1; Tue, 25 Jul 2023 05:00:04 -0400
X-MC-Unique: TZdUSMPZNzWwOdNOBncfjA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a356c74e0so362246366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690275603; x=1690880403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10mn6aaFkPn0YdbwxtxpcKgA3YVJpkmRIrntoqjJVBU=;
        b=JLCaUFsiYPiKrYcXiCk4sY4vqJU5O5Y8im15nNbEvNskSi9f/lfAIgXXqWN0cJ2cad
         VBzN0Rw649gQVD+0YKVvGkWCBsBC9VD3l+nvfkr9wlTcMIUK3UsFTRrWT58khKc6To5O
         Nn6ZhR9Kf3rLdTerlCajImI1Ol7pwLcy+KbqViKSh7Fzb0DBWADb5akkUqMW3BNHGLKA
         qqGJydvzeJt7GkzukZ8doriD2hDCSJwuJ54yVMFoN/gURBG8zCSZzLpFg6Sfjw24YOEA
         OViXXU8MPHct/TsEKwmHBFe+GTG8cXtpn91yFsHwvcjdCYmLnX49kEU0cf/pYnROo2ww
         bJgw==
X-Gm-Message-State: ABy/qLbKuZ07nmP910tif0EAKa4KaTtPii4otPKzKJ3nSe5wGqgUcpwn
        yLxWe2dTBrbi8mshzpSCcjmfEQHEKMMXvHNVA/HPm0mol9wQT2L+CVkkfgtQ+4TdArhacToxkm7
        T/JnD9uN6LGIGmUGJCV9J6NJvXfW6eOPR
X-Received: by 2002:a17:906:2d6:b0:992:d337:6e3e with SMTP id 22-20020a17090602d600b00992d3376e3emr11466732ejk.66.1690275603509;
        Tue, 25 Jul 2023 02:00:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGGRHa9OiYuLHkVAuKWwNap43VGDDNMYXat3TofzdFkTyTvlG7SdRfm1oxv0Yahopi3C2MBNw==
X-Received: by 2002:a17:906:2d6:b0:992:d337:6e3e with SMTP id 22-20020a17090602d600b00992d3376e3emr11466719ejk.66.1690275603183;
        Tue, 25 Jul 2023 02:00:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id dk14-20020a170906f0ce00b009930308425csm7931335ejb.31.2023.07.25.02.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 02:00:02 -0700 (PDT)
Message-ID: <e0c859de-ff1a-5975-081d-cdb9e4fbcb3b@redhat.com>
Date:   Tue, 25 Jul 2023 11:00:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] vboxsf: Use flexible arrays for trailing string member
Content-Language: en-US, nl
To:     Kees Cook <keescook@chromium.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20230720151458.never.673-kees@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230720151458.never.673-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees, Larry,

On 7/20/23 17:15, Kees Cook wrote:
> The declaration of struct shfl_string used trailing fake flexible arrays
> for the string member. This was tripping FORTIFY_SOURCE since commit
> df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3"). Replace the
> utf8 and utf16 members with actual flexible arrays, drop the unused ucs2
> member, and retriain a 2 byte padding to keep the structure size the same.
> 
> Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
> Closes: https://lore.kernel.org/lkml/ab3a70e9-60ed-0f13-e3d4-8866eaccc8c1@lwfinger.net/
> Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Kees, Larry thank you for fixing this while I was on vacation.

The patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Kees, I'm the vboxsf maintainer and it would be easiest for
me if you can include this in a future 6.5 fixes pull-request
to Linus if that is possible ?

Regards,

Hans



> ---
>  fs/vboxsf/shfl_hostintf.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/vboxsf/shfl_hostintf.h b/fs/vboxsf/shfl_hostintf.h
> index aca829062c12..069a019c9247 100644
> --- a/fs/vboxsf/shfl_hostintf.h
> +++ b/fs/vboxsf/shfl_hostintf.h
> @@ -68,9 +68,9 @@ struct shfl_string {
>  
>  	/** UTF-8 or UTF-16 string. Nul terminated. */
>  	union {
> -		u8 utf8[2];
> -		u16 utf16[1];
> -		u16 ucs2[1]; /* misnomer, use utf16. */
> +		u8 legacy_padding[2];
> +		DECLARE_FLEX_ARRAY(u8, utf8);
> +		DECLARE_FLEX_ARRAY(u16, utf16);
>  	} string;
>  };
>  VMMDEV_ASSERT_SIZE(shfl_string, 6);

