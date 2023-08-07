Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E92E772837
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjHGOxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGOxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:53:09 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2FA9F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:53:08 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686bea20652so4581226b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 07:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691419988; x=1692024788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz4C0Ykv3hnD80E1C+XIQNh+DiyZWVyJ/hXfjeRPY3w=;
        b=K9lSNwFpLCgaQljCflaYPjwLcrEsoLKYq/ajk/Gslt08bIyWEkCxsedMLzh2LcqYwe
         s9ScDOk+qTiwO7FPrWXWPTwq3sveNQh9dR5hcZXIpVb/dHG8/7ssrFww+I8X8k02vk0B
         e5IlLhd5niDcAfBavb6r/zOKQR5rczVkX7mUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691419988; x=1692024788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mz4C0Ykv3hnD80E1C+XIQNh+DiyZWVyJ/hXfjeRPY3w=;
        b=hGNO9AwREDqim3j2WEI9Omvy8TkcE6yFuePlxz8x7fro9q86ujx8SWHidr/GG5ZTvl
         vXh+LZ0ReiPtvs45bvt85cBmOOLEZmj6w4VvIAJbOaePoGzpcI+H4umKCtIf5dra3q/E
         wWUiwDkUmRYNbZ/QiUW7kJqB+5pj9o7qz0Dar5UOm4d3Uxh9UWQbMIXHN3j3iSDL5IgP
         k6HzsZzIff9YleE8pJBF4Z991Z8tNf35vYdzYgbt6yrwJQGRT6tETLmz3PH3JmJBZekF
         G/zxmyhqnjGLk65Rsdl1qa9dqv1kWcxEQRYP4P+Ljs6V+Cqn9AMIxFZZAOdF8mvKq+LN
         cH/Q==
X-Gm-Message-State: AOJu0YwBVtZQh9BiKM26XnHEuEawojrdwLllY70SEpjvQRRPRzNg8POj
        HCnTVztoXT1EOoYqd6iBBgnOvw==
X-Google-Smtp-Source: AGHT+IHcrdmabvdHUY+IfA82oDHvksfxDwt+GVT18hKyeOe/HSmWfiZjfG8JwHA67hULI1cA5TMEEA==
X-Received: by 2002:a05:6a21:3e09:b0:140:61f8:53f3 with SMTP id bk9-20020a056a213e0900b0014061f853f3mr8379628pzc.21.1691419988203;
        Mon, 07 Aug 2023 07:53:08 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id x15-20020a62fb0f000000b00682a27905b9sm6434405pfm.13.2023.08.07.07.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 07:53:07 -0700 (PDT)
Date:   Mon, 7 Aug 2023 23:53:02 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/3] lib/vsprintf: Sort headers alphabetically
Message-ID: <20230807145302.GD907732@google.com>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-2-andriy.shevchenko@linux.intel.com>
 <ZNEASXq6SNS5oIu1@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNEASXq6SNS5oIu1@alley>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/07 16:31), Petr Mladek wrote:
> 
> I am sorry but I will not accept this patch unless there
> is a wide consensus that this makes sense.

I completely agree with Petr.

I found it a little bit hard to be enthusiastic about
this patch in particular and _probably_ about this series
in general, sorry Andy.
