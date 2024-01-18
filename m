Return-Path: <linux-kernel+bounces-30361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA07831DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14034289844
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C582C1AC;
	Thu, 18 Jan 2024 16:45:51 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8773228E3A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596351; cv=none; b=m/P71AMzL3G2jYzpzzkxF3aPLHbQZgE5cIoKMdk0SXHlS8CrUjajuL2kgWZr5eIDqQr4QboMgY/USaLspGaGZ60aYG/MJOuLnj6jYuBdsIHSMT55o5nxTP6fTkwXzE+USDj+OMoUra5S3dJsHh7hcI5MQXXOBwYltaD8wIPG/4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596351; c=relaxed/simple;
	bh=SG5QZH1EZKylCYftBHdttqKqgIyhXeTEaQ2BW8oBf8o=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=Z5fbpwNHtJPkI7j1/19c+0xKy/bv8wdjlIjQejjWUOXKaAjxyHkOu+Wo0zt5crw3AI8Dp4DrBhcmG4qODT154y5HRgmXqiw0K8A2l33jKI7j1RMPdFnyIk5GPyjwL6MIjRd+TFOXEM3pl0qDnUo8yjD8xECbBOa7YWdwyUWYm/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bc2b7bef65so1123129639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 08:45:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705596348; x=1706201148;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+eAYtZcVX4zI2oi/ZfnKVJN97akTYdBLvFi9dAnH/0=;
        b=LYruesllGre8C9UzXBEnn53R2Ax3IQG/O7gIpbnSjtTmWyvMScZnGKWiDFoEahHzFL
         2sjSIP8wWS0YJyBAjsOpCRqgOht24XewO1Ch1sXFqpCHyBYmZjFgbJTQFq4RJRxVyPyT
         1+FALoEpjHra4nSNeeIsTmTMla+Tvc0zxLJvihgrLt+2P9DLvchrBks1qOOBH1G1nBxp
         bId5EuGJWujg135qsNHuHedk4scGJbvMPhWIMOHxfe73Oxndv+DZSIe+yE7786M5UGrj
         yYxt/g0/hhbW61aeRj/94zXtYtsQOQvMiS7+mRdZz9tg1mz6EtoPZtNfEQV9iSSHmfWS
         KPVQ==
X-Gm-Message-State: AOJu0Yxwq+khzGREL8N73IaE3Iw4b1xUmqh3eXiuV/HLCokmRH7wLGDj
	S7HXyriwcj7oAxurACOX/PU37liZJf5w51iUJajs5W1Q+mdi+d1p7kBLMxd9jSKAF84UWiuYcaU
	rzrjY4E/AJbgqHHnjIN486B9BMmT/+FFPAR8rko92BTkwyPyicbwA1EBrJQ==
X-Google-Smtp-Source: AGHT+IHVbyEXfo71E/S3bCFY6t3V7V0YmMgVwhb18w7B8pMwnhrf3BOaAXTYByeKrfO02OlMLx6eN8+GfTvZkiGZDPtWRxmxP628
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1648:b0:7bf:338:c77a with SMTP id
 y8-20020a056602164800b007bf0338c77amr36524iow.3.1705596348714; Thu, 18 Jan
 2024 08:45:48 -0800 (PST)
Date: Thu, 18 Jan 2024 08:45:48 -0800
In-Reply-To: <000000000000e3d83a060ee5285a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ed418060f3b1822@google.com>
Subject: Re: [syzbot] [syzbot] [nfs?] KMSAN: kernel-infoleak in
 sys_name_to_handle_at (4)
From: syzbot <syzbot+09b349b3066c2e0b1e96@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [nfs?] KMSAN: kernel-infoleak in sys_name_to_handle_at (4)
Author: n.zhandarovich@fintech.ru

Try using kzalloc() instead of kmalloc() in do_sys_name_to_handle()

#syz test: https://github.com/google/kmsan.git master

---
 fs/fhandle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 18b3ba8dc8ea..57a12614addf 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -36,7 +36,7 @@ static long do_sys_name_to_handle(const struct path *path,
 	if (f_handle.handle_bytes > MAX_HANDLE_SZ)
 		return -EINVAL;
 
-	handle = kmalloc(sizeof(struct file_handle) + f_handle.handle_bytes,
+	handle = kzalloc(sizeof(struct file_handle) + f_handle.handle_bytes,
 			 GFP_KERNEL);
 	if (!handle)
 		return -ENOMEM;
-- 
2.25.1


