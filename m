Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00417B89F0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244325AbjJDSar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244322AbjJDSal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:30:41 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896A7A7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:30:38 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2777d237229so85742a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696444238; x=1697049038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bLvtp0QMoGYySE9wosYwCfDiMQTfzGa8df2T3UXcExo=;
        b=SeVze/GnEE+ou15Shp91ACh89GI0NGvSy8mM+kRHbKPuQl9dw4jf4EnlUQ9ne9Qz4z
         cD+CcomkKvkuWtKLXG8UwcVx6cKpUdXsnrX6OsNmf8OEFbYgjl0COdCnxHtZjF/s+YWS
         PvA/27jqQ9ELBFNxZ2d+ynUj4+JYkx30Ut/fedvMgt9jcpfWDozkYbNAgUoTF+xMiax/
         5MqSuBDgsjDO8qa7x345jL64m5EM0SPKzbyIe7ukLjeXvLJEOB0jEd0tmq6gAlDrS5ze
         lg23kU3YqbW2U3a0R8Vtqfm/bUachzWUKfwuvApAFaQhkX/lp6QAbD/8CiIPJd6HY/iK
         Okag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696444238; x=1697049038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bLvtp0QMoGYySE9wosYwCfDiMQTfzGa8df2T3UXcExo=;
        b=EjBNWfICUFLPJxsUg0Oa/QlubhUVf721n6MzDNnBf8a0ur4fok3UO8PS1IgcfucQ9A
         ssHVVz5KS3YLfVXpxz0NrMSBUmWJJ3h+RcSSvdW1Xt0cBYWyDiJAp/5wlXKe2AgeDBQp
         vNI9Qv++6OFuTBK6zQskoG+jXGE8K/n3IDm/YK79ZIzEkVMSyMTyg2AUPDLqpInyEHlK
         rrYypjuCaIaRPK18iThjppI5/rVscfC0hBZmONPydKCmJSocjGt0QazPNblbwzXLnUGz
         nHhjruzqfdBZJ/+xNIz3ObuPhEEfyJsZOrQyynWtLvTnoJIHU6rXDNw9PthJ/1q/gqRV
         CKWw==
X-Gm-Message-State: AOJu0YwKwIhsMWDCqZB1MIKY+wF5Ok3jlsGoijt9ns6jpuZXQ8t4utb9
        Hq/bFcpRdozN4oferjSC/V+I4volEHw=
X-Google-Smtp-Source: AGHT+IFb4/zLDHhoTO/L9ADnf3OtDeiNfQcNDUYeMN7UNbw0aWvcWor6OIqqX01+H2Up4syc4w8lYLfMUSU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:fb96:b0:279:c5c:136a with SMTP id
 cp22-20020a17090afb9600b002790c5c136amr49428pjb.9.1696444238014; Wed, 04 Oct
 2023 11:30:38 -0700 (PDT)
Date:   Wed, 4 Oct 2023 11:30:36 -0700
In-Reply-To: <20231004174628.2073263-1-paul@xen.org>
Mime-Version: 1.0
References: <20231004174628.2073263-1-paul@xen.org>
Message-ID: <ZR2vTN618U0UgtIA@google.com>
Subject: Re: [PATCH v2] KVM: x86/xen: ignore the VCPU_SSHOTTMR_future flag
From:   Sean Christopherson <seanjc@google.com>
To:     Paul Durrant <paul@xen.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Durrant <pdurrant@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023, Paul Durrant wrote:
> From: Paul Durrant <pdurrant@amazon.com>
> 
> Upstream Xen now ignores this flag [1], since the only guest kernel ever to
> use it was buggy. By ignoring the flag the guest will always get a callback
> if it sets a negative timeout which upstream Xen has determined not to
> cause problems for any guest setting the flag.
> 
> [1] https://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=19c6cbd909
> 
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org

If you're going to manually Cc folks, put the Cc's in the changelog proper so that
there's a record of who was Cc'd on the patch.

Or even better, just use scripts/get_maintainers.pl and only manually Cc people
when necessary.
