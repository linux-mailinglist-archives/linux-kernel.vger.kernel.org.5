Return-Path: <linux-kernel+bounces-124098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDE6891235
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7910A1F224AC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5343A267;
	Fri, 29 Mar 2024 03:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyGiD1Wy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4BA2E821
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 03:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711684569; cv=none; b=govpa6lrMddnbGUEFCUNpDjeGx/clqpVqOqHTp0l110g0g5vDjH0OpN/q8nNsrbVBLmKGGhnYMbfJHJFFFYV1PymCgXdJUcPIL0tz5Tqtiav3eNxGFBLHRiXXbQZDR4E44nP+EUahPWLSDOW/L5jrF4S7DvjkitaQqf+kBfd7BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711684569; c=relaxed/simple;
	bh=LJdVzIjhdB6S/DcfelzDKPP9Yk+5ga0skvUpr5ygfQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZjQ4qyqcI9szq1ZaNZDLAWZEw9tYxvLGaJrFujtMcc4Sg4Bl2dWh9wfhmkbfZ7n2diq/cEW8qI0NZyw7makpyrnEJnfK2DhYP/mzEn7TVPqNQo8whvRx8aGlHjNNNgUCvLw8X2AJm6jVe8H8nLrb8+ydrIDTtCEWEX7+A6Umrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyGiD1Wy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711684566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJdVzIjhdB6S/DcfelzDKPP9Yk+5ga0skvUpr5ygfQM=;
	b=gyGiD1Wyt+1Jhi83kuzdCNeLA3KxmqJ6x+wJBZW3eahEfRuahfIEzaDFnCPrGqTeCp71QT
	3VCLYRE5BmjaoJKw4pS0ME+helrX6ZlWXWrNCV5f8mjBN0eb7XcmbBzcOnOb3AefSR0We9
	O6fy+fdU3Tulx1KyCcX2S3WgouojH6M=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-iVQytZqvORavyDAuQi8e9g-1; Thu, 28 Mar 2024 23:56:04 -0400
X-MC-Unique: iVQytZqvORavyDAuQi8e9g-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1e0ae06181eso18924355ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711684563; x=1712289363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJdVzIjhdB6S/DcfelzDKPP9Yk+5ga0skvUpr5ygfQM=;
        b=f9k5+Vyop1UGCgm1ClCmTMyYQNIvrxvb1NKDhtlwpuCzzJoHtNeHVLL2W5DsiGO+4B
         sk2L48vqxxDY7FFMbPUOW6zMF/GUfOhORGlltyCLnmQ6+v1FmUY2ARQ0Lc4f3UjtygWY
         gnNR0+s/VjvcFKBR+6eY/6YMETs2yCSlCmjJaKrnEGUy/fcIn4hgH7WeL8Ejptan8Mgn
         DjJmJh/fpp35Mnwc15Soe9K8lwruMls/4ip0Hn6S+jojK6helzXTHY5lT3ZD6LzrEDKn
         yRPQX5wly0h5tBQnuVR30UDwM78pfTEvgv+tAhY/vClbXAKRCxyY5Xv7m+jrenVpLHTM
         lq3w==
X-Forwarded-Encrypted: i=1; AJvYcCXtOS/zkAa5PCao80TgwQkAtkNJdzd6kDee9PGvaouGX2elDPB1URWalouY0zr0ccaid4Me3aGEmd0oxYkfsbnTpzGE9Oj/sAW78TT8
X-Gm-Message-State: AOJu0YzM944Dkq+IlAe8JZIKbpNH52ibio9pisF2lbEzEUJGB9vqf/93
	RRxSOQQbNad2ijlEPgC5SsPp6uSoDD7/ia1HOBFc7fM2KPEqr8XvUjPkuZQXi3dYd3d3lKYGH6Q
	hPY12qXQ5utlC9PUQPR2/kocTmpcVobKk7LsEl36o5jNRVstUeWNcoBlol87R+5T7yscl2Dj7RG
	iNHNAjp9XwLmbOTgxjqHIMZMphZZlvIxJNXna8iT2gQJdG
X-Received: by 2002:a17:90a:d515:b0:2a0:8d17:948d with SMTP id t21-20020a17090ad51500b002a08d17948dmr1838132pju.1.1711684562670;
        Thu, 28 Mar 2024 20:56:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5WpbyriUxjePwEjGO5X6q+YKYhB1eZJaJgrj4rVieoGSzVLIkn+ALnR8ZipwbzdgGvrRXqkbuUUu/vp0RL8A=
X-Received: by 2002:a17:90a:d515:b0:2a0:8d17:948d with SMTP id
 t21-20020a17090ad51500b002a08d17948dmr1838120pju.1.1711684562345; Thu, 28 Mar
 2024 20:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320101912.28210-1-w_angrong@163.com> <20240321025920-mutt-send-email-mst@kernel.org>
 <CACGkMEuHRf0ZfBiAYxyNHB3pxuzz=QCWt5VyHPLz-+-+LM=+bg@mail.gmail.com>
In-Reply-To: <CACGkMEuHRf0ZfBiAYxyNHB3pxuzz=QCWt5VyHPLz-+-+LM=+bg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 29 Mar 2024 11:55:50 +0800
Message-ID: <CACGkMEuM9bdvgH7_v6F=HT-x10+0tCzG56iuU05guwqNN1+qKQ@mail.gmail.com>
Subject: Re: [PATCH v3] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wang Rong <w_angrong@163.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 5:08=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Mar 21, 2024 at 3:00=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Wed, Mar 20, 2024 at 06:19:12PM +0800, Wang Rong wrote:
> > > From: Rong Wang <w_angrong@163.com>
> > >
> > > Once enable iommu domain for one device, the MSI
> > > translation tables have to be there for software-managed MSI.
> > > Otherwise, platform with software-managed MSI without an
> > > irq bypass function, can not get a correct memory write event
> > > from pcie, will not get irqs.
> > > The solution is to obtain the MSI phy base address from
> > > iommu reserved region, and set it to iommu MSI cookie,
> > > then translation tables will be created while request irq.
> > >
> > > Change log
> > > ----------
> > >
> > > v1->v2:
> > > - add resv iotlb to avoid overlap mapping.
> > > v2->v3:
> > > - there is no need to export the iommu symbol anymore.
> > >
> > > Signed-off-by: Rong Wang <w_angrong@163.com>
> >
> > There's in interest to keep extending vhost iotlb -
> > we should just switch over to iommufd which supports
> > this already.
>
> IOMMUFD is good but VFIO supports this before IOMMUFD. This patch
> makes vDPA run without a backporting of full IOMMUFD in the production
> environment. I think it's worth.
>
> If you worry about the extension, we can just use the vhost iotlb
> existing facility to do this.
>
> Thanks

Btw, Wang Rong,

It looks that Cindy does have the bandwidth in working for IOMMUFD support.

Do you have the will to do that?

Thanks


