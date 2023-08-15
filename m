Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84D077D61A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbjHOWb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240420AbjHOWbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:31:34 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34D71FF3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:31:31 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55c7bb27977so9097879a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692138691; x=1692743491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c05rm68PGHctHfBOW0BB2Jo3SVzvE3TlPm3JKZSv5Mw=;
        b=zSFF7IvUGxfd6gkBF8F4GxNIfCZDaje81HGokT4kVqC0KU5MBZZfnSNOssjA6mgPAN
         cRsGYufjjTrofJ5vumrJHSKBn+aQkdbQm8SJ6Tg7pe3uSFLBt5uqtw3fpFPHIwqCLQwl
         XcScAy71RtNQVglvUX71pW9VDOezt9WeMjdzJpB8j6xCtBMrW64e4RqjVsEAATOLSY+2
         Kc0mkrDGoXj1Uxkmf3RdCa1iiwYYcPfTD1tlmgV7Y1a7fsQcwwVcxfXNnu1VMojtXQVU
         cWzhmvK9BEtXIJT8SQyPj67km+M1Y0mj0c3KYu6zoMpRyt7aoFrrEFWzb2h44tTJG4MZ
         Z3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692138691; x=1692743491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c05rm68PGHctHfBOW0BB2Jo3SVzvE3TlPm3JKZSv5Mw=;
        b=kXrH/muq0sh4OpFY3/grq9YmEn0u8sG/e2c8HBoKLCm7rl403oSb876EFK1MLjJSos
         FRfAwvWSiLaXANKQj3eFtIWpPCEsZzxX0Axu8eb8HpBcwcV+mhTFqz4Ituug1P7DMILq
         ZO9T+3GR6VTMxTOcMyOZuOz6eq2Psb6buAxqBokJ1dACL4DSa31k0UUAoUdGo2xtsyv4
         79N9pRiPi8tdJgzRg9x6bOim7AIlHEeXSQTkrtQIZQCUKbTiWDI9GI7ORNVARD2femuj
         Xx8Pkhr70g91f3M4Ee/G2+DM7dvdEZFNY6uMjj7VS0uFTcqw4pt9X5crPLM8cuzN7tou
         8ooQ==
X-Gm-Message-State: AOJu0YyZ0MhhfguQIsVOLzRtuA0WM4G1R8H5tlB05XjTMgWKKVmuuWsO
        lB+R8D9qGbptgB93ZwcgKnvMP5cWAgE=
X-Google-Smtp-Source: AGHT+IFdD7miISJ5FT27quR/P7x6Ii7fo9teB2QXXhYX+gchH8nb3ttm0pZzM2e0YrayRrW5/0n1JDm2xpA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:3e4c:0:b0:563:dced:3f35 with SMTP id
 l73-20020a633e4c000000b00563dced3f35mr36925pga.4.1692138691431; Tue, 15 Aug
 2023 15:31:31 -0700 (PDT)
Date:   Tue, 15 Aug 2023 15:31:29 -0700
In-Reply-To: <20230811045127.3308641-7-rananta@google.com>
Mime-Version: 1.0
References: <20230811045127.3308641-1-rananta@google.com> <20230811045127.3308641-7-rananta@google.com>
Message-ID: <ZNv8weRKhSeLYWIc@google.com>
Subject: Re: [PATCH v9 06/14] KVM: Move kvm_arch_flush_remote_tlbs_memslot()
 to common code
From:   Sean Christopherson <seanjc@google.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jing Zhang <jingzhangos@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Fuad Tabba <tabba@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Gavin Shan <gshan@redhat.com>,
        Shaoqin Huang <shahuang@redhat.com>
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

On Fri, Aug 11, 2023, Raghavendra Rao Ananta wrote:
> From: David Matlack <dmatlack@google.com>
> 
> Move kvm_arch_flush_remote_tlbs_memslot() to common code and drop
> "arch_" from the name. kvm_arch_flush_remote_tlbs_memslot() is just a
> range-based TLB invalidation where the range is defined by the memslot.
> Now that kvm_flush_remote_tlbs_range() can be called from common code we
> can just use that and drop a bunch of duplicate code from the arch
> directories.
> 
> Note this adds a lockdep assertion for slots_lock being held when
> calling kvm_flush_remote_tlbs_memslot(), which was previously only
> asserted on x86. MIPS has calls to kvm_flush_remote_tlbs_memslot(),
> but they all hold the slots_lock, so the lockdep assertion continues to
> hold true.
> 
> Also drop the CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT ifdef gating
> kvm_flush_remote_tlbs_memslot(), since it is no longer necessary.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Acked-by: Anup Patel <anup@brainfault.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
