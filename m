Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D117F0827
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 18:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjKSRiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 12:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjKSRiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 12:38:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4170EF2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700415491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UfEOa4dx8jbARfZI7SJUwpd5ijXfpmv9Ry2k8rEDX50=;
        b=Ev4ShtAVvqPFfziw2gV208mhc0ncM8rmcGKTJqxBvOVkVwwvEIYuaTxKKFWDUAoQBdEghu
        Ouck92goEYrrrU51SaBxvkT11rl3jXh8F30v+IXfMXOniOVhGbzxr7wELngHozvO8NjqPD
        IFbcnw5F2LRfuMC2pmTaf2FWcwdkILs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-7OK70x7MMGKr5qMNz7AcVw-1; Sun, 19 Nov 2023 12:38:10 -0500
X-MC-Unique: 7OK70x7MMGKr5qMNz7AcVw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5082705f6dfso3321390e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700415488; x=1701020288;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UfEOa4dx8jbARfZI7SJUwpd5ijXfpmv9Ry2k8rEDX50=;
        b=gnSSoLWm9W3nGiDfgBoSB94VhtGkvRjQNgUPE/t53Fp9wHNXQH5Di0lQGLBnLZaIWR
         E9I58f8KPFqtDN2FpAZsxjuIM61ILldiu0j4LOTRYIMtkJU/Bk+x8f4Rxjbr0RMDmyhq
         w1KklQ98W01jVq2JBRhdmTf9FhTMFaemaSHBqjCVdB11ujiCzeYL1eIFR59O1mBqr3RS
         g6NgLcvuzFvWzmwEzy+Ku6ylwLJnz9ZuM6zzc6X7kqpnXiZt66zmVuQLuHYWMwziHadL
         Tr/NUFyGj084hM1qZGW/lDJ5XKAxZyKE+k2gwFEa4vwF0SO5mk2D+lHFCi3OG0ceSZsF
         lKdw==
X-Gm-Message-State: AOJu0YyTxMOPjQDxjUmbQL2U3rtVYOvvkRsXX7XOTjuzohGJDxRHOQ2o
        pIusWrOrhKZ2qVemN5O/dX5qIEOGs4Ab1BuzRArsNLJQs/v/EJSfuum0ozjqA4rZP2bj9QYrHER
        stPIR9shB8cIFtCorNvZzCwxnf5+wE1iN
X-Received: by 2002:a19:f80c:0:b0:509:1207:5e9a with SMTP id a12-20020a19f80c000000b0050912075e9amr3951853lff.42.1700415488281;
        Sun, 19 Nov 2023 09:38:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExMBjE8+a7PVy5wXI/+thGPI75u5SYcZ3rTZpq032gUJPIYrccoKOVRfTufwtu6HC4wgWZFw==
X-Received: by 2002:a19:f80c:0:b0:509:1207:5e9a with SMTP id a12-20020a19f80c000000b0050912075e9amr3951842lff.42.1700415487986;
        Sun, 19 Nov 2023 09:38:07 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id d19-20020adf9b93000000b003316eb9db40sm6231643wrc.51.2023.11.19.09.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 09:38:07 -0800 (PST)
Message-ID: <c964b29b08854b2779a75584cf2c3bb1e5ccb26a.camel@redhat.com>
Subject: Re: [PATCH] KVM: selftests: Fix MWAIT error message when guest
 assertion fails
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 19 Nov 2023 19:38:06 +0200
In-Reply-To: <20231107182159.404770-1-seanjc@google.com>
References: <20231107182159.404770-1-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-07 at 10:21 -0800, Sean Christopherson wrote:
> Print out the test and vector as intended when a guest assert fails an
> assertion regarding MONITOR/MWAIT faulting.  Unfortunately, the guest
> printf support doesn't detect such issues at compile-time, so the bug
> manifests as a confusing error message, e.g. in the most confusing case,
> the test complains that it got vector "0" instead of expected vector "0".
> 
> Fixes: 0f52e4aaa614 ("KVM: selftests: Convert the MONITOR/MWAIT test to use printf guest asserts")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c b/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
> index 80aa3d8b18f8..853802641e1e 100644
> --- a/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
> @@ -27,10 +27,12 @@ do {									\
>  									\
>  	if (fault_wanted)						\
>  		__GUEST_ASSERT((vector) == UD_VECTOR,			\
> -			       "Expected #UD on " insn " for testcase '0x%x', got '0x%x'", vector); \
> +			       "Expected #UD on " insn " for testcase '0x%x', got '0x%x'", \
> +			       testcase, vector);			\
>  	else								\
>  		__GUEST_ASSERT(!(vector),				\
> -			       "Expected success on " insn " for testcase '0x%x', got '0x%x'", vector); \
> +			       "Expected success on " insn " for testcase '0x%x', got '0x%x'", \
> +			       testcase, vector);			\
>  } while (0)
>  
>  static void guest_monitor_wait(int testcase)
> 
> base-commit: 45b890f7689eb0aba454fc5831d2d79763781677

I think that these days the gcc (and llvm likely) support printf annotations,
and usually complain, we should look at adding these to have a warning in such cases.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



