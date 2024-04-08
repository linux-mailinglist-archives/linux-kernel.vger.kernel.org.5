Return-Path: <linux-kernel+bounces-135599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF6189C837
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A091C22D4A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC66C14039D;
	Mon,  8 Apr 2024 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i87uljCJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCF814038A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589959; cv=none; b=m0bo3uOu73k2qbijUvtQpLBY456B7fy/JumIn3jPxcT1FO0TX52KC5Yl6K69vhOK3tGNtEHRNL3hU6PP+3ZuhX/LzcUHxcKqGDKj31YPWZ22bqOsqERCl6aS68O6A3GI/4TcBCis7rxrzuQbwgZDNLdXGuaB6zUDPycPQLI7bF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589959; c=relaxed/simple;
	bh=E2bygDLxctLyEaBgrlNgxm+JWadAQkRVMDbvCvnQsQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mZ1AR14rgyxdPOZB0eLo/ntiUhksF5kgP+4IsfPeIRfBe1N3fQGLlT5lu4cOz3ss/DBcddmjAwZhrMeCWv4/vaIqBc2CRDL14/Iu5kSOFa4vDwltKjzXnWONF/l2qZblEf5Gpb7WNxb21W0nILdP+XrvR0MHm3k/+3pV9Oxyd38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i87uljCJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712589956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E2bygDLxctLyEaBgrlNgxm+JWadAQkRVMDbvCvnQsQk=;
	b=i87uljCJUPsuJLpA4HuRizPR9hOuHe5hVeKI7gRiakC72Fj8wCfUVqP7rFwVyc8F0DfUd8
	wJ48ZiJI9y2/mgMMPx67aCED9/mBl44tJDjJT0WHwPYWSDgUiIpDt9ejDq3yZfpPKiqYL0
	THd0mGxmWCBjvjejNNonXpRmzgD6hBw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-3Nu3O5w2MYqMQE1K92yMSQ-1; Mon, 08 Apr 2024 11:25:54 -0400
X-MC-Unique: 3Nu3O5w2MYqMQE1K92yMSQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6993bd297ebso47656056d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 08:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712589954; x=1713194754;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2bygDLxctLyEaBgrlNgxm+JWadAQkRVMDbvCvnQsQk=;
        b=fZFV5MYXMMPpGoU2mIAYfu9qrlNOKe3SOi191wH8Dfrz1tk7gyWY1B/YWMr9troXzu
         oSl/AaTMntOhkSZsegfMBLhkqftzlu6DUci5e3UEas4UuE1SHiH8/0D+omxlOfrB18CA
         ZdRhhn/NA431KeYAB4p0SVUTBFSzOWq3Zo5ud6deFHGWdAxmWCmW2DFvQrXT5bow6zEX
         U7Mxjyi/5yojCsuzPOOz6RTo3HY10clLZ8UlX1W2zFbvyeUVkW+LU/pVSyc1/iIvcVA9
         DW4NzWRXVHDA2/1uR2nrhcnK7ERdHYXG0P3nYXk9IlblO8YuUPpfM/b2GYJz8eJObKSJ
         YEWg==
X-Forwarded-Encrypted: i=1; AJvYcCWZnI4uXLj3Ale850buU4ObmKtfwMxtmRSlZCaOVQVUi+CEkEEiOq07Kj52lFIHopCRNxlA5DXdHGI1E2cSMzUz/smDPI+p7qDs+Gne
X-Gm-Message-State: AOJu0YwYLCcQQ7C3/qQxstKUKgBPlC2R7aTSsXf658g1/tPs/4VI/hfF
	KTRVb1v8APSb2oy10DuaBs0Bb6jVq+ryl4Xm36pqc7BUUlieF8l3h3uYHuhjnxW1cNtExbnGl9O
	yt8bs07WqX+ole3lXrr+I95OKwfqQNGc2ASjZ/v8tOSa4Gj2KzA3ZPz2C9otmLg==
X-Received: by 2002:a05:6214:e47:b0:69b:1f07:44ce with SMTP id o7-20020a0562140e4700b0069b1f0744cemr2010616qvc.60.1712589954271;
        Mon, 08 Apr 2024 08:25:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjEWhXR1gWfsxsS0ukk1VT9VCFDHUHzGnv1HkbZBErleNvDjFgwO+Da1XgmL5NoX4hL4iYjw==
X-Received: by 2002:a05:6214:e47:b0:69b:1f07:44ce with SMTP id o7-20020a0562140e4700b0069b1f0744cemr2010603qvc.60.1712589954016;
        Mon, 08 Apr 2024 08:25:54 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id j9-20020a0cf9c9000000b0069b20aed8b4sm512884qvo.103.2024.04.08.08.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:25:53 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Alexandru Ardelean <alex@shruggie.ro>, linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 tian.xianting@h3c.com, steffen.aschbacher@stihl.de,
 gregkh@linuxfoundation.org
Subject: Re: [PATCH][V2] sched/rt: Print curr when RT throttling activated
In-Reply-To: <CAH3L5QqZ61H9Fk24R4K3vNdpmvBjnxHaxH7CRTT5Fa3tbot_hg@mail.gmail.com>
References: <20230516122202.954313-1-alex@shruggie.ro>
 <CAH3L5QoBqSOBHhoxSrYw6U34gqTPEhi_RB_Cve-YmBzYj3LXAQ@mail.gmail.com>
 <CAH3L5QqZ61H9Fk24R4K3vNdpmvBjnxHaxH7CRTT5Fa3tbot_hg@mail.gmail.com>
Date: Mon, 08 Apr 2024 17:25:50 +0200
Message-ID: <xhsmho7ajanb5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/04/24 18:47, Alexandru Ardelean wrote:
> On Thu, Jul 13, 2023 at 11:07=E2=80=AFPM Alexandru Ardelean <alex@shruggi=
e.ro> wrote:
>>
>> On Tue, May 16, 2023 at 3:22=E2=80=AFPM Alexandru Ardelean <alex@shruggi=
e.ro> wrote:
>> >
>> > From: Xianting Tian <tian.xianting@h3c.com>
>> >
>> > We may meet the issue, that one RT thread occupied the cpu by 950ms/1s,
>> > The RT thread maybe is a business thread or other unknown thread.
>> >
>> > Currently, it only outputs the print "sched: RT throttling activated"
>> > when RT throttling happen. It is hard to know what is the RT thread,
>> > For further analysis, we need add more prints.
>> >
>> > This patch is to print current RT task when RT throttling activated,
>> > It help us to know what is the RT thread in the first time.
>> >
>>
>> Adding Greg on this patch, since it 's been a while.
>> And also: ping :)
>
> Ping on this :)
>

AFAIA this has been proposed a few times in the past, the problem is that
printing the current task isn't the right thing to do as it may not be the
one that contributed most of the runtime that lead to throttling.

See https://lore.kernel.org/lkml/20221209163606.53a2370e@gandalf.local.home/


