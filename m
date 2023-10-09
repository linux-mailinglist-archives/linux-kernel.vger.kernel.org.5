Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F777BEA3C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377520AbjJITBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378218AbjJITBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:01:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE94EA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:01:26 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690ce3c55f1so3565791b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 12:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696878086; x=1697482886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3IFH55pRhzV5onmAR0V0RcmvgjZQ6iKkHWC3kCd8jJc=;
        b=RW2u+ZsCtAs38ITe1AJ6KufCuMKAsJwjkNJT4rxdSYjpdQMCv7RbQI+DUqNjjZrruK
         hxzk2f8rE+QeAsfMutPGo5Htnq3HSKkuPdEZUglq6uBTg8qwvHC4tly7lVp1tIkUqjjy
         CbqpRqf3gQR9HXoosqwEN6WrDSWQeJBi4HGqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696878086; x=1697482886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IFH55pRhzV5onmAR0V0RcmvgjZQ6iKkHWC3kCd8jJc=;
        b=DIhXx7G/EqgoGBFYnZkNcDirUxMs0WHUFUsbRcWoNPq8REWhZ1MpdbHgTVxQ3VdDNb
         HgaKMrFoSyVT9Y/SCiLRpq3HJF2Jm5ASlCncIjSCiiqRzIoSqdsJPzbcyuya3214L/d3
         s2QD//rvf7eGQ0oljLwyawd9aIslRJ8IaZCRloa97nDgL3+DP6lJv/E/KIK6gshtRW7X
         K3NCwSPyXwT3pJIU/KsKX+H4LXwsAQR2CNTrSoR+RupB6OdG2BchHohNBvTp5Q8J9BOo
         xKpACVwCzFFgyXwZpe7Ny6Sc5qp+Ev01KKo3zDP1Hg4HmqMQkNS/pGLltC919LQ6xEDz
         TovA==
X-Gm-Message-State: AOJu0Yx/0wc6iJogQF2r1OtvXklb0k3sOmVHp5WRQqHroLeuZxH4gowR
        gR6UHqXD51wrENnVt4LpOjnmpA==
X-Google-Smtp-Source: AGHT+IEdiLUEPaXGkHEsA/tYV+jvxhXR25Tgergrl7cSdjdxq9CSr6ZJuinl4dMflGBaKnVK+mZmDw==
X-Received: by 2002:a05:6a00:b82:b0:68f:e810:e894 with SMTP id g2-20020a056a000b8200b0068fe810e894mr17362981pfj.33.1696878085896;
        Mon, 09 Oct 2023 12:01:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f24-20020aa78b18000000b0068fd026b496sm6613220pfd.46.2023.10.09.12.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:01:25 -0700 (PDT)
Date:   Mon, 9 Oct 2023 12:01:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] xen/xenbus: Add __counted_by for struct
 read_buffer and use struct_size()
Message-ID: <202310091200.2DFF1FE4B5@keescook>
References: <ZSRMosLuJJS5Y/io@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRMosLuJJS5Y/io@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 12:55:30PM -0600, Gustavo A. R. Silva wrote:
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

Looks good. There are going to be lots of 1-byte flex array members...

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
