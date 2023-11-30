Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A077E7FE6D8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344158AbjK3Cfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjK3Cfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:35:31 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226ACD7F;
        Wed, 29 Nov 2023 18:35:36 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VxPkUUK_1701311734;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VxPkUUK_1701311734)
          by smtp.aliyun-inc.com;
          Thu, 30 Nov 2023 10:35:34 +0800
Message-ID: <1701311694.1163726-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 2/5] virtio_net: Add page_pool support to improve performance
Date:   Thu, 30 Nov 2023 10:34:54 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     Liang Chen <liangchen.linux@gmail.com>, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, pabeni@redhat.com, alexander.duyck@gmail.com,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
 <20230526054621.18371-2-liangchen.linux@gmail.com>
 <c745f67e-91e6-4a32-93f2-dc715056eb51@linux.dev>
 <20231129095825-mutt-send-email-mst@kernel.org>
 <b699fbc8-260a-48e9-b6cc-8bfecd09afed@linux.dev>
 <0c2efe49-03db-4616-a4e5-26ff0434e323@linux.dev>
In-Reply-To: <0c2efe49-03db-4616-a4e5-26ff0434e323@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 23:29:10 +0800, Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>
> =E5=9C=A8 2023/11/29 23:22, Zhu Yanjun =E5=86=99=E9=81=93:
> >
> > =E5=9C=A8 2023/11/29 22:59, Michael S. Tsirkin =E5=86=99=E9=81=93:
> >> On Wed, Nov 29, 2023 at 10:50:57PM +0800, Zhu Yanjun wrote:
> >>> =E5=9C=A8 2023/5/26 13:46, Liang Chen =E5=86=99=E9=81=93:
> >>
> >> what made you respond to a patch from May, now?
> >
> > I want to apply page_pool to our virtio_net. This virtio_net works on
> > our device.
> >
> > I want to verify whether page_pool on virtio_net with our device can
> > improve the performance or not.
> >
> > And I found that ethtool is wrong.
> >
> > I use virtio_net on our device. I found that page member variable in
> > rq is not used in recv path.
> >
> > When virtio_net is modprobe, I checked page member variable in rq with
> > kprobe or crash tool.=C2=A0 page member variable in rq is always NULL.
> >
> > But sg in recv path is used.
> >
> > So how to use page member variable in rq? If page member variable in
> > rq is always NULL, can we remove it?
> >
> > BTW, I use ping and iperf tool to make tests with virtio_net. In the
> > tests, page member variable in rq is always NULL.
>
>
> And I replaced page member variable in rq with page_pool, but the
> statistics of page_pool are always 0.
>
> It is interesting that page_pool member variable in rq is not used in
> ping and iperf tests.
>
> I am not sure what tests can make page member variable not NULL. ^_^

Do you mean rq->pages?

That is for big mode.

Thanks.


>
> Best Regards,
>
> Zhu Yanjun
>
>
> >
> > It is interesting.
> >
> > Zhu Yanjun
> >
> >>
