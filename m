Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67F17FF8EC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346604AbjK3R6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjK3R6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:58:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E2C10EA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701367103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXAA0SWAfHXtZ1ioopeEEFz3kDipZ0RHppWNUXlv9bg=;
        b=fORwbM0HueohgOdFEbaJ/RVT94i7qxH0UbXhUfd7753Lq1X1l9yT3yYZkQ71Z1DnsAamdB
        RnSX6cIyY2JAF903+B6oVxT0r+MvOJcyGfO+m54Hb01hAeA6QlrWYtBVpGE7f+2m+xzSN4
        zRedEbwf5Ws1MlUKUx3srPPunW47LHI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-TNDzuNigMxyj1XuQfguGWQ-1; Thu, 30 Nov 2023 12:58:22 -0500
X-MC-Unique: TNDzuNigMxyj1XuQfguGWQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-333120f8976so1012029f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701367101; x=1701971901;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXAA0SWAfHXtZ1ioopeEEFz3kDipZ0RHppWNUXlv9bg=;
        b=P0vtpxbSchYgg84kv07rxajtzaCY6WB6xl0pajzHAXqxcdS3NKKuHYoDQmSiDB1LPl
         JYdirhgrMvHT+NzDQvGArdtbtclalcyfzipSiLryUFw6JqkN+DpMGC+wsWNOmHy1tPmb
         XFbOV7rBBwdEySO1AKHpw0ycLZjx5KWmwOlb2aQoCLEaSHulUe12X20kcDySw5pSqUXL
         lmh4vj7hJUOwTwfyO8m5ePFjGOBhsvuafCxvX69Ryjcx07M8OGAQ7QDvMd6wrr5O4P0F
         QGxY4uNSmmBczZ+HRNwFz0dzEaWGhbLPHss/VK48jMeqiIjxOICqyLgeHAHpy+RMqZL6
         F+5g==
X-Gm-Message-State: AOJu0YyEXWe8MNnnrsfgsn4CeGosn7laBkpXP1Na6o+X9mXa4hllZa5H
        zuk0i4iYHP2CGAKoKbzmiqb71EfIdvfjvrvr0NRj4MLYeFGpCgb0jrRm5LW2HNdoi4CLQOIUezX
        yH5oCFKQZ733XDx+k9mt4LuGWFmct2cWH
X-Received: by 2002:a17:906:2c0c:b0:a03:d8ea:a263 with SMTP id e12-20020a1709062c0c00b00a03d8eaa263mr10894ejh.16.1701366694858;
        Thu, 30 Nov 2023 09:51:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtc0eXLlwnLg30p/WJ6AWxa2PJaUXZoOYAwEip1wk4a2f/JyUmPPCTF24oDqoOPtL76C+mdA==
X-Received: by 2002:adf:f148:0:b0:332:c9c3:2cd3 with SMTP id y8-20020adff148000000b00332c9c32cd3mr4045wro.47.1701365355975;
        Thu, 30 Nov 2023 09:29:15 -0800 (PST)
Received: from starship ([5.28.147.32])
        by smtp.gmail.com with ESMTPSA id h1-20020a2eb0e1000000b002c9c0a59627sm190249ljl.41.2023.11.30.09.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:29:15 -0800 (PST)
Message-ID: <90cb8be18da40c62f6acbf2bee19ec046e122e49.camel@redhat.com>
Subject: Re: [PATCH v7 05/26] x86/fpu/xstate: Introduce fpu_guest_cfg for
 guest FPU configuration
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Cc:     "john.allen@amd.com" <john.allen@amd.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Gao, Chao" <chao.gao@intel.com>
Date:   Thu, 30 Nov 2023 19:29:13 +0200
In-Reply-To: <742a95cece1998673aa360be10036c82c0c535ec.camel@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-6-weijiang.yang@intel.com>
         <742a95cece1998673aa360be10036c82c0c535ec.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-28 at 14:58 +0000, Edgecombe, Rick P wrote:
> On Fri, 2023-11-24 at 00:53 -0500, Yang Weijiang wrote:
> > +       /*
> > +        * Set guest's __user_state_size to fpu_user_cfg.default_size
> > so that
> > +        * existing uAPIs can still work.
> > +        */
> > +       fpu->guest_perm.__user_state_size =
> > fpu_user_cfg.default_size;


> 
> It seems like an appropriate value, but where does this come into play
> exactly for guest FPUs?

It is used because permission API is used for guest fpu state as well (for user features),
and it affects two things:

1. If permission is not asked, then KVM will fail to resize the FPU state to match guest CPUID.
2. It will affect output size of the KVM_GET_XSAVE2 ioctl, which outputs buffer similar to
other FPU state buffers exposed to userspace (like one saved on signal stack, or one obtained via ptrace).


Best regards,
	Maxim Levitsky

