Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A397DD4EB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346999AbjJaRpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376307AbjJaRpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:45:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2697C9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698774276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K9ATk+xEEF9iVCbTQHY9aknrLQ4S9DPQjw7UE6MLIMM=;
        b=hAqk9KCUhwkqSdx94acdxMtKGbhStVWi4tlD4cosNccMtpij80e83uoNlLcc5nKUcIL6Cg
        MDzlLqbU/EX3rs9oj5HX+MR4F3LuUX47BRxVbRnx+C3tDxKXsILcWdQyIE7j6G3DENhcCD
        X4DYx8SICzFypoK5hw5EStGaMd2XM+s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-TLJNN2sTObec82ZtpiTBjg-1; Tue, 31 Oct 2023 13:44:34 -0400
X-MC-Unique: TLJNN2sTObec82ZtpiTBjg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4093a561f7eso21618475e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774273; x=1699379073;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K9ATk+xEEF9iVCbTQHY9aknrLQ4S9DPQjw7UE6MLIMM=;
        b=P1HdpBByR7X4Fyatx23lgAVcuMzBsIfHf516U4T/xKGzyPMbFZOtRfNXqbPvmrk4yh
         T5GF4cAzxsZkV7M9yVRTKDQV4BtvkICDQZp4VHbJ2KjwjAi+fpf1sN9xwN01EB/C7jsu
         776Eg44cwFa8RDDIJZHvRXZI2DjXuxPVY/XRwbay2NwOhCznGwUs38xzrDtVoUuoiN+0
         9VRPYiWL9PMEnFdpGGB2EmLz40+tNYkxfwnr0lCyndspuXDwYAplXIEjKMHlYwERD3Mu
         +/Qab/4LAwd8yIWaiwHiF+qk831CvHuwpxcuqs/0S6Ep45iViATmVGf3ngcwhZg9ylpU
         WubQ==
X-Gm-Message-State: AOJu0Yy2XGyJVE5RHRuwAAnatIXizCGTqI/HRhD2zsV7TMH9DdR2ka+C
        n0c+tZ8JfFKwVaWTiGlR4OodgD1z35KuoI1pdyqBA2zCpHCHciWNX8v0Brcx0gw1VFYaw+UW/BN
        tis7dCF761OYQdNs4Ll5zIID2
X-Received: by 2002:adf:fa88:0:b0:31f:f65f:74ac with SMTP id h8-20020adffa88000000b0031ff65f74acmr8266451wrr.70.1698774273665;
        Tue, 31 Oct 2023 10:44:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeysvPYg4MaZZIdSgqpx65k49R9Wi9ixUa/a8pT03ZkRiB0O0l996DGT5K6AOj66/xKarLLw==
X-Received: by 2002:adf:fa88:0:b0:31f:f65f:74ac with SMTP id h8-20020adffa88000000b0031ff65f74acmr8266441wrr.70.1698774273433;
        Tue, 31 Oct 2023 10:44:33 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id p14-20020adfcc8e000000b0032dbf32bd56sm2015046wrj.37.2023.10.31.10.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:44:33 -0700 (PDT)
Message-ID: <bb2fab66ced849d739ab08cef1772e0c335d64eb.camel@redhat.com>
Subject: Re: [PATCH v6 05/25] x86/fpu/xstate: Remove kernel dynamic
 xfeatures from kernel default_features
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Tue, 31 Oct 2023 19:44:31 +0200
In-Reply-To: <d8c3888c-4266-d781-5d0a-381a57a9c35c@intel.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-6-weijiang.yang@intel.com>
         <d8c3888c-4266-d781-5d0a-381a57a9c35c@intel.com>
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

On Thu, 2023-09-14 at 09:22 -0700, Dave Hansen wrote:
> On 9/13/23 23:33, Yang Weijiang wrote:
> > --- a/arch/x86/kernel/fpu/xstate.c
> > +++ b/arch/x86/kernel/fpu/xstate.c
> > @@ -845,6 +845,7 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
> >  	/* Clean out dynamic features from default */
> >  	fpu_kernel_cfg.default_features = fpu_kernel_cfg.max_features;
> >  	fpu_kernel_cfg.default_features &= ~XFEATURE_MASK_USER_DYNAMIC;
> > +	fpu_kernel_cfg.default_features &= ~fpu_kernel_dynamic_xfeatures;
> 
> I'd much rather that this be a closer analog to XFEATURE_MASK_USER_DYNAMIC.
> 
> Please define a XFEATURE_MASK_KERNEL_DYNAMIC value and use it here.
> Don't use a dynamically generated one.
> 

I also think so.

Best regards,
	Maxim Levitsky




