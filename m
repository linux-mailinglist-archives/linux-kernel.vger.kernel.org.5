Return-Path: <linux-kernel+bounces-153740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5418AD292
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF37D1F21622
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BE3155330;
	Mon, 22 Apr 2024 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1+IxzqG"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A206155323;
	Mon, 22 Apr 2024 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804176; cv=none; b=E12EzD8OIhxcb4LVn8jv+y4F74l2eyI6ED+Hrs60Iscn2dWp570GuajAo9WHA9xJi0RprzgEunVyRxWeAwxhONEOklRo57APZwn1QzMY4DZUWScGh5ZgMl2+epcdl7wY/urFD+RNs6+tSM2j13ls/WKTMgXuzuJijvRIRoMKh1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804176; c=relaxed/simple;
	bh=pvMg8v9KxE5KJEycWSs0QebhErG3dC9I65w80Mm0wM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G3Qe1PKmMiu9y7Yfgd7tudryalV3W179cp5TjjMYJbNtT5k9KeTuRgu6WIQB7sDpkZu465rhobObU1NuU5pFzt6RN2piD1AmNcU5beuP9lsm1GIegqOU51IKk07/2XSlA7FuHsRFgCeUNtT5AkiLcH4JJgBZG/HdgMWcw7/AUQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1+IxzqG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e8fce77bb2so21082885ad.0;
        Mon, 22 Apr 2024 09:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713804175; x=1714408975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjDIyXeRN5F/Rz1j7hLtt0c+k3OrZr+6KVwQKgEg9NA=;
        b=Q1+IxzqG9dbki6AunlZew9HkGxzwoJN4POb8+uHRM13cHWirludjubZLg5QVkG6ek4
         7Xv7mxLYqWrGONuagTv3vIJIeRz2yGMt7mNA9TDgZnUZeM2I6dSLnxLriGcGpgvHoSme
         +yUyK9QTnGj5e5D5IKZPlSZPAimRjSlF9w6Zdqzkb1D6cw4yiO0ty+xR0/wibT0B/Q5S
         aFBUWjQ6kZqx0MVe1gSAjeVGBDq7dDwLyWB4kSiBOBshUgDLOicFNKEvIqEuyTgIClli
         XF3m9nhyoNWvyt4I5jZWCstC1ojC5Cge0oGWxutU8kp7LgMrZw7I5ngGkD3p9wAHM/jB
         xPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713804175; x=1714408975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjDIyXeRN5F/Rz1j7hLtt0c+k3OrZr+6KVwQKgEg9NA=;
        b=nIYKh3bT+4s5/Sg4WjpiQMSn4v3gIPs310cOOj5TOSVmkCh2B0wf9fdJOoEQ7Sf9AY
         OhT9TjHnNjqyL5Ib4ndYo7waQeWVaZENBoSyACcZOo7qlAUxsQGjydoDa8/p+ZHp2XoS
         IOjXjjHwZWVqCleSzD/MJivUbqX8sIirGAMsjaZonEmCiq9GGTN5iCXEE+z6dcKrzPce
         oJkeAQ8n9H+3qliggVcHQadPa4r1rfP+8qzvcOSMEOT0FNpQUHMkDnE5D5BPP7G67fM8
         raOS4hY0vPBUBRrTBT+zoGKA60xqhJTtDc4YrkiDhExl7yGN2IuRyxbF6QhY/3PPYRz6
         l6Lg==
X-Forwarded-Encrypted: i=1; AJvYcCX8H/cc3LEPZiuJWbH7CUdXFVOnrxomhhG2gkjCUhMe9dcjc78TCT5PqUf3CDD6xoEsn0Llk9AiAqj9v756RrxiI4lO0jRUvX6vhHASPz82wrxDc4P0K4VZ6zy/TJ56ZQM9ifVm0kHsh1pwvApJTz3ZSBYNhKVfvvOZpVTUV01usMznMrEWRzZU1eZfX6BEHhW2v/sB4Yhez8o+/TU=
X-Gm-Message-State: AOJu0YwNSYhmmilUsTCqfEP+zlHgfQAUDSMojaCQlUzpEW7KO1ZXYPPw
	DE6eyh5eQ8uYuofoEKDxK75qhLTtFu0Kuj08Mqj4dyS0fdFk1U+R
X-Google-Smtp-Source: AGHT+IEBSDCtqMN9don4XWWjqMotOgj9q/MREDNxdL5MkB6wNycQQ0VxWmkAd//5A3lFd861WFvO0g==
X-Received: by 2002:a17:903:120e:b0:1e3:dfdc:6972 with SMTP id l14-20020a170903120e00b001e3dfdc6972mr13052319plh.9.1713804174824;
        Mon, 22 Apr 2024 09:42:54 -0700 (PDT)
Received: from [127.0.1.1] ([2001:ee0:50f5:5d0:f32d:f608:a763:3732])
        by smtp.googlemail.com with ESMTPSA id p3-20020a170902780300b001e7b8c21ebesm8461702pll.225.2024.04.22.09.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:42:54 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
Date: Mon, 22 Apr 2024 23:41:40 +0700
Subject: [PATCH 5/5] drivers/s390/cio: ensure the copied buf is NULL
 terminated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-fix-oob-read-v1-5-e02854c30174@gmail.com>
References: <20240422-fix-oob-read-v1-0-e02854c30174@gmail.com>
In-Reply-To: <20240422-fix-oob-read-v1-0-e02854c30174@gmail.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>, 
 Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>, 
 GR-Linux-NIC-Dev@marvell.com, Krishna Gudipati <kgudipat@brocade.com>, 
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>, 
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Fabian Frederick <fabf@skynet.be>, Saurav Kashyap <skashyap@marvell.com>, 
 Javed Hasan <jhasan@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com, 
 Nilesh Javali <nilesh.javali@cavium.com>, Arun Easi <arun.easi@cavium.com>, 
 Manish Rangankar <manish.rangankar@cavium.com>, 
 Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Saurav Kashyap <saurav.kashyap@cavium.com>, linux-s390@vger.kernel.org, 
 Jens Axboe <axboe@kernel.dk>, Bui Quang Minh <minhquangbui99@gmail.com>
X-Mailer: b4 0.13.0

Currently, we allocate a lbuf-sized kernel buffer and copy lbuf from
userspace to that buffer. Later, we use scanf on this buffer but we don't
ensure that the string is terminated inside the buffer, this can lead to
OOB read when using scanf. Fix this issue by allocating 1 more byte to at
the end of buffer and write NULL terminator to the end of buffer after
userspace copying.

Fixes: a4f17cc72671 ("s390/cio: add CRW inject functionality")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/s390/cio/cio_inject.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/cio_inject.c b/drivers/s390/cio/cio_inject.c
index 8613fa937237..9b69fbf49f60 100644
--- a/drivers/s390/cio/cio_inject.c
+++ b/drivers/s390/cio/cio_inject.c
@@ -95,10 +95,11 @@ static ssize_t crw_inject_write(struct file *file, const char __user *buf,
 		return -EINVAL;
 	}
 
-	buffer = vmemdup_user(buf, lbuf);
+	buffer = vmemdup_user(buf, lbuf + 1);
 	if (IS_ERR(buffer))
 		return -ENOMEM;
 
+	buffer[lbuf] = '\0';
 	rc = sscanf(buffer, "%x %x %x %x %x %x %x", &slct, &oflw, &chn, &rsc, &anc,
 		    &erc, &rsid);
 

-- 
2.34.1


