Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1584C7B7183
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjJCTHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjJCTG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:06:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA5CAB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:06:56 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-536071e79deso278417a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696360014; x=1696964814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rh8Yz80jnPJhs1iYa7SyyuCUEYbcinIqWYdYuoixQk=;
        b=hLCkx7j4O+/aJ+XOOjxDl2gYHI+IA3pblK1nvrZLnieVidpbso1XOaOMMMli/bBIsU
         Mb3HbSHQLZj3SD55OMJ20054pvDHcKf5RhbcEczGhs8njCvTWX8p9FNUU40ZYNfAhBTo
         3qZ07fBfSX26M9KEu0VpOyDLVnLgFltUu8ys/7mPquCRT5DIhLqDSjhl7gZQJOcWJtZw
         AQSDzoUMeXq5ah0MkmEIjnPJmMJH7kwC0aQIaoBozBFhSqQaUu0wVhGvdvBeoV5aZCiM
         I+R14dg2WxvL3Z5Lwo6qSjRAEEvHEPShLFMMDRNLIEtNcBKzwXc0YeioAeesWOh2Njbj
         1KmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696360014; x=1696964814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rh8Yz80jnPJhs1iYa7SyyuCUEYbcinIqWYdYuoixQk=;
        b=LPLD5Ie7tI69epbeh2jOO+TFUy8yJreaZMZbwUpdcydviEQTxIkVJun/0zZoo1onyk
         LGo0sDYP9kampkSaeHH8LvZtoABXnVu7N4SjAmQCNJcaW2eV0lIPhniLijLfIZtzsN8k
         1fM8OGpgHZ9wn7WjsdGDQPTVCJsIB3ow7oCxRLfS5Oqw+fc26n2OnGawIei/F08j2YFA
         W3dkwDkzF/rCcqFM+PxYpyVY02RztQrbHxHTSdm49TMu/Pzr97ckoMb8zPBb+kw+S00H
         5ghUj3u+lXYjJGXELBZNGUlopeIUaV8PAPGD/+woWv6URVx9xGFWAQlKwDS8iDgvH7Kx
         2jIg==
X-Gm-Message-State: AOJu0YzQjS6lhDp3ivPjFpB1KCTLwYBz35STO75EnH6+MYeLp9XrV2Rd
        czHcj5K8C/o+0dAab6hrTag=
X-Google-Smtp-Source: AGHT+IFByEmpxRHnJvCJSXSaxJ1+9+eTDKM1M9GLHpiiXmtDMyv986aH8TxejFAoHExHmD35hqr3SQ==
X-Received: by 2002:a05:6402:3552:b0:530:8b92:b69d with SMTP id f18-20020a056402355200b005308b92b69dmr2998719edd.10.1696360014446;
        Tue, 03 Oct 2023 12:06:54 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id g13-20020a50ee0d000000b0051e1660a34esm1265750eds.51.2023.10.03.12.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:06:53 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 3 Oct 2023 21:06:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86_64: test that userspace stack is in fact NX
Message-ID: <ZRxmS/3nr6pDa1+z@gmail.com>
References: <4b78a714-5ac3-4783-8256-1dda4673db01@p183>
 <1d5223b8-0275-619d-db1c-e2aaaddb173e@intel.com>
 <d468d13c-6c4b-4d8d-8e2d-e4314b4bb1a7@p183>
 <f972d59c-40dd-2a68-ff13-a2658513a25b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f972d59c-40dd-2a68-ff13-a2658513a25b@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dave Hansen <dave.hansen@intel.com> wrote:

> On 10/3/23 06:00, Alexey Dobriyan wrote:
> > On Mon, Oct 02, 2023 at 07:23:10AM -0700, Dave Hansen wrote:
> >> Basically, could you spend a moment in the changelog to talk about:
> >>
> >> 1. 32-bit kernels on NX hardware
> >> and
> >> 2. 64-bit kernels on non-NX hardware
> > 
> > Sure. My logic whas that i386 is dead arch, but this test is easy to
> > port to i386, only 2 simple functions.
> 
> I honestly don't feel strongly about it one way or the other.  But
> whatever we do, let's explain it, please.
> 
> > I don't want to parse /proc/cpuinfo. If someone knows they're shipping
> > NX-incapable hardware, just let them disable the test.
> 
> Other than clearcpuid=nx, I don't _think_ we have any way to clear the
> X86_FEATURE_NX bit right now.  That should mean that you can use regular
> old CPUID to see if the booted kernel supports NX. [...]

I think that's probably overkill - the test should report a failure if
NX is not available for whatever reason.

Because not having NX in 2023 on any system that is threatened is a
big security vulnerability in itself, and whether the vendor or owner
intentionally did that or not doesn't really matter, and a failing
kernel testcase will be the least of their problems.

In fact I'd argue that we should fail this testcase in that situation
as a matter of principle: NX clearly doesn't work and there's very
few situations where that's acceptable.

Anyone who doesn't want or have NX can skip paying attention to this
failing testcase just fine.

Thanks,

	Ingo
