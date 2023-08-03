Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A91476F5B1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjHCWXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjHCWXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:23:50 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEB84213
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 15:23:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bb119be881so12705055ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 15:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691101429; x=1691706229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8Cg2kZRT159MfkhH+DbOB4Grpbn6uU0SfeqcgSslkw=;
        b=MBC0cvUMfx/k57hOALKBcJd55TOJ3tYu16VR0C3BuqBhUx4LUVAqht3S2a2Dm1XMUz
         lYQUI+wCS67tuobdYFvv8mnYiNi+WMepofzTXu20xdRGD203GrocRTrp8MWyF6hojt86
         GkDNNyF/X8JeZFxT2QAZw7mCIbbdRlfmfZoYgEn+vPHLH/RMZDH/E9DH1BU6yldJvQZj
         DQ1Qb/78wWOMDndGkjeBBpANUku12OPkc9ocZTRNbb8uXcyLEfrVtu+3fbuxGvcoGsoF
         m7Im6l3cyaYJF44e0+qZ5w3XnJCYUg9gV5cMEy7CP4rbLfOawx1VJMHpMqf7wpSDcFF0
         j/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691101429; x=1691706229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8Cg2kZRT159MfkhH+DbOB4Grpbn6uU0SfeqcgSslkw=;
        b=QGoHsZNAKM8W6LwvsvYG2U+M01eZIp16bEalR/msC0AwjBy8Uw9Pc7kIZxVjrbFoLs
         oySrTNUugg2/oG+tD7ncL+P1OEa5DK052TJ79J3JyC1vuiU2QALGb29jkwnEr2Hgxg0N
         CLxLA1CS6D6mtmBDgb0orhAAIYqyhzCHy2NOqc3uR9IpAD3kEmGf8hAgG+vSL9iXeYS/
         o2XkcfBtpJqnEpMqrwZtPK9fo4mEHS8K62n880rYNg/DRnfo2uVXH0cuWbiPsuhAnZAa
         vwND7kMbdGJYwkI6wLRb+i0Imj9C9oAOTcK/M/BiiouwQrA2/vQvwnHPkb3PP9I6Rho9
         T3og==
X-Gm-Message-State: AOJu0YwSDVBVZBEJKpL3DpVOf5yCwQuxsC/chufUCEFdaxvdtzRaM/HR
        +gvizDemMjOhA6ZZ+T8dudA=
X-Google-Smtp-Source: AGHT+IG+a3iUtaS/nCojwOyEUokszweAddlSdq3xuJtfZIub4vWdUnX/TAr9aoNrof/CfmKgIMriGg==
X-Received: by 2002:a17:902:ecc3:b0:1b6:6625:d3a8 with SMTP id a3-20020a170902ecc300b001b66625d3a8mr65164plh.16.1691101428797;
        Thu, 03 Aug 2023 15:23:48 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id ji5-20020a170903324500b001bc445e249asm332787plb.124.2023.08.03.15.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 15:23:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 3 Aug 2023 12:23:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, Dave Airlie <airlied@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: arm32 build warnings in workqueue.c
Message-ID: <ZMwo8rZrRilARZBr@slm.duckdns.org>
References: <CAPM=9twNnV4zMCvrPkw3H-ajZOH-01JVh_kDrxdPYQErz8ZTdA@mail.gmail.com>
 <CAHk-=wi=eDN4Ub0qSN27ztBAvHSXCyiY2stu3_XbTpYpQX4x7w@mail.gmail.com>
 <ZJX27JDyrgvdeCe4@slm.duckdns.org>
 <ZMdu1YqUI7VIEq1y@alley>
 <CAHk-=wiJSzSkF-FDcHydR61Q3_q4xCiqq37tfXdijaCxsDF86Q@mail.gmail.com>
 <ZMgIF_6zCqB0LfjN@slm.duckdns.org>
 <CAHk-=wgGmV6x1brPoROABozj99hrKo031qq8F8K9Mjx2FC6nfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgGmV6x1brPoROABozj99hrKo031qq8F8K9Mjx2FC6nfw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

On Mon, Jul 31, 2023 at 12:22:06PM -0700, Linus Torvalds wrote:
> We do have that
> 
>    scripts/gdb/linux/constants.py.in
> 
> thing. Which seems to be the logical place do deal with this all.
> 
> That's where other - and arguably much more fundamental - kernel
> #define's are dealt with.
> 
> Now, looking at the particular constants that are listed, I get the
> feeling that the people who have done that script may be mostly
> interested in filesystems, but I don't see why it wouldn't be
> appropriate for the workstruct stuff too...

It can be used but there are some drawbacks:

* It requires maintaining external code, which usually doesn't scale that
  well, especially over extended period of time.

* It requires pre-processing header files and then evaluating the resulting
  C expressions. It's not a showstopper and some tools can already do so
  but, for example, to use this with drgn, we'd have to generate this into
  python expressions using something and then source it. Maybe we can
  prepackage the pre-processed results but things do get more complicated
  and likely more error-prone.

* This likely will cover some of the constants but there are also many which
  aren't readily visible in public header files. It is possible to try to
  preprocess .c files too but then now each machine has to have full source
  deployed and so on.

So, not that it's impossible but if you contrast this to having the
constants available in the debug info:

* There's only one source of truth. No external maintenance is needed.

* The tools already rely heavily on having debug info available for type
  information and the symbols. As needing debug info is pretty common, most
  distros and prod environments provide ready access to them, whether kernel
  or applications.
  
* Having constants in debug info doesn't add any complexity or point of
  possible mistakes. As long as the binary matches the debug info, which is
  a property that tools and environments watch and maintain closely and easy
  to notice when broken, you know that you're using the same numers as the
  running kernel, which is a huge relief.

The downside of using enums is that C's enum is not great in terms of type
predictability. I personally would much prefer specifying the types
explicitly, but, as long as the rules are stable, I think it's something we
can live with. While a bit annoying, the benefits of using them outweighs
the annoyances in general.

It's just so silly that constants of all the stuff we need for monitoring
and debugging are the one thing that we can't provide through debug info and
requires all the special, potentially fragile, workarounds.

Thanks.

-- 
tejun
