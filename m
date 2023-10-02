Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8BA7B5B34
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbjJBTVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjJBTVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:21:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5B0AC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 12:21:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d85fc108f0eso115066276.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696274488; x=1696879288; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t6T5u8n63H32m/YuZ6al8a5T5YBKCODxao+/slOadeI=;
        b=JXPGgIgj8j3Xjygz/vPx2g+8u1uMbF82N3/mhYyEWpwbmpapRhLvPzJ97TFGF5KltE
         9pyfhggldqoSjmGEtRA1Jk+HpvubScXLHClP/wJw/JIzPT8+rUtDwV0WRoa2PXuPQoCV
         F2AVsRe+y8idstwiE/ZlH278Zufb1Li6el7AZFYvRRuBNXk/D6RYQTZBm0433NuMs85U
         gUPKd1VF0vXYX3yv5fA2Ch8EiC45XZrnEIweiLcHDj1Cxfit+oMFXmj0qpf06RIoZs8s
         VivfZFubWbF+f5pUKu7oQDcxI+YO7Ojd9QQ/ScAGsZ+kgy4uE7BUOlXXKVVU2k7PGuBH
         /UfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696274488; x=1696879288;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6T5u8n63H32m/YuZ6al8a5T5YBKCODxao+/slOadeI=;
        b=Sg2qECsMcstCWf+q5qJ+ecAFauSfHaidnx7MfAsoNOVLU+QjRcVgymxrXMWjwfPI48
         jokCYXCJmuHGToCVLlZzKqvUFTChWvUf+RBqyTbLgCdBAMo0hEvBNF6PWttNdrFU5tJd
         VlHoQ8UPlzGEI7TEBaTgUyiL7Gsbdjj22jAG/Yzi0ddXhgbwnsbOyAqir+xjrU4/zTUt
         0Sht3aeCex3tUEDLxAd+aAQ+CZdij7n0eCmz3ivkpgRmwR3MgH6PYDKzQk0+CXEYWRgi
         luV+eoSHT7cSVg/pOzgkYCc54ySBRFqLqj9AoiphV6j4ToyLajeQH4tNW5tyqLN9zN2y
         feEQ==
X-Gm-Message-State: AOJu0YwUHzlJYuCXkrqxb8EIMi0ZnXUoFJbAwFiQJRuZBjRMbpCGpZhQ
        2E0u5U24fz9hJtIFrqCGKGomoRKK6m4=
X-Google-Smtp-Source: AGHT+IHtmSpMO46KvblpohsWz6O2OSsiMptb0VeaGAhA3nbdHgcxj9vvtm/o9rpvvprle6yfo7JS3Vq54xM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2d12:0:b0:d7e:8dee:7813 with SMTP id
 t18-20020a252d12000000b00d7e8dee7813mr200701ybt.8.1696274487816; Mon, 02 Oct
 2023 12:21:27 -0700 (PDT)
Date:   Mon, 2 Oct 2023 12:21:26 -0700
In-Reply-To: <20231002115723.175344-1-mlevitsk@redhat.com>
Mime-Version: 1.0
References: <20231002115723.175344-1-mlevitsk@redhat.com>
Message-ID: <ZRsYNnYEEaY1gMo5@google.com>
Subject: Re: [PATCH v3 0/4] Allow AVIC's IPI virtualization to be optional
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        Paolo Bonzini <pbonzini@redhat.com>
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

On Mon, Oct 02, 2023, Maxim Levitsky wrote:
> Hi!
> 
> This patch allows AVIC's ICR emulation to be optional and thus allows
> to workaround AVIC's errata #1235 by disabling this portion of the feature.
> 
> This is v3 of my patch series 'AVIC bugfixes and workarounds' including
> review feedback.

Please respond to my idea[*] instead of sending more patches.  I'm not opposed to
a different approach, but we need to have an actual discussion around the pros and
cons, and hopefully come to an agreement.  This cover letter doesn't even acknowledge
that there is an alternative proposal, let alone justify why the vcpu->loaded
approach was taken.

[*] https://lore.kernel.org/all/ZRYxPNeq1rnp-M0f@google.com
