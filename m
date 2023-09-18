Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62AA7A5223
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjIRShK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjIRShI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:37:08 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8401FC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:37:00 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2745cd2ba68so3878302a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695062220; x=1695667020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BgrOLmK1nfCOeUseM7RHVXxQRtSQj47fEGB5Nd8IrIA=;
        b=L16BALIZb8kCA4i0/br6jIRNDyDWXKhzr8YKgnPwE6AemiOWusbcXJmu9jz6hoXNiS
         GdoeXoskuorJexSaiMBr7K5zDK1qC/Fuhb7fg3RBzuQfPylKros/Kw8nwOlGYjvjfjs7
         ucnvX1NWaV2DD9oAA3+V2ZS13S45XN8YO6vnFmD8c9ChWbIS/ATcZfrL/qhH/YAyD508
         47dD/PxGwZVaKjcAafPlxjH9jRodM1SFu+F94JmW/l1adP6i/+mE+iwmDV2fLntTKyQF
         CIXVEJzpZD6hZf62W7XGcR/viyot3MPp2xt42uqYamNKJ9nSkb5gf0Hg95nTYIJeFypb
         3vNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695062220; x=1695667020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgrOLmK1nfCOeUseM7RHVXxQRtSQj47fEGB5Nd8IrIA=;
        b=utwUmOxKznv9Ig7L5CuK6f4kLvS+lG+QMOhNrEMfe4jYd8Z7bW/XfgJOCapxu9V1p1
         cmG62I1urmWQy5KdFQCVxXDI87CoAh/SV01mVaXDsUfWdRS/WhbSVyPNqn3oEZ/ZGLS0
         i7b3pbY5Q8N+b4nW3jLyq0umRYE51kXNSGJPCPC+/zeRgVVSRkQz1NX8Fw4+5sEOeO7P
         9Lv/5SGSAPodrcFfApkCiys9kQlFsjLWDUhtOaN+7fzJlN+No+egzsM9RBfE+zhsYxPD
         hz0gUHjCg2t1OvjgwMS75R4+ZWtooRELk9XTcOgZgqB48gcGlEdSyrBaWkVSDmYx6QO9
         lXog==
X-Gm-Message-State: AOJu0YxJILGGaJmVZ2WiXHyYBOC0r5kkPeRxWXTa6fgqCbKKKgeYRmLG
        JJJFyhlXIhwvhHjiLY4NeA4=
X-Google-Smtp-Source: AGHT+IH4KjM31r7X0Pt6hoWQVeA6t9GcWBcDsiMKxjyWTjthZK1gUYYOy4ukyEa2Gt3i1vrpBQ4zpw==
X-Received: by 2002:a17:90a:bd93:b0:274:8a03:b546 with SMTP id z19-20020a17090abd9300b002748a03b546mr10118210pjr.23.1695062220134;
        Mon, 18 Sep 2023 11:37:00 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090b010600b002682523653asm7380116pjz.49.2023.09.18.11.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:36:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 18 Sep 2023 08:36:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        John Ogness <john.ogness@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix duplicate wq_update_pod_attrs_buf
 allocation
Message-ID: <ZQiYyja8kN2UhyeV@slm.duckdns.org>
References: <20230913101634.553699-1-john.ogness@linutronix.de>
 <CAMuHMdWts9NKU=DfPujTKAQNU6T3uawVtejwiTkp=usMu0rH-A@mail.gmail.com>
 <202309152011.EAFC890@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309152011.EAFC890@keescook>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 08:14:12PM -0700, Kees Cook wrote:
> > Stephen posted a similar patch before:
> > https://lore.kernel.org/all/20230905174935.2d75feab@gandalf.local.home
> 
> I tripped over this kmemleak report too. It'd be nice to get this into
> -rc2. Tejun, are able to get this or the Sep 5th patch to Linus soon?

Applied Stephen's one. Sorry about the delay. Have been seek for a few
weeks.

Thanks.

-- 
tejun
