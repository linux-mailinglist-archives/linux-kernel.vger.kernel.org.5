Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA2079D994
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbjILTaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbjILTaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2CB3CF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694546963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CUr8uffvIKRfj1LAAfZsZyfJJTJnjUDK/LWC7CZG7b8=;
        b=aJylhkwK8VKukiZlA+33tUfT/Bv0ybANcApgEIyk/2nPW4dp9GH2RigOxF/Jebgl8mWR7V
        wBAZPT0OQkPPCcQnz7RCRSL4yfRgF6swZASAJNwAP3SEb2br5fxAPGmoPhMql4wgy1Sard
        1E0qSr+RaV2GRKaO52vA5YJ4aW0AuKU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-Gaiw_s1jNfCI7Ftz1FnnkA-1; Tue, 12 Sep 2023 15:29:22 -0400
X-MC-Unique: Gaiw_s1jNfCI7Ftz1FnnkA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6bdb30c45f6so5923232a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694546961; x=1695151761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUr8uffvIKRfj1LAAfZsZyfJJTJnjUDK/LWC7CZG7b8=;
        b=OxVvyi06s5tJ2C/s9f4TSP+kQigEPvj7fkhxEkW2mc2u1RsduoHuFegS9FIYNk5jEn
         oSuGgRmWaQMRIsKcbKz6NZPoVuykgMN/FY+83t7+M+Cq6kz1unS29N4U/wpmhUsVFQYg
         SLLzc72QFXOlm5tukHqfJsBWqUyWbXUGMoD9SBptN3kchW3IHlB9pojFbwMdwa308OO0
         XwQDYxcEoKaOt+ZYFtBQ9ZkViTaHCT4GyXo0O/fJ2QT7BIp5LcinisopLlQoAYRiPVer
         Vet2wPWqFOwOUwaw+FGBZtnZ7ydWbvonEWJNh4BtU37xcfo862nHoDdxrOWCIreCQiGk
         x+7g==
X-Gm-Message-State: AOJu0YxA5DXGeCrpydchU0ttMZyQIcYtA/eLHzgZOIlUt3X2wRkwQ3/E
        mPIsOXqGkghO69NNTpXTx7L4hIB7EXl+WlKgIumAs7tDsgHggMBVdkGs1ar1A6PssTCDlIbSW7j
        /CKIKyMQtKFwzl2KHW2oo8SG2
X-Received: by 2002:a05:6830:4af:b0:6bc:8cd2:dd97 with SMTP id l15-20020a05683004af00b006bc8cd2dd97mr752355otd.29.1694546961668;
        Tue, 12 Sep 2023 12:29:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGleJyX0X3iapwL2vHV0dP7EtxVDVe3VLFKSVMQi6qzXHIfeZOnHRMYeKyD3en798V4yoBomA==
X-Received: by 2002:a05:6830:4af:b0:6bc:8cd2:dd97 with SMTP id l15-20020a05683004af00b006bc8cd2dd97mr752349otd.29.1694546961440;
        Tue, 12 Sep 2023 12:29:21 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:c91:da45:7fbc:86c3:920a])
        by smtp.gmail.com with ESMTPSA id d14-20020a05683018ee00b006b8c277be12sm4291056otf.8.2023.09.12.12.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 12:29:21 -0700 (PDT)
Date:   Tue, 12 Sep 2023 16:29:15 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/1] scripts: Introduce a default git.orderFile
Message-ID: <ZQC8C_CGLcU1vT-G@redhat.com>
References: <20230911234418.38154-2-leobras@redhat.com>
 <e0d83e21-c1fe-5f3b-9613-e9d137baaee7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0d83e21-c1fe-5f3b-9613-e9d137baaee7@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 09:24:04PM -0700, Randy Dunlap wrote:
> 
> 
> On 9/11/23 16:44, Leonardo Bras wrote:
> > When reviewing patches, it looks much nicer to have some changes shown
> > before others, which allow better understanding of the patch before the
> > the .c files reviewing.
> > 
> > Introduce a default git.orderFile, in order to help developers getting the
> > best ordering easier.
> > 
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> 
> LGTM. Thanks.
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks Randy!

> 
> > ---
> > 
> > Please provide feedback on what else to add / remove / reorder here!
> > 
> > Changes since RFCv1:
> > - Added Kconfig* (thanks Randy Dunlap!)
> > - Changed Kbuild to Kbuild* (improve matching)
> > 
> >  scripts/git.orderFile | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >  create mode 100644 scripts/git.orderFile
> > 
> > diff --git a/scripts/git.orderFile b/scripts/git.orderFile
> > new file mode 100644
> > index 000000000000..819f0a957fe3
> > --- /dev/null
> > +++ b/scripts/git.orderFile
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +# order file for git, to produce patches which are easier to review
> > +# by diffing the important stuff like header changes first.
> > +#
> > +# one-off usage:
> > +#   git diff -O scripts/git.orderfile ...
> > +#
> > +# add to git config:
> > +#   git config diff.orderFile scripts/git.orderfile
> > +#
> > +
> > +MAINTAINERS
> > +
> > +# Documentation
> > +Documentation/*
> > +*.rst
> > +
> > +# build system
> > +Kbuild*
> > +Kconfig*
> > +Makefile*
> > +*.mak
> > +
> > +# semantic patches
> > +*.cocci
> > +
> > +# headers
> > +*.h
> > +
> > +# code
> > +*.c
> 
> -- 
> ~Randy
> 

