Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D617C6C3B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378237AbjJLLZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343832AbjJLLZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:25:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EAFC9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 04:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697109883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zveky+Fb/XNh+9tQfE5JhzGTXcVCcRXpZcV7+5bnPhg=;
        b=A1Zyt3PXocvNx7eKIe+4H0HkKUm674W050+ovBQaJQYBwavSn3vD1jRkPXaa13NZjys1cc
        TOSHkWYVQg/FPdpIIN0MDZP6cSzjgi9vlyUrg6tW1ueDKrQ3wEC/K22j0wCJojKcTY8M7b
        i4oEvmbsspOIe7UPy5P44hG3TWYQE+M=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-Du8t1abfO12jcNlmfj107w-1; Thu, 12 Oct 2023 07:24:42 -0400
X-MC-Unique: Du8t1abfO12jcNlmfj107w-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3aec0675519so1202565b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 04:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697109881; x=1697714681;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zveky+Fb/XNh+9tQfE5JhzGTXcVCcRXpZcV7+5bnPhg=;
        b=gk5kafHjK+QFSeCzGxHqV3zAxC0N5iiCEixTULdEy7OozgkQDnMpeJvks0YYGulXkI
         t+fFLUt+zzST5CJpTsj2SvGc/twIpcwreKko5c+/lMKjEgIkmg8CmQyvvhnoFnSlIkaW
         BJs6boyrL6C8BeC31aS8q6FK7m4ooM/UpJlhUDEJH2Vje8DlKsyWE7jmayP9b1L1lA8Q
         cXcKanvB8bSrgD8EZhJjrSdEV1eYWaNwRiDnJlepqcQL7pbM/AV8N3mj66M9dfeZimyW
         ZT4a73sAupVNJxLQKrL0xyQm78B5X832mW+pcivhMYxbrugpfjfu0ZQIe2akAFrMLntl
         m99w==
X-Gm-Message-State: AOJu0YzTHcaurmjULuePH6bti7iguUL7Hbc70MLH58KiLRuiK/3MYh6G
        L+CjLtucdNB2HpANVOf1kBqY/eDLlI6Sb3et27bXN6bBii8HuPjy4FR3UbPRhceXQRnm7q40iII
        GoRoRdzDWw6aFZ2MQJo/zhvAr
X-Received: by 2002:a05:6808:f8f:b0:3a7:8e9a:e984 with SMTP id o15-20020a0568080f8f00b003a78e9ae984mr28512007oiw.57.1697109881517;
        Thu, 12 Oct 2023 04:24:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz1AdSl8r7MeuK2blz7z9oGSXJAoJ7gnRP0T4cBTWQndcCo4Q9UcajmnaQPF16FpjhN41QrQ==
X-Received: by 2002:a05:6808:f8f:b0:3a7:8e9a:e984 with SMTP id o15-20020a0568080f8f00b003a78e9ae984mr28511986oiw.57.1697109881304;
        Thu, 12 Oct 2023 04:24:41 -0700 (PDT)
Received: from rh (p200300c93f266600211746b64b43cdf8.dip0.t-ipconnect.de. [2003:c9:3f26:6600:2117:46b6:4b43:cdf8])
        by smtp.gmail.com with ESMTPSA id j12-20020ac84f8c000000b004181a8a3e2dsm6098662qtw.41.2023.10.12.04.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 04:24:40 -0700 (PDT)
Date:   Thu, 12 Oct 2023 13:24:36 +0200 (CEST)
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
Subject: Re: [PATCH v7 10/12] KVM: selftests: aarch64: Introduce vpmu_counter_access
 test
In-Reply-To: <20231009230858.3444834-11-rananta@google.com>
Message-ID: <44608d30-c97a-c725-e8b2-0c5a81440869@redhat.com>
References: <20231009230858.3444834-1-rananta@google.com> <20231009230858.3444834-11-rananta@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463795790-917814220-1697109880=:6347"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463795790-917814220-1697109880=:6347
Content-Type: text/plain; charset=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 9 Oct 2023, Raghavendra Rao Ananta wrote:
> +/* Create a VM that has one vCPU with PMUv3 configured. */
> +static void create_vpmu_vm(void *guest_code)
> +{
> +	struct kvm_vcpu_init init;
> +	uint8_t pmuver, ec;
> +	uint64_t dfr0, irq = 23;
> +	struct kvm_device_attr irq_attr = {
> +		.group = KVM_ARM_VCPU_PMU_V3_CTRL,
> +		.attr = KVM_ARM_VCPU_PMU_V3_IRQ,
> +		.addr = (uint64_t)&irq,
> +	};
> +	struct kvm_device_attr init_attr = {
> +		.group = KVM_ARM_VCPU_PMU_V3_CTRL,
> +		.attr = KVM_ARM_VCPU_PMU_V3_INIT,
> +	};
> +
> +	/* The test creates the vpmu_vm multiple times. Ensure a clean state */
> +	memset(&vpmu_vm, 0, sizeof(vpmu_vm));
> +
> +	vpmu_vm.vm = vm_create(1);
> +	vm_init_descriptor_tables(vpmu_vm.vm);
> +	for (ec = 0; ec < ESR_EC_NUM; ec++) {
> +		vm_install_sync_handler(vpmu_vm.vm, VECTOR_SYNC_CURRENT, ec,
> +					guest_sync_handler);
> +	}
> +
> +	/* Create vCPU with PMUv3 */
> +	vm_ioctl(vpmu_vm.vm, KVM_ARM_PREFERRED_TARGET, &init);
> +	init.features[0] |= (1 << KVM_ARM_VCPU_PMU_V3);
> +	vpmu_vm.vcpu = aarch64_vcpu_add(vpmu_vm.vm, 0, &init, guest_code);
> +	vcpu_init_descriptor_tables(vpmu_vm.vcpu);
> +	vpmu_vm.gic_fd = vgic_v3_setup(vpmu_vm.vm, 1, 64,
> +					GICD_BASE_GPA, GICR_BASE_GPA);
> +
> +	/* Make sure that PMUv3 support is indicated in the ID register */
> +	vcpu_get_reg(vpmu_vm.vcpu,
> +		     KVM_ARM64_SYS_REG(SYS_ID_AA64DFR0_EL1), &dfr0);
> +	pmuver = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_PMUVER), dfr0);
> +	TEST_ASSERT(pmuver != ID_AA64DFR0_PMUVER_IMP_DEF &&
> +		    pmuver >= ID_AA64DFR0_PMUVER_8_0,
> +		    "Unexpected PMUVER (0x%x) on the vCPU with PMUv3", pmuver);
> +
> +	/* Initialize vPMU */
> +	vcpu_ioctl(vpmu_vm.vcpu, KVM_SET_DEVICE_ATTR, &irq_attr);
> +	vcpu_ioctl(vpmu_vm.vcpu, KVM_SET_DEVICE_ATTR, &init_attr);
> +}

This one fails to build for me:
aarch64/vpmu_counter_access.c: In function ¡create_vpmu_vm¢:
aarch64/vpmu_counter_access.c:456:47: error: ¡ID_AA64DFR0_PMUVER_MASK¢ undeclared (first use in this function); did you mean ¡ID_AA64DFR0_EL1_PMUVer_MASK¢?
   456 |         pmuver = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_PMUVER), dfr0);

Regards,
Sebastian
---1463795790-917814220-1697109880=:6347--

