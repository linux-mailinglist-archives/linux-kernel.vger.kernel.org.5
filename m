Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9EF76C2B4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjHBCIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHBCIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:08:16 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B5519A0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:08:15 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4036bd4fff1so158091cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 19:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690942094; x=1691546894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aja2sp26dbGeO9esoM3QzIDVku+dq0XwVDIc+IsolCQ=;
        b=6MnyYdm06DH0WFOhS8+wUQPsLSbrpKWd3npWMcNWWyzAoz/kWWU4HkWHEZkS61E5pe
         9+jM2Wx2GDwjmZYAXMQ3oB/Ejtai2i/RIC/5EhBihdDTYwCEGEc0i91VlXsTHUJNwSLg
         HEWLCMrTrjQPcHYz/1kyIkGqMQcNEkWIjapol0tMtvd6wLBG/kZFFiygKH+0VY7jQciM
         llbYmlAKWBPiPtT85B8qB78/xEDiFTc4jhn4UorM7ZYY2b8Kp0Hsfr/3asBIIHRoIz4G
         9GRBAmP5iodnS7ZBJgfcQQApGF89b1H00DiaC3rJYn/6IOMhoWejdsbrBkUAlYw2vfXb
         6EXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690942094; x=1691546894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aja2sp26dbGeO9esoM3QzIDVku+dq0XwVDIc+IsolCQ=;
        b=Bvri7YPJHVhZUossiWmSJbtSVtXX51MMjFr/Q9MwZa/8qnXq572n5zpaHH+qHwe71J
         fBxqGd8q0DjZ2HrJDz4DyIUK0Aq1KlOQeASNnT0qOcMglwcEIMQtj1oXZIjLrlvkIwcM
         BIv3gF4EEPvVU5GEi8G8v2FOcI/XyPnAN36K+gslLdK8ccWGugZFYnGzN4beiPSIxGSP
         K3Nv3fGgjQJyNINvhuGr8XRtoGovvwhjpg3jGnkdIM/AFbnoZo2RuS/Coe5gj0s7lRff
         qjT7oO5sbXOfK/kFzVnHxxBmWKLkldxfwcyz4ztfPixaYotelhSabb0ZecJS3Z49+5Ca
         m0Ng==
X-Gm-Message-State: ABy/qLZvrcMpKuUAab9JyXNpnpavw3lpjy3KKnjieAP+QNrwJYh2IWXM
        /BgzzOSIuDSzQSi4R6GekpIsOiTMlFhh5lwgddka9w==
X-Google-Smtp-Source: APBJJlFI0LpzT3Dxb29zrFcaiBceXtmAw2GDelbar44DfZF8uuQLNGEI78+/S1i3xVkHS0a1TO1gl0VExunoRFjXvvE=
X-Received: by 2002:ac8:584b:0:b0:40f:dc70:fde2 with SMTP id
 h11-20020ac8584b000000b0040fdc70fde2mr129571qth.26.1690942094306; Tue, 01 Aug
 2023 19:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230802001938.3913174-1-kaleshsingh@google.com>
In-Reply-To: <20230802001938.3913174-1-kaleshsingh@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 1 Aug 2023 20:07:38 -0600
Message-ID: <CAOUHufbz-VHZ12b9wrCFxZ9mqVnU=Xstkoo5Ym9_tw72R1-2Gg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm-unstable: Multi-gen LRU: Fix per-zone reclaim
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     akpm@linux-foundation.org, surenb@google.com,
        android-mm@google.com, kernel-team@android.com,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 6:19=E2=80=AFPM Kalesh Singh <kaleshsingh@google.com=
> wrote:
>
> MGLRU has a LRU list for each zone for each type (anon/file) in each
> generation:
>
>         long nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
>
> The min_seq (oldest generation) can progress independently for each
> type but the max_seq (youngest generation) is shared for both anon and
> file. This is to maintain a common frame of reference.
>
> In order for eviction to advance the min_seq of a type, all the per-zone
> lists in the oldest generation of that type must be empty.
>
> The eviction logic only considers pages from eligible zones for
> eviction or promotion.
>
>     scan_folios() {
>         ...
>         for (zone =3D sc->reclaim_idx; zone >=3D 0; zone--)  {
>             ...
>             sort_folio();       // Promote
>             ...
>             isolate_folio();    // Evict
>         }
>         ...
>     }
>
> Consider the system has the movable zone configured and default 4
> generations. The current state of the system is as shown below
> (only illustrating one type for simplicity):
>
> Type: ANON
>
>         Zone    DMA32     Normal    Movable    Device
>
>         Gen 0       0          0        4GB         0
>
>         Gen 1       0        1GB        1MB         0
>
>         Gen 2     1MB        4GB        1MB         0
>
>         Gen 3     1MB        1MB        1MB         0
>
> Now consider there is a GFP_KERNEL allocation request (eligible zone
> index <=3D Normal), evict_folios() will return without doing any work
> since there are no pages to scan in the eligible zones of the oldest
> generation. Reclaim won't make progress until triggered from a ZONE_MOVAB=
LE
> allocation request; which may not happen soon if there is a lot of free
> memory in the movable zone. This can lead to OOM kills, although there
> is 1GB pages in the Normal zone of Gen 1 that we have not yet tried to
> reclaim.
>
> This issue is not seen in the conventional active/inactive LRU since
> there are no per-zone lists.
>
> If there are no (not enough) folios to scan in the eligible zones, move
> folios from ineligible zone (zone_index > reclaim_index) to the next
> generation. This allows for the progression of min_seq and reclaiming
> from the next generation (Gen 1).
>
> Qualcomm, Mediatek and raspberrypi [1] discovered this issue independentl=
y.
>
> [1] https://github.com/raspberrypi/linux/issues/5395
>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
> Reported-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

LGTM. But I think we need the Fixes tag and Cc stable.
