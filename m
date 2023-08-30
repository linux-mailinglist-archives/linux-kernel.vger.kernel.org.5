Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07D078E170
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241436AbjH3VaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239596AbjH3VaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:30:02 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2837CE8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:29:27 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-5733d431209so143570eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693430902; x=1694035702; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mX87NFpq5hOfvdT04Pm6d0i+GaLVpBWiM2uVOuPxz60=;
        b=cYHrhovLKJ0sEMTq4zgO8HS67HCdrzFmVUyOFqBC80H2PibOEVEyQmgob1ZHoz+uc3
         ReBfEXceHcuJIGzKuZg91AUrGrm/d7ab0MgnMD/KyCAc295wb3rSmU+XRPMeYeXaBpFA
         Aor+lq3y59gsc7+LGZd94tATl8pE/JJOxarXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693430902; x=1694035702;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mX87NFpq5hOfvdT04Pm6d0i+GaLVpBWiM2uVOuPxz60=;
        b=NEkweVXV+9o9ZKH0Myg4UX+f1ByNShvNmCXFkWqLkuQMOYef98XfTjzFoZipGrbU8B
         wTOBugz9TDeUHr5ckHVfWAr01KrWKILwwZhT98WZTD0bE/zL8hCDT8uE0jKGfRaxnqsq
         cxS2mhoTtg7YBVtTX9DULy7eZ4zy80y/DZEjTcVLTpNbvrvE88wCVM6DFt4ge5cqQ4Lr
         Q01T1CQInHLLp933sPQBm6UDpyMuvUM0bMTaAbUGEiBwuiJn+w3bmHfSlgDQqB7Fu3Wt
         tJwB2nkSYk6b/76a7eZ8corOe6ktuneuCRXV79AzB0BJz910YzMWqqsfAjbLo9a6aJ52
         XC+g==
X-Gm-Message-State: AOJu0YwkyJESU4A5fBpkKGu/kGIKb5UWZKmZtGHh6MQs1M4Co4InXG7Q
        70BXAcPejhZJyDBr1jCopCWU+w==
X-Google-Smtp-Source: AGHT+IGQ084nkb7iIsJ2XF+m82eh0ID/gW5Gdzzjqr3zKMtpOfpaWSrwZxRRJSR+a0zPwLsgAs5h0Q==
X-Received: by 2002:a05:6808:199e:b0:3a1:c108:41b1 with SMTP id bj30-20020a056808199e00b003a1c10841b1mr4046501oib.25.1693430902532;
        Wed, 30 Aug 2023 14:28:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i15-20020a63bf4f000000b00565e96d9874sm34815pgo.89.2023.08.30.14.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 14:28:21 -0700 (PDT)
Date:   Wed, 30 Aug 2023 14:28:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] vt: Fix potential read overflow of kernel memory
Message-ID: <202308301421.997C4034B5@keescook>
References: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
 <2023083035-unpadded-amulet-8c7e@gregkh>
 <CADmuW3Wbgb7s+jRm8F0hcjzreWysVdzNvv778yUbGCOxAJHwjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADmuW3Wbgb7s+jRm8F0hcjzreWysVdzNvv778yUbGCOxAJHwjQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 03:25:54PM -0400, Azeem Shaikh wrote:
> On Wed, Aug 30, 2023 at 1:57 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Aug 30, 2023 at 04:04:10PM +0000, Azeem Shaikh wrote:
> > > strlcpy() reads the entire source buffer first.
> > > This read may exceed the destination size limit if
> > > a source string is not NUL-terminated [1].
> >
> > But that's not the case here, right?  So your "potential read overflow"
> > isn't relevant here.
> >
> > > The copy_to_user() call uses @len returned from strlcpy() directly
> > > without checking its value. This could potentially lead to read
> > > overflow.
> >
> > But can it?  How?
> >
> 
> The case I was considering is when the null-terminated hardcoded
> string @func_table[kb_func] has length @new_len > @len. In this case,
> strlcpy() will assign @len = @new_len and copy_to_user() would read
> @new_len from the kmalloc-ed memory of @len. This is the potential
> read overflow I was referring to. Let me know if I'm mistaken.

First there is:

ssize_t len = sizeof(user_kdgkb->kb_string);

"struct user_kdgkb" is UAPI (therefore unlikely to change), and kb_string
is 512:

struct kbsentry {
        unsigned char kb_func;
        unsigned char kb_string[512];
};

Then we do:

                len = strlcpy(kbs, func_table[kb_func] ? : "", len);

This is the anti-pattern (take the length of the _source_) we need to
remove. However, func_table[] is made up of either %NUL-terminated
strings:

char func_buf[] = {
        '\033', '[', '[', 'A', 0, 
        '\033', '[', '[', 'B', 0, 
...
char *func_table[MAX_NR_FUNC] = {
        func_buf + 0,
        func_buf + 5,
...

Or a NULL address itself. The ?: operator handles the NULL case, so
"len" can only ever be 0 through the longest string in func_buf. So it's
what I'd call "accidentally correct". i.e. it's using a fragile
anti-pattern, but in this case everything is hard-coded and less than
512.

Regardless, we need to swap for a sane pattern, which you've done. But
the commit log is misleading, so it needs some more detail. :)

-Kees

-- 
Kees Cook
