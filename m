Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D91D7D0755
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 06:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjJTEY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 00:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjJTEYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 00:24:54 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281AE13E;
        Thu, 19 Oct 2023 21:24:53 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7be88e9ccso4033757b3.2;
        Thu, 19 Oct 2023 21:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697775892; x=1698380692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SpKVxfcnp8P5cberSO/2dfJnE7ygAJckEl3qSeVgS/8=;
        b=e5YkNgOhS3+Q/XBgmLIlVYajaQIIKy2tLRMxl7KyX2lEzdCU47YAHT4h4gZhLj01M3
         hhNBKcvw1rE0OP7kwuVVIiQQtP/a/+cAcHIYIAPenSYs5dQsm1xIzqwL5RSi5EqLW7N4
         fAGocZw779xjnUrq4Pz9Yo0g7PNHMg+fXlOsRKAk6UyycHpptcGHTI/p3TOi9/3ugVRM
         OWRtppw+Mws38MMg+GHO+FwxiWzKNmKBcRjGIa1+SE3kuE3MnC9Y/7fvzSxgN8OM39gC
         cx76pB4ohoxjVDZs1yjCCTK9dXaJuhYDSZa/jsyNAHIa+iSbtev+6Xs3hSLOQlZdjI6l
         u3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697775892; x=1698380692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpKVxfcnp8P5cberSO/2dfJnE7ygAJckEl3qSeVgS/8=;
        b=G/sNt0p9LqR0Jpzih1urN3MIfxeKUqX5Yq/jrds3YCagpX6BPV99pWVXLdVl+bC/sy
         0geunwh53uW+k4EwQLerdtc9lkIwwy4mZgszTZwJngOVWt8GnNN7zfW7Mz3Nj4iW/CXV
         cK2mTH9CPJ1V+GSwLX8j0HFPhJJ24evYHUzgMV3ybYF+7/X/B1Kj+XOUOPFOc18j3YDz
         VMLTE2y+7yOVMp29Vad0xekwSiPAdndI8bDQSxX3e2lQYEzY6w2ZZX90ZmRu/krWNPLc
         HkvQtlkDfaBaq1uC/XH2skNEtobgENTy8xG+sidM9CVTRq5tq5+FaG6XlqmuAaqoGUS7
         yDrw==
X-Gm-Message-State: AOJu0Yz5LAPHscf7y/QNLFMKyHVgyvhMXeTbVpOzUC5Dm93bhKX8+a4O
        PEeBbSrqKHaHltVMRnbR5VfV+cDUqpO7pg==
X-Google-Smtp-Source: AGHT+IFeskf2qoxBbJ4QbLVHj7lJSlMgBXSK5+8Y2uOf8L9jqv7gkuvuDwZUifoOcIW6jWqh8K4UvQ==
X-Received: by 2002:a05:690c:f12:b0:5a7:ac6c:edc8 with SMTP id dc18-20020a05690c0f1200b005a7ac6cedc8mr1254113ywb.4.1697775892242;
        Thu, 19 Oct 2023 21:24:52 -0700 (PDT)
Received: from localhost ([2607:fb90:3e1a:8bc6:2f64:4032:da57:30a1])
        by smtp.gmail.com with ESMTPSA id l128-20020a0dfb86000000b0059f7ca6beb4sm403343ywf.55.2023.10.19.21.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 21:24:51 -0700 (PDT)
Date:   Thu, 19 Oct 2023 21:24:49 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bitmap tree
Message-ID: <ZTIBESMp9qsRdVja@yury-ThinkPad>
References: <20231019170106.4159eac5@canb.auug.org.au>
 <ZTFSHqjkHLM5iAqH@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTFSHqjkHLM5iAqH@yury-ThinkPad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 08:58:24AM -0700, Yury Norov wrote:
> On Thu, Oct 19, 2023 at 05:01:06PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the bitmap tree, today's linux-next build (native perf)
> > failed like this:
> > 
> > In file included from /home/sfr/next/next/tools/perf/util/header.h:10,
> >                  from /home/sfr/next/perf/pmu-events/pmu-events.c:3:
> > /home/sfr/next/next/tools/include/linux/bitmap.h:5:10: fatal error: linux/align.h: No such file or directory
> >     5 | #include <linux/align.h>
> >       |          ^~~~~~~~~~~~~~~
> > 
> > Caused by commit
> > 
> >   ed46ac8199f0 ("bitmap: introduce generic optimized bitmap_size()")
> > 
> > I have used the bitmap tree from next-20231018 for today.
> 
> Thanks, Stephen. I'll take a look and let you know when it's resolved.

Hi Stephen,

So the problem is that the patch "bitmap: introduce generic optimized
bitmap_size()" adds reference to the linux/align.h, which doesn't exist
in tools.

I removed tools part of the patch entirely, and now tools/perf, for
example, builds OK for me natively. The tree doesn't touch tools at
all now, except for moving BYTES_TO_BITS() from a source file to a
header, which looks safe.

Can you please try the latest bitmap-for-next?

Alexander, when you touch tools, it's can you build something from
it as part of your testing? I usually build tools/perf.

Thanks,
Yury
