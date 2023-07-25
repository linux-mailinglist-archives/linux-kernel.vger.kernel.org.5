Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D26762436
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjGYVRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGYVRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:17:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647D719AF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 14:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690319804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jvny8tbaTavW0op4gURn9SHKDxlvKs4/aOokPMfstnw=;
        b=HHmIa6pGGZyr+upPqEVQHcWDxQ3wS67+I5NeaIceBqcRnnz7OSs5wbt0FUaeb65gIgKa9n
        pfbS7PmlJdEZORcBS1Apd/oU+AeZEPxgWdKHbTM/02CesOzZB/CALrE3N3x2lMWMC8yp8A
        lJWlkUqXNpbT0no6E9wSIEn6pwo2OD4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-3T0vjqWuOVaxXKMg7O6veg-1; Tue, 25 Jul 2023 17:16:42 -0400
X-MC-Unique: 3T0vjqWuOVaxXKMg7O6veg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-403fc19a7a7so68440181cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 14:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690319802; x=1690924602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jvny8tbaTavW0op4gURn9SHKDxlvKs4/aOokPMfstnw=;
        b=YG+ASpyc4o0Oah4oDpuovXmDsx+WYOwVgFgk64NoSUjGJ4cjwPzz16TWdzIHy2B71h
         VXVZbezj6Z49GxaRdgAriYjnYPftvXfB9OsXR08upd6HB5hF/uCsy4x8hEMxu7rgyv/b
         E47Uuw7ecO4Fb++gCkoj8jVAY6WI1ybci9Hm863VbrC8METVTwS5Z6qL0sqkoiRhWhR/
         Oib1+UcqZyloOB0Ow5g4FVKNE7ZC9KCvoQDVtWNHXolzvR8PIlPyYXMojuPSsaNxOZfD
         oDSvDPCUT07+d9Z7y6PAloi1h1LHmhvQ/PgfkjRXmRNA0ROxxCTCXI22IRqhoxbNLc6s
         nV8Q==
X-Gm-Message-State: ABy/qLZEoBX7PUwcuZF2tzG5fEz+0+NOxWaMtqX6WGjul6Aa746mgclk
        gleuqqCMHCbPebfdM8M3zq3dwlHY+LqckbBaFJF7Oc7WcbEKFp5EJuC6rs6iJiuTylZTOIarS1g
        tfeK21QWFs8IqjR5eLEtrcrtuK9C3JEWXdvTFly4w
X-Received: by 2002:a05:622a:312:b0:403:b130:80b2 with SMTP id q18-20020a05622a031200b00403b13080b2mr165111qtw.12.1690319802031;
        Tue, 25 Jul 2023 14:16:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEgvP1H5ebRlKKFdIcdmET28+qqy3PgXwo2zcmSFDUklwgAlWu4odpsF1vohOHF+NvfRWiMvzDBst76mujbvng=
X-Received: by 2002:a05:622a:312:b0:403:b130:80b2 with SMTP id
 q18-20020a05622a031200b00403b13080b2mr165094qtw.12.1690319801797; Tue, 25 Jul
 2023 14:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230703135526.930004-1-npache@redhat.com> <c8bbc891-cd52-e34a-8ca7-76314e97cbe3@arm.com>
 <CAA1CXcBWuMgMbBTLj9eYzW4wBxbJpa3FGZsbtiibrYODZQdg6A@mail.gmail.com> <ZLQIaSMI74KpqsQQ@arm.com>
In-Reply-To: <ZLQIaSMI74KpqsQQ@arm.com>
From:   Nico Pache <npache@redhat.com>
Date:   Tue, 25 Jul 2023 15:16:15 -0600
Message-ID: <CAA1CXcDcddzEquSqsckZ3eDzQr7FhSxn1GfUiRS5KL4JRQbXjg@mail.gmail.com>
Subject: Re: [RFC] arm64: properly define SOFT_DIRTY for arm64
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aquini@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

Thanks for your reply.

From my understanding only two of the PBHA bits [60:59] are being used
for *_TABLE_<UXN|PXN>.

If that's the case is it safe to assume bits [63:61] are usable
(without considering OOT patches) and are treated similarly to the
software bits [58:55]? or do more considerations need to be made with
regards to using these bits?

There isnt much info in the codebase about PBHA, but from some
external research it seems the PBHA bits are intended to be used by
future SoC hardware but are currently not exposed to allow users to
use them for their intended purpose.

If you think this is a viable solution, I will go ahead and use bit 61
to implement a SOFTWARE_DIRTY bit. But if the goal is to inevitably
expose these bits to the hardware and allow them to use it, then
perhaps introducing this feature would be short lived.

Thanks,
-- Nico

On Sun, Jul 16, 2023 at 9:19=E2=80=AFAM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> (I noticed Mark already replied in another thread along the same lines)
>
> On Tue, Jul 04, 2023 at 06:08:59AM -0400, Nico Pache wrote:
> > Is it possible to add the same DBM check I'm using
> > (!arch_has_hw_pte_young) in these pte helper functions to only clear
> > it when DBM is not present?
>
> It's not possible since we don't have a way to encode a read-only +
> dirty PTE (e.g. after ptep_set_wrprotect()). The PTE_WRITE/PTE_DBM bit
> in the architecture only tells that the hardware is allowed to clear the
> PTE_RDONLY bit on a write access and that's what we consider hw-dirty.
> When a dirty/writeable PTE is made read-only, we clear PTE_WRITE, set
> PTE_RDONLY _and_ the software PTE_DIRTY bit.
>
> With the permission indirection extensions (PIE, see patches from Joey),
> PTE_RDONLY can be treated as a true !PTE_DIRTY bit but there's no
> hardware around yet.
>
> So if you need software dirty, it can only be done with another software
> PTE bit. The problem is that we are short of such bits (only one left if
> we move PTE_PROT_NONE to a different location). The userfaultfd people
> also want such bit.
>
> Personally I'd reuse the four PBHA bits but I keep hearing that they may
> be used with some out of tree patches.
>
> --
> Catalin
>

