Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E287D854E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345363AbjJZOyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345343AbjJZOyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:54:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1D71B3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:54:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEDAC433C8;
        Thu, 26 Oct 2023 14:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1698332056;
        bh=3QlDzhYrf7P1UVluxNylKvOnHhMo0/dRhjHt5yfy+As=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=luu7O4Zpr91mxYh7wbxwsuSQMyINGvqbzvNM2OYDSLD7DOP9EhGEntc9OF6SE64Oe
         AlTASilQVbwkxfyTaXBvzyuZ1cFyhppoDgV8B/jtWUiMEus7FZKHdvZ2yBBmC4l5zh
         BNgWcKFYyQzA5EGlCoUNEXtbBxRjprIrkE8Pcxs0=
Date:   Thu, 26 Oct 2023 07:54:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH -fixes 0/2] Fix set_huge_pte_at()
Message-Id: <20231026075415.47c0a032906b604de08ed39b@linux-foundation.org>
In-Reply-To: <36aa1ec7-df13-4741-be09-c53a05f3d591@arm.com>
References: <20230928151846.8229-1-alexghiti@rivosinc.com>
        <305b4dec-c99d-3cee-4563-8d7dcbae9384@ghiti.fr>
        <20231003090443.67a2e2692b68211e05b53248@linux-foundation.org>
        <CAHVXubi5C0hBaXx5tqVHZAJSd1zvHRqoxUEkk9ZbmZ5mq2=mAw@mail.gmail.com>
        <20231026071300.e12dab3be1edd26007db85ee@linux-foundation.org>
        <32d9627c-821a-48f0-b430-0532a47b8699@ghiti.fr>
        <36aa1ec7-df13-4741-be09-c53a05f3d591@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 15:30:44 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> >>> Those fixes finally did not make it to 6.6, I was hoping for them to
> >>> land in -rc6 or -rc7: for the future, what should have I done to avoid
> >>> that?
> >> They're merged in Linus's tree.
> >>
> >> 6f1bace9a9fb arm64: hugetlb: fix set_huge_pte_at() to work with all swap entries
> >> 935d4f0c6dc8 mm: hugetlb: add huge page size param to set_huge_pte_at()
> > 
> > 
> > Oops, sorry, I missed them this morning!
> 
> Those two patches that Andrew highlights are the fix I did for arm64. Weren't
> you referring to the corresponding patches you did for riscv, Alex?

These are in mainline:

1de195dd0e05 riscv: fix set_huge_pte_at() for NAPOT mappings when a swap entry is set
117b1bb0cbc7 riscv: handle VM_FAULT_[HWPOISON|HWPOISON_LARGE] faults instead of panicking

I'm not sure what happened to your "riscv: hugetlb: convert
set_huge_pte_at() to take vma" - perhaps it was updated.
