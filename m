Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660F57CF179
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjJSHkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbjJSHkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:40:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B92F12D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:40:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53f98cbcd76so3379a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697701200; x=1698306000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWavqM6arQNElYvYw/XKPSNP8Oucxbnt8dSEavyv3es=;
        b=KVEpErImyt7v6HgglO4ZZFG9UHehT5R0w9q7lWlzpaO63zsl0DqilCTIUhIDp3yOqi
         PAVxnbuIEb8soCb7/7/GzvgGudKAk2yf8p+UrzmaZ5t7cT4MdBFlQGcJ94q5AraOUmFa
         +TgdUAQxKZ9hmkDah6jKegvZiL82SrnOzZXFT/9hDuBpa3+Zt8RKdBJ8d1AyfaIaQc8O
         vbyTBDO2KoEKqVszx30yvWr8HprmcNpz8iw5jak9pio+/HZk6PjQGzhjg3WCBDZCRPRG
         1YUB+GNsWCPOA9DcZ6qP2/YBuqIbuALb8XUTYWvhdSoq+2Qz5c6ok/EEqmsae/o2BYc5
         ox9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697701200; x=1698306000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWavqM6arQNElYvYw/XKPSNP8Oucxbnt8dSEavyv3es=;
        b=LMP0xrTmzOgEV5CACVZ4nlqjREENQTUR+LuYKcayyFQQHgfiyiLEhYYTy2yc9cWUjy
         LEa1Kzjd5RastUTDY7fyDrhhS5RfG5uBmzXcF1eVJnSB5Y04dCSOwRSdESR9KvVXv2zh
         nO0GOBczseImAJSHeFXNoXS1dcb7F5KYgob4+uqv666hsOw7Z2lZFeumQE8xUTcwV4O0
         3736pOd6ynRlnVV8KyttNS0CV+EcdOLoGdtLl7T++y7bm1Sy/yMzRhA7aaNyJnVNkba0
         5/bG8yR3EOHaSaMNgL5/7yid0rTzyjvjKDABh3fvAw9HwpI+ngFGrtfK+bPm3ea9Wpy/
         ylHg==
X-Gm-Message-State: AOJu0YzL4M02R4Gqs7HDvAZC+AFRmDcn9MgSTnF+dUMb0LhXCsWLKSca
        nufLa55Zj+ziQfg2aSGAQC2AiiMa4XYiMGTwfI0Mag==
X-Google-Smtp-Source: AGHT+IE3bnRKjOzno0YQxKvX1Er/AEQw13u10fDJO85JVeZ4aPBDjI3kp+r5eJM2IrlQet7VWcR2ijoFP+iNgufJQZg=
X-Received: by 2002:aa7:da53:0:b0:53f:9265:bd0d with SMTP id
 w19-20020aa7da53000000b0053f9265bd0dmr53704eds.5.1697701200143; Thu, 19 Oct
 2023 00:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR0702MB3840EB26EF2A1A35BFEA53BFD9D5A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231018154205.GT800259@ZenIV> <VI1PR0702MB3840F2D594B9681BF2E0CD81D9D4A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231019050250.GV800259@ZenIV> <20231019061427.GW800259@ZenIV> <20231019063925.GX800259@ZenIV>
In-Reply-To: <20231019063925.GX800259@ZenIV>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 19 Oct 2023 09:39:45 +0200
Message-ID: <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
Subject: Re: AW: [PATCH] amd64: Fix csum_partial_copy_generic()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     gus Gusenleitner Klaus <gus@keba.com>,
        Al Viro <viro@ftp.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 8:39=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Thu, Oct 19, 2023 at 07:14:27AM +0100, Al Viro wrote:
> > On Thu, Oct 19, 2023 at 06:02:50AM +0100, Al Viro wrote:
> > > On Thu, Oct 19, 2023 at 04:44:04AM +0000, gus Gusenleitner Klaus wrot=
e:
> > > > > On Wed, Oct 18, 2023 at 06:18:05AM +0000, gus Gusenleitner Klaus =
wrote:
> > > > > > The checksum calculation is wrong in case of an source buffer
> > > > > > containing zero bytes only. The expected return value is 0, the
> > > > > > actual return value is 0xfffffff.
> > > > >
> > > > > Expected where?  The actual checksum is defined modulo 0xffff, so
> > > > > 0 and 0xffffffff represent the same final value.
> > > > >
> > > > > The only twist is that in some situations we internally use 0 for
> > > > > "not calculated yet".
> > > > >
> > > > > > This problem occurs when a ICMP echo reply is sent that has set
> > > > > > zero identifier, sequence number and data.
> > > > >
> > > > > What problem?  Could you please either point to specific RFC or
> > > > > show that packets are rejected by some existing system, or...?
> > > >
> > > > Here's our situation:
> > > > Our device gets pinged by a third party manufacturer robot controll=
er.
> > > > We have updated the kernel in our device to 5.15 from 4.9, the robo=
t
> > > > controller is kept unchanged. At 4.9, our device's ping reply is ac=
cepted
> > > > by the robot controller, at 5.15 it's not.
> > > >
> > > > Wireshark shows a bad checksum warning:
> > > >  'Checksum: 0x0000 incorrect, should be 0xffff'
> > > >
> > >
> > > Lovely.  I think I see what's going on, give me a few to think about =
it...
> >
> > The real source of trouble was switching csum_and_copy_{to,from}_user()
> > to reporting faults as 0.  And yes, it's broken.  Bugger...
>
> I really hate the idea of bringing back the old horrors and splitting
> _nocheck and _user variants ;-/  Especially since we don't care (and
> never had, really) where in the EFAULT case had the damn thing faulted
> and what csum had it managed to accumulate prior to that point.
>
> The only callers are csum_and_copy_..._iter() and they discard
> the entire iovec segment if fault happens; all users of
> csum_and_copy_from_iter() are actually discarding everything in
> that case (reverting iterator to the point where it had been
> prior to the call).
>
> And they are all thread-synchronous.  Hell, it's tempting to steal
> a thread flag, clear it before the call of those suckers, set it in
> exception handlers in those and check in csum_and_copy_..._iter()
> after the call...  Let me see how ugly something of that sort would
> be...

I wonder if the csum_and_copy_...() helpers are really needed in modern day=
s,
with much bigger cpu caches.

Maybe we could remove them and use more standard copy + standard
checksum over kernel buffers.
