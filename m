Return-Path: <linux-kernel+bounces-126168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F2289330E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084691C223A4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE44F145FF6;
	Sun, 31 Mar 2024 16:27:44 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7325214EC57;
	Sun, 31 Mar 2024 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902463; cv=fail; b=SiFbLfUuVwhhkK9eQ2Zn2dfAsOOLNZOndaOzJHxAuFpq/txKyFGJFqBnmvc/0+k39MppgEJbr9GkdblkopaH55vHZxOQ47uRCTAmioFsrkvr5nuyZT3rMxAv4t6oX924iqLSSfdFx91htNf2/p+grEjEfpAIs97vaAeqJ+piZcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902463; c=relaxed/simple;
	bh=g4lYfwETIOu+M8/pMzPJsYcFQwPd+aO++vxQ/K6ghTw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByDAFv2jlRWE73eW7nZkH53/OEFb0aihFImML6Yr2KPXUmHrG8YSRBZKAuzH4KYNDt8/KTrlbC1O0ZFcdBvDG8HCQd0GZzV8GZvpzdHniubUrDKpwfQt/5ndDdVcaBh0x61pWtWxi4oOnUpxFrbAlJvOwXD3IO52OFL36okaH8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=shingroup.cn; spf=fail smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.65.219; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=shingroup.cn
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C9842208C1;
	Sun, 31 Mar 2024 18:27:37 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LMUQsmKzwcG9; Sun, 31 Mar 2024 18:27:31 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 9C293208C2;
	Sun, 31 Mar 2024 18:27:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 9C293208C2
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 8F4C9800051;
	Sun, 31 Mar 2024 18:27:30 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:27:30 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:44 +0000
X-sender: <netdev+bounces-83494-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAbAACAAAFAAwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwAPAAAAU2NodW1hbm4sIFBldGVyBQA8AAIAAAUAHQAPAAwAAABtYngtZXNzZW4tMDEFAA4AEQAuyVP5XtO9RYbNJlr9VbVbBQALABcAvgAAAEOSGd+Q7QVIkVZ3ffGxE8RDTj1EQjQsQ049RGF0YWJhc2VzLENOPUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpLENOPUFkbWluaXN0cmF0aXZlIEdyb3VwcyxDTj1zZWN1bmV0LENOPU1pY3Jvc29mdCBFeGNoYW5nZSxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXNlY3VuZXQsREM9ZGUFABIADwBgAAAAL289c2VjdW5ldC9vdT1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKS9jbj1SZWNpcGllbnRzL2NuPVBldGVyIFNjaHVtYW5uNWU3BQBHAAIAAAUARgAHAAMAAAAFAEMAAgAABQAWAAIAAAUAagAJAAEAAAAAAAAABQAUABEAnTlpvhaBCEeyp1ntZSMfKQUAFQAWAAIAAAAPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAIwACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAmAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAFZ7p8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAqAAAAk4oAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABDwAqAAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5SZXN1Ym1pdENvdW50BwABAAAADwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1YgUAKQACAAE=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 14315
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=netdev+bounces-83494-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C43A3208B4
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711775345; cv=none; b=gfLWY1ioFi9jl1ZBFjmxmFW2tHmdP96al/rViDheOnyYsGPNiY/6rojsa6KuCViu6ospo8JqIPmrQ5kYhXxI4fWTd13oBUM7loEJ816ctuoV5AIOJRDqdy8LJMFGF588bEGNcNoJZnlMJ+26z+gcXZ2kaQlCf0QR+U0nKFsVYlw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711775345; c=relaxed/simple;
	bh=nYsJpAvl6D6Ldufd73Rjy7YF1XYSzElH1fykgREgPxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPDDajRC5sef6WYcCenUzFrJabkj3nFiAaNM8jxBguQE+fYD0jUXLYNwIYYdx/DfR8ex7tUilcegtdOsom4YdWhROAmwHDAxg4AfPonb2M1mMwD3xYUyVNldguOl29V8JvaRRyAAWjRH+cUhqKQq6qdlYHWWn1MFfLqI2qghuRo=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz13t1711775229tdi4p2
X-QQ-Originating-IP: RfTYRleHqifmaUL5vg3HHBAADHtyt3J2efZxDgCsTa0=
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: OtIeQkg1QQHVkELNGhnn3Ao/OxN3u837g2WY2miXs+dKwNICeHodGDXYI+XIN
	MLiksvoY6OK484p/H1Pd7HcbM0rICeev22amIC6/BI2BPXdj7hZR/NjRgIzO0ujc7AJYyuh
	hSs4kN6XesHATJzk7YtHOv0oscVKSJDG1YcCID61KeNwB//v/SP6Vco5Zi0zVzK2CryiHy7
	MDlcbxtiVcvQbWgHR9uJniyBUgkXuWUpSRm9PGge+rsWbj+CoXH7KA5p92J+1tMYPfc3pMS
	a2+D1HW1CQDyFXgH/iGbdQU2wmJ3Udzd7Q8BgYnuoVkISFF2Z3cH4G9BqZDzzOAp62v8M7U
	2sZsZTz6rWN4NWIO+LXnMPEd2Ftx/MDN8OxPXGUXp3ZrWXMIP1dg4Nut1Jfsg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10889329762490604258
Date: Sat, 30 Mar 2024 13:07:06 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Eric Dumazet <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ioana.ciornei@nxp.com>, <wintera@linux.ibm.com>, <twinkler@linux.ibm.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net/iucv: Avoid explicit cpumask var
 allocation on stack
Message-ID: <4E49057A4198779C+Zged+hXhxE4GksiL@centos8>
References: <20240329105610.922675-1-dawei.li@shingroup.cn>
 <20240329105610.922675-2-dawei.li@shingroup.cn>
 <CANn89iJzuw8_ti4P4tJ_A3Fd0QCjHTBjasbm_J3N8up=gK8Aow@mail.gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANn89iJzuw8_ti4P4tJ_A3Fd0QCjHTBjasbm_J3N8up=gK8Aow@mail.gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hi Eric,

On Fri, Mar 29, 2024 at 02:21:28PM +0100, Eric Dumazet wrote:
> On Fri, Mar 29, 2024 at 11:57=E2=80=AFAM Dawei Li <dawei.li@shingroup.cn>=
 wrote:
> >
> > For CONFIG_CPUMASK_OFFSTACK=3Dy kernel, explicit allocation of cpumask
> > variable on stack is not recommended since it can cause potential stack
> > overflow.
> >
> > Instead, kernel code should always use *cpumask_var API(s) to allocate
> > cpumask var in config-neutral way, leaving allocation strategy to
> > CONFIG_CPUMASK_OFFSTACK.
> >
> > Use *cpumask_var API(s) to address it.
> >
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > ---
> >  net/iucv/iucv.c | 37 ++++++++++++++++++++++++++-----------
> >  1 file changed, 26 insertions(+), 11 deletions(-)
> >
> > diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
> > index a4ab615ca3e3..b51f46ec32f9 100644
> > --- a/net/iucv/iucv.c
> > +++ b/net/iucv/iucv.c
> > @@ -520,14 +520,19 @@ static void iucv_setmask_mp(void)
> >   */
> >  static void iucv_setmask_up(void)
> >  {
> > -       cpumask_t cpumask;
> > +       cpumask_var_t cpumask;
> >         int cpu;
> >
> > +       if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
> > +               return;
>=20
> This can not be right. iucv_setmask_up() is not supposed to fail.
>=20
> Since iucv_setmask_up() is only called with iucv_register_mutex held,
> you could simply add a 'static' for @cpumask variable.

Correct, iucv_register_mutex is a global lock and can serialize access
on static cpumask var.

I will respin V2 as you suggested.

Thanks,

    Dawei
>=20
>=20
>=20
> > +
> >         /* Disable all cpu but the first in cpu_irq_cpumask. */
> > -       cpumask_copy(&cpumask, &iucv_irq_cpumask);
> > -       cpumask_clear_cpu(cpumask_first(&iucv_irq_cpumask), &cpumask);
> > -       for_each_cpu(cpu, &cpumask)
> > +       cpumask_copy(cpumask, &iucv_irq_cpumask);
> > +       cpumask_clear_cpu(cpumask_first(&iucv_irq_cpumask), cpumask);
> > +       for_each_cpu(cpu, cpumask)
> >                 smp_call_function_single(cpu, iucv_block_cpu, NULL, 1);
> > +
> > +       free_cpumask_var(cpumask);
> >  }
>=20


