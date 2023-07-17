Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC0C755D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjGQHn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGQHnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:43:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D767EFE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689579757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LgDWPpR69a6gRtsnEM9q7cWClwoc2XjUqvbJeDKqL18=;
        b=RrhAsVav6d6oRcuxHacPiXYJQbWfrok5r4VhtDC+qL/wRUmd78eL3E8s9XzRCp3ZVYNR67
        YDMYBMWANLNtvrFzEITH++0T4siWdXSBz6B4YSY627j+h/AhaxuzWemNcXD8qCScoFmly5
        MO1HlwWO9NxcLaXa4PWwzOXJI9OWYCw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-iX9UtgOuNeO0QaC328eS5w-1; Mon, 17 Jul 2023 03:42:36 -0400
X-MC-Unique: iX9UtgOuNeO0QaC328eS5w-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b895fa8929so21338465ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689579755; x=1692171755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgDWPpR69a6gRtsnEM9q7cWClwoc2XjUqvbJeDKqL18=;
        b=F4fuuK/AKaT6xy9WU+HDl1tyC2OTnCqljfR9U2HiXvlCBaoNk9luBpfJpbEtD06kxU
         ilZ+9YbG9XcCHU2RpLsekIbwzQbeiVFyCk4OvrQ2HXV8FEz64oofiD3YkHn6PsG5iuNe
         0o4OuQoRakEiGwMYIWz5bVFK2ymzdl3zC6iqnuWFHCyjfxJEHecC0e7dxOsticiMiEYP
         kjfNPMa7dpu0Rd0RmSQiBBGc5QKZDOH3dLGL49BYe1DxmXGRj1fX1zXue+yTQXta/C8/
         P3rYTDvhIVEZDLmZQ5RTKQbtO+L3YrTMNn6cFXHzhxnJwq8Ps0VMPXeUkLRwpP7EVkJ/
         wGSw==
X-Gm-Message-State: ABy/qLbk7hRxDj4z+RKZXQuP4Q1iotak+mR1js9Q84vI9luS04V1eYMU
        m1Y+CzLNyJyiMfRISUALhVgybiMd2Js5tNthL/P/A5WOZR94pLc3s1vwDF4iH1vHPu1DCstvkaa
        ok9otHAI71ko3wyGIEr1N4vPLADhQ99eH6ODXqYGcLvczR6LIoTw=
X-Received: by 2002:a17:903:32ca:b0:1b8:94e9:e7d2 with SMTP id i10-20020a17090332ca00b001b894e9e7d2mr10597109plr.0.1689579754879;
        Mon, 17 Jul 2023 00:42:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFSdHjeDPWFi9IYOJrmi8q9RrGv5VWqjZyZQX93Uju5J+yo4lOUUQ8UFP2RsXYaWbnx0vqOUH6a1eAHVzaAhqY=
X-Received: by 2002:a17:903:32ca:b0:1b8:94e9:e7d2 with SMTP id
 i10-20020a17090332ca00b001b894e9e7d2mr10597104plr.0.1689579754596; Mon, 17
 Jul 2023 00:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230717071938.6204-1-duminjie@vivo.com>
In-Reply-To: <20230717071938.6204-1-duminjie@vivo.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 17 Jul 2023 09:42:23 +0200
Message-ID: <CAHc6FU4_SDSpom3Qvt35AXOmmc3v9EJYksgP4EN3owMEC2y-AA@mail.gmail.com>
Subject: Re: [PATCH v1] gfs2: increase usage of folio_next_index() helper
To:     Minjie Du <duminjie@vivo.com>
Cc:     Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minjie,

On Mon, Jul 17, 2023 at 9:20=E2=80=AFAM Minjie Du <duminjie@vivo.com> wrote=
:
> Simplify code pattern of 'folio->index + folio_nr_pages(folio)' by using
> the existing helper folio_next_index().
>
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  fs/gfs2/aops.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index ae49256b7..5f0254237 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -272,8 +272,7 @@ static int gfs2_write_jdata_batch(struct address_spac=
e *mapping,
>                                  * not be suitable for data integrity
>                                  * writeout).
>                                  */
> -                               *done_index =3D folio->index +
> -                                       folio_nr_pages(folio);
> +                               *done_index =3D folio_next_index(folio);
>                                 ret =3D 1;
>                                 break;
>                         }
> --
> 2.39.0
>

Applied, thanks.

Email addresses like '"open list:GFS2 FILE SYSTEM"
<cluster-devel@redhat.com>' and 'open list
<linux-kernel@vger.kernel.org>' are not helpful though, so could you
please avoid using addresses like that in the future?

Thanks,
Andreas

