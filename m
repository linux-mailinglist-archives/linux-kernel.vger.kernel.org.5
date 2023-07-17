Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95E775602B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjGQKM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGQKMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:12:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870021A8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689588695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8nRj22T9/512zPxvkOqC1vXSxbaDljwzw9UUPmIr2es=;
        b=Tc9SZO3f+5zAGUEayExBN9t1fLRWdwoRdftdA2ulCCWzI0Ci7ZGJEcVTh3Hj7x0EFRc2Mp
        e1Z/b2h2r0V9TDwPOl93w0oqyd7wmLSSld73WTEp4fgPMnOcTS6gYl5lZEyBQkvM9Bca9u
        vRn+L51tRNTA15y0mQ6E7YUS8SO3xPI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-NAHIyNvfNG625mIkmwDmCw-1; Mon, 17 Jul 2023 06:11:34 -0400
X-MC-Unique: NAHIyNvfNG625mIkmwDmCw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fa8db49267so22394095e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689588693; x=1692180693;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nRj22T9/512zPxvkOqC1vXSxbaDljwzw9UUPmIr2es=;
        b=Fiwk3ldIwtrkGW4tHLIH7OQWMDi+0EXB3rmy8oIZYXuApSxdaTMVvn1ep7venxU76y
         6NJp5huUAbpBEa20z2mu69BPNqu6MEJZj26hE/P3MmxBI7ZZyvgwraQws96cmzJh8Amh
         XamNcY7XUWJGbdxljvj45GHs1OSEBCuLv0CZrOr1Qx8H2Hky0teSFNOX6gAudU4IVCBd
         DaSPTxNE6zT2B851/nJiJ1dZDtwoHQyTpTfkRb3JywkhXw5/VD8DMh5MLQPD1/JeNRRR
         6wW36w83J5HUN2I5DY+Bmuqgx1/Z5nkRr9DGq0Q1A2b3PWFWGSeiOuuI684NgT7Szmsy
         5ZkQ==
X-Gm-Message-State: ABy/qLZaguxNaAOmG0Ewl8EwGkeD1VE2klhoGTBmE5eYka1OJ7ngphv5
        2VWFDGY/5ri/1qcw1+ASAWTE/hMsTdQ9TrUHziK00MONFF0yRrxRZANoA1HU22hmRSdQCLdsj5f
        Qmf5fODvMakN6X1Poa3viKqfliZIU9ldt
X-Received: by 2002:a1c:730c:0:b0:3f7:f884:7be3 with SMTP id d12-20020a1c730c000000b003f7f8847be3mr9353272wmb.4.1689588693187;
        Mon, 17 Jul 2023 03:11:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG4NMi/EOG4DbyTAfW6xDy5Sl4Jzmh3AyVQ2FAtVi551OsEy6xNNEX2UpRf+vdorITRBLLbbQ==
X-Received: by 2002:a1c:730c:0:b0:3f7:f884:7be3 with SMTP id d12-20020a1c730c000000b003f7f8847be3mr9353257wmb.4.1689588692905;
        Mon, 17 Jul 2023 03:11:32 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j1-20020a5d4641000000b0031434936f0dsm18696149wrs.68.2023.07.17.03.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 03:11:32 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] drm: fb-helper/ssd130x: Add support for DRM_FORMAT_R1
In-Reply-To: <CAMuHMdUiEXgk51Bjo+SdTXJz=bCrPzrcd8k1cZcEJUamsn0d1g@mail.gmail.com>
References: <cover.1689252746.git.geert@linux-m68k.org>
 <87zg3w7zlz.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdV_qNfytroBEfqDMe04POt27s9o=FevXht7N4YXRmBz8Q@mail.gmail.com>
 <87o7kakijn.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdURa8E9cmphbDkTgS2o3ORWd7JAj68PV9bxd3aygKZRJg@mail.gmail.com>
 <87jzuykhm5.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdUiEXgk51Bjo+SdTXJz=bCrPzrcd8k1cZcEJUamsn0d1g@mail.gmail.com>
Date:   Mon, 17 Jul 2023 12:11:31 +0200
Message-ID: <87edl6kfu4.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Javier,
>
> On Mon, Jul 17, 2023 at 11:33=E2=80=AFAM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> >> >> penguin in test004 is not displayed correctly. I was expecting tha=
t to be
>> >> >> working correctly since you mentioned to be using the Linux logo o=
n boot.
>> >> >
>> >> > Linux has logos for displays using 2, 16, and 256 colors. Note that=
 the
>> >> > default logos are 80x80, which is larger than your display, so no l=
ogo
>> >> > is drawn.
>> >> > Fbtest has only the full color logo, so it will look bad on a monoc=
hrome
>> >> > display.
>> >>
>> >> I see. Should the test check for minimum num_colors and skip that tes=
t then?
>> >
>> > The test still works (you did see an ugly black-and-white penguin), do=
esn't it?
>>
>> Fair enough. But when it defaulted to XRGB8888, it looked better. So I
>> thought that it was a regression. No strong opinion though if the test
>> should be skipped or not.
>
> IC, fbtest's mono_match_color() just finds the closest color (black or
> white), while drm_fb_xrgb8888_to_gray8_line() uses a weighted average
> of the RGB components. That might make a small but visible difference.
>
> We could make it look even better using Floyd-Steinberg dithering... ;-)
> Fbtest does have an unused match_color_error() helper, so I must have
> had that in mind, initially...
>

Interesting. I'll take a look to that if I have time! But as mentioned,
all that is something to improve in your fbtest suite and the ssd130x
changes in the driver do look good to me and are working as expected.

> Gr{oetje,eeting}s,
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

