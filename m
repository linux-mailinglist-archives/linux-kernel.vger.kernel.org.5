Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD6C7F15A0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjKTO0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjKTO0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:26:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FA9136
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700490373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WCml1wygp+3G4XDBK3ZMkKvMovt52E8+5uR4Ab+tFvk=;
        b=P+qsWth6BRkdZPqHuklivuOE6DY1aoq57EshC2ehlcXEJpIz/GopeUvfKZJXvQFQE3vQ2t
        I9AkQmzuWkKPljiPErLjxV9Z1yrmalBk689kj32cIchP5UiyvnQXMdlRnNf2sfANvfDhpA
        yIbZaRJumkx2ZcCCb3M/wmVNI++jYJQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-V4YGNT-oOAiMiZtaEprZmA-1; Mon, 20 Nov 2023 09:26:11 -0500
X-MC-Unique: V4YGNT-oOAiMiZtaEprZmA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-54816f3f424so2999010a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:26:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700490370; x=1701095170;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCml1wygp+3G4XDBK3ZMkKvMovt52E8+5uR4Ab+tFvk=;
        b=Vh6bZOjv5sXP5uwhdGEd/6f7efRpf6wmxHdRQcvvnhWw7ZsUWM1P1jKweKzK5zYKeP
         ZzPwjHy1VbYnsv9LLmi+Zm0Nct0L5Wqg+vS20Q2YSLe/U7/if0h5qQLDFWP3ue++ZvR/
         zlg3tPbDFuPMEQUs4R0qw136OBwdSZb6cqlpkwUBJA1md9kPYTv3pJkGI1fauRMEJCFo
         SU50CWbun6dSw1UKclc5XgCN8w3+tlu3eHGvhzN4sW+lee1/u61yv8cCFO4xXBQfmgOp
         barQnEorbEVfAt68FWXC6isr3UmtSF5nyNc6lHrI1mmFrJGikjPPKrdpPMJLEFcJTzbl
         VSIQ==
X-Gm-Message-State: AOJu0YwWKFpm4YA2ln8D2HoG1aTetzlroAIQWjRZS3KlwFTfEJ8vRgk6
        4HPElvj1HGrBIWldVirMZcMUkMeEs0yi1rg786gxzwsRLvuja2LliYY7tUFoDGLeagWo2Bv0kpI
        8AH5bTd+m4yngSe65uHE4fhws
X-Received: by 2002:a05:6402:40c4:b0:548:7ccc:6428 with SMTP id z4-20020a05640240c400b005487ccc6428mr6128847edb.11.1700490370403;
        Mon, 20 Nov 2023 06:26:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHMHHyfevTZBOGA7OAoxC98zM3OcTilr92FcoZ3cNuGbvLzmUH9ulWS5dMWytx0YgPl0WvMQ==
X-Received: by 2002:a05:6402:40c4:b0:548:7ccc:6428 with SMTP id z4-20020a05640240c400b005487ccc6428mr6128827edb.11.1700490370127;
        Mon, 20 Nov 2023 06:26:10 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id r5-20020a056402018500b0053dec545c8fsm3622562edv.3.2023.11.20.06.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 06:26:09 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 13/34] KVM: x86: hyper-v: optimize and cleanup
 kvm_hv_process_stimers()
In-Reply-To: <20231118155105.25678-14-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-14-yury.norov@gmail.com>
Date:   Mon, 20 Nov 2023 15:26:08 +0100
Message-ID: <877cmcqz5r.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Yury Norov <yury.norov@gmail.com> writes:

> The function traverses stimer_pending_bitmap n a for-loop bit by bit.
> We can do it faster by using atomic find_and_set_bit().
>
> While here, refactor the logic by decreasing indentation level
> and dropping 2nd check for stimer->config.enable.
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/x86/kvm/hyperv.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 238afd7335e4..460e300b558b 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -870,27 +870,26 @@ void kvm_hv_process_stimers(struct kvm_vcpu *vcpu)
>  	if (!hv_vcpu)
>  		return;
>  
> -	for (i = 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++)
> -		if (test_and_clear_bit(i, hv_vcpu->stimer_pending_bitmap)) {
> -			stimer = &hv_vcpu->stimer[i];
> -			if (stimer->config.enable) {
> -				exp_time = stimer->exp_time;
> -
> -				if (exp_time) {
> -					time_now =
> -						get_time_ref_counter(vcpu->kvm);
> -					if (time_now >= exp_time)
> -						stimer_expiration(stimer);
> -				}
> -
> -				if ((stimer->config.enable) &&
> -				    stimer->count) {
> -					if (!stimer->msg_pending)
> -						stimer_start(stimer);
> -				} else
> -					stimer_cleanup(stimer);
> -			}
> +	for_each_test_and_clear_bit(i, hv_vcpu->stimer_pending_bitmap,
> +					ARRAY_SIZE(hv_vcpu->stimer)) {
> +		stimer = &hv_vcpu->stimer[i];
> +		if (!stimer->config.enable)
> +			continue;
> +
> +		exp_time = stimer->exp_time;
> +
> +		if (exp_time) {
> +			time_now = get_time_ref_counter(vcpu->kvm);
> +			if (time_now >= exp_time)
> +				stimer_expiration(stimer);
>  		}
> +
> +		if (stimer->count) {

You can't drop 'stimer->config.enable' check here as stimer_expiration()
call above actually changes it. This is done on purpose: oneshot timers
fire only once so 'config.enable' is reset to 0.

> +			if (!stimer->msg_pending)
> +				stimer_start(stimer);
> +		} else
> +			stimer_cleanup(stimer);
> +	}
>  }
>  
>  void kvm_hv_vcpu_uninit(struct kvm_vcpu *vcpu)

-- 
Vitaly

