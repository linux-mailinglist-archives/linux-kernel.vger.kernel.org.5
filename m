Return-Path: <linux-kernel+bounces-163692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE438B6E62
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1955E28138C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FB1127E2F;
	Tue, 30 Apr 2024 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IP5HH1i+"
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F3D28DDF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469519; cv=none; b=dVHnzy3ZS2J/bf0WO3I7SgfKY4T3mK7yNYbmRu1f8HwYS9UJcxgo/XVmuzBOcGGkkVxF3YW1QzIVZ/Cq3YGmRqGjsh8Gn7G78r5EyyZQ/U+JcQCe/DoqQhiuUiK43g6HAYFysb0vXSlVGgtoDlLZHX8R9GOZjUkpQkTJAesxcIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469519; c=relaxed/simple;
	bh=GyrnoGgCwPvSi7f0bGGT8Rkatbx9R1Lw+jk2EHRtaXk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=tn5mAiHYZVnpLBpHOYqifgOKgOQunHkWgkVMJ0RlIA18eRG4FbQ3H4EtL9QftgpN3fXpRRGyxaZx0uVJzy4vUM5yK6fgBBbp3pLN7AoQWET0khzcveSzksqntVkgpIWUkOAkytjTEIoHNEapO4TIevRKaGq2Py29vKznhJQxxmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=IP5HH1i+; arc=none smtp.client-ip=203.205.251.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1714469509; bh=HLV0QD/9WTdmLS6RCyWcgbzB9VHBZ4GBfqebvLw9pxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IP5HH1i+aHmDhnGYoA3kECb5Zt79YVeLmMZwy/PUzBQQm48/Qgf3Pb5NyzOcrmVgn
	 FUIKyk8nfqXS6+APN1e80RJ7aWvTPza/SGyXLD+F/6vD9D9ggqt7D4e/+1ky2lrKY4
	 7BR9MXfAAzYEysYRLV00cgF58491jpMBqNXg9Q4Y=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 7EF29854; Tue, 30 Apr 2024 17:31:47 +0800
X-QQ-mid: xmsmtpt1714469507t94g3cd0w
Message-ID: <tencent_546DA49414E876EEBECF2C78D26D242EE50A@qq.com>
X-QQ-XMAILINFO: N+bThp2B+LIxQ3WebrxRv9uyBrNb1R/uJqRNy/xC9KgJ24jrMuaSUEE1vzWqTF
	 /W22NtAswJo6LcbthliuhkaAhYyBF59tFA08xRejB+09ghOvDcE7q2ew6LCSL9iN05+TouhD3jA6
	 4a9Q4L3zXWSvUPigKxJ7qbpTxTKa35+CljNl2AQwOlYvfA//q+9qj+w44sx3fbD7V+Iy8juXXtt/
	 DkFvhJQJTN+mNd5BFF0UT260ZrT3k7q56UbPAMMpBj+/ZmdN71STqGp31bUYbkO2gWe8ptISIwQV
	 razorMFiNSokKdI/0VqlHLCgSQKGw9sXt1gxQG/QBSTAihJprOHfIFhJW49ZhOtj26gb3afct3TM
	 MRk4IAujVYg24PdK18wY9VZZwouckB5AlNffGJizt2n5ew1FCapI8afmGLnOnxhZF29JuwburNwF
	 s36H2rWvSh+aT2rVfn2Gr6eQKj0BhYSbFEio/iLTFIbUzJ33vqeH9ldzJCpeRZcMYb1zNMsByTaD
	 xX5ezAu/Y1l0zD/nTINEl1zxBtPr3Z9wuWof9oZigXPUIEQ1ffisOPG+TnM07/fsT1Juo4rpUmm6
	 Heyu5NZIFD+btdkYRErHqVuBnql2fzTMeU9AW2s46P8xoG0o5j0Ly3U7pqQE3CNWLWq//UEVi0YR
	 k1zswyePG9VcaHnv/XyXN2Dro1vjLaekANsH0ugyTIalDTqIhIZdHfvIzQv8ElvxKpLYlMTAe/GX
	 8eISl8cZKkCxwoFTjUTjLiNFpEqOZ9B8LRFK3ERT7Itp7RazhDRG0KgP3MA30Kk4iV8IEkF8zNPi
	 YBBuiOOBg929Z+lzJhL80gl8Q134bWcqo8T3ZgZ/mqq6vkJrmQulLnrduOyn0U1k8QeBq+UB8JL4
	 GogLuXGC0zaKwJkKrbYdn1h2x1Ptm6JEwVrHxk0d7N7QrF/QjgS6krBIT9QhCoXQ+dCItD/Z9eZD
	 mpbd+UcBI=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read in vhost_task_fn
Date: Tue, 30 Apr 2024 17:31:47 +0800
X-OQ-MSGID: <20240430093146.810849-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000a9613006174c1c4c@google.com>
References: <000000000000a9613006174c1c4c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uaf in vhost_task_fn

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git bb7a2467e6be
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 48c289947b99..8800f5acc007 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -61,8 +61,8 @@ static int vhost_task_fn(void *data)
 		set_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags);
 		vtsk->handle_sigkill(vtsk->data);
 	}
-	complete(&vtsk->exited);
 	mutex_unlock(&vtsk->exit_mutex);
+	complete(&vtsk->exited);
 
 	do_exit(0);
 }


