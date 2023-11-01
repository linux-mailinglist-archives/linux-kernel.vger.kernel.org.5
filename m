Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F76A7DDFFF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjKALAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjKALAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:00:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1161FFC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 03:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698836355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ChCUMS4Z0zFJSSZC7NvVm2TXc5lFEMGFDVYjPFXyk18=;
        b=CBUGIDfGcAFMcZVYl+tBbboYHDpWHw/EJDSJpOT1YWgV6RztNp1jUfgg9Kus9rvMOWgsZW
        dlGM3ahyK4vfdMbXdXvK8drvEVoJkU0zj59ai6E45scT+mHeBXuvCl1vK5IFBV3+9qR69A
        0ficsu3p7bvpgmjNsWPOgoXckLAHlQ4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-fyY86f_8NsCcwA_q8KmtfA-1; Wed, 01 Nov 2023 06:59:13 -0400
X-MC-Unique: fyY86f_8NsCcwA_q8KmtfA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a681c3470fso453869666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 03:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698836352; x=1699441152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChCUMS4Z0zFJSSZC7NvVm2TXc5lFEMGFDVYjPFXyk18=;
        b=sq8wcFVyGvV7t2jDUNlemPNVpqpOG7SZSaBPt2Mf0soZBrWxWTgNLDZr/ZOkHgJ1KE
         yGJVZpEzAB8cRpgZS8WyTIbTjgKHdap0HNwIBcwFaBMj7xuTcoELjV326qyhzYGxoz0C
         eL1S2XIk7/gaE/lOlYzuVT2xtLMI1KWQqaHdzyPzWtpLxH8kzlCIlmkfavIYQQdYvGr+
         UCwqh1gJ7v2sHx0oHTibuitoIItJFhllWpliiJbrIcnH4eUpDxT8GDuJ35FKKb5Ug2Wc
         2qi1LNZwOUuP/iVDLIokLzXe6vL3RCj8omD0XF8Pv0Ni80QLOjmN612KiCivuBEAU0+D
         Ir2A==
X-Gm-Message-State: AOJu0YxlciinQcWpA4pKxMtX0TVdJa83Crw9IrUhykEupgrDUQpPBmm5
        0rrWkaPqpmgBcpKXHWVrOSretDCSv0HPdYh8J6ZuYzTUfOJ6h6DFtERmQcjzDMJx2WdmLa7L5cS
        +kdaqAa2RhV6xB7r7MsFZQ6Iv
X-Received: by 2002:a17:907:a44:b0:9be:b668:5700 with SMTP id be4-20020a1709070a4400b009beb6685700mr1473979ejc.58.1698836352534;
        Wed, 01 Nov 2023 03:59:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN4iF493a6l6vf8pkc7Vcdp9JsgvmrZwNhMEkxLmF5mmGf3XNHFkTZfmDTINO03oYIYYz4pw==
X-Received: by 2002:a17:907:a44:b0:9be:b668:5700 with SMTP id be4-20020a1709070a4400b009beb6685700mr1473967ejc.58.1698836352277;
        Wed, 01 Nov 2023 03:59:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a22-20020a1709062b1600b0099ddc81903asm2265963ejg.221.2023.11.01.03.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 03:59:11 -0700 (PDT)
Message-ID: <24e0ae5c-26bb-6efa-d59a-262541d2a452@redhat.com>
Date:   Wed, 1 Nov 2023 11:59:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] vboxsf: Avoid an spurious warning if load_nls_xxx()
 fails
Content-Language: en-US, nl
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <d09eaaa4e2e08206c58a1a27ca9b3e81dc168773.1698835730.git.christophe.jaillet@wanadoo.fr>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <d09eaaa4e2e08206c58a1a27ca9b3e81dc168773.1698835730.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 11/1/23 11:49, Christophe JAILLET wrote:
> If an load_nls_xxx() function fails a few lines above, the 'sbi->bdi_id' is
> still 0.
> So, in the error handling path, we will call ida_simple_remove(..., 0)
> which is not allocated yet.
> 
> In order to prevent a spurious "ida_free called for id=0 which is not
> allocated." message, tweak the error handling path and add a new label.
> 
> Fixes: 0fd169576648 ("fs: Add VirtualBox guest shared folder (vboxsf) support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thank you, both patches look good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans



> ---
>  fs/vboxsf/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> index 1fb8f4df60cb..9848af78215b 100644
> --- a/fs/vboxsf/super.c
> +++ b/fs/vboxsf/super.c
> @@ -151,7 +151,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>  		if (!sbi->nls) {
>  			vbg_err("vboxsf: Count not load '%s' nls\n", nls_name);
>  			err = -EINVAL;
> -			goto fail_free;
> +			goto fail_destroy_idr;
>  		}
>  	}
>  
> @@ -224,6 +224,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>  		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
>  	if (sbi->nls)
>  		unload_nls(sbi->nls);
> +fail_destroy_idr:
>  	idr_destroy(&sbi->ino_idr);
>  	kfree(sbi);
>  	return err;

