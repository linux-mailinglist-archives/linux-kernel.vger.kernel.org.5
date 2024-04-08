Return-Path: <linux-kernel+bounces-134841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5433A89B7B7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8DE1F22A44
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AB923770;
	Mon,  8 Apr 2024 06:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnuJ+uVz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1642232A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558277; cv=none; b=hpEEKv1gSDnJl5vWsjYxA9FinnJtrhqP4HQY2SaK0l32DYJkR+zja8mSy6vlv7JvqWEvhMnAiskh4BkpnsLk+0LQo5/GmhwkwFvU3pto8biR7rGnRiQbtWM7+SxJQYiN+CKFHDopAhRMsyFt0+aSsxaIUqtVK66PA1ZBaLE7ArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558277; c=relaxed/simple;
	bh=TfJdkB5yl6go/ImD3Jt1aZ7iRc8UE3YZ3XaVQ0OB+L0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBcYNEUsA/vzbVatinXbTa8PtPIyhDwt+RtJ2MWkTkjfDdOA4CZXP1V2xFl1spB443dcE6DkG0M9Eb0VOGUyu8qqvJsZBtRNYtxUTFiA5Qq0O6ZWYFEEJvsVTIHhiQGmOIXDKbN8z8h8+i9zsnsjPSWuWBkNR7ic5KcWWk+GU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dnuJ+uVz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712558274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TfJdkB5yl6go/ImD3Jt1aZ7iRc8UE3YZ3XaVQ0OB+L0=;
	b=dnuJ+uVzB2cJCX0Xko9nfDKzZLH3/0SbZ6G7/HFmrOaSeWsDiBarwczywM8QnwJZu62DFr
	B5/GkkGeCfwZ4bIRT490UKxcj6fQmcplA5pmuzCngJXfP5N3p4+nDSsMmFFM8COMTImwRG
	UDI7hEl5KvIHIDQmxsFjoSiEgbr9gVc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-58-k1oAMOIaAzQHP3SghYg-1; Mon, 08 Apr 2024 02:37:53 -0400
X-MC-Unique: 58-k1oAMOIaAzQHP3SghYg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5f034b4db5bso2061206a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 23:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712558272; x=1713163072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfJdkB5yl6go/ImD3Jt1aZ7iRc8UE3YZ3XaVQ0OB+L0=;
        b=OVoKSD6Hgn8vxobp2i8yHX54Kszmj9cKzZLQjwA4JVCow6Zbg/KkJmHshebxWpRrG7
         r+A63T4K5pmgdEVqBSVItk1IDPQM3SbMMm0o3xYPIpfPMWQqId3tCKxE5i1Tjg/iqJJv
         iWyIhV5paBzHZ140lCCs4eWMWZwujShML9Y+4kybvTac3Ki6FeJybSe4t6d0LMIeRFat
         jcoNUoiC8Xs6EobgzngBlSEdVpvYIIXtwA1xv2rxNlV+6Ds0XGnAtBy1F2ptIDG2Y9Ra
         uQwUkJwEsh+UeoxvL9u51rwRN4gLRH8Zuo9CyPPkc3tW/jsNXV9sOHqATNQX6lX6UYpM
         +iyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6vvdP8EqXn2QFU/7VDx8FKv1WLg0GAN/bL26Jtjw59gPRDLm3TUDepEcn5iSxyiVRFI7+uHovdUqnlHmgc8nTqRL94mxQNjc27LBN
X-Gm-Message-State: AOJu0YywKobnrZVpikW15imeFco4VegqfAp8Zo+LZlaXzyP5UyTFaZF8
	HFuD+8+32hDvEZWdTutq2n3O+IeGK/5CA9mbtcxdqTLpPDJAgDdr5TvMxxAB2OR42Ey+uikKsKL
	i++FPQoED6cYhlqJdiqYXVZCdxAuR4TA2gkrVcAQs4b9afEcUKLaxuMvDdSpAeHCTlCGEcBDQIJ
	8foOIxbL47wtnZXTf4GGJLRoGiPU/Hp9QUgJLd
X-Received: by 2002:a05:6a20:c90c:b0:1a3:ae18:f1e4 with SMTP id gx12-20020a056a20c90c00b001a3ae18f1e4mr6736145pzb.34.1712558272043;
        Sun, 07 Apr 2024 23:37:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE++t+kDRwQTjzBUO1mfVfERd3l7rNbc0xIi9zTeBPMF1iq2N0XXvk4NSGNqvS3RADG9LQmO1bzc88Z/Zq0VA=
X-Received: by 2002:a05:6a20:c90c:b0:1a3:ae18:f1e4 with SMTP id
 gx12-20020a056a20c90c00b001a3ae18f1e4mr6736131pzb.34.1712558271762; Sun, 07
 Apr 2024 23:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320101912.28210-1-w_angrong@163.com> <20240321025920-mutt-send-email-mst@kernel.org>
 <CACGkMEuHRf0ZfBiAYxyNHB3pxuzz=QCWt5VyHPLz-+-+LM=+bg@mail.gmail.com>
 <CACGkMEuM9bdvgH7_v6F=HT-x10+0tCzG56iuU05guwqNN1+qKQ@mail.gmail.com>
 <20240329051334-mutt-send-email-mst@kernel.org> <CACGkMEvdw4Yf2B1QGed0W7wLhOHU9+Vo_Z3h=4Yr9ReBfvuh=g@mail.gmail.com>
 <17068236.8b8.18ea1d8622f.Coremail.w_angrong@163.com>
In-Reply-To: <17068236.8b8.18ea1d8622f.Coremail.w_angrong@163.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Apr 2024 14:37:40 +0800
Message-ID: <CACGkMEtYPwhkDJFxiZZHUtVy3NTY_f3DWG7K_5ZJ7Yknu_y8cw@mail.gmail.com>
Subject: Re: Re: [PATCH v3] vhost/vdpa: Add MSI translation tables to iommu
 for software-managed MSI
To: tab <w_angrong@163.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 10:47=E2=80=AFAM tab <w_angrong@163.com> wrote:
>
> > >
> > > On Fri, Mar 29, 2024 at 11:55:50AM +0800, Jason Wang wrote:
> > > > On Wed, Mar 27, 2024 at 5:08=E2=80=AFPM Jason Wang <jasowang@redhat=
com> wrote:
> > > > >
> > > > > On Thu, Mar 21, 2024 at 3:00=E2=80=AFPM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Wed, Mar 20, 2024 at 06:19:12PM +0800, Wang Rong wrote:
> > > > > > > From: Rong Wang <w_angrong@163.com>
> > > > > > >
> > > > > > > Once enable iommu domain for one device, the MSI
> > > > > > > translation tables have to be there for software-managed MSI.
> > > > > > > Otherwise, platform with software-managed MSI without an
> > > > > > > irq bypass function, can not get a correct memory write event
> > > > > > > from pcie, will not get irqs.
> > > > > > > The solution is to obtain the MSI phy base address from
> > > > > > > iommu reserved region, and set it to iommu MSI cookie,
> > > > > > > then translation tables will be created while request irq.
> > > > > > >
> > > > > > > Change log
> > > > > > > ----------
> > > > > > >
> > > > > > > v1->v2:
> > > > > > > - add resv iotlb to avoid overlap mapping.
> > > > > > > v2->v3:
> > > > > > > - there is no need to export the iommu symbol anymore.
> > > > > > >
> > > > > > > Signed-off-by: Rong Wang <w_angrong@163.com>
> > > > > >
> > > > > > There's in interest to keep extending vhost iotlb -
> > > > > > we should just switch over to iommufd which supports
> > > > > > this already.
> > > > >
> > > > > IOMMUFD is good but VFIO supports this before IOMMUFD. This patch
> > > > > makes vDPA run without a backporting of full IOMMUFD in the produ=
ction
> > > > > environment. I think it's worth.
> > > > >
> > > > > If you worry about the extension, we can just use the vhost iotlb
> > > > > existing facility to do this.
> > > > >
> > > > > Thanks
> > > >
> > > > Btw, Wang Rong,
> > > >
> > > > It looks that Cindy does have the bandwidth in working for IOMMUFD =
support.
> > >
> > > I think you mean she does not.
> >
> > Yes, you are right.
> >
> > Thanks
>
> I need to discuss internally, and there may be someone else will do that.
>
> Thanks.

Ok, please let us know if you have a conclusion.

Thanks

>
> >
> > >
> > > > Do you have the will to do that?
> > > >
> > > > Thanks
> > >
>
>
>
>
> --
> =E5=8F=91=E8=87=AA=E6=88=91=E7=9A=84=E7=BD=91=E6=98=93=E9=82=AE=E7=AE=B1=
=E5=B9=B3=E6=9D=BF=E9=80=82=E9=85=8D=E7=89=88
> <br/><br/><br/>
>
>
> ----- Original Message -----
> From: "Jason Wang" <jasowang@redhat.com>
> To: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: "Wang Rong" <w_angrong@163.com>, kvm@vger.kernel.org, virtualization@=
lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Cin=
dy Lu" <lulu@redhat.com>
> Sent: Fri, 29 Mar 2024 18:39:54 +0800
> Subject: Re: [PATCH v3] vhost/vdpa: Add MSI translation tables to iommu f=
or software-managed MSI
>
> On Fri, Mar 29, 2024 at 5:13=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Fri, Mar 29, 2024 at 11:55:50AM +0800, Jason Wang wrote:
> > > On Wed, Mar 27, 2024 at 5:08=E2=80=AFPM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Thu, Mar 21, 2024 at 3:00=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Wed, Mar 20, 2024 at 06:19:12PM +0800, Wang Rong wrote:
> > > > > > From: Rong Wang <w_angrong@163.com>
> > > > > >
> > > > > > Once enable iommu domain for one device, the MSI
> > > > > > translation tables have to be there for software-managed MSI.
> > > > > > Otherwise, platform with software-managed MSI without an
> > > > > > irq bypass function, can not get a correct memory write event
> > > > > > from pcie, will not get irqs.
> > > > > > The solution is to obtain the MSI phy base address from
> > > > > > iommu reserved region, and set it to iommu MSI cookie,
> > > > > > then translation tables will be created while request irq.
> > > > > >
> > > > > > Change log
> > > > > > ----------
> > > > > >
> > > > > > v1->v2:
> > > > > > - add resv iotlb to avoid overlap mapping.
> > > > > > v2->v3:
> > > > > > - there is no need to export the iommu symbol anymore.
> > > > > >
> > > > > > Signed-off-by: Rong Wang <w_angrong@163.com>
> > > > >
> > > > > There's in interest to keep extending vhost iotlb -
> > > > > we should just switch over to iommufd which supports
> > > > > this already.
> > > >
> > > > IOMMUFD is good but VFIO supports this before IOMMUFD. This patch
> > > > makes vDPA run without a backporting of full IOMMUFD in the product=
ion
> > > > environment. I think it's worth.
> > > >
> > > > If you worry about the extension, we can just use the vhost iotlb
> > > > existing facility to do this.
> > > >
> > > > Thanks
> > >
> > > Btw, Wang Rong,
> > >
> > > It looks that Cindy does have the bandwidth in working for IOMMUFD su=
pport.
> >
> > I think you mean she does not.
>
> Yes, you are right.
>
> Thanks
>
> >
> > > Do you have the will to do that?
> > >
> > > Thanks
> >


