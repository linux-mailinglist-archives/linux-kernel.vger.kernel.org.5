Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03671773728
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjHHC4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjHHC4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:56:49 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E5710C4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:56:48 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-76ad8892d49so454953685a.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 19:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691463407; x=1692068207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GX0N26I0qKYcD48uhAl1BajrNAHzwO8xUz/Vp1nLk6k=;
        b=A1bQ243yHr+PH7ZK4rJ666WNy4S25xlNYKQ+Z60tWAF91FeR5awJflNFzSNT8R52oQ
         c5Rc5GglYV6/FaE1GXf1ryovrJEXSeeXIRC6V6jfEQY4XSRGPfc7/3p0aHU7DglR4Sou
         6zZVF7twlusHn5qDE4+KGwPvgmuY5lfzZS0Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691463407; x=1692068207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GX0N26I0qKYcD48uhAl1BajrNAHzwO8xUz/Vp1nLk6k=;
        b=eDMDfD0u2ambP6DKf3ZazRj0aMMGYCLuPrZ6I49q9ztlC+Pkt7XHfCqNn6rdpf7V1V
         6Xzgy9PXejnTDItvXw2rOsxzNO+R8CPRvGGCH4d7zlRDp3GMlCsmwGBZa04cNvO3dXVr
         2d+G8rQOW8MtWqypZIDX1PtO9e0wyhR1m2SKcEnwUrB5/gs++rN2pKpwDDANXQumtpO7
         QEVdzhe5sSyI6shUKpnT+w9j3e1K3aTXWsOuT9B8YWCfi23mtzWfbmmolHVCLVVQG6Xh
         Jm+PKW6pk2vqvbP0i4S1L2gTRBrUMb67GBGHfQ1OnDp9aHwhwq03NlxYKJwyfnsUQIon
         04ZA==
X-Gm-Message-State: AOJu0YwekokR4ZgR7kAq8hcm0Hx6GEC+5LqeyjrV0oUJGcHEWDrTKsmQ
        kGRH4BwfSl4S6lddgTbGACpEduQnYJqd5wGfGbHfzJTjTM/iUtk+
X-Google-Smtp-Source: AGHT+IEEmi702JC/AgpIWFM53OKSEfuBEW4q5OvlNG9tZxwNwJBukcOv8+8FbrlDfbVIuiAp5i4GrGQABIZWmyP5y+k=
X-Received: by 2002:a05:620a:29c9:b0:76c:7f5e:3888 with SMTP id
 s9-20020a05620a29c900b0076c7f5e3888mr15523556qkp.50.1691463407258; Mon, 07
 Aug 2023 19:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230807082419.38780-1-miquel.raynal@bootlin.com>
 <CAGXv+5GaW5wtVqsN+GQJ6rzkmCq1R3c1xeZ=_hNmHmrkVZ=eug@mail.gmail.com>
 <20230807112040.55af2163@xps-13> <20230807162854.171ac18d@xps-13>
In-Reply-To: <20230807162854.171ac18d@xps-13>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 8 Aug 2023 10:56:36 +0800
Message-ID: <CAGXv+5GTOVhh3R0WJ7xOP5vq+MkKhQvUUjMGoLe39-2T8oqyLw@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] NVMEM cells in sysfs
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 10:28=E2=80=AFPM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hi Chen-Yu,
>
> miquel.raynal@bootlin.com wrote on Mon, 7 Aug 2023 11:20:40 +0200:
>
> > Hi Chen-Yu,
> >
> > wenst@chromium.org wrote on Mon, 7 Aug 2023 16:57:03 +0800:
> >
> > > On Mon, Aug 7, 2023 at 4:24=E2=80=AFPM Miquel Raynal <miquel.raynal@b=
ootlin.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > As part of a previous effort, support for dynamic NVMEM layouts was
> > > > brought into mainline, helping a lot in getting information from NV=
MEM
> > > > devices at non-static locations. One common example of NVMEM cell i=
s the
> > > > MAC address that must be used. Sometimes the cell content is mainly=
 (or
> > > > only) useful to the kernel, and sometimes it is not. Users might al=
so
> > > > want to know the content of cells such as: the manufacturing place =
and
> > > > date, the hardware version, the unique ID, etc. Two possibilities i=
n
> > > > this case: either the users re-implement their own parser to go thr=
ough
> > > > the whole device and search for the information they want, or the k=
ernel
> > > > can expose the content of the cells if deemed relevant. This second
> > > > approach sounds way more relevant than the first one to avoid usele=
ss
> > > > code duplication, so here is a series bringing NVMEM cells content =
to
> > > > the user through sysfs.
> > > >
> > > > Here is a real life example with a Marvell Armada 7040 TN48m switch=
:
> > > >
> > > > $ nvmem=3D/sys/bus/nvmem/devices/1-00563/
> > > > $ for i in `ls -1 $nvmem/cells/*`; do basename $i; hexdump -C $i | =
head -n1; done
> > > > country-code@77
> > > > 00000000  54 57                                             |TW|
> > > > crc32@88
> > > > 00000000  bb cd 51 98                                       |..Q.|
> > > > device-version@49
> > > > 00000000  02                                                |.|
> > > > diag-version@80
> > > > 00000000  56 31 2e 30 2e 30                                 |V1.0.0=
|
> > > > label-revision@4c
> > > > 00000000  44 31                                             |D1|
> > > > mac-address@2c
> > > > 00000000  18 be 92 13 9a 00                                 |......=
|
> > > > manufacture-date@34
> > > > 00000000  30 32 2f 32 34 2f 32 30  32 31 20 31 38 3a 35 39  |02/24/=
2021 18:59|
> > > > manufacturer@72
> > > > 00000000  44 4e 49                                          |DNI|
> > > > num-macs@6e
> > > > 00000000  00 40                                             |.@|
> > > > onie-version@61
> > > > 00000000  32 30 32 30 2e 31 31 2d  56 30 31                 |2020.1=
1-V01|
> > > > platform-name@50
> > > > 00000000  38 38 46 37 30 34 30 2f  38 38 46 36 38 32 30     |88F704=
0/88F6820|
> > > > product-name@d
> > > > 00000000  54 4e 34 38 4d 2d 50 2d  44 4e                    |TN48M-=
P-DN|
> > > > serial-number@19
> > > > 00000000  54 4e 34 38 31 50 32 54  57 32 30 34 32 30 33 32  |TN481P=
2TW2042032|
> > > > vendor@7b
> > > > 00000000  44 4e 49                                          |DNI|
> > > >
> > > > This layout with a cells/ folder containing one file per cell has b=
een
> > > > legitimately challenged by John Thomson. I am not against the idea =
of
> > > > having a sub-folder per cell but I did not find a relevant way to d=
o
> > > > that so for know I did not change the sysfs organization. If someon=
e
> > > > really wants this other layout, please provide a code snipped which=
 I
> > > > can integrate.
> > > >
> > > > Current support does not include:
> > > > * The knowledge of the type of data (binary vs. ASCII), so by defau=
lt
> > > >   all cells are exposed in binary form.
> > > > * Write support.
> > > >
> > > > Changes in v8:
> > > > * Fix a compilation warning whith !CONFIG_NVMEM_SYSFS.
> > > > * Add a patch to return NULL when no layout is found (reported by D=
an
> > > >   Carpenter).
> > > > * Fixed the documentation as well as the cover letter regarding the
> > > >   addition of addresses in the cell names.
> > >
> > > It seems this version no longer creates cells for legacy DT layout fo=
rmats?
> > > So while I assume the issue I ran into is fixed, I don't see any cell=
s
> > > created on the MT8183 either.
> > >
> > > Is this intended?
> >
> > Not at all, but I am surprised they are no longer created. I will add
> > fake cells and see how it behaves.
>
> Alright, I've got confused, the cells are still created, but in the
> 'legacy' case, they no longer appear in sysfs. I guess that's what you
> meant. I will move the sysfs creation to a better place indeed.

That's right, the cells in sysfs aren't created. Sorry for the confusion.
