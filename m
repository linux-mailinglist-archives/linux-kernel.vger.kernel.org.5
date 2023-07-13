Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E7F752BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbjGMUgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjGMUge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DE92120
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689280547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WVgpZ8lQKOwdGxh2onlmjRJMoFI1HaOmtUktQySa1w4=;
        b=brAghUeEi5zm7m+NPYv9vZQ0dwGQRnDouoQDfN1E1wZMIVXlIukP9Yd0R21SknFIXiKQ8x
        qo+6Eq08ZpXY+06e6x8L1P1YZAmgUhlu4+6hNtsKNCQU4yBVy3HVlfhwWW5Q/2dacI/zp5
        ldab4W6esPZp9rYpMImkaKKmz7E41Bw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-NXpDNUMyMSW8uQwNgBpIow-1; Thu, 13 Jul 2023 16:35:45 -0400
X-MC-Unique: NXpDNUMyMSW8uQwNgBpIow-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31400956ce8so722731f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689280544; x=1691872544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVgpZ8lQKOwdGxh2onlmjRJMoFI1HaOmtUktQySa1w4=;
        b=IUVaVntgk0Y1mQ9VGqwLBvGfnHWDkDnWvfKOY9uFq+oU6gkBOp45+S107owNIXzbpf
         +ovrZReq25pY1bDVbBitRc2ROA5EGFY//f7AwHNmlhasSVGxK0snS/XJ4gHanebbTkw6
         N4EMMefETpKghBKdmZgfKMGDV7nlSLepXz8HgpuWXUfAwADlW1FEtLT0WwLDUvqxlXKW
         3O2GRdvSjbOCs/hXEoqQgYK+pKquKuQhigBwGV+v6IuDZd+sBapKb2GWnfQrpdk93dcj
         KS3KAtgUVjZtrQis87uCSYYuAtVNXxSO0fPJ+o5AO04BmHnecLGmCB0LWr9nJ03Bjjw5
         ulYg==
X-Gm-Message-State: ABy/qLbwnUPeeoqhtmKhe6BCCq/w4l9r0dyRz45pGQvIyZMb4xpwEmdq
        QXEAxS8tcTb6P+GrICGlu8wtvDEvBBBwU2ZKCEqsSCo1jvjIOCNs1rJk6ILlCMjgGTnjaL+ks5j
        WYNLNdkcFp8GE90KUAvEs6mrNH64OG/yt9GYypON1
X-Received: by 2002:adf:e60f:0:b0:314:1ad7:2ea8 with SMTP id p15-20020adfe60f000000b003141ad72ea8mr2264237wrm.54.1689280544727;
        Thu, 13 Jul 2023 13:35:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHOrNFSNqO2ibgNG8U5/2UOpb0BAv2NtxVH0GEXiTL3/xlDsfILHX94fg3ANCKRsk4V/3fsHjacWFA3C9imx4A=
X-Received: by 2002:adf:e60f:0:b0:314:1ad7:2ea8 with SMTP id
 p15-20020adfe60f000000b003141ad72ea8mr2264232wrm.54.1689280544417; Thu, 13
 Jul 2023 13:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230620133711.22840-1-dwagner@suse.de> <20230620133711.22840-5-dwagner@suse.de>
 <594f73f2-59b0-bbcb-d7a0-6d89e2446830@gmail.com> <7kcc75btp5bo5oqjnpqlwwo37l2f4atwfemknbmvqagrqicl2i@njn4tai7e4m7>
In-Reply-To: <7kcc75btp5bo5oqjnpqlwwo37l2f4atwfemknbmvqagrqicl2i@njn4tai7e4m7>
From:   Ewan Milne <emilne@redhat.com>
Date:   Thu, 13 Jul 2023 16:35:33 -0400
Message-ID: <CAGtn9rmDDqXKH2XfqKXww7aOKmNG6vwuPEsy6bXmABaWvHvd7Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] nvme-fc: Make initial connect attempt synchronous
To:     Daniel Wagner <dwagner@suse.de>
Cc:     James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Shin'ichiro Kawasaki" <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The basic issue I am trying to solve with NVMe/FC is that we cannot get sys=
tems
to boot reliably from NVMe/FC (boot from SAN) because we don't know how lon=
g
the connect is going to take, and we have seen spurious failures in our tes=
ting.

In general, I think the whole business of a userspace syscall() -> asynchro=
nous
work in the kernel is problematic because the syscall can return a good sta=
tus
even if the connect is never going to work due to a condition that is
not going to
clear.  It is difficult and cumbersome to script around this reliably.

So what I am saying is the current mechanism doesn't work completely
right anyway.

We also encounter the problem Daniel is addressing trying to get
blktests and other
internal tests to work, for similar reasons.

-Ewan

On Thu, Jul 6, 2023 at 8:07=E2=80=AFAM Daniel Wagner <dwagner@suse.de> wrot=
e:
>
> Hi James,
>
> On Sat, Jul 01, 2023 at 05:11:11AM -0700, James Smart wrote:
> > As much as you want to make this change to make transports "similar", I=
 am
> > dead set against it unless you are completing a long qualification of t=
he
> > change on real FC hardware and FC-NVME devices. There is probably 1.5 y=
rs of
> > testing of different race conditions that drove this change. You cannot
> > declare success from a simplistic toy tool such as fcloop for validatio=
n.
> >
> > The original issues exist, probably have even morphed given the time fr=
om
> > the original change, and this will seriously disrupt the transport and =
any
> > downstream releases.  So I have a very strong NACK on this change.
> >
> > Yes - things such as the connect failure results are difficult to retur=
n
> > back to nvme-cli. I have had many gripes about the nvme-cli's behavior =
over
> > the years, especially on negative cases due to race conditions which
> > required retries. It still fails this miserably.  The async reconnect p=
ath
> > solved many of these issues for fc.
> >
> > For the auth failure, how do we deal with things if auth fails over tim=
e as
> > reconnects fail due to a credential changes ?  I would think commonalit=
y of
> > this behavior drives part of the choice.
>
> Alright, what do you think about the idea to introduce a new '--sync' opt=
ion to
> nvme-cli which forwards this info to the kernel that we want to wait for =
the
> initial connect to succeed or fail? Obviously, this needs to handle signa=
ls too.
>
> From what I understood this is also what Ewan would like to have.
>
> Hannes thought it would make sense to use the same initial connect logic =
in
> tcp/rdma, because there could also be transient erros (e.g. spanning tree
> protocol). In short making the tcp/rdma do the same thing as fc?
>
> So let's drop the final patch from this series for the time. Could you gi=
ve some
> feedback on the rest of the patches?
>
> Thanks,
> Daniel
>

