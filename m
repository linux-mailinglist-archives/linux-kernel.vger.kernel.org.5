Return-Path: <linux-kernel+bounces-49629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBE7846D47
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 545B5B2E0EC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB2E7C099;
	Fri,  2 Feb 2024 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VtW2GsYk"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A4A60243
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867890; cv=none; b=VKInrcO5+YGI1GUfpTE6fXc8vXLvkFQ9iaJ/bajo2cBabdBnCZIVDBUIbLMRFYUQxyf4U89zQIgw9+V8Hzzhn8mEfkqf5VLiuJ/hm0gCXmMpAETexuczVD7/LEJpWUhCt58f+pD3lkoaNbWDlqF5+gZUImR1KvPIup9lUi2DZkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867890; c=relaxed/simple;
	bh=l6H1gbJcCr35vCqymXlCF/h8YZTcgy5+Gozii0AQ/Yc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=VXJGJ2kw4E+gF0Mq/+AKAhm6ztV7sSS1FGFuNewUFu8O2/rCeG56h6RotYM9EM2Z1L4QLIXMq2NqVpcczXrS7OVCr2HEVaclMMsST9drQUGT/oMhkBEg+VeCBSecLTC5qpp+8LFo7D7H8JNCN+KHW8OwOkt9U2KfyZLSQAVZTOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VtW2GsYk; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706867885; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=l6H1gbJcCr35vCqymXlCF/h8YZTcgy5+Gozii0AQ/Yc=;
	b=VtW2GsYk4mewzbmehG90uH16kg/G6HTAuXseg+1Fc+uK6A/6Nac4p3VSRt+n4EqdO/FeBeuEUsmZNMaRdYG4JPKHiconD6XTdCYf3+l0ga35tPkF+xd2y5XMvgXu/6ujfFkRBXwTryN3cqgdxS6Ki4ewmxEXehMlSsa8Zpjh/Pg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.wcDWh_1706867884;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.wcDWh_1706867884)
          by smtp.aliyun-inc.com;
          Fri, 02 Feb 2024 17:58:05 +0800
Message-ID: <1706867854.8480594-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4] virtio_net: Support RX hash XDP hint
Date: Fri, 2 Feb 2024 17:57:34 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: mst@redhat.com,
 hengqi@linux.alibaba.com,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>
References: <20240131035535.22258-1-liangchen.linux@gmail.com>
 <CACGkMEuaGiH4H3pvjTK5rUh0DmL9ZMsLRaVQ3+5GOfnrj8OxPA@mail.gmail.com>
 <CAKhg4tL3E_AfsEOyzUr13zcbjzzUY1v5VXdAGMLDYdy5om35NQ@mail.gmail.com>
In-Reply-To: <CAKhg4tL3E_AfsEOyzUr13zcbjzzUY1v5VXdAGMLDYdy5om35NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Fri, 2 Feb 2024 17:25:02 +0800, Liang Chen <liangchen.linux@gmail.com> w=
rote:
> On Thu, Feb 1, 2024 at 1:37=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Wed, Jan 31, 2024 at 11:55=E2=80=AFAM Liang Chen <liangchen.linux@gm=
ail.com> wrote:
> > >
> > > The RSS hash report is a feature that's part of the virtio specificat=
ion.
> > > Currently, virtio backends like qemu, vdpa (mlx5), and potentially vh=
ost
> > > (still a work in progress as per [1]) support this feature. While the
> > > capability to obtain the RSS hash has been enabled in the normal path,
> > > it's currently missing in the XDP path. Therefore, we are introducing
> > > XDP hints through kfuncs to allow XDP programs to access the RSS hash.
> > >
> > > 1.
> > > https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@day=
nix.com/#r
> > >
> > > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > Thanks
>
> I've just realized that I forgot to include netdev@vger.kernel.org in
> the cc list. Would it be advisable for me to resend the patch with
> netdev@vger.kernel.org in the cc list to ensure it receives the
> necessary attention for potential merging? Thanks!

Did you use ./scripts/get_maintainer.pl?

Please resend it.

Thanks.


>
> Thanks,
> Liang
> >

