Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF9E77063E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjHDQqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjHDQqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:46:33 -0400
Received: from out-110.mta0.migadu.com (out-110.mta0.migadu.com [IPv6:2001:41d0:1004:224b::6e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D714C0B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:46:28 -0700 (PDT)
Date:   Fri, 4 Aug 2023 16:46:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691167586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qaR2G5Chx/VcUIaTYRuVF0uwhqVmW9NgGj+Bf+hZY7o=;
        b=r+7WDHTAnuE6UxfVFf9fmVXWZrmioqVjtqh2KCn/L35YcmjQRsSJVd/v1z+Ks6eJx8J4jA
        LS+cxW2YC2JZ/gzgc8G8izhmj/IUaH3i22/t7+ES3S7mAYiT5/wal8BUgHjTB9cBHWagSe
        11Un/V39kIbT2E0Q/LNoUv+MPvnz+qU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH 2/4] KVM: selftests: Add helper macros for ioctl()s that
 return file descriptors
Message-ID: <ZM0rXgKvb912k5BE@linux.dev>
References: <20230804004226.1984505-1-seanjc@google.com>
 <20230804004226.1984505-3-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804004226.1984505-3-seanjc@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On Thu, Aug 03, 2023 at 05:42:24PM -0700, Sean Christopherson wrote:
> Add KVM, VM, and vCPU scoped helpers for ioctl()s that return file
> descriptors, i.e. deduplicate code for asserting success on ioctls() for
> which a positive return value, not just zero, is considered success.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

I appreciate the desire to eliminate duplicate code, but I think the
naming just muddies the waters. TBH, when I first read the diff w/o the
changelog, I thought you were describing the input fd (i.e. 'kvm_fd',
'vm_fd', 'vcpu_fd'). I don't think explicitly spelling out the condition
each time (i.e. ret >= 0) is all that difficult.

[...]

>  /*
>   * Looks up and returns the value corresponding to the capability
>   * (KVM_CAP_*) given by cap.
>   */
>  static inline int vm_check_cap(struct kvm_vm *vm, long cap)
>  {
> -	int ret =  __vm_ioctl(vm, KVM_CHECK_EXTENSION, (void *)cap);
> -
> -	TEST_ASSERT(ret >= 0, KVM_IOCTL_ERROR(KVM_CHECK_EXTENSION, ret));
> -	return ret;
> +	return vm_fd_ioctl(vm, KVM_CHECK_EXTENSION, (void *)cap);
>  }

Though the same error condition, this isn't returning an fd.

-- 
Thanks,
Oliver
