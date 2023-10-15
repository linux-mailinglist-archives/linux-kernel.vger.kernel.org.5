Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67FE7C9882
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 12:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjJOJz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 05:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjJOJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 05:55:24 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF324AD
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 02:55:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53e855d7dacso1168428a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 02:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697363720; x=1697968520; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WvfQbrUOAety/yQQMKIQiictUB3muNGYsVZ1vSvxI3g=;
        b=GhXEcA0FIO87MWvMyLWvsXwtu/kLh+tzUnrnX4XJSYhVOlkGOupELtKMtpKtYW+ss5
         DgLl/lIGgpUmqeIHRuFJLT12pLPS3349+Vi/stkwrb0HBxxeOuabCQ4O8QqOXOyvSXaM
         2fIUFcrkux+ATazIFHHkdyOlTkm7efJkgtnvJv9aoj3n8iD0TQ0vgEc5nxgxKPHw0mMs
         WqSdnLtlINHaclLt9CBNvpY2y+6AkwvgXJn4hUpcjAncj2NpE6178yIgUtRp39e2AZ+s
         HgZHecW3O0qGvcGThi4NPfuI8zUsgTaAM4+14wjvK2zuWbJf4touk4LvO4UwbXXH/c5V
         q0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697363720; x=1697968520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WvfQbrUOAety/yQQMKIQiictUB3muNGYsVZ1vSvxI3g=;
        b=OYqVplKcs4L0ymNCDBwq2xQVcP9QJ3IRdD8jOgP9ni9yKh0DFF27kLWlqQkCV1kMQ6
         nfpx/S+IrphIXGV4EFqKWVkRin5+3LCPCVmRorrc4xvSHIC87+DcX+Qo0K7oRIC0Z2D2
         lMZa+MjqzQ56u922T3lU5lN92DdDPPv8XmNGcsSFcBV6UHN8noNKtNrAJIzdF9ALNoXL
         1wcsZytzbSL9UBAe6q7d8HufbDz5NXqSzFbKLQ/CXltubAGB0YxvvzK78d8IKA+gdQA5
         6Y3o7NkEMMKCq5733XwwEEkR91Lh6qpAfd6Ovx8h38VxPXjdewkWg493bCIV5MXwUo4F
         rrwQ==
X-Gm-Message-State: AOJu0Yza6Uj12ijsLJ/EQViGEWYeeGm4vOg/ERexpuLuu84w8DOKRJe1
        JDEeny4EcUVkgrOkuYgZGQ==
X-Google-Smtp-Source: AGHT+IHxoeMhCG3v2V0tkipffEqPtxQL84PiKF/YNHtRvpc/SoFf6I4cpvEwZBSzmd5ybZWGocFcYg==
X-Received: by 2002:a17:906:254:b0:9b2:b691:9b5f with SMTP id 20-20020a170906025400b009b2b6919b5fmr27177944ejl.41.1697363720160;
        Sun, 15 Oct 2023 02:55:20 -0700 (PDT)
Received: from p183 ([46.53.250.251])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090637d300b009b65a698c16sm2038960ejc.220.2023.10.15.02.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 02:55:19 -0700 (PDT)
Date:   Sun, 15 Oct 2023 12:55:17 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] smp: fix __smp_processor_id() backup macro
Message-ID: <c22be6b2-5d80-4168-95cc-f86a79d8cb39@p183>
References: <b12bdef9-d5c0-49cf-aea2-ff7b56220fdc@p183>
 <20231014151221.46096b7fc17ccaeb691ff5d0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231014151221.46096b7fc17ccaeb691ff5d0@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 03:12:21PM -0700, Andrew Morton wrote:
> On Sat, 14 Oct 2023 19:14:15 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > Every __smp_processor_id usage doesn't have arguments and
> > every raw_smp_processor_id usage doesn't have arguments,
> > therefore "#define __smp_processor_id(x)" can not possibly work.
> > 
> > ...
> >
> > --- a/include/linux/smp.h
> > +++ b/include/linux/smp.h
> > @@ -261,7 +261,7 @@ static inline int get_boot_cpu_id(void)
> >   * regular asm read for the stable.
> >   */
> >  #ifndef __smp_processor_id
> > -#define __smp_processor_id(x) raw_smp_processor_id(x)
> > +#define __smp_processor_id() raw_smp_processor_id()
> >  #endif
> >  
> 
> It's been that way for at least 4 years.  Presumably this is never used
> and should be removed?

Deleting breaks compilation immediately.

C89 6.8.3 §4 says

	"The number of arguments in an invocation of a function-like
	macro shall agree with the number of parameters in the macro
	definition, ..."

C99 relaxes this in 6.10.3 §4

	the number of arguments (including those arguments
	consisting of no preprocesing tokens) ... shall equal
	the number of parameters in the macro definition.

So, "#define M()" works with M() only, but "#define M(a)" worked with
M(1) and started working as M() which is very funny.

In other words changelog is wrong: it can and does work (sort of by
accident).
