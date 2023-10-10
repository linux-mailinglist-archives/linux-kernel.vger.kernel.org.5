Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9549C7C4519
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjJJWxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjJJWxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:53:37 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B1B99
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:53:35 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c7373cff01so2709945ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696978415; x=1697583215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sM2D1z73zi+5HYrcOqeqetxrp6E/x8mIV2xfN5N2igs=;
        b=DM92OVe/C6YiKLrtiL2N8KFHcGveutEPVbhbsoYAq2nse0Gy7k7dQfxjFlWDRNa3hm
         No3QxubAVLFg5Ygt4kf/s3slq3FsYMP+xa8uFN8Uizy372mas1041Z6Q6ZwOJ5EYQ+zx
         /8HAPQwsljYJZ2WWlQOjTH28PhubKfVem091E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696978415; x=1697583215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sM2D1z73zi+5HYrcOqeqetxrp6E/x8mIV2xfN5N2igs=;
        b=Nxsr4hqdHh2qn0uYibuy9JAZeulv+4jm5cxI+cpqE3XNIQo6Lng95NUbDRCGIod0AX
         wlPhXaQ9LLyB68y6oY12U/En2yPawr/CWFaQ4gIGscQ8XGjvvs5sFHGS91yDI8UKWxYJ
         6lYkD9/i08fUQddPpoBZHYvbHNRE8M6UGIq+mpEeBVmqlOkSSx87x6OmXMZBU/U4bvUn
         PGKAtvhL2vptW5EMMmXVJKAvsB/Pe//RWCGEVnY2rqr7eAvVebB00+MQReiuOUvVK7uI
         LfY92mHpoDFsIGc2V/QYOSKFg9vfv7zDV9cJpfDF+yX8MwOn2qKZLaQ90PZBUQHYFrU5
         IP1w==
X-Gm-Message-State: AOJu0YxhLDLjT7YZxXKkhbOb8+Zbq8aw1Dgcyv3P+8z1qmGQGVQ/GoCf
        trKmMg/DAxZy4bL3ABBvTc0Mng==
X-Google-Smtp-Source: AGHT+IF5qzcdrI8/uAq34pNGWTaPSCwg++M1k0mWJv9CMAIOsIQmhZyd+wlOKIN+dREI7d5oXJ4TwQ==
X-Received: by 2002:a17:903:493:b0:1c0:bcbc:d66 with SMTP id jj19-20020a170903049300b001c0bcbc0d66mr20932044plb.7.1696978415300;
        Tue, 10 Oct 2023 15:53:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b001bde65894c8sm1782132pls.268.2023.10.10.15.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:53:34 -0700 (PDT)
Date:   Tue, 10 Oct 2023 15:53:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] afs: Add __counted_by for struct afs_acl and use
 struct_size()
Message-ID: <202310101552.3578F46@keescook>
References: <ZSVKwBmxQ1amv47E@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSVKwBmxQ1amv47E@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 06:59:44AM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/afs/internal.h | 2 +-
>  fs/afs/xattr.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index 469a717467a4..e263a58b82ba 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -1116,7 +1116,7 @@ extern void afs_fs_inline_bulk_status(struct afs_operation *);
>  
>  struct afs_acl {
>  	u32	size;
> -	u8	data[];
> +	u8	data[] __counted_by(size);
>  };

It's surprising how many of these 2-member structs we have in the kernel
that do the same basic thing. :)

And I see that "size" is assigned before using "data", good.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
