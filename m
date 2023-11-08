Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7AB7E561B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjKHMTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjKHMTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:19:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489441BCC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 04:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699445944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qvMbksH7c6ZcEvPYTegmnIug2dODLV7SHYglfVWxD9g=;
        b=fqSHjTVRXluNKA9aZlPr8jR2ZrmK7ne3BrchfCP9JJptLIvFlRPBJnHwPiJYXW7qZqQupv
        nbVzUZFJsmobTBDO3jZaYnHnOgJHpEuAqk7D4gSuM6NVzivuEdATpXRpsJU8t2rssEUheG
        kpyaSFg/KxznBo8a30w/ovX+geryh7U=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-ZN6LUCchPgy7vtuvrFhsGA-1; Wed, 08 Nov 2023 07:19:03 -0500
X-MC-Unique: ZN6LUCchPgy7vtuvrFhsGA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5bd0c909c50so4068967a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 04:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699445942; x=1700050742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvMbksH7c6ZcEvPYTegmnIug2dODLV7SHYglfVWxD9g=;
        b=GQJsAUmY8wmdQ0CcF5RWZ9nbYhwf7cW6ZscVG4GKwwkVGi7apaNy3mUBTW/BqZOAIg
         0FQBfRRamOVTLdmI87/BG+4JgG/xojqmR+5mO9rUAuvnB2WiABl5lY5Jzqj7YalS5Lg3
         zbCrp3Szdy0XLy1A+RzL5QyiHxi+N61eXkwXL7tTMTvIyeuuXL/L+LTaWiHbQ4XrLHWr
         TKa4PrW9huDP2cN3EzpCykvA2gDuRghszMv2ACUaUnNmy9bWmoThXqjR0rfm8ETJknPx
         tq65Dn+Qxt9cQb21kisxjtQY1fBn+QbUYoFuinVk2jzihpOBvj9lGwEf0y40ifq4g+1C
         Neag==
X-Gm-Message-State: AOJu0YyqIalnieBlf6VA7UQsuO9n4+GZiSdgSotlOXe46XofjJPqgjiQ
        Ax8sypu2IYVCd6K9iEMy4y6gGD9f6MICFBg4ZMpe1ZU1GxhBb/OfhqWEiSY5QCH5klm7TJ1Iq2s
        LWn0VTOrZ0M+GD27Adijn2i/xQbkmuaqZc+WliYvy
X-Received: by 2002:a05:6a20:938a:b0:181:90eb:6b24 with SMTP id x10-20020a056a20938a00b0018190eb6b24mr2095807pzh.22.1699445942415;
        Wed, 08 Nov 2023 04:19:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMbLzr20JSxrzK1NYa1Vhm0XM23Nhag0peMzgZJ1k+N4/hUlCW39pruQ7YMOM5nxoc/XiYAkMlMh4BRGJ1gqM=
X-Received: by 2002:a05:6a20:938a:b0:181:90eb:6b24 with SMTP id
 x10-20020a056a20938a00b0018190eb6b24mr2095525pzh.22.1699445937280; Wed, 08
 Nov 2023 04:18:57 -0800 (PST)
MIME-Version: 1.0
References: <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com> <4b0b46f29955956916765d8d615f96849c8ce3f7.camel@linaro.org>
 <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com> <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
 <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com> <5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com>
 <8ae8ce4d-6323-4160-848a-5e94895ae60e@leemhuis.info> <CAOssrKdvy9qTGSwwPVqYLAYYEk0jbqhGg4Lz=jEff7U58O4Yqw@mail.gmail.com>
 <2023102731-wobbly-glimpse-97f5@gregkh> <CAOssrKfNkMmHB2oHHO8gWbzDX27vS--e9dZoh_Mjv-17mSUTBw@mail.gmail.com>
 <2023102740-think-hatless-ab87@gregkh> <CAOssrKd-O1JKEPzvnM1VkQ0-oTpDv0RfY6B5oF5p63AtQ4HoqA@mail.gmail.com>
 <689f677b84b484636b673b362b17a6501a056968.camel@linaro.org>
 <CAOssrKfP+t-cy322ujizQofgZkPZsBu1H4+zfbWNEFCmTsXwug@mail.gmail.com>
 <afe378bf254f6c4ac73bb55be3fa7422f2da3f5f.camel@linaro.org>
 <CAOssrKeJB7BZ7fA6Uqo6rHohybmgovc6rVwDeHbegvweSyZeeA@mail.gmail.com>
 <7df24b0e-ea98-4dc7-9e1b-dfc29d0fa1b1@leemhuis.info> <61be0ebb17ae0f01ea0e88a225cbfa07ff661060.camel@linaro.org>
In-Reply-To: <61be0ebb17ae0f01ea0e88a225cbfa07ff661060.camel@linaro.org>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed, 8 Nov 2023 13:18:46 +0100
Message-ID: <CAOssrKeUbmEUWnT_JoRRAb0asttB3FfMva121D+sXFYEuFTV8w@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT"
To:     =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Daniel Rosenberg <drosen@google.com>,
        Alessio Balsini <balsini@android.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 11:31=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:

> We are using the Android kernel in all cases and Android applies
> patches on top of Linus' tree, yes (as does everybody else). The
> previous Android kernel worked, the current Android kernel doesn't
> because of the patch in question.

Why don't you revert the patch in question in the Android kernel?

Thanks,
Miklos

