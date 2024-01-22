Return-Path: <linux-kernel+bounces-32316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF1C8359FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B5F28170B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B99728EF;
	Mon, 22 Jan 2024 04:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIuUn5tB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993541FA1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 04:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705896740; cv=none; b=BZnAgGjkgA4q/okmbehhD7T//pFJkzdlAqTsSrNtSK3+U2pGbufk1gpZUBePY4wV2R6ZlZtuaNVnJXtbeteK8Mjdp/vwNrobDVokDGAK72mFQ6SEbdQKN/AYH4VmroSHECNeECEBe5PkLAxwaLcVylFlP1pKNiIXm/6QTpkVGS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705896740; c=relaxed/simple;
	bh=MmLX/+2eKkvpMSGodryciCRGoarYC51S/2/oOX7cMXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oh7EHdnRXT4Q+th6oO8VKh4pXu5ex5jqgenfBmObobo9DqHGIuWsNEuRG/TggjnKs/PmOUcIK0sBVUcecJ9xzMid6zak46c6LIXDdG38QbXPHhVWfQHcHBHl5YBw2FWR+RfK0jVwJgvPSVxsNNRQliXLNBfFU1ehbdQxJclf5tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NIuUn5tB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705896737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdiWVjSrLkm00g1JovgY0SIa+x6URzp4TrijiFdHWvQ=;
	b=NIuUn5tBVgTlBTB6jv9jhnquz9/DC8Dl9UzT3zamMDULHx3N4O9kK+KcotgVND5pLJTGsp
	x17oF8AdHYhDTGSLRTbHfx7KMzMwHv56fVYH4vPwACvYvzxfah+pURqQjAdGrRi380nhBt
	87gJdiSKFOJcuxK6WGP67eskJuiwhRA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-cJPCY7z8Pl-sh7yo3jqHSA-1; Sun, 21 Jan 2024 23:12:16 -0500
X-MC-Unique: cJPCY7z8Pl-sh7yo3jqHSA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5cf35636346so1087647a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 20:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705896735; x=1706501535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdiWVjSrLkm00g1JovgY0SIa+x6URzp4TrijiFdHWvQ=;
        b=Wp6R0nMJilauw4S7H/JBQTtCJDCg/mSZj8qeUY4UbNEQVBdEmwECUir/yYmsH0pWeR
         U/g5D3f4gh9STXP2nf1mXcPoeXjMowH/zgdaO3Q03Xgf06UtwdhBDmNQ+B8/o+zyFnjg
         OhDjQm/1A/+ks23LEF0BW/K8mPfCbfuShEL7vUQAhzoiY5dtLrQYSJsRKzfnx+WZJSef
         A7M/4Mdcq4yQjvdC8uQSRBzfhe3Yd8fJwtmxFCi1ulL8r6lAngtqLB96KdXqvd3URMDo
         et+7PD+fpYuORXKIw0GzGvZ5iB/pQkJ4KjM9XQME7/sdmfne3uYFsjNj3lHVutkNPK/G
         FTOg==
X-Gm-Message-State: AOJu0YxBe71rFjGCRAjLJ4dxhj6ugQigxvU+8YU5H/DG15HkGgrq1CYa
	VVjDMSfgUIJR/XK4OGzhMvQZO2/KjCZW/w6H5orgAzag5XpPShjNwrgDEXH20aCTyYD88ZHmnye
	TRIbaeVSCzdtXB2863G2miTvn2uA8wpQkN9dQVfpBX+nqo/zvP7do8qTUjD3P/t0ORn0V7OdwE0
	i1ixOzmFNHFGSz4V7DeBPlR6haQT39O44wqyJ1
X-Received: by 2002:a05:6a20:4314:b0:19c:36df:42db with SMTP id h20-20020a056a20431400b0019c36df42dbmr468893pzk.5.1705896734936;
        Sun, 21 Jan 2024 20:12:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPKntMMuZTTQpPnZS+5Zmec96aBqPnJau5M7G5SBtCRvgwmF/Mz4WBFPpuztC9MKdTbx2dzj4f1qhZ8gLlJHI=
X-Received: by 2002:a05:6a20:4314:b0:19c:36df:42db with SMTP id
 h20-20020a056a20431400b0019c36df42dbmr468885pzk.5.1705896734692; Sun, 21 Jan
 2024 20:12:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
 <CACGkMEuFTRBYU+z3ZSWzMMv2650PQ=kduGxcGXaf0T5222Bh4g@mail.gmail.com> <aea1681c-e04d-4678-b161-6dbd2b13b82e@oracle.com>
In-Reply-To: <aea1681c-e04d-4678-b161-6dbd2b13b82e@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 12:12:03 +0800
Message-ID: <CACGkMEuCOnnMTyjGWz+BahYimwge=6fX4Ynq22gv=koCcnx0mg@mail.gmail.com>
Subject: Re: [RFC V1 00/13] vdpa live update
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>, 
	Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 4:32=E2=80=AFAM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 1/10/2024 9:55 PM, Jason Wang wrote:
> > On Thu, Jan 11, 2024 at 4:40=E2=80=AFAM Steve Sistare <steven.sistare@o=
racle.com> wrote:
> >>
> >> Live update is a technique wherein an application saves its state, exe=
c's
> >> to an updated version of itself, and restores its state.  Clients of t=
he
> >> application experience a brief suspension of service, on the order of
> >> 100's of milliseconds, but are otherwise unaffected.
> >>
> >> Define and implement interfaces that allow vdpa devices to be preserve=
d
> >> across fork or exec, to support live update for applications such as q=
emu.
> >> The device must be suspended during the update, but its dma mappings a=
re
> >> preserved, so the suspension is brief.
> >>
> >> The VHOST_NEW_OWNER ioctl transfers device ownership and pinned memory
> >> accounting from one process to another.
> >>
> >> The VHOST_BACKEND_F_NEW_OWNER backend capability indicates that
> >> VHOST_NEW_OWNER is supported.
> >>
> >> The VHOST_IOTLB_REMAP message type updates a dma mapping with its user=
land
> >> address in the new process.
> >>
> >> The VHOST_BACKEND_F_IOTLB_REMAP backend capability indicates that
> >> VHOST_IOTLB_REMAP is supported and required.  Some devices do not
> >> require it, because the userland address of each dma mapping is discar=
ded
> >> after being translated to a physical address.
> >>
> >> Here is a pseudo-code sequence for performing live update, based on
> >> suspend + reset because resume is not yet available.  The vdpa device
> >> descriptor, fd, remains open across the exec.
> >>
> >>   ioctl(fd, VHOST_VDPA_SUSPEND)
> >>   ioctl(fd, VHOST_VDPA_SET_STATUS, 0)
> >>   exec
> >
> > Is there a userspace implementation as a reference?
>
> I have working patches for qemu that use these ioctl's, but they depend o=
n other
> qemu cpr patches that are a work in progress, and not posted yet.  I'm wo=
rking on
> that.

Ok.

>
> >>   ioctl(fd, VHOST_NEW_OWNER)
> >>
> >>   issue ioctls to re-create vrings
> >>
> >>   if VHOST_BACKEND_F_IOTLB_REMAP
> >>       foreach dma mapping
> >>           write(fd, {VHOST_IOTLB_REMAP, new_addr})
> >
> > I think I need to understand the advantages of this approach. For
> > example, why it is better than
> >
> > ioctl(VHOST_RESET_OWNER)
> > exec
> >
> > ioctl(VHOST_SET_OWNER)
> >
> > for each dma mapping
> >      ioctl(VHOST_IOTLB_UPDATE)
>
> That is slower.  VHOST_RESET_OWNER unbinds physical pages, and VHOST_IOTL=
B_UPDATE
> rebinds them.  It costs multiple seconds for large memories, and is incur=
red during the
> virtual machine's pause time during live update.  For comparison, the tot=
al pause time
> for live update with vfio interfaces is ~100 millis.
>
> However, the interaction with userland is so similar that the same code p=
aths can be used.
> In my qemu prototype, after cpr exec's new qemu:
>   - vhost_vdpa_set_owner() calls VHOST_NEW_OWNER instead of VHOST_SET_OWN=
ER
>   - vhost_vdpa_dma_map() sets type VHOST_IOTLB_REMAP instead of VHOST_IOT=
LB_UPDATE
>
> - Steve
>

Ok, let's document this in the changlog.

Thanks


