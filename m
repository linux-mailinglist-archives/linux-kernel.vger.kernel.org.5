Return-Path: <linux-kernel+bounces-48996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832AD846477
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3B81C23830
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33024481C6;
	Thu,  1 Feb 2024 23:30:58 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466EC481BE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706830257; cv=none; b=W72PeU4XCwjHm42RD67AklzHTSpFLXNL+6K9i28+B7PFTe7j/D9h5TT5MK5EnJqz5DPwYP4GmtkjCz7R9Fi+NCEVv7O243keOktjMPnnyAWsyMhg0ymU1dNaQfa0Q2bhX8g0LeiA4r1AkZa9cHzSIFaI382kg/Lk4RYoV3dw4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706830257; c=relaxed/simple;
	bh=8INpvQI01LIkViTNlfS4VCM/BynvzCHgJbdsjskF9xA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UAk7IwIun3IKIlmqUmjKDBwn7HaBifOYYj0CnGeyW5naKdYaVWvhZNM87iy0w6eXAxxyS915XXeETuz+boO9XgUvxv9JiaYONDZZys2+lRtIKyXaQDXrj/1lOB7/UiCR2TY7I4mQNI5VHHmXxEzhZTD03o40JNxQY45uoZ873/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363b281a3b9so396585ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 15:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706830255; x=1707435055;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQnJPHhUP2fBHB6E+cKfrGCV/cxpTXH4z30wnqadnLA=;
        b=B9lNGzuJyQm1K5EBofdPQMfMceJafLT7mqMuE2DjQcF/4NC7bdXvcVIfefh4J9MU1d
         TXcs+R4Q3slm/EMbezPZJ1PJkmOKXl7q1lgWuQx0TrJzeLvMf6qKel6wRifwMGIKpUOB
         EFXy0GLA/O7bzhjvmsG8iw/ek1yLmhjA+41TLwlUyEmIBZIjp4XsKL3GUljG725Xnuh5
         vZRoYFObOX8LKnaHqD4b4iCOhxKETPPtlzDTiP9jWCYD6MnGn/Yr49qauRjE8qmLbAyO
         jaVS29wVBjycaAUVAo6crb1eNuowatR/toGnMoXWuM9mVIUtF+nGjPsG1ci9WLDRgir4
         bmcA==
X-Gm-Message-State: AOJu0YzqrkE9jmYTTLEuhJomI4VBbju/PbxQQYDGCCKib/H3kJyYXHnL
	VrJdlhZTvhwdWbUcJ5yyXPyH/VjolZskn/O41oY1nujnnH/MUW3w+Sl124DmH83yDj5xooPjnXr
	PPyPIGKdP6Ey8FLkWccE+shTR2rT01whxsSuGPHLqtnzpQm1tcDe7REDYQQ==
X-Google-Smtp-Source: AGHT+IEUJVYniRkMK5306d1sFsBxoYihMDRdfzIbG9tjVAH/EYQD95UaNrChwF4l61aSs/f7w232WYZ3vK9cggAAHJWu0GOMU72P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aad:b0:363:8be6:2b22 with SMTP id
 l13-20020a056e021aad00b003638be62b22mr497761ilv.1.1706830255476; Thu, 01 Feb
 2024 15:30:55 -0800 (PST)
Date: Thu, 01 Feb 2024 15:30:55 -0800
In-Reply-To: <000000000000d1668406104ff51e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011dad906105a63dc@google.com>
Subject: Re: [syzbot] Re: [syzbot] [erofs?] KMSAN: uninit-value in
 z_erofs_lz4_decompress (3)
From: syzbot <syzbot+88ad8b0517a9d3bb9dc8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress (3)
Author: eadavis@qq.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 021be5feb1bc..8ac3f96676c4 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -252,7 +252,8 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
 			       16, 1, src + inputmargin, rq->inputsize, true);
 		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
-			       16, 1, out, rq->outputsize, true);
+			       16, 1, out, (ret < 0 && rq->inputsize > 0) ? 
+			       (ret + rq->inputsize) : rq->outputsize, true);
 
 		if (ret >= 0)
 			memset(out + ret, 0, rq->outputsize - ret);


