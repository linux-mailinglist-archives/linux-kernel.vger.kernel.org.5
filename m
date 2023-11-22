Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71617F51F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjKVU5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjKVU5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:57:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBC91B6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:57:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A41AC43391
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 20:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700686650;
        bh=7HrNNwCQeYg//1wXfdONZGPlZPj4fJmEJbfhUw7Kkxc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XuXcikeA33Q/gWnu28IA8nuMw00BMbt1MiE+s5+0GkVvA8mYBFnbLs2cNt7FHmkQl
         o/HsgtRjSt6yvQA9iBmWoN1GGLB7cBibVRM8g5ZPQARuxZTKptTB5IwRmo9ygsfkJW
         +LXFK2csxvO1YK1pymiLc0qSR50ejKIuesyNQ0vG14Gt7y6+qbxW1Q4s4IYUKP+onn
         2O8vX9zJYSuWk2KzWmkgflTex0LJ9bMhNqcs8wVfX9eY+dTBYaTybjuuzfXPraNW86
         62Dct+3HkDIxkzfC6amhUkWQDFyiaOXirmiZiHK5buIW+AjFJ9bViZeYXmktshuwyd
         SYOsBfAcC1otg==
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso134760a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:57:30 -0800 (PST)
X-Gm-Message-State: AOJu0YwrMh0tFtiqfi5JqjV6V/grnZzYc2PzPZF9hVbzLaqUTHTWhuwg
        X25vuCjgvnIHkMcuo9ulZiCcXn8LGeNLlM5fc81W6w==
X-Google-Smtp-Source: AGHT+IFiijhA01TJBJCiU8uJ8BY9AkxHJlZ982j8yRZgJVXgFkxBtLfdID5bMz4YhZXoZIwOfNEZsF4Lfko9ol3wOkg=
X-Received: by 2002:a17:90b:1b46:b0:280:6e68:a5a8 with SMTP id
 nv6-20020a17090b1b4600b002806e68a5a8mr3740315pjb.22.1700686649843; Wed, 22
 Nov 2023 12:57:29 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-5-ryncsn@gmail.com>
 <CAF8kJuNbcvwmojMB2Vp2LjTBxZtKFO_Zng4TODqADxmNPn2kCg@mail.gmail.com>
 <CAMgjq7D_OJiaNPWquFqxk5DKZXqoUMrD7Y_CRM7D0RnRnHmW7Q@mail.gmail.com>
 <CAF8kJuOzXAy8Er_knD0hi60Tb+XDMrijg-W83KD=Zdjqbu1Dmw@mail.gmail.com> <CAMgjq7DNVkyhwyXz9PRcp3XTBNvznZ97dOFFA_DGsJks12_pQw@mail.gmail.com>
In-Reply-To: <CAMgjq7DNVkyhwyXz9PRcp3XTBNvznZ97dOFFA_DGsJks12_pQw@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Wed, 22 Nov 2023 12:57:18 -0800
X-Gmail-Original-Message-ID: <CAF8kJuM05apUTd9Mpv6s4sZ6SfSAWD+hM_KLiDfatoXu5QwFbg@mail.gmail.com>
Message-ID: <CAF8kJuM05apUTd9Mpv6s4sZ6SfSAWD+hM_KLiDfatoXu5QwFbg@mail.gmail.com>
Subject: Re: [PATCH 04/24] mm/swap: avoid setting page lock bit and doing
 extra unlock check
To:     Kairui Song <ryncsn@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kairui,

On Wed, Nov 22, 2023 at 9:33=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:

> > There are two different charges. Memcg charging and memcg swapin chargi=
ng.
> > The folio_put will do the memcg discharge, the corresponding memcg
> > charge is in follio allocation.
>
> Hi Chris,
>
> I didn't get your idea here... By "memcg swapin charge", do you mean
> "memory.swap.*"? And "memcg charging" means "memory.*"?. There is no

Sorry I should have used the function name then there is no ambiguity.
"memcg swapin charge" I mean function mem_cgroup_swapin_charge_folio().
This function will look up the swap entry and find the memcg by swap entry =
then
charge to that memcg.

> memcg charge related code in folio allocation (alloc_pages_mpol),
> actually the mem_cgroup_swapin_charge_folio here is doing memcg charge
> not memcg swapin charge. Swapin path actually need to uncharge
> "memory.swap" by mem_cgroup_swapin_uncharge_swap in later part of this
> function.

I still think you have a bug there.

Take this make up example:
Let say the for loop runs 3 times and the 3rd time breaks out the for loop.
The original code will call:
filemap_get_folio() 3 times
folio_put() 2 times
mem_cgroup_swapin_charge_folio() 1 time.

With your patch, it will call:
filemap_get_folio() 3 times
folio_put() 2 times
mem_cgroup_swapin_charge_folio() 3 times.

Do you see the behavior difference there?

Chris
