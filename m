Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75700798A0F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244639AbjIHPfN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Sep 2023 11:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjIHPfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:35:12 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FDC1BFF;
        Fri,  8 Sep 2023 08:35:07 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d77a4e30e97so1940843276.2;
        Fri, 08 Sep 2023 08:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694187306; x=1694792106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+6VjZU2vxtVbghCxEX+9cbu10teXXLUQ8IVk0xjDXQ=;
        b=vgfhlVFsXG+MaevA54BlpPTuf0oA5Hxu6JV0q3F22WXVfNrcEEqRBF5GoUKOiVW3t/
         842b1UteDhaqi3+EWY7mF1FRkuxmWI1F/3au9HBShte7fDVqMuOc7Ao4ptjwX3xTpfNR
         bM6wyuKdbHjbiri7SnEzxjHrc0lCHUl/V/Gl3K4dJTLUvCvuwWPtC7gUefwxKIpHEyii
         50hO4W9PvsWzDNVO5Ib///QBKkBAGQGne2Gxt8j78huhBpGAI5Sax+wq8+AyEk3Yqt34
         Q7i4OFLCgrgFcW9rGsfADAzA+jQJO5J9TE9TYYDhmcYly5grA6/SJm+E033+K9KMfqh+
         mYZw==
X-Gm-Message-State: AOJu0YytBwJswkF3w2iXedoag9bHDQOHfMOxly1sY3GJPZ5oY5/30bGA
        X0jHcaYOAQOieU3mGpyYIGapxajtkxgtF5QM
X-Google-Smtp-Source: AGHT+IGlfgmlpj39lxfg+W5V2L7AOLFFrlfIEWzp1VCpb/mLlcm0AgsY/G9qZGcTKYhF6HXPUHeKcA==
X-Received: by 2002:a5b:e84:0:b0:d7b:97f3:4646 with SMTP id z4-20020a5b0e84000000b00d7b97f34646mr207507ybr.60.1694187306635;
        Fri, 08 Sep 2023 08:35:06 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id p198-20020a2574cf000000b00d749bc5b169sm411709ybc.43.2023.09.08.08.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 08:35:05 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5921a962adfso21875807b3.1;
        Fri, 08 Sep 2023 08:35:05 -0700 (PDT)
X-Received: by 2002:a25:adc3:0:b0:d07:60bd:89f4 with SMTP id
 d3-20020a25adc3000000b00d0760bd89f4mr2887335ybe.37.1694187305502; Fri, 08 Sep
 2023 08:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <7dfaf999-30ad-491c-9615-fb1138db121c@moroto.mountain> <CAL_JsqJB_pK-Q-Y-v6mWV1KwfL8sjFGgCcSL5gdrZm-TqxvBJg@mail.gmail.com>
In-Reply-To: <CAL_JsqJB_pK-Q-Y-v6mWV1KwfL8sjFGgCcSL5gdrZm-TqxvBJg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Sep 2023 17:34:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVep4Hib0iBabGdFfbCxdftWcJ8wfySGLB8GbmbSmBNhg@mail.gmail.com>
Message-ID: <CAMuHMdVep4Hib0iBabGdFfbCxdftWcJ8wfySGLB8GbmbSmBNhg@mail.gmail.com>
Subject: Re: [PATCH] of: dynamic: Fix potential memory leak in of_changeset_action()
To:     Rob Herring <robh@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        kbuild test robot <lkp@intel.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Sep 8, 2023 at 5:18 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, Sep 8, 2023 at 2:03 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > Smatch complains that the error path where "action" is invalid leaks
> > the "ce" allocation:
> >     drivers/of/dynamic.c:935 of_changeset_action()
> >     warn: possible memory leak of 'ce'
> >
> > Fix this by doing the validation before the allocation.
>
> I'm going to add a note when applying that "action" can't ever
> actually be invalid because all the callers are static inlines with
> hardcoded action values. I suppose there could be an out of tree
> module calling of_changeset_action() directly, but that's wrong given
> the wrappers.

FTR, the out-of-tree overlay configfs patches do not call
of_changeset_action() (or any of the wrappers).

> > Fixes: 914d9d831e61 ("of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/r/202309011059.EOdr4im9-lkp@intel.com/
>
> Despite what that says, it was never reported to me. IOW, the added TO
> and CC lines don't seem to have any effect.

The copy I received did list you in the "To"-header, though.
Fall-out of the issues seen with Gmail lately?
I do miss lots of email, too :-(

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
