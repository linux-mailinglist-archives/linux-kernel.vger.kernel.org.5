Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDE27E6A8C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjKIM1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjKIM1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:27:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8736270C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 04:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699532782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1/haom+yH9xLwnE9aURcVj9dx4YOUUdXMdvnVMAeYqM=;
        b=HecThWgbZ6C6ynnvaiA5u144VgmDj3hSFaWTn+bmjBw2kNcU6zE8tnR1MyIm4vBIuTvt7M
        I0yxU28PrYVHhwiFDUZOyZirXAGjduhcXuF+q6fHTPWQ1wccLWfWu6IaODU0z3aNdwrpU+
        qe9SwYxgdW9RN1gu9hnGBz5bDvdix1g=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-ZMD9Qt1BMGm5HbMs5fOb1A-1; Thu, 09 Nov 2023 07:26:21 -0500
X-MC-Unique: ZMD9Qt1BMGm5HbMs5fOb1A-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5b596737797so1586247b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 04:26:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699532781; x=1700137581;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/haom+yH9xLwnE9aURcVj9dx4YOUUdXMdvnVMAeYqM=;
        b=oyC3BakxB4076uS/VZGfTNZsStwiygzIQIX8sH27+1PgTPFXV1DfubgXIYJw7XZliq
         Z06shIQZo+P7zQBUU4mfhAs0n1BnOlBHN8wHdWVgrDwdiuA8g/YkVkuVZ+8i9oowNcFu
         KJ5fP/pnMNdXiUcGScAb0xFvg0Dbxdf5j52u4p+CNoInRvI5sY5vG3/YxttOCOHMYQcq
         bJlrdUjmJiGj9J7E1YmboYWsW4BwJBdcFfQmQplZEUe2lR3H0bbRyn1VhoV6eOPeMVd7
         pFs+fHdd6wITFIxVfPXzLI1fmFNuWpmSA7HKj0Pa6xsLf/zhGj+O34+WLhsszm0lZR4L
         AeCA==
X-Gm-Message-State: AOJu0Yzd9MnuUJ/aDlWGTU0SDDVZWuM5aeB9ZROdCnky/N/Ff9FjSAew
        3UV3yOIIL4gTcAu/iEDCFvr61dEoX5/4iu7bazYSPAgIUmCG2UXjLgJCfpjnlTr6ZDivT4XpS22
        wgB54+Q973WDvdLUYDk4mQH43
X-Received: by 2002:a81:a941:0:b0:5a7:ba54:5127 with SMTP id g62-20020a81a941000000b005a7ba545127mr3971931ywh.3.1699532781106;
        Thu, 09 Nov 2023 04:26:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlXxTrprPZijY3/9XY14mMrwVZ8+lm8hhrgq8SG1ZGANmgzirEEjusP4RzmaSaOW2ShlenrA==
X-Received: by 2002:a81:a941:0:b0:5a7:ba54:5127 with SMTP id g62-20020a81a941000000b005a7ba545127mr3971916ywh.3.1699532780737;
        Thu, 09 Nov 2023 04:26:20 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id g24-20020ac84dd8000000b00417db2593bdsm1876925qtw.72.2023.11.09.04.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 04:26:20 -0800 (PST)
Message-ID: <ad66b532d1702c36adecd944e25f84e4497ef8b3.camel@redhat.com>
Subject: Re: [PATCH net v4 0/3] Fix large frames in the Gemini ethernet
 driver
From:   Paolo Abeni <pabeni@redhat.com>
To:     Vladimir Oltean <olteanv@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 09 Nov 2023 13:26:17 +0100
In-Reply-To: <20231109105037.zppxrr3bptd7a7i6@skbuf>
References: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
         <20231109105037.zppxrr3bptd7a7i6@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-09 at 12:50 +0200, Vladimir Oltean wrote:
> On Thu, Nov 09, 2023 at 10:03:11AM +0100, Linus Walleij wrote:
> > This is the result of a bug hunt for a problem with the
> > RTL8366RB DSA switch leading me wrong all over the place.
> >=20
> > I am indebted to Vladimir Oltean who as usual pointed
> > out where the real problem was, many thanks!
> >=20
> > Tryig to actually use big ("jumbo") frames on this
> > hardware uncovered the real bugs. Then I tested it on
> > the DSA switch and it indeed fixes the issue.
> >=20
> > To make sure it also works fine with big frames on
> > non-DSA devices I also copied a large video file over
> > scp to a device with maximum frame size, the data
> > was transported in large TCP packets ending up in
> > 0x7ff sized frames using software checksumming at
> > ~2.0 MB/s.
> >=20
> > If I set down the MTU to the standard 1500 bytes so
> > that hardware checksumming is used, the scp transfer
> > of the same file was slightly lower, ~1.8-1.9 MB/s.
> >=20
> > Despite this not being the best test it shows that
> > we can now stress the hardware with large frames
> > and that software checksum works fine.
> >=20
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
>=20
> Thanks for being persistent with this! I hope we didn't miss today's
> "net" pull request :)

I fear this is a bit too late for today's PR. I hope it should not be a
big problem, since we are very early in the release cycle.

Cheers,

Paolo

