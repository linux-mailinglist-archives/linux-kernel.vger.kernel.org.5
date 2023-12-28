Return-Path: <linux-kernel+bounces-12871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4734381FB79
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 23:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F146F1F24501
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 22:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5F810A10;
	Thu, 28 Dec 2023 22:12:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796F610A00
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36007df1516so31860935ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 14:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703801545; x=1704406345;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3YQZhWhujBROv0sS7CdL2R5DgVZfb0HKg8qJgmKT1E=;
        b=KwXvSFKRWtltpgt67zNsLBnmWCGg1xcaX5PSUEsw5EXapqFUZHrmufrHXKA9pupC2w
         SC+A6K3yXs0MyeT9YClCRAjI4clD2k3gYLDdwW3t0oI7nnUoMN0wENCSk88InOiClSkB
         RaZtjmG9iIvztYVSwnwcWDmNtr+6kCDl86S5iAYXD3ZFIjDQcBFsiXC0NOePpTD1J92E
         DmdM0p4wrl3168IfgxiMjg1o1pJde31wUIFeY1K2CVz1qz0HF4JeHocIc7A5dukny57a
         h2QR/u642Y9zdSVVHG8je7u7X7RnjmGuKGB0k35GPZJNIjGepITKIlX6Sk/pcgLcA45t
         5x0A==
X-Gm-Message-State: AOJu0Yxf0PFChDQl868pmRvqyGYHdyWK0s1fgmYTaIp21f8BZp9YOkqM
	7UXcfB+SWI0FIb9lJ7HUED0JrXOHjjVSo4yXHjB1T66PkXBOIiE=
X-Google-Smtp-Source: AGHT+IEmZ+p8UfGnxal9iCf9P+sjKjvWosPhYr2b4O41Jg06zmUaO6mD1puRUTyohFTmfvBoTDZ5XpE3t2JO7nu5RPZx4lpbumDf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d84:b0:35f:db4b:69dd with SMTP id
 h4-20020a056e021d8400b0035fdb4b69ddmr1326862ila.0.1703801545594; Thu, 28 Dec
 2023 14:12:25 -0800 (PST)
Date: Thu, 28 Dec 2023 14:12:25 -0800
In-Reply-To: <000000000000321c24060d7cfa1c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e49f66060d993519@google.com>
Subject: Re: [syzbot] Re: [syzbot] [erofs?] KMSAN: uninit-value in
 z_erofs_lz4_decompress (2)
From: syzbot <syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress (2)
Author: eadavis@qq.com

please test uninit-value in z_erofs_lz4_decompress (2)

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fbafc3e621c3

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 021be5feb1bc..f4cc77e3255f 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -250,7 +250,8 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
 			       16, 1, src + inputmargin, rq->inputsize, true);
 		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
-			       16, 1, out, rq->outputsize, true);
+			       16, 1, out, ret < 0 ? (ret + rq->inputsize) : 
+			       rq->outputsize, true);
 
 		if (ret >= 0)
 			memset(out + ret, 0, rq->outputsize - ret);


