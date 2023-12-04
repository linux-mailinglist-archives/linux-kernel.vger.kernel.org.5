Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F000680395F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344413AbjLDQA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbjLDQAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:00:23 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3589711F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:00:28 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cfc4af9668so19595755ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701705628; x=1702310428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vu5tKdLWsp9uh1IlEpXyg0ZTTjJv3rNUrs1mjxuE+II=;
        b=B0IGHm62IWoUTyGNnCFcK4MHHOp0E1uaM48di7b3KqoP+rLKMb9+XMrbpVOpALLmuK
         4ryK02RmWaM6zB2mhpLE7vLCuQFjbiNVBV0z3xjwWJd4+MVP8PWenjIP5YJpIRteO6Kg
         IlE8Vi+ftUpsmyBxoVDYC5W6HhmitsnCo2+AB1TIiB5xh3cs/i/dPwL2pR8mu4Uw7iv2
         XTPrruOOGTotlrNTPfyYHJb1ACiwdjLQXiVLkidPUpdKflxBhUcz7rJ7DHYcH4KWwAF1
         2LNyn33cNYNO2QUdheKNL8iRVFRfLWJHDYJ1t0ow9pRuqPXczbaWMHz4C6sDTaJrOw31
         Dqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701705628; x=1702310428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vu5tKdLWsp9uh1IlEpXyg0ZTTjJv3rNUrs1mjxuE+II=;
        b=A4OaR1NwW1Fc5lMBudqbZMYAKRsFdTxUCfNjv2T055jWr/TEHKtOL+il27p7DW3tJK
         kmxjB2ZFgHCq3wZ0bELVsMRFRWse+M/lSF6sDO70F6DK9BwoNZXKqjbJLVtP+/nxkU1T
         y7mTKoJIiKwurc5XiGByb8WBjBEwo7DbhVM2ycpfP9jxW8ucAL3atjvM5G1wItYFym5g
         sMLrN4nhw72Bd0OEXZjvWqnqJjr4AOQzRZv4hJTNE8slUXSWbkTaRIdPlTtUYJxiIYtc
         FfYy19pgmAFQSW+qccNxsZ7pGUdcyTZgdCbmau12sk892P//1oOOBiIWzo84GYc2iArP
         vleg==
X-Gm-Message-State: AOJu0YwHaz/cHawNpmRKGld0fc2kvGmOOt+JyHaKljOnrd5SFZ6QJN1H
        YTKrBF2vrW1v+ZmrVbAUsV4qi4XDwyk=
X-Google-Smtp-Source: AGHT+IEq6m7bLLC6JEwzPGChct1XfwSRHBPSjG7LGs7N2YZblTkyK07gu6RLABzHeBmKxH54ytMP9y8SuQI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e88b:b0:1d0:83bc:5661 with SMTP id
 w11-20020a170902e88b00b001d083bc5661mr110010plg.5.1701705628175; Mon, 04 Dec
 2023 08:00:28 -0800 (PST)
Date:   Mon, 4 Dec 2023 08:00:26 -0800
In-Reply-To: <87h6kymgzi.fsf@redhat.com>
Mime-Version: 1.0
References: <20231203192422.539300-1-yury.norov@gmail.com> <20231203193307.542794-1-yury.norov@gmail.com>
 <20231203193307.542794-12-yury.norov@gmail.com> <87h6kymgzi.fsf@redhat.com>
Message-ID: <ZW33mlO7DIh2k5Gs@google.com>
Subject: Re: [PATCH v2 13/35] KVM: x86: hyper-v: optimize and cleanup kvm_hv_process_stimers()
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023, Vitaly Kuznetsov wrote:
> > -	for (i = 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++)
> > -		if (test_and_clear_bit(i, hv_vcpu->stimer_pending_bitmap)) {
> > -			stimer = &hv_vcpu->stimer[i];
> > -			if (stimer->config.enable) {
> > -				exp_time = stimer->exp_time;
> > -
> > -				if (exp_time) {
> > -					time_now =
> > -						get_time_ref_counter(vcpu->kvm);
> > -					if (time_now >= exp_time)
> > -						stimer_expiration(stimer);
> > -				}
> > -
> > -				if ((stimer->config.enable) &&
> > -				    stimer->count) {
> > -					if (!stimer->msg_pending)
> > -						stimer_start(stimer);
> > -				} else
> > -					stimer_cleanup(stimer);
> > -			}
> > +	for_each_test_and_clear_bit(i, hv_vcpu->stimer_pending_bitmap,
> > +					ARRAY_SIZE(hv_vcpu->stimer)) {

Another nit, please align the indendation:

	for_each_test_and_clear_bit(i, hv_vcpu->stimer_pending_bitmap,
				    ARRAY_SIZE(hv_vcpu->stimer)) {

> > +		stimer = &hv_vcpu->stimer[i];
> > +		if (!stimer->config.enable)
> > +			continue;
> > +
> > +		exp_time = stimer->exp_time;
> > +
> > +		if (exp_time) {
> > +			time_now = get_time_ref_counter(vcpu->kvm);
> > +			if (time_now >= exp_time)
> > +				stimer_expiration(stimer);
> >  		}
> > +
> > +		if (stimer->config.enable && stimer->count) {
> > +			if (!stimer->msg_pending)
> > +				stimer_start(stimer);
> > +		} else
> > +			stimer_cleanup(stimer);
> 
> Minor nitpick: it's better (and afair required by coding style) to use
> '{}' for both branches here:

Yeah, it's a hard requirement in KVM x86.

> 
> 	if (stimer->config.enable && stimer->count) {
> 		if (!stimer->msg_pending)
> 			stimer_start(stimer);
> 	} else {
> 		stimer_cleanup(stimer);
> 	}
> 
> > +	}
> >  }
> >  
> >  void kvm_hv_vcpu_uninit(struct kvm_vcpu *vcpu)
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> -- 
> Vitaly
> 
