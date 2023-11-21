Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0627F32A3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjKUPqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbjKUPqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:46:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E83597
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:46:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E42C433CB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700581561;
        bh=QrrdlxnPkvBTM/dyyHD62Af+aE8UzFW+pcUz2BBDeuU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Nd10M+JVclQzaCLDrEsgLBawo4Wg9OoO8L8dtHIvU1EhdwDQFbXvgdxX37SJxk0cH
         nNunW/tN/1zbcY6PnHy2ISrWW/ThPx84ryM0Qp8SrvgcVa6XmkoeMram0+9WqNPdy/
         WfyNPVgX9tapd87DtoJhQ821Hpj1zdts/Zm3dLc4L+3Z8fBFLXQ3GZVRC35pEgukhB
         JETA7Djd4871RBNinv12o+cEwlryvS/DlmjzhA1bm9Z1qKhZqCL9fPUWIC5nxy8qFM
         gCdRAie605+dIU4t1DZvknlV/YinUJM5b2i9d5Ct0fq4ai2uBCuaRKYWUzdfnlYYto
         2YQNx9QCojyIA==
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2839c113cbcso3173138a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:46:00 -0800 (PST)
X-Gm-Message-State: AOJu0YyGQniDOgNmMOl65nUwpVxZ+eWE5KxiiAOZxS+QLzCBNTCX/2vT
        Kpx2Q1uHZPM0R59X+O0FffBv8gOojmzdckJX5QyL5w==
X-Google-Smtp-Source: AGHT+IGegx4rQwcGEz/T77/nwkD5/STT5cfrYqzCCH5FAqe8ldX/x5YzOTvHgrPX7ZS/a+tkjb3nmpylxoncPAQcNcs=
X-Received: by 2002:a17:90a:fd02:b0:280:3f33:64d8 with SMTP id
 cv2-20020a17090afd0200b002803f3364d8mr12148287pjb.21.1700581560471; Tue, 21
 Nov 2023 07:46:00 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-11-ryncsn@gmail.com>
In-Reply-To: <20231119194740.94101-11-ryncsn@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 21 Nov 2023 07:45:49 -0800
X-Gmail-Original-Message-ID: <CAF8kJuM1xwXdGbE_jpE3mcscYCcxRaA6xL68LGCzC3vDprsTsQ@mail.gmail.com>
Message-ID: <CAF8kJuM1xwXdGbE_jpE3mcscYCcxRaA6xL68LGCzC3vDprsTsQ@mail.gmail.com>
Subject: Re: [PATCH 10/24] mm/swap: remove nr_rotate_swap and related code
To:     Kairui Song <kasong@tencent.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
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

On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> No longer needed after we switched to per entry swap readhead policy.

This is a behavior change patch, better separate out from clean up
series for exposure and discussions.

I think the idea is reasonable. The policy should be made on device
level rather than system level. I saw Ying has some great feedback
regarding readahead cross device boundaries.

Chris
