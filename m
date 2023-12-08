Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC0880A8A3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjLHQVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjLHQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:21:08 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C024199E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:21:14 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1d0c4af46cdso14960935ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 08:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702052473; x=1702657273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tn2js7FD63PZPF5/U2hMAUmYqMluIo8bm6m0EGWnrq8=;
        b=qGS4TmoY9gPpC5+oOBgbzik/oBUuVsjqWviOS/YVQOdiL1QEWoKLdDXb7kbKeA+6xi
         EcFpg1+JrRUdHhqp6YJ4Uf/yoBEn51RNjghzDZZPtaJNitLsyNHm/oIFngU7ItCtUUXy
         3EtiqdBG+lL5nqKiwSOb2CATFZgqjYJr4FAlYIQFUWdEoGcpwWu4WICDfwiVaxB9gGTW
         pWPnr2vE0cK26rYSMWJGH3B4jVFmdPP6Kqw1bLa9hiQ5asORfbSf1qHP2s4hpGTBEtA4
         N9ejwWw/e3vjSSXmQg4gFPYWbd2xbppQyeoZzG7AT9KDQM/efhmYkOphgxV38eOAFPsr
         87VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702052473; x=1702657273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tn2js7FD63PZPF5/U2hMAUmYqMluIo8bm6m0EGWnrq8=;
        b=ppzmj2008Yp4Oln5OG7H/IIbahRoP8WephyEncAfNjhO3Q24RMsy8tQCFgJgd2DpXC
         Yrt1t1m7At4A/fldTw7JGw5KhCYz3Cd/FWbYfFoKF5ZjVXs6j5nT5H+Fo8eTnKpbI5P9
         Ibzzxxjl2hQ7129uUokP57K+faTkxCRsBDBKLkTCI5o4gexsA4o7h+Wuj310j1KDY3wk
         pATh43f70UT0bqK6q915Ulew0003c2OJU8u/FyeHMw+IJ4TYcNtbuzXb1OuHvAG7xDmQ
         4AkcyNDkPpXLLXPoXKZ9g1NXV37w1OUmS5/Egz0EyMptaqwqaUzb3QuNvwNlS8tmjZj/
         IuBA==
X-Gm-Message-State: AOJu0Yw0FpFsExtW92KWVuPlqcnHhnjkyWrc6fc3uTztlKqEJuLIM4j4
        NkGCki3zkRptqx0UaKNlpk3nt79FSOk=
X-Google-Smtp-Source: AGHT+IFWQtVJ0r4eHGvVtUIeVYSgkmqQlzHfiGMIkd/nLI8qwI88lt5tQTOe7hJPAwvkVngG53ghJy8eGhM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e804:b0:1d0:c2be:3d9d with SMTP id
 u4-20020a170902e80400b001d0c2be3d9dmr3772plg.7.1702052473502; Fri, 08 Dec
 2023 08:21:13 -0800 (PST)
Date:   Fri, 8 Dec 2023 08:21:12 -0800
In-Reply-To: <20231208033505.2930064-1-shahuang@redhat.com>
Mime-Version: 1.0
References: <20231208033505.2930064-1-shahuang@redhat.com>
Message-ID: <ZXNCd5UKYS_90xAD@google.com>
Subject: Re: [PATCH v1] KVM: selftests: Fix Assertion on non-x86_64 platforms
From:   Sean Christopherson <seanjc@google.com>
To:     Shaoqin Huang <shahuang@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023, Shaoqin Huang wrote:
> When running the set_memory_region_test on arm64 platform, it causes the
> below assert:
> 
> ==== Test Assertion Failure ====
>   set_memory_region_test.c:355: r && errno == EINVAL
>   pid=40695 tid=40695 errno=0 - Success
>      1	0x0000000000401baf: test_invalid_memory_region_flags at set_memory_region_test.c:355
>      2	 (inlined by) main at set_memory_region_test.c:541
>      3	0x0000ffff951c879b: ?? ??:0
>      4	0x0000ffff951c886b: ?? ??:0
>      5	0x0000000000401caf: _start at ??:?
>   KVM_SET_USER_MEMORY_REGION should have failed on v2 only flag 0x2
> 
> This is because the arm64 platform also support the KVM_MEM_READONLY flag, but
> the current implementation add it into the supportd_flags only on x86_64
> platform, so this causes assert on other platform which also support the
> KVM_MEM_READONLY flag.
> 
> Fix it by using the __KVM_HAVE_READONLY_MEM macro to detect if the
> current platform support the KVM_MEM_READONLY, thus fix this problem on
> all other platform which support KVM_MEM_READONLY.
> 
> Fixes: 5d74316466f4 ("KVM: selftests: Add a memory region subtest to validate invalid flags")
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---

/facepalm

Reviewed-by: Sean Christopherson <seanjc@google.com>
