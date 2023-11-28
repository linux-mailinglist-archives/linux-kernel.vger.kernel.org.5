Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B6E7FB2C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343729AbjK1Ha5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjK1Hay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:30:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2BA1AE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701156658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QJw7klMuwiJlKB6SVmymnlH6vaoxDAKmhu1Kr42WXFE=;
        b=jI/IoI2iepXACcMUeBeO97Jg3JKQ+73ba6T4BzaL45L0AA3/NTpgn/x5C3ho6SFeFEsRPs
        k4y/hdAD1h9p0i0Yb4480UDl9Fzr5TENAkRepRkkovjV3PtKzsc4t1FnbXNpb/mtLu7Uwi
        AiDzRSOq4d+WcfUtJlcV9hymsujf74A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-zTJEV6zGPOCYxDUh6afdBA-1; Tue, 28 Nov 2023 02:30:57 -0500
X-MC-Unique: zTJEV6zGPOCYxDUh6afdBA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-333120f8976so20406f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156656; x=1701761456;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QJw7klMuwiJlKB6SVmymnlH6vaoxDAKmhu1Kr42WXFE=;
        b=cFO1T8OtxvBvOOOVd1utToMsMZyd0CrRGhJxT8jPkQb4NopmdzYp2Sh3F7wWK6hgz0
         SZB32HdPW07tzyP51XBw1g0jWK9arEGHS+7n8/wS0n5L2jc8keDjo6WIGkbqbXX7ZxJT
         jJL3TKkxIPlg24tuG+qYEAXfFspd0iqhWUc6RJQanrTkL6eaDD1BEoqCsPHvr3rIqch9
         KboBFmpqAQJx0EPPO+QWEi+1oNUz+pMPNcmt0ZPD/3qXF5YcAovy+T/w+NH6+uPaVQ7s
         iW0O1AGKbT3Pu1DaYWSsDzCOxU+ILtwP6eGh+bbkoIBjClf5BiOb0wRMKqHsOjQzeEB7
         WJYg==
X-Gm-Message-State: AOJu0Yxg2FVOggX03pCMUEPj/XOZ/7jVGZAiLsZ/xHaHaSKsK3Zlpxbh
        Je1yFRUYIht08HZ/+quA3e1yxLP8MfX+1QV7dgouhloxE0tST8kAQgD062/2MU+xr3BAUgJ/nPM
        a48NbbyWk96TreGYEXAUPwC3l
X-Received: by 2002:adf:a348:0:b0:32f:7a1a:6b21 with SMTP id d8-20020adfa348000000b0032f7a1a6b21mr11000207wrb.50.1701156655944;
        Mon, 27 Nov 2023 23:30:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHa/sbmHoE/nFo4mc0n2d5RiJbrsqpbqyRnjeQE775RHciBXztaU2w+eG0rGex2i3mWrn1uWA==
X-Received: by 2002:adf:a348:0:b0:32f:7a1a:6b21 with SMTP id d8-20020adfa348000000b0032f7a1a6b21mr11000186wrb.50.1701156655574;
        Mon, 27 Nov 2023 23:30:55 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b00405c7591b09sm16480293wmp.35.2023.11.27.23.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:30:55 -0800 (PST)
Message-ID: <433aa3b530bcf92b4b843153d6e3919cdb623308.camel@redhat.com>
Subject: Re: [RFC 13/33] KVM: Allow polling vCPUs for events
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk,
        jgowans@amazon.com, corbert@lwn.net, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, x86@kernel.org,
        linux-doc@vger.kernel.org
Date:   Tue, 28 Nov 2023 09:30:53 +0200
In-Reply-To: <20231108111806.92604-14-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
         <20231108111806.92604-14-nsaenz@amazon.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-08 at 11:17 +0000, Nicolas Saenz Julienne wrote:
> A number of use cases have surfaced where it'd be beneficial to have a
> vCPU stop its execution in user-space, as opposed to having it sleep
> in-kernel. Be it in order to make better use of the pCPU's time while
> the vCPU is halted, or to implement security features like Hyper-V's
> VSM.


> 
> A problem with this approach is that user-space has no way of knowing
> whether the vCPU has pending events (interrupts, timers, etc...), so we
> need a new interface to query if they are. poll() turned out to be a
> very good fit.
> 
> So enable polling vCPUs. The poll() interface considers a vCPU has a
> pending event if it didn't enter the guest since being kicked by an
> event source (being kicked forces a guest exit). Kicking a vCPU that has
> pollers wakes up the polling threads.
> 
> NOTES:
>  - There is a race between the 'vcpu->kicked' check in the polling
>    thread and the vCPU thread re-entering the guest. This hardly affects
>    the use-cases stated above, but needs to be fixed.
> 
>  - This was tested alongside a WIP Hyper-V Virtual Trust Level
>    implementation which makes ample use of the poll() interface.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---
>  arch/x86/kvm/x86.c       |  2 ++
>  include/linux/kvm_host.h |  2 ++
>  virt/kvm/kvm_main.c      | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 57f9c58e1e32..bf4891bc044e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10788,6 +10788,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  		goto cancel_injection;
>  	}
>  
> +	WRITE_ONCE(vcpu->kicked, false);
> +
>  	if (req_immediate_exit) {
>  		kvm_make_request(KVM_REQ_EVENT, vcpu);
>  		static_call(kvm_x86_request_immediate_exit)(vcpu);
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 687589ce9f63..71e1e8cf8936 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -336,6 +336,7 @@ struct kvm_vcpu {
>  #endif
>  	int mode;
>  	u64 requests;
> +	bool kicked;
>  	unsigned long guest_debug;
>  
>  	struct mutex mutex;
> @@ -395,6 +396,7 @@ struct kvm_vcpu {
>  	 */
>  	struct kvm_memory_slot *last_used_slot;
>  	u64 last_used_slot_gen;
> +	wait_queue_head_t wqh;
>  };
>  
>  /*
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index ad9aab898a0c..fde004a0ac46 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -497,12 +497,14 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
>  	kvm_vcpu_set_dy_eligible(vcpu, false);
>  	vcpu->preempted = false;
>  	vcpu->ready = false;
> +	vcpu->kicked = false;
>  	preempt_notifier_init(&vcpu->preempt_notifier, &kvm_preempt_ops);
>  	vcpu->last_used_slot = NULL;
>  
>  	/* Fill the stats id string for the vcpu */
>  	snprintf(vcpu->stats_id, sizeof(vcpu->stats_id), "kvm-%d/vcpu-%d",
>  		 task_pid_nr(current), id);
> +	init_waitqueue_head(&vcpu->wqh);
>  }
>  
>  static void kvm_vcpu_destroy(struct kvm_vcpu *vcpu)
> @@ -3970,6 +3972,10 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
>  		if (cpu != me && (unsigned)cpu < nr_cpu_ids && cpu_online(cpu))
>  			smp_send_reschedule(cpu);
>  	}
> +
> +	if (!cmpxchg(&vcpu->kicked, false, true))
> +		wake_up_interruptible(&vcpu->wqh);
> +
>  out:
>  	put_cpu();
>  }
> @@ -4174,6 +4180,29 @@ static int kvm_vcpu_mmap(struct file *file, struct vm_area_struct *vma)
>  	return 0;
>  }
>  
> +static __poll_t kvm_vcpu_poll(struct file *file, poll_table *wait)
> +{
> +	struct kvm_vcpu *vcpu = file->private_data;
> +
> +	poll_wait(file, &vcpu->wqh, wait);
> +
> +	/*
> +	 * Make sure we read vcpu->kicked after adding the vcpu into
> +	 * the waitqueue list. Otherwise we might have the following race:
> +	 *
> +	 *   READ_ONCE(vcpu->kicked)
> +	 *					cmpxchg(&vcpu->kicked, false, true))
> +	 *					wake_up_interruptible(&vcpu->wqh)
> +	 *   list_add_tail(wait, &vcpu->wqh)
> +	 */
> +	smp_mb();
> +	if (READ_ONCE(vcpu->kicked)) {
> +		return EPOLLIN;
> +	}
> +
> +	return 0;
> +}
> +
>  static int kvm_vcpu_release(struct inode *inode, struct file *filp)
>  {
>  	struct kvm_vcpu *vcpu = filp->private_data;
> @@ -4186,6 +4215,7 @@ static const struct file_operations kvm_vcpu_fops = {
>  	.release        = kvm_vcpu_release,
>  	.unlocked_ioctl = kvm_vcpu_ioctl,
>  	.mmap           = kvm_vcpu_mmap,
> +	.poll		= kvm_vcpu_poll,
>  	.llseek		= noop_llseek,
>  	KVM_COMPAT(kvm_vcpu_compat_ioctl),
>  };



A few ideas on the design:

I think that we can do this in a simpler way.


I am thinking about the following API:

-> vCPU does vtlcall and KVM exits to the userspace.

-> The userspace sets the vCPU to the new MP runstate (KVM_MP_STATE_HALTED_USERSPACE) which is just like regular halt
but once vCPU is ready to run, the KVM instead exits to userspace.


-> The userspace does another KVM_RUN which blocks till an event comes and exits back to userspace.

-> The userspace can now decide what to do, and it might for example send signal to vCPU thread which runs VTL0,
to kick it out of the guest mode, and resume the VTL1 vCPU.


Best regards,
	Maxim Levitsky 






