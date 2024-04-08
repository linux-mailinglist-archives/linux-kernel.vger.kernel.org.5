Return-Path: <linux-kernel+bounces-135330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E32CE89BF19
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B231C21FC2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98FE6EB62;
	Mon,  8 Apr 2024 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICPX0NBP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E80D6A014
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580007; cv=none; b=pgn5BUTSyksqFb9+V9nij2qtxeaMcAwiqWcfWi9hNMQrAoQ9AXDwKGWjQk89EugqzSaqU0p0Q1cMpClYQUzwbtyzkBSOhwftKBaFnTETgeD/rbMOjiTtdj/CCQK0jQ7dd4/wa5cjxfuD7TRFvDGG4sQ+oaf5L9UsizGrwe5AczA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580007; c=relaxed/simple;
	bh=fxPXw2p77yhgVxO+9PcInO2jf4CRcklB5uKFPixrm8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ha7pqCXyBUiylSu9ehzcoY+wyA1DkmbD0Tbb1mar+mOSQX1D2clNe2akdKwpSFZExpHUsfK2LL1ZSyz3IFpnrbGTveY6voISzGtWVRF5/97YF/R6x6PfC1YZRUgd38kEwvdstkCyZTuLXd+aVl8fbNff3wrJGo5o+9StZkIKpXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICPX0NBP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712580003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ae2COtjajtOOtS6X4ygU+qeHK/f9eu0OjppudYN/LXQ=;
	b=ICPX0NBPIWiSzHv/qAZo0YcA8QGYQM63evZiJLFredajKRrV0BQkvoC549+haRafGyFbXw
	4WmmFotLtu+SXRFFxoXJZ8Gd34iKQooRkXhFngPmBdRCgtZDBPri/dBWW7B+al21NlazXQ
	S1+pEgv1ZyJ0uCTHeKNml9SnMMwdvbA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-HnAjSohWP-y_Dmn4UA7jxA-1; Mon, 08 Apr 2024 08:40:02 -0400
X-MC-Unique: HnAjSohWP-y_Dmn4UA7jxA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a519e05fe4fso226361066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 05:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712580001; x=1713184801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ae2COtjajtOOtS6X4ygU+qeHK/f9eu0OjppudYN/LXQ=;
        b=UKlWugGq8ch9BzB6vkGTUOmuYIYxt741aqjHdtYlqJkbQBHJ7jtM4u803y2/xgJmS1
         fBm6wUKcbHNtUR/WK9cWIAEju4q0awXUXtw8TeMGRI3zSrEz/s+i7tKrMgLIcp/zTtOh
         LVkzfVmeo/Nm/s3d543GgCBaqj+fc6cMXm9mFPhYZCySTrEY0NRuB6VmyZHN1TRkWoMQ
         yAbA4xxHGlLPetDf1biMNXBivOy3xtnPNLjaZIsLOZzzASYMvMK3Wfkjx4sqbJnL1YgR
         DiTJlBCWeEPR9ol6zaaii3lVi42eAB++v1J9ONUaW8y5YRbiTlIejvGygGotguJEjBBx
         Yngg==
X-Forwarded-Encrypted: i=1; AJvYcCXjOpz4TS1Hca+JVzhwgJequA6k7n31AUAAs+Tvjx9A3cpj5aF8LYRsCSsXoLQ7fQQOcorYHYgvt9pGCsNJU8vmkDOJJ+WFjQxU+VtQ
X-Gm-Message-State: AOJu0YxJbHpCaAVCQnB2pZ8U6bNa40HnDq8NgANqSdXNwhs5hygXOzLZ
	BGNd/LMJlws63LOCjuNRMnett4/YHs9LWKLbIq+TB/9V1fakBiXfFHQY6EZYpVUTZez7CubTzA2
	Y7v/eJxq6nsJqV0O5XKk8rZ/Hp7NuQHHq02fnGV+nc5DvLNtrTOXh/7zrhG9ESiboKFgi7+R+eZ
	Z83RZzdi+g/PkckonbeiFpOthDxV1h3dCktxRcK/VoTy/PJi8=
X-Received: by 2002:a17:907:9444:b0:a51:d70f:b5f2 with SMTP id dl4-20020a170907944400b00a51d70fb5f2mr2084585ejc.20.1712580000865;
        Mon, 08 Apr 2024 05:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg3MkKq/gJZBjDBVnAKe4jU7q9XkeS1BfnnkBObgzhdnwCFitOZa/DmVr4r6jMIn9yjc43uLBh88PkDhgd3Mk=
X-Received: by 2002:a17:907:9444:b0:a51:d70f:b5f2 with SMTP id
 dl4-20020a170907944400b00a51d70fb5f2mr2084571ejc.20.1712580000551; Mon, 08
 Apr 2024 05:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404055635.316259-1-lulu@redhat.com> <20240408033804-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240408033804-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 8 Apr 2024 20:39:21 +0800
Message-ID: <CACLfguUL=Kteorvyn=wRUWFJFvhvgRyp+V7GNBp2R33hK1vnSw@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: Add reconnect process for VDUSE
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 3:40=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Apr 04, 2024 at 01:56:31PM +0800, Cindy Lu wrote:
> > Add a document explaining the reconnect process, including what the
> > Userspace App needs to do and how it works with the kernel.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  Documentation/userspace-api/vduse.rst | 41 +++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/user=
space-api/vduse.rst
> > index bdb880e01132..7faa83462e78 100644
> > --- a/Documentation/userspace-api/vduse.rst
> > +++ b/Documentation/userspace-api/vduse.rst
> > @@ -231,3 +231,44 @@ able to start the dataplane processing as follows:
> >     after the used ring is filled.
> >
> >  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> > +
> > +HOW VDUSE devices reconnection works
> > +------------------------------------
> > +1. What is reconnection?
> > +
> > +   When the userspace application loads, it should establish a connect=
ion
> > +   to the vduse kernel device. Sometimes,the userspace application exi=
sts,
> > +   and we want to support its restart and connect to the kernel device=
 again
> > +
> > +2. How can I support reconnection in a userspace application?
> > +
> > +2.1 During initialization, the userspace application should first veri=
fy the
> > +    existence of the device "/dev/vduse/vduse_name".
> > +    If it doesn't exist, it means this is the first-time for connectio=
n. goto step 2.2
> > +    If it exists, it means this is a reconnection, and we should goto =
step 2.3
> > +
> > +2.2 Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> > +    /dev/vduse/control.
> > +    When ioctl(VDUSE_CREATE_DEV) is called, kernel allocates memory fo=
r
> > +    the reconnect information. The total memory size is PAGE_SIZE*vq_m=
umber.
>
> Confused. Where is that allocation, in code?
>
> Thanks!
>
this should allocated in function vduse_create_dev(), I will rewrite
this part  to make it more clearer
will send a new version soon
Thanks
cindy

> > +2.3 Check if the information is suitable for reconnect
> > +    If this is reconnection :
> > +    Before attempting to reconnect, The userspace application needs to=
 use the
> > +    ioctl(VDUSE_DEV_GET_CONFIG, VDUSE_DEV_GET_STATUS, VDUSE_DEV_GET_FE=
ATURES...)
> > +    to get the information from kernel.
> > +    Please review the information and confirm if it is suitable to rec=
onnect.
> > +
> > +2.4 Userspace application needs to mmap the memory to userspace
> > +    The userspace application requires mapping one page for every vq. =
These pages
> > +    should be used to save vq-related information during system runnin=
g. Additionally,
> > +    the application must define its own structure to store information=
 for reconnection.
> > +
> > +2.5 Completed the initialization and running the application.
> > +    While the application is running, it is important to store relevan=
t information
> > +    about reconnections in mapped pages. When calling the ioctl VDUSE_=
VQ_GET_INFO to
> > +    get vq information, it's necessary to check whether it's a reconne=
ction. If it is
> > +    a reconnection, the vq-related information must be get from the ma=
pped pages.
> > +
> > +2.6 When the Userspace application exits, it is necessary to unmap all=
 the
> > +    pages for reconnection
> > --
> > 2.43.0
>


