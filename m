Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556A77E01EC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346862AbjKCKl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjKCKlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB2FD4B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 03:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699008062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=Lp6Jz+POVOM2ymATN0+4roKlcGz/gu2UjTswWR4Ytbw=;
        b=cRg4+PCqqSlOE2s/8+SbHCWChJ/PgzTXRoLzGH2VKsxlFbC6nK51LMuzcKpx7+fFQ85SE9
        ZqdCL60k0CdCxvgpyvUtNst78QeZG6G9eFzeg/QI6b37gEj2F0Veh//aj0hpgG1tnhl+/z
        GKWyOQ93PVAwx6y1OyziDH2saneefoY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-4L2D5j_RP4ei0doGh-MZ8A-1; Fri, 03 Nov 2023 06:41:00 -0400
X-MC-Unique: 4L2D5j_RP4ei0doGh-MZ8A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c15543088aso220446566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 03:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699008060; x=1699612860;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lp6Jz+POVOM2ymATN0+4roKlcGz/gu2UjTswWR4Ytbw=;
        b=k/1fM/vr3yz3kDX2xEXdMZPAZ6HfDAN9HrkSnRIYxFzdjSDdcjSuc1eN956RNRc3H0
         Ii4oRFEyE2ojgjxsBKYIgFJwojGuknneHcdWlBALHaeFXn1bxuAQNkyvU6j+ezcKVBq9
         rCHQGwruWWcPqQr0MjZXn1oAT33rLeP0FMQYZtrLwturj8eTfF8Ondo+jH1/fWhepqD0
         ivdhv2ZLhLdpbN4NA+BmMnMsC7eSUTbrR6AnMg41igb7BRxfdDwsBZDO9xLaGw9A0fe1
         nkxacsTb5SpuS8gJVTEPInPr6gVq2PliZOqIN5fjfR3pMDVkI0MQRAf+omF0fso1yv8g
         DRaw==
X-Gm-Message-State: AOJu0YyYWm4HlG07GvAIH9ZioC0XB6dSLpiv9Nq/PbE9ENTkNGraFZdd
        8tFrvRkdoymSf8hFtGeB4q1I2ecrdDTJIjU3vIwQFB6Nqe1SCd9DBbuQWVP/U9CJB9+LEpRWcaf
        4PrUTlLrBRFb9w1CN26ZdrU55
X-Received: by 2002:a17:906:7950:b0:9bf:c00f:654a with SMTP id l16-20020a170906795000b009bfc00f654amr2302817ejo.24.1699008059853;
        Fri, 03 Nov 2023 03:40:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYL84kQ58i2cP4K6S7xeuKGH18ZQ7RIKhzKbyX3E6c1jOpr4P+mCWZM0GIPaXqH2aak15cSg==
X-Received: by 2002:a17:906:7950:b0:9bf:c00f:654a with SMTP id l16-20020a170906795000b009bfc00f654amr2302775ejo.24.1699008059454;
        Fri, 03 Nov 2023 03:40:59 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:4783:a68:c1ee:15c5? ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
        by smtp.googlemail.com with ESMTPSA id g4-20020a170906394400b009a5f1d15644sm754493eje.119.2023.11.03.03.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 03:40:58 -0700 (PDT)
Message-ID: <e39a8f6e-c98d-4873-aa3f-2e566dead5c5@redhat.com>
Date:   Fri, 3 Nov 2023 11:40:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 15/35] fs: Export anon_inode_getfile_secure() for use
 by KVM
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        David Matlack <dmatlack@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?= =?UTF-8?Q?n?= <mic@digikod.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20231027182217.3615211-1-seanjc@google.com>
 <20231027182217.3615211-16-seanjc@google.com>
 <20231102-freihalten-vorsah-fdd68051b005@brauner>
From:   Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20231102-freihalten-vorsah-fdd68051b005@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/23 17:24, Christian Brauner wrote:
> On Fri, Oct 27, 2023 at 11:21:57AM -0700, Sean Christopherson wrote:
>> Export anon_inode_getfile_secure() so that it can be used by KVM to create
>> and manage file-based guest memory without need a fullblow filesystem.
>> The "standard" anon_inode_getfd() doesn't work for KVM's use case as KVM
>> needs a unique inode for each file, e.g. to be able to independently
>> manage the size and lifecycle of a given file.
>>
>> Note, KVM doesn't need a "secure" version, just unique inodes, i.e. ignore
>> the name.
>>
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> ---
> 
> Before we enshrine this misleading name let's rename this to:
> 
> create_anon_inode_getfile()
> 
> I don't claim it's a great name but it's better than *_secure() which is
> very confusing. So just:
> 
> struct file *create_anon_inode_getfile(const char *name,
>                                         const struct file_operations *fops,
>                                         void *priv, int flags)

I slightly prefer anon_inode_create_getfile(); grepping include/linux 
for '\<create_' vs '_create_' shows that this is much more common.

Neither userfaultfd (which uses anon_inode_getfd_secure()) nor io_uring 
strictly speaking need separate inodes; they do want the call to 
inode_init_security_anon().  But I agree that the new name is better and 
I will adjust the comments so that it is clear why you'd use this 
function instead of anon_inode_get{file,fd}().

> May also just remove that context_inode argument from the exported
> function. The only other caller is io_uring. And neither it nor this
> patchset need the context_inode thing afaict.

True, OTOH we might as well rename anon_inode_getfd_secure() to 
anon_inode_create_getfd(), and that one does need context_inode.

I'll Cc you on v14 and will carry the patch in my tree.

Paolo

> Merge conflict risk is
> extremely low so carrying that as part of this patchset is fine and
> shouldn't cause huge issues for you.
> 

