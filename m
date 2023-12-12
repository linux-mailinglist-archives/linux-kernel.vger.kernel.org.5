Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBB880FB6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjLLXd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjLLXd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:33:56 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E31B2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:34:02 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7b72d574399so263694739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702424042; x=1703028842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtJTpyn6WHnHGJdQw4Qk327F16W+w6nqd2j0/8/aQGg=;
        b=dseTZj7EeYLbQYMJMjFX7Nf+m7nMM4lABs7JcEEvFBtSZhNEIts/WND445GoPSMdZ5
         k9fbjDyghZ+6r7+qt/A8GWMwF+iP0aTJcrulFTiHt4V1sxlMXX0AO+4rC93eXQMfpuHm
         GtNnQsskBSUVuS0F4qKPmbpZfw7xci6xH2st+nsvGy9P0dUWb3rnaMe48A5ocwdLK0Hm
         UWOTjiYrL+5di4ccXSFvf9koBI5jMBeiPA4l0BhqKHrxxVgNcQc/eHHRJ4CoTmGMbsOd
         Sryb9Pz5DFTEaNol/1ywUvJasP9YN5vVDAEpTSJ34k8evC81gsUc5zjMyz23S4HTwxpn
         DeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702424042; x=1703028842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtJTpyn6WHnHGJdQw4Qk327F16W+w6nqd2j0/8/aQGg=;
        b=YpWfPeexs8snh78vcZf3XNaO4F6Z4pHVf/xs9m5RWlg9uDU9FxUwiJKY34eTJ+n+nt
         ysDFiB/N/v6LzD5XH3/YnhYQPtrEclZMXWYwXa4HHpOjn4gpmai2g4R2aKv4FKUDYdGW
         LEU5x0IlI9q/TJO195s007g1isaUjN5H3vovkWY4HOv6We2ObX39D15Jyl3lCJYqdZTV
         oY+LRmWpvz1YKa5qm/fFJkuvtJotBp5tpTDxqcPZrQL+3SGhZvKfa/MPOjxZ9IBlUn8C
         Un4rEmPVyzxRSo3Ig6/bjuRucR/QOsI6yt2UYLDF8sD9ejj5AWbT1EOdBj937YSLvcl9
         2BKg==
X-Gm-Message-State: AOJu0YxNXl5NPDgOONMMa4sNg4R5E0KirEdLFleGCMakDlIjCEka5Elr
        lTQKNlpc8YCF82ThKoBSXSwne9GKhcNKpces+r8=
X-Google-Smtp-Source: AGHT+IHCY5+Y1tkrzrKpX+SOVRIfVFFKwbCOM1fg2+bB2QO5CZhoT5QRozIYql6CKJDECrDXP1XSG+88KNrIHJj/L7o=
X-Received: by 2002:a05:6602:2bd4:b0:7b6:fb93:89a8 with SMTP id
 s20-20020a0566022bd400b007b6fb9389a8mr6566058iov.31.1702424041698; Tue, 12
 Dec 2023 15:34:01 -0800 (PST)
MIME-Version: 1.0
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
 <CAKEwX=NXcY3_GuKbh0=Ceg9wj=7u4y0NgmfSVEG3-+deY0jiWQ@mail.gmail.com>
 <CAJD7tkbErWz7Rjn-JdY8LjSW=GzEyyrNeJ5P1ipChFSufmQmLQ@mail.gmail.com>
 <CAF8kJuMegmMD3+YZfvsW3h1y1z1-kH7SiyJHPVnrSc89OZASuA@mail.gmail.com>
 <77d628dc-ab8c-4d8c-bc63-7e4518ea92d7@bytedance.com> <CAJD7tkZCxwDpNm-jQv_ieDvYhrtvMTXXjRp9_dQW3_VqYgUUsw@mail.gmail.com>
In-Reply-To: <CAJD7tkZCxwDpNm-jQv_ieDvYhrtvMTXXjRp9_dQW3_VqYgUUsw@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 12 Dec 2023 15:33:47 -0800
Message-ID: <CAKEwX=PfRNLL_t5q8vfEKA_rxgFcAer=9EFwLWDo9kDsmroAGw@mail.gmail.com>
Subject: Re: [PATCH 0/7] mm/zswap: optimize the scalability of zswap rb-tree
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Chris Li <chriscli@google.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 3:27=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Let's split the rbtree breakdown into a separate series. This series
> has irrelevant (and very nice) cleanups and optimizations, let's get
> them separately and defer the rbtree breakdown part until we get data
> about the xarray implementation. Perhaps the tree breakdown is not
> needed as much with an xarray, or at the very least the implementation
> would look different on top of an xarray.

Actually, kinda agree - I quite like the cleanup/optimization done
w.r.t dstmem reuse :)
