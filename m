Return-Path: <linux-kernel+bounces-23101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A94AB82A7A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32AE52862AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3669FE572;
	Thu, 11 Jan 2024 06:35:22 +0000 (UTC)
Received: from smtp238.sjtu.edu.cn (smtp238.sjtu.edu.cn [202.120.2.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF351E546
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjtu.edu.cn
Received: from mta90.sjtu.edu.cn (unknown [10.118.0.90])
	by smtp238.sjtu.edu.cn (Postfix) with ESMTPS id 3C6959CB3;
	Thu, 11 Jan 2024 14:35:09 +0800 (CST)
Received: from mstore135.sjtu.edu.cn (unknown [10.118.0.135])
	by mta90.sjtu.edu.cn (Postfix) with ESMTP id 0173437C87C;
	Thu, 11 Jan 2024 14:35:08 +0800 (CST)
Date: Thu, 11 Jan 2024 14:35:08 +0800 (CST)
From: Zheyun Shen <szy0127@sjtu.edu.cn>
To: Jason Wang <jasowang@redhat.com>, mst <mst@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	virtualization <virtualization@lists.linux.dev>, 
	david <david@redhat.com>, xuanzhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <1824181559.1228150.1704954908335.JavaMail.zimbra@sjtu.edu.cn>
Subject: Re: [PATCH] driver/virtio: Add Memory Balloon Support for
 SEV/SEV-ES
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 10.0.5_GA_4574 (ZimbraWebClient - GC120 (Win)/10.0.5_GA_4574)
Thread-Index: l+gZfqyZiAOpiygeFB9+OsBBxO8d6Q==
Thread-Topic: driver/virtio: Add Memory Balloon Support for SEV/SEV-ES

On Wed, Jan 10, 2024 at 4:01=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> Sorry I don't get what you are saying at all.
> Please format the commit log along the following lines:

> Currently .....
> This is bad because ...
> To fix ...
> As a result ...

> No way I am going to spead CONFIG_AMD_MEM_ENCRYPT all over the place=20
> like this.

I will try to find out a solution with fewer macros and send patch V2
with a more perspicuous commit log.



On Thur, Jan 11, 2024 at 11:20=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:

> > For now, SEV pins guest's memory to avoid swapping or
> > moving ciphertext, but leading to the inhibition of
> > Memory Ballooning.
> >
> > In Memory Ballooning, only guest's free pages will be relocated
> > in balloon inflation and deflation, so the difference of plaintext
> > doesn't matter to guest.

> This seems only true if the page is zeroed, is this true here?

Sorry, I cannot figure out why the pages should be zeroed. I think
both host kernel and guest kernel assume that the pages are not=20
zeroed and will use kzalloc or manually zero them in real applications,
which is same as non-SEV environments.=20

I have tested in SEV-ES, reclaiming memory by balloon inflation and reuse=
=20
them after balloon deflation both works well with the patch. Hypervisor=20
can normally give the reclaimed memory from one CVM to another, or give=20
back to the origin CVM.

