Return-Path: <linux-kernel+bounces-164506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F998B7E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9CB91F23558
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D5C181323;
	Tue, 30 Apr 2024 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="CSoyvMe5"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF1717F385;
	Tue, 30 Apr 2024 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497862; cv=none; b=UqA60kMxGMLZ0IL7v0rtyYjNQHZfgIO5nz14NkXR/fokFUypt7cwSi7Ly8jTAHBJPQrFHGhr5Cs1i0aNOJgauibeuZtSA9qYENZu3eBx8wlk0cGuZa75dBplFDSaPFdLdmiFDwzU4ISUfG8ikefJgM4MS/mM++U5+Ez/eDsEuEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497862; c=relaxed/simple;
	bh=wyni/P2zqYEIwz4b2jPFOn7K/o20R+rMhqEI4gvwYGQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d19M+lG+DqN1/Eutlq46JzgRgVPsHuLov1r3uyq/ietPdJW16Rrnlp6bqGD4L9LsUgwQ68U5UWG/O0MEIbs305pwaP1cMsiwFLZXP9DKPrGttK70AOYoEOlIjvFtBdu+KlIkjcBt9hvMUlb90KV9lZb2+9aqLHpkPsAXLIJWTG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=CSoyvMe5; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Z+7S7yss0Z/3HfrJHfsoOEnXPR0d6itI8idhdLjGVt8=;
  b=CSoyvMe5xwRTMoiNMuI683b7Jk5rHr0SbfmYxPKCgJLai1z/UPqyMfsm
   kNOpdONPLwTO+QNaP116cerg0SZxKUsJOad+FL87HaJdh8c1GeV1W2fzc
   o0ZvYDgwl+IsXKIUDWLsjocO/xaqULgHUxKbneo06ZRlnM+DKXdKpUcqB
   E=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,242,1708383600"; 
   d="scan'208";a="86109162"
Received: from 12-176-169-194.cust.keyyo.net (HELO hadrien) ([194.169.176.12])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 19:23:08 +0200
Date: Tue, 30 Apr 2024 19:23:07 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: R Sundar <prosunofficial@gmail.com>
cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, mripard@kernel.org, 
    mchehab@kernel.org, linux-media@vger.kernel.org, 
    linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
    javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH linux-next] media:cdns-csi2tx: replace of_node_put() with
 __free
In-Reply-To: <f86b0c15-8fc4-4ed7-984a-3ab90c66a3eb@gmail.com>
Message-ID: <76b3d25-2ba3-2f9f-3ed6-61a63983a225@inria.fr>
References: <20240429171543.13032-1-prosunofficial@gmail.com> <6df5d715-3e31-40a5-9db3-2c3b9f12efac@wanadoo.fr> <f86b0c15-8fc4-4ed7-984a-3ab90c66a3eb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-728899255-1714497787=:3106"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-728899255-1714497787=:3106
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 30 Apr 2024, R Sundar wrote:

> On 30/04/24 00:10, Christophe JAILLET wrote:
> > Le 29/04/2024 à 19:15, R Sundar a écrit :
> > > Use the new cleanup magic to replace of_node_put() with
> > > __free(device_node) marking to auto release when they get out of scope.
> > >
> > > Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > > Signed-off-by: R Sundar <prosunofficial@gmail.com>
> > > ---
> > >   drivers/media/platform/cadence/cdns-csi2tx.c | 19 +++++++------------
> > >   1 file changed, 7 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/media/platform/cadence/cdns-csi2tx.c
> > > b/drivers/media/platform/cadence/cdns-csi2tx.c
> > > index 3d98f91f1bee..88aed2f299fd 100644
> > > --- a/drivers/media/platform/cadence/cdns-csi2tx.c
> > > +++ b/drivers/media/platform/cadence/cdns-csi2tx.c
> > > @@ -496,48 +496,43 @@ static int csi2tx_get_resources(struct csi2tx_priv
> > > *csi2tx,
> > >   static int csi2tx_check_lanes(struct csi2tx_priv *csi2tx)
> > >   {
> > >       struct v4l2_fwnode_endpoint v4l2_ep = { .bus_type = 0 };
> > > -    struct device_node *ep;
> > >       int ret, i;
> > > -
> > > -    ep = of_graph_get_endpoint_by_regs(csi2tx->dev->of_node, 0, 0);
> > > +    struct device_node *ep __free(device_node) =
> > > +        of_graph_get_endpoint_by_regs(csi2tx->dev->of_node, 0, 0);
> > > +
> > >       if (!ep)
> > >           return -EINVAL;
> > >       ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep), &v4l2_ep);
> > >       if (ret) {
> > >           dev_err(csi2tx->dev, "Could not parse v4l2 endpoint\n");
> > > -        goto out;
> > > +        return ret;
> > >       }
> > >       if (v4l2_ep.bus_type != V4L2_MBUS_CSI2_DPHY) {
> > >           dev_err(csi2tx->dev, "Unsupported media bus type: 0x%x\n",
> > >               v4l2_ep.bus_type);
> > > -        ret = -EINVAL;
> > > -        goto out;
> > > +        return -EINVAL;
> > >       }
> > >       csi2tx->num_lanes = v4l2_ep.bus.mipi_csi2.num_data_lanes;
> > >       if (csi2tx->num_lanes > csi2tx->max_lanes) {
> > >           dev_err(csi2tx->dev,
> > >               "Current configuration uses more lanes than supported\n");
> > > -        ret = -EINVAL;
> > > -        goto out;
> > > +        return -EINVAL;
> > >       }
> > >       for (i = 0; i < csi2tx->num_lanes; i++) {
> > >           if (v4l2_ep.bus.mipi_csi2.data_lanes[i] < 1) {
> > >               dev_err(csi2tx->dev, "Invalid lane[%d] number: %u\n",
> > >                   i, v4l2_ep.bus.mipi_csi2.data_lanes[i]);
> > > -            ret = -EINVAL;
> > > -            goto out;
> > > +            return -EINVAL;
> > >           }
> > >       }
> > >       memcpy(csi2tx->lanes, v4l2_ep.bus.mipi_csi2.data_lanes,
> > >              sizeof(csi2tx->lanes));
> > > -out:
> > > -    of_node_put(ep);
> > >       return ret;
> >
> > Hi,
> >
> > Nit: return 0; ?
> >
> > CJ
> >
> > >   }
> >
> Hi,
>
> In success case, ret variable value also will be zero, else for non-zero ret
> value it will return from v4l2_fwnode_endpoint_parse()'s error case handling
> block.

Indeed, but it seems that the return ret at the end of the function always
returns 0?  If that is the case, return 0 would be better, as one can see
that that code is only reached in the success case.

julia
--8323329-728899255-1714497787=:3106--

