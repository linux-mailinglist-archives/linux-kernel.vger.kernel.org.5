Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054007FE5F9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343899AbjK3BYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3BYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:24:34 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854A110C6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:24:40 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cfb5471cd4so4229185ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701307480; x=1701912280; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FijcW7Tw2HqDQY+nVc3aasjWLlfqxmExsIveTz02HjQ=;
        b=DAu88USZFrzw4PSECulnLd2jUUwFwZwOsCY4pcGqtfspPfpDHNumJFt+idmYSn7FZp
         yJSXFY0tmuNm7JaHTP/Iblxtntfq/RR34MC2uY2E8yXx8fFI+kFN30fA+uLyY+ENL0fs
         Zmd+PTV6TSazIcdRxmsYql0iUTGbdPDwBTG37uMwuolQwwn2SuMuEyAe1uxzO/S0X/VV
         0VFQwOITblsf9DEifX3jXUimear9er80RKBd+1FwEmizr+abr9FTgCIkVlyMmVkDGrcW
         t7fJqdCMtI74myGF6JXCWIIIO+K8zqFwG1oGtsvTnmn5SkW205QO6VO1jH/oeQESTiuc
         mduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701307480; x=1701912280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FijcW7Tw2HqDQY+nVc3aasjWLlfqxmExsIveTz02HjQ=;
        b=I32H28tOSDVIdaoed6ecaEnuBNwsQxQcIYkFwZRqob2OfZjV/X1wt8/BYHKBPlrood
         AnPgL37Jv7T6RYRnw2/8Ptbm6qJTBnVZPa6wlZapGNIiKJ+AQU5+V9vDKJ+AH94fap1k
         kxifbo3tb/xyDwtg7Qr4/URpgb9eNz1LyQBf3ylQyTdA/86PlabfbX0N3RiDB1r8nBeE
         HgiVkejh9jS/M2UDpdKj8UKHDrx7OdIzglsJHiqGUBXwfyD5X7tHvdekkeYomR0LUL2N
         u8kkIjKFzTFfSjnp03/jyfCfiOhGxo96sG1ynxvrYOl/B1Da008UweSo41e0wdrJ3Plk
         jhDA==
X-Gm-Message-State: AOJu0YxN7zuXPMADDl1Uscv+fl8bBfMTG/JijxiZbndp80Fwdsml95An
        +mK34+hV5O3PSQAsLGW7viu5HHJwR00=
X-Google-Smtp-Source: AGHT+IErsuc0JAxSV9mVa1KKUxzvdkHcwJKTQOB5cSVR+6B7NH/uRbY1BOT56iziJwTSivAzPdqEhwldt1A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:25cf:b0:1cf:d52a:2255 with SMTP id
 jc15-20020a17090325cf00b001cfd52a2255mr2256433plb.11.1701307480068; Wed, 29
 Nov 2023 17:24:40 -0800 (PST)
Date:   Wed, 29 Nov 2023 17:24:38 -0800
In-Reply-To: <20231025152406.1879274-12-vkuznets@redhat.com>
Mime-Version: 1.0
References: <20231025152406.1879274-1-vkuznets@redhat.com> <20231025152406.1879274-12-vkuznets@redhat.com>
Message-ID: <ZWfkVnsYytDeeaDL@google.com>
Subject: Re: [PATCH 11/14] KVM: nVMX: hyper-v: Introduce nested_vmx_evmptr12()
 and nested_vmx_is_evmptr12_valid() helpers
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
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

On Wed, Oct 25, 2023, Vitaly Kuznetsov wrote:
> 'vmx->nested.hv_evmcs_vmptr' accesses are all over the place so hiding
> 'hv_evmcs_vmptr' under 'ifdef CONFIG_KVM_HYPERV' would take a lot of
> ifdefs. Introduce 'nested_vmx_evmptr12()' accessor and
> 'nested_vmx_is_evmptr12_valid()' checker instead. Note, several explicit
> 
>   nested_vmx_evmptr12(vmx) != EVMPTR_INVALID
> 
> comparisons exist for a reson: 'nested_vmx_is_evmptr12_valid()' also checks
> against 'EVMPTR_MAP_PENDING' and in these places this is undesireable. It
> is possible to e.g. introduce 'nested_vmx_is_evmptr12_invalid()' and turn
> these sites into
> 
>   !nested_vmx_is_evmptr12_invalid(vmx)
> 
> eliminating the need for 'nested_vmx_evmptr12()' but this seems to create
> even more confusion.
> 
> No functional change intended.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/hyperv.h | 10 +++++++++
>  arch/x86/kvm/vmx/nested.c | 44 +++++++++++++++++++--------------------
>  arch/x86/kvm/vmx/nested.h |  2 +-
>  3 files changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/hyperv.h b/arch/x86/kvm/vmx/hyperv.h
> index 933ef6cad5e6..ba1a95ea72b7 100644
> --- a/arch/x86/kvm/vmx/hyperv.h
> +++ b/arch/x86/kvm/vmx/hyperv.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/kvm_host.h>
>  #include "vmcs12.h"
> +#include "vmx.h"
>  
>  #define EVMPTR_INVALID (-1ULL)
>  #define EVMPTR_MAP_PENDING (-2ULL)
> @@ -20,7 +21,14 @@ enum nested_evmptrld_status {
>  	EVMPTRLD_ERROR,
>  };
>  
> +struct vcpu_vmx;

This forward declaration should be unnecessary as it's defined by vmx.h, which
is included above.  
