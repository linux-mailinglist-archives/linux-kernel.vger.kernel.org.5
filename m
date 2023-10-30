Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4917DBF1B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjJ3RhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjJ3RhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D65AB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698687374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=3jYLwfXXzRbH81zwo7MCV6nGPuDVHVRPsAgIWckITik=;
        b=IcA+ZLnpKQJpkCRGDeb33JEkCn0qNxsf+T38lWM+J1FdtxfUv3d9OgweJu6+CVjKyNkrdb
        xFUFoD42L/cV+VNMIP9EugPeJNCCu6ePeotPp/6SdlzGexxjJrJaQcjpo4kSnAW0weezRq
        9i8t5ffjdsjeJr6mTv6hFVPs4mNBzpg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-D9Aa9STPNhGHBmARhcvkZQ-1; Mon, 30 Oct 2023 13:36:13 -0400
X-MC-Unique: D9Aa9STPNhGHBmARhcvkZQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32f8c4b74f7so461006f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698687372; x=1699292172;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jYLwfXXzRbH81zwo7MCV6nGPuDVHVRPsAgIWckITik=;
        b=RrCyksY2LZpEPBbuhpw5G17+2elcWxy13QUzi5fuiLSsF/Nkb3WfOBzpb4F0zFkPl8
         MWpGMe8NrOpxgVFll1lmWEV1N0LUUXpcw7zC0zoYx8o5WrF9ruHluNwNPerRfELjFyN+
         ufR98jdfxLppEY5m55JEg6mscXamY7xdZCXzLcIijRdgQP053roTmhQ//RkhUH20kX9P
         nAy+PXX4ZhihpUeFylJgADKbvA25AiE3YdDNZY6CLtDwzZj62FCCiriNNf/gLWkulqbl
         lJ4Q3YDCOJwyKFS9Dq+2MR90dJqwvmSlF128ZbXkC1xfTNij9Mo8pig+2xL7CVjKqxu8
         3BCw==
X-Gm-Message-State: AOJu0YyytgGKxXlUxe6+kp1EyI2eZWvrJFtMBjGD17QJ8p7cC98Nmt1/
        UfATN/7O8WBVdxuiyj7nThD2xsZB/guQWU/OWl7l+P9cX60EQB1upKjwhQLJc1y6Bsk/cRX3MoW
        S9IMBNF3NpMR5+BYrKWA2kIYQ
X-Received: by 2002:adf:ec4f:0:b0:32d:8357:42dd with SMTP id w15-20020adfec4f000000b0032d835742ddmr6883258wrn.68.1698687371993;
        Mon, 30 Oct 2023 10:36:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEboAELdFqaoOZREgnEhsC/lbRki6/0Jdh0l66f6RUru0wLk22AqSmUMVbSPZpU1ZFwEkh2hA==
X-Received: by 2002:adf:ec4f:0:b0:32d:8357:42dd with SMTP id w15-20020adfec4f000000b0032d835742ddmr6883233wrn.68.1698687371568;
        Mon, 30 Oct 2023 10:36:11 -0700 (PDT)
Received: from [192.168.1.174] ([151.81.68.207])
        by smtp.googlemail.com with ESMTPSA id p14-20020a5d68ce000000b003253523d767sm8703507wrw.109.2023.10.30.10.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 10:36:10 -0700 (PDT)
Message-ID: <a56e499f-c91c-45da-b404-444c22b2df24@redhat.com>
Date:   Mon, 30 Oct 2023 18:36:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 23/35] KVM: x86: Add support for "protected VMs" that
 can utilize private memory
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
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
 <20231027182217.3615211-24-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20231027182217.3615211-24-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/23 20:22, Sean Christopherson wrote:
> Add a new x86 VM type, KVM_X86_SW_PROTECTED_VM, to serve as a development
> and testing vehicle for Confidential (CoCo) VMs, and potentially to even
> become a "real" product in the distant future, e.g. a la pKVM.
> 
> The private memory support in KVM x86 is aimed at AMD's SEV-SNP and
> Intel's TDX, but those technologies are extremely complex (understatement),
> difficult to debug, don't support running as nested guests, and require
> hardware that's isn't universally accessible.  I.e. relying SEV-SNP or TDX
> for maintaining guest private memory isn't a realistic option.
> 
> At the very least, KVM_X86_SW_PROTECTED_VM will enable a variety of
> selftests for guest_memfd and private memory support without requiring
> unique hardware.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

with one nit:

> +---------------------
> +
> +:Capability: KVM_CAP_MEMORY_ATTRIBUTES
> +:Architectures: x86
> +:Type: system ioctl
> +
> +This capability returns a bitmap of support VM types.  The 1-setting of bit @n

s/support/supported/

Paolo

