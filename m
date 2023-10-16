Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C917CA4AE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjJPKCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPKCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:02:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098DCAC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697450524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Rvdf5GF7NssmVrOVN5fIpBg7Q/eJJlAGQ4ASt6ni/o=;
        b=e3Wq/Tvi7u5Vy23l+z1e4rkIqxunXrNPJz/oMpb7+h6Q+6HpKStmlavMYLCNqIzJWQk4ZQ
        aw7XYcndx7irUO/hCOWoHmEeQnTHeSmNWsVT3lveiOLy9jdLeUuzfJQ7U5t+U/gWbu2R1i
        OlkF0wpuiWPLLs5dsDkzJoX7mkqLjys=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-0i_Ig--pPxWy0j2y1lK-pA-1; Mon, 16 Oct 2023 06:01:53 -0400
X-MC-Unique: 0i_Ig--pPxWy0j2y1lK-pA-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-457d094c420so868403137.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697450512; x=1698055312;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Rvdf5GF7NssmVrOVN5fIpBg7Q/eJJlAGQ4ASt6ni/o=;
        b=jScUYjUQhs/ADNx3IW0CxcfEDy9jyxgzqs926Okd21bqyX+zSOCaEX1TeXrUck7+0p
         p/f1kzuYg6txlOaFYX5ZyrXboteYUfLORzaQcSelphx9gK6hGPuNysQLTwXL1f4D7GKo
         aVgOt6jemS7ZfkVP+eph9aFPqWPlfOyVXHm17mwJDtwdqHrp/t0y8gICDo3cbGO/J4De
         vrd8AYJ8HfnFt/4e0KFlwFB9g78fp487shoV2u9qAQ4/OPVZfkvhbAWe0ZY9aVfjvZyh
         npX/GYs8U3Yods5VUGomxiseE11o/OisLzojYYoxMFn/fJ6qiTd6i9WDq3z1Uy5LTmFj
         uTSg==
X-Gm-Message-State: AOJu0Yxw9Pc54sHy4IagOaE8I4kMD6Q+SukBZDGNl7oBFopRv4gbEKnU
        Ld+3t9mv+MA4PE/lJKApmmUmhJjk/cbcWSA5Cq7RLIiE2ZEyiRtUO/odOvK41K2FYkh+oWDHGqY
        5xLySut/H7dhn1ZEeqruAN7KE
X-Received: by 2002:a05:6102:1250:b0:458:16ac:bcad with SMTP id p16-20020a056102125000b0045816acbcadmr77260vsg.32.1697450512557;
        Mon, 16 Oct 2023 03:01:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6harqCGifXrM0+4AN5WIM0FRUrWBf8RWML7HaIo1VltVJ/nTSF6hWksPJbMyBcx5ZRlWB+Q==
X-Received: by 2002:a05:6102:1250:b0:458:16ac:bcad with SMTP id p16-20020a056102125000b0045816acbcadmr77235vsg.32.1697450512287;
        Mon, 16 Oct 2023 03:01:52 -0700 (PDT)
Received: from rh (p200300c93f0047001ec25c15da4a4a7b.dip0.t-ipconnect.de. [2003:c9:3f00:4700:1ec2:5c15:da4a:4a7b])
        by smtp.gmail.com with ESMTPSA id h4-20020ac87444000000b004179e79069asm2890615qtr.21.2023.10.16.03.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:01:52 -0700 (PDT)
Date:   Mon, 16 Oct 2023 12:01:48 +0200 (CEST)
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
In-Reply-To: <CAJHc60zPc6eM+t7pOM19aKbf_9cMvj_LnPnG1EO35=EP0jG+Tg@mail.gmail.com>
Message-ID: <2714abd6-40a4-17f8-e997-843bc69d9319@redhat.com>
References: <20231009230858.3444834-1-rananta@google.com> <20231009230858.3444834-11-rananta@google.com> <44608d30-c97a-c725-e8b2-0c5a81440869@redhat.com> <65b8bbdb-2187-3c85-0e5d-24befcf01333@redhat.com>
 <CAJHc60zPc6eM+t7pOM19aKbf_9cMvj_LnPnG1EO35=EP0jG+Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463795790-956281928-1697450511=:6267"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463795790-956281928-1697450511=:6267
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 13 Oct 2023, Raghavendra Rao Ananta wrote:
> On Thu, Oct 12, 2023 at 8:02 AM Sebastian Ott <sebott@redhat.com> wrote:
>>
>> On Thu, 12 Oct 2023, Sebastian Ott wrote:
>>> On Mon, 9 Oct 2023, Raghavendra Rao Ananta wrote:
>>>>  +/* Create a VM that has one vCPU with PMUv3 configured. */
>>>>  +static void create_vpmu_vm(void *guest_code)
>>>>  +{
>>>>  +   struct kvm_vcpu_init init;
>>>>  +   uint8_t pmuver, ec;
>>>>  +   uint64_t dfr0, irq = 23;
>>>>  +   struct kvm_device_attr irq_attr = {
>>>>  +           .group = KVM_ARM_VCPU_PMU_V3_CTRL,
>>>>  +           .attr = KVM_ARM_VCPU_PMU_V3_IRQ,
>>>>  +           .addr = (uint64_t)&irq,
>>>>  +   };
>>>>  +   struct kvm_device_attr init_attr = {
>>>>  +           .group = KVM_ARM_VCPU_PMU_V3_CTRL,
>>>>  +           .attr = KVM_ARM_VCPU_PMU_V3_INIT,
>>>>  +   };
>>>>  +
>>>>  +   /* The test creates the vpmu_vm multiple times. Ensure a clean state
>>>>  */
>>>>  +   memset(&vpmu_vm, 0, sizeof(vpmu_vm));
>>>>  +
>>>>  +   vpmu_vm.vm = vm_create(1);
>>>>  +   vm_init_descriptor_tables(vpmu_vm.vm);
>>>>  +   for (ec = 0; ec < ESR_EC_NUM; ec++) {
>>>>  +           vm_install_sync_handler(vpmu_vm.vm, VECTOR_SYNC_CURRENT, ec,
>>>>  +                                   guest_sync_handler);
>>>>  +   }
>>>>  +
>>>>  +   /* Create vCPU with PMUv3 */
>>>>  +   vm_ioctl(vpmu_vm.vm, KVM_ARM_PREFERRED_TARGET, &init);
>>>>  +   init.features[0] |= (1 << KVM_ARM_VCPU_PMU_V3);
>>>>  +   vpmu_vm.vcpu = aarch64_vcpu_add(vpmu_vm.vm, 0, &init, guest_code);
>>>>  +   vcpu_init_descriptor_tables(vpmu_vm.vcpu);
>>>>  +   vpmu_vm.gic_fd = vgic_v3_setup(vpmu_vm.vm, 1, 64,
>>>>  +                                   GICD_BASE_GPA, GICR_BASE_GPA);
>>>>  +
>>>>  +   /* Make sure that PMUv3 support is indicated in the ID register */
>>>>  +   vcpu_get_reg(vpmu_vm.vcpu,
>>>>  +                KVM_ARM64_SYS_REG(SYS_ID_AA64DFR0_EL1), &dfr0);
>>>>  +   pmuver = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_PMUVER), dfr0);
>>>>  +   TEST_ASSERT(pmuver != ID_AA64DFR0_PMUVER_IMP_DEF &&
>>>>  +               pmuver >= ID_AA64DFR0_PMUVER_8_0,
>>>>  +               "Unexpected PMUVER (0x%x) on the vCPU with PMUv3",
>>>>  pmuver);
>>>>  +
>>>>  +   /* Initialize vPMU */
>>>>  +   vcpu_ioctl(vpmu_vm.vcpu, KVM_SET_DEVICE_ATTR, &irq_attr);
>>>>  +   vcpu_ioctl(vpmu_vm.vcpu, KVM_SET_DEVICE_ATTR, &init_attr);
>>>>  +}
>>>
>>> This one fails to build for me:
>>> aarch64/vpmu_counter_access.c: In function ‘create_vpmu_vm’:
>>> aarch64/vpmu_counter_access.c:456:47: error: ‘ID_AA64DFR0_PMUVER_MASK’
>>> undeclared (first use in this function); did you mean
>>> ‘ID_AA64DFR0_EL1_PMUVer_MASK’?
>>>   456 |         pmuver = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_PMUVER),
>>>   dfr0);
>>
>> Looks like there's a clash with
>> "KVM: arm64: selftests: Import automatic generation of sysreg defs"
>> from:
>>         https://lore.kernel.org/r/20231003230408.3405722-12-oliver.upton@linux.dev
> Thanks for the pointer, Sebastian! Surprisingly, I don't see the patch
> when I sync to kvmarm/next.
>

Yea, sry - I've had both of these series applied locally.

Sebastian
---1463795790-956281928-1697450511=:6267--

