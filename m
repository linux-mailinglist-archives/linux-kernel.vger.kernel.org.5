Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F52D77050C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjHDPmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjHDPm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:42:29 -0400
X-Greylist: delayed 2612 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Aug 2023 08:42:27 PDT
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [IPv6:2a0c:5a00:149::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42448171D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:42:27 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1qRwGI-003fwN-NK; Fri, 04 Aug 2023 16:58:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID;
        bh=yXVPj20MkIKPwoR/zOQt8w9eMyZJGpnP6T83Hf+rbY8=; b=LLFIgVsBgcuG3YL0Z1htIOypsR
        +UD/9XI/jNrfN6STOucZOIbGRGbH5d/xbu9X1B8hohxPNGqRMvU/er12t0L/sdsZw/py38SFlxxwi
        rCAJLjvOgBYud6khF11q6SYq8vUOGqDcpkdscEmcYNzBrZYMMprHoWOyEOyVk8bzeZYKxRkrM8xCf
        uvb03y4i4whFP7f4KWKQf1F2WF6tNJ4C83P9yHOiEs5zOasrsijA7iWaPcIzxWT41hOV+dRsvv+lj
        HrQOC3GmEHBAp+hB4PQQDIE2ljd23+hcHJf8o1p/GdU+Loujq6lJKEyhYxtgXXSh1BNLy7oKWbfLb
        BO5W5AtQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1qRwGH-0000FV-P9; Fri, 04 Aug 2023 16:58:42 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1qRwG3-0007eD-R3; Fri, 04 Aug 2023 16:58:27 +0200
Message-ID: <ae42db25-9c8c-3f27-9ccb-41644b135a8b@rbox.co>
Date:   Fri, 4 Aug 2023 16:58:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] KVM: selftests: Use asserting kvm_ioctl() macros when
 getting ARM page sizes
Content-Language: pl-PL, en-GB
To:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230804004226.1984505-1-seanjc@google.com>
 <20230804004226.1984505-4-seanjc@google.com>
From:   Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20230804004226.1984505-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/23 02:42, Sean Christopherson wrote:
> Use kvm_ioctl() instead of open coding equivalent ioctl()+TEST_ASSERT()
> calls when getting the support page sizes on ARM.  The macro usage is a
> little funky since the "kvm_fd" parameter implies an actual /dev/kvm fd,
> but on the other hand the code is invoking KVM ioctl()s.
> 
> Alternatively, the core utilities could expose a vm_open()+vm_close()
> pair so that the ARM code could create a dummy, on-stack VM+vCPU pair and
> use {vm,vcpu}_ioctl() as appropriate.  But the odds of something breaking
> due to oddball, partial usage of kvm_vm and kvm_vcpu structures is much
> higher than realizing meaningful benefit from using {vm,vcpu}_ioctl().

Since you're doing the cleanup, does mmio_warning_test qualify for the
same (funky usage ahead)?

-       kvm = open("/dev/kvm", O_RDWR);
-       TEST_ASSERT(kvm != -1, "failed to open /dev/kvm");
-       kvmvm = __kvm_ioctl(kvm, KVM_CREATE_VM, NULL);
-       TEST_ASSERT(kvmvm > 0, KVM_IOCTL_ERROR(KVM_CREATE_VM, kvmvm));
-       kvmcpu = ioctl(kvmvm, KVM_CREATE_VCPU, 0);
-       TEST_ASSERT(kvmcpu != -1, KVM_IOCTL_ERROR(KVM_CREATE_VCPU, kvmcpu));
+       kvm = open_path_or_exit(KVM_DEV_PATH, O_RDWR);
+       kvmvm = kvm_fd_ioctl(kvm, KVM_CREATE_VM, NULL);
+       kvmcpu = kvm_fd_ioctl(kvmvm, KVM_CREATE_VCPU, NULL);

Side note, just in case this wasn't your intention: no kvm@ in cc.

thanks,
Michal

