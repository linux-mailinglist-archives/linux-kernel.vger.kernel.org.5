Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A641A79766F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbjIGQJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240651AbjIGQIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:08:20 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4EE22A70
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:01:54 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-501bef6e0d3so1908800e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694102428; x=1694707228; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rd3g14aq0Z17dL7uhkaawHdoYkXsMOdf9lkrn2VBQN8=;
        b=ujlzQrL+e4huWJOExS4hJCTv0t+Xq32Y49ywuQEy2m+1l9qvfzsB3mXpFLOSCWtTtb
         n5kQz9FwEUbVzkP/d0ue1I9Y5r8i2kX24Lo8YqbQGWUajaRNGUeiz3mFa0Brcrt3rDmu
         d15x17yicI6yXZnKgBAFIOidR21rLWDoVEFD0Oimk0J20LcIoqMH3TvVVz7/+ERXNRLF
         8g1OkMdBUo6p6pgjBtUnqxU9G8eCAIquNeka1bzA3weMJjBJmbe3jQfjIyPYvjHtctgo
         uHZgK/2AAiOCaSesD5Igmw2WsvTz5rHwYIuxRDe0/5rqAcQRlqEGQdTCnTseDM6fMqrs
         wNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102428; x=1694707228;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rd3g14aq0Z17dL7uhkaawHdoYkXsMOdf9lkrn2VBQN8=;
        b=kUXxm1Rgq7SSP0zV2fPaXwg56DAFyRunLBiNgxXZWwFK+Y3dK9U9Z+/cqbGf0sQlJn
         yxvvMkVNJj+HTT8LkFka5oMith31EjKxx1ixfpYXDACv4dq3GP1JSSVwb7ycjJZ5EmIi
         5EKVjfe0P6xO9KFsXx5PHrliIuyPs/LOlMpOYQar1lzaRKgLfvAdy+3LDb8+PLlBra+M
         NMG0PA6hkJ4080ZRpd23GusSVkiA2x1vOkUinxGrjSGG8GpQIlzpnO193FCKeR7YpZgE
         9oBn9doVp5RdaJGwkifbedMEFi/fs7EyFtqO+1vNnLNCPzMDL8BxTcqxQmkRJ44E/yok
         V0Kg==
X-Gm-Message-State: AOJu0YzigcjDp8CUMu/cbmjum2irzFRNHv0UQHJhClV3i6R/h4OHJBDP
        HWRZz2nscLuIj+u9UblGX95a9ScIqrtaXeczQG8=
X-Google-Smtp-Source: AGHT+IGglI0RO6vx8D5x0p1s9L/ra8iOSpCNNTG2ytt6fbbSiSjyPJglvq7Yl3BORRm775/WPHbEig==
X-Received: by 2002:adf:f749:0:b0:314:748:d59d with SMTP id z9-20020adff749000000b003140748d59dmr4553606wrp.27.1694087243431;
        Thu, 07 Sep 2023 04:47:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bp5-20020a5d5a85000000b0031f07d1edbcsm20553045wrb.77.2023.09.07.04.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 04:47:23 -0700 (PDT)
Date:   Thu, 7 Sep 2023 14:47:20 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     oe-kbuild@lists.linux.dev, Rob Herring <robh@kernel.org>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/of/dynamic.c:935 of_changeset_action() warn: possible
 memory leak of 'ce'
Message-ID: <e902e684-5953-4e71-82b3-28166666bc6d@kadam.mountain>
References: <eaa86211-436d-445b-80bd-84cea5745b5a@kadam.mountain>
 <CAMuHMdUgTKfk0DdzS1ZtKuij1NE-nTEBdgnnS0o2uy8RbtagmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUgTKfk0DdzS1ZtKuij1NE-nTEBdgnnS0o2uy8RbtagmQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 01:30:09PM +0200, Geert Uytterhoeven wrote:
> Hi Dan,
> 
> On Thu, Sep 7, 2023 at 12:52 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   99d99825fc075fd24b60cc9cf0fb1e20b9c16b0f
> > commit: 914d9d831e6126a6e7a92e27fcfaa250671be42c of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock
> > config: x86_64-randconfig-161-20230831 (https://download.01.org/0day-ci/archive/20230901/202309011059.EOdr4im9-lkp@intel.com/config)
> > compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> > reproduce: (https://download.01.org/0day-ci/archive/20230901/202309011059.EOdr4im9-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > | Closes: https://lore.kernel.org/r/202309011059.EOdr4im9-lkp@intel.com/
> >
> > smatch warnings:
> > drivers/of/dynamic.c:935 of_changeset_action() warn: possible memory leak of 'ce'
> >
> > vim +/ce +935 drivers/of/dynamic.c
> >
> > 201c910bd6898d Pantelis Antoniou 2014-07-04  925  int of_changeset_action(struct of_changeset *ocs, unsigned long action,
> > 201c910bd6898d Pantelis Antoniou 2014-07-04  926                struct device_node *np, struct property *prop)
> > 201c910bd6898d Pantelis Antoniou 2014-07-04  927  {
> > 201c910bd6898d Pantelis Antoniou 2014-07-04  928        struct of_changeset_entry *ce;
> > 201c910bd6898d Pantelis Antoniou 2014-07-04  929
> > 201c910bd6898d Pantelis Antoniou 2014-07-04  930        ce = kzalloc(sizeof(*ce), GFP_KERNEL);
> > 606ad42aa3b1fe Rob Herring       2016-06-15  931        if (!ce)
> > 201c910bd6898d Pantelis Antoniou 2014-07-04  932                return -ENOMEM;
> > 606ad42aa3b1fe Rob Herring       2016-06-15  933
> > 914d9d831e6126 Rob Herring       2023-08-18  934        if (WARN_ON(action >= ARRAY_SIZE(action_names)))
> > 914d9d831e6126 Rob Herring       2023-08-18 @935                return -EINVAL;
> >
> > No kfree(ce).  Probably we move this check before the kmalloc()?
> 
> Yes, moving up sounds great.
> Care to send a patch?
> 

Sure.  I can do that.

These are zero day bot warnings from Intel.  I normally just look them
over and hit the forward button.  Quite often the zero day bot will find
the warnings before the patch has been apply.  But in this case, it's
simple enough to patch.

regards,
dan carpenter

