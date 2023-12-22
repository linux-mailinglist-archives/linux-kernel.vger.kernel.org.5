Return-Path: <linux-kernel+bounces-9527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B74E81C70C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8586DB212C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6FCD314;
	Fri, 22 Dec 2023 09:00:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D676DDAE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-33-OhDEaeKjMoSgrizogtDWdA-1; Fri, 22 Dec 2023 09:00:02 +0000
X-MC-Unique: OhDEaeKjMoSgrizogtDWdA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 22 Dec
 2023 08:59:47 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 22 Dec 2023 08:59:47 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "'guoren@kernel.org'" <guoren@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"alexghiti@rivosinc.com" <alexghiti@rivosinc.com>, "charlie@rivosinc.com"
	<charlie@rivosinc.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>,
	"david@redhat.com" <david@redhat.com>, "panqinglin2020@iscas.ac.cn"
	<panqinglin2020@iscas.ac.cn>, "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>, "willy@infradead.org" <willy@infradead.org>,
	"bjorn@rivosinc.com" <bjorn@rivosinc.com>, "conor.dooley@microchip.com"
	<conor.dooley@microchip.com>, "cleger@rivosinc.com" <cleger@rivosinc.com>,
	"leobras@redhat.com" <leobras@redhat.com>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "Guo
 Ren" <guoren@linux.alibaba.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH V2 2/4] riscv: mm: Fixup compat arch_get_mmap_end
Thread-Topic: [PATCH V2 2/4] riscv: mm: Fixup compat arch_get_mmap_end
Thread-Index: AQHaNCUDLOr76Y7kz0WYFR/4SG7VuLC1ATgA
Date: Fri, 22 Dec 2023 08:59:47 +0000
Message-ID: <367b05acb90d4a6e898dd34e4254b697@AcuMS.aculab.com>
References: <20231221154702.2267684-1-guoren@kernel.org>
 <20231221154702.2267684-3-guoren@kernel.org>
In-Reply-To: <20231221154702.2267684-3-guoren@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: guoren@kernel.org <guoren@kernel.org>
> Sent: 21 December 2023 15:47
>=20
> From: Guo Ren <guoren@linux.alibaba.com>
>=20
> When the task is in COMPAT mode, the arch_get_mmap_end should be 2GB,
> not TASK_SIZE_64. The TASK_SIZE has contained is_compat_mode()
> detection, so change the definition of STACK_TOP_MAX to TASK_SIZE
> directly.

Why 2G ?

IIRC for 32-bit native x86 the limit is 3G, but in compat mode
it is (just under) 4G.

There is a special mmap option (for programs like wine) to
limit mmap() to 2G.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


