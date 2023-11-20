Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5EE7F1A38
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbjKTRel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjKTReg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:34:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEFDBE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:34:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0F9C433C7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 17:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700501672;
        bh=l5y25bSfyuTDCqjIuzPL1MkOl4MXmmQUXlmyQFMQjLY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tyVraxvY2BEJuhXBKZKHI/OF3kkdyJl/Besik/yWhboY3Gtj9Y8jeKsTTZO7eK7Qm
         XEM9TqDQTDt2C0X6uhfxm3eFgeLfGNxdOehskE8OFRF20DoEEc8dwC918SkB2fv90q
         KkQd66d38c+vJHjouWPX6sQQtq2IV4GB7vmBtabJbl6jmitpAdu6Gu104Azjr6Eeou
         /ZkpDTWlDPZ2WpgZpZ456gNPVb8IfBF7KpTr91lgpdp1ioc8DCL2e7pNA4ONHMARXN
         pj+QVYIn6fRD/EIy2YWAU3dpW0y0qWxZEV2VshBJdaQgTOi3wzODSO6Xb96wDq08Ds
         fntl/0Hqqz+FA==
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28120aa1c24so3126142a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:34:32 -0800 (PST)
X-Gm-Message-State: AOJu0Yx4LNAFPrDkHDWgYtkRBDdLF9rKD2M/ztn1T/kS2J06NfMGlyyR
        gFdUXwgthBXTlv6mdgFrKUNmkRePmGJIv+7zQA9Enw==
X-Google-Smtp-Source: AGHT+IGbynMZguQy1gy1l9Y2sMFDwbH47UZLvGUcle97Eq9G4RDIUluKrlugmvhWTvoAQYdOJDqFnBHVtYAVMpa4Brw=
X-Received: by 2002:a17:90b:1b4f:b0:281:1c2e:9e6a with SMTP id
 nv15-20020a17090b1b4f00b002811c2e9e6amr5676311pjb.39.1700501671895; Mon, 20
 Nov 2023 09:34:31 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-2-ryncsn@gmail.com>
 <ZVp2UE+MqkifJG4B@casper.infradead.org> <CAF8kJuOGUQNyZesw5BY3dfwBNhL6_RG_=tXc1ZQ4VRGRtGPuMw@mail.gmail.com>
 <CAMgjq7CO_9tXfwd2at-tT+O_JU-NGoG=9OWcqwkc9M3iL1Ga1A@mail.gmail.com>
In-Reply-To: <CAMgjq7CO_9tXfwd2at-tT+O_JU-NGoG=9OWcqwkc9M3iL1Ga1A@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Mon, 20 Nov 2023 09:34:20 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNFAaUj0rx=vWWZjNaKzDKj1J2-i-SJUhnZjd1KDtx0eg@mail.gmail.com>
Message-ID: <CAF8kJuNFAaUj0rx=vWWZjNaKzDKj1J2-i-SJUhnZjd1KDtx0eg@mail.gmail.com>
Subject: Re: [PATCH 01/24] mm/swap: fix a potential undefined behavior issue
To:     Kairui Song <ryncsn@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
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

On Mon, Nov 20, 2023 at 3:15=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
> > Chris
>
> Hi, Chris and Matthew.
>
> Thanks for the comments.
>
> Right, it's just a language syntax level thing, since "->" have a
> higher priority, so in the syntax level it is doing a member access
> first, then take the address. By C definition  member access should
> not happen if the object is invalid (NULL). Only a hypothesis problem
> on paper...

The dereference only shows up in the abstract syntax tree level.
According to the C standard there are expansion and evaluation phases
after that. At the evaluation phase the dereference will turn into
pointer arithmetic. Per my understanding, the dereference never
actually happens, due to the evaluation rules, not even in theory.

> This is indeed not needed since in reality it's just pointer
> arithmetic. I'm OK dropping this.

Thanks

Chris
