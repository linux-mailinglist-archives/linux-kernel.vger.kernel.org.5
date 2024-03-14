Return-Path: <linux-kernel+bounces-103460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BE387BFA1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8590B1F23E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF18471747;
	Thu, 14 Mar 2024 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uh+HVKsO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21910DDD9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429055; cv=none; b=iMDrBuHipaggodVpUGsGQjiaQQV78eTn2a6fWsXrMAnf687Moy1rujBHnu68HUG1D8G0hwkyy/U5XBgbFmqtQpWNYChrrIe31uxXW0c6Ku8B92Od0lKx0GdqQSNlFr6i+6+Kv0eMlv5b+B/buIN8LzHuFWHujdaoj0TcbgklLZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429055; c=relaxed/simple;
	bh=AQfUW3gFNrbjXXL3IloGvW+E2jBS9PDIeGTSBRAl+RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD1+xavsgbyCNcdHGRt94smkdmSSF50VYpxsoj+E0iBF6owNf8j8lHkG9lbrJ9YC7lqI4fvpiRUM0bVq59SaFlBvRc0cU9LRRxbqerEIdxvZZ6c9mADpfR7XoR5SC7WHpJy9LHvRa1RwEjJzIR+cb83FwKf0vTcGovfwxnI6BjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uh+HVKsO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710429043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EtZDDd/rvhCl2ys9FRYjPigN0aLlgEl2NbUy3nuNa/o=;
	b=Uh+HVKsO22xCBfZyVdqOstqpz9mQXOTc7Za6z8ItoVZ+LaNniQvKP3uOFjcbMCGCyt5+fl
	Vay60tJrJpbdnggOR4NIUKSEM+lSpsnO0vyZ0ieyd5NKlXd8UM/8q/kJO83/GayuGSCEmj
	1DIxbMEOsRqZNlmy3g0F7+mSUvHptA0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-YJKIeZgBPTyqMKvWEz-mkg-1; Thu, 14 Mar 2024 11:09:32 -0400
X-MC-Unique: YJKIeZgBPTyqMKvWEz-mkg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-513b3ca9650so903486e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710428970; x=1711033770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtZDDd/rvhCl2ys9FRYjPigN0aLlgEl2NbUy3nuNa/o=;
        b=cuurIXjeWy/ZWYx2AiXot0g9kHouqKM7jJjPe5GrEWerEb9vmUjA3pxkawsQXsu5BM
         Dt4Lcn7k33bMJZCCmlf2wUEm0joGgKpnQXAZMP4O63lRXqly3tXZqa0+b5B9cHt2cmXq
         rpD0LRyYxNT0iNzG5LvEQOWKsJkmmav2EgK4VcLEr2JCd+IhYcdD8wtZ7IRyZcbdBnR8
         hdHBIoZEQx9IAoZW3dez/eBCnCz1PvTuU3RQ07nKxFH2gV8wRVT8jkjGuBBoTUL/onMh
         vJQGFgOUWYuY5DAJFefXX6CAi9fhyfghRM90MpSq3kq+YhaWshp4fFoZzT2c/AP9ZoOJ
         /Zug==
X-Forwarded-Encrypted: i=1; AJvYcCUUXp+Cjqe6Sm5hQAeB03EQiN/WsVvpqoRIrHPgO+5apVMxuZxxFuTHnaI0pKP+euD2bCm7SRg1VyI3yhho0wNw9sVkZx3KtxhU192I
X-Gm-Message-State: AOJu0Yyq868+tpZcBIh46vaxCopTyaysqi7vdkoqqP3mazWWkHy//6vX
	XLVmYoTjQHml93w3We+03u/bfCQnSIB9e0KEt1564dbWa84RQwKqKt7qDd4aTUZfc5NJd5Wuv1y
	qrTX/H+E2jZOLyiQ0xJpw4kczRvbT8Y93CZVfGCbuBvhb3RjM6QWIcB/XX6uzpA==
X-Received: by 2002:a19:914c:0:b0:513:cab1:dc9a with SMTP id y12-20020a19914c000000b00513cab1dc9amr1492771lfj.19.1710428970155;
        Thu, 14 Mar 2024 08:09:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJWuoe/3iFru0sIgh80GCQKJ1jGXO44jJmLMs2cyMkKY2erF0fOYFgEPRPLaBXlctWIZnyYg==
X-Received: by 2002:a19:914c:0:b0:513:cab1:dc9a with SMTP id y12-20020a19914c000000b00513cab1dc9amr1492752lfj.19.1710428969612;
        Thu, 14 Mar 2024 08:09:29 -0700 (PDT)
Received: from redhat.com ([2.52.141.198])
        by smtp.gmail.com with ESMTPSA id b9-20020a05600c4e0900b004132f8c2ac1sm2732690wmq.14.2024.03.14.08.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 08:09:29 -0700 (PDT)
Date: Thu, 14 Mar 2024 11:09:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Luis Machado <luis.machado@arm.com>, Jason Wang <jasowang@redhat.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	nd <nd@arm.com>
Subject: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6 sched/fair: Add
 lag based placement)
Message-ID: <20240314110649-mutt-send-email-mst@kernel.org>
References: <20231213094854-mutt-send-email-mst@kernel.org>
 <20231214021328-mutt-send-email-mst@kernel.org>
 <92916.124010808133201076@us-mta-622.us.mimecast.lan>
 <20240121134311-mutt-send-email-mst@kernel.org>
 <07974.124020102385100135@us-mta-501.us.mimecast.lan>
 <20240201030341-mutt-send-email-mst@kernel.org>
 <89460.124020106474400877@us-mta-475.us.mimecast.lan>
 <20240311130446-mutt-send-email-mst@kernel.org>
 <cf813f92-9806-4449-b099-1bb2bd492b3c@arm.com>
 <73123.124031407552500165@us-mta-156.us.mimecast.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73123.124031407552500165@us-mta-156.us.mimecast.lan>

On Thu, Mar 14, 2024 at 12:46:54PM +0100, Tobias Huschle wrote:
> On Tue, Mar 12, 2024 at 09:45:57AM +0000, Luis Machado wrote:
> > On 3/11/24 17:05, Michael S. Tsirkin wrote:
> > > 
> > > Are we going anywhere with this btw?
> > > 
> > >
> > 
> > I think Tobias had a couple other threads related to this, with other potential fixes:
> > 
> > https://lore.kernel.org/lkml/20240228161018.14253-1-huschle@linux.ibm.com/
> > 
> > https://lore.kernel.org/lkml/20240228161023.14310-1-huschle@linux.ibm.com/
> > 
> 
> Sorry, Michael, should have provided those threads here as well.
> 
> The more I look into this issue, the more things to ponder upon I find.
> It seems like this issue can (maybe) be fixed on the scheduler side after all.
> 
> The root cause of this regression remains that the mentioned kworker gets
> a negative lag value and is therefore not elligible to run on wake up.
> This negative lag is potentially assigned incorrectly. But I'm not sure yet.
> 
> Anytime I find something that can address the symptom, there is a potential
> root cause on another level, and I would like to avoid to just address a
> symptom to fix the issue, wheras it would be better to find the actual
> root cause.
> 
> I would nevertheless still argue, that vhost relies rather heavily on the fact
> that the kworker gets scheduled on wake up everytime. But I don't have a 
> proposal at hand that accounts for potential side effects if opting for
> explicitly initiating a schedule.
> Maybe the assumption, that said kworker should always be selected on wake 
> up is valid. In that case the explicit schedule would merely be a safety 
> net.
> 
> I will let you know if something comes up on the scheduler side. There are
> some more ideas on my side how this could be approached.

Thanks a lot! To clarify it is not that I am opposed to changing vhost.
I would like however for some documentation to exist saying that if you
do abc then call API xyz. Then I hope we can feel a bit safer that
future scheduler changes will not break vhost (though as usual, nothing
is for sure).  Right now we are going by the documentation and that says
cond_resched so we do that.

-- 
MST


