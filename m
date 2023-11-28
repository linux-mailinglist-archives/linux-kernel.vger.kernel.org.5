Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135737FB215
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343663AbjK1Gml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjK1Gmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:42:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8DE198
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701153765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UiaQdwESEYDh0OWSlkZl1xuzNRF7zyPvHRw34kcgm7E=;
        b=Sv1be2vaCJKWqIbkKiyzb/mLTEhoL0Cib05aD0Q7IBuE321zL21q3gn9l51rlGzWwaU5NA
        dqh7hEvZJv6Xmg/yEJF3CaPByoDbyFYvbjrwHzEFPaJSIPwS2CNnNdkGfsf66aqxYO2y7i
        FRH3bWqRTrj8smmDIGmk3OUUBfY2iRk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-uzJ8UQQmMwqjgbGIy3u2cg-1; Tue, 28 Nov 2023 01:42:43 -0500
X-MC-Unique: uzJ8UQQmMwqjgbGIy3u2cg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-332f5ac9f49so2051650f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:42:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701153762; x=1701758562;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UiaQdwESEYDh0OWSlkZl1xuzNRF7zyPvHRw34kcgm7E=;
        b=KOkiZAStkLU9yXISQ9IYgonO/fSoSqhm+zAwPYkBCnSiYzTK9UxYXSe8ooWQgbbN4D
         mJs3nMfmlcaJo+aCa72UpfZNvs7NKQCVtQD4hH2HrU3DUZKybtHbXlDz2SxkQnW8ndLL
         XbIMnIiI1JcsquMjyP2E0zP7TEA0/7w4stRXhI82TPvVKYJdKhGRRW25+e7lpEX9oIov
         3Vb0u+naCOLaKPvlFaGqKcDjY+uYNiSCUbsyYeUizsptTK6h58tmjvqxv5qnHgbSoGKc
         LtJWcHlhZnF82WU+MbelZuS2sBxP+U8ifE9hLookSPVF2Bt7qRuP0yyQL2VSmUNljqwH
         LwJg==
X-Gm-Message-State: AOJu0YygES+D+VwzNulK/WnkpBd+s6mMyyinc7+blzCstO7lPwYNYGcY
        fl6wPVscKHb0/WUshVINZDTNu33CqvUeHLG/r2Ed4EZ5hIdh6vpQF19MbESs2O/6iGdUZlyrVyR
        6lVcnVioF2QGveIUnsFN2IZOh
X-Received: by 2002:adf:da4a:0:b0:333:149:68f1 with SMTP id r10-20020adfda4a000000b00333014968f1mr2844116wrl.70.1701153762662;
        Mon, 27 Nov 2023 22:42:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzVPae2GApop6eWDvzDCz8sHV2p++din6DOfCUmKc7HNHTvntQTPElvh8JbWiI/6/j61K24A==
X-Received: by 2002:adf:da4a:0:b0:333:149:68f1 with SMTP id r10-20020adfda4a000000b00333014968f1mr2844101wrl.70.1701153762332;
        Mon, 27 Nov 2023 22:42:42 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id w27-20020adf8bdb000000b00332e5624a31sm13384035wra.84.2023.11.27.22.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 22:42:42 -0800 (PST)
Message-ID: <69607670cc11c05658870ae07d1af543a9446fe8.camel@redhat.com>
Subject: Re: [PATCH v3 4/4] KVM: x86: add new nested vmexit tracepoints
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 28 Nov 2023 08:42:40 +0200
In-Reply-To: <a10d3a01-939c-493c-b93c-b3821735e062@redhat.com>
References: <20230928103640.78453-1-mlevitsk@redhat.com>
         <20230928103640.78453-5-mlevitsk@redhat.com>
         <a10d3a01-939c-493c-b93c-b3821735e062@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-24 at 17:11 +0100, Paolo Bonzini wrote:
> On 9/28/23 12:36, Maxim Levitsky wrote:
> > Add 3 new tracepoints for nested VM exits which are intended
> > to capture extra information to gain insights about the nested guest
> > behavior.
> > 
> > The new tracepoints are:
> > 
> > - kvm_nested_msr
> > - kvm_nested_hypercall
> > 
> > These tracepoints capture extra register state to be able to know
> > which MSR or which hypercall was done.
> > 
> > - kvm_nested_page_fault
> > 
> > This tracepoint allows to capture extra info about which host pagefault
> > error code caused the nested page fault.
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> 
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> with just one question below that can be fixed when applying:
> 
> > @@ -1139,6 +1145,22 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
> >   				       vmcb12->control.exit_int_info_err,
> >   				       KVM_ISA_SVM);
> >   
> > +	/* Collect some info about nested VM exits */
> > +	switch (vmcb12->control.exit_code) {
> > +	case SVM_EXIT_MSR:
> > +		trace_kvm_nested_msr(vmcb12->control.exit_info_1 == 1,
> > +				     kvm_rcx_read(vcpu),
> > +				     (vmcb12->save.rax & -1u) |
> > +				     (((u64)(kvm_rdx_read(vcpu) & -1u) << 32)));
> 
> Why the second "& -1u"?  (And I also prefer 0xFFFFFFFFull

I think I copied it from somewhere but I can't seem to find where.
I agree with both remarks, will fix.

Thanks,
	Best regards,
		Maxim Levitsky
> 
> Paolo
> 


