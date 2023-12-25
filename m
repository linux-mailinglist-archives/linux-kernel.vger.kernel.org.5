Return-Path: <linux-kernel+bounces-11189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF3A81E2F5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90002B215F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 23:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3715453E26;
	Mon, 25 Dec 2023 23:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVyHHONS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFFE53E17
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703547117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSlPAyAZzv+QVMkLmtnw21kPDx01ngb4jPGaj9Nd6Dk=;
	b=HVyHHONSLpmH/07R0WiJVsExF/p1CmbYgE+YlNcfUm2aHUILjCjSRNqkpwRc+vkvmo8djH
	2Eb+UpUKqyYNWnLIoKUizg780dSMQw80lMDzKJYybwsiOreswNnldvF4hdsVLvoCKlofed
	Wj0OxoPd3q2t7rVAVV98UdgeviFAM0s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-Kp_o3q8TMuunmh3-dbEeKw-1; Mon,
 25 Dec 2023 18:31:54 -0500
X-MC-Unique: Kp_o3q8TMuunmh3-dbEeKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E07831C172C1;
	Mon, 25 Dec 2023 23:31:53 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E1691C060AF;
	Mon, 25 Dec 2023 23:31:52 +0000 (UTC)
Date: Tue, 26 Dec 2023 07:31:49 +0800
From: Baoquan He <bhe@redhat.com>
To: fuqiang wang <fuqiang.wang@easystack.cn>, akpm@linux-foundation.org
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/kexec: fix potential cmem->ranges out of bounds
Message-ID: <ZYoQ5ej3uDKt5rmw@MiWiFi-R3L-srv>
References: <20231222121855.148215-1-fuqiang.wang@easystack.cn>
 <ZYWPHSmwK8iG6xUr@MiWiFi-R3L-srv>
 <ZYe3iN816iiKDwIu@MiWiFi-R3L-srv>
 <a65e7a06-bc91-4c82-9a65-6066f9f64409@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a65e7a06-bc91-4c82-9a65-6066f9f64409@easystack.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 12/25/23 at 09:44pm, fuqiang wang wrote:
> 在 2023/12/24 12:46, Baoquan He 写道:
> 
> > Rethink about this, seems above code comment is fine to be kept, and the
> > same feeling about the elfheader region split from crashk_res. So, other
> > than the patch log concerns, this patch looks good to me. Let's see if
> > other people has concern about the newly added comments.
> > 
> 
> Hi Baoquan
> 
> Thank you very much for your suggestions in the patch log and code comments. I
> have learned a lot and I will gradually improve.
> 
> I found the following patch in linux-next:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=666ef13f2870c43ba8a402ec8a3cedf6eb6c6f5a
> 
> I'm sorry, It's my mistake. Do you think it is still necessary to merge this
> patch based on that ?

That patch need be withdrew because that is not expected according to
our discussion.

Hi Andrew,

Could you withdraw the patch fuqiang mentioned?

x86/crash: fix potential cmem->ranges array overflow
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=666ef13f2870c43ba8a402ec8a3cedf6eb6c6f5a

Thanks


