Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440707DD46E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346805AbjJaRNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344282AbjJaRNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:13:48 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E237583;
        Tue, 31 Oct 2023 10:13:44 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id C44DB191591;
        Tue, 31 Oct 2023 18:13:41 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1698772422; bh=C/t7JNbhwzhQJdikrhIXlx5gMjFw0DReJg6ztbL++WE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=10IxAPzwMrq3fzyjn4Yy6eS4qfHbdYe7IRNZD0mpwOaTnGxoXCEtc9ovUmA7qKQxa
         bILAujyYSUj57eWgAG/0SlZrDFFKCgZl6tARb9KmUFuX464LuQYJ2vbC8vXF6+KRdN
         /BtOHZ6k++amm6wcBek7W7vrMz1OKy0GYuefG5D+ti+4JYdzQWOp5Ukrci28V0z24x
         m4dE7HMPfdDSU4IzTHej7S3IHGjRGyWnkLdjQbkJmA5rESgGAeXuU6AaOtcNJceHG9
         aMHmEcmX6fyKBj0FVnOkIg+9RzOfAG6Q/5FiIo4khDTB3cnJrSMyOS2figrBY9Itqw
         2TO625KybgXsA==
Date:   Tue, 31 Oct 2023 18:13:40 +0100
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Lutomirski, Andy" <luto@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "hch@lst.de" <hch@lst.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 04/10] swiotlb: Use free_decrypted_pages()
Message-ID: <20231031181340.30233c17@meshulam.tesarici.cz>
In-Reply-To: <c0233c531965a69ffb55210ace6a8a9d0f844e74.camel@intel.com>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
        <20231017202505.340906-5-rick.p.edgecombe@intel.com>
        <20231031114316.0bfa8d91@meshulam.tesarici.cz>
        <c0233c531965a69ffb55210ace6a8a9d0f844e74.camel@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023 15:54:52 +0000
"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> wrote:

> On Tue, 2023-10-31 at 11:43 +0100, Petr Tesa=C5=99=C3=ADk wrote:
> >=20
> > I admit I'm not familiar with the encryption/decryption API, but if a
> > __free_pages() is not sufficient here, then it is quite confusing.
> > The error label is reached only if set_memory_decrypted() returns
> > non-zero. My naive expectation is that the memory is *not* decrypted
> > in
> > that case and does not require special treatment. Is this assumption
> > wrong? =20
>=20
> Yea, the memory can still be decrypted, or partially decrypted.=C2=A0On x=
86,
> all the set_memory() calls can fail part way through the work, and they
> don't rollback the changes they had made up to that point.

Thank you for the explanation. So, after set_memory_decrypted() fails,
the pages become Schroedinger-crypted, but since its true state cannot
be observed by the guest kernel, it stays as such forever.

Sweet.

>[...]
> > OTOH I believe there is a bug in the logic. The subsequent
> > __free_pages() in swiotlb_alloc_tlb() would have to be changed to a
> > free_decrypted_pages(). However, I'm proposing a different approach
> > to
> > address the latter issue here:
> >=20
> > https://lore.kernel.org/linux-iommu/20231026095123.222-1-petrtesarik@hu=
aweicloud.com/T/ =20
>=20
> Oh, yes, that makes sense. I was planning to send a patch to just leak
> the pages if set_memory_decrypted() fails, after my v2 linked above is
> accepted. It could have a different label than the phys_limit check
> error path added in your linked patch, so that case would still free
> the perfectly fine encrypted pages.

Hm, should I incorporate this knowledge into a v2 of my patch and
address both issues?

Petr T
