Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E6E7FFD89
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376904AbjK3VbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjK3Va7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:30:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D7A1B4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701379864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CRU7CkycS7SUcJkoz0E93L3cEZtHoI2nxjtl0XDIHtI=;
        b=MNyXjOeYCMi3d7PY+Iothk1aqIuuHcepB5STzcFYou6yGJl3AhqVaMOT+D2SRA0Xz2oQqi
        1QgecfId4m4nuWaHcH10T4AFGlPHkD/Or6k0Y5gW8LbMNTJeeuIo8W8GZGzwA7CWlf5x2Z
        3Q5Jsii1af4934f8BwxOyNkO13UehCQ=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-Yyff1DwLMTKsruloLPnCSQ-1; Thu, 30 Nov 2023 16:31:03 -0500
X-MC-Unique: Yyff1DwLMTKsruloLPnCSQ-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1fa8e147acdso453530fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701379862; x=1701984662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRU7CkycS7SUcJkoz0E93L3cEZtHoI2nxjtl0XDIHtI=;
        b=XqPhhMEeLQobuUD1BmQrA6zG31aYqX3BDz0Cghl/JXPzJnw0UM91rYpWXuKQJw7901
         Fswybt1q0H0NZRbgd1PjgWfPMSgewSr2gUPIfRB0rzg7mS3HFhyPksnk4Ucu/EDXgvnl
         47zpwvSNZGb+RjfBgE7Zo8Xe1Ualxs5RHLyEmVwp1jIFGNeVVbLGfF4b4FhD7O1JyTv/
         MNHHjqvnxWEzJaf4F6WDXKltG2ZGfztPFtVorBljQTOKg5OBhGT1Ljc1PEWK76aqO+Gb
         OYJFlOimqUsfXqCx5a1We7uCv8sNzZRQY28RlBDwq/wg9tI7QyXNlo5/HtIfFizYX6BP
         8esw==
X-Gm-Message-State: AOJu0Yznx6d8D5NBv+Bw5W7Zrgk1b7qbCdz4QpXwGEUO8g4haXNoJ1Od
        phNiNCGea16xm8a40D2KKmqYszzI6Ky0r4ayfQBKeIil+Aswv3Wc0gv5w4X8IqBUKbuUYVFfKCl
        jW3DMTwG0a27q8c0VgS0IL/Mf1G/Nm01x
X-Received: by 2002:a05:6871:89f:b0:1fa:25e7:380c with SMTP id r31-20020a056871089f00b001fa25e7380cmr3376645oaq.4.1701379862197;
        Thu, 30 Nov 2023 13:31:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/wrmZb1Pj0VJ3a4ZBfX7FQO3l+DqTcZEmdXOZXRg9ok8MvraDC5X1akCfH4y0bxaGhg1yPw==
X-Received: by 2002:a05:6871:89f:b0:1fa:25e7:380c with SMTP id r31-20020a056871089f00b001fa25e7380cmr3376607oaq.4.1701379861914;
        Thu, 30 Nov 2023 13:31:01 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id b19-20020ac87553000000b00423b8a53641sm842916qtr.29.2023.11.30.13.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:31:01 -0800 (PST)
Date:   Thu, 30 Nov 2023 16:30:58 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH RFC 06/12] mm/gup: Drop folio_fast_pin_allowed() in
 hugepd processing
Message-ID: <ZWj_EgljG3NwS5r1@x1n>
References: <20231116012908.392077-7-peterx@redhat.com>
 <ZVsYMMJpmFV2T/Zc@infradead.org>
 <ZVzT5_3Zn-Y-6xth@x1n>
 <ZV21GCbG48nTLDzn@infradead.org>
 <ZV90JcnQ1RGud/0R@casper.infradead.org>
 <ZV-KQ0e0y9BTsHGv@x1n>
 <d2313c1d-1e50-49b7-bed7-840431af799a@arm.com>
 <ZV-sJsdFfXiCkylv@x1n>
 <510adc26-9aed-4745-8807-dba071fadbbe@arm.com>
 <ZWDKV0XNjplc_vUP@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWDKV0XNjplc_vUP@x1n>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 11:07:51AM -0500, Peter Xu wrote:
> On Fri, Nov 24, 2023 at 09:06:01AM +0000, Ryan Roberts wrote:
> > I don't have any micro-benchmarks for GUP though, if that's your question. Is
> > there an easy-to-use test I can run to get some numbers? I'd be happy to try it out.
> 
> Thanks Ryan.  Then nothing is needed to be tested if gup is not yet touched
> from your side, afaict.  I'll see whether I can provide some rough numbers
> instead in the next post (I'll probably only be able to test it in a VM,
> though, but hopefully that should still reflect mostly the truth).

An update: I finished a round of 64K cont_pte test, in the slow gup micro
benchmark I see ~15% perf degrade with this patchset applied on a VM on top
of Apple M1.

Frankly that's even less than I expected, considering not only how slow gup
THP used to be, but also on the fact that that's a tight loop over slow
gup, which in normal cases shouldn't happen: "present" ptes normally goes
to fast-gup, while !present goes into a fault following it.  I assume
that's why nobody cared slow gup for THP before.  I think adding cont_pte
support shouldn't be very hard, but that will include making cont_pte idea
global just for arm64 and riscv Svnapot.

The current plan is I'll add that performance number into my commit message
only, as I don't ever expect any real workload will regress with it.  Maybe
a global cont_pte api will be needed at some point, but perhaps not yet
feel strongly for this use case.

Please feel free to raise any concerns otherwise.

Thanks,

-- 
Peter Xu

