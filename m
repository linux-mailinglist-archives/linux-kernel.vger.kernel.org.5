Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BFE771186
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjHESnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjHESnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:43:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB222737
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 11:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C775360E76
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 18:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A49C433C8;
        Sat,  5 Aug 2023 18:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691260986;
        bh=JxNWPx3YcT6FMDu/5paY892p5ex0sPcNRYPgD4XnjbY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BatuvWtbx/l8UXQLE1KQYGbHxOLMOAYTzVa5DuYV/BgKbhBeD999i+dBaXDURPOrN
         wCWJ1ImQviAbA26hoxC+DXISpUUAfexqfZwyQlAZPRVu8oPS/qAmeCObeFCQclzb4h
         U3SuZTR8+efB0Uutos+C7M/dtHslwNkQXYflgO6g=
Date:   Sat, 5 Aug 2023 11:43:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Split out sprintf() and friends
Message-Id: <20230805114304.001f8afe1d325dbb6f05d67e@linux-foundation.org>
In-Reply-To: <20230805175027.50029-3-andriy.shevchenko@linux.intel.com>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
        <20230805175027.50029-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  5 Aug 2023 20:50:26 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> kernel.h is being used as a dump for all kinds of stuff for a long time.
> sprintf() and friends are used in many drivers without need of the full
> kernel.h dependency train with it.

There seems little point in this unless someone signs up to convert
lots of code to include sprintf.h instead of kernel.h?

And such conversions will presumably cause all sorts of nasties
which require additional work?

So... what's the plan here?
