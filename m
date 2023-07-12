Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F427513C5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjGLWuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjGLWut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:50:49 -0400
Received: from out-32.mta1.migadu.com (out-32.mta1.migadu.com [IPv6:2001:41d0:203:375::20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A761991
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:50:46 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689202244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UGwO+NFWVQ6+B443EQUy8r3A++Fa14LZLWf0tT7Rus0=;
        b=UxHnr5rV6hfCEyOAsdIBnSUrJOh9nbAbwubUfn49e15xmnCPJ9mAqlFvwBT7px7TMqShj/
        sYSNok/9alT3jgq8AZzMqyexGbwaShTsLvoWs0dfgzvVMvh5WynUXUO2DeYeJRpuTlHO2q
        R02CeVXI72J9fYLWnOSFb4UoNJk/u0A=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, maz@kernel.org,
        Mostafa Saleh <smostafa@google.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>, suzuki.poulose@arm.com,
        tabba@google.com, james.morse@arm.com, qperret@google.com,
        bgardon@google.com, sudeep.holla@arm.com, gshan@redhat.com,
        yuzenghui@huawei.com, will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v2] KVM: arm64: Add missing BTI instructions
Date:   Wed, 12 Jul 2023 22:50:34 +0000
Message-ID: <168920214959.3096128.780259299986215400.b4-ty@linux.dev>
In-Reply-To: <20230706152240.685684-1-smostafa@google.com>
References: <20230706152240.685684-1-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2023 15:22:40 +0000, Mostafa Saleh wrote:
> Some bti instructions were missing from
> commit b53d4a272349 ("KVM: arm64: Use BTI for nvhe")
> 
> 1) kvm_host_psci_cpu_entry
> kvm_host_psci_cpu_entry is called from __kvm_hyp_init_cpu through "br"
> instruction as __kvm_hyp_init_cpu resides in idmap section while
> kvm_host_psci_cpu_entry is in hyp .text so the offset is larger than
> 128MB range covered by "b".
> Which means that this function should start with "bti j" instruction.
> 
> [...]

Applied to kvmarm/fixes. Sorry this took longer than expected, Mostafa. I
was hitting an unrelated issue with pKVM initialization on the only system
I have that supports BTI.

[1/1] KVM: arm64: Add missing BTI instructions
      https://git.kernel.org/kvmarm/kvmarm/c/dcf89d111199

--
Best,
Oliver
