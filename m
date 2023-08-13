Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C500077AA79
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 20:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjHMSFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 14:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjHMSFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 14:05:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A772119F;
        Sun, 13 Aug 2023 11:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C9C660C17;
        Sun, 13 Aug 2023 18:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95682C433C7;
        Sun, 13 Aug 2023 18:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691949938;
        bh=6CxxC2X/bSrbG1oSNI+Vc2RwjrYKIPxi63YQco6hIEQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ifTdvqQdMdMeJUATcgGcbDL/Nk4K+WdeXyNNMwyX1e4uwozat2V7dg+fIpyq8n8RN
         HVpyEdd5bdju0gnC++16RBZIdsYQqrP/eNR/KxazR63q4+B42UtvaoSt4lqUQvbmgA
         rjI1pPV33HPwGiktqIsdcnXbxSWJURScGEAZ9QR9vS/ApAZPh8bRGVB3l5NSeBdjvF
         fa5y2nur/P8OcB7gpicXNf6G46rPrrcd6RGl2WcY6P6RUEkqiyJEN+1W0x0u5QGnW/
         PA+5XPkpKoRWH6xioV7Gk2PXaMHrZO04EZ04tUstFGyd0tJXC8/Socs0J5xRqxZxgW
         r7cqmkjYk4tYQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fe7e1ef45dso5683244e87.1;
        Sun, 13 Aug 2023 11:05:38 -0700 (PDT)
X-Gm-Message-State: AOJu0YwnUBXeTLJ7ohfuYrcQhKqBVE//No0NEgEgLtN71v6I0B58RGDh
        noP5eWbb/TpBovrkfkn5CfpcA2ex00tcA/U2jD0=
X-Google-Smtp-Source: AGHT+IEFggOgCUVUmx/8KdVSMus4JSQxEgEt1R34d708vA0praW+DI2t3s60NXMHKdIZl9o2KLud/JfSxRRJsIC0hiI=
X-Received: by 2002:a05:6512:3085:b0:4fe:347c:874b with SMTP id
 z5-20020a056512308500b004fe347c874bmr6778041lfd.8.1691949936659; Sun, 13 Aug
 2023 11:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230808104912.1254342-1-yukuai1@huaweicloud.com> <20230808160520.GA16024@lst.de>
In-Reply-To: <20230808160520.GA16024@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Sun, 13 Aug 2023 22:05:23 +0400
X-Gmail-Original-Message-ID: <CAPhsuW5eJ2snSoJ4SryYhjteBYUM9W9MtVQq5w8noOEAvBj+fA@mail.gmail.com>
Message-ID: <CAPhsuW5eJ2snSoJ4SryYhjteBYUM9W9MtVQq5w8noOEAvBj+fA@mail.gmail.com>
Subject: Re: [PATCH -next] md/raid5-cache: fix null-ptr-deref for r5l_flush_stripe_to_raid()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, bugfood-ml@fatooh.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
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

On Tue, Aug 8, 2023 at 8:05=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>

Applied to md-next. Thanks!

Song

PS: The first email didn't make it to lore, and it didn't show up in
patchwork. :(
