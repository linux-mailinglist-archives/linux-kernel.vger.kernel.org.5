Return-Path: <linux-kernel+bounces-124397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ECE8916F8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2967B1F24CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A2169E0F;
	Fri, 29 Mar 2024 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pu1fXYxn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB2569DFF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711708816; cv=none; b=eNj4A7cz/z06KJNtuWHxr6EVkhvYMOVhOGTNSQm8m6e1FeefLBWhm4c3TE/JbFrbdm5fuUkNGIN/No3AoN7aAkqnWRtE3ZhBQXqoiGPyAkU3R1z94Y3AtHt0ZCKKdHOTXtzSUPGL2fpejlDiQTMY4mgd1TP9OpVa7F9i5JszemM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711708816; c=relaxed/simple;
	bh=aWlw1knI6iA9pHb6F2hZMi+1qAncr3KP7cFanst0N6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWNWiiLmQhQz0/KGloovEaLn8NWCNN16TGWQx/8SZ9VkdW4/o8XBk9MRtnB73tFCNRxX+U893nJjeYM3WQx9JwP9s8NgFSnmk9k1C7uMl1hubD3+Ttow2Ev8B/kYTChLhKnYgDcCLSYSdkI46g8h7HFAP1k1JbhFgpl/urtcvpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pu1fXYxn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711708812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWlw1knI6iA9pHb6F2hZMi+1qAncr3KP7cFanst0N6Q=;
	b=Pu1fXYxnWWkIBKJmdWLFKDM5k3rzYaVIKo1mhO4bV4pX/mCvJh3KIjl0Q5pu1mkpvLhBgT
	VJ/9i6LHA0J7C3K+9jheVFsCLfeK8502EDIzVCcgNSvFD96U4BBUfJhErndKRbmp6D518/
	K5VN/9CIP2CiBrSI3yk6DUEXPkjmW3E=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-gZZCbf7cMmOppiBrnIsQbQ-1; Fri, 29 Mar 2024 06:40:09 -0400
X-MC-Unique: gZZCbf7cMmOppiBrnIsQbQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29de4f107b7so1634171a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 03:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711708807; x=1712313607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWlw1knI6iA9pHb6F2hZMi+1qAncr3KP7cFanst0N6Q=;
        b=M/5JCRewyKiQ0WKik/vlrijp8Rsdqa42Z6NRzDf2jY+D+lpnzXlFFRwFh+wHqXmu6l
         Wl2tecvEXC9YBT8T/YdhcoX89vAEJLdysJTff1TrgHZzHQ1zurCpMGP1MYKBHK9NLFLr
         3Z4w2ycxpR+Ag7XT1MG7iCMoUb/1VqGNyhQPDeLX23OwbtWpkbGx/IWAa1YQn1eESYJv
         iJF6iQkCmWQWUfIqppT28CPwL/XniA8rNZhx8K55IPU8FvqbHXU3ppIR/CEhehCbFQn2
         kGTX5bG7OTt4ntk6BNU4AxNg4cG4CFspChsJrzvrj6eTCSg6tdV7pyWEn2k0iVE1yvcv
         zxXg==
X-Forwarded-Encrypted: i=1; AJvYcCVoLf3tAXtKEyC1kS7fTUULAMEp1ZuDCKXVpHDNJ643rOVOwAVBqL/7cL/ubLtld2t/sG3sYPHa23ehtTwrZuBNxPCqdU+k1fav+EUH
X-Gm-Message-State: AOJu0YxzKzzy8Yh1YuGOTzlnbgVcnxeaiLGdDT07204dQhc5x3SDME32
	MFLkVrNm+fYpEGwIJP6Msb7oiEY6VqeHmU8VHkfeF6ePKQcFKLJfKsBsly5xTdLjyMVPFvXROd7
	34BKNaiulrraqrsi5MEOxcBwCdxdnFn00qNN94NSHAn4OTUIKWvG2b84HneEoG7dzuIe05jfVPO
	gpeWFQ/g+eTydS7Z/ZxfBnS8viHc8ww/iNOtN4
X-Received: by 2002:a17:90b:8c6:b0:2a2:9f6:759e with SMTP id ds6-20020a17090b08c600b002a209f6759emr1875594pjb.20.1711708807052;
        Fri, 29 Mar 2024 03:40:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb2wOAwuZXQWgzWL66EpG6vLDeyAJyD0oneTmmJW/T8q+bGhu652fGejrNwbcPHG3zyYzfHXasccYzy+nbzx0=
X-Received: by 2002:a17:90b:8c6:b0:2a2:9f6:759e with SMTP id
 ds6-20020a17090b08c600b002a209f6759emr1875582pjb.20.1711708806789; Fri, 29
 Mar 2024 03:40:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320101912.28210-1-w_angrong@163.com> <20240321025920-mutt-send-email-mst@kernel.org>
 <CACGkMEuHRf0ZfBiAYxyNHB3pxuzz=QCWt5VyHPLz-+-+LM=+bg@mail.gmail.com>
 <CACGkMEuM9bdvgH7_v6F=HT-x10+0tCzG56iuU05guwqNN1+qKQ@mail.gmail.com> <20240329051334-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240329051334-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 29 Mar 2024 18:39:54 +0800
Message-ID: <CACGkMEvdw4Yf2B1QGed0W7wLhOHU9+Vo_Z3h=4Yr9ReBfvuh=g@mail.gmail.com>
Subject: Re: [PATCH v3] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wang Rong <w_angrong@163.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 5:13=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Mar 29, 2024 at 11:55:50AM +0800, Jason Wang wrote:
> > On Wed, Mar 27, 2024 at 5:08=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Thu, Mar 21, 2024 at 3:00=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Wed, Mar 20, 2024 at 06:19:12PM +0800, Wang Rong wrote:
> > > > > From: Rong Wang <w_angrong@163.com>
> > > > >
> > > > > Once enable iommu domain for one device, the MSI
> > > > > translation tables have to be there for software-managed MSI.
> > > > > Otherwise, platform with software-managed MSI without an
> > > > > irq bypass function, can not get a correct memory write event
> > > > > from pcie, will not get irqs.
> > > > > The solution is to obtain the MSI phy base address from
> > > > > iommu reserved region, and set it to iommu MSI cookie,
> > > > > then translation tables will be created while request irq.
> > > > >
> > > > > Change log
> > > > > ----------
> > > > >
> > > > > v1->v2:
> > > > > - add resv iotlb to avoid overlap mapping.
> > > > > v2->v3:
> > > > > - there is no need to export the iommu symbol anymore.
> > > > >
> > > > > Signed-off-by: Rong Wang <w_angrong@163.com>
> > > >
> > > > There's in interest to keep extending vhost iotlb -
> > > > we should just switch over to iommufd which supports
> > > > this already.
> > >
> > > IOMMUFD is good but VFIO supports this before IOMMUFD. This patch
> > > makes vDPA run without a backporting of full IOMMUFD in the productio=
n
> > > environment. I think it's worth.
> > >
> > > If you worry about the extension, we can just use the vhost iotlb
> > > existing facility to do this.
> > >
> > > Thanks
> >
> > Btw, Wang Rong,
> >
> > It looks that Cindy does have the bandwidth in working for IOMMUFD supp=
ort.
>
> I think you mean she does not.

Yes, you are right.

Thanks

>
> > Do you have the will to do that?
> >
> > Thanks
>


