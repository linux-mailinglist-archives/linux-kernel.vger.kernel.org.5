Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EEE7AE7FE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjIZI33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjIZI31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445C1B4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695716920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BDGMuzc+Ph0H26Zmokb7by0M5wtPKpu7VqpmaaH1U6E=;
        b=dRvO65Hm6NKk94mtdPiI1Kh+ay2Ka4Ck8+kTQVY/NRSh45dHRJ5DhGAjsfMF7TfexnPMlA
        b1j2H7ttYF+z/hkjnp5dYR0bKEw83cYOT8H3CjUACDqc7WsrhjbuE3ft3cJ77hri+v49go
        3K33nju/zDbylHxjG7wKymaj4qf1zv4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-kH42RRsBNdWN6GRUj7Y6RA-1; Tue, 26 Sep 2023 04:28:38 -0400
X-MC-Unique: kH42RRsBNdWN6GRUj7Y6RA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-532eb7faea1so6476195a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695716917; x=1696321717;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BDGMuzc+Ph0H26Zmokb7by0M5wtPKpu7VqpmaaH1U6E=;
        b=d1G28Y7iaheA3OvEXUDVdWCoe5jd4p5VQuUH9fpmolO3SgdqiUsyzrA2xtLBmURm3E
         AHMRJiiZNpIwXRv72tcyew5Z2E28InKnD059/Xho0fDKTt5Hmy9WDD2tHfzUQKcoA8Gk
         +rBUjOsbnfV/JXkRXMjYUfgBF18/0IDON/AN9YGblxOtN84rOe3LBtwkrQ6+MCWiKe06
         ay1NrGJwQtPWWCoDwBTdXoDkXVWofzitk17NOSEoWD8Zq/VUrAZG+gT8XoICInHAom5/
         yQl6G01PellTMQP7j9VDLjBIaL7TRAGndzk9Ip3/5KpT9hLUXXmQmHjeHMfHZ3Vmq8Mt
         QSyA==
X-Gm-Message-State: AOJu0YxOH/u+QIVkgMt/HsfY3hcjHzldvg6+zwfb1+TVX+nDoPStn+12
        IDJ/rA4MhR5+fGTTWwaP+L1P5iaokmt7rnG8dqeN3plk5JiQcnYzy2EJY2+h+CrF5ebwpPyFuXG
        EEh3/69IrqATFBzCEEINAjClj
X-Received: by 2002:aa7:df0a:0:b0:530:df47:f172 with SMTP id c10-20020aa7df0a000000b00530df47f172mr7552037edy.15.1695716917860;
        Tue, 26 Sep 2023 01:28:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTLIYbLX149Gs3q2BIYdKDFI+frkReM0C/HZ5AV891vDyAWTc1p0/UObw+C4sShPj7YUXCAQ==
X-Received: by 2002:aa7:df0a:0:b0:530:df47:f172 with SMTP id c10-20020aa7df0a000000b00530df47f172mr7552030edy.15.1695716917532;
        Tue, 26 Sep 2023 01:28:37 -0700 (PDT)
Received: from starship ([89.237.96.178])
        by smtp.gmail.com with ESMTPSA id l21-20020a056402125500b0053315f0d510sm6549327edw.76.2023.09.26.01.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 01:28:37 -0700 (PDT)
Message-ID: <abd13162f106c5ce86c211fc9d32d901ab34500b.camel@redhat.com>
Subject: Re: [PATCH v2 0/4] KVM: x86: tracepoint updates
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Date:   Tue, 26 Sep 2023 11:28:35 +0300
In-Reply-To: <ZRIf1OPjKV66Y17/@google.com>
References: <20230924124410.897646-1-mlevitsk@redhat.com>
         <ZRIf1OPjKV66Y17/@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

У пн, 2023-09-25 у 17:03 -0700, Sean Christopherson пише:
> On Sun, Sep 24, 2023, Maxim Levitsky wrote:
> > This patch series is intended to add some selected information
> > to the kvm tracepoints to make it easier to gather insights about
> > running nested guests.
> > 
> > This patch series was developed together with a new x86 performance analysis tool
> > that I developed recently (https://gitlab.com/maximlevitsky/kvmon)
> > which aims to be a better kvm_stat, and allows you at glance
> > to see what is happening in a VM, including nesting.
> 
> Rather than add more and more tracepoints, I think we should be more thoughtful
> about (a) where we place KVM's tracepoints and (b) giving userspace the necessary
> hooks to write BPF programs to extract whatever data is needed at any give time.
> 
> There's simply no way we can iterate fast enough in KVM tracepoints to adapt to
> userspace's debug/monitoring needs.  E.g. if it turns out someone wants detailed
> info on hypercalls that use memory or registers beyond ABCD, the new tracepoints
> won't help them.
> 
> If all KVM tracepoints grab "struct kvm_vcpu" and force VMCS "registers" to be
> cached (or decached depending on one's viewpoint), then I think that'll serve 99%
> of usecases.  E.g. the vCPU gives a BPF program kvm_vcpu, vcpu_{vmx,svm}, kvm, etc.
> 
> trace_kvm_exit is good example, where despite all of the information that is captured
> by KVM, it's borderline worthless for CPUID and MSR exits because their interesting
> information is held in registers and not captured in the VMCS or VMCB.
> 
> There are some on BTF type info issues that I've encountered, but I suspect that's
> as much a PEBKAC problem as anything.
> 

While eBPF has its use cases, none of the extra tracepoints were added solely because of
the monitoring tool and I do understand that tracepoints are a limited resource.

Each added tracepoint/info was added only when it was also found to be useful for regular
kvm tracing.

Best regards,
	Maxim Levitsky

