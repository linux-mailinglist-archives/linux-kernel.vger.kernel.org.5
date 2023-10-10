Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242F07C456F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343967AbjJJX2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJJX2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:28:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C43399
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 16:28:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2791747288cso4023285a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 16:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696980498; x=1697585298; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3ffyVmDvObFUQGm01LEbnK2a/NNSPjFeJ8aUijmhJtI=;
        b=motvlJD/CCSca8DU/gmwa6KBCkG7scvSfW8COtt2JmDGZqFL+7hZg8Ncynmys9Oa9D
         QQiwZTGU3Cs7Lm9/NT+Rkj/DIR3yW8sL27MMSnqPUt3lN1uHBtViBlGnuHimFrBSyA9E
         ITN9X5IRqBHIRf7381IoB+AOJNBElQkcQjKgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696980498; x=1697585298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ffyVmDvObFUQGm01LEbnK2a/NNSPjFeJ8aUijmhJtI=;
        b=sdLZSpasAOn+tO2Wk0XFYy+gMeAzL9M82vQPWbKzeHCWZVK8kC9bc0QmpL28gJMMBK
         xE82DpLNtUav05vcIyRmVDTnRii9u5LGyqzD4wF3egfd881ElGEch8zrbIFczDHVEZhb
         17oH+tawCK5YRjm2MsqgJKKImkF/DhHVieBRT9zh+9U8ZFiSYnwpBn00h2Ple7aulkkq
         MS7NyVfNhs+pXTXxfRIPXoOFgr687iD9XubzPSwKNNotFaaUmRGpy0tbSwLcOQNbRCUm
         5NIWlev4hHEdvwxV0uVB+DLm1zI8Dguy8n6DnSI++bILLySQ0FqrW4Qx7OYOHn4HPoGp
         PYkg==
X-Gm-Message-State: AOJu0YyfW9ZpEsdttSLhzZRL4k9VgA9IMqa6tigGVDLP93Bfv8PosGMY
        P7jkUac7Gro7a0HuFXqk6W89hA==
X-Google-Smtp-Source: AGHT+IEiG6MkiUeUM4CjFtvjNc39SCT6bmkPmjD94V4ggCDiykYfKvAabgK71CDQRK5wtqaWRWjRvw==
X-Received: by 2002:a17:90a:ab87:b0:27b:258f:2843 with SMTP id n7-20020a17090aab8700b0027b258f2843mr12673716pjq.7.1696980498575;
        Tue, 10 Oct 2023 16:28:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s15-20020a17090a5d0f00b00263cca08d95sm12446269pji.55.2023.10.10.16.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 16:28:17 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:28:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-hardening@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] net: intel: replace deprecated strncpy uses
Message-ID: <202310101625.175D43E7@keescook>
References: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
 <d84f2d4d-40d7-af15-0049-f8e1efed1eba@intel.com>
 <CAFhGd8pR4EdjVzHLKwxtH=OHNO1rLsuWAs=ZHX7hWohhE8Kcjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8pR4EdjVzHLKwxtH=OHNO1rLsuWAs=ZHX7hWohhE8Kcjg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 04:22:44PM -0700, Justin Stitt wrote:
> On Tue, Oct 10, 2023 at 4:19 PM Jesse Brandeburg
> <jesse.brandeburg@intel.com> wrote:
> >
> > On 10/10/2023 3:26 PM, Justin Stitt wrote:
> > > Hi,
> > >
> > > This series aims to eliminate uses of strncpy() as it is a deprecated
> > > interface [1] with many viable replacements available.
> > >
> > > Predominantly, strscpy() is the go-to replacement as it guarantees
> > > NUL-termination on the destination buffer (which strncpy does not). With
> > > that being said, I did not identify any buffer overread problems as the
> > > size arguments were carefully measured to leave room for trailing
> > > NUL-bytes. Nonetheless, we should favor more robust and less ambiguous
> > > interfaces.
> > >
> > > Previously, each of these patches was sent individually at:
> > > 1) https://lore.kernel.org/all/20231009-strncpy-drivers-net-ethernet-intel-e100-c-v1-1-ca0ff96868a3@google.com/
> > > 2) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-e1000-e1000_main-c-v1-1-b1d64581f983@google.com/
> > > 3) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-fm10k-fm10k_ethtool-c-v1-1-dbdc4570c5a6@google.com/
> > > 4) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-i40e-i40e_ddp-c-v1-1-f01a23394eab@google.com/
> > > 5) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-igb-igb_main-c-v1-1-d796234a8abf@google.com/
> > > 6) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-igbvf-netdev-c-v1-1-69ccfb2c2aa5@google.com/
> > > 7) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-intel-igc-igc_main-c-v1-1-f1f507ecc476@google.com/
> > >
> > > Consider these dead as this series is their new home :)
> > >
> > > I found all these instances with: $ rg "strncpy\("
> > >
> > > This series may collide in a not-so-nice way with [3]. This series can
> > > go in after that one with a rebase. I'll send a v2 if necessary.
> > >
> > > [3]: https://lore.kernel.org/netdev/20231003183603.3887546-1-jesse.brandeburg@intel.com/
> > >
> > > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> > > Link: https://github.com/KSPP/linux/issues/90
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> >
> > Thanks Justin for fixing all these!
> >
> > For the series:
> > Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> >
> > PS: have you considered adding a script to scripts/coccinelle/api which
> > might catch and try to fix future (ab)users of strncpy?
> 
> There is a checkpatch routine for it. Also, the docs are littered with
> aversions to strncpy. With that being said, I would not be opposed
> to adding more checks, though.
> 
> Once I'm more caught up on all the outstanding strncpy uses,
> I'll look into adding some coccinelle support.

Coccinelle for strncpy is difficult since each set of callers tends to
need careful examination. But the good news here is that at the current
rate, the kernel may be strncpy-free pretty soon. :)

-- 
Kees Cook
