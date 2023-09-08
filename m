Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C72798A50
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244205AbjIHQDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240812AbjIHQDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:03:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EE81FD9;
        Fri,  8 Sep 2023 09:03:21 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bcc0adab4so277114766b.2;
        Fri, 08 Sep 2023 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694189000; x=1694793800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H1Yz6OhmoK/aAZh58Ge5vVqf6WDrZqCawVIXLfTFMWk=;
        b=iwbdx6fFolnuAFLq6yxNkhHseYkhh2LodMFZRU8cSCad3VORZ45VLNvljTQlA36aUi
         GE10BIrXCKFPOTGbvRKknNk3iUR5MsC+3eaIWkpPa9AGK135Dqo07WiYz4hEmbJn8Dif
         aM8Mbhp4FNXTAVr1n1B7Fs8Bm95/Vw+YnjY8tZi7IkadYCk28+DgLBuBkfcIHLPqN2Mh
         fd1cg9xyxFY05mHBgNJAMm7tAbaENZpRBdx1jR5RD6OnVukNMTV/HfcbsI9p3FpdDYV6
         6GL3XDXHzfqC9nmCQ255qgTba8pY2G4HVrXdgmyLKADOd3Jb91cLvjGjm13QcQKXKP8O
         5DrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694189000; x=1694793800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1Yz6OhmoK/aAZh58Ge5vVqf6WDrZqCawVIXLfTFMWk=;
        b=gIGDoMYYQ9fQ5UTiFxom36Yo6f/nKxUz2LC0RLrSdFgBU6mq+CB9IVMrsx6BXBEjHv
         Fvho0Mv7PcowBXoVQJko/id5lFHp4t40RkcSyu3J6pJWCb7eThr9+kp8yXrrEOluWuMa
         iCWy3jaCO6uzz/z0xzs0pkeKj9TYL5lH4JbFSHJ0Z4bPUpyzxSh+Gy7jCJujyfqiKMjN
         RSj4J6q3g45g4HjquE9glmkKkcabkIN+QmR85duvbauEqKIK6dbi6Y4YgXIrI7u1A0Cn
         MsSl3MUPEN+AKAq6xoWvOYb/tBOW4nYCDzoRpzKukpIVy+Gq3C77f+8ojZ+sYRSZCZ6J
         lDKw==
X-Gm-Message-State: AOJu0Yw9kVmyLjp2gnAZt++lTqmg/wBCAtekh4ACDZbgqqct2F/aIPdc
        +9TpymqvKrnENdFsYhmHA1HPx1z8GQ==
X-Google-Smtp-Source: AGHT+IEaavioBPf3vAKJBA/Kb7ey2P+c0wZOcJ4GBcIWt1+U+8L3WCmHSq64cyihbUNlugu3bQXiSw==
X-Received: by 2002:a17:906:5a5a:b0:9a5:c9a4:ba13 with SMTP id my26-20020a1709065a5a00b009a5c9a4ba13mr2129987ejc.37.1694189000044;
        Fri, 08 Sep 2023 09:03:20 -0700 (PDT)
Received: from p183 ([46.53.253.206])
        by smtp.gmail.com with ESMTPSA id lz24-20020a170906fb1800b009932337747esm1204115ejb.86.2023.09.08.09.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 09:03:19 -0700 (PDT)
Date:   Fri, 8 Sep 2023 19:03:17 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] uapi: fix __DECLARE_FLEX_ARRAY for C++
Message-ID: <f1819874-2b91-4983-9ebe-6cd83d5d3bc3@p183>
References: <930c3ee5-1282-40f4-93e0-8ff894aabf3a@p183>
 <a0c3a352-89c6-4764-b377-f55a68a1b2cb@p183>
 <202309080848.60319AF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202309080848.60319AF@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 08:53:12AM -0700, Kees Cook wrote:
> On Fri, Sep 08, 2023 at 06:14:38PM +0300, Alexey Dobriyan wrote:
> > __DECLARE_FLEX_ARRAY(T, member) macro expands to
> > 
> > 	struct {
> > 		struct {} __empty_member;
> > 		T member[];
> > 	};
> > 
> > which is subtly wrong in C++ because sizeof(struct{}) is 1 not 0,
> 
> Ewwww. Isn't this a bug in C++?

Sort of, but it can't be fixed.

> > changing UAPI structures layouts.
> > 
> > This can be fixed by expanding to
> > 
> > 	T member[];
> > 
> > Now g++ doesn't like "T member[]" either throwing errors on code like
> > this:
> > 
> > 	struct S {
> > 		union {
> > 			T1 member1[];
> > 			T2 member2[];
> > 		};
> > 	};
> > 
> > or
> > 
> > 	struct S {
> > 		T member[];
> > 	};
> > So use
> > 
> > 	T member[0];
> > 
> > which seems to work and does the right thing wrt structure layout.
> 
> It seems sad to leave C++ broken, but I guess we have to do this.
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> > Fix header guard while I'm at it.
> 
> Hm, when did that get broken? Maybe that should be fixed separately?

By your last commit?

> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> 
> Probably a Fixes: tag would be nice too.

OK

Fixes: c8248faf3ca2 ("Compiler Attributes: counted_by: Adjust name and identifier expansion")
Fixes: 3080ea5553cc ("stddef: Introduce DECLARE_FLEX_ARRAY() helper")

> >  include/uapi/linux/stddef.h |    6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > --- a/include/uapi/linux/stddef.h
> > +++ b/include/uapi/linux/stddef.h
> > @@ -39,6 +39,10 @@
> >   * struct, it needs to be wrapped in an anonymous struct with at least 1
> >   * named member, but that member can be empty.
> >   */
> > +#ifdef __cplusplus
> > +#define __DECLARE_FLEX_ARRAY(T, member)		\
> > +	T member[0]
> > +#else
> >  #define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
> >  	struct { \
> >  		struct { } __empty_ ## NAME; \
> > @@ -49,3 +53,5 @@
> >  #ifndef __counted_by
> >  #define __counted_by(m)
> >  #endif
> > +
> > +#endif
> 
> -- 
> Kees Cook
