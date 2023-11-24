Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF7E7F8289
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345941AbjKXTIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345799AbjKXTI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:08:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B4C19B1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700852913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ktMN6fpPE1Jf/JsJv1eWYJ7kbl3PClV8V5bIG3J558=;
        b=R5AhIL42byWML5c2aXzoYyeUNZ2ilRvQExbw6dxikcjmbr5wZHvbzA+OeiHCpb+b9fF2L1
        lJUK7wstZKl9t8dN0NuHUHAHhBXC6roPQCBODHiq46t+rXLQpIQG6W3Iypux6+p6KcVn+e
        twLESudGdoa8Nkq327CUEYqR3L5R1XY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-P_0_uEoONRm4ynfhoWadcg-1; Fri, 24 Nov 2023 14:08:31 -0500
X-MC-Unique: P_0_uEoONRm4ynfhoWadcg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c50ef18b04so26551541fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:08:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700852910; x=1701457710;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ktMN6fpPE1Jf/JsJv1eWYJ7kbl3PClV8V5bIG3J558=;
        b=SwphvGzlb40ECtswj83Nd6lguhcWCrydDmLXXCTyfYFuDqRTuJJ9V1Ik8CJaLuX3Am
         jUcDUPZ1a8P9KxepCn2RAy7J7j5aWF8ujKU+ikA1U3O9K3UhbnlrDe4fJk8Rbs9pXoFf
         z1bOILijLxqqY9MWmCsPp5UK8UGNuI+YanofFUUvtzapahi7jq6D8uweYX/UhEYBQf8i
         djwNlTLeKNkUvuhLZRbOlHWoZ8rlsyHqi/J+jjJvdy1cMEeDuHh3DtsbUQOpD33vmfls
         ZQSspVQHftVx+aAsAxxTW9TPkwyVskKRU9+32H9N6jxEOk055QTjtYlpxSHTFKYkpBoF
         3MOg==
X-Gm-Message-State: AOJu0Yw3x/otQJncD/mKH28ekT0cJ54bXCyW+NBhEv/3q7KhbdqhwLD+
        d9saHNQbgCkEmoE26yn+GTo8NOcygfjGQjoAEdrtM+8TZgsMlRyDmB7pAYSs+KZ02Ho5YTtY8Vb
        hQj56EmzN4OMwzdVY4Ts/XIyB
X-Received: by 2002:a2e:9d5a:0:b0:2c7:3b83:c4b7 with SMTP id y26-20020a2e9d5a000000b002c73b83c4b7mr2699922ljj.14.1700852910305;
        Fri, 24 Nov 2023 11:08:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVm/V08FW9UONS0nS/A1S/Bwyn4V6Z7EXOCU29ZC+B53PqwGcdz73dtb8czfY1GowtO7aojA==
X-Received: by 2002:a2e:9d5a:0:b0:2c7:3b83:c4b7 with SMTP id y26-20020a2e9d5a000000b002c73b83c4b7mr2699899ljj.14.1700852909940;
        Fri, 24 Nov 2023 11:08:29 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id hg25-20020a170906f35900b00a08a933baafsm1312957ejb.126.2023.11.24.11.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 11:08:29 -0800 (PST)
Message-ID: <a6ef92ae-0747-435b-822d-d0229da4683c@redhat.com>
Date:   Fri, 24 Nov 2023 20:08:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Danilo Krummrich <dakr@redhat.com>
Subject: Re: [PATCH 4/4] lib/iomap.c: improve comment about pci anomaly
To:     Arnd Bergmann <arnd@kernel.org>,
        Philipp Stanner <pstanner@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Eric Auger <eric.auger@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Neil Brown <neilb@suse.de>, John Sanpe <sanpeqf@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Gow <davidgow@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Jason Baron <jbaron@akamai.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20231120215945.52027-2-pstanner@redhat.com>
 <20231120215945.52027-6-pstanner@redhat.com>
 <a9ab9976-c1e0-4f91-b17f-e5bbbf21def3@app.fastmail.com>
Content-Language: en-US
Organization: RedHat
In-Reply-To: <a9ab9976-c1e0-4f91-b17f-e5bbbf21def3@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 11/21/23 11:03, Arnd Bergmann wrote:
> On Mon, Nov 20, 2023, at 22:59, Philipp Stanner wrote:
>> lib/iomap.c contains one of the definitions of pci_iounmap(). The
>> current comment above this out-of-place function does not clarify WHY
>> the function is defined here.
>>
>> Linus's detailed comment above pci_iounmap() in drivers/pci/iomap.c
>> clarifies that in a far better way.
>>
>> Extend the existing comment with an excerpt from Linus's and hint at the
>> other implementation in drivers/pci/iomap.c
>>
>> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> 
> I think instead of explaining why the code is so complicated
> here, I'd prefer to make it more logical and not have to
> explain it.
> 
> We should be able to define a generic version like
> 
> void pci_iounmap(struct pci_dev *dev, void __iomem * addr)

Let's shed some light on the different config options related to this.

To me it looks like GENERIC_IOMAP always implies GENERIC_PCI_IOMAP.

lib/iomap.c contains a definition of pci_iounmap() since it uses the
common IO_COND() macro. This definitions wins if GENERIC_IOMAP was
selected.

lib/pci_iomap.c contains another definition of pci_iounmap() which is
guarded by ARCH_WANTS_GENERIC_PCI_IOUNMAP to prevent multiple definitions
in case either GENERIC_IOMAP is set or the architecture already defined
pci_iounmap().

What's the purpose of not having set ARCH_HAS_GENERIC_IOPORT_MAP producing
an empty definition of pci_iounmap() though [1]?

And more generally, is there any other (subtle) logic behind this?

[1] https://elixir.bootlin.com/linux/latest/source/lib/pci_iomap.c#L167

> {
> #ifdef CONFIG_HAS_IOPORT
>         if (iomem_is_ioport(addr)) {
>                ioport_unmap(addr);
>                return;
>         }
> #endif
>        iounmap(addr)
> }
> 
> and then define iomem_is_ioport() in lib/iomap.c for x86,
> while defining it in asm-generic/io.h for the rest,
> with an override in asm/io.h for those architectures
> that need a custom inb().

So, that would be similar to IO_COND(), right? What would we need inb() for
in this context?

- Danilo

> 
> Note that with ia64 gone, GENERIC_IOMAP is not at all
> generic any more and could just move it to x86 or name
> it something else. This is what currently uses it:
> 
> arch/hexagon/Kconfig:   select GENERIC_IOMAP
> arch/um/Kconfig:        select GENERIC_IOMAP
> 
> These have no port I/O at all, so it doesn't do anything.
> 
> arch/m68k/Kconfig:      select GENERIC_IOMAP
> 
> on m68knommu, the default implementation from asm-generic/io.h
> as the same effect as GENERIC_IOMAP but is more efficient.
> On classic m68k, GENERIC_IOMAP does not do what it is
> meant to because I/O ports on ISA devices have port
> numbers above PIO_OFFSET. Also they don't have PCI.
> 
> arch/mips/Kconfig:      select GENERIC_IOMAP
> 
> This looks completely bogus because it sets PIO_RESERVED
> to 0 and always uses the mmio part of lib/iomap.c.
> 
> arch/powerpc/platforms/Kconfig: select GENERIC_IOMAP
> 
> This is only used for two platforms: cell and powernv,
> though on Cell it no longer does anything after the
> commit f4981a00636 ("powerpc: Remove the celleb support");
> I think the entire io_workarounds code now be folded
> back into spider_pci.c if we wanted to.
> 
> The PowerNV LPC support does seem to still rely on it.
> This tries to do the exact same thing as lib/logic_pio.c
> for Huawei arm64 servers. I suspect that neither of them
> does it entirely correctly since the powerpc side appears
> to just override any non-LPC PIO support while the arm64
> side is missing the ioread/iowrite support.
> 
>       Arnd
> 

