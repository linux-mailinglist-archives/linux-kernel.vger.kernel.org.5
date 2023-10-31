Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC767DD50A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376356AbjJaRqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376387AbjJaRqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7819FF3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698774344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cO/Vlwo8YbBBaeYGTje2Kw7g6SOZ7cRjnvIaAY84PaE=;
        b=h4FUEYxCZd/Xn4DtanfNiKZmH/+byITL5LcRyK2tmPg25gWBoL3IVbaPIJJ6KWqK75cFm7
        hlMF+IMddE89dlzJxx5vsr6QI57h+rvgzmxdU/cejQFi0cMkd4uyfbbItKnXU1CVDPo72/
        xeqagW2lRXgdXqT2+zv7mXxa5Ussck0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-he6pbem7MQ60hy_WYt6k9g-1; Tue, 31 Oct 2023 13:45:43 -0400
X-MC-Unique: he6pbem7MQ60hy_WYt6k9g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32f8371247fso1403608f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774342; x=1699379142;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cO/Vlwo8YbBBaeYGTje2Kw7g6SOZ7cRjnvIaAY84PaE=;
        b=VfvfOycDD6OFmOSzYbhimIrBVfYgZXQ2GE19Hr77/DuCYx2oj6jzEs7U2W8Y7h2pxR
         csAQixNN25Ho2fklrGi5Ee1kbqZR53W5t8mXrEWyqGMcUHYKefqYK1cu0FROKNyEpZI8
         c7256x5hJ3W/uOufWWc3sYD1Lhp1hpsRKjhFEvB093JtybsxyBgoLqQiKAv+M+sbyIkS
         5UwD2hKDPvYrgmF/13aGgzev2p05XfckPqC6D7GTOiAzGW6oik8weW8dOSTPWvHWk1bi
         rTLQZ5iPp8oWj+OUJztXCpGJm2TB7foOrFVDkEoEz3Uv+OI3glsacFlSF8hGr7uHYj/9
         WvrA==
X-Gm-Message-State: AOJu0YyCp20h/2SD5f3wK1mN213TYFjqCEj6SMSC4XRlT0O0oQ8ZJh+Y
        jkn/xxe5H7ERwdTz9Kxc/UrcgnW5lm5TMIRROof0IBOGta0W/RmGA9vHSkBJPGfTxjYLtsqrZKh
        mMPJG0GsWYc5PAyNDF0jKJK+9
X-Received: by 2002:a5d:5b08:0:b0:32d:bb4a:525c with SMTP id bx8-20020a5d5b08000000b0032dbb4a525cmr15714443wrb.14.1698774342100;
        Tue, 31 Oct 2023 10:45:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy2h6R3KqjFDxJ6i/qPbHjR5tnvvY3sC6qACoOqxagdoF8k/6p0aXaV1cTogc9EuQUwhR9sg==
X-Received: by 2002:a5d:5b08:0:b0:32d:bb4a:525c with SMTP id bx8-20020a5d5b08000000b0032dbb4a525cmr15714425wrb.14.1698774341870;
        Tue, 31 Oct 2023 10:45:41 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id l4-20020adff484000000b0032f79e55eb8sm1997449wro.16.2023.10.31.10.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:45:41 -0700 (PDT)
Message-ID: <110a791e0f057b52b7395569422100ede192cbbf.camel@redhat.com>
Subject: Re: [PATCH v6 08/25] x86/fpu/xstate: WARN if normal fpstate
 contains kernel dynamic xfeatures
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Tue, 31 Oct 2023 19:45:39 +0200
In-Reply-To: <20230914063325.85503-9-weijiang.yang@intel.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-9-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> fpu_kernel_dynamic_xfeatures now are __ONLY__ enabled by guest kernel and
> used for guest fpstate, i.e., none for normal fpstate. The bits are added
> when guest fpstate is allocated and fpstate->is_guest set to %true.
> 
> For normal fpstate, the bits should have been removed when init system FPU
> settings, WARN_ONCE() if normal fpstate contains kernel dynamic xfeatures
> before xsaves is executed.
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kernel/fpu/xstate.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
> index 9c6e3ca05c5c..c2b33a5db53d 100644
> --- a/arch/x86/kernel/fpu/xstate.h
> +++ b/arch/x86/kernel/fpu/xstate.h
> @@ -186,6 +186,9 @@ static inline void os_xsave(struct fpstate *fpstate)
>  	WARN_ON_FPU(!alternatives_patched);
>  	xfd_validate_state(fpstate, mask, false);
>  
> +	WARN_ON_FPU(!fpstate->is_guest &&
> +		    (mask & fpu_kernel_dynamic_xfeatures));
> +
>  	XSTATE_XSAVE(&fpstate->regs.xsave, lmask, hmask, err);
>  
>  	/* We should never fault when copying to a kernel buffer: */

I am not sure about this patch. It's true that now the kernel dynamic features
are for guest only, but in the future I can easily see a kernel dynamic feature
that will also be used in the kernel itself.

Maybe we can add a comment above this warning to say that _currently_ there are
no kernel dynamic features that are enabled for the host kernel.

Best regards,
	Maxim Levitsky




