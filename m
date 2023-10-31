Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D887DD4E4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376293AbjJaRpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376261AbjJaRpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90406A6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698774265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vjtWvsFj0am0rYDH+Q7lI+mXlwPeVNGi1NsELi1tHIo=;
        b=eOb1SLAd8nPog06t5PBqbJ1qNJyn5ldW1UIvcfEPk2+vlh2Na4gQHRV/2YN6Wgi2eAXb7F
        35EanLqNHnugJIP+IMDPOQnVUKtgSJxSjDQOVD6tLY25bud9EL+nLcVaDHmSd00lHeH2j7
        UHrmkDotsOpqz37Psm6/s3Z1laKsRdM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-IZAlu8ZIOnqt0esWeprWWQ-1; Tue, 31 Oct 2023 13:44:24 -0400
X-MC-Unique: IZAlu8ZIOnqt0esWeprWWQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5091368e043so3797805e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774262; x=1699379062;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vjtWvsFj0am0rYDH+Q7lI+mXlwPeVNGi1NsELi1tHIo=;
        b=eeVyePy1+2kh5TmXbMank5ZkcUErnmVG0grju3SF6SW+fONe5tNHiiTO9YBQbw8mN7
         FYj3ksubFmCO6I6wTBhAbHoZ8D6+Di6y+YqluA4shITGJ6TYsEOq8z14XNMmn8X2jbZw
         KlUAeO/l1RtgvZlT8ZOsx+bM0V35z4Ccxm2ekfSeAFDZ3zEbEI63dmvTTLlnU366Knjs
         nxMcIQgwlcDzBHUypwIVgJUqSzgkuaTP3Bgh2i/3IXAgkToStAddnCvrZ2eM1BouIZ9y
         BjnvVUvbrlVSe7Q9ctirW6oW4umBhcbdVBi2A9N3aCEuucEx+Dd3DZpsHe+K7beIg1TG
         mw7g==
X-Gm-Message-State: AOJu0Ywq7tJnDkT8ePtJ597ZQsGe/LhOh/9D6YVW8z41lMi3/lL5ClMn
        N0oAql4E9nKRY0is06RmQ3g0oAKwbox7Df0in68y6BDlVrJYdkl0u8THBGDYeZC0mqkfr360gaz
        Bgo7YPRWleHsV2K+iSZgDLjWe
X-Received: by 2002:a05:6512:3b3:b0:507:99d6:95fc with SMTP id v19-20020a05651203b300b0050799d695fcmr9172418lfp.45.1698774262707;
        Tue, 31 Oct 2023 10:44:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFV6sOHpaJ3EyONEX+ohOPSasXf97pDEXBx9ljvLy8uz4xZRam6mOr1a98gGLj4gQyTHZMpA==
X-Received: by 2002:a05:6512:3b3:b0:507:99d6:95fc with SMTP id v19-20020a05651203b300b0050799d695fcmr9172404lfp.45.1698774262513;
        Tue, 31 Oct 2023 10:44:22 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id a8-20020adffac8000000b003296b488961sm1997228wrs.31.2023.10.31.10.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:44:22 -0700 (PDT)
Message-ID: <17c85a216c87a2a91bdfd8f34659df1dfb1d8f63.camel@redhat.com>
Subject: Re: [PATCH v6 04/25] x86/fpu/xstate: Introduce kernel dynamic
 xfeature set
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Gao, Chao" <chao.gao@intel.com>,
        "john.allen@amd.com" <john.allen@amd.com>
Date:   Tue, 31 Oct 2023 19:44:20 +0200
In-Reply-To: <eea8bf26-1c86-8e2b-9ded-cb0d09c08fcf@intel.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-5-weijiang.yang@intel.com>
         <f16beeec3fba23a34c426f311239935c5be920ab.camel@intel.com>
         <eea8bf26-1c86-8e2b-9ded-cb0d09c08fcf@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-09-15 at 14:42 +0800, Yang, Weijiang wrote:
> On 9/15/2023 8:24 AM, Edgecombe, Rick P wrote:
> > On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> > > +static void __init init_kernel_dynamic_xfeatures(void)
> > > +{
> > > +       unsigned short cid;
> > > +       int i;
> > > +
> > > +       for (i = 0; i < ARRAY_SIZE(xsave_kernel_dynamic_xfeatures);
> > > i++) {
> > > +               cid = xsave_kernel_dynamic_xfeatures[i];
> > > +
> > > +               if (cid && boot_cpu_has(cid))
> > > +                       fpu_kernel_dynamic_xfeatures |= BIT_ULL(i);
> > > +       }
> > > +}
> > > +
> > I think this can be part of the max_features calculation that uses
> > xsave_cpuid_features when you use use a fixed mask like Dave suggested
> > in the other patch.
> 
> Yes, the max_features has already included CET supervisor state bit. After  use
> fixed mask, this function is not needed.
> 
> 
My 0.2 cents are also on having XFEATURE_MASK_KERNEL_DYNAMIC macro instead.

Best regards,
	Maxim Levitsky




