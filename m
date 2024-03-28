Return-Path: <linux-kernel+bounces-108611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7008880CF3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC51B234C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3FC36B08;
	Wed, 20 Mar 2024 08:22:10 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FAF11720;
	Wed, 20 Mar 2024 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710922930; cv=none; b=abwN9zCRHbNNaJT513Dp6+9Jvt6+72IL289nu9lMgZDeiMc9pnvqNTS779wlhBj7qeQl06yvUuyVR+IBMo/vuTKNQJSPDH559UP3lYCDnIjnlY7rbmK65QKQxFGSXQSKDgY4uXeHo3S60/xdyD7rtQ28X+DFZjAPJTOZ8elSPRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710922930; c=relaxed/simple;
	bh=9yBbHSOJlL9pdcEYP8Hk+lnve6pJYkw0t1O5f/G/TDo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FP+cFuCt6rDteQzw/1XsJdkbNGnf6GEuI121vFecMj7P68qHERAleBTOWLfIVuPRT46kn22pg0Vepot7dfExiEoP92OToqIfNaeNXc/9ol4rOuZ2GWyfBC2MRECAN1QbF8SPvx6uMzDvYIfcg1fvYUIc0I0euSJx5jpP0czjf6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from msexch01.omp.ru (10.188.4.12) by msexch02.omp.ru (10.188.4.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 20 Mar
 2024 11:21:56 +0300
Received: from msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753]) by
 msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753%5]) with mapi id 15.02.1258.012;
 Wed, 20 Mar 2024 11:21:56 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Jarkko Sakkinen <jarkko@kernel.org>, David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Andrew Zaborowski <andrew.zaborowski@intel.com>
CC: "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, "Sergey
 Shtylyov" <s.shtylyov@omp.ru>
Subject: Re: [PATCH] KEYS: prevent NULL pointer dereference in
 find_asymmetric_key()
Thread-Topic: [PATCH] KEYS: prevent NULL pointer dereference in
 find_asymmetric_key()
Thread-Index: AQHadsRHcr0dJekxEkCC6oTcOjjyP7E9+xQAgAEukF2AACqYAIAA/WFj
Date: Wed, 20 Mar 2024 08:21:56 +0000
Message-ID: <7fd0f2a8252d4a6aa295adc1e76bc0e2@omp.ru>
References: <20240315103320.18754-1-r.smirnov@omp.ru>
 <CZX9T3TU6YU0.3JE9M7M3ENUE0@kernel.org>
 <b5f21d1175c142efb52e68a24bc4165a@omp.ru>,<CZY02YNBTGYQ.3KG8NLH8X3RQE@kernel.org>
In-Reply-To: <CZY02YNBTGYQ.3KG8NLH8X3RQE@kernel.org>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: msexch02.omp.ru, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 3/20/2024 4:50:00 AM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 19 Mar 2024 22:14:22 +0200 Jarkko Sakkinen wrote:
> On Tue Mar 19, 2024 at 4:44 PM EET, Roman Smirnov wrote:
> > On Tue, 19 Mar 2024 01:39:00 +0200 Jarkko Sakkinen wrote:
> > > On Fri Mar 15, 2024 at 12:33 PM EET, Roman Smirnov wrote:
[...]
> > > >
> > > > Found by Linux Verification Center (linuxtesting.org) with Svace.
> > >=20
> > > I'm not sure if this should be part of the commit message.
> >
> > I have already submitted patches with this line, some have been
> > accepted. It is important for the Linux Verification Center to mark
> > patches as closing issues found with Svace.
> >
> > > >
> > > > Fixes: 7d30198ee24f ("keys: X.509 public key issuer lookup without =
AKID")
> > > > Suggested-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> > >=20
> > > Should be reported-by.
> >
> > The suggested-by tag belongs to Sergey because he suggested the fix,
> > subject/description of the patch. The tag reported-by belongs to
> > Svace tool.
>
> 1. I did not see any reported-by tags in this which is requirement.
> 2. Who did find the issue using that tool? I don't put reported-by to
>    GDB even if I use that find the bug.

Svace is an automated bug finding tool. This error was found during
source code analysis by the program, so the tag reported-by does not
belong to any person. I don't know what to do in such a situation,
but write something like:

    Reported-by: Svace

would be weird. I think that the line "Found by Linux ... with Svace"
could be a substitute for the tag.=

