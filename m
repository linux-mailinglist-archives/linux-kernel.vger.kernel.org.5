Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D5A758222
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjGRQb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjGRQbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:31:52 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE16710D2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:31:48 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40371070eb7so307771cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689697908; x=1692289908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kWSufgbF1ilR3fnCaYRUv7EJnoFqqfNMPgZ+JW0ixk=;
        b=qWMmdb1E6ct3nyLRQ4Dr0bILS6voMnjBKxj6MHT6b1nDURVcmuc5iYkhR3eZi3wnvd
         POzO4mix2uXRz9lNt1Uz3bMvFUeAnaWeVLKxnxWBia2c5MEzDpx9JmghgldbI4ZpxrFh
         n1DMSdzFsgTS4iySvf+Zu/7ptONCXUvwqOISGRpc3w+euwnC/+kC5+tTzluT9NoQxr6F
         /KfLeDcambEhPlmxuhbPlnfHLEDFVq4TMNcpXIl7H0m9IvfcKdps8Gl1HDK5DYXH9KUc
         y3ZxkzVXtWSt7PYDVFWedwLxid/Y/bmPmqme4fp5bXpXOsTIOn/fIlcf7vLzz8KFl8J/
         WTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689697908; x=1692289908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kWSufgbF1ilR3fnCaYRUv7EJnoFqqfNMPgZ+JW0ixk=;
        b=iZrt9BRgjr43Fu22v2mc6qWpwUYyc/VEUPpVfnqLCu9IcHWiAXt+9nFYTlOs6jHOCF
         tWNcj7CvglV0OyxMQpsPC2uqnctiV+GV7o9z4XVqYvVNmYWkWQGFeXLD2MaBa0HSHvmw
         BqggCU5vJi2nvQ8Gjr9+wwmJeswygNSY07vDrKWFdRn9yIAQh81J177iA5KM2ec92kPF
         ykm8iNuHX/xbJrinVf9qQe6oA1X8ML0wg1zpUKWOhDge5gVxtySRifv2NCMJ3EozCbXf
         xghjmXNssu+pwF3jfQhzaH+FeLNWkcJxkr8/qcAHpIRjOq9uxeURYkTAu4y6uSybJISX
         4Stw==
X-Gm-Message-State: ABy/qLbCQkhow/1+/5DdStfM3vH4HxLd0/Pf1ttPrg9EBTQr6OLDSvfQ
        tGGpIIgUFFo1XqfuttNLz/rJWscQnqGvpBMIjEVeWMjfIlB7l4Mrmf0=
X-Google-Smtp-Source: APBJJlG9moMaK1J+MXKKSahhbk3tCuAAQsqhf19T+KELPMPI/xtqKKqqfvD/YeMcU02hEDP1YsRLExeVOM374H7jf1Y=
X-Received: by 2002:a05:622a:1009:b0:403:b3ab:393e with SMTP id
 d9-20020a05622a100900b00403b3ab393emr309945qte.18.1689697907796; Tue, 18 Jul
 2023 09:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230718004942.113174-1-mike.kravetz@oracle.com> <20230718004942.113174-3-mike.kravetz@oracle.com>
In-Reply-To: <20230718004942.113174-3-mike.kravetz@oracle.com>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 18 Jul 2023 09:31:11 -0700
Message-ID: <CADrL8HVfBCmNYL5pM_LyHQNWyvihK=_GFnbtWB0tpTuLgiDybw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hugetlb: optimize update_and_free_pages_bulk to
 avoid lock cycles
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jiaqi Yan <jiaqiyan@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 5:50=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.c=
om> wrote:
>
> update_and_free_pages_bulk is designed to free a list of hugetlb pages
> back to their associated lower level allocators.  This may require
> allocating vmemmmap pages associated with each hugetlb page.  The
> hugetlb page destructor must be changed before pages are freed to lower
> level allocators.  However, the destructor must be changed under the
> hugetlb lock.  This means there is potentially one lock cycle per page.
>
> Minimize the number of lock cycles in update_and_free_pages_bulk by:
> 1) allocating necessary vmemmap for all hugetlb pages on the list
> 2) take hugetlb lock and clear destructor for all pages on the list
> 3) free all pages on list back to low level allocators
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4a910121a647..e6b780291539 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1856,13 +1856,43 @@ static void update_and_free_hugetlb_folio(struct =
hstate *h, struct folio *folio,
>  static void update_and_free_pages_bulk(struct hstate *h, struct list_hea=
d *list)
>  {
>         struct page *page, *t_page;
> -       struct folio *folio;
> +       bool clear_dtor =3D false;
>
> +       /*
> +        * First allocate required vmemmmap for all pages on list.  If vm=
emmap
> +        * can not be allocated, we can not free page to lower level allo=
cator,
> +        * so add back as hugetlb surplus page.
> +        */
>         list_for_each_entry_safe(page, t_page, list, lru) {
> -               folio =3D page_folio(page);
> -               update_and_free_hugetlb_folio(h, folio, false);
> -               cond_resched();
> +               if (HPageVmemmapOptimized(page)) {
> +                       if (hugetlb_vmemmap_restore(h, page)) {
> +                               spin_lock_irq(&hugetlb_lock);
> +                               add_hugetlb_folio(h, page_folio(page), tr=
ue);
> +                               spin_unlock_irq(&hugetlb_lock);
> +                       } else
> +                               clear_dtor =3D true;
> +                       cond_resched();
> +               }
> +       }
> +
> +       /*
> +        * If vmemmmap allocation performed above, then take lock to clea=
r

s/vmemmmap/vmemmap. Also is a little hard to understand, something
like "If vmemmap allocation was performed above for any folios,
then..." seems clearer to me.

> +        * destructor of all pages on list.
> +        */
> +       if (clear_dtor) {
> +               spin_lock_irq(&hugetlb_lock);
> +               list_for_each_entry(page, list, lru)
> +                       __clear_hugetlb_destructor(h, page_folio(page));
> +               spin_unlock_irq(&hugetlb_lock);
>         }

I'm not too familiar with this code, but the above block seems weird
to me. If we successfully allocated the vmemmap for *any* folio, we
clear the hugetlb destructor for all the folios? I feel like we should
only be clearing the hugetlb destructor for all folios if the vmemmap
allocation succeeded for *all* folios. If the code is functionally
correct as is, I'm a little bit confused why we need `clear_dtor`; it
seems like this function doesn't really need it. (I could have some
huge misunderstanding here.)

> +
> +       /*
> +        * Free pages back to low level allocators.  vmemmap and destruct=
ors
> +        * were taken care of above, so update_and_free_hugetlb_folio wil=
l
> +        * not need to take hugetlb lock.
> +        */
> +       list_for_each_entry_safe(page, t_page, list, lru)
> +               update_and_free_hugetlb_folio(h, page_folio(page), false)=
;
>  }
>
>  struct hstate *size_to_hstate(unsigned long size)
> --
> 2.41.0
>
