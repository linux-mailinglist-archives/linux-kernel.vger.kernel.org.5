Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831707E95D7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 05:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjKMEEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 23:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjKMEEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 23:04:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06361BE6;
        Sun, 12 Nov 2023 20:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699848289; x=1731384289;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WOwoSlqLfWWESwTKcsZG0UieWIfgaFt66vVqv43uELo=;
  b=I+L+fr5RVhC5fGM42/qTIVDM1RZ5Xh4f2ouehtCnCtcjM11uFFzn4n8V
   48KvC3JLuZEyFQtXZxYe5W9Wy2wNJSJW57R3Fv0l//mtsT+hfS5FGsAzc
   RrmnWTIPA4NG9tEBi0qD7KT78thgnpbtVNNwKdtuV9KXaGlDPrekpIYl4
   yv1WJ+jN5RuFviOp5hNx2M95noY0nOqzSK9eQKFGcUparCJm5umiwEvWv
   exkXIOaHK1JUtryU8luaHSsirdoIWT5mDyOpPyskdzTDSHIC8Tpm1ufMX
   uUPshAB9CG1FgReFyDNBZz6m2RHREfIEUqDj02TILwyyZzUzsaj1vi2pZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="394273098"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="394273098"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 20:04:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="740655679"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="740655679"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77]) ([10.93.6.77])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 20:04:43 -0800
Message-ID: <22c602c9-4943-4a16-a12e-ffc5db29daa1@intel.com>
Date:   Mon, 13 Nov 2023 12:04:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] KVM: selftests: Add logic to detect if ioctl()
 failed because VM was killed
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>,
        Oliver Upton <oliver.upton@linux.dev>,
        Colton Lewis <coltonlewis@google.com>
References: <20231108010953.560824-1-seanjc@google.com>
 <20231108010953.560824-3-seanjc@google.com>
 <0ee32216-e285-406f-b20d-dd193b791d2b@intel.com>
 <ZUuyVfdKZG44T1ba@google.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZUuyVfdKZG44T1ba@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/2023 12:07 AM, Sean Christopherson wrote:
> On Wed, Nov 08, 2023, Xiaoyao Li wrote:
>> On 11/8/2023 9:09 AM, Sean Christopherson wrote:
>>> Add yet another macro to the VM/vCPU ioctl() framework to detect when an
>>> ioctl() failed because KVM killed/bugged the VM, i.e. when there was
>>> nothing wrong with the ioctl() itself.  If KVM kills a VM, e.g. by way of
>>> a failed KVM_BUG_ON(), all subsequent VM and vCPU ioctl()s will fail with
>>> -EIO, which can be quite misleading and ultimately waste user/developer
>>> time.
>>>
>>> Use KVM_CHECK_EXTENSION on KVM_CAP_USER_MEMORY to detect if the VM is
>>> dead and/or bug, as KVM doesn't provide a dedicated ioctl().  Using a
>>> heuristic is obviously less than ideal, but practically speaking the logic
>>> is bulletproof barring a KVM change, and any such change would arguably
>>> break userspace, e.g. if KVM returns something other than -EIO.
>>
>> We hit similar issue when testing TDX VMs. Most failure of SEMCALL is
>> handled with a KVM_BUG_ON(), which leads to vm dead. Then the following
>> IOCTL from userspace (QEMU) and gets -EIO.
>>
>> Can we return a new KVM_EXIT_VM_DEAD on KVM_REQ_VM_DEAD?
> 
> Why?  Even if KVM_EXIT_VM_DEAD somehow provided enough information to be useful
> from an automation perspective, the VM is obviously dead.  I don't see how the
> VMM can do anything but log the error and tear down the VM.  KVM_BUG_ON() comes
> with a WARN, which will be far more helpful for a human debugger, e.g. because
> all vCPUs would exit with KVM_EXIT_VM_DEAD, it wouldn't even identify which vCPU
> initially triggered the issue.

It's not about providing more helpful debugging info, but to provide a 
dedicated notification for VMM that "the VM is dead, all the following 
command may not response". With it, VMM can get rid of the tricky 
detection like this patch.

> Using an exit reason is a also bit tricky because it requires a vCPU, whereas a
> dead VM blocks anything and everything.

No argue of it. It cannot work for all the case, but at least it can 
make some case happier.

>> and replace -EIO with 0? yes, it's a ABI change.
> 
> Definitely a "no" on this one.  As has been established by the guest_memfd series,
> it's ok to return -1/errno with a valid exit_reason.
> 
>> But I'm wondering if any userspace relies on -EIO behavior for VM DEAD case.
> 
> I doubt userspace relies on -EIO, but userpsace definitely relies on -1/errno being
> returned when a fatal error.

what about KVM_EXIT_SHUTDOWN? Or KVM_EXIT_INTERNAL_ERROR?


