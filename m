Return-Path: <linux-kernel+bounces-107651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3070D87FFA4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543281C21BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B797F200BA;
	Tue, 19 Mar 2024 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaPtggXi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33F546BF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710858744; cv=none; b=YFMGknlaY0NL9PHSDvfYNMi2ICLBTVlnib7H7yOcA0PX/e+NwPE2X2+fFcHW0SJ0+308NkvhW71FlJMwu8rpxLVjzRwqR/g9ryBq+GER5ZeFFibqM8uwG66GPOvWlca3jJpUnOAIDDBc9cIDeYEKvwAeK+AcPmP9VBqGdMskqIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710858744; c=relaxed/simple;
	bh=CtbjVAzI1TTRnxHrtvdkjylVVNAWSDgWFFarj5wI+To=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iXx020NCkmDs5f7yWIEvQxBKe33uiNfhjvTH+A8rVmlituTjBeWp3DBeuK5+Cw8PKNbzwtyX3FgYmGQHptY3VCjf6dk5MNve/MDpvHx6aEG2iN/4fs3PcdpJXvTjHQOZG9+ObKYVDE7emsx3mpozCNVAC7nKGU9vChTUFhzRzqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HaPtggXi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710858741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NMOlZZVpc/B3d/wBiRgPwi4KSA7KCUCmf1+nlUjP7U8=;
	b=HaPtggXiV09NbOx/gOep1A4valgygpBpQMZYuaw80dmvSf3JbeuKWLVXMjmhs7GZ9ZSIOv
	pSOpy9mLKPMSdzNHXZ69oig6iH8enedJKau1rsqwfEdVhIPCo+/IFiM+TaEliXMHP5R/b1
	bmB3/ZU5kD6oSg9jxrVxrFAtfRNV2io=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-Ec0miqAZOUKgMzDzdlN55g-1; Tue, 19 Mar 2024 10:32:19 -0400
X-MC-Unique: Ec0miqAZOUKgMzDzdlN55g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e354aaf56so6593955e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710858738; x=1711463538;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NMOlZZVpc/B3d/wBiRgPwi4KSA7KCUCmf1+nlUjP7U8=;
        b=JLuvKpmY3fW3EdzStMD2TNwMzePTfg9/FSDHwkEpinAmrr8PZUL71yrwVSFgGSlT88
         76EkaqUJdaFh70ZsMAnE+QBDja8Vt3LqK4bcu9sELIzPUWCYs0NZz02yd/o2IW8TJdAp
         SJSxhdayVe+sKmZxUP/+aYRlyBM7OkNXAqZQXNzqDYEtN2+2/xH+j3yMYk7635h88rwU
         XaRrnmINNt58P7cWx4crxeZBtx0l1qjX1N9DuNrVw/1Ihk9ptoHXye+m9ROipjTJgHpa
         EnfI1/Jzn+t0sBKc7JKT9WqNLPkYtAo0BJbzqRwy8zYrphD/yszrxkKDcf9gjm1VF2g3
         lhTA==
X-Forwarded-Encrypted: i=1; AJvYcCUWWfUtR74OrkWofywBFMF+AAlNyyV10bOZoGP7QnBtM7Aodav2UEjsYaDmM9jHztzuNpVG1np+tXaUtZ0D+dtZUQp5PBmLvSq1SiEL
X-Gm-Message-State: AOJu0YycADjGd3fjwNazOfbz+pysyJpK6tGl7w0aWZcKY8Iq0A3s/iAC
	FsQMzWHasvmYiRuU1Kz+cpmYuOSwUXxtjAC08UrdRKADmlvJKvOn0Zd6Uq8EJCFWrO1Fm06Yveb
	xiuTJFpr0ATmM37wkRZyXAZ0umiZauNo94AjIHeXN+0nSd6X4UAXvHjL2Rj47QA==
X-Received: by 2002:a5d:6a03:0:b0:33d:32f7:c85 with SMTP id m3-20020a5d6a03000000b0033d32f70c85mr1815720wru.0.1710858738251;
        Tue, 19 Mar 2024 07:32:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjYXbDiL/z8L5wdHscpGgk6mkfnRgNqw26X+z9KaGAZLsJKk/mSmVTvg3oqMyoXRQGXm53Iw==
X-Received: by 2002:a5d:6a03:0:b0:33d:32f7:c85 with SMTP id m3-20020a5d6a03000000b0033d32f70c85mr1815709wru.0.1710858737855;
        Tue, 19 Mar 2024 07:32:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-224-202.dyn.eolo.it. [146.241.224.202])
        by smtp.gmail.com with ESMTPSA id n6-20020a5d4006000000b0033e699fc6b4sm12536133wrp.69.2024.03.19.07.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 07:32:17 -0700 (PDT)
Message-ID: <0bfbe50a087725366a47ee36d4778292e19bbee9.camel@redhat.com>
Subject: Re: [PATCH net v1] mlxbf_gige: open() should call request_irq()
 after NAPI init
From: Paolo Abeni <pabeni@redhat.com>
To: David Thompson <davthompson@nvidia.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, u.kleine-koenig@pengutronix.de, 
	leon@kernel.org
Cc: asmaa@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 19 Mar 2024 15:32:16 +0100
In-Reply-To: <20240315145609.23950-1-davthompson@nvidia.com>
References: <20240315145609.23950-1-davthompson@nvidia.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-15 at 10:56 -0400, David Thompson wrote:
> This patch fixes an exception that occurs during open()
> when kdump is enabled.  The sequence to reproduce the
> exception is as follows:
> a) enable kdump
> b) trigger kdump via "echo c > /proc/sysrq-trigger"
> c) kdump kernel executes
> d) kdump kernel loads mlxbf_gige module
> e) the mlxbf_gige module runs its open() as the
>    the "oob_net0" interface is brought up
> f) mlxbf_gige module will experience an exception
>    during its open(), something like:
>=20
>      Unable to handle kernel NULL pointer dereference at virtual address =
0000000000000000
>      Mem abort info:
>        ESR =3D 0x0000000086000004
>        EC =3D 0x21: IABT (current EL), IL =3D 32 bits
>        SET =3D 0, FnV =3D 0
>        EA =3D 0, S1PTW =3D 0
>        FSC =3D 0x04: level 0 translation fault
>      user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000e29a4000
>      [0000000000000000] pgd=3D0000000000000000, p4d=3D0000000000000000
>      Internal error: Oops: 0000000086000004 [#1] SMP
>      CPU: 0 PID: 812 Comm: NetworkManager Tainted: G           OE     5.1=
5.0-1035-bluefield #37-Ubuntu
>      Hardware name: https://www.mellanox.com BlueField-3 SmartNIC Main Ca=
rd/BlueField-3 SmartNIC Main Card, BIOS 4.6.0.13024 Jan 19 2024
>      pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>      pc : 0x0
>      lr : __napi_poll+0x40/0x230
>      sp : ffff800008003e00
>      x29: ffff800008003e00 x28: 0000000000000000 x27: 00000000ffffffff
>      x26: ffff000066027238 x25: ffff00007cedec00 x24: ffff800008003ec8
>      x23: 000000000000012c x22: ffff800008003eb7 x21: 0000000000000000
>      x20: 0000000000000001 x19: ffff000066027238 x18: 0000000000000000
>      x17: ffff578fcb450000 x16: ffffa870b083c7c0 x15: 0000aaab010441d0
>      x14: 0000000000000001 x13: 00726f7272655f65 x12: 6769675f6662786c
>      x11: 0000000000000000 x10: 0000000000000000 x9 : ffffa870b0842398
>      x8 : 0000000000000004 x7 : fe5a48b9069706ea x6 : 17fdb11fc84ae0d2
>      x5 : d94a82549d594f35 x4 : 0000000000000000 x3 : 0000000000400100
>      x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000066027238
>      Call trace:
>       0x0
>       net_rx_action+0x178/0x360
>       __do_softirq+0x15c/0x428
>       __irq_exit_rcu+0xac/0xec
>       irq_exit+0x18/0x2c
>       handle_domain_irq+0x6c/0xa0
>       gic_handle_irq+0xec/0x1b0
>       call_on_irq_stack+0x20/0x2c
>       do_interrupt_handler+0x5c/0x70
>       el1_interrupt+0x30/0x50
>       el1h_64_irq_handler+0x18/0x2c
>       el1h_64_irq+0x7c/0x80
>       __setup_irq+0x4c0/0x950
>       request_threaded_irq+0xf4/0x1bc
>       mlxbf_gige_request_irqs+0x68/0x110 [mlxbf_gige]
>       mlxbf_gige_open+0x5c/0x170 [mlxbf_gige]
>       __dev_open+0x100/0x220
>       __dev_change_flags+0x16c/0x1f0
>       dev_change_flags+0x2c/0x70
>       do_setlink+0x220/0xa40
>       __rtnl_newlink+0x56c/0x8a0
>       rtnl_newlink+0x58/0x84
>       rtnetlink_rcv_msg+0x138/0x3c4
>       netlink_rcv_skb+0x64/0x130
>       rtnetlink_rcv+0x20/0x30
>       netlink_unicast+0x2ec/0x360
>       netlink_sendmsg+0x278/0x490
>       __sock_sendmsg+0x5c/0x6c
>       ____sys_sendmsg+0x290/0x2d4
>       ___sys_sendmsg+0x84/0xd0
>       __sys_sendmsg+0x70/0xd0
>       __arm64_sys_sendmsg+0x2c/0x40
>       invoke_syscall+0x78/0x100
>       el0_svc_common.constprop.0+0x54/0x184
>       do_el0_svc+0x30/0xac
>       el0_svc+0x48/0x160
>       el0t_64_sync_handler+0xa4/0x12c
>       el0t_64_sync+0x1a4/0x1a8
>      Code: bad PC value
>      ---[ end trace 7d1c3f3bf9d81885 ]---
>      Kernel panic - not syncing: Oops: Fatal exception in interrupt
>      Kernel Offset: 0x2870a7a00000 from 0xffff800008000000
>      PHYS_OFFSET: 0x80000000
>      CPU features: 0x0,000005c1,a3332a5a
>      Memory Limit: none
>      ---[ end Kernel panic - not syncing: Oops: Fatal exception in interr=
upt ]---
>=20
> The exception happens because there is a pending RX interrupt before the
> call to request_irq(RX IRQ) executes.  Then, the RX IRQ handler fires
> immediately after this request_irq() completes. The RX IRQ handler runs
> "napi_schedule()" before NAPI is fully initialized via "netif_napi_add()"
> and "napi_enable()", both which happen later in the open() logic.
>=20
> This patch fixes the issue by re-ordering the logic in mlxbf_gige open()
> so that the request_irq() calls execute after NAPI is fully initialized.

It also adds a missing phy_stop(phydev) in the error path. It's worth
mentioning in the changelog or possibly place into a separate patch.

Cheers,

Paolo


