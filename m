Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F357F759B95
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjGSQ4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjGSQ4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:56:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A171BF2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689785732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybZMnwXlmIEE0ADI9FsKUlcEynrHTdW2zV41y3cU4q8=;
        b=GywAJTHHLcxJVwUJVakntTMUsC9ImefzxWcs8ba2GGuU7mN0qPIBWmkS6OiMKea8ncFEmX
        GqmxHuyFFHDhYM5yhA6J+t4roOPPCnCIaXDkG4qsKtkkTzaNZ1kPGNB4hsHV+fZywytjKw
        m1nR9lV36gw3ZVAxhygmL3U5yVEGzxY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-5D0pByogNIGoACwDtMJDLw-1; Wed, 19 Jul 2023 12:55:30 -0400
X-MC-Unique: 5D0pByogNIGoACwDtMJDLw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5218b9647a8so2537559a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689785729; x=1692377729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybZMnwXlmIEE0ADI9FsKUlcEynrHTdW2zV41y3cU4q8=;
        b=WhRvB3iXQmbSBKtvyA0JJPOtiNRTvkduXBFJUrzpCFpVJQ4sROJIeasm1PSDM9Jkko
         fbj0jmivj7I3COW+DnV4fskdPGoZE2+3LMU4h6316X94LktBBFk7YkDTLNtHxQ5tspOy
         rICABapmSAD8Q8cn6FIywi53JCEq8s7n1SLfH6wdCXMjYC904+XLQadk0fTL3l59eic7
         VxufBJkNERC3iYYUg3/BuI0Kmdmc7hsKUBJSjH5IhbZLgiw/B+VMV1Fix/2i1ETMD+OB
         t60S8X7lnAKw8g9SK8yvusXB7bDDBc0ZkBr9BEhcbYZRoFaBDJgY1qcoWLgmpcew9Vw2
         ipnw==
X-Gm-Message-State: ABy/qLZ5GmW7pqETlQaMbEupqXdmrVH15lvLy4bJ4Xp+0oVk4VSMFhce
        Y38dn2xTYef3okuDBC9wHUcD5dfXX/79ksty+2cB47QG2EKZKVwO1MLPcrjOCuTrtZPH25PTFwN
        JMiiOdiEWYDGwNYzYQVP80AcE
X-Received: by 2002:aa7:df12:0:b0:51e:28e6:3838 with SMTP id c18-20020aa7df12000000b0051e28e63838mr2675095edy.17.1689785729747;
        Wed, 19 Jul 2023 09:55:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEE4qOGG9V7ZI8+WFW37awHpPD5aiip3zVhw1ks31Z/kpX3OD6eusNtSgp6OKt44xHjSBz/kg==
X-Received: by 2002:aa7:df12:0:b0:51e:28e6:3838 with SMTP id c18-20020aa7df12000000b0051e28e63838mr2675066edy.17.1689785729461;
        Wed, 19 Jul 2023 09:55:29 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id r18-20020aa7d592000000b0051df5eefa20sm2911736edq.76.2023.07.19.09.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 09:55:28 -0700 (PDT)
Message-ID: <711f74d6-fe15-6bd4-a9b9-c4f178d95bf3@redhat.com>
Date:   Wed, 19 Jul 2023 18:55:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v11 01/29] KVM: Wrap kvm_gfn_range.pte in a per-action
 union
To:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-2-seanjc@google.com>
Content-Language: en-US
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230718234512.1690985-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 01:44, Sean Christopherson wrote:
> +	BUILD_BUG_ON(sizeof(gfn_range.arg) != sizeof(gfn_range.arg.raw));
> +	BUILD_BUG_ON(sizeof(range->arg) != sizeof(range->arg.raw));

I think these should be static assertions near the definition of the 
structs.  However another possibility is to remove 'raw' and just assign 
the whole union.

Apart from this,

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> +	BUILD_BUG_ON(sizeof(gfn_range.arg) != sizeof(range->arg));


