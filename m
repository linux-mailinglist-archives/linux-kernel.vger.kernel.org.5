Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E691A77F17E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348618AbjHQHvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241318AbjHQHvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:51:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889DC10C0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:51:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DC0B64288
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D65DC433CD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692258695;
        bh=7bSUwHmNO8dW3AGCI9qBWJ06AyfFTVir+EtSZOlGnk4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IoEa8QSLtA20a6gY/atDS1VQTjI/HQqhOWLgnzVn9CEqh8WVXOTC4anbLcJsc72gm
         6kimXzkB6UdtyTiX2KblPdETkxQ+3gaIg22KZlWPM2nI9PBluWhyuUs5L/XFwDFnSZ
         FqIiMhEw/RwbHSRt5D5Z4StwjuSin9+JJp47iVw54qd+pLQ70gJNT65wEOs6cvMkZL
         HvTWxgXPNd9P6yDl37SPLLiQbywHpGaMUF+eWnXa3DHByI2HArj1DZS0LbBUjEUlZN
         d0nFGD3Xkh3M5WbESCMQeX/MFuw9uAjUVQOlLXVFDwFBtHXAs2lJLlpgqE2kXZsOmc
         IDUB4mVcEkkaw==
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5650ef42f6dso4639879a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:51:35 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw3pVGPWfN+HI+rq/2smwrMqKGfw+Kcx5itHUkHz1LV+XRNhtJE
        OltCObpax5nzPh1vdozO2kO1/NQsxAT9Bg1DUCRP+g==
X-Google-Smtp-Source: AGHT+IFiAzBL8cK9fAiv09ewrCX1IoiXfSJ8wR0PjemT8qnHGFCuysHEWXc4VvJw6AUUU6kSNsUVCoOqgL262n41ckY=
X-Received: by 2002:a17:90b:fcf:b0:269:7eea:d7f6 with SMTP id
 gd15-20020a17090b0fcf00b002697eead7f6mr2886423pjb.49.1692258694794; Thu, 17
 Aug 2023 00:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230809100754.3094517-1-shikemeng@huaweicloud.com>
 <20230809100754.3094517-2-shikemeng@huaweicloud.com> <ZNu5uHhYI4QxR4au@google.com>
 <53956bbf-844c-97da-2057-a8805360b35f@huaweicloud.com>
In-Reply-To: <53956bbf-844c-97da-2057-a8805360b35f@huaweicloud.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Thu, 17 Aug 2023 00:51:23 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMvLG6NL_r0Lnf5Un5bskrG6P6i4OhOVKFuhBQ5f9D91g@mail.gmail.com>
Message-ID: <CAF8kJuMvLG6NL_r0Lnf5Un5bskrG6P6i4OhOVKFuhBQ5f9D91g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/page_alloc: remove track of active PCP lists range
 in bulk free
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kemeng,

On Wed, Aug 16, 2023 at 7:22=E2=80=AFPM Kemeng Shi <shikemeng@huaweicloud.c=
om> wrote:
> Hi Chris, there is no functional change intended in this patch. As
> I menthioned in changelog, there is no wrap for list iteration, so
> that the active PCP lists range will never be used.
> > I have a patch sitting in my tree for a while related to this
> > count vs pcp->count.  The BPF function hook can potentially change
> > pcp->count and make count out of sync with pcp->count which causes
> > a dead loop.

In this case the BPF allocates a page inside spin_lock. The "pcp->count" is
smaller than "count". The loop condition only checks "count > 0" but all
pcp->lists pages have been free. pcp->count is 0 but "count" is 1.
After a few times wrap around, the pindex_max is smaller than pindex_min,
then reach to -1 cause the invalid page fault.

> I guess pcp->count is set to bigger than it should be. In this case,
> we will keep trying get pages while all pages in pcp list were taken
> off already and dead lock will happen. In this case, dead looo will
> happen with or without this patch as the root cause is that we try
> to get pages more than pcp list owns.> Maybe I can send my out alone side=
 with yours for discussion?

My patch is split into two parts, the first patch is a functional
change to allow
pcp->count drop below "count".
The other patch is just to clean up, and should have the same function.

Sure will send it out and CC you for discussion.

> > I don't mind my patch combined with yours.
> >
> Either way is acceptable to me, just feel free to choose one you like
> and I'd like to see if more we could do to this.

Thanks

Chris
