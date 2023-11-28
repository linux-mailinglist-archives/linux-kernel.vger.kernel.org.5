Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F587FB9A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbjK1LuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344563AbjK1LuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:50:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18BED6D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:50:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78109C433CC;
        Tue, 28 Nov 2023 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701172214;
        bh=OCv5jOPu04qFPi6ssiG4av97RLxhHF1iTMxErUPuhxM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OjVTNoCngj8vhKQa4NLxoGYZGPzhnXiWZTtymJszXRp9aE5OHmasJdxQxtWYTb1lT
         x+1ii7lVkfaehoU9AwY17drmJlHGDUVjY7gb2ulMt29SnG31aIAXjY37IRjiHqrjRT
         3IyWZ8kl4uz0D3//4gXLGxipDqQnpzx9x+U9UdxJYrg2UWwtb4/ihKunSdFRHYuX+H
         D+x+WM+Y3GycueXKYJcj+GJCE306wYDXHxsJla04bHbSsmI8/Hi3Dnwyv/uDMfvytG
         1/2/evih98QpUNbii8Xkms+PQRMMYyODIGLBkHgdLmBJvtbqfJl+XYsK2hGEgkS/Gz
         iCU0/MZpgLXFA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2c9b8363683so3623011fa.3;
        Tue, 28 Nov 2023 03:50:14 -0800 (PST)
X-Gm-Message-State: AOJu0Yx5jqUbtgYW/G3SpJbJnB6Qtq2V+fGwottcRm1Yo2vFFcLjcjRQ
        2LEuHEgv7AKMUL6xWVigi1VERosYiMaVBvRxIrM=
X-Google-Smtp-Source: AGHT+IEcQ8JC8Crlu73uQLM9HlwZR3LZT0et+kEASrOblD8H6K4gVCHuT491KE4vEf9NtjRDaSpeS0lEVW4n7CQRei0=
X-Received: by 2002:a2e:7a0e:0:b0:2c9:b8e0:6e4c with SMTP id
 v14-20020a2e7a0e000000b002c9b8e06e4cmr434921ljc.49.1701172212628; Tue, 28 Nov
 2023 03:50:12 -0800 (PST)
MIME-Version: 1.0
References: <20231103151354.110636-1-michael.roth@amd.com> <30ff0335-3d9c-7d54-85d0-5898320f4e1f@suse.cz>
 <CAMj1kXF-B_1MJahfFg72cgcmZ9dMvqiEm8WGGejkqRFN=JreEA@mail.gmail.com> <9be0159e-1762-6c07-e6eb-a86f1c780118@suse.cz>
In-Reply-To: <9be0159e-1762-6c07-e6eb-a86f1c780118@suse.cz>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Nov 2023 12:50:01 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE65htEpXSL+h1X-zQ2RH4Oc193rac7=PBYMYJvEUBXNA@mail.gmail.com>
Message-ID: <CAMj1kXE65htEpXSL+h1X-zQ2RH4Oc193rac7=PBYMYJvEUBXNA@mail.gmail.com>
Subject: Re: [PATCH v2] efi/unaccepted: Fix off-by-one when checking for
 overlapping ranges
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Michael Roth <michael.roth@amd.com>, linux-efi@vger.kernel.org,
        x86@kernel.org, linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>, stable@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 at 12:25, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 11/8/23 12:21, Ard Biesheuvel wrote:
> > On Fri, 3 Nov 2023 at 16:30, Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >> On 11/3/23 16:13, Michael Roth wrote:
> >> > When a task needs to accept memory it will scan the accepting_list
> >> > to see if any ranges already being processed by other tasks overlap
> >> > with its range. Due to an off-by-one in the range comparisons, a task
> >> > might falsely determine that an overlapping range is being accepted,
> >> > leading to an unnecessary delay before it begins processing the range.
> >> >
> >> > Fix the off-by-one in the range comparison to prevent this and slightly
> >> > improve performance.
> >> >
> >> > Fixes: 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused by parallel memory acceptance")
> >> > Link: https://lore.kernel.org/linux-mm/20231101004523.vseyi5bezgfaht5i@amd.com/T/#me2eceb9906fcae5fe958b3fe88e41f920f8335b6
> >> > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> >>
> >> More justification for introducing a common ranges_overlap() helper somewhere :)
> >>
> >> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> >>
> >
> > Thanks, I'll take this as a fix.
>
> Ping, can't see it in mainline nor -next?
>

Apologies - queued up now.
