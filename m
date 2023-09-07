Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24DD7974EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjIGPmW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Sep 2023 11:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjIGPjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:39:18 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EED11BFC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:37:19 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-57358a689d2so643857eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100982; x=1694705782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARN4xuhYZ7lSwH89iRCy1ksYn1EV+NyFN8++9iEiUo4=;
        b=QmTIbyiFCtuGkMBj93Uz8hoBVh3aT0NrxkoXJTlFgoTsglxKSY0fbwhYzWm1++kxT4
         koP9LJgWTbGh0CNhlP67p7CcRx6JsyckP0TGCv17u5hmQM9fUhHEwU0Tw5nRpbwQr40L
         6CE85m0sBGCTIVc+OLjhYZeCxxMvDro7JGq/IwvMDfTb/LWk0kE0mKIOR5VAosZaO8r4
         fqVKNu9m5Cvh/S8bLt3rW8yikxjMPY8HACcxeBdHJLA617hlvtSpm65l9Qu4MXbJ5Bx6
         8EdVGmla3RYix+h77vzU2BakSsjcf2Px2JkdCUh3z2XI4rSJB9LijiSFsk2aYJL0lyZL
         qEBw==
X-Gm-Message-State: AOJu0YxT9xs2NVZ0pCk9QMjCwsrorZacUzkvpTizWtm8Htyf6V6SNF+Y
        zg6fsLPZC5K7OH2l0b4KreZllnPubZup5w==
X-Google-Smtp-Source: AGHT+IFYyb2+uEqBvYccX5wcs7nXU2QXb/ienIGWQs/muAlB93P622LeWSkBFBX1u6VEcuBcu47GOw==
X-Received: by 2002:a05:6808:f12:b0:3a7:8725:f37c with SMTP id m18-20020a0568080f1200b003a78725f37cmr23332921oiw.10.1694086222554;
        Thu, 07 Sep 2023 04:30:22 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id y126-20020a0def84000000b005869fd2b5bcsm4249623ywe.127.2023.09.07.04.30.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 04:30:22 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-ccc462deca6so770055276.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 04:30:21 -0700 (PDT)
X-Received: by 2002:a25:8f87:0:b0:d08:5a25:e6b4 with SMTP id
 u7-20020a258f87000000b00d085a25e6b4mr19246497ybl.28.1694086221753; Thu, 07
 Sep 2023 04:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <eaa86211-436d-445b-80bd-84cea5745b5a@kadam.mountain>
In-Reply-To: <eaa86211-436d-445b-80bd-84cea5745b5a@kadam.mountain>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 7 Sep 2023 13:30:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUgTKfk0DdzS1ZtKuij1NE-nTEBdgnnS0o2uy8RbtagmQ@mail.gmail.com>
Message-ID: <CAMuHMdUgTKfk0DdzS1ZtKuij1NE-nTEBdgnnS0o2uy8RbtagmQ@mail.gmail.com>
Subject: Re: drivers/of/dynamic.c:935 of_changeset_action() warn: possible
 memory leak of 'ce'
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev, Rob Herring <robh@kernel.org>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Thu, Sep 7, 2023 at 12:52 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   99d99825fc075fd24b60cc9cf0fb1e20b9c16b0f
> commit: 914d9d831e6126a6e7a92e27fcfaa250671be42c of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock
> config: x86_64-randconfig-161-20230831 (https://download.01.org/0day-ci/archive/20230901/202309011059.EOdr4im9-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230901/202309011059.EOdr4im9-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202309011059.EOdr4im9-lkp@intel.com/
>
> smatch warnings:
> drivers/of/dynamic.c:935 of_changeset_action() warn: possible memory leak of 'ce'
>
> vim +/ce +935 drivers/of/dynamic.c
>
> 201c910bd6898d Pantelis Antoniou 2014-07-04  925  int of_changeset_action(struct of_changeset *ocs, unsigned long action,
> 201c910bd6898d Pantelis Antoniou 2014-07-04  926                struct device_node *np, struct property *prop)
> 201c910bd6898d Pantelis Antoniou 2014-07-04  927  {
> 201c910bd6898d Pantelis Antoniou 2014-07-04  928        struct of_changeset_entry *ce;
> 201c910bd6898d Pantelis Antoniou 2014-07-04  929
> 201c910bd6898d Pantelis Antoniou 2014-07-04  930        ce = kzalloc(sizeof(*ce), GFP_KERNEL);
> 606ad42aa3b1fe Rob Herring       2016-06-15  931        if (!ce)
> 201c910bd6898d Pantelis Antoniou 2014-07-04  932                return -ENOMEM;
> 606ad42aa3b1fe Rob Herring       2016-06-15  933
> 914d9d831e6126 Rob Herring       2023-08-18  934        if (WARN_ON(action >= ARRAY_SIZE(action_names)))
> 914d9d831e6126 Rob Herring       2023-08-18 @935                return -EINVAL;
>
> No kfree(ce).  Probably we move this check before the kmalloc()?

Yes, moving up sounds great.
Care to send a patch?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
