Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB217DBD74
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbjJ3QHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjJ3QHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:07:22 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC58C9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:07:20 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc42d3f61eso11957755ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698682039; x=1699286839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYj9CzuAjK7WX2GIPL2L+DIVtRCWsgVm7uwhZjeF2lA=;
        b=3eQEBVVJW6qpJRwIuasDzGtyhpatmXjUjasnElIBF8WjDI+5ApsFJ1zlDBlWT/69TB
         PbTOHJinmlk+6aMVIH1rf63/lkKTsx0HNyXkcOGxLPBIKoLTzYcS4D+N1dBwkqdfsq/S
         yrUZOH4RT0MgkqHKkV9fo9/iJHC5KhS9aBgKJ5GC3Ehhb5WvIv5T2CWdFs5anHN3mu4N
         TuA4Z1ZZjrp9Qq2HjIs19K7Ul9Ov/A5B/bGpzVvmCJQKXDxhBNMpPGy8oagszu8qGOCM
         Sy9/BZQ01UDgphVn92xAZ3R44OHqqS2VIxjhPZ/H/x+68a9CrcENGbg1bva66PztNRjU
         oSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698682039; x=1699286839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYj9CzuAjK7WX2GIPL2L+DIVtRCWsgVm7uwhZjeF2lA=;
        b=RA6pGUpuRh7yZhiMI0mNLz/UWaADQ98Hv51TnUShJlZVQonhVmHtyTyYufKWVsf6th
         gPetf9jIEJxyfmFS5BsetgGReiGXvXhs+2S7MjIeEm4Y86lXii7U5m01oH9gUYsf9JdK
         OhC5teYwnILHOcXXKQQN9GsylEXYXORDUgTXqnY1qh03M0LtDfNxNlom6f+U4bDB641B
         6462IM32aqZAA5YYcf3OdiY/bno0T//cO2jfYb6tj1zZ5mpppqZqfpq4OEjHpdoP7fTM
         XOlQ3DWpMKhReqCZd4hm7LXTSC38uNZqu1QV/9Oe/Vv69SYXan7+C7jGhWvXLEl2eDw6
         wxdg==
X-Gm-Message-State: AOJu0YytOEhVD/Lne/iR7wpRJAmHVAx0M/tL3CH0HgRSx1n/ZelzArQk
        zfbioQCOlUHgT+dznkibROePHa+F+yI=
X-Google-Smtp-Source: AGHT+IFV5tV3//QjGmVmppct6PwpDpPOizUHi1+e/PWkSYXnddQsZMLTEun3JdOKBwDTc/ow3wO73Wx/+3M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d887:b0:1cc:47d4:492c with SMTP id
 b7-20020a170902d88700b001cc47d4492cmr63679plz.11.1698682039706; Mon, 30 Oct
 2023 09:07:19 -0700 (PDT)
Date:   Mon, 30 Oct 2023 16:07:18 +0000
In-Reply-To: <20231030141728.1406118-1-nik.borisov@suse.com>
Mime-Version: 1.0
References: <20231030141728.1406118-1-nik.borisov@suse.com>
Message-ID: <ZT_UtjWSKCwgBxb_@google.com>
Subject: Re: [PATCH] KVM: x86: User mutex guards to eliminate __kvm_x86_vendor_init()
From:   Sean Christopherson <seanjc@google.com>
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     pbonzini@redhat.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023, Nikolay Borisov wrote:
> Current separation between (__){0,1}kvm_x86_vendor_init() is superfluos as

superfluous

But this intro is actively misleading.  The double-underscore variant most definitely
isn't superfluous, e.g. it eliminates the need for gotos reduces the probability
of incorrect error codes, bugs in the error handling, etc.  It _becomes_ superflous
after switching to guard(mutex).

IMO, this is one of the instances where the "problem, then solution" appoach is
counter-productive.  If there are no objections, I'll massage the change log to
the below when applying (for 6.8, in a few weeks).

  Use the recently introduced guard(mutex) infrastructure acquire and
  automatically release vendor_module_lock when the guard goes out of scope.
  Drop the inner __kvm_x86_vendor_init(), its sole purpose was to simplify
  releasing vendor_module_lock in error paths.

  No functional change intended.

> the the underscore version doesn't have any other callers.
> 
> Instead, use the newly added cleanup infrastructure to ensure that
> kvm_x86_vendor_init() holds the vendor_module_lock throughout its
> exectuion and that in case of error in the middle it's released. No
> functional changes.

