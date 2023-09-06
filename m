Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3882796D9A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 01:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240901AbjIFXZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 19:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjIFXZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 19:25:33 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D53C1739
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 16:25:30 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-493545b4eaeso141190e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 16:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694042729; x=1694647529; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AxlMpyfAXFHqTylsJ6r8hVsuVIraJSfKnWULsZSuxYc=;
        b=2jasvDOTBl12xVB1TO5H3J0L+bdljIiF2LQaI+CzWhDDNLXNCMB1t1BYaICj3M0ad0
         /jqUNUApkg07odkgcK97otMhYBJLq707OcCgvJ7t0NggDcNoUyzymiIk8iSbKuI0Y7DK
         koInxYFk5MaHcnJ8ifbSm7Xeqh9pnsVZc6hsbMSYYFztklwPIGoXVlM+ZYk84iBINwaY
         36MZKcowDnMdsftPL9MWZt50GXJ3+N0jtLj/MzfE2iiFD84S3jFgF+28hfCI/6otCmkQ
         2OOzRTlxqYRHRSrUGFcppgrRY0GdD10bbV9D4F2YiJTd7BuWIM9H4LqvbS/yPyU4icVe
         6QpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694042729; x=1694647529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxlMpyfAXFHqTylsJ6r8hVsuVIraJSfKnWULsZSuxYc=;
        b=VmEc7hzI99QusUNWvk3AOsFc65OEDKJU6MQMBrncw2NbgjvAinXIwHDbNHlWlSrUdg
         qyXMBivqmb5bviumPiJ29jiMjfg7LqXrc52TI1DhOrIiNkyNXc0BFf5NUQFf83xt3aKA
         vC066BrKBbb45mx5q7csM4qPLzVwScfDxeGYRdpHq1/7NDUP2xxp2zYRjHRACEWw5m8w
         2mrUI+IoB96v5l+44vgZre834j38AgnpO8GOAifkZ9OQ+i9PHziIH8AKL3UpcZ1m3vY+
         QaOjZSucSG+rIkascqVXP4Ss/HYHC43GEWijXIjEIF0TiILft7dC1g5/x22wEk3UU1ZD
         f35A==
X-Gm-Message-State: AOJu0YxEt1vBBruAcAuNyuyoeqUNBKvJDYlh+OZX335ongSzE7LvcXM5
        63UjyNC0wd0i5ZNFNSyA+Cf3XpcqDAxPPPIFZVqY2A==
X-Google-Smtp-Source: AGHT+IGvpqI6hC2I9OgAy8VBumOgaK2u4te0SuFTJLdSnN7A9rjmNIH9oHK6O2GNZeS2+tG7sRVqlIK/xrOgO09hyh8=
X-Received: by 2002:a1f:e743:0:b0:493:61d1:b3cc with SMTP id
 e64-20020a1fe743000000b0049361d1b3ccmr4333757vkh.6.1694042729132; Wed, 06 Sep
 2023 16:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230906224541.2778523-1-acdunlap@google.com> <e037f1c0-aaf6-7951-04ea-6d27e557b61b@intel.com>
In-Reply-To: <e037f1c0-aaf6-7951-04ea-6d27e557b61b@intel.com>
From:   Adam Dunlap <acdunlap@google.com>
Date:   Wed, 6 Sep 2023 16:25:17 -0700
Message-ID: <CAMBK9=b9V6WxYZNrVPNV5vzBZ-mT_noBAxod=ijqrV3bUXAUyA@mail.gmail.com>
Subject: Re: [PATCH] x86/sev-es: Do not use copy_from_kernel_nofault in early
 #VC handler
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, Jacob Xu <jacobhxu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Usually, we'll add some gunk in arch/x86/boot/compressed/misc.h to
> override the troublesome implementation.  In this case, it would make a
> lot of sense to somehow avoid touching boot_cpu_data.x86_virt_bits in
> the first place.

Thanks for the comment. I realize this patch is doing something a bit misleading
here. In this case, "early" does not refer to the compressed kernel, but
actually the regular kernel but in the stage with this early #VC handler
vc_boot_ghcb (instead of the usual vc_raw_handle_exception). This #VC handler
triggers for the first time on a cpuid instruction in secondary_startup_64, but
boot_cpu_data.x86_virt_bits is not initialized until setup_arch inside of
start_kernel, which is at the end of secondary_startup_64.

The compressed kernel already has its own implementation of vc_decode_insn which
simply calls memcpy instead of copy_from_kernel_nofault, so the point of this
patch is to do the same thing for the early stages of the post-decompression
kernel.

So unless I'm misunderstanding, adding a version of copy_from_kernel_nofault to
the compressed directory wouldn't solve the problem since the problem does not
occur during the compressed stage.
