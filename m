Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6787DF9BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377153AbjKBSPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbjKBSOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:14:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D7F423E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698948061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJ+UkH3qPYQ7lRJ5DdsZoeXn42tgB94NClzdfh7mZoQ=;
        b=aMYv9dxTLzj9rz1NsC4Lx21WHFDcDc3U2dh5C7TEJ+wzsN1qfkriasbEUA93GWqCY+/t4G
        Lyp5Fe45nOMLgJvAID64HqOF16VwlR02RDc+Mbzw7alr9Xz3gXjEjJG+C+Bvtf7GvuFmjE
        T+ypNPIFumnpvQ073yBbXtnjqBv78e0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-3ZdsxKa4PJ6FjcFe_yYD7g-1; Thu, 02 Nov 2023 14:00:58 -0400
X-MC-Unique: 3ZdsxKa4PJ6FjcFe_yYD7g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32f8c4e9b88so835755f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948057; x=1699552857;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ+UkH3qPYQ7lRJ5DdsZoeXn42tgB94NClzdfh7mZoQ=;
        b=FdFEJFpenW09RWYZmSiHZZpFPxsiXcxq7kOLcdiVCtKb+Qca0PMTuk6hEzEOqJbGUJ
         CoMhPigGGNkF5XOmDHbrrSZXEG0xP/yx+jn4vPts3K0rmUdfHWlybjrpfLjw2ztxczfM
         yks7ek9QzJz/z0KaBbjZunkJli1Omqi0+UxvDw+hRONLbQ8pvnf9he7iU2vWNKlCqtLC
         TY+HQGOMcNL0mhJohjJW7UUFEeP1OqnNM5AYxMoRegZgN6PtMFG8fE9P3xKq2A6zDGFa
         5N7f7TZJBtPUy+dsUOTvJHhrAkGhx/jzL0/sRvFae8gO3FJbtXHPMXiSnrcCCgBGAG0D
         CyAA==
X-Gm-Message-State: AOJu0Yw7HyJd/iq8LdaMRC59yPvbs6bIFazIQoRhXRUJ6LDAiu4+k7X9
        t1IL2wAe6S53Ha5WUh/VCwjPC+w3V9bweSvFipmrMLUkP1r7PGVjyppFsEkaaBMsVNuj7DglYTz
        AzUyixqOA1+2G5vsEoSRnFnoK
X-Received: by 2002:a5d:584b:0:b0:314:c6b:b9a2 with SMTP id i11-20020a5d584b000000b003140c6bb9a2mr545423wrf.13.1698948057334;
        Thu, 02 Nov 2023 11:00:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1n2z71L+wqB4Mkj6U4jKyy45oITPgji4/YRzxTHFku+S26pjfXL8zLBz7RADa15XZapq+LQ==
X-Received: by 2002:a5d:584b:0:b0:314:c6b:b9a2 with SMTP id i11-20020a5d584b000000b003140c6bb9a2mr545324wrf.13.1698948056251;
        Thu, 02 Nov 2023 11:00:56 -0700 (PDT)
Received: from starship ([89.237.99.95])
        by smtp.gmail.com with ESMTPSA id u9-20020adfed49000000b0031c52e81490sm3023134wro.72.2023.11.02.11.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:00:55 -0700 (PDT)
Message-ID: <1af84c9b931f7dda277b49d1463ea8cdcda32cf0.camel@redhat.com>
Subject: Re: [PATCH 2/9] KVM: x86: SVM: Update dump_vmcb with shadow stack
 save area additions
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     John Allen <john.allen@amd.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        weijiang.yang@intel.com, rick.p.edgecombe@intel.com,
        seanjc@google.com, x86@kernel.org, thomas.lendacky@amd.com,
        bp@alien8.de
Date:   Thu, 02 Nov 2023 20:00:54 +0200
In-Reply-To: <20231010200220.897953-3-john.allen@amd.com>
References: <20231010200220.897953-1-john.allen@amd.com>
         <20231010200220.897953-3-john.allen@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-10 at 20:02 +0000, John Allen wrote:
> Add shadow stack VMCB save area fields to dump_vmcb. Only include S_CET,
> SSP, and ISST_ADDR. Since there currently isn't support to decrypt and
> dump the SEV-ES save area, exclude PL0_SSP, PL1_SSP, PL2_SSP, PL3_SSP, and
> U_CET which are only inlcuded in the SEV-ES save area.
> 
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>  arch/x86/kvm/svm/svm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 6a0d225311bc..e435e4fbadda 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3416,6 +3416,10 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
>  	       "rip:", save->rip, "rflags:", save->rflags);
>  	pr_err("%-15s %016llx %-13s %016llx\n",
>  	       "rsp:", save->rsp, "rax:", save->rax);
> +	pr_err("%-15s %016llx %-13s %016llx\n",
> +	       "s_cet:", save->s_cet, "ssp:", save->ssp);
> +	pr_err("%-15s %016llx\n",
> +	       "isst_addr:", save->isst_addr);
>  	pr_err("%-15s %016llx %-13s %016llx\n",
>  	       "star:", save01->star, "lstar:", save01->lstar);
>  	pr_err("%-15s %016llx %-13s %016llx\n",

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

