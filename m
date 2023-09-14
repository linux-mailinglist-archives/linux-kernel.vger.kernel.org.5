Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22B97A0BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbjINRrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbjINRrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:47:17 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F581FF5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:47:12 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-415155b2796so26161cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694713632; x=1695318432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OapqwkKCf4YIRdOK5eipqLOcrCetpXM2XnBK/inREIE=;
        b=nM6TRcyPH7TFDawGPQFgGHjWpcAkK0S7BHo1ftoVRJEI/iIkOpQXO8Eg77/QUkqgob
         R3K9l7p67Wd2U3JC1LCEjIeS+MCQPH9EYllR0P7oVNEUpxp6OtJ2Qjky8NI5b9nI/kgm
         15BcOxLExXwDOrbObJyvW7cFAzXzsuTZlLO7tngzcVDvZYi7V+zoulbYO5DYTdl+gu25
         nGFurKUd5++bz9VGkhF5UiNGlfUFjyZfk5X9SQTZlkjqeJM3U1tofw9X6pwDp1lIJAAJ
         pBJ9qRrevxBChDYfKgpAvkoxn2E7ZwyR63fCyaR1FiquULuNc7OkQaKnudxnds70sFL1
         PKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694713632; x=1695318432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OapqwkKCf4YIRdOK5eipqLOcrCetpXM2XnBK/inREIE=;
        b=oHptrgKhdWkKGdZ+YKQuI9xC5Mu7qwo8iX46APrn7rUrY61m6NhJdiiDzgq6eNdfQN
         zQqL/n6GOwRspKgBAsaaV9q6nEAE6YuRq8J/a1RwkahfkCa9rmF50D6uQwBuLhD4h4Uj
         cuf+U2ReSSuZu+aE9aDlG+oVv7B2exlYRxK2nIDes5U0xVEIIriMjyfkjvrHLtgNXeLt
         Zb7V0m9kvotHtzN24nKgp6U7ICfiS7Cf+JLZK6XvJmYew1LoephmrPmxeuqI52NkZSH1
         I0N5li9gMdDhryqHmfnQxB6Qt5KHTn1af3DSIxyqyXJM+KGmM/BVL22yy0C9Ma/7V9CM
         vlQw==
X-Gm-Message-State: AOJu0YzPPnxYutA4EhgxB5ZHgwIsFX/fZnO9S8vKpwwLMov3Me2mtzeC
        f/tVFApH7kKqUBeOOCavSLNQeUlSleIBsDZTgEtvMA==
X-Google-Smtp-Source: AGHT+IG3dCEOE5PEHdrU+RjQG71bo20lPeEalZi4ir7k35XVyOQ4/Mg/UvcNdhM+698GCDtKbdL+6QOc/dR/UWSrgQ8=
X-Received: by 2002:ac8:7f4e:0:b0:403:fdf1:e05e with SMTP id
 g14-20020ac87f4e000000b00403fdf1e05emr10948qtk.19.1694713631986; Thu, 14 Sep
 2023 10:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230914140823.1732-1-justinjiang@vivo.com>
In-Reply-To: <20230914140823.1732-1-justinjiang@vivo.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 14 Sep 2023 11:46:35 -0600
Message-ID: <CAOUHufY+7j1L37c1RvCBdkx36qyNZYOBuZa_+GAA4j=9vKzwWA@mail.gmail.com>
Subject: Re: [PATCH] mm: mglru: fix add unevictable folio to lruvec->lists
To:     Zhiguo Jiang <justinjiang@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 8:08=E2=80=AFAM Zhiguo Jiang <justinjiang@vivo.com>=
 wrote:
>
> The unevictable folio is not supported to add to lruvec->lists
> in lruvec_add_folio().
>
> So use lruvec_add_folio_tail() instead of lruvec_add_folio()
> to add unevictable folio to lruvec->lists in sort_folio().
>
> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  mode change 100644 =3D> 100755 mm/vmscan.c
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 661615fa709b..a15e45632034
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4237,7 +4237,7 @@ static bool sort_folio(struct lruvec *lruvec, struc=
t folio *folio, struct scan_c
>                 success =3D lru_gen_del_folio(lruvec, folio, true);
>                 VM_WARN_ON_ONCE_FOLIO(!success, folio);
>                 folio_set_unevictable(folio);
> -               lruvec_add_folio(lruvec, folio);
> +               lruvec_add_folio_tail(lruvec, folio);
>                 __count_vm_events(UNEVICTABLE_PGCULLED, delta);
>                 return true;
>         }

NAK.

lruvec_add_folio()
{
        ...

        if (lru !=3D LRU_UNEVICTABLE)
                list_add(&folio->lru, &lruvec->lists[lru]);
}

lruvec_add_folio_tail()
{
        ...

        /* This is not expected to be used on LRU_UNEVICTABLE */
        list_add_tail(&folio->lru, &lruvec->lists[lru]);
}

struct page {
        ...
                        union {
                                struct list_head lru;

                                /* Or, for the Unevictable "LRU list" slot =
*/
                                struct {
        ...
}
