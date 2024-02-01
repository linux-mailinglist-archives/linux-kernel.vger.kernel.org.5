Return-Path: <linux-kernel+bounces-48103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D0E845743
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0632827C2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF1915DBD9;
	Thu,  1 Feb 2024 12:20:19 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98415DBB1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790019; cv=none; b=KksPhV45RVujazDtk4W6zyRVf4ozJjnVXam9sGTRAQbk4cdzpEqqz3ipjCowB055z0NDSGP1Fx7Ksrus8XuDh5bfSi8yb3hUvAlTE83ek48z6ezSzpsZGGGsCzW4osER9fwxzq9ePOugntMX1+0T2NIRCUZ2AMPoSbrXy/mJUoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790019; c=relaxed/simple;
	bh=etr0OO7Vtd/4j+h2vXqZZvY8KV+cF/PxDwFEEIZLJxY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=I7oYBDsKxFzeBm/bKCLBFfOntGEESw0To38RIZoC+f6X2HerJ5N7GgvKJtaD8SxEtxaR1QI9I7SWnjnGIyY3wZr8YC+3DEsL0h7Ydk5HVstngGgnqcI+4VX0Bx5jckMw75wYButPwPKA8Zm4/o//vedUMKYCUQ3WcmN3btBCmCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bfe777fe22so57072239f.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 04:20:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706790016; x=1707394816;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0C+xer7LB8i2CoA7KZV71iY6F56oesDkOncgCzoHlTo=;
        b=WSwMyheJiWSjWO8e2aJgq1mrSX9YBfnOIeG74daJEJQDnoultcTYoLGIEOikMGm4vz
         OZ7Xw2/QjZCZji8Bg2zAmMxE8eyPtvwLifGT3ldNXBqL5Eu1xVMPEde0c/Y0BjlazpmQ
         1NWNSFPt/tp+gQKB5ZL5Kxf45MIefc1FJwI2Vvi5Vx2a6jyXUAFu676unPMbA+vjGK+b
         4p464kL6EjxXEvWVeil5cDMOgQ1iDVcMkW7Vs60vSYEoGopsrwPUE2esAGNBqOy5CUHz
         +yo6IMBbPryfZWCZ8IQuDMWLPE/gZaDsrtUZqogDXHxncISNgunzTAHM2I894juz5xW+
         BLKw==
X-Gm-Message-State: AOJu0YylWZCAQc4GSWoG+c/8r6tT+zh+BoAwkmn//vV2p43CFPoZUWOP
	4s3OIAeAsPCoNdNYYXntcX0/FjSzbFfW5O1xLpbSiPrHtUMNxWLnif5YWtJxhfTa0DwkFuFEIsc
	We4jlEf41ZsvUysBflisqjW+TmOIfPlVSBfqG02e3oZdXN0QIJMC8nJHaqQ==
X-Google-Smtp-Source: AGHT+IHWg52+gMoYyL2L65UUDUqMkRYzjh08pSXBUXD4u7cT2rvp6F0tI6b3DzrGvBdmVzuPp4ecyw6/MDhyeTVO8GPq5OJnUjkd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8b:b0:35f:c723:1f62 with SMTP id
 w11-20020a056e021c8b00b0035fc7231f62mr481318ill.0.1706790016796; Thu, 01 Feb
 2024 04:20:16 -0800 (PST)
Date: Thu, 01 Feb 2024 04:20:16 -0800
In-Reply-To: <000000000000d1668406104ff51e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8534a0610510487@google.com>
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
@@ -250,7 +250,8 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
 			       16, 1, src + inputmargin, rq->inputsize, true);
 		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
-			       16, 1, out, rq->outputsize, true);
+			       16, 1, out, (ret < 0 && rq->inputsize > 0) ? 
+			       (ret + rq->inputsize) : rq->outputsize, true);
 
 		if (ret >= 0)
 			memset(out + ret, 0, rq->outputsize - ret);


