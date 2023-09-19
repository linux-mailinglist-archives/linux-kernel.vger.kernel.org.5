Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE197A6CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 23:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjISVXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 17:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjISVX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:23:29 -0400
Received: from out-219.mta1.migadu.com (out-219.mta1.migadu.com [IPv6:2001:41d0:203:375::db])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C04B3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 14:23:23 -0700 (PDT)
Date:   Tue, 19 Sep 2023 17:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695158601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G9eTz/QahZOPqLKrGjaKqGMUmxzEd2GX3xz/Fx2MTUU=;
        b=dZ8b1tKKDI3YmYOtf9qCOVOWCShr5qT7k8EC9WUB8eaGvcfaCkOSdp1RYxMxmc6hn1F/Zu
        W7rPr9cnJ0whyt0zlESzlNMVp+bxg2F56s44O+SAZawTCDI41/KybHjRMFYj7HYbplaeyO
        oqLaHvnqaL4qL5d/QEnLaDPz5ViohEU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Kees Cook <keescook@chromium.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: linux-next: Tree for Sep 12 (bcachefs)
Message-ID: <20230919212318.6kr772hz3m5dsyck@moria.home.lan>
References: <20230912152645.0868a96a@canb.auug.org.au>
 <202309131803.6A3C1D05A@keescook>
 <20230914193807.ozcmylp6n6dsqkbi@moria.home.lan>
 <202309141708.C8B61D4D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309141708.C8B61D4D@keescook>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 05:20:41PM -0700, Kees Cook wrote:
> Because they're ambiguous and then the compiler can't do appropriate
> bounds checking, compile-time diagnostics, etc. Maybe it's actually zero
> sized, maybe it's not. Nothing stops them from being in the middle of
> the structure so if someone accidentally tries to put members after it
> (which has happened before), we end up with bizarre corruptions, etc,
> etc. Flexible arrays are unambiguous, and that's why we committed to
> converting all the fake flex arrays. The compiler does not have to guess
> (or as has been the case: give up on) figuring out what was intended.

So it does seem like we need to be able to distinguish between normal
flex arrays that go at the end of a struct vs. - what should we call
them, markers? that go in the middle.

> Regardless, I'm just trying to help make sure folks that run with
> CONFIG_UBSAN_BOUNDS=y (as done in Android, Ubuntu, etc) will be able to
> use bcachefs without runtime warnings, etc. Indexing through a 0-sized
> array is going to trip the diagnostic either at runtime or when building
> with -Warray-bounds.

I do have CONFIG_UBSAN_BOUNDS=y testing in my own CI, so all the runtime
errors should be fixed now (some of them with casts, but the casts are
in helpers that know what they're doing, not scattered around at
random).

So I think we're good for now - I'm going to hold off on more cleanup
for now unless reports of actual ubsan splats turn up, since I'm getting
a bit bombarded at the moment :)
