Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C7B812633
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 05:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbjLND7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 22:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjLND7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 22:59:50 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365F9B7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 19:59:56 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-42598c2b0b7so99211cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 19:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702526395; x=1703131195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9SXl2tgU3L2tlbd5i1MJ4Mhz783przOxvBKI9pySS8=;
        b=0R22Q2uYLQTXQ/UdtcCyLRzm7sqpXAHIQtXe+SGm/bE2p8SzhcibFfLjbEoHUDXlba
         B+iPPZl9jmYRFaqKREZqFNfiZ4Af0vXPY53H7P6IOGSpscngub+cECgFvJ4qTF1jAiDN
         vvOQrbLPsT5MqzVRbF7pvohsa3wD6xk3HZ6D0xwL9KsIzkZHDiqX4W2x+7wgHKssXZL6
         eMGXrSn52DLFsXsUeqrad4MSyj6so4GMgAkt2rPGUEGSj9B4/o8bAjgf9+GY/+jx+/vf
         Zig/f0t2A/KRjopLN3TgFpkaToABEvlGXLo019fKJK5Sxt/E0LR+HYSOJpzUockxiwTo
         IlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702526395; x=1703131195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9SXl2tgU3L2tlbd5i1MJ4Mhz783przOxvBKI9pySS8=;
        b=rHMecM8IzFiwR3ibjDcoNj8guiMndihLUliWEfVn286ZWa5yCNup10j76AVV/zNz0s
         WdX9QFm+pQVNb4IdtViwbQu/tB4wqd7KuhssrtrjqEDe2YUCk/8Ms5tZj3zHTB3Uss8j
         slYCL5I1gU7dMXFwyLOtIeyqzfsx/6v3x87QjbZ/9LylgOi/YR4k+1+4Ya5zAdtKbmgV
         cFgHHyOw+BQNTO9JYgCihNmvCjkPykgDX0Orzh5SV38pZPt0bSxZOaiY+Sm/aH9ugpXw
         nwEqx9wTI+GoUBGkZfkUaoo24b3jUK6f8KyCQz6I401Gpi0P2fGqRP+W2b2VKZ1PjHXd
         86mA==
X-Gm-Message-State: AOJu0Yz6KdnVs+Cq+mUR2BqbmWfVtM3RdeLU4uomPv0Cij40N6hvZUq0
        iM7RIzcG+o65IARdu1HkmVB2jOOAI1K6LHLMuO3G7lcvV6U803Q8h5w=
X-Google-Smtp-Source: AGHT+IESwgZP1TXh1NT4O/RQwoZiqy2YV0XyAtyNBGRcT7/vSnMoL3kzLw4XBlh0PCwwtguE1YvhUUb4Oip8pcjOAUY=
X-Received: by 2002:a05:622a:248:b0:425:962a:1972 with SMTP id
 c8-20020a05622a024800b00425962a1972mr1579258qtx.20.1702526395107; Wed, 13 Dec
 2023 19:59:55 -0800 (PST)
MIME-Version: 1.0
References: <20231214013450.5734-1-cuibixuan@vivo.com> <20231214013450.5734-3-cuibixuan@vivo.com>
In-Reply-To: <20231214013450.5734-3-cuibixuan@vivo.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 13 Dec 2023 20:59:18 -0700
Message-ID: <CAOUHufZXX9M=sTkqxy=Pf2c298w7ha-SzF+1g9_HWcNkLVM9oA@mail.gmail.com>
Subject: Re: [PATCH -next v3 2/2] mm: vmscan: add new event to trace shrink lru
To:     cuibixuan@vivo.com
Cc:     akpm@linux-foundation.org, mm-commits@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, opensource.kernel@vivo.com,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
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

On Wed, Dec 13, 2023 at 6:35=E2=80=AFPM Bixuan Cui <cuibixuan@vivo.com> wro=
te:
>
> From: cuibixuan <cuibixuan@vivo.com>
>
> Add a new event to calculate the shrink_inactive_list()/shrink_active_lis=
t()
> execution time.
>
> Example of output:
>          kswapd0-103     [007] .....  1098.353020: mm_vmscan_lru_shrink_a=
ctive_start: nid=3D0
>          kswapd0-103     [007] .....  1098.353040: mm_vmscan_lru_shrink_a=
ctive_end: nid=3D0 nr_taken=3D32 nr_active=3D0 nr_deactivated=3D32 nr_refer=
enced=3D0 priority=3D6 flags=3DRECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>          kswapd0-103     [007] .....  1098.353040: mm_vmscan_lru_shrink_i=
nactive_start: nid=3D0
>          kswapd0-103     [007] .....  1098.353094: mm_vmscan_lru_shrink_i=
nactive_end: nid=3D0 nr_scanned=3D32 nr_reclaimed=3D0 nr_dirty=3D0 nr_write=
back=3D0 nr_congested=3D0 nr_immediate=3D0 nr_activate_anon=3D0 nr_activate=
_file=3D0 nr_ref_keep=3D32 nr_unmap_fail=3D0 priority=3D6 flags=3DRECLAIM_W=
B_ANON|RECLAIM_WB_ASYNC
>          kswapd0-103     [007] .....  1098.353094: mm_vmscan_lru_shrink_i=
nactive_start: nid=3D0
>          kswapd0-103     [007] .....  1098.353162: mm_vmscan_lru_shrink_i=
nactive_end: nid=3D0 nr_scanned=3D32 nr_reclaimed=3D21 nr_dirty=3D0 nr_writ=
eback=3D0 nr_congested=3D0 nr_immediate=3D0 nr_activate_anon=3D0 nr_activat=
e_file=3D0 nr_ref_keep=3D11 nr_unmap_fail=3D0 priority=3D6 flags=3DRECLAIM_=
WB_FILE|RECLAIM_WB_ASYNC
>
> Signed-off-by: Bixuan Cui <cuibixuan@vivo.com>

NAK.

A _start should always be paired with an _end unless there is a good
reason not to.

mm-commits@ is the wrong mailing list to submit MM patches.

Is the build error Andrew pointed out earlier fixed? If so, where is
it credited to him?
