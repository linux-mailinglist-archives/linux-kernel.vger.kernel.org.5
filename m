Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EF378F459
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347482AbjHaVCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345052AbjHaVCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:02:40 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23801C0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:02:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so16805945ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693515757; x=1694120557; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YPjmJfrcP1DlcVvCXznbWohWnUvBbmeVedMj4uSaPwY=;
        b=n+M30yIjH1Azx8OPIxyuNtwk7z7p3qzyAXgl9j/6QvquuUtp3tJgx5Xu9Lc78aAZhr
         Wnm2id4V/Og91GMBzoNIZmg3X9Vhxcl5XuLmcSiyKRq21WJy55uEpOAH7PZihN+L03jX
         0C1j8pSkemXlj+1Enxh1wck5C4laJgLzo3usQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693515757; x=1694120557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YPjmJfrcP1DlcVvCXznbWohWnUvBbmeVedMj4uSaPwY=;
        b=KP5Gc+/wEze1AyEt0aEW0xOwMsjMZD9zPJqSmshQehaH/ZJGU9YsgNkH2ndUvorCSI
         KzK/CAVxtXHwCPv50Sfivn6O9ZawlitkqRGtsmT7OM9vh9s4hHShniQ1N0aCnsopRYum
         nBZ9NNICs4xlj+an5jzB26QL/kv1Zz36ZhWeDTmLXUEnIj/tn9NOtgA+ZRC8t6MRih5L
         uiS2qvwSYcIfggoPlxmtSg+D5extYEyMly22viIo1LIocl/pzl09MZMgZRGQYuzeLeqO
         Al62h43c9pA94uGA5N+Z4tVyr7GXl1hKrAiByMuA4gt2A2T/TEGMVMqBnrlgPGP7RXke
         ay6w==
X-Gm-Message-State: AOJu0YwpBEUGMX3MWYuVzYGFHaoQbaQHbhhoJu7Mj7r/1cVA8Oyva7xf
        69IwQg6/Wm7i4/Qmb8CRwYEmgA==
X-Google-Smtp-Source: AGHT+IFEU9mcbMzKzrjRSeo06SsVZLZJ9AMVv07T/VwIDnFU2B4i9ZLF9BEAXIcYdSLlQyBKd7/Blw==
X-Received: by 2002:a17:903:244d:b0:1b2:676d:1143 with SMTP id l13-20020a170903244d00b001b2676d1143mr838409pls.15.1693515757554;
        Thu, 31 Aug 2023 14:02:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902d48400b001bc18e579aesm1641989plg.101.2023.08.31.14.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 14:02:36 -0700 (PDT)
Date:   Thu, 31 Aug 2023 14:02:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] scsi: target: Replace strlcpy with strscpy
Message-ID: <202308311402.8F9854D6A@keescook>
References: <20230831143638.232596-1-azeemshaikh38@gmail.com>
 <202308311141.612BF8D@keescook>
 <CADmuW3XpGR-jzq0SP8wVp+W3ZXZ9hgLpNrLrEox0K3Pyw5kfXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADmuW3XpGR-jzq0SP8wVp+W3ZXZ9hgLpNrLrEox0K3Pyw5kfXg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 03:20:47PM -0400, Azeem Shaikh wrote:
> On Thu, Aug 31, 2023 at 2:42 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Aug 31, 2023 at 02:36:38PM +0000, Azeem Shaikh wrote:
> > > strlcpy() reads the entire source buffer first.
> > > This read may exceed the destination size limit.
> > > This is both inefficient and can lead to linear read
> > > overflows if a source string is not NUL-terminated [1].
> > > In an effort to remove strlcpy() completely [2], replace
> > > strlcpy() here with strscpy().
> > >
> > > Direct replacement is safe here since return value of -errno
> > > is used to check for truncation instead of sizeof(dest).
> > >
> > > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> > > [2] https://github.com/KSPP/linux/issues/89
> > >
> > > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > > ---
> > > v3:
> > >  * Address readability comment.
> > >
> > > v2:
> > >  * Replace all instances of strlcpy in this file instead of just 1.
> > >  * https://lore.kernel.org/all/20230830210724.4156575-1-azeemshaikh38@gmail.com/
> > >
> > > v1:
> > >  * https://lore.kernel.org/all/20230830200717.4129442-1-azeemshaikh38@gmail.com/
> > >
> > >  drivers/target/target_core_configfs.c |   24 ++++++++++++------------
> > >  1 file changed, 12 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
> > > index 936e5ff1b209..d5860c1c1f46 100644
> > > --- a/drivers/target/target_core_configfs.c
> > > +++ b/drivers/target/target_core_configfs.c
> > > @@ -1392,16 +1392,16 @@ static ssize_t target_wwn_vendor_id_store(struct config_item *item,
> > >       /* +2 to allow for a trailing (stripped) '\n' and null-terminator */
> > >       unsigned char buf[INQUIRY_VENDOR_LEN + 2];
> > >       char *stripped = NULL;
> > > -     size_t len;
> > > +     ssize_t len;
> > >       ssize_t ret;
> > >
> > > -     len = strlcpy(buf, page, sizeof(buf));
> > > -     if (len < sizeof(buf)) {
> > > +     len = strscpy(buf, page, sizeof(buf));
> > > +     if (len > 0) {
> > >               /* Strip any newline added from userspace. */
> > >               stripped = strstrip(buf);
> > >               len = strlen(stripped);
> > >       }
> > > -     if (len > INQUIRY_VENDOR_LEN) {
> > > +     if (len < 0 || len > INQUIRY_VENDOR_LEN) {
> >
> > Agh, sorry I missed this before: the first "if" needs to be "len >= 0"
> > otherwise this:
> >
> >         ret = target_check_inquiry_data(stripped);
> >
> > will be passing a NULL pointer...
> >
> 
> Hmm, the current implementation of strscpy never returns 0. If
> sizeof(buf) is 0, it'll return -E2BIG. Do you still prefer that I
> update this to check for len >= 0?

Oh right! Nevermind, then. Fine as-is. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
