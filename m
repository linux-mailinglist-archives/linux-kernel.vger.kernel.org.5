Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE59B7FB2CB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343740AbjK1HeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjK1HeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:34:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93602197
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701156855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eyjo55qLliRYjmYTzBCIbN4AdrhCtAA/uK2GJwWiVO0=;
        b=hCCgfYjucqMKc8Ij2fCNRtRc12hgnzZLT14d1nBVGtIOsjL/5+Wf9ZlMPxCVimDt+7Ahvf
        RkNuNiDKrHLYfalJSHyOwHNe57SLx9SWyIrPxSMI/k0CtYx+P2GZV7U+/pVMMhZ/nS0aBK
        5E2tjZ6NZw2aJ1KKyymIfVA+zM5bTEQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-tm_TR_TUNcmp-oewGFdCng-1; Tue, 28 Nov 2023 02:34:14 -0500
X-MC-Unique: tm_TR_TUNcmp-oewGFdCng-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c87972a358so45229251fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:34:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156853; x=1701761653;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eyjo55qLliRYjmYTzBCIbN4AdrhCtAA/uK2GJwWiVO0=;
        b=JdfUjsYMw8goaRVGB1lOxB/8erm75QBWs0Vh67RfRlg8JFnD4KtqFAW0vOA9a2B8bC
         sTpKL/5hplXKog9yJj9i3+tHDg2JDLJ6qeIuCdk5mGxpIX2HXyCwCji6uifJWevYUu0D
         t0RbKe7LLTV30QJwWTzgHbcFCVoqMtTyq/DA0kwdSaSdMNZ61IMZ4vCMzXdNNc2U3FdY
         3MQPyfEOyhLH8won7X91lcNDwc7nzCJtDGfCOHs5UVtMqvzXzJR8pTPrygKqoByR6xIK
         bavKlQZLUX9Of+uLdy640A3EoDMqSQcj0BksDwP8hvRZGybDaohZJjBdx0jjqFQl8bgk
         RqnA==
X-Gm-Message-State: AOJu0YwqnDvKyzgg/MAqaQWKJC/hRbkm0/9JgOxr6XmZSx7usXNmD+Xi
        CU0JTZeVoFmKLjuklAvBHLigm5B16mJ/7H5YqIUdnuHPjgIhkKL9dieacAu5BhSw1raZvZjK+Do
        X7plDLjgUUb98x5QuW5TR6WTA
X-Received: by 2002:a05:651c:c85:b0:2c9:9376:1ae7 with SMTP id bz5-20020a05651c0c8500b002c993761ae7mr8406390ljb.28.1701156852838;
        Mon, 27 Nov 2023 23:34:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhKW22SAvKwvjE7CTORodsLpg9bL5WiFyycmYSgUDV6WJI08pAgC+6hurQK/6T/oEOp7zr0g==
X-Received: by 2002:a05:651c:c85:b0:2c9:9376:1ae7 with SMTP id bz5-20020a05651c0c8500b002c993761ae7mr8406365ljb.28.1701156852519;
        Mon, 27 Nov 2023 23:34:12 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b0040b4110f548sm9598049wmq.23.2023.11.27.23.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:34:12 -0800 (PST)
Message-ID: <5838ebdd46bcddd836bc87d0ec7d57fadbfb79f6.camel@redhat.com>
Subject: Re: [RFC 14/33] KVM: x86: Add VTL to the MMU role
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, anelkz@amazon.com, graf@amazon.com,
        dwmw@amazon.co.uk, jgowans@amazon.com, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, x86@kernel.org,
        linux-doc@vger.kernel.org
Date:   Tue, 28 Nov 2023 09:34:10 +0200
In-Reply-To: <CWVCX8ZD8QQZ.2FVZ6DODV8A6T@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
         <20231108111806.92604-15-nsaenz@amazon.com> <ZUvE2clQI-wOzRBd@google.com>
         <CWVCX8ZD8QQZ.2FVZ6DODV8A6T@amazon.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Fri, 2023-11-10 at 18:52 +0000, Nicolas Saenz Julienne wrote:
> On Wed Nov 8, 2023 at 5:26 PM UTC, Sean Christopherson wrote:
> > On Wed, Nov 08, 2023, Nicolas Saenz Julienne wrote:
> > > With the upcoming introduction of per-VTL memory protections, make MMU
> > > roles VTL aware. This will avoid sharing PTEs between vCPUs that belong
> > > to different VTLs, and that have distinct memory access restrictions.
> > > 
> > > Four bits are allocated to store the VTL number in the MMU role, since
> > > the TLFS states there is a maximum of 16 levels.
> > 
> > How many does KVM actually allow/support?  Multiplying the number of possible
> > roots by 16x is a *major* change.
> 
> AFAIK in practice only VTL0/1 are used. Don't know if Microsoft will
> come up with more in the future. We could introduce a CAP that expses
> the number of supported VTLs to user-space, and leave it as a compile
> option.
> 

Actually hyperv spec says that currently only two VTLs are implemented in HyperV

https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/vsm

"Architecturally, up to 16 levels of VTLs are supported; however a hypervisor may choose to implement fewer than 16 VTL’s. Currently, only two VTLs are implemented."

We shouldn't completely hardcode two VTLs but I think that it is safe to make optimizations aiming at two VTLs,
and also have a compile time switch for the number of supported VTLs.

In terms of adding VTLs to MMU role, as long as it's only 2 VTLs, I don't think that this is a terrible idea.

This does bring a question: what we are going to do about SMM? Windows will need it due to secure boot,
so we can't just say that VSM is only supported without SMM.


However if we take the approach of having a VM per VTL, then all of this is free, except that every time userspace changes memslots,
it will have to do so for both VMs at the same time (and that might introduce races).

Also TLB flushes might be tricky to synchronize between these two VMs and so on.

Best regards,
	Maxim Levitsky



