Return-Path: <linux-kernel+bounces-122922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9FF88FF87
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57967293A79
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F7D8060B;
	Thu, 28 Mar 2024 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e33gRX4r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779E1DDF6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630132; cv=none; b=rh8cYjXo+F2SGx/oxhlY7Gx7e/UI9i6pskb0PHc+0qES6nr27sXr7g73QETmMHkPr5aGJ4CZDLwPKt9K9eZ8lpIZCtGjrOJZR4F97Vhg2N3n6p98Z42hjF3hLXeAGt5Cpa6o3Lr/OWDatkPEYQapkxgc7+yiuO8NdP8meUZ4n44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630132; c=relaxed/simple;
	bh=Ihr7L8SWFId0wHZDJNAhIySLvqt1dNUVwx+q54NFASE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yqccp0CdBMoCqK04HF1Zb0jmc2dttjSAIXzwGCR2oIXUDCwAzwfMRSr1xwAI7kMg6Km+DFof8IPtzWHXO1hiXqn5P0UKf48IzeVRC+rxBWdFIvmoSvMpZWyL48G5Uu3binw1axEvrgnLYPeYXMwgfiJn1U0VD69Wg9RqjTvjcB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e33gRX4r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711630128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AgaT+pY93qnOUFTULTCBIx5BPdYnscxfg11Ywj5dIco=;
	b=e33gRX4r+52CSNllithyfSHPlvu5OSMg02jEld6cynawHIOUG/YdczUxx1iaXrqcGhMrzy
	q51qksMf5pkKhJ176xgZREJxFAJrxj/XGjAYeTyU8r+35UQPsrYyZQ6QBOml6YSqmRAaT9
	0GueL/DpkKXJq7wS0y7lqvyLxuzQhnk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-9vzhBFvJNO27D4bR-eRsaA-1; Thu, 28 Mar 2024 08:48:47 -0400
X-MC-Unique: 9vzhBFvJNO27D4bR-eRsaA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-341c449d7beso201020f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711630126; x=1712234926;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgaT+pY93qnOUFTULTCBIx5BPdYnscxfg11Ywj5dIco=;
        b=jBZiIShdFjzqWfrDSphfjoV5miPTnI2pfTCvU3ZlBCJ8m32qz3WKxpHpr813h9NZ3J
         bcq5EuWGCouZotZAP6UDHAHmCfIW9AzFQKFeUPUz1Eg10yTUO+7M+19q1XrgVXcC3EC7
         xadnz0UrbZcufOQdndJy9WOYfhyJ6nogR9EbyHqgWYto6zKP4rXyHqaASjWbLUhIFSP4
         C+qM6wofCpXuXDDmnhPp5fSPgtM8yOlA40R36KPcOhj0r4HbCbF4rREUeG2AxkZdmydo
         nNZnayBT8rRb5tA17A846krCWfKZQSA0cG3Q9vx73MyEl2GbarAcsh8CKXdUqx7grvKo
         XF2w==
X-Forwarded-Encrypted: i=1; AJvYcCVPdhl8jJES1j0W+8lSAeUpzX0MntVD+r4X+SgqDsFryWazTyRdx0Sd+/cpG/9890QcZBCYyWzKNgg1nHKP1Z7pHTm4Yi+qo+ZT9R4g
X-Gm-Message-State: AOJu0YxMDgrR6oHKFyQi4TEI2GtVfPPkTB6rAJK3d+4AsDVa96kNFrmG
	J+c5AdLkFFf/dyZd+I92SwMrhHijHKvvtpBtqPOm6LRD1lqZ7sahJa1ASeIp4FzFhdsLmLsVxc4
	TCwm9DH7WLW5Ke7+96JNwzmzR9zE9IxCFXbgEsh1AkeGv3yyy4oo9td1suwBsjg==
X-Received: by 2002:a05:600c:1d1c:b0:415:4334:7f55 with SMTP id l28-20020a05600c1d1c00b0041543347f55mr1493914wms.3.1711630126141;
        Thu, 28 Mar 2024 05:48:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH1dc0NV1gXSA1yPOqwdvHxIofEWbhTXPxuMBp9lVsn4Xg7fLdSZoyWoBKUsHvXmkjuQTQhg==
X-Received: by 2002:a05:600c:1d1c:b0:415:4334:7f55 with SMTP id l28-20020a05600c1d1c00b0041543347f55mr1493893wms.3.1711630125734;
        Thu, 28 Mar 2024 05:48:45 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-47.dyn.eolo.it. [146.241.249.47])
        by smtp.gmail.com with ESMTPSA id di6-20020a0560000ac600b00341c9956dc9sm1680130wrb.68.2024.03.28.05.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:48:45 -0700 (PDT)
Message-ID: <69cf3037390c7d82365ab0f5f92d55bd88a2400a.camel@redhat.com>
Subject: Re: [PATCH net v1] mlxbf_gige: stop interface during shutdown
From: Paolo Abeni <pabeni@redhat.com>
To: David Thompson <davthompson@nvidia.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, u.kleine-koenig@pengutronix.de, 
	leon@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 28 Mar 2024 13:48:43 +0100
In-Reply-To: <20240325210929.25362-1-davthompson@nvidia.com>
References: <20240325210929.25362-1-davthompson@nvidia.com>
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

On Mon, 2024-03-25 at 17:09 -0400, David Thompson wrote:
> The mlxbf_gige driver intermittantly encounters a NULL pointer
> exception while the system is shutting down via "reboot" command.
> The mlxbf_driver will experience an exception right after executing
> its shutdown() method.  One example of this exception is:
>=20
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
00000000070
> Mem abort info:
>   ESR =3D 0x0000000096000004
>   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>   SET =3D 0, FnV =3D 0
>   EA =3D 0, S1PTW =3D 0
>   FSC =3D 0x04: level 0 translation fault
> Data abort info:
>   ISV =3D 0, ISS =3D 0x00000004
>   CM =3D 0, WnR =3D 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000011d373000
> [0000000000000070] pgd=3D0000000000000000, p4d=3D0000000000000000
> Internal error: Oops: 96000004 [#1] SMP
> CPU: 0 PID: 13 Comm: ksoftirqd/0 Tainted: G S         OE     5.15.0-bf.6.=
gef6992a #1
> Hardware name: https://www.mellanox.com BlueField SoC/BlueField SoC, BIOS=
 4.0.2.12669 Apr 21 2023
> pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : mlxbf_gige_handle_tx_complete+0xc8/0x170 [mlxbf_gige]
> lr : mlxbf_gige_poll+0x54/0x160 [mlxbf_gige]
> sp : ffff8000080d3c10
> x29: ffff8000080d3c10 x28: ffffcce72cbb7000 x27: ffff8000080d3d58
> x26: ffff0000814e7340 x25: ffff331cd1a05000 x24: ffffcce72c4ea008
> x23: ffff0000814e4b40 x22: ffff0000814e4d10 x21: ffff0000814e4128
> x20: 0000000000000000 x19: ffff0000814e4a80 x18: ffffffffffffffff
> x17: 000000000000001c x16: ffffcce72b4553f4 x15: ffff80008805b8a7
> x14: 0000000000000000 x13: 0000000000000030 x12: 0101010101010101
> x11: 7f7f7f7f7f7f7f7f x10: c2ac898b17576267 x9 : ffffcce720fa5404
> x8 : ffff000080812138 x7 : 0000000000002e9a x6 : 0000000000000080
> x5 : ffff00008de3b000 x4 : 0000000000000000 x3 : 0000000000000001
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  mlxbf_gige_handle_tx_complete+0xc8/0x170 [mlxbf_gige]
>  mlxbf_gige_poll+0x54/0x160 [mlxbf_gige]
>  __napi_poll+0x40/0x1c8
>  net_rx_action+0x314/0x3a0
>  __do_softirq+0x128/0x334
>  run_ksoftirqd+0x54/0x6c
>  smpboot_thread_fn+0x14c/0x190
>  kthread+0x10c/0x110
>  ret_from_fork+0x10/0x20
> Code: 8b070000 f9000ea0 f95056c0 f86178a1 (b9407002)
> ---[ end trace 7cc3941aa0d8e6a4 ]---
> Kernel panic - not syncing: Oops: Fatal exception in interrupt
> Kernel Offset: 0x4ce722520000 from 0xffff800008000000
> PHYS_OFFSET: 0x80000000
> CPU features: 0x000005c1,a3330e5a
> Memory Limit: none
> ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]=
---
>=20
> During system shutdown, the mlxbf_gige driver's shutdown() is always exec=
uted.
> However, the driver's stop() method will only execute if networking inter=
face
> configuration logic within the Linux distribution has been setup to do so=
.
>=20
> If shutdown() executes but stop() does not execute, NAPI remains enabled
> and this can lead to an exception if NAPI is scheduled while the hardware
> interface has only been partially deinitialized.
>=20
> The networking interface managed by the mlxbf_gige driver must be properl=
y
> stopped during system shutdown so that IFF_UP is cleared, the hardware
> interface is put into a clean state, and NAPI is fully deinitialized.
>=20
> Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
> Signed-off-by: David Thompson <davthompson@nvidia.com>

LGTM, but it would be nice if someone else at nvidia could have a look.

Thanks!

Paolo


