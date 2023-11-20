Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4315B7F0B10
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjKTDf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjKTDf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:35:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3A6AA
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 19:35:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A64C433C8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700451354;
        bh=62lRMD43jjAKjDzraj2ZVEWyz4K9K7STu+VjEnu4DJk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sB8jmsaenxaQSZtTnEZhkNerXZATf+rVxpKOLUwpsTswT10G+JSMumZkBKND6uKv0
         PXj9CITTz6fNPvlwmaPvBOYfg7L2ZfgGG1hGr1+MFmeWHXTPQT5SXQ327vjIKsMeve
         wPHhq+QzhxuyZpolzmrMhp3uxO083zodSWQt4DfYZXieNO/6YSEEAHuZgaUPX8I5Kz
         +v5AxoXgGNeQLCwJN7GH/jJWR65nBMUiq8qn9FVRcqZrQO3KTj64QiIPIMZUmnlXll
         WuBPQxxxYnrUUi5z90LNPZXyj7RIM3iXzVFeNoEToMQpOindvc9cLa0czfSPcnYIxe
         Yl0/WoJEyyd0A==
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2809a824bbbso2607731a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 19:35:54 -0800 (PST)
X-Gm-Message-State: AOJu0YzILFUh47bm7VzcmX5fw6D+5amvCGKR2OdfHEYeWYWPqOATGO/e
        9IoqYMHOQTo2nfP86QPPgCrAs36MCoB0T9ieX7JRNg==
X-Google-Smtp-Source: AGHT+IFUvXLlhgsD7jLkOF1XQH8/mI72vbQ7j6Zc0xfO3seezj0akSl7BHHfUOPtPPKAo3HgVCPtqg4HDTyzUC2s1UQ=
X-Received: by 2002:a17:90a:191a:b0:27d:c95:b0ad with SMTP id
 26-20020a17090a191a00b0027d0c95b0admr4539183pjg.21.1700451353958; Sun, 19 Nov
 2023 19:35:53 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-2-ryncsn@gmail.com>
 <ZVp2UE+MqkifJG4B@casper.infradead.org>
In-Reply-To: <ZVp2UE+MqkifJG4B@casper.infradead.org>
From:   Chris Li <chrisl@kernel.org>
Date:   Sun, 19 Nov 2023 19:35:42 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOGUQNyZesw5BY3dfwBNhL6_RG_=tXc1ZQ4VRGRtGPuMw@mail.gmail.com>
Message-ID: <CAF8kJuOGUQNyZesw5BY3dfwBNhL6_RG_=tXc1ZQ4VRGRtGPuMw@mail.gmail.com>
Subject: Re: [PATCH 01/24] mm/swap: fix a potential undefined behavior issue
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kairui Song <kasong@tencent.com>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kairui,

On Sun, Nov 19, 2023 at 12:55=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Nov 20, 2023 at 03:47:17AM +0800, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > When folio is NULL, taking the address of its struct member is an
> > undefined behavior, the UB is caused by applying -> operator

I think dereferencing the NULL pointer is undefined behavior. There is
no dereferencing here. It is just pointer arithmetic of NULL pointers,
which is adding offset of page to the NULL pointer, you got NULL.

> > won't lead to a real issue, still better to fix it, also makes the
> > code less error-prone, when folio is NULL, page is also NULL,
> > instead of a meanless offset value.

I consider your reasoning is invalid. NULL pointer arithmetic should
be legal. This patch is not needed.

Chris
