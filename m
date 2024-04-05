Return-Path: <linux-kernel+bounces-132823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E26899ABB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E38283829
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C63161B52;
	Fri,  5 Apr 2024 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FHCTfvGW"
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1540142E73
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312798; cv=none; b=Icpf9LpmLe5FYbTWBk55SGzfS5p/JX7ilmaumZAhQs2BZgcMItoqz6jRqhFN72tB/stLXfkyvuS/hq7m8VG+Gq4+VjUaQ6UtGMj8JqTiP6qE6c7TVfwUduOvHXQhNlLgQ2KjmOOac2gjezL1M+mz7iwbczI3F+pTyZ5oC/Rgvl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312798; c=relaxed/simple;
	bh=ZUjt3cn6Jciw9Yzl+9UZycVqc/qXs9Q8GWj5hR5RLZ4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Mf2SqJDbcGt+AkOc3wii1yIquD2outFJFi85n27PI6QUSmgvbcBNPwDwpptfmI/kwdMSTc1bXhl1uU7b/gI5USzR5JAVZ1MTGehdU0OtDL3Nb2prcUhNZqxosJH6cEq4GWQDywfHfxMhs8dSnuupe6CWvAMIwmqm40q10ysllGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FHCTfvGW; arc=none smtp.client-ip=203.205.251.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712312786; bh=37tWAJ0q0mR8nZCkCCUVBIS8KeNb1ZTR/arOTSOcqzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FHCTfvGW0P66a7EGzk5rgkeplkI1T/msLhJSM5BCvpLkBv622NwjUxWGC/M+bd0Yc
	 NmbP2RMmcE3XtDXzfcaUEe8ez9/zEni7vICIAY2pCrwigCkZwHuy1/uufE40WjXYqO
	 kt9nArPuHgq6l/VpFfD/hnV6eOa1jBLyt1lx2T04=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 517872E8; Fri, 05 Apr 2024 18:20:23 +0800
X-QQ-mid: xmsmtpt1712312423t8wyk8uxe
Message-ID: <tencent_3625ABBA9DBB0A33C69E1A1B8A4B7B1BC308@qq.com>
X-QQ-XMAILINFO: MFWpArBVhhGTWNlr2ZQekxpqK7CZKj2N3vN0YlVUpCOhZwiBLQFDcdss7Tjs7G
	 8OzJ9hopT36pRIb70GKQos42iqcq7BvLyeK9vSyJxTpIGkL8P4BQr9SKuSxpJWykI13zd95RkCD2
	 N+GFEMLpAl9BroXBim+g9XH6Du6Vb0mBAY37+ypjp82P3V0jo/4r5UEJs0MtaYIjlmdm4wCj1RN2
	 t+sTUNShmia6JEaPNXDvAjUWPHs6BB7PzoAl/O0ppL/ykpZGKIfz4xbnJtbCm/C2pDXGoav6VAa/
	 IPbpVev7RpzcXYSDMXFza/JJNwZaAP2HFxm6vVFnA9MhyLZG0OhWmvr9AXHZLPSlMPiuSmRovQ2m
	 d2/orSduTvJfrsumBI7BZPMO+1HRox37m+e8zxhmpxXh+pPIWCY1SFIc6adkwXqy/6s4WrYVTzDE
	 m0N8SQ6nPNjXaoD2lBv51shUbqBKykKYyYIsXJr7xvM2vlfKs3jneMDxanqGm5MyUxdpG3Plx2ja
	 S2OpWQyCoS2O8C44ZE2Y86C9dmjmNZAxjv0vp27RDDi3sM8LVeWMuCyQrjNiZfJkaYCeTv44vTGu
	 Xp2cwUEjhPIM7/w0JnA4id34sn/86tCpYg4DAvu1N4nP1Ppw695QDS039EYgQu9G6oliCyRhGRRv
	 ezzghjfLo9TvyJSCeCDER9nZVrBhNil5SpkSnCwj62UVecYQpyzo6Crhvr0MfnH3QW6fyTr3zKIH
	 RJQS4yLX6kAW08aUtgQC1DOVPu+Hf6Dg4B4yarTEXDU7fkItnpEXhKpLDw4DDPCTwUjIH0LBJG7Q
	 On2DLk5vB7xJSX+oWjOXCM7ScmYtIZqG9kIAQ3eTojMHK3nYvxRiC0jz8Omaw4ABROPBKqj8qvG/
	 6UVDUxzjQlSsn+Lg3ZglVDJ8euWPFztrW6Sx9YjNZnhGbV7nslC2hCmvPu+M6b+fXshC8mKRMDuj
	 jRZI1PODXpyB5aXC+3hUE3zp4n9zXvQ2f7B+MSaQwB2+BRsuRB207UiLcZ8VFnQNp/iGHqPjkNy6
	 IWI3rgaNg5jORrQAwQrDPCU8Rohc0OsLVZuxGoyQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b71011ec0a23f4d15625@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in l2cap_sock_setsockopt
Date: Fri,  5 Apr 2024 18:20:24 +0800
X-OQ-MSGID: <20240405102023.570352-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000b0848f061553f0d5@google.com>
References: <000000000000b0848f061553f0d5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test oob in rfcomm_sock_setsockopt

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fe46a7dd189e

diff --git a/net/socket.c b/net/socket.c
index e5f3af49a8b6..d5b2ab6c859c 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2327,6 +2327,9 @@ int __sys_setsockopt(int fd, int level, int optname, char __user *user_optval,
 	int err, fput_needed;
 	struct socket *sock;
 
+	if (optlen < 4)
+		return -EINVAL;
+
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
 	if (!sock)
 		return err;


