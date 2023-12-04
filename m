Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5971E802ABA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 05:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbjLDEMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 23:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDEMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 23:12:34 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7A9D5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 20:12:40 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b4d9e81deso42577435e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 20:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701663159; x=1702267959; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uSIjHQyxvuiMYpm126xyxG1Zci+DFvN4cs1bYgkFaNU=;
        b=AjY5m3WZdb4y9NSY8BGOtBrPZaPWeU7XUlaaMu0f7XApsVwQOMEWo7J1Q/h4cptJL0
         WWyid3cNzIaR5YXKztsOQg+4HYThRlujOBTSNwqsnbM1O6427recNY9PdDv2ueh9asqW
         HhhLhdHIoadO+UTtH4mSTjnBTu+AfJC6T2aiOT4vdoIlrbbcyoPRz8ntFLIj3D1gCYns
         WADCVpCClK1PvpiXIkteKC9xWzu95V0WguA/xGfaGn4j1yDcQ8InpeiTw91a7JJjTxkk
         1vWJsHE7VbEiYInMv8GOxwa1Q3chrXw3E536LJZA9dk1EKT/TnKWxwLnsKkEb090Rd8N
         mppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701663159; x=1702267959;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSIjHQyxvuiMYpm126xyxG1Zci+DFvN4cs1bYgkFaNU=;
        b=hlzZKEqMwkTk9bYx/p4rM7SZ/PbL/WskcZXHCW9lCNiqcJtuyx1q9cS6C/t/zzPobJ
         X804YzAZ3ykpv4y8xLwf/cLTM9FcDQII7gYLzA0zS7Kl/RdF1nb1mZ70eOD2t/9w66AV
         +MzRaElHSCCWun+yLuGysujSQBTjN2HIsvpIDB6LQDFdBOClU6VWeOHOJ0cTX7X1NCpd
         H2+x17T+JIW2rM4kwOPeWxOX8z/RK0eFMOHAjZM2BgiBdJoUsdG7/PZyejfL/R6L25B0
         SOdWFSfztW7oqnuoVIwl78jMlmIBdQBMb/tPw2GXzhK07d6ldq50u9RapMOQmqUfRERi
         gN2Q==
X-Gm-Message-State: AOJu0YzBHX0MFf4baTMYY2ue3UnB3hbPDZbAb1cZnjtjOSnQ6jn6rXp4
        z9WBKOgtq/Q+8u+inCKhEGNg3w==
X-Google-Smtp-Source: AGHT+IFZ3Amq/8upC2zDw7bfGR8OHocro9buNNWJ73bfkCMwsGdKd3TsSUm4vWCIpdfHvwBaPhtIBA==
X-Received: by 2002:a05:600c:3b1d:b0:40b:5e1e:cf9 with SMTP id m29-20020a05600c3b1d00b0040b5e1e0cf9mr1855181wms.52.1701663159222;
        Sun, 03 Dec 2023 20:12:39 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b19-20020a05600c4e1300b0040648217f4fsm17107376wmq.39.2023.12.03.20.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 20:12:38 -0800 (PST)
Date:   Mon, 4 Dec 2023 07:12:35 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Andrey Konovalov <andreyknvl@gmail.com>,
        "Liu, Yujie" <yujie.liu@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Haibo Li <haibo.li@mediatek.com>, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, xiaoming.yu@mediatek.com
Subject: Re: [PATCH] fix comparison of unsigned expression < 0
Message-ID: <ecf38b22-ee64-41e5-b9b5-c32fc1cb57bc@moroto.mountain>
References: <20231128075532.110251-1-haibo.li@mediatek.com>
 <20231128172238.f80ed8dd74ab2a13eba33091@linux-foundation.org>
 <CA+fCnZcLwXn6crGF1E1cY3TknMaUN=H8-_hp0-cC+s8-wj95PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZcLwXn6crGF1E1cY3TknMaUN=H8-_hp0-cC+s8-wj95PQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 04:01:47AM +0100, Andrey Konovalov wrote:
> On Wed, Nov 29, 2023 at 2:22 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 28 Nov 2023 15:55:32 +0800 Haibo Li <haibo.li@mediatek.com> wrote:
> >
> > > Kernel test robot reported:
> > >
> > > '''
> > > mm/kasan/report.c:637 kasan_non_canonical_hook() warn:
> > > unsigned 'addr' is never less than zero.
> > > '''
> > > The KASAN_SHADOW_OFFSET is 0 on loongarch64.
> > >
> > > To fix it,check the KASAN_SHADOW_OFFSET before do comparison.
> > >
> > > --- a/mm/kasan/report.c
> > > +++ b/mm/kasan/report.c
> > > @@ -634,10 +634,10 @@ void kasan_non_canonical_hook(unsigned long addr)
> > >  {
> > >       unsigned long orig_addr;
> > >       const char *bug_type;
> > > -
> > > +#if KASAN_SHADOW_OFFSET > 0
> > >       if (addr < KASAN_SHADOW_OFFSET)
> > >               return;
> > > -
> > > +#endif
> >
> > We'd rather not add ugly ifdefs for a simple test like this.  If we
> > replace "<" with "<=", does it fix?  I suspect that's wrong.
> 
> Changing the comparison into "<=" would be wrong.
> 

I would say that changing it to <= is seldom the correct thing.  I've
wanted to make that trigger a warning as well.

> But I actually don't think we need to fix anything here.
> 
> This issue looks quite close to a similar comparison with 0 issue
> Linus shared his opinion on here:
> 
> https://lore.kernel.org/all/Pine.LNX.4.58.0411230958260.20993@ppc970.osdl.org/
> 
> I don't know if the common consensus with the regard to issues like
> that changed since then. But if not, perhaps we can treat this kernel
> test robot report as a false positive.

I would say that the consensus has changed somewhere around 2015 or
so.  Unsigned comparisons to zero used to be one of the most common
types of bugs in new code but now almost all subsystems have turned on
the GCC warning for this.

However, this is a Smatch warning and I agree with Linus on this.  For
example, Smatch doesn't complain about the example code the Linus
mentioned.

	if (a < 0 || a > X)

And in this case, it's a one liner fix for me to add KASAN_SHADOW_OFFSET
as an allowed macro and silence the warning.

regards,
dan carpenter
