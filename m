Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6827CEEA8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 06:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjJSEc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 00:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSEcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 00:32:55 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34FA98
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 21:32:52 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c9d3a21f7aso61388105ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 21:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697689972; x=1698294772; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RnOzt84oZghevEg+Rzga2baNzgIg+lwRsncAsrhg8lM=;
        b=PaIzbEEF2twqOe6LqSsgaXHuKgHYVijp9uyqORVSXKEWaFlBLhstdfX2hVDmLLcen6
         12/7dTNu3RF5LHbU+YYPATjrvw3C6hqHdxaK9kix7UEYCi1HxQR/8wIXk4PE4jLvxWga
         Qsb8ctSSH9WpAgaUpGVgFr9bsQ+7OWn8bZjlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697689972; x=1698294772;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RnOzt84oZghevEg+Rzga2baNzgIg+lwRsncAsrhg8lM=;
        b=j7PtrWHtLlGuKEeJ/ljWdXC92x8WQS67BwOObillF1nJKac4chNHVb7Mf+O6B1flcu
         GOfN0BIxjLhyrNA6o6my3l+ZVeCO2DdPUiK/DtRJpd9D1TkeI/jvSoBmG2/68DfXVtDu
         vtrEXwEsG6wOyQuiXKAS3GTOKpP+1rcCfrSkimyoksyD+QG/MNXaHp4mwuWQjwT1l1hC
         cK2HbDs4kNrK2eioA8lAh8NA8i7PUz7hhOJyCYDRshVy0X4sMwosZWqdkHpoaor9i/8X
         2x7v2NPNolPUA3yQgHo4j82lQBwHOAVmSdCtoUlKZuMwQpH472CvP5ean1b6OhLvC90/
         72qA==
X-Gm-Message-State: AOJu0Yy/NePHct2fF4+/lsO6ek1mlfOw6r8Us2EINLsQj050LMxEkuA/
        Z+yp6nhu3mETo6gzy3yoeK3zo0fmcv0bTKftsOo=
X-Google-Smtp-Source: AGHT+IHcZ00Q1gaUgk3wdtXxOzn5zV9aMtkIZ61OLUJA+xezbdzugupNil1ClsZCxpyUazpV5ZbeJg==
X-Received: by 2002:a17:903:24d:b0:1c9:d7f7:47a with SMTP id j13-20020a170903024d00b001c9d7f7047amr1737831plh.38.1697689972006;
        Wed, 18 Oct 2023 21:32:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902d68b00b001b89891bfc4sm751602ply.199.2023.10.18.21.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 21:32:51 -0700 (PDT)
Date:   Wed, 18 Oct 2023 21:32:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] block: replace deprecated strncpy with strscpy
Message-ID: <202310182101.8C98652A5C@keescook>
References: <20231018-strncpy-drivers-nvdimm-btt-c-v1-1-58070f7dc5c9@google.com>
 <CAFhGd8o-ftoGQ4qvrdGM2tSYWBqvYbF7Qb7O+UfsbzYxVmU6sA@mail.gmail.com>
 <ZTBrSb/h13YzE3Ws@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTBrSb/h13YzE3Ws@aschofie-mobl2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 04:33:29PM -0700, Alison Schofield wrote:
> On Wed, Oct 18, 2023 at 03:39:59PM -0700, Justin Stitt wrote:
> > I have a feeling I may have botched the subject line for this patch.
> > Can anyone confirm if it's good or not?
> > 
> > Automated tooling told me that this was the most common patch
> > prefix but it may be caused by large patch series that just
> > happened to touch this file once.
> > 
> > Should the subject be: nvdimm/btt: ... ?
> > 
> > Judging from [1] I see a few "block" and a few of nvdimm/btt.
> 
> Hi Justin,
> 
> It should be nvdimm/btt because it only touches btt.c.
> 
> Here's the old school way that I use to find prefixes. Maybe you can
> train your automated tooling to do this, and then share it with me ;)
> 
> I do:
> 
> ~/git/linux/drivers/nvdimm$ git log --pretty=oneline --abbrev-commit btt.c
> 
> 3222d8c2a7f8 block: remove ->rw_page
> ba229aa8f249 nvdimm-btt: Use the enum req_op type
> 86947df3a923 block: Change the type of the last .rw_page() argument
> 8b9ab6266204 block: remove blk_cleanup_disk
> 3205190655ea nvdimm-btt: use bvec_kmap_local in btt_rw_integrity
> 322cbb50de71 block: remove genhd.h
> 
> And I see a few choices, with 'block' being pretty common.
> I peek in those patches and see that block was used when the patch
> included files in drivers/block AND also in nvdimm/btt.

Yeah, this "look into the patch" step is what was missing from the
tool[1]. I've just tweaked it to weight based on number of files,
and the results are more in line with what I'd expect now. The "top 5"
best guesses are now:

	libnvdimm, btt:
	nvdimm/btt:
	nvdimm-btt:
	libnvdimm/btt:
	block:

[1] https://github.com/kees/kernel-tools/blob/trunk/helpers/get-prefix

> Use nvdimm/btt for your patch.
> 
> A bit more below -
> 
> > 
> > On Wed, Oct 18, 2023 at 3:35 PM Justin Stitt <justinstitt@google.com> wrote:
> > >
> > > strncpy() is deprecated for use on NUL-terminated destination strings
> > > [1] and as such we should prefer more robust and less ambiguous string
> > > interfaces.
> > >
> > > We expect super->signature to be NUL-terminated based on its usage with
> > > memcpy against a NUL-term'd buffer:

typo memcpy -> memcmp above?

> > > btt_devs.c:
> > > 253 | if (memcmp(super->signature, BTT_SIG, BTT_SIG_LEN) != 0)
> > > btt.h:
> > > 13  | #define BTT_SIG "BTT_ARENA_INFO\0"
                             1234567890123456

That's a funny way to define a string. :) Now it has two %NULs at the
end. ;) It doesn't need that trailing '\0'

#define BTT_SIG_LEN 16

And then this could be:

#define BTT_SIG_LEN sizeof(BTT_SIG)

But anyway...

> > >
> > > NUL-padding is not required as `super` is already zero-allocated:
> > > btt.c:
> > > 985 | super = kzalloc(sizeof(struct btt_sb), GFP_NOIO);
> > > ... rendering any additional NUL-padding superfluous.
> > >
> > > Considering the above, a suitable replacement is `strscpy` [2] due to
> > > the fact that it guarantees NUL-termination on the destination buffer
> > > without unnecessarily NUL-padding.
> > >
> > > Let's also use the more idiomatic strscpy usage of (dest, src,
> > > sizeof(dest)) instead of (dest, src, XYZ_LEN) for buffers that the
> > > compiler can determine the size of. This more tightly correlates the
> > > destination buffer to the amount of bytes copied.
> > >
> > > Side note, this pattern of memcmp() on two NUL-terminated strings should
> > > really be changed to just a strncmp(), if i'm not mistaken? I see
> > > multiple instances of this pattern in this system.
> 
> I'm not following this note about memcmp() usage. Where is that?
> 
> > >
> > > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> > > Link: https://github.com/KSPP/linux/issues/90
> > > Cc: linux-hardening@vger.kernel.org
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > ---
> > > Note: build-tested only.
> > >
> > > Found with: $ rg "strncpy\("
> 
> How you found it goes in the commit log, not below the line.
> 
> > > ---
> > >  drivers/nvdimm/btt.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> > > index d5593b0dc700..9372c36e8f76 100644
> > > --- a/drivers/nvdimm/btt.c
> > > +++ b/drivers/nvdimm/btt.c
> > > @@ -986,7 +986,7 @@ static int btt_arena_write_layout(struct arena_info *arena)
> > >         if (!super)
> > >                 return -ENOMEM;
> > >
> > > -       strncpy(super->signature, BTT_SIG, BTT_SIG_LEN);
> > > +       strscpy(super->signature, BTT_SIG, sizeof(super->signature));

Yup, this looks right to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
