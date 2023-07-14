Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175E3753FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbjGNQwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbjGNQwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:52:40 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A54B358E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:52:39 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40371070eb7so3381cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689353558; x=1691945558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSor0z+j8dmiR3R7cJSlo0LRTK1ibHmEGZae25a0cWc=;
        b=ZZLybBkqBBUUYyp31pT1mbSdyfkuKc97A19ibjYbqfBDrlQ11L9v4bgA5rASWZaN8l
         /Sk2e7uQOZVTviTGBbf8UZcq782vf4m3NDaF6NS96dZHLrPOx8gbx++nycIAkpUSH6Yd
         PtgnmkhZnmwBTY/SKdSrHA4C7GNWEMjAqW4Tmo3N6O/e5Chg6RyBZ0NfN35Z/UdKyQ8Q
         NGsvZSbjTPcvdjSQpeWRe9FbiIoB3KfuX6L9Q50fnkivt9b5s2EDvdAST74bSwSRQ6rg
         ewR2Z5aP8RzlxYV0g3/cFvu7gToWsQBy++RpuUJnj5IUedwZkhkbUEydVHswuouIPIwm
         Fmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689353558; x=1691945558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSor0z+j8dmiR3R7cJSlo0LRTK1ibHmEGZae25a0cWc=;
        b=cL5o6Db36H6sLvlOmy+VlAu3oFFExAMbGhoaf3k9cqMUkkNtawPEt0OV7AeYooVjSt
         tq1quOXN5NH+9/rVuPelOb9+HjdMijRs83loJjfa93aPvPHaUtjE8bdq8DztWQSgTiUo
         MbywqyDYMnbd5zXqAHVmY7kPcNDUoJFDtVmReQDO9muvSSzxAhTQ3y6ZilLUIneM+mXJ
         RtV/6OKnheFNqkun2SDtX3NXVfL2/ow/gwSJSFCDeQyeOBNWGFh86MpzvjT8Amz5stSq
         lzxsyPqIi3p6mXSCuDtBn7tdkMlj9DtPeRDb9xEpx3KApJzs78VsvHbLQ1FPWgPQ9h5E
         dXyw==
X-Gm-Message-State: ABy/qLbfMDYxoaq2+qJsjQdG6XtnAKBVba8t3t2XF+j5gyE5bCWoduNx
        OqBId0uYwVQWltyY1dFBbXSXepBMfP9UQOOuzqROZQ==
X-Google-Smtp-Source: APBJJlGO51hVhm4koyw7/qMAERYXkNF8318256x5/cFfzFGvLDmNFVsjehig2PNxZSfWaptsXyqXwKTAXdMU8WyZosc=
X-Received: by 2002:a05:622a:1aa5:b0:3f8:3065:7fc5 with SMTP id
 s37-20020a05622a1aa500b003f830657fc5mr806892qtc.1.1689353557945; Fri, 14 Jul
 2023 09:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230714160407.4142030-1-ryan.roberts@arm.com> <20230714161733.4144503-1-ryan.roberts@arm.com>
In-Reply-To: <20230714161733.4144503-1-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 14 Jul 2023 10:52:01 -0600
Message-ID: <CAOUHufZdMjXP6vu1q+pXT8o5uhu5O0w_Fm5ccDvv2dzMiQv_=g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mm: Non-pmd-mappable, large folios for folio_add_new_anon_rmap()
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Fri, Jul 14, 2023 at 10:17=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> In preparation for FLEXIBLE_THP support, improve
> folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
> passed to it. In this case, all contained pages are accounted using the
> order-0 folio (or base page) scheme.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Yu Zhao <yuzhao@google.com>
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

This patch doesn't depend on the rest of the series and therefore can
be merged separately in case the rest needs more discussion.

Ryan, please feel free to post other code paths (those from v1) you've
optimized for large anon folios at any time, since each code path can
be reviewed and merged individually as well.
