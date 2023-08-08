Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFDB7736FF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjHHCo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjHHCow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:44:52 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100CD19B6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:44:27 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4036bd4fff1so105731cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 19:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691462666; x=1692067466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFBtj5+GUeabKO+a6gaW+tViZxqLfdyLTKUL9Gnj9eE=;
        b=i/VHYmemj0AqwkE/aEQ4VIiX9E0CoxW/L48u4vW5wLdg+eBjtfFFhyPqu2GgIu5+dt
         BiI2K5Lb0TvWaP543JgNpD7yXw9P2/pLuGt2dsO/utVzQ8XT7TYpsrHSkTwtdX2mA5DT
         irRmR0UxGtLREgcczpJCHDyBpvwUqQ6l+NDAeO486ZTbdMidl781riX1QJ4Jl0xlIIjk
         RfgUMutLOKsftAogFysgdrsiR9oepxWFN9bA9VmQylHmBypyYAA7UyrmUH52/2rB5uD+
         LOz2Af4axT+crlWHpcBMMcF6pmoXQPvyG16cS3nxnJRqBj1X+3Hd4on0V903PwK2KSr3
         eLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691462666; x=1692067466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFBtj5+GUeabKO+a6gaW+tViZxqLfdyLTKUL9Gnj9eE=;
        b=GykInK+7a352omuXXAc6MvTIuKgf1XW9n+KeXBdkRlzGDOCrJO+zGUUnCSmOp1pXFA
         hNpbYVcBY73Tl9Og3L3Gyki3/o19hur4Ahw4mhGx2CQPLQ6MZvMR0MYNAE4KGk3mRF3r
         m9PkMn0sP83Ungnd+V3zS+IJu8mID4XVx68DxOYfo9sqUoHJgscpk0Htg+v/6bPBoIeF
         A7fSLMmALvdqXCZUwJ8Y1gjWxtfnnpQHotz3loAnNHKFo4SdIqPnGVQIe8Tl47AE4GLV
         eE288009nlKKjfT7VL+v5ML9GU/JvobABhz0197xDRjf575/fLEV853GmuFj2xu3X9Z0
         WZmw==
X-Gm-Message-State: AOJu0YyVNYmCh31uNHjuTQAtVZfgxt0WchIkVt43S+KqTGbeOqDikEyQ
        6hLsDmV9AsJTKau/kBJcEEz69VEvqR1K116Wi1j9ag==
X-Google-Smtp-Source: AGHT+IF64S4/Xi/oJhQgXH6fWplai9RuABjTLRY3oKXCVmngRrRUof9ljJ+2KiXHIjJ2ezLm2h04KupyzFuwiGBk5zg=
X-Received: by 2002:a05:622a:1456:b0:3fa:45ab:22a5 with SMTP id
 v22-20020a05622a145600b003fa45ab22a5mr550337qtx.27.1691462666077; Mon, 07 Aug
 2023 19:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230808020917.2230692-1-fengwei.yin@intel.com>
In-Reply-To: <20230808020917.2230692-1-fengwei.yin@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 7 Aug 2023 20:43:49 -0600
Message-ID: <CAOUHufa99BbKi3pq2xxrNEzygULE-brUELK=DLU89REW-GT-Vw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] don't use mapcount() to check large folio sharing
To:     Yin Fengwei <fengwei.yin@intel.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, willy@infradead.org,
        vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
        minchan@kernel.org, david@redhat.com, ryan.roberts@arm.com,
        shy828301@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 8:10=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.com> =
wrote:
>
> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
> folio_mapcount() is used to check whether the folio is shared. But it's
> not correct as folio_mapcount() returns total mapcount of large folio.
>
> Use folio_estimated_sharers() here as the estimated number is enough.
>
>
> This patchset will fix the cases:
> User space application call madvise() with MADV_FREE, MADV_COLD and
> MADV_PAGEOUT for specific address range. There are THP mapped to the
> range. Without the patchset, the THP is skipped. With the patch, the
> THP will be split and handled accordingly.
>
> David reported the cow self test skip some cases because of
> MADV_PAGEOUT skip THP:
> https://lore.kernel.org/linux-mm/9e92e42d-488f-47db-ac9d-75b24cd0d037@int=
el.com/T/#mbf0f2ec7fbe45da47526de1d7036183981691e81
> and I confirmed this patchset make it work again.
>
>
> Changelog from v1:
>   - Avoid two Fixes tags make backport harder. Thank Andrew for pointing
>     this out.
>
>   - Add note section to mention this is a temporary fix which is fine
>     to reduce user-visble effects. For long term fix, we should wait for
>     David's solution. Thank Ryan and David for pointing this out.
>
>   - Spell user-visible effects out. Then people could decide whether
>     these patches are necessary for stable branch. Thank Andrew for
>     pointing this out.

LGTM, thank you.
