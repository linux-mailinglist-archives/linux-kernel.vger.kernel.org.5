Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C44B7D3C36
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjJWQVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjJWQU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:20:59 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1258410C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:20:57 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cbe08af374so2044375ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698078056; x=1698682856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6M5Qcu8/m7OmULF94b0ZtR8TUikaFRq5dVXXqiKXwE=;
        b=VsPR9Aa7h9wJMuKyJLL0Rrk7gSaJd4M0k/q8KjPP6SGHXf+bEtIbH9h5d9z7USI4tK
         VTBC/bwSa176KERuEeEtnJFzYqcbvDFVGkmmFyDULik+30g6E2oz2+RMwax9KCxtJLDc
         JhjH+bDrjSKs8fpDiMj3vT8KW7c/l3T7r+pL5v6xo7zeGgkFL1bBC5l2+8QFhzoKpH0Y
         pUGV1r7ngWc3HRF1gV1zz2uJZ4vQ9SgmQnjFthTHJIw6PqVmEkNw0zyL7E83hvHjpv6Y
         7hTp4cOR/AtwApc3hnr9Sic9uX8oEZ3aOqDUSeDLp8Wlzo9L2qwG6M1o7Ap22ioznSoS
         EBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698078056; x=1698682856;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6M5Qcu8/m7OmULF94b0ZtR8TUikaFRq5dVXXqiKXwE=;
        b=NUMSfS9WjA3VNywGnhKDmzNCzhJPrnbJZCl8yBXhuIvVAAHmyJjGARWr5LW3j4HBJq
         fOwN6EBTauLBjnS1dla1EadJYku4/xbVBFBUO6Nb3WoySv7DEvk5m8N8EArvr6SxJSuj
         GmzMZIDHOww0YZb4QKaT3lgpY1JS/dWa9trq/Q9d6EY3OC7d4yyvwvM3eYYP/t55qLK6
         TiTdP1O0GNgw4DNz/Ipz3GlKOn5p/UFFn+2Kg5jnjdPDVAtBXy+DUIOmv6l3J8ajphZc
         C1Rf0jt4BXxzyXdtELfKOVC8z+E84M7uZL49srEauNjL7RIyY40aLRw7QoQlpibfm+eF
         GiTw==
X-Gm-Message-State: AOJu0YxoEHRWZeF70Hi5rPBOaxe0RFxrlx4zu1mJTryiZCbiD3qdRW4q
        KaCbPMVwh4CiblJwRGALXw9jtjZnq+I=
X-Google-Smtp-Source: AGHT+IE9RhMoOLSJBVIJXK/i7kHEGZvfdQgmWbkxVDAbHyWfkKuY1/wHnvUHmuSIonljHFPKy/AX6Q3ht4s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:23cc:b0:1ca:4d35:b2f9 with SMTP id
 o12-20020a17090323cc00b001ca4d35b2f9mr176090plh.8.1698078056416; Mon, 23 Oct
 2023 09:20:56 -0700 (PDT)
Date:   Mon, 23 Oct 2023 09:20:54 -0700
In-Reply-To: <20230913124227.12574-3-binbin.wu@linux.intel.com>
Mime-Version: 1.0
References: <20230913124227.12574-1-binbin.wu@linux.intel.com> <20230913124227.12574-3-binbin.wu@linux.intel.com>
Message-ID: <ZTadZtriaQeKHksJ@google.com>
Subject: Re: [PATCH v11 02/16] KVM: x86: Use a new flag for branch targets
From:   Sean Christopherson <seanjc@google.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, chao.gao@intel.com, kai.huang@intel.com,
        David.Laight@aculab.com, robert.hu@linux.intel.com,
        guang.zeng@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023, Binbin Wu wrote:
> Use the new flag X86EMUL_F_BRANCH instead of X86EMUL_F_FETCH in assign_eip()
> to distinguish instruction fetch and branch target computation for features
> that handle differently on them, e.g. Linear Address Space Separation (LASS).

A slightly different shortlog+changelog:

  KVM: x86: Add an emulator flag to differntiate branch targets from fetches

  Add an emulator flag, X86EMUL_F_BRANCH, and use it instead of
  X86EMUL_F_FETCH in assign_eip() to distinguish between instruction fetch
  and branch target computation for features that handle them differently,
  e.g. Intel's upcoming Linear Address Space Separation (LASS) applies to
  code fetches but not branch target calculations.

The shortlog in particular is far too vague.

> As of this patch, X86EMUL_F_BRANCH and X86EMUL_F_FETCH are identical as far
> as KVM is concerned.

This patch looks good, but I'm going to skip it for now as it's not needed until
LASS is supported, since LAM doesn't differentiate between the two.  I.e. this
should have been the first patch in the LASS portion of the series.  No need to
repost, it's trivially easy to tweak vmx_get_untagged_addr().
