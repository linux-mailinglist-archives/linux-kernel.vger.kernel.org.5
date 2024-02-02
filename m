Return-Path: <linux-kernel+bounces-50457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C20CF84792C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CEE1C2868F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF15134CEA;
	Fri,  2 Feb 2024 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kswTC9PP"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7D3134CD8;
	Fri,  2 Feb 2024 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900385; cv=none; b=MsVvCNhiPcfgHSSOCfTyShyo/aFdW+lxVwgdt/1S3EGtXi/musHKglLQ8xUbibcfBya0n3nxAXEIq8GzltcaZ58i9/6byDUFtNLPDjWZzFJl3vOmMRK5zGo9fEZLk7ZGDtBZzDVAHKpwWeiWoNc5KtmWPiMi06EjepIVOAYGMSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900385; c=relaxed/simple;
	bh=HisE2RH3eV190/SfpAV4pdX199xVRgezozVZ4AC2xmU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ajdfkIV5Vrm7Pw3f47Mp1Wa/DtG3GgwYgpwONHdAFZS/aIGOH8f4n1H9qjNDZTCqKLVlHKH6aG5RtK8rLLY6CWxcJQidDUsXvLU0Oy2lQleTgpYoFG4h/OGUckdIAn+VprRAaVp5UyxrSfbn3G2P2uTYgBwkA7zD07HTvu3KKQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kswTC9PP; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-295ef56bdfeso2356389a91.1;
        Fri, 02 Feb 2024 10:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706900383; x=1707505183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2yimvhpmcH1I5gEDzfqI+I0n41BXD3MB9C5UvNS/xCg=;
        b=kswTC9PPsafH9pGfNUNDf6FwF5oz19QBdXPDV0iOI17OGYjWbqdZAONXgORFSYNcAs
         KTOEiacNogki6OJUtgC2s0b9DbfpRxbHkK7A5WNfeW94l9kJWGPFzzPi2W8TDHwEwvZv
         LZ8aRihkk0q6FPBQpiB6b3eghgY9MNo+Qd6gFafTPYTFXWRmGcVAf467MDOD2jnUW1hg
         ZmKuG1WdSqkJin2z9q6i0rHTKDLUJklvT6SO8PgmY6vk4f9Myk91+I3C3lx/iHmns5Gt
         SzgKs46DUVRpzsDbbf5lWiLMIImrAnPKK6I38CpnLAut1xMKip3jSDL+RxkrOBTVtrhN
         JKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706900383; x=1707505183;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2yimvhpmcH1I5gEDzfqI+I0n41BXD3MB9C5UvNS/xCg=;
        b=xCXijlOaGiWdBV/Li7I7zSQODL81yRbDBUb2S71b/rlly+C+BaRkV91tUCNhBMoVO6
         4hq+Talu0NuxuxqNb37qehcchigJiMknd22JgvTaZuXSCzHR/I4BuoXIDKDubo6ixvo5
         B2/9aool7YCOELTW11kkXlIyb0TJq6D2yEW/w0HFDKkIKwlQknQx9/k3qFM4N05lOwJU
         caFDF6QFBrc5mxscvlDAx0IpM1hSdas2PT7KrF/M2VX287Cu+ThZefMJ92WpM3rorlmt
         jIrvgfII1mN3rYDcyMpSHCDEIglHPaWwOuuC/9K9BtTTgiWDrXuNBHXradMTTKeSJQ6F
         bmXg==
X-Gm-Message-State: AOJu0YyJ7nINprOBX18V28uXi0sF9EAO2t7tIR3g7X6vNEBliMW0xjT7
	/MUsFy0xlytKu7QtssTtAkA7i75jO8YPlKNA0LCp52aUudtClKeRTV5agFlEQ9pwz0cUYr9MLXT
	YOgBQWbVXmFonfExcTkToTs9QLg==
X-Google-Smtp-Source: AGHT+IEexo0m7nRHY3fD6KVXQSR3165NjdJQSvnuLFl8WOAV680fDBl+Yy+XRoIrVnIX38rPjIcG3ENmRFRKQSN+n/g=
X-Received: by 2002:a17:90a:d704:b0:296:4795:19f with SMTP id
 y4-20020a17090ad70400b002964795019fmr2690862pju.16.1706900382648; Fri, 02 Feb
 2024 10:59:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Fri, 2 Feb 2024 12:59:31 -0600
Message-ID: <CALGdzurBnMztPW1Q8mujfYaopVQ8MkSUXUvnAqJcLGu5ROSU4Q@mail.gmail.com>
Subject: [Linux Kernel Bug][usb/f_printer] WARNING in usb_ep_queue
To: gregkh@linuxfoundation.org, azeemshaikh38@gmail.com, 
	ivan.orlov0322@gmail.com, benjamin.tissoires@redhat.com, 
	linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	Zijie Zhao <zzjas98@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000f9a18406106ab6b9"

--000000000000f9a18406106ab6b9
Content-Type: text/plain; charset="UTF-8"

Dear Linux Developers for F_printer,

We encountered "WARNING in usb_ep_queue" when testing the f_printer driver with
Syzkaller and our generated specifications.

I attached the report and C/syz reproducers for this crash.

```
------------[ cut here ]------------
WARNING: CPU: 1 PID: 10395 at drivers/usb/gadget/udc/core.c:295
usb_ep_queue+0xa0/0x300 linux/drivers/usb/gadget/udc/core.c:295
Modules linked in:
CPU: 1 PID: 10395 Comm: syz-executor364 Not tainted 6.6.0-gd2f51b3516da #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:usb_ep_queue+0xa0/0x300 linux/drivers/usb/gadget/udc/core.c:295
Code: 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 31 02 00 00 0f b6
5d 35 31 ff 89 de e8 da 51 08 fa 84 db 74 11 e8 01 56 08 fa 90 <0f> 0b
90 41 bd 94 ff ff ff eb 56 e8 f0 55 08 fa 48 8d 7d 10 48 b8
RSP: 0018:ffffc900075cfc00 EFLAGS: 00010093
RAX: 0000000000000000 RBX: 0000000000000081 RCX: ffffffff8786e5a6
RDX: ffff88801cd59e00 RSI: ffffffff8786e5af RDI: 0000000000000001
RBP: ffff8880173d80e0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000081 R11: 0000000000000000 R12: ffff888019236e10
R13: 0000000000000820 R14: 0000000000000000 R15: ffff888019236e58
FS:  000055555591d3c0(0000) GS:ffff88807ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020c55000 CR3: 0000000024d03000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 printer_write+0x650/0xf30 linux/drivers/usb/gadget/function/f_printer.c:669
 vfs_write+0x2ae/0xd80 linux/fs/read_write.c:582
 ksys_write+0x127/0x250 linux/fs/read_write.c:637
 do_syscall_x64 linux/arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 linux/arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f1c4a60e3bd
Code: c3 e8 87 20 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd3d68a858 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f1c4a60e3bd
RDX: 000000000000004f RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007f1c4a663cd5 R09: 00007f1c4a663cd5
R10: 00237265746e6972 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd3d68aab8 R14: 00007ffd3d68a880 R15: 00007ffd3d68a870
 </TASK>
```

It seems that the `WARN_ON_ONCE(!ep->enabled && ep->address)` in
usb_ep_queue (https://elixir.bootlin.com/linux/v6.7/source/drivers/usb/gadget/udc/core.c#L290),
which is invoked by `printer_write`
(https://elixir.bootlin.com/linux/v6.7/source/drivers/usb/gadget/function/f_printer.c#L669).

If you have any questions or require more information, please feel
free to contact us.

Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>

Best,
Chenyuan

--000000000000f9a18406106ab6b9
Content-Type: application/octet-stream; name="repro.prog"
Content-Disposition: attachment; filename="repro.prog"
Content-Transfer-Encoding: base64
Content-ID: <f_ls50ebad1>
X-Attachment-Id: f_ls50ebad1

IyB7VGhyZWFkZWQ6ZmFsc2UgUmVwZWF0OnRydWUgUmVwZWF0VGltZXM6MCBQcm9jczo4IFNsb3dk
b3duOjEgU2FuZGJveDogU2FuZGJveEFyZzowIExlYWs6ZmFsc2UgTmV0SW5qZWN0aW9uOmZhbHNl
IE5ldERldmljZXM6ZmFsc2UgTmV0UmVzZXQ6ZmFsc2UgQ2dyb3VwczpmYWxzZSBCaW5mbXRNaXNj
OmZhbHNlIENsb3NlRkRzOmZhbHNlIEtDU0FOOmZhbHNlIERldmxpbmtQQ0k6ZmFsc2UgTmljVkY6
ZmFsc2UgVVNCOmZhbHNlIFZoY2lJbmplY3Rpb246ZmFsc2UgV2lmaTpmYWxzZSBJRUVFODAyMTU0
OmZhbHNlIFN5c2N0bDpmYWxzZSBTd2FwOmZhbHNlIFVzZVRtcERpcjpmYWxzZSBIYW5kbGVTZWd2
OmZhbHNlIFJlcHJvOmZhbHNlIFRyYWNlOmZhbHNlIExlZ2FjeU9wdGlvbnM6e0NvbGxpZGU6ZmFs
c2UgRmF1bHQ6ZmFsc2UgRmF1bHRDYWxsOjAgRmF1bHROdGg6MH19CnIwID0gc3l6X29wZW5fZGV2
JEtHUFRfZ19wcmludGVyKCYoMHg3ZjAwMDAwMDAwODApLCAweDAsIDB4ODAwNDEpCndyaXRlKHIw
LCAmKDB4N2YwMDAwMDAwMDAwKT0iYzIiLCAweGZmZmZmZGVmKQp3cml0ZSRiaW5mbXRfc2NyaXB0
KHIwLCAmKDB4N2YwMDAwMDAwMGMwKT17JyMhICcsICcuL2ZpbGUwJywgW3sweDIwLCAnL2Rldi9n
X3ByaW50ZXIjXHgwMCd9LCB7MHgyMCwgJy9kZXYvZ19wcmludGVyI1x4MDAnfSwgezB4MjAsICcv
ZGV2L2dfcHJpbnRlciNceDAwJ30sIHsweDIwLCAnL2Rldi9nX3ByaW50ZXIjXHgwMCd9XX0sIDB4
NGYpCnIxID0gc3l6X29wZW5fZGV2JHVzYmZzKCYoMHg3ZjAwMDAwMDAwNDApLCAweDQwMCwgMHgy
KQppb2N0bCRVU0JERVZGU19SRVNFVChyMSwgMHg1NTE0KQo=
--000000000000f9a18406106ab6b9
Content-Type: application/octet-stream; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64
Content-ID: <f_ls50eba20>
X-Attachment-Id: f_ls50eba20

Ly8gYXV0b2dlbmVyYXRlZCBieSBzeXprYWxsZXIgKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUv
c3l6a2FsbGVyKQoKI2RlZmluZSBfR05VX1NPVVJDRSAKCiNpbmNsdWRlIDxkaXJlbnQuaD4KI2lu
Y2x1ZGUgPGVuZGlhbi5oPgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNp
bmNsdWRlIDxzaWduYWwuaD4KI2luY2x1ZGUgPHN0ZGFyZy5oPgojaW5jbHVkZSA8c3RkYm9vbC5o
PgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGli
Lmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN5cy9wcmN0bC5oPgojaW5jbHVkZSA8
c3lzL3N0YXQuaD4KI2luY2x1ZGUgPHN5cy9zeXNjYWxsLmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMu
aD4KI2luY2x1ZGUgPHN5cy93YWl0Lmg+CiNpbmNsdWRlIDx0aW1lLmg+CiNpbmNsdWRlIDx1bmlz
dGQuaD4KCnN0YXRpYyB1bnNpZ25lZCBsb25nIGxvbmcgcHJvY2lkOwoKc3RhdGljIHZvaWQgc2xl
ZXBfbXModWludDY0X3QgbXMpCnsKCXVzbGVlcChtcyAqIDEwMDApOwp9CgpzdGF0aWMgdWludDY0
X3QgY3VycmVudF90aW1lX21zKHZvaWQpCnsKCXN0cnVjdCB0aW1lc3BlYyB0czsKCWlmIChjbG9j
a19nZXR0aW1lKENMT0NLX01PTk9UT05JQywgJnRzKSkKCWV4aXQoMSk7CglyZXR1cm4gKHVpbnQ2
NF90KXRzLnR2X3NlYyAqIDEwMDAgKyAodWludDY0X3QpdHMudHZfbnNlYyAvIDEwMDAwMDA7Cn0K
CnN0YXRpYyBib29sIHdyaXRlX2ZpbGUoY29uc3QgY2hhciogZmlsZSwgY29uc3QgY2hhciogd2hh
dCwgLi4uKQp7CgljaGFyIGJ1ZlsxMDI0XTsKCXZhX2xpc3QgYXJnczsKCXZhX3N0YXJ0KGFyZ3Ms
IHdoYXQpOwoJdnNucHJpbnRmKGJ1Ziwgc2l6ZW9mKGJ1ZiksIHdoYXQsIGFyZ3MpOwoJdmFfZW5k
KGFyZ3MpOwoJYnVmW3NpemVvZihidWYpIC0gMV0gPSAwOwoJaW50IGxlbiA9IHN0cmxlbihidWYp
OwoJaW50IGZkID0gb3BlbihmaWxlLCBPX1dST05MWSB8IE9fQ0xPRVhFQyk7CglpZiAoZmQgPT0g
LTEpCgkJcmV0dXJuIGZhbHNlOwoJaWYgKHdyaXRlKGZkLCBidWYsIGxlbikgIT0gbGVuKSB7CgkJ
aW50IGVyciA9IGVycm5vOwoJCWNsb3NlKGZkKTsKCQllcnJubyA9IGVycjsKCQlyZXR1cm4gZmFs
c2U7Cgl9CgljbG9zZShmZCk7CglyZXR1cm4gdHJ1ZTsKfQoKc3RhdGljIGxvbmcgc3l6X29wZW5f
ZGV2KHZvbGF0aWxlIGxvbmcgYTAsIHZvbGF0aWxlIGxvbmcgYTEsIHZvbGF0aWxlIGxvbmcgYTIp
CnsKCWlmIChhMCA9PSAweGMgfHwgYTAgPT0gMHhiKSB7CgkJY2hhciBidWZbMTI4XTsKCQlzcHJp
bnRmKGJ1ZiwgIi9kZXYvJXMvJWQ6JWQiLCBhMCA9PSAweGMgPyAiY2hhciIgOiAiYmxvY2siLCAo
dWludDhfdClhMSwgKHVpbnQ4X3QpYTIpOwoJCXJldHVybiBvcGVuKGJ1ZiwgT19SRFdSLCAwKTsK
CX0gZWxzZSB7CgkJY2hhciBidWZbMTAyNF07CgkJY2hhciogaGFzaDsKCQlzdHJuY3B5KGJ1Ziwg
KGNoYXIqKWEwLCBzaXplb2YoYnVmKSAtIDEpOwoJCWJ1ZltzaXplb2YoYnVmKSAtIDFdID0gMDsK
CQl3aGlsZSAoKGhhc2ggPSBzdHJjaHIoYnVmLCAnIycpKSkgewoJCQkqaGFzaCA9ICcwJyArIChj
aGFyKShhMSAlIDEwKTsKCQkJYTEgLz0gMTA7CgkJfQoJCXJldHVybiBvcGVuKGJ1ZiwgYTIsIDAp
OwoJfQp9CgpzdGF0aWMgdm9pZCBraWxsX2FuZF93YWl0KGludCBwaWQsIGludCogc3RhdHVzKQp7
CglraWxsKC1waWQsIFNJR0tJTEwpOwoJa2lsbChwaWQsIFNJR0tJTEwpOwoJZm9yIChpbnQgaSA9
IDA7IGkgPCAxMDA7IGkrKykgewoJCWlmICh3YWl0cGlkKC0xLCBzdGF0dXMsIFdOT0hBTkcgfCBf
X1dBTEwpID09IHBpZCkKCQkJcmV0dXJuOwoJCXVzbGVlcCgxMDAwKTsKCX0KCURJUiogZGlyID0g
b3BlbmRpcigiL3N5cy9mcy9mdXNlL2Nvbm5lY3Rpb25zIik7CglpZiAoZGlyKSB7CgkJZm9yICg7
OykgewoJCQlzdHJ1Y3QgZGlyZW50KiBlbnQgPSByZWFkZGlyKGRpcik7CgkJCWlmICghZW50KQoJ
CQkJYnJlYWs7CgkJCWlmIChzdHJjbXAoZW50LT5kX25hbWUsICIuIikgPT0gMCB8fCBzdHJjbXAo
ZW50LT5kX25hbWUsICIuLiIpID09IDApCgkJCQljb250aW51ZTsKCQkJY2hhciBhYm9ydFszMDBd
OwoJCQlzbnByaW50ZihhYm9ydCwgc2l6ZW9mKGFib3J0KSwgIi9zeXMvZnMvZnVzZS9jb25uZWN0
aW9ucy8lcy9hYm9ydCIsIGVudC0+ZF9uYW1lKTsKCQkJaW50IGZkID0gb3BlbihhYm9ydCwgT19X
Uk9OTFkpOwoJCQlpZiAoZmQgPT0gLTEpIHsKCQkJCWNvbnRpbnVlOwoJCQl9CgkJCWlmICh3cml0
ZShmZCwgYWJvcnQsIDEpIDwgMCkgewoJCQl9CgkJCWNsb3NlKGZkKTsKCQl9CgkJY2xvc2VkaXIo
ZGlyKTsKCX0gZWxzZSB7Cgl9Cgl3aGlsZSAod2FpdHBpZCgtMSwgc3RhdHVzLCBfX1dBTEwpICE9
IHBpZCkgewoJfQp9CgpzdGF0aWMgdm9pZCBzZXR1cF90ZXN0KCkKewoJcHJjdGwoUFJfU0VUX1BE
RUFUSFNJRywgU0lHS0lMTCwgMCwgMCwgMCk7CglzZXRwZ3JwKCk7Cgl3cml0ZV9maWxlKCIvcHJv
Yy9zZWxmL29vbV9zY29yZV9hZGoiLCAiMTAwMCIpOwp9CgpzdGF0aWMgdm9pZCBleGVjdXRlX29u
ZSh2b2lkKTsKCiNkZWZpbmUgV0FJVF9GTEFHUyBfX1dBTEwKCnN0YXRpYyB2b2lkIGxvb3Aodm9p
ZCkKewoJaW50IGl0ZXIgPSAwOwoJZm9yICg7OyBpdGVyKyspIHsKCQlpbnQgcGlkID0gZm9yaygp
OwoJCWlmIChwaWQgPCAwKQoJZXhpdCgxKTsKCQlpZiAocGlkID09IDApIHsKCQkJc2V0dXBfdGVz
dCgpOwoJCQlleGVjdXRlX29uZSgpOwoJCQlleGl0KDApOwoJCX0KCQlpbnQgc3RhdHVzID0gMDsK
CQl1aW50NjRfdCBzdGFydCA9IGN1cnJlbnRfdGltZV9tcygpOwoJCWZvciAoOzspIHsKCQkJaWYg
KHdhaXRwaWQoLTEsICZzdGF0dXMsIFdOT0hBTkcgfCBXQUlUX0ZMQUdTKSA9PSBwaWQpCgkJCQli
cmVhazsKCQkJc2xlZXBfbXMoMSk7CgkJCWlmIChjdXJyZW50X3RpbWVfbXMoKSAtIHN0YXJ0IDwg
NTAwMCkKCQkJCWNvbnRpbnVlOwoJCQlraWxsX2FuZF93YWl0KHBpZCwgJnN0YXR1cyk7CgkJCWJy
ZWFrOwoJCX0KCX0KfQoKdWludDY0X3QgclsyXSA9IHsweGZmZmZmZmZmZmZmZmZmZmYsIDB4ZmZm
ZmZmZmZmZmZmZmZmZn07Cgp2b2lkIGV4ZWN1dGVfb25lKHZvaWQpCnsKCQlpbnRwdHJfdCByZXMg
PSAwOwptZW1jcHkoKHZvaWQqKTB4MjAwMDAwODAsICIvZGV2L2dfcHJpbnRlciNcMDAwIiwgMTYp
OwoJcmVzID0gLTE7CnJlcyA9IHN5el9vcGVuX2RldigvKmRldj0qLzB4MjAwMDAwODAsIC8qaWQ9
Ki8wICsgcHJvY2lkKjEsIC8qZmxhZ3M9Ki8weDgwMDQxKTsKCWlmIChyZXMgIT0gLTEpCgkJclsw
XSA9IHJlczsKbWVtc2V0KCh2b2lkKikweDIwMDAwMDAwLCAxOTQsIDEpOwoJc3lzY2FsbChfX05S
X3dyaXRlLCAvKmZkPSovclswXSwgLypidWY9Ki8weDIwMDAwMDAwdWwsIC8qY291bnQ9Ki8weGZm
ZmZmZGVmdWwpOwptZW1jcHkoKHZvaWQqKTB4MjAwMDAwYzAsICIjISAiLCAzKTsKbWVtY3B5KCh2
b2lkKikweDIwMDAwMGMzLCAiLi9maWxlMCIsIDcpOwoqKHVpbnQ4X3QqKTB4MjAwMDAwY2EgPSAw
eDIwOwptZW1jcHkoKHZvaWQqKTB4MjAwMDAwY2IsICIvZGV2L2dfcHJpbnRlciNcMDAwIiwgMTYp
OwoqKHVpbnQ4X3QqKTB4MjAwMDAwZGIgPSAweDIwOwptZW1jcHkoKHZvaWQqKTB4MjAwMDAwZGMs
ICIvZGV2L2dfcHJpbnRlciNcMDAwIiwgMTYpOwoqKHVpbnQ4X3QqKTB4MjAwMDAwZWMgPSAweDIw
OwptZW1jcHkoKHZvaWQqKTB4MjAwMDAwZWQsICIvZGV2L2dfcHJpbnRlciNcMDAwIiwgMTYpOwoq
KHVpbnQ4X3QqKTB4MjAwMDAwZmQgPSAweDIwOwptZW1jcHkoKHZvaWQqKTB4MjAwMDAwZmUsICIv
ZGV2L2dfcHJpbnRlciNcMDAwIiwgMTYpOwoqKHVpbnQ4X3QqKTB4MjAwMDAxMGUgPSAweGE7Cglz
eXNjYWxsKF9fTlJfd3JpdGUsIC8qZmQ9Ki9yWzBdLCAvKmRhdGE9Ki8weDIwMDAwMGMwdWwsIC8q
bGVuPSovMHg0ZnVsKTsKbWVtY3B5KCh2b2lkKikweDIwMDAwMDQwLCAiL2Rldi9idXMvdXNiLzAw
Iy8wMCNcMDAwIiwgMjEpOwoJcmVzID0gLTE7CnJlcyA9IHN5el9vcGVuX2RldigvKmRldj0qLzB4
MjAwMDAwNDAsIC8qaWQ9Ki8weDQwMCwgLypmbGFncz0qLzIpOwoJaWYgKHJlcyAhPSAtMSkKCQly
WzFdID0gcmVzOwoJc3lzY2FsbChfX05SX2lvY3RsLCAvKmZkPSovclsxXSwgLypjbWQ9Ki8weDU1
MTQsIDApOwoKfQppbnQgbWFpbih2b2lkKQp7CgkJc3lzY2FsbChfX05SX21tYXAsIC8qYWRkcj0q
LzB4MWZmZmYwMDB1bCwgLypsZW49Ki8weDEwMDB1bCwgLypwcm90PSovMHVsLCAvKmZsYWdzPSov
MHgzMnVsLCAvKmZkPSovLTEsIC8qb2Zmc2V0PSovMHVsKTsKCXN5c2NhbGwoX19OUl9tbWFwLCAv
KmFkZHI9Ki8weDIwMDAwMDAwdWwsIC8qbGVuPSovMHgxMDAwMDAwdWwsIC8qcHJvdD0qLzd1bCwg
LypmbGFncz0qLzB4MzJ1bCwgLypmZD0qLy0xLCAvKm9mZnNldD0qLzB1bCk7CglzeXNjYWxsKF9f
TlJfbW1hcCwgLyphZGRyPSovMHgyMTAwMDAwMHVsLCAvKmxlbj0qLzB4MTAwMHVsLCAvKnByb3Q9
Ki8wdWwsIC8qZmxhZ3M9Ki8weDMydWwsIC8qZmQ9Ki8tMSwgLypvZmZzZXQ9Ki8wdWwpOwoJZm9y
IChwcm9jaWQgPSAwOyBwcm9jaWQgPCA4OyBwcm9jaWQrKykgewoJCWlmIChmb3JrKCkgPT0gMCkg
ewoJCQlsb29wKCk7CgkJfQoJfQoJc2xlZXAoMTAwMDAwMCk7CglyZXR1cm4gMDsKfQo=
--000000000000f9a18406106ab6b9
Content-Type: application/octet-stream; name="repro.report"
Content-Disposition: attachment; filename="repro.report"
Content-Transfer-Encoding: base64
Content-ID: <f_ls50ebai2>
X-Attachment-Id: f_ls50ebai2

LS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tCldBUk5JTkc6IENQVTogMSBQSUQ6
IDEwMzk1IGF0IGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvY29yZS5jOjI5NSB1c2JfZXBfcXVldWUr
MHhhMC8weDMwMCBsaW51eC9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2NvcmUuYzoyOTUKTW9kdWxl
cyBsaW5rZWQgaW46CkNQVTogMSBQSUQ6IDEwMzk1IENvbW06IHN5ei1leGVjdXRvcjM2NCBOb3Qg
dGFpbnRlZCA2LjYuMC1nZDJmNTFiMzUxNmRhICMxCkhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRh
cmQgUEMgKGk0NDBGWCArIFBJSVgsIDE5OTYpLCBCSU9TIDEuMTUuMC0xIDA0LzAxLzIwMTQKUklQ
OiAwMDEwOnVzYl9lcF9xdWV1ZSsweGEwLzB4MzAwIGxpbnV4L2RyaXZlcnMvdXNiL2dhZGdldC91
ZGMvY29yZS5jOjI5NQpDb2RlOiAwMiA0OCA4OSBmYSA4MyBlMiAwNyAzOCBkMCA3ZiAwOCA4NCBj
MCAwZiA4NSAzMSAwMiAwMCAwMCAwZiBiNiA1ZCAzNSAzMSBmZiA4OSBkZSBlOCBkYSA1MSAwOCBm
YSA4NCBkYiA3NCAxMSBlOCAwMSA1NiAwOCBmYSA5MCA8MGY+IDBiIDkwIDQxIGJkIDk0IGZmIGZm
IGZmIGViIDU2IGU4IGYwIDU1IDA4IGZhIDQ4IDhkIDdkIDEwIDQ4IGI4ClJTUDogMDAxODpmZmZm
YzkwMDA3NWNmYzAwIEVGTEFHUzogMDAwMTAwOTMKUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDog
MDAwMDAwMDAwMDAwMDA4MSBSQ1g6IGZmZmZmZmZmODc4NmU1YTYKUkRYOiBmZmZmODg4MDFjZDU5
ZTAwIFJTSTogZmZmZmZmZmY4Nzg2ZTVhZiBSREk6IDAwMDAwMDAwMDAwMDAwMDEKUkJQOiBmZmZm
ODg4MDE3M2Q4MGUwIFIwODogMDAwMDAwMDAwMDAwMDAwMSBSMDk6IDAwMDAwMDAwMDAwMDAwMDAK
UjEwOiAwMDAwMDAwMDAwMDAwMDgxIFIxMTogMDAwMDAwMDAwMDAwMDAwMCBSMTI6IGZmZmY4ODgw
MTkyMzZlMTAKUjEzOiAwMDAwMDAwMDAwMDAwODIwIFIxNDogMDAwMDAwMDAwMDAwMDAwMCBSMTU6
IGZmZmY4ODgwMTkyMzZlNTgKRlM6ICAwMDAwNTU1NTU1OTFkM2MwKDAwMDApIEdTOmZmZmY4ODgw
N2VjMDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMApDUzogIDAwMTAgRFM6IDAwMDAg
RVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCkNSMjogMDAwMDAwMDAyMGM1NTAwMCBDUjM6
IDAwMDAwMDAwMjRkMDMwMDAgQ1I0OiAwMDAwMDAwMDAwMzUwZWYwCkNhbGwgVHJhY2U6CiA8VEFT
Sz4KIHByaW50ZXJfd3JpdGUrMHg2NTAvMHhmMzAgbGludXgvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1
bmN0aW9uL2ZfcHJpbnRlci5jOjY2OQogdmZzX3dyaXRlKzB4MmFlLzB4ZDgwIGxpbnV4L2ZzL3Jl
YWRfd3JpdGUuYzo1ODIKIGtzeXNfd3JpdGUrMHgxMjcvMHgyNTAgbGludXgvZnMvcmVhZF93cml0
ZS5jOjYzNwogZG9fc3lzY2FsbF94NjQgbGludXgvYXJjaC94ODYvZW50cnkvY29tbW9uLmM6NTEg
W2lubGluZV0KIGRvX3N5c2NhbGxfNjQrMHg0MC8weDExMCBsaW51eC9hcmNoL3g4Ni9lbnRyeS9j
b21tb24uYzo4MgogZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NjMvMHg2YgpSSVA6
IDAwMzM6MHg3ZjFjNGE2MGUzYmQKQ29kZTogYzMgZTggODcgMjAgMDAgMDAgMGYgMWYgODAgMDAg
MDAgMDAgMDAgZjMgMGYgMWUgZmEgNDggODkgZjggNDggODkgZjcgNDggODkgZDYgNDggODkgY2Eg
NGQgODkgYzIgNGQgODkgYzggNGMgOGIgNGMgMjQgMDggMGYgMDUgPDQ4PiAzZCAwMSBmMCBmZiBm
ZiA3MyAwMSBjMyA0OCBjNyBjMSBiOCBmZiBmZiBmZiBmNyBkOCA2NCA4OSAwMSA0OApSU1A6IDAw
MmI6MDAwMDdmZmQzZDY4YTg1OCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAwMDAwMDAwMDAw
MDAwMDAxClJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDAwMDAwMDAwZjQyNDAgUkNYOiAw
MDAwN2YxYzRhNjBlM2JkClJEWDogMDAwMDAwMDAwMDAwMDA0ZiBSU0k6IDAwMDAwMDAwMjAwMDAw
YzAgUkRJOiAwMDAwMDAwMDAwMDAwMDAzClJCUDogMDAwMDAwMDAwMDAwMDAwMCBSMDg6IDAwMDA3
ZjFjNGE2NjNjZDUgUjA5OiAwMDAwN2YxYzRhNjYzY2Q1ClIxMDogMDAyMzcyNjU3NDZlNjk3MiBS
MTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAwMDAwMDAwMDAwMDAxClIxMzogMDAwMDdmZmQz
ZDY4YWFiOCBSMTQ6IDAwMDA3ZmZkM2Q2OGE4ODAgUjE1OiAwMDAwN2ZmZDNkNjhhODcwCiA8L1RB
U0s+Cg==
--000000000000f9a18406106ab6b9--

