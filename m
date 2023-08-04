Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFCA7709E9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjHDUmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjHDUmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:42:09 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5B6E48
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:42:07 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-56ca4d7079aso1749670eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 13:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1691181727; x=1691786527;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=249ycHqM4buC+8/ZQ59dw3xP72SAUA6j7QbwO1h3mxE=;
        b=e590hj7kADFb6FxZuo+skH4jnJ+Tsa3qg1V8Dm4GZkVonzuFxtn4AqlBK1DnQkgCEx
         Xprgo6Xo4IZ4tnfQr8ZTvF4mJ8E8YB+AgQ4DilFzN0Kas3lC2WeeRHfoxzArd5kJW+3l
         /m68zffVG4IlFkE06iEMBW6+paEKQXjyNrxoqNoEV4chmovILplQTmdPEIHOtTBRNp6Y
         imMI23+y/unnHcF1jKx7huqcooPdkou+KalSrxSihc9THbGGtWUwziioZyi6TOUMSp/X
         9F7MICnQDNdBvscvnzrudEJ+gsTgrJOSjz032BG+pMJ0Je10PfSlWLyCnqUfe9u7Wnut
         a9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691181727; x=1691786527;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=249ycHqM4buC+8/ZQ59dw3xP72SAUA6j7QbwO1h3mxE=;
        b=YWaT2Ogm5Op2G0FHXIUd0+v4ss+YbOm/SpEtsamVqIH57aGxHwB7r0EDMo97W44slK
         2sxq13qTPDUtdSOzIhFaZiFm4ZVajPJY9oBV6YSRgir/TmGHfbMdXXJxeyeqrU9qY5rN
         hoauxv3PbkT3xFYhZiv3Fw7csic4+0PByBgN+unU9u/WKNWkIto0JygeLxdCjKmLJRcZ
         /p0iowiddsMrAo/0S4c5aaLGQJaNGoGtHufkw1xSQI/BMKvtLxcCwutF4iNpR5EQZL7j
         zrUwP0/o4jQghM2tpiH5oh+a1bJnjwJHtZU2DzF3SZjMPsN+hGcLfH9UCyyz4GmzWRB7
         V4EA==
X-Gm-Message-State: AOJu0YyQooZsu7qF42RD38e3FL6e++01oh0jG4Blu5YPGl/Y48pUaKUE
        Hkl4aJCikxi2qbIrIrnTS9BMRQ==
X-Google-Smtp-Source: AGHT+IHwpOK1vj2nnOOjZdZJHGclvpYw6PjaHLgkacsGSRe+RKgyaXlCV2IWiLU0F17xr357n3DikQ==
X-Received: by 2002:a05:6358:3384:b0:139:9d20:9f60 with SMTP id i4-20020a056358338400b001399d209f60mr2305107rwd.11.1691181727176;
        Fri, 04 Aug 2023 13:42:07 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:bae9::7a9])
        by smtp.gmail.com with ESMTPSA id c17-20020a0cf2d1000000b0063d1f967268sm918458qvm.111.2023.08.04.13.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 13:42:06 -0700 (PDT)
Message-ID: <8a2b68f1e8da19a8d81535e0ff4391e99691e141.camel@ndufresne.ca>
Subject: Re: [PATCH 2/2] media: v4l2-mem2mem: add a list for buf used by hw
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Randy Li <ayaka@soulik.info>
Cc:     linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        Hsia-Jun Li <Randy.Li@synaptics.com>, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, hiroh@chromium.org,
        hans.verkuil@cisco.com, hverkuil@xs4all.nl,
        linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        p.zabel@pengutronix.de, ezequiel@vanguardiasur.com.ar
Date:   Fri, 04 Aug 2023 16:42:05 -0400
In-Reply-To: <585fdf97-4ed9-7d9a-78a8-e271d5b05301@soulik.info>
References: <20230704040044.681850-1-randy.li@synaptics.com>
         <20230704040044.681850-3-randy.li@synaptics.com>
         <20230712093301.nkj2vok2x7esdhb3@chromium.org>
         <f8f766c0166c502e29b06cda71f6531e44a91a17.camel@ndufresne.ca>
         <CAAFQd5CO4TS6wMsnaL7ob4CXogj5KT52x85YUUN1ZwDkOxW0oQ@mail.gmail.com>
         <583e22718b80cc5e1ae631528c83c95e97de5cae.camel@ndufresne.ca>
         <CAAFQd5CAJ7GxiY5=bBAa+L=1WJth6QZ3+PG83=GX+eEx1S4uhg@mail.gmail.com>
         <7d340df3-e14c-24de-4fc2-b7dca619447c@synaptics.com>
         <CAAFQd5BKHQPNVpDvpQaFn-q721BJknJCUB72urc2=EKsAH=OCg@mail.gmail.com>
         <10ad26e6-b2d0-d0e6-40c8-2cc70613188b@synaptics.com>
         <70ed7b3197f34c9f3dce9c83c527884c89df5449.camel@ndufresne.ca>
         <585fdf97-4ed9-7d9a-78a8-e271d5b05301@soulik.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Le vendredi 04 ao=C3=BBt 2023 =C3=A0 00:16 +0800, Randy Li a =C3=A9crit=C2=
=A0:
> On 2023/7/29 00:19, Nicolas Dufresne wrote:
> > Le vendredi 28 juillet 2023 =C3=A0 15:37 +0800, Hsia-Jun Li a =C3=A9cri=
t=C2=A0:
> > > > I think this is one reason to migrate to the stateless decoder desi=
gn.
> > > >=20
> > > I didn't know such plan here. I don't think the current stateless API
> > > could export the reconstruction buffers for encoder or post-processin=
g
> > > buffer for decoder to us.
> > Someone suggested introduce auxiliary queues in our meeting in Lyon a w=
hile ago,
> > but I bet everyone got too busy with finalizing APIs, fixing fluster te=
sts etc.
> > The suggestion felt like it would be possible to add it after the fact.=
 This was
> > also being discussed in the context of supporting multi-scalers (standa=
lone our
> > inline with the codec, like VC8000D+). It could also cover for primary =
and
> > secondary buffers, along with encoder primary, and reconstruction buffe=
rs, but
> > also auxiliary reference data. This would also be needed to properly su=
pport
> > Vulkan Video fwiw, and could also help with a transition to DMABuf Heap=
s and
> > memory accounting.
> >=20
> > I've also had corridor discussion around having multi-instance media co=
nstroller
> > devices. It wasn't clear how to bind the media instance to the video no=
de
> > instances, but assuming there is a way, it would be a tad more flexible=
 (but
> > massively more complex).
>=20
> I think we should answer to those questions before we decided what we wan=
t:
>=20
> A. Should a queue only has the buffers for the same format and sizes?

I initially started answering these, but ended up concluding this is more s=
ome
sort of personal notes. I believe the discussion is diverging. Remember tha=
t in
an existing API, one cannot fix all theoretical issues in one go. In order =
to
move forward, you have to tackle very specific use case and find a way forw=
ard.
If you are to break compatibility as much as you suggest, you'd rather look=
 into
writing a new API.

[...]
