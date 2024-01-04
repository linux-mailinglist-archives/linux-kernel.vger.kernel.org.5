Return-Path: <linux-kernel+bounces-16432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB43823E7F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AECAF1C23909
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE89A20327;
	Thu,  4 Jan 2024 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="SLyewzUv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FD62030A;
	Thu,  4 Jan 2024 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1704360169; x=1735896169;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X05DzwK/q9MkZAmJyZEF2ihoOm61DrnuEUS0sLrHCvI=;
  b=SLyewzUvRKtmjhDtq+6ur3RP5c6Fe+1Ntg38u7Q147XxkeXAQ+hKqKhP
   y70WtCrsGbnM4+BVjCiW53v/MT6ZpPQYhREWjBeKPH9elDuXj+wNYwGP4
   0C58YJudKOmet88xMb+Thx3jpvRTcu2mQfz8lg29goQXoAfyrQcYcdwyZ
   4=;
X-IronPort-AV: E=Sophos;i="6.04,330,1695686400"; 
   d="scan'208";a="625630305"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 09:22:44 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix) with ESMTPS id 7F4368A04E;
	Thu,  4 Jan 2024 09:22:42 +0000 (UTC)
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:50268]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.37.235:2525] with esmtp (Farcaster)
 id 3c5fd880-9e5d-4151-988b-13075e669f77; Thu, 4 Jan 2024 09:22:41 +0000 (UTC)
X-Farcaster-Flow-ID: 3c5fd880-9e5d-4151-988b-13075e669f77
Received: from EX19D033EUC003.ant.amazon.com (10.252.61.134) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 4 Jan 2024 09:22:36 +0000
Received: from EX19D032EUC002.ant.amazon.com (10.252.61.185) by
 EX19D033EUC003.ant.amazon.com (10.252.61.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 4 Jan 2024 09:22:36 +0000
Received: from EX19D032EUC002.ant.amazon.com ([fe80::e696:121c:a227:174]) by
 EX19D032EUC002.ant.amazon.com ([fe80::e696:121c:a227:174%3]) with mapi id
 15.02.1118.040; Thu, 4 Jan 2024 09:22:36 +0000
From: "Durrant, Paul" <pdurrant@amazon.co.uk>
To: "Allister, Jack" <jalliste@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Allister, Jack" <jalliste@amazon.co.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, "Wang, Jue" <juew@amazon.com>, Usama Arif
	<usama.arif@bytedance.com>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Tejun Heo
	<tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Yan-Jie Wang
	<yanjiewtw@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v6] x86: intel_epb: Add earlyparam option to keep bias at
 performance
Thread-Topic: [PATCH v6] x86: intel_epb: Add earlyparam option to keep bias at
 performance
Thread-Index: AQHaPu06oUuGY3zUqk+MuinfJmm8L7DJYJiQ
Date: Thu, 4 Jan 2024 09:22:35 +0000
Message-ID: <12f10bbcba78463fa274e17fad305894@amazon.co.uk>
References: <ff3a0382-734d-4f46-bd35-ffa1f53a3ac3@intel.com>
 <20240104090551.46251-1-jalliste@amazon.com>
In-Reply-To: <20240104090551.46251-1-jalliste@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> -----Original Message-----
> From: Jack Allister <jalliste@amazon.com>
> Sent: 04 January 2024 09:06
> Cc: Allister, Jack <jalliste@amazon.co.uk>; Rafael J . Wysocki
> <rafael@kernel.org>; Durrant, Paul <pdurrant@amazon.co.uk>; Wang, Jue
> <juew@amazon.com>; Usama Arif <usama.arif@bytedance.com>; Jonathan Corbet
> <corbet@lwn.net>; Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar
> <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>; Dave Hansen
> <dave.hansen@linux.intel.com>; x86@kernel.org; H. Peter Anvin
> <hpa@zytor.com>; Paul E. McKenney <paulmck@kernel.org>; Randy Dunlap
> <rdunlap@infradead.org>; Tejun Heo <tj@kernel.org>; Peter Zijlstra
> <peterz@infradead.org>; Yan-Jie Wang <yanjiewtw@gmail.com>; Hans de Goede
> <hdegoede@redhat.com>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v6] x86: intel_epb: Add earlyparam option to keep bias at
> performance
>=20
> Buggy BIOSes may not set a sane boot-time Energy Performance Bias (EPB).
> A result of this may be overheating or excess power usage. The kernel
> overrides any boot-time EPB "performance" bias to "normal" to avoid this.
>=20
> When used in data centers it is preferable keep the EPB at "performance"
> when performing a live-update of the host kernel via a kexec to the new
> kernel. This is due to boot-time being critical when performing the kexec
> as running guest VMs will perceieve this as latency or downtime.
>=20
> On Intel Xeon Ice Lake platforms it has been observed that a combination
> of
> EPB being set to "normal" alongside HWP (Intel Hardware P-states) being
> enabled/configured during or close to the kexec causes an increases the
> live-update/kexec downtime by 7 times compared to when the EPB is set to
> "performance".
>=20
> Introduce a command-line parameter, "intel_epb=3Dpreserve", to skip the
> "performance" -> "normal" override/workaround. This maintains prior
> functionality when no parameter is set, but adds in the ability to stay a=
t
> performance for a speedy kexec if a user wishes.
>=20
> Signed-off-by: Jack Allister <jalliste@amazon.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Paul Durrant <pdurrant@amazon.com>
> Cc: Jue Wang <juew@amazon.com>
> Cc: Usama Arif <usama.arif@bytedance.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  9 ++++++++
>  arch/x86/kernel/cpu/intel_epb.c               | 22 +++++++++++++++++--
>  2 files changed, 29 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Paul Durrant <pdurrant@amazon.com>

