Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07AD7DE66B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 20:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345253AbjKATcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 15:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345697AbjKATce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 15:32:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201168E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 12:32:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b064442464so2395847b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 12:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698867147; x=1699471947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6IOFILc1juY1gEvvnFoIG8ITiseh8mrQ04o+Gb2z3/Q=;
        b=u0fnYm+/Mhehjs+tjn8iDIp7NIZAwd9q9wqg76RhU4Rd2qFhntWrPdfhRLRx2WicaT
         7vT7MAqNdVGtx6H/fyZkW1LclrCOy0DLBdcTUuAAxxESYCDkaUhewzwr57YiME0kH4Ig
         iXQo5fr3dTzqUpWA7PY6KV4lSdjIL7R/tmC/N9cQpSyBVrR72yLrzSYGGgL4KPUpB1hZ
         yIhWFnlxiM/BCewW9HDJIAZVESOAvJrPcGbBLxvLeF113RJB+37/wVVbPRtQ7JrGTvbr
         ANZaNmfaQMVHkIlrQzQVMQy0GdBJm4eW2ApCiNHgSb29tAuW/PjCvYUypahM9muNp2QR
         bQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698867147; x=1699471947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IOFILc1juY1gEvvnFoIG8ITiseh8mrQ04o+Gb2z3/Q=;
        b=v/E1nE916/FjonGtTXxIyXe9G16vhnT1ASscx4ra7IIrJxBlaTH3w3+Z5xvtFEVPBl
         BizmbhH6E21ik42zLeTy4R+wh1weD6BI4dS/oJrD+PYWH9W01t9Cdm2jhc8TzFwsvW4S
         jd5hBEaNv4lFtPUUV8kT50cr4jZcsu59k86y0k6JxK6VXOV5b1S1prCNYBisZbL1gX+j
         eBZ7jhqbtZIVVwomGUtKQ8bdiCwMiRvw5FQ40ihpTKWp+G8HLXnLD4YrdS+KMbk4WsSy
         bcwRkwqbNftN6bHMAyDnMYq4sJnPrglwqw1+b/yODNcTj8uoq4mSqajCDrrSxiiIcYaq
         4RKQ==
X-Gm-Message-State: AOJu0YwT3Ao6MnptqVC2IknLYdB3U7prl/4lBOlsWsTH8qV08DjTrDwz
        it3ZRMD/+JewrA2Yu/+YM5t5Km0qt3s=
X-Google-Smtp-Source: AGHT+IGcHEr0x9rrRKoy4mO3Yhn1gyEFe0DDAl1bhpW3gzQoxc7OCR9FRvOVEppdVcqmAkuT32MQrLIjjDI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:9385:0:b0:da0:59f7:3c97 with SMTP id
 a5-20020a259385000000b00da059f73c97mr290120ybm.12.1698867147286; Wed, 01 Nov
 2023 12:32:27 -0700 (PDT)
Date:   Wed, 1 Nov 2023 12:32:25 -0700
In-Reply-To: <92faa0085d1450537a111ed7d90faa8074201bed.camel@redhat.com>
Mime-Version: 1.0
References: <20230914063325.85503-1-weijiang.yang@intel.com>
 <20230914063325.85503-11-weijiang.yang@intel.com> <92faa0085d1450537a111ed7d90faa8074201bed.camel@redhat.com>
Message-ID: <ZUKnyfbRqTFhMABI@google.com>
Subject: Re: [PATCH v6 10/25] KVM: x86: Add kvm_msr_{read,write}() helpers
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023, Maxim Levitsky wrote:
> On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> > Wrap __kvm_{get,set}_msr() into two new helpers for KVM usage and use the
> > helpers to replace existing usage of the raw functions.
> > kvm_msr_{read,write}() are KVM-internal helpers, i.e. used when KVM needs
> > to get/set a MSR value for emulating CPU behavior.
> 
> I am not sure if I like this patch or not. On one hand the code is cleaner
> this way, but on the other hand now it is easier to call kvm_msr_write() on
> behalf of the guest.
> 
> For example we also have the 'kvm_set_msr()' which does actually set the msr
> on behalf of the guest.
> 
> How about we call the new function kvm_msr_set_host() and rename
> kvm_set_msr() to kvm_msr_set_guest(), together with good comments explaning
> what they do?

LOL, just call me Nostradamus[*] ;-)

 : > SSP save/load should go to enter_smm_save_state_64() and rsm_load_state_64(),
 : > where other fields of SMRAM are handled.
 : 
 : +1.  The right way to get/set MSRs like this is to use __kvm_get_msr() and pass
 : %true for @host_initiated.  Though I would add a prep patch to provide wrappers
 : for __kvm_get_msr() and __kvm_set_msr().  Naming will be hard, but I think we
                                             ^^^^^^^^^^^^^^^^^^^
 : can use kvm_{read,write}_msr() to go along with the KVM-initiated register
 : accessors/mutators, e.g. kvm_register_read(), kvm_pdptr_write(), etc.

[*] https://lore.kernel.org/all/ZM0YZgFsYWuBFOze@google.com

> Also functions like kvm_set_msr_ignored_check(), kvm_set_msr_with_filter() and such,
> IMHO have names that are not very user friendly.

I don't like the host/guest split because KVM always operates on guest values,
e.g. kvm_msr_set_host() in particular could get confusing.

IMO kvm_get_msr() and kvm_set_msr(), and to some extent the helpers you note below,
are the real problem.

What if we rename kvm_{g,s}et_msr() to kvm_emulate_msr_{read,write}() to make it
more obvious that those are the "guest" helpers?  And do that as a prep patch in
this series (there aren't _that_ many users).

I'm also in favor of renaming the "inner" helpers, but I think we should tackle
those separately.separately
