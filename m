Return-Path: <linux-kernel+bounces-93347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AFE872E54
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC6F28B752
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250651B7FB;
	Wed,  6 Mar 2024 05:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSv2Czub"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE3918049
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 05:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709702914; cv=none; b=Q4shdxrfK6INTDycCahKiEc6u/XTADQPFheAAfoktaaRC0lcXeE/thuLJYLIokWjZFsKYYz4Tl0raq0J9Ainbjtp0Uk+YaqTtkl2ucVS9tOmFE0x54rmHCq5D4Fu0vwJeAnzHhtgBZ0W4VSSzEE6onFI8pofny2OvoNjSbKFMmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709702914; c=relaxed/simple;
	bh=3hxZI4emF1wYSHuHobZcbBk1gscMxJ+EA04ne/SQOYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSPPN1mO00NoIKxTQwLDmQ2dSi42ayFUoyLrPXRUSK9RKxPXzkK0SgZhTxiupDL26+MA4L6+LncjJCeBR3Vu5Cw6N3eWeR6hBRQiUoQbDYnXjHBRaH2JE/9wQoeg3Wm1U5QcKD/PpPUZpoFMTIL2bpEmifBpy0rGLTUnTw92tCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LSv2Czub; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709702910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3hxZI4emF1wYSHuHobZcbBk1gscMxJ+EA04ne/SQOYA=;
	b=LSv2CzubTrTbByxduuh4pZfQ0Q/gBUjOswhm9ioU9E+W1CNf0KRk9c/obrgOLptBRlQohp
	7uIQzGQbh6sOUKAxfMBQA8IrSu6EfSCDQJEq183AJRB+xCXehDg+CZTPrx20dXPMVc2Ckj
	Sa01suLJ78gzQrt2ifpO54A8Zx3yO/s=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-7w5ufH04NgKvrN1mwRCC0A-1; Wed, 06 Mar 2024 00:28:29 -0500
X-MC-Unique: 7w5ufH04NgKvrN1mwRCC0A-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29988382913so4199256a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 21:28:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709702908; x=1710307708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hxZI4emF1wYSHuHobZcbBk1gscMxJ+EA04ne/SQOYA=;
        b=N1othIxlO6AlatHu1a5UEAT2jkTqnQrCJzLjjsTgVhDSTIrHecVLjF0hX8H1sBfCQs
         Ak0swUz5Ds84GflDl2oHToHjfmbWzFkwDIJ2Df1pNe0GaOhQj6f/XtfNZFeYB46c85W0
         +Wkp4QmKGCrsGHjzyrjBWY0KlPPIqpRuo17pqI1KTdlzIcub27ocIICv60++Ao59IWEg
         qfY325hgIWcUe/SbUS4JVtnKsyqju2iCT+qiPCvGhHiNlBvBIwmKvHKzVym03gDUVX2o
         2BvFb/ZOwlCYH35oAh5gg+2qiubM7GpMjP3NhLF1aGzrZGEcC3pptaexWV8WSb40mrbJ
         IsqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ3grEw2oLciyJ2VcSSB+gLjGwH7IEAeQ8A03iKsCuFUddlhDCd+ljLv39CjoFHgU6QE+qnijPzz3zMBx1YipsvBcxq7kJ2H7sHET8
X-Gm-Message-State: AOJu0YwHwCvTlCgPL8KKeIR61MBYy6RPad8Dpt+OXIWjLyXAOpZF5/Hn
	88zq7rrT27TtBN+bGselN1E9RV7/fOXWwi0cN9N/ypurLDOJ6KGIRN+9ev8sGR1oCHwfLgH8VwK
	KBAoFx4Z/7NTNWKS4/vwO7u6VOQoAh9eUTGpLRILZLWNtwGUZRS835t9KTOZtLh6m7GVfOGHSMi
	qUsnGP5eY79G7MvAiwTG9zlI7+xWFRB2ZhmQxM
X-Received: by 2002:a17:90a:fa96:b0:299:8957:9898 with SMTP id cu22-20020a17090afa9600b0029989579898mr11177781pjb.42.1709702907978;
        Tue, 05 Mar 2024 21:28:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3Aj9fYblNSHqZkWcccQqlzqUYhtj/+FONgyoU5B6Vd3h9SCF/s0WtuY4Kuj8YPdnUmWlVkzWj361ddQrkNHc=
X-Received: by 2002:a17:90a:fa96:b0:299:8957:9898 with SMTP id
 cu22-20020a17090afa9600b0029989579898mr11177772pjb.42.1709702907704; Tue, 05
 Mar 2024 21:28:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228093013.8263-1-linyunsheng@huawei.com> <20240228093013.8263-6-linyunsheng@huawei.com>
 <65c3503409c0e1670bdf06fecfd58ec483a114b9.camel@redhat.com>
In-Reply-To: <65c3503409c0e1670bdf06fecfd58ec483a114b9.camel@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 6 Mar 2024 13:28:16 +0800
Message-ID: <CACGkMEts-S7=p8aY+p+1JcTGZdLO65ug6t7c_yNj8xwRrhg9tA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 5/5] tools: virtio: introduce vhost_net_test
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, Yunsheng Lin <linyunsheng@huawei.com>, 
	davem@davemloft.net, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 5:47=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Wed, 2024-02-28 at 17:30 +0800, Yunsheng Lin wrote:
> > introduce vhost_net_test for both vhost_net tx and rx basing
> > on virtio_test to test vhost_net changing in the kernel.
> >
> > Steps for vhost_net tx testing:
> > 1. Prepare a out buf.
> > 2. Kick the vhost_net to do tx processing.
> > 3. Do the receiving in the tun side.
> > 4. verify the data received by tun is correct.
> >
> > Steps for vhost_net rx testing:
> > 1. Prepare a in buf.
> > 2. Do the sending in the tun side.
> > 3. Kick the vhost_net to do rx processing.
> > 4. verify the data received by vhost_net is correct.
> >
> > Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>
> @Jason: AFAICS this addresses the points you raised on v5, could you
> please have a look?
>
> Thanks!

Looks good to me.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> Paolo
>
>


