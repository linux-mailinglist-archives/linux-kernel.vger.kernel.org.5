Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285F87826F0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbjHUKUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjHUKUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9679FC2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692613193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6J98QdNCW3hGvq/vmAAFfh6AyiQr3+OWRF+NTVCkrzw=;
        b=DkUHI4GRXcc0XOa3Gv2W0UP+ZmksiR26VAMaq8Cy50MQqwzW98gVZplpNSO1HQ1lQ1YJ1o
        V9NHksMhgP6E7fT1aCC2/8j/QN1bhZkw8akeoqPdefMiNkmtQAUNqWrFDAOc8AFOctNwqc
        zKfP4AaMwsVIVp60SbOlUmyeIqk+u4Y=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-JG4K6dm4O02Ey60nvUOBLQ-1; Mon, 21 Aug 2023 06:19:52 -0400
X-MC-Unique: JG4K6dm4O02Ey60nvUOBLQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-521a38098faso1917318a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692613191; x=1693217991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6J98QdNCW3hGvq/vmAAFfh6AyiQr3+OWRF+NTVCkrzw=;
        b=KLtS+YRX67OzXINlGkLD9NNxQI75GsWRulzxZl2St8f9aiDVnjuwRSIpXD7+j3MRBL
         P3w+wawPLd1cGcCL5if2CW+M+yWsiFkLNWL5SIL/m59ikgZqC4IiaE561t+uRFUtt2gl
         Rz7jFZWGfzB8NE+PSrTVlCOsCy/Lblp/9gxeBPzTKSOaZwTtcAsikwURzOOM83IY5GE4
         BI/sWpfrZKzQ5dyB5a1kmWG/D9c2JvOI1zSkpybwlWQHzSsrtPsjPb9i6bISm8FSv5nS
         JnNwl4/8dagxQwIRNcweAmmn64mVc78SYXkiTZdK2NKU4TnP57EfEkQlTcj5f0BWVA4W
         27bA==
X-Gm-Message-State: AOJu0Yy/MBNbsVRSq3SUT6JVig+KyUPB0p6Ona9z8226XWoJP3uiPKLZ
        8+jkA7baR1SAbKpB9eeMjmKEFK+8MeC/As7P0zfVZx+thFPEAcC+NgsNfMMhGgYmqM0D1PcMTq5
        oDH+U9RSTQ3Z9vK4694qitf5BNQqPcdaeoIFdJB9Z
X-Received: by 2002:aa7:d741:0:b0:522:ab06:7213 with SMTP id a1-20020aa7d741000000b00522ab067213mr4499900eds.27.1692613191320;
        Mon, 21 Aug 2023 03:19:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEczeFjtn1koyKYLXFdMW1w5mzWAvVlP2Ptfln+ymfh4TciXnX7kdQBk3KT1NYiJ34aiM9A/fFkyGmoZsUVwyE=
X-Received: by 2002:aa7:d741:0:b0:522:ab06:7213 with SMTP id
 a1-20020aa7d741000000b00522ab067213mr4499883eds.27.1692613191035; Mon, 21 Aug
 2023 03:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
 <ZMK60UphgVuj4Z+L@smile.fi.intel.com> <ZMydcGv8Dvu3Hje1@smile.fi.intel.com>
 <nycvar.YFH.7.76.2308071319140.14207@cbobk.fhfr.pm> <ZND/8wd67YbGs8d5@smile.fi.intel.com>
 <nycvar.YFH.7.76.2308141128260.14207@cbobk.fhfr.pm> <ZOMcHQc8Em/s6C+y@smile.fi.intel.com>
 <ez2oewpi3yeaiejrvbe433ude75pgm3k3s5sh5gnn7pvnzm7b4@ajuopfgwocft>
 <ZOMvpmoWLCgcAyJR@smile.fi.intel.com> <ZOMv4VB0bZpupNlN@smile.fi.intel.com>
In-Reply-To: <ZOMv4VB0bZpupNlN@smile.fi.intel.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 21 Aug 2023 12:19:39 +0200
Message-ID: <CAO-hwJ+Pa0yMV5taEc9+RXEWJzkotpyj4gz2qftyLV4G73F-mg@mail.gmail.com>
Subject: Re: [PATCH v1 00/12] HID: cp2112: Cleanups and refactorings
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Benjamin Tissoires <bentiss@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 11:35=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Aug 21, 2023 at 12:34:30PM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 21, 2023 at 10:51:04AM +0200, Benjamin Tissoires wrote:
> > > On Aug 21 2023, Andy Shevchenko wrote:
>
> ...
>
> > > Long story short, I'm not able to test it right now (and I got quite
> > > some backlog as you can imagine). IIRC the code was fine, so I think =
we
> > > can just take the series as is, and work on the quirks (if any) later=
.
> >
> > Thank you!
> >
> > The thing that might be broken is interrupts handling. If that works,
> > I'm pretty confident with the rest.
>
> I.o.w. first 5 patches to test is already 98% of guarantee that everythin=
g
> is fine.

Actually I applied you series locally, and applied Danny's patches on
top, and I could run your series in qemu with the cp2112 as USB
passthrough.

Everything is working fine, so I can take this one just now.

Cheers,
Benjamin

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

