Return-Path: <linux-kernel+bounces-12333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFC281F38D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958931C22764
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0D5EA9;
	Thu, 28 Dec 2023 01:11:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C809643
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b71b4b179aso369787239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 17:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703725897; x=1704330697;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53BkWtJJBzqQ1P6c/UoMHi1N9c4Y/hvc/0Gyi5+W830=;
        b=rFf7FRZEvxHbM/7vwP7jtpZAo8TbulhDh2V3U5mnh7mvLqWcR/sANdlZjmJ1SFy+jQ
         mi7+e1D649oa77ZUkIWrbTk7onBRQh32fwpqQkxTfNvyo2reSFkXXHW4h4+oJ6V+hRS1
         mN7zHV1Tk61BPm3Xmd0WI+OBTJ/nzvts2l95rybN7FLJlDikUEonkxSebvgWK1dUGcHM
         aC65iA5Cfoo+PiJDu/C201emTS8fvFSfHKGtL9UOrrzBn7cGV5bx9S5B1/f5oTMjsOhK
         hRQuYQ3ka0UPtL48F49hYlNi0ssLnD1ogFD9DmqZ85MCEIpnVOPe8k522WP15rW0CwwQ
         pY6w==
X-Gm-Message-State: AOJu0Yw5IwdgrzwicyLjko29KwIuboKMIH8cvrOgJbmFhrxUgXelRPcG
	eDV8oeP+HeUc/TQyn2XZaRaMe1tTop/ZZpB65rC+hxlaSmyYHGE=
X-Google-Smtp-Source: AGHT+IHKl/Fo8LIBj6PHOZcijC51RaHw+ZGL0Xd0QIyodSBCwejtWzv4gHSxgsZKUOAhC3DRN+W83I3mDjILPKKspJma5d+rE1WV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:90c4:0:b0:46d:5d7e:2c67 with SMTP id
 c4-20020a0290c4000000b0046d5d7e2c67mr209419jag.2.1703725897685; Wed, 27 Dec
 2023 17:11:37 -0800 (PST)
Date: Wed, 27 Dec 2023 17:11:37 -0800
In-Reply-To: <000000000000321c24060d7cfa1c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed2009060d879851@google.com>
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress (2)
From: syzbot <syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress (2)
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fbafc3e621c3

diff --git a/lib/hexdump.c b/lib/hexdump.c
index 06833d404398..68b30bf6c6a3 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -263,12 +263,14 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 		    const void *buf, size_t len, bool ascii)
 {
 	const u8 *ptr = buf;
-	int i, linelen, remaining = len;
+	int i, linelen, remaining;
 	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
 
 	if (rowsize != 16 && rowsize != 32)
 		rowsize = 16;
 
+	len = len > sizeof(linebuf) ? sizeof(linebuf) : len;
+	remaining = len;
 	for (i = 0; i < len; i += rowsize) {
 		linelen = min(remaining, rowsize);
 		remaining -= rowsize;

