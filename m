Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF56F79C8B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjILHw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjILHwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:52:09 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085FEE79
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:52:06 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-6491907dbc3so34851176d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694505124; x=1695109924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wfU0nPdaQSnyD0LQvaXmeyB83Sm2OJsXjly/b3WroA=;
        b=ktxk1uAbsmO/mP/Wm76/NBsj7lysxF9A3ReUvU0rhyV2xOP0GrbXoXBMGDdYXQk7qO
         JyX1h/MBJEDfLqIXRgJw4/He6jChcG7jDcG+rUCLjQI/4Ge5OakDC3m9shzVVi/40voi
         dnqwX7UoQTkWDsXKotU8s1SGGO+17s8kkaomE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694505124; x=1695109924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wfU0nPdaQSnyD0LQvaXmeyB83Sm2OJsXjly/b3WroA=;
        b=k4Lhg+sssjlfJ69tkl4bkKEN0UQ+Hzacd9Z9w49AHNNOcoNdxImPZqbjvq0vFU93Hv
         sgTgdB8CSC2MU/gfsdWMBR5xc5UWnNr/ZYugucZA28l8eiPd0JN24YnTGIiB2YbSuMor
         BcUn+tBUz/hndYrFvV+vxNaufDCg4UKhmliOsWZMxvFOGDwe2B4q5t/bkMK7EiXN8MMY
         ChL4qSS1ovqG5qO+V5sz2LKAr2/FurfIC9JqEKbS+2bRda66J0gXqj6f5je8dlHiE6UU
         6sFUB3UyRkLshIDUTeXzQO/DURmfWH/gXrjcneGdSulZT55/PqZ/YRslZd09k4sgjN0u
         dFgg==
X-Gm-Message-State: AOJu0YyTORiov5YcTYisizazbVrDTt5K3cPZqb8XaugtudLB2BCTKoUH
        kUs9mUGchzD0eZ42cCdbXAsgDolquNTAeVS7HpKsJg==
X-Google-Smtp-Source: AGHT+IGepGuQT9Tz4St8l1RuGKPOyaWlL3KjsHTIVoOvCq+AZrowNdmZ4mP4u/fcxmzh9nNwWGjC0g==
X-Received: by 2002:ac8:5907:0:b0:410:443:221a with SMTP id 7-20020ac85907000000b004100443221amr17513599qty.1.1694505124050;
        Tue, 12 Sep 2023 00:52:04 -0700 (PDT)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id l16-20020ac848d0000000b0041514d1da65sm2273558qtr.20.2023.09.12.00.52.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:52:03 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-76f17eab34eso323076485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:52:02 -0700 (PDT)
X-Received: by 2002:a05:620a:a1c:b0:76f:93e:4b45 with SMTP id
 i28-20020a05620a0a1c00b0076f093e4b45mr11888873qka.69.1694505122529; Tue, 12
 Sep 2023 00:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230828075420.2009568-1-anle.pan@nxp.com> <DB9PR04MB9284AA58AA71655C9C0C7C9A87E6A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5DYxwX+JdXQ_-ba5B9y+gyWPjvUpCBnKM1zz1W2EkO_vA@mail.gmail.com>
 <DB9PR04MB928460023FB3CCCBC3EACE1487E9A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5BGJX7=Z1ukFRq_ktaQ0d7FbvV-ob5gs8hfGaNHUXPTww@mail.gmail.com>
 <DB9PR04MB9284A0CDB1FC7CAADE0A394F87EFA@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5AugUGh7Z=9Qh7SS4=-0ddGBmRAOOyCGDfPdT-=eurtUg@mail.gmail.com>
 <DB9PR04MB9284A45033B3E24F44C5AA3987F2A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5Bk0DUq5jgFDHV2wGYEcfQzNVQ2KYJ2ZYLubwFLgqW4kQ@mail.gmail.com>
 <DB9PR04MB92846D75C93A9B2B8C8A998D87F1A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5Ar18TvFE3jXBuphpCiwWAb8O99wqkiwEVDSs3+MXvW0w@mail.gmail.com> <DB9PR04MB9284404C1E1F1300EEF5A70487F1A@DB9PR04MB9284.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB9284404C1E1F1300EEF5A70487F1A@DB9PR04MB9284.eurprd04.prod.outlook.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 12 Sep 2023 16:51:43 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Aq=ZrNGQU6psXJXt1ak2SkoRrZ=QBzp+xxHmWre0zBVg@mail.gmail.com>
Message-ID: <CAAFQd5Aq=ZrNGQU6psXJXt1ak2SkoRrZ=QBzp+xxHmWre0zBVg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
To:     Hui Fang <hui.fang@nxp.com>
Cc:     Anle Pan <anle.pan@nxp.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jindong Yue <jindong.yue@nxp.com>,
        Xuegang Liu <xuegang.liu@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 4:43=E2=80=AFPM Hui Fang <hui.fang@nxp.com> wrote:
>
> On Tue, Sep 12, 2023 at 4:11=E2=80=AFPM Tomasz Figa <tfiga@chromium.org> =
wrote:
> > Is your DMA device restricted only to the bottom-most 4 GB (32-bit DMA
> > address)? If yes, would it make sense to also allocate from that area r=
ather
> > than bouncing the memory?
>
> The DMA device use 32-bit DMA address.
> From user space, can't control the v4l2 buffer address, may still change =
the
> code of vb2_dma_sg_alloc().

Right. You may want to try modifying vb2_dma_sg_alloc_compacted() to
use dma_alloc_pages() instead of alloc_pages().

Best regards,
Tomasz
