Return-Path: <linux-kernel+bounces-116662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2763688A234
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D15481F3BE52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054F812D1EF;
	Mon, 25 Mar 2024 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQSs45jo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A9812CDB1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711352757; cv=none; b=b0XL74VUMqqTJeCF8Hg5pDlWYx4KdxYuOIdUgyZ9XFslRce5DU8VpGixzznpcDXPTqCnyHNHuc8IYxCNXkJ+JCnzRpW2xGnAjmNlhohRs9rtaVuD19X3rtwAo1Zg+9WKLCGtiB5OUU2jfnvOt3bclGfPN9vu/q+ogM2wtRjHXNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711352757; c=relaxed/simple;
	bh=XLXR7CpeR8gHAez+Vwa8A2VvxLDQcEPkSjGIz/Pgx0g=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NNhI45Qtj1iKTEQLDoWc1ORaPjp/AIDIU2o8hHnf052mKKxgANVqLPHAxkZDpSgQCXpre92n4IVszJU0Se56YHvgRRuzyud56PLv5iZBAywBj4INp0j5IjIGU9MI+Eg3HkXpDNoGLlaleKVS6U9KufKDIrnsbue244etqr7VpTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQSs45jo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711352754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PXxUYXNi2B5JrRFUMDl5qPnuHfLdN9B9ueRStkVYom4=;
	b=QQSs45jo6eXyoK0lK02A8RnAYGcgjVXJ0ZOMHC/lJGBJj6cIQa5HP/oub/4Qtkf0svP8lc
	iz5oPfpgHBe07enbqFn9uIe+oRY9hlP0vRsJlALAjgaU2PRe3RaKIu4WW7kR3wZuq4M3n1
	QZvu4zpJ4QObRdLgduCStlWlx2RS1vw=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-mfYpWBL6PqeDkxMe6ychaQ-1; Mon, 25 Mar 2024 03:45:52 -0400
X-MC-Unique: mfYpWBL6PqeDkxMe6ychaQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6e356790f94so2463481b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 00:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711352751; x=1711957551;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PXxUYXNi2B5JrRFUMDl5qPnuHfLdN9B9ueRStkVYom4=;
        b=kxBU+xBULpQGONbRN3Q9iU1IV6IkI2BV7vgNZXiYYdfEH3q0EsuF3aDFfnrt08v0r5
         fQJAXbCWMkWun9oqx5x23Eb+Ys+okfqseb4PpxqnYDmyLiSn4ydOcFR/PVm2kFRqnk8N
         qkcV5QfFUCZsRcRGq6v8l6+7wOkcfL2KbHCPnI+cYf2Ixl28EwTYzsn6I+z0DC4/MPNS
         /Vpu0VhwDB5yUDNClRVXJ+Vtjs3TsZygrNTBa90FACf6EytQ3lTt62oSOHc8HgFJgsrT
         8ebe9vzTomj94DjbLjQm7HkewP//v63zmk+ED1CDFdZRwC2g7inAw4W8S0jGbu03mDuJ
         B+NA==
X-Gm-Message-State: AOJu0YwRIqOkBY7wI2FvEU4NAlbYap1oJZtO791lBlyeHogC3lD7LutT
	6jl7LXlw+AEDXLDZEjtv2SIOqRLWUkSflJqYOc/iAYzhpwHvNNsyL7FcoWD2qAOsAkKBasppe3w
	3iy3N4YIY1FFnWw4eYhMeZHT49fQGrko+VnBKDNCAZ6bsJUZ9g+Lzo4WHGFFH/vGHwdaLFbLk
X-Received: by 2002:a05:6a00:4fc9:b0:6ea:7ff3:e8c1 with SMTP id le9-20020a056a004fc900b006ea7ff3e8c1mr9608557pfb.5.1711352751116;
        Mon, 25 Mar 2024 00:45:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4ZACPGPHFgRBDJfktlN/sU04zwVuM4xZKCNpfkktNV4fv7/XUA5fEqqO9DV5nkcXInyfwNw==
X-Received: by 2002:a05:6a00:4fc9:b0:6ea:7ff3:e8c1 with SMTP id le9-20020a056a004fc900b006ea7ff3e8c1mr9608542pfb.5.1711352750729;
        Mon, 25 Mar 2024 00:45:50 -0700 (PDT)
Received: from [10.72.113.22] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v6-20020aa78086000000b006ea8c030c1esm3576295pff.211.2024.03.25.00.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 00:45:50 -0700 (PDT)
Message-ID: <e119b3e2-09a0-47a7-945c-98a1f03633ef@redhat.com>
Date: Mon, 25 Mar 2024 15:45:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
 Ceph Development <ceph-devel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
From: Xiubo Li <xiubli@redhat.com>
Subject: kernel BUG at mm/usercopy.c:102 -- pc : usercopy_abort
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi guys,

We are hitting the same crash frequently recently with the latest kernel 
when testing kceph, and the call trace will be something likes:

[ 1580.034891] usercopy: Kernel memory exposure attempt detected from 
SLUB object 'kmalloc-192' (offset 82, size 499712)!^M
[ 1580.045866] ------------[ cut here ]------------^M
[ 1580.050551] kernel BUG at mm/usercopy.c:102!^M
^M
Entering kdb (current=0xffff8881211f5500, pid 172901) on processor 4 
Oops: (null)^M
due to oops @ 0xffffffff8138cabd^M
CPU: 4 PID: 172901 Comm: fsstress Tainted: G S 6.6.0-g623393c9d50c #1^M
Hardware name: Supermicro SYS-5018R-WR/X10SRW-F, BIOS 1.0c 09/07/2015^M
RIP: 0010:usercopy_abort+0x6d/0x80^M
Code: 4c 0f 44 d0 41 53 48 c7 c0 1c e9 13 82 48 c7 c6 71 62 13 82 48 0f 
45 f0 48 89 f9 48 c7 c7 f0 6b 1b 82 4c 89 d2 e8 63 2b df ff <0f> 0b 49 
c7 c1 44 c8 14 82 4d 89 cb 4d 89 c8 eb a5 66 90 f3 0f 1e^M
RSP: 0018:ffffc90006dfba88 EFLAGS: 00010246^M
RAX: 000000000000006a RBX: 000000000007a000 RCX: 0000000000000000^M
RDX: 0000000000000000 RSI: ffff88885fd1d880 RDI: ffff88885fd1d880^M
RBP: 000000000007a000 R08: 0000000000000000 R09: c0000000ffffdfff^M
R10: 0000000000000001 R11: ffffc90006dfb930 R12: 0000000000000001^M
R13: ffff8882b7bbed12 R14: ffff88827a375830 R15: ffff8882b7b44d12^M
FS:  00007fb24c859500(0000) GS:ffff88885fd00000(0000) 
knlGS:0000000000000000^M
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
CR2: 000055c2bcf9eb00 CR3: 000000028956c005 CR4: 00000000001706e0^M
Call Trace:^M
  <TASK>^M
  ? kdb_main_loop+0x32c/0xa10^M
  ? kdb_stub+0x216/0x420^M
more>

You can see more detail in ceph tracker 
https://tracker.ceph.com/issues/64471.

I have seen someone has reported a similar issue one year ago but that 
has been fixed already, please see 
https://lore.kernel.org/linux-mm/CANn89iLaWZhrfyn8NBzdN1zQC0d47WC4_jvpwKQPoHwyCVueVQ@mail.gmail.com/T/.

Is it a known issue ?

Thanks

- Xiubo




