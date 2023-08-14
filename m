Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA3577BD8D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjHNQAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjHNP7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:59:46 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A104910E4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:59:43 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40a47e8e38dso417111cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692028783; x=1692633583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4i5eV473f7wGLCUwgr8eYOWIRZnCPm+12Iu8HyqFQZ4=;
        b=QeiZ/V/HDBgQma+VPIYzMnSI+wWGXhP/WATnzSaWxUHnnjG3VkOwog2bBquQo1mZR7
         oPZDpTClhz0d2BeL+bbe9t0ejh1ggNvxQyKYv5vSBvWn8v2o+Ujx849qi74bmVekOhWn
         0CEpgDR2s1tpA1B3llKF+Z4j5+dcItmBfhWKCJn9gvtTIhtC8obgDF36yXvcQrtaG5qe
         pKgEEnFGO3nwXE4I8uoslqMT2uvaxpHz+5kYnc3qiMhJJ5PBtKKjlXMzFiAj0jdlPgR4
         nJUXmE3FC6Ph72MDRc4XiBwU7Qz+THcSA6Gb0LX3GiXKfFWTIukNVZaXoWMUsaaBBqFL
         Drug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692028783; x=1692633583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4i5eV473f7wGLCUwgr8eYOWIRZnCPm+12Iu8HyqFQZ4=;
        b=KFS57Zs1kgCdd+I+YToFh5OymkqAphvRG4QT36+uJtjqcb9Wob2lPt1iLK6U7e/XGJ
         f5p2Ga14tY2wI+IWIdxHq+0zAA2s/q/laglCDTlMHkeEweENuGZlLUySBbij5e8bbBwx
         GuRXFill6h/iQFffSlvWLWhL0Orz9AlwgzBN0fpZ2dVuQshWQONtpsVFpdV3XIzejvQP
         FyV1b7Mv4BuXG41BjxswJDQIEer9nLkwWbG3E7u4tqsMUERSS2GUkUGSMkVO/pWdI2nI
         y935IyvaDS2otWl508E/EsJpYe89KZookP6NVOnvtXBCQKTzbOytaMUBs0uYl0/904TZ
         tCLQ==
X-Gm-Message-State: AOJu0YwpCO16rKS1tX1os5l/ISIosh1WOXIrCmMwcqg7TWrbkI0m1FOQ
        u5kXgpVpUOc+Cp3oWfPFxcJ6V4VwiSGh9F1rThhkww==
X-Google-Smtp-Source: AGHT+IFDjRWBRJPugWc/SmG/R5CLHd5UA0RCFSy3Sbq0ldUfjl8s+ZFz2wUt7NFfjwQ8aSKf/5oKkOjuCtNMQFLvpng=
X-Received: by 2002:a05:622a:1988:b0:410:3405:7398 with SMTP id
 u8-20020a05622a198800b0041034057398mr586521qtc.18.1692028782725; Mon, 14 Aug
 2023 08:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230814151636.1639123-1-tjmercier@google.com>
In-Reply-To: <20230814151636.1639123-1-tjmercier@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 14 Aug 2023 09:59:06 -0600
Message-ID: <CAOUHufZg=RpSMeQSaag0mXH_UAASPtqPVUtC-u9V=j826Vpo4Q@mail.gmail.com>
Subject: Re: [PATCH mm-unstable] mm: multi-gen LRU: don't spin during memcg release
To:     "T.J. Mercier" <tjmercier@google.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        android-mm@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 9:16=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> When a memcg is in the process of being released mem_cgroup_tryget will
> fail because its reference count has already reached 0. This can happen
> during reclaim if the memcg has already been offlined, and we reclaim
> all remaining pages attributed to the offlined memcg. shrink_many
> attempts to skip the empty memcg in this case, and continue reclaiming
> from the remaining memcgs in the old generation. If there is only one
> memcg remaining, or if all remaining memcgs are in the process of being
> released then shrink_many will spin until all memcgs have finished
> being released. The release occurs through a workqueue, so it can take
> a while before kswapd is able to make any further progress.
>
> This fix results in reductions in kswapd activity and direct reclaim in
> a test where 28 apps (working set size > total memory) are repeatedly
> launched in a random sequence:
>
>                                        A          B      delta   ratio(%)
>            allocstall_movable       5962       3539      -2423     -40.64
>             allocstall_normal       2661       2417       -244      -9.17
> kswapd_high_wmark_hit_quickly      53152       7594     -45558     -85.71
>                    pageoutrun      57365      11750     -45615     -79.52
>
> Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
> Cc: stable@vger.kernel.org
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Acked-by: Yu Zhao <yuzhao@google.com>
