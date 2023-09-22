Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CE87AB8F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjIVSR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjIVSR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:17:26 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091BA9F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:17:20 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34deefc2016so7730795ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695406639; x=1696011439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNM5qFpuQrwUs+7E90Z8RXHKxODmGjt566L854L1cyY=;
        b=f8Xu1n9DKITCfh6xg3x3f4i30pXwiYxdg5V1SqmRhHXkqaK4W0zxWCnAghfqflhoHG
         Z+1jFgtCux6dd7ZQXQ9a4/2cBoMRDaz3VM/f+k0+vT0z9BDzc5iMocOKrtwL5fbSqU5Y
         HSnVLE969EtaahtX6JZmClimmGMKAUAA+pMuKNbQqRmnJ9BrRuRRfdDK3NN2lRTMF/EF
         +aTNm+4jLL+W+h/X37X/v92/FzLjJItlbGPVHPCEGNw9uMHzgiBid8R4mgr9OAyk+B24
         IW96TBrQ6WPPAuz9QX+MJnoGfpX2knshZDPazYwcXLBj+GugPN+OvwQlAQ0j+43SjCga
         aAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695406639; x=1696011439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNM5qFpuQrwUs+7E90Z8RXHKxODmGjt566L854L1cyY=;
        b=PIEl4UzGuGbk/Rti8z1jgsBgHELUscpC6DarUY7BCkr0T6f9rtPwlhQqpAyTjbyXuP
         XQX/YpzFfv/wS1nvpfNUWd3PqCPNqqlFQIUG8lMFu0ifmwIefyDzUZEBqpbE7H12flDZ
         balv5KHlaoLCa7tsKYKlNSM+cJ1PXwPRL0kdTNBtEA8HVkWyLwhHmBqjU5chg1tq9dVq
         ReRmixLQ2jcpuftLGuDyHTiTboTi2C5+rhcpoCFKCgl0kN4CdsqQRI2p+HrSrfngRN+W
         +GniCvt+SamUR8i0+tnM6PNd28txW0HtecfD+Sh9YwoNXITSTSk0szr0Lv1x7lmD5We/
         aeug==
X-Gm-Message-State: AOJu0Yw0hDcLdckkQ8qbsSIma1nABCqf4Sx0TroWFEeIQ1bmRPeRIbmJ
        4r90y9eC52BOEQZn8OQbnmkke1TeMkgZYJRwhgo=
X-Google-Smtp-Source: AGHT+IH3vBuwlb7tT1ZO/MwNPf/qLy/ukjsoYKbcDRGSaUZyDgxOn51t2h6VWV/K44gsIhpmG1+w6x4QseJXh1HPWAk=
X-Received: by 2002:a05:6e02:1bcb:b0:351:1ac0:e1cf with SMTP id
 x11-20020a056e021bcb00b003511ac0e1cfmr391126ilv.4.1695406639285; Fri, 22 Sep
 2023 11:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230922172211.1704917-1-cerasuolodomenico@gmail.com>
In-Reply-To: <20230922172211.1704917-1-cerasuolodomenico@gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Fri, 22 Sep 2023 11:17:08 -0700
Message-ID: <CAKEwX=M3jxusnwx3weQFr-WYN-fONPgA-5d59eVJksaTOSsANA@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix potential memory corruption on duplicate store
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:22=E2=80=AFAM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> While stress-testing zswap a memory corruption was happening when writing
> back pages. __frontswap_store used to check for duplicate entries before
> attempting to store a page in zswap, this was because if the store fails
> the old entry isn't removed from the tree. This change removes duplicate
> entries in zswap_store before the actual attempt.
>
> Based on commit ce9ecca0238b ("Linux 6.6-rc2")
>
> Fixes: 42c06a0e8ebe ("mm: kill frontswap")
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Acked-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/zswap.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 412b1409a0d7..9146f9f19061 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1218,6 +1218,19 @@ bool zswap_store(struct folio *folio)
>         if (!zswap_enabled || !tree)
>                 return false;
>
> +       /*
> +        * If this is a duplicate, it must be removed before attempting t=
o store
> +        * it, otherwise, if the store fails the old page won't be remove=
d from
> +        * the tree, and it might be written back overriding the new data=
.
> +        */
> +       spin_lock(&tree->lock);
> +       dupentry =3D zswap_rb_search(&tree->rbroot, offset);
> +       if (dupentry) {
> +               zswap_duplicate_entry++;
> +               zswap_invalidate_entry(tree, dupentry);
> +       }
> +       spin_unlock(&tree->lock);
> +
>         /*
>          * XXX: zswap reclaim does not work with cgroups yet. Without a
>          * cgroup-aware entry LRU, we will push out entries system-wide b=
ased on
> --
> 2.34.1
>
