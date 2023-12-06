Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38772807158
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378670AbjLFN4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378745AbjLFNzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:55:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0DAD50
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701870955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P7s0RODaU0CONE0ORnylh3BqAbb5cnBkp4sJTs7k4Oo=;
        b=g3WZRGs4sKcnJwO9HBtnHNa1jMkWtdfKjo4kGUeelgpDdEkAXkTHxvSQIDyllEfuLDxpqm
        dTe4qGmgcpdaQdlI5jeK1ECd5qjv0OzenWu+LOGlddmYugwYujT+d6qbly3isH5nrQ6og+
        HgT/Dc459pU+XjQ79cRn27xMCPp9xYU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-YChUwnUAO6Kbw-RKxY2G3g-1; Wed, 06 Dec 2023 08:55:53 -0500
X-MC-Unique: YChUwnUAO6Kbw-RKxY2G3g-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50bf0f26df4so3967158e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 05:55:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701870952; x=1702475752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7s0RODaU0CONE0ORnylh3BqAbb5cnBkp4sJTs7k4Oo=;
        b=Ky9vkRNbBKW9I9uQMTXK4SxV+UEWBE7jVOoXGitebTcKTdXFZvRPmteF7DMbcvwu74
         t1eXnyhRfEoHcVlQ1TyMO9bwflaVOJoDQcqJBmyPMhVocJZ1Uer1dAQYjE7rshEfKgcl
         iDvpULYGvFN1X+WK6UwTmCu8YNINYcK9dMstlsNDG+bPLGKZ3EGPhQCmeKSHR5B7tpu7
         Y2pdTaXKT4VR+2gAeQ/GmDn1Qd1mtXYmbZLhENi+InruXCFohrfypwqyQMFHbOj5HSim
         AG4afvxwcj/GnSlK0MfAuer76rBJtiPujSaaUlL25F6Um3Y9vX2JrgiqLhoULxYYYQQg
         VM7Q==
X-Gm-Message-State: AOJu0YzdunKXFoed831pc4F9098ogeoyEf0/BEhF2MoZfJlwWK21zbID
        cHWaycNbmADE2Ssz9KGO94i4yluMDq5ARjof7229a0JStwdhN+VbSDxyrMqwIkmLIknhILuuMtB
        /Je5R6MxxbRUVUHTuF8ldwF0Xoo/66CqtiLCrTqRX
X-Received: by 2002:ac2:559a:0:b0:50b:e60f:4baa with SMTP id v26-20020ac2559a000000b0050be60f4baamr577482lfg.47.1701870952243;
        Wed, 06 Dec 2023 05:55:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGySLmvleNpyWCKhp6Ms6z7L9oDKbB5Ep3UDcXrZEAKc/ZMomNHiJ3gmUVz0bLloH+uuuwybbA9sE3pt4kNYMU=
X-Received: by 2002:ac2:559a:0:b0:50b:e60f:4baa with SMTP id
 v26-20020ac2559a000000b0050be60f4baamr577466lfg.47.1701870951874; Wed, 06 Dec
 2023 05:55:51 -0800 (PST)
MIME-Version: 1.0
References: <20231206135228.2591659-1-srasheed@marvell.com>
In-Reply-To: <20231206135228.2591659-1-srasheed@marvell.com>
From:   Michal Schmidt <mschmidt@redhat.com>
Date:   Wed, 6 Dec 2023 14:55:40 +0100
Message-ID: <CADEbmW3bn7btX_8RiOEncyh+M+WMK5Kxi+Gy_o3P2pi3u7rzHg@mail.gmail.com>
Subject: Re: [PATCH net v3] octeon_ep: initialise control mbox tasks before
 using APIs
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hgani@marvell.com, vimleshk@marvell.com, egallen@redhat.com,
        pabeni@redhat.com, horms@kernel.org, kuba@kernel.org,
        davem@davemloft.net, wizhao@redhat.com, konguyen@redhat.com,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 2:52=E2=80=AFPM Shinas Rasheed <srasheed@marvell.com=
> wrote:
>
> Initialise various workqueue tasks and queue interrupt poll task
> before the first invocation of any control net APIs. Since
> octep_ctrl_net_get_info was called before the control net receive
> work task was initialised or even the interrupt poll task was
> queued, the function call wasn't returning actual firmware
> info queried from Octeon.
>
> Fixes: 8d6198a14e2b ("octeon_ep: support to fetch firmware info")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V3:
>   - Included Fixes line in commit log.
>   - Corrected typo in print statement.
>
> V2: https://lore.kernel.org/all/20231205130625.2586755-1-srasheed@marvell=
.com/
>   - Updated changelog.
>   - Handled error return for octep_ctrl_net_get_info
>
> V1: https://lore.kernel.org/all/20231202150807.2571103-1-srasheed@marvell=
.com/
>
>  .../ethernet/marvell/octeon_ep/octep_main.c   | 22 +++++++++++--------
>  1 file changed, 13 insertions(+), 9 deletions(-)

Good timing. I was just going to write to you about the typo :)
Looks good now.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>

