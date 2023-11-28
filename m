Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D177FB2AE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343718AbjK1H0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjK1H0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:26:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C2B1BB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701156415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aDhxfrZ6A0IBRHudGpkZAOoM1jn0urSkC0LwcNBapbI=;
        b=ViYkU0kQPWRym9rgySUPrmYgvewMwjphtyt8W2TlvLzoXg1GbxGJzQ+ZjQLjv7GaGM5Qgb
        vbCJsc7WGRBrEWdORICTz8qvizGDdkvne8CKW4siCOrizj81HzXhLZxRHjVNWE1aNsUCe8
        v4nRkZftUiYHy6cDA2wrBAleH5PzNmk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-It0yUrn1N0iFdlYtaaW3Vw-1; Tue, 28 Nov 2023 02:26:52 -0500
X-MC-Unique: It0yUrn1N0iFdlYtaaW3Vw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-407d3e55927so35597965e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:26:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156411; x=1701761211;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aDhxfrZ6A0IBRHudGpkZAOoM1jn0urSkC0LwcNBapbI=;
        b=ezjfbB44yyIEQNG74/RQ7WHsb2M8ljHHR4ucoUR49v77nw6oHHzdfXW9N5+FrX85D+
         Q7rQHdPkapqndaq5PPt5J02KLswno+pIEn55jJB+M4LwgjeMNI9kwxjIO/kSuP9HeQr4
         UMM4zhxLSkUzFh21FE90x18OtiTnNNTwcroclSc1WbrO5nRwbjmpBehSP1q8PXTVVF13
         bhbYKOGNaoCeawoMJ5D87DIt3xljgoMpRGLvFdSbI8yAoyxxOPfE3UAcp/PI8nR8lYVs
         Bo+XgjePzf58wXIwPQDE9oHl0mM7/185NvjQcCQv3Z4sW1JRpNhVwZnEMGrplU4PN1Fe
         qviA==
X-Gm-Message-State: AOJu0YwXvDh+KX1yThZTM45wV4c+0cwscYZF0FJ9/2h7aagJ93rlHFt3
        VSWh+p1tli49H8MxkeMxAP7ze0+bjJaxTRTQES2iQr0xWnmVhjGzlvPa/XhdZyco746AmcWSQBc
        IlokPRREUhg/z6hQNXc5DuoMZ
X-Received: by 2002:a05:600c:1f93:b0:401:2ee0:7558 with SMTP id je19-20020a05600c1f9300b004012ee07558mr10641348wmb.32.1701156411736;
        Mon, 27 Nov 2023 23:26:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4M7NxKP9raF3yxSld89xnv352HPd9UfYd6M9jkbwCiMadp3oGAStD9ceWph2CLoGlKw1rNQ==
X-Received: by 2002:a05:600c:1f93:b0:401:2ee0:7558 with SMTP id je19-20020a05600c1f9300b004012ee07558mr10641324wmb.32.1701156411350;
        Mon, 27 Nov 2023 23:26:51 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b00405959bbf4fsm16310283wmq.19.2023.11.27.23.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:26:51 -0800 (PST)
Message-ID: <38e52b16dfb57d0759b0e196fc952f20a62b0d3f.camel@redhat.com>
Subject: Re: [RFC 11/33] KVM: x86: hyper-v: Handle GET/SET_VP_REGISTER hcall
 in user-space
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Alexander Graf <graf@amazon.com>,
        Nicolas Saenz Julienne <nsaenz@amazon.com>,
        kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        anelkz@amazon.com, dwmw@amazon.co.uk, jgowans@amazon.com,
        corbert@lwn.net, kys@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, x86@kernel.org, linux-doc@vger.kernel.org
Date:   Tue, 28 Nov 2023 09:26:48 +0200
In-Reply-To: <b9c6ad26-ce8b-45f3-b856-8e6be2497f6e@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
         <20231108111806.92604-12-nsaenz@amazon.com>
         <b9c6ad26-ce8b-45f3-b856-8e6be2497f6e@amazon.com>
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

On Wed, 2023-11-08 at 13:14 +0100, Alexander Graf wrote:
> On 08.11.23 12:17, Nicolas Saenz Julienne wrote:
> > Let user-space handle HVCALL_GET_VP_REGISTERS and
> > HVCALL_SET_VP_REGISTERS through the KVM_EXIT_HYPERV_HVCALL exit reason.
> > Additionally, expose the cpuid bit.
> > 
> > Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> > ---
> >   arch/x86/kvm/hyperv.c             | 9 +++++++++
> >   include/asm-generic/hyperv-tlfs.h | 1 +
> >   2 files changed, 10 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > index caaa859932c5..a3970d52eef1 100644
> > --- a/arch/x86/kvm/hyperv.c
> > +++ b/arch/x86/kvm/hyperv.c
> > @@ -2456,6 +2456,9 @@ static void kvm_hv_write_xmm(struct kvm_hyperv_xmm_reg *xmm)
> >   
> >   static bool kvm_hv_is_xmm_output_hcall(u16 code)
> >   {
> > +	if (code == HVCALL_GET_VP_REGISTERS)
> > +		return true;
> > +
> >   	return false;
> >   }
> >   
> > @@ -2520,6 +2523,8 @@ static bool is_xmm_fast_hypercall(struct kvm_hv_hcall *hc)
> >   	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX:
> >   	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX:
> >   	case HVCALL_SEND_IPI_EX:
> > +	case HVCALL_GET_VP_REGISTERS:
> > +	case HVCALL_SET_VP_REGISTERS:
> >   		return true;
> >   	}
> >   
> > @@ -2738,6 +2743,9 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
> >   			break;
> >   		}
> >   		goto hypercall_userspace_exit;
> > +	case HVCALL_GET_VP_REGISTERS:
> > +	case HVCALL_SET_VP_REGISTERS:
> > +		goto hypercall_userspace_exit;
> >   	default:
> >   		ret = HV_STATUS_INVALID_HYPERCALL_CODE;
> >   		break;
> > @@ -2903,6 +2911,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
> >   			ent->ebx |= HV_POST_MESSAGES;
> >   			ent->ebx |= HV_SIGNAL_EVENTS;
> >   			ent->ebx |= HV_ENABLE_EXTENDED_HYPERCALLS;
> > +			ent->ebx |= HV_ACCESS_VP_REGISTERS;
> 
> Do we need to guard this?

I think so, check should be added to 'hv_check_hypercall_access'.

I do wonder though why KVM can't just pass all unknown hypercalls to userspace
instead of having a whitelist.


Best regards,
	Maxim Levitsky

> 
> 
> Alex
> 
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 




