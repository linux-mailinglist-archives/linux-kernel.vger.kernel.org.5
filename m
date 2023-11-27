Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EE87FAB29
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjK0URk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjK0URh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:17:37 -0500
Received: from gentwo.org (gentwo.org [62.72.0.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEFBD4B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:17:44 -0800 (PST)
Received: by gentwo.org (Postfix, from userid 1003)
        id B7CFE41AEE; Mon, 27 Nov 2023 12:17:43 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id B6CC641AED;
        Mon, 27 Nov 2023 12:17:43 -0800 (PST)
Date:   Mon, 27 Nov 2023 12:17:43 -0800 (PST)
From:   "Christoph Lameter (Ampere)" <cl@linux.com>
To:     Mihai Carabas <mihai.carabas@oracle.com>
cc:     linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        pbonzini@redhat.com, wanpengli@tencent.com, vkuznets@redhat.com,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        akpm@linux-foundation.org, pmladek@suse.com, peterz@infradead.org,
        dianders@chromium.org, npiggin@gmail.com,
        rick.p.edgecombe@intel.com, joao.m.martins@oracle.com,
        juerg.haefliger@canonical.com, mic@digikod.net, arnd@arndb.de,
        ankur.a.arora@oracle.com
Subject: Re: [PATCH 7/7] cpuidle/poll_state: replace cpu_relax with
 smp_cond_load_relaxed
In-Reply-To: <724589ce-7656-4be0-aa37-f6edeb92e1c4@oracle.com>
Message-ID: <277fbd0d-25ea-437e-2ea7-6121c4e269db@linux.com>
References: <1700488898-12431-1-git-send-email-mihai.carabas@oracle.com> <1700488898-12431-8-git-send-email-mihai.carabas@oracle.com> <6bd5fd43-552d-b020-1338-d89279f7a517@linux.com> <724589ce-7656-4be0-aa37-f6edeb92e1c4@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1152771662-1701116263=:544079"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1152771662-1701116263=:544079
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 22 Nov 2023, Mihai Carabas wrote:

> La 22.11.2023 22:51, Christoph Lameter a scris:
>> 
>> On Mon, 20 Nov 2023, Mihai Carabas wrote:
>> 
>>> cpu_relax on ARM64 does a simple "yield". Thus we replace it with
>>> smp_cond_load_relaxed which basically does a "wfe".
>> 
>> Well it clears events first (which requires the first WFE) and then does a 
>> WFE waiting for any events if no events were pending.
>> 
>> WFE does not cause a VMEXIT? Or does the inner loop of 
>> smp_cond_load_relaxed now do 2x VMEXITS?
>> 
>> KVM ARM64 code seems to indicate that WFE causes a VMEXIT. See 
>> kvm_handle_wfx().
>
> In KVM ARM64 the WFE traping is dynamic: it is enabled only if there are more 
> tasks waiting on the same core (e.g. on an oversubscribed system).
>
> In arch/arm64/kvm/arm.c:
>
>  457 >-------if (single_task_running())
>  458 >------->-------vcpu_clear_wfx_traps(vcpu);
>  459 >-------else
>  460 >------->-------vcpu_set_wfx_traps(vcpu);

Ahh. Cool did not know about that. But still: Lots of VMEXITs once the 
load has to be shared.

> This of course can be improved by having a knob where you can completly 
> disable wfx traping by your needs, but I left this as another subject to 
> tackle.

kvm_arch_vcpu_load() looks strange. On the one hand we pass a cpu 
number into it and then we use functions that only work if we are running 
on that cpu?

It would be better to use smp_processor_id() in the function 
and not pass the cpu number to it.
--8323329-1152771662-1701116263=:544079--
