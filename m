Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D027CA9AD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjJPNgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjJPNg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8636B185
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697463345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yy1/cgxKgJiMUa1SJT7ozjNtxww425JfDJ39NondDok=;
        b=dk4+hS/3xSdctIFKgEHUQ4cKStkU/tpgtD4Cv7pckuwCeXicbxRvTFuWZFDGxo7Uc8y9xm
        lXMayQ7e8qkawp7f9pjIqkfBPl6FDCM4wXGgo4CtfnzjlmWCVkXZtoTTQREJf4TaV7SEwk
        KWfoRys7rh6wu5dyelsc0TwoK1eR37k=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-ryZbvV79PfWt_3kBDAWadA-1; Mon, 16 Oct 2023 09:35:44 -0400
X-MC-Unique: ryZbvV79PfWt_3kBDAWadA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3af602b6512so7857824b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697463343; x=1698068143;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yy1/cgxKgJiMUa1SJT7ozjNtxww425JfDJ39NondDok=;
        b=dQxEHlKeBbisLG8RdUEl+K/5RKW5RzggJIRJUOgjdIAPlYVwDGjq1PT5NBxHHueRWH
         s71AssBxS5QJxsXds+6fOF9psy+S6ZJt7qV9gfrWftI+dTIOhw4h6gxfvPC0wqMTM8o2
         7QWiKGIp3TdPNfU5WevvJLT9dIge3pFMR8bueUFn2X2g5zovdKfOXBXs6okarbUU82Jv
         uoFvi06E7xTk5wnwTaeokRPwh4XwUhH1N2ifJAV2+AIIG+5/kNXoLd0a5ptrNgRa3FbV
         I4bBCgW96v0u3lSH4ppIuH84C98coyh+Op4OT7sTb7uXh726mr05YWA/n6Ri+I38nz4M
         P35w==
X-Gm-Message-State: AOJu0YwIa2r5KiAp+7kNNSreP9Dcy7zSI1Ob5Hl8lOO4yE6tcjHvJk+j
        0yO6IUFSZGUHsOavAB/i6xM+vSucz4O6PdgYYmSsyCXOPU274mN+dYuPLgBHufLP0Byu/3+yYN1
        +oD0VtV8uTrEgmXR8S6IjzR/2
X-Received: by 2002:a05:6808:2112:b0:3af:6634:49b9 with SMTP id r18-20020a056808211200b003af663449b9mr45234742oiw.30.1697463343625;
        Mon, 16 Oct 2023 06:35:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE77paMQjv1E0tWECLik6rtZ5xsUdcoZNEFSPtcpxvsM02M0fanwTqgfdfIspb/jqxNklUPGQ==
X-Received: by 2002:a05:6808:2112:b0:3af:6634:49b9 with SMTP id r18-20020a056808211200b003af663449b9mr45234711oiw.30.1697463343313;
        Mon, 16 Oct 2023 06:35:43 -0700 (PDT)
Received: from rh (p200300c93f0047001ec25c15da4a4a7b.dip0.t-ipconnect.de. [2003:c9:3f00:4700:1ec2:5c15:da4a:4a7b])
        by smtp.gmail.com with ESMTPSA id dl15-20020ad44e0f000000b0066d1540f9ecsm3437870qvb.77.2023.10.16.06.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 06:35:43 -0700 (PDT)
Date:   Mon, 16 Oct 2023 15:35:38 +0200 (CEST)
From:   Sebastian Ott <sebott@redhat.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shaoqin Huang <shahuang@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v7 07/12] KVM: arm64: PMU: Set PMCR_EL0.N for vCPU based
 on the associated PMU
In-Reply-To: <20231009230858.3444834-8-rananta@google.com>
Message-ID: <b4739328-5dba-a3a6-54ef-2db2d34201d8@redhat.com>
References: <20231009230858.3444834-1-rananta@google.com> <20231009230858.3444834-8-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2023, Raghavendra Rao Ananta wrote:
> u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
> {
> -	return __vcpu_sys_reg(vcpu, PMCR_EL0);
> +	u64 pmcr = __vcpu_sys_reg(vcpu, PMCR_EL0) &
> +			~(ARMV8_PMU_PMCR_N_MASK << ARMV8_PMU_PMCR_N_SHIFT);
> +
> +	return pmcr | ((u64)vcpu->kvm->arch.pmcr_n << ARMV8_PMU_PMCR_N_SHIFT);
> }
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index ff0f7095eaca..c750722fbe4a 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -745,12 +745,8 @@ static u64 reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
> {
> 	u64 pmcr;
>
> -	/* No PMU available, PMCR_EL0 may UNDEF... */
> -	if (!kvm_arm_support_pmu_v3())
> -		return 0;
> -
> 	/* Only preserve PMCR_EL0.N, and reset the rest to 0 */
> -	pmcr = read_sysreg(pmcr_el0) & (ARMV8_PMU_PMCR_N_MASK << ARMV8_PMU_PMCR_N_SHIFT);
> +	pmcr = kvm_vcpu_read_pmcr(vcpu) & (ARMV8_PMU_PMCR_N_MASK << ARMV8_PMU_PMCR_N_SHIFT);

pmcr = ((u64)vcpu->kvm->arch.pmcr_n << ARMV8_PMU_PMCR_N_SHIFT);
Would that maybe make it more clear what is done here?

