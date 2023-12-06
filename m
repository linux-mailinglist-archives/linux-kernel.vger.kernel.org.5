Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E888073B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379199AbjLFPan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379147AbjLFPal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:30:41 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045EAD53
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:30:48 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d051809221so34099995ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 07:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701876647; x=1702481447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IAZC2v4ypuvtxPizjFSSQnZMRXpvkMqeXdIpFeNZXFU=;
        b=BrW55YqZMX2Au/uTycnICp19hhBsn731+hTYhq9CyX4la756i4t5t4XaYdcuHbjD/+
         CRf+UPIcTd3jZOJrKIDUDb+hKQlCNXPFr8oiMNtJavsohPEvqg9gIZVtYVz+6wT8JYOV
         VIS5rPZrQ6IobJmfE9AVOFpKJy332/w3sthF4SbBdNeGvnAGt7quba05FYWCkKecCUGE
         rsXCZNdKjlKAfLSWmEldh2d+tcyEI3zjjru5zwLv3ogqjw1Gfx3jmVNvkBXNnr4F3534
         YNwsXd0Z2F7kvUMAQNNxedIahvI08wanlguV9MH1Ozaac7MHvkpEemxla5ekZAnwvxx7
         Uz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701876647; x=1702481447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAZC2v4ypuvtxPizjFSSQnZMRXpvkMqeXdIpFeNZXFU=;
        b=sRklGfiLpKJUpU8zxE7pf3NRQ1fDK8Lc7po0j5FkugtF4ZPOuG2AyJB6J9XQ9XEW0f
         3nBEupE2fDjOwnP8IwDgpYgfbk8GzNTtSx9tbkQVVcIzB62zLf9KRb2HaNc+L9EFl9Gc
         lDCMZgpaf4nTitBbTUp7T81qFSWfjbOV1u9c+D/+/eaXCJs7v58x5RiCp4GgbBVrXTrX
         ++YGzcOfDTdkSiuGkxfe2SWHRQAs6AqxNlHx50eM4grKTzlndlYPHkyVnA6+S6uuU1ns
         2OLVE5wBbHBrtm4AiG32w3v4/ECCDuslNi2Rx9xflXTOl2EClSFC9RRmyS4Xocg3fWBn
         qRmg==
X-Gm-Message-State: AOJu0Yzk7FBQ0WtShXpq+spFoqMrMYsLPycAyuIiZ5gL+Rn/pKzudd2b
        GfqL2zRhgCk9K4QtotjiWY8tCPJrxbI=
X-Google-Smtp-Source: AGHT+IHPAp7FETKY164sZ7rMnNRMfbZoTS7QEpWZ7Kkr5cqKmyV8OSEzsF3xjQ7jtKwDTxKq28GGWikNrao=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:3304:b0:1d0:c3e7:d4c with SMTP id
 jk4-20020a170903330400b001d0c3e70d4cmr13136plb.2.1701876647461; Wed, 06 Dec
 2023 07:30:47 -0800 (PST)
Date:   Wed, 6 Dec 2023 07:30:46 -0800
In-Reply-To: <20231206032054.55070-1-likexu@tencent.com>
Mime-Version: 1.0
References: <20231206032054.55070-1-likexu@tencent.com>
Message-ID: <ZXCTppx4II1sbRAl@google.com>
Subject: Re: [PATCH v2] KVM: x86/intr: Explicitly check NMI from guest to
 eliminate false positives
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't make up random prefixes.  This should really be "x86/pmu".

From Documentation/process/maintainer-kvm-x86.rst:

Shortlog
~~~~~~~~
The preferred prefix format is ``KVM: <topic>:``, where ``<topic>`` is one of::

  - x86
  - x86/mmu
  - x86/pmu
  - x86/xen
  - selftests
  - SVM
  - nSVM
  - VMX
  - nVMX


...

New topics do occasionally pop up, but please start an on-list discussion if
you want to propose introducing a new topic, i.e. don't go rogue.
