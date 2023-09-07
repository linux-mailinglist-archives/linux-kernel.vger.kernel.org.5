Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C692E797B29
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbjIGSGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238288AbjIGSFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:05:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A791710;
        Thu,  7 Sep 2023 11:04:55 -0700 (PDT)
Date:   Thu, 7 Sep 2023 12:15:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694081728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cq8rae8UZhseve8ECsfKS9IcW0y6Ca5VZnDm6gs+Jes=;
        b=MdkPSIZ/ynC2raAdMlJZvDo2L3P/3lIogpcaDXFrLH9+JudFvEqpMKSdQQNkfHsUposgoZ
        5mgUStkvFDTFQNRBbBdZf/gVnHVza23KbQtvVuNdg6adnK6afucoW2iAva9UM1D6BrUXLe
        06PyA+kdFWPCXBEacA7RvklmkkYr2F5sFrJLtocpwTyqMDARS0m3P7ldhsJcf7S2sNiR0L
        SHREku/NK+p6Cb2+Chl5DM70I1wHAJ2ErkbU94thVcOgkfC0n3My34oEWqocLqRRAbz4sh
        +7X/dvC2SM/nN8t9R6mIBP5uLk9QA2mR68GUoneVQ4vPdaSAZAcujY6C7RxpuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694081728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cq8rae8UZhseve8ECsfKS9IcW0y6Ca5VZnDm6gs+Jes=;
        b=OvnOiF36jjpXi1C6cMeCm/YLONfshth+JYHRtDt94iVOW2dW6MJz21RlxSjf38BkHlqMqE
        tnbJZ/2en32SHZBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        "linyunsheng@huawei.com" <linyunsheng@huawei.com>
Subject: Re: RE: [EXT] Re: [PATCH net v2] octeontx2-pf: Fix page pool cache
 index corruption.
Message-ID: <20230907101527.45YwOJcG@linutronix.de>
References: <20230907014711.3869840-1-rkannoth@marvell.com>
 <20230907070955.0kdmjXbB@linutronix.de>
 <MWHPR1801MB19187A03AF45B0E23B534B6BD3EEA@MWHPR1801MB1918.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <MWHPR1801MB19187A03AF45B0E23B534B6BD3EEA@MWHPR1801MB1918.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-07 08:15:58 [+0000], Ratheesh Kannoth wrote:
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Subject: [EXT] Re: [PATCH net v2] octeontx2-pf: Fix page pool cache ind=
ex
> > corruption.
> > >  	cq->refill_task_sched =3D false;
> > > +
> > > +	local_bh_disable();
> > > +	napi_schedule(wrk->napi);
> > > +	local_bh_enable();
> >=20
> > This is a nitpick since I haven't look how it works exactly: Is it poss=
ible that the
> > wrk->napi pointer gets overwritten by
> > otx2_napi_handler() since you cleared cq->refill_task_sched() earlier?
> I don=E2=80=99t see any issue here.  As NAPI and workqueue execution is s=
erialized (as interrupt is disabled when=20
> Workqueue is scheduled).  I don=E2=80=99t think we can move "refill_task_=
sched =3D false" after local_bh_enable().=20
> But we can move refill_task_sched =3D false as below . but I don=E2=80=99=
t see a need.=20

Right, there might be no issue I was just asking. I don't know how the
cq <-> NAPI mapping is working. If you say that there is no race/issue,
okay ;)

>  +
>  +	local_bh_disable();
>  +	napi_schedule(wrk->napi);
>   +	cq->refill_task_sched =3D false;
>  +	local_bh_enable();

Sebastian
