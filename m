Return-Path: <linux-kernel+bounces-106640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB57A87F159
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EDCC2847F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72845812E;
	Mon, 18 Mar 2024 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAaOItsc"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8DE58101
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794550; cv=none; b=pTZRkahuzTUsPDAYBf+0hjRMf7/L9Vh0KvUd9wTDiLJr2foX9RcdWoOBaEwpzJRT0oIosLYoQJikoVzThNVQFj8hj/TntvX5hu/bA6K48Yve2O/0tPTX0zzd0caJTKthQJaEbVxR5IrNoKTVJxD0kOBnhcFLoyf2XXG+j5rj8XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794550; c=relaxed/simple;
	bh=0bBvFG2L1I0MqGSSWQyROx+p1tXb04MkJOQiiHHdpmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gvSP/8lM5KP7g7Gqii60OIOy7kt103pFyCp54WEJv0ZrS2m3yPnzPtq3yD7NNbYhdwCuPfD3Nlfeq4UFXffk9WrDnmQe96s5jOUKipB0Zdn8zVtPbAM4o8cTB27UiQrRwto3kTuU5Xe6Unpq8rLwT09GLbO+ClHF2rW/ERkSTBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAaOItsc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dde26f7e1dso33918085ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710794548; x=1711399348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOsqTDQ0hoCpx6NngOtwgMcIYvc2i1Le/r+OHK5eWY4=;
        b=YAaOItscB9IIniZQn8JEcqP9Mwwv3wLfn3laKtsB4LTVU4MmitvY/wnnhMmg2RDzVV
         /zSc7Hwy8HaS75NZEFguJ2NaF1Vcj41rjOkPAE7vsHra6toooiikcVr1ngfDivWBgSDs
         n/wflSU49yNhGHzyLnKN8oJFsi/8SSJzqc+HzFDXwuqlb9a059vdAxMwvjPj7sPTxbh1
         hcI1cRGeG2GmgxOU1znrWI52DoZEU2DEpFvnvf3sgxr65l9WNL0fkG4AXsn9IStEIF6c
         LETdLuYRAeK6ObT3cYmJb0I0ePk5aRVIUOEYCwreooKccXFxkkrF9gQtGRZSrnlby6Q4
         ZzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710794548; x=1711399348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOsqTDQ0hoCpx6NngOtwgMcIYvc2i1Le/r+OHK5eWY4=;
        b=MxuKtbivtc3vP2evG7ZLlavJHfW3G2yrSkDkRULcuufU01GVffQOeWycD1aP0ibHYr
         62tuuT01BTiDiMIqlW8S4e4++FvlKLBZpPx5qhZ9HSm3cxWPTu7lHBOIy3IxUPHg2qZX
         akmgZ79tFARGQNZVbSQSAKefeok57Z+/Zlaef4cFb3CHu/t+YtywO1F48rARPzOk6kiK
         SPd/c6aw1U6Ad4yBJAY/DS+l8DhUF77iW8muAAMv3IqU64UFK6jB6iG36BKUk0thes8l
         XImCCy5geN19QmZ+zNscIUIMb9/FF0uLfeNmxDL+mp4vSZgRaNeqkzciNOfppA+Ng1gg
         7IGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRSsHpfZPTXlk+gLSwTkyjEArALA3GY6haiO4/ylJrhdJInYGiUeH+E6gL+C5CZvWRc7a0IY4mG2cIj5vzx8eI3og/HazGBeEQud2i
X-Gm-Message-State: AOJu0YzGJAjYHLiLEQDrpZBC6z9MHZOoGXPX+R6lcHp6IyT4bS6ojywz
	M+pCNIUU0Sc9CRDmIVeYtsYLYsw/E1ZjTuU5uet6w4CCHsyC2QjN
X-Google-Smtp-Source: AGHT+IFCYHczU0tpIIDzQoQiXOblgmkwVE2mrTbYFR1AS7iQJdFmL+Fi/BVFr3ctCanVQdjkZRIXhA==
X-Received: by 2002:a17:902:ecc9:b0:1e0:3f65:f503 with SMTP id a9-20020a170902ecc900b001e03f65f503mr731769plh.39.1710794548027;
        Mon, 18 Mar 2024 13:42:28 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b001db579a146csm9927711pln.241.2024.03.18.13.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 13:42:27 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
Cc: akpm@linux-foundation.org,
	chengming.zhou@linux.dev,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	syzkaller-bugs@googlegroups.com,
	yosryahmed@google.com
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
Date: Tue, 19 Mar 2024 09:42:12 +1300
Message-Id: <20240318204212.36505-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000bbb3d80613f243a6@google.com>
References: <000000000000bbb3d80613f243a6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-14-09-36' ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13043abe180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=19bb57c23dffc38e
> dashboard link: https://syzkaller.appspot.com/bug?extid=adbc983a1588b7805de3
> compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1706d231180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ba7959180000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-e5eb28f6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0a7371c63ff2/vmlinux-e5eb28f6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7539441b4add/zImage-e5eb28f6.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e5eb28f6d1afebed4bb7d740a797d0390bd3a357

diff --git a/mm/zswap.c b/mm/zswap.c
index 9dec853647c8..47c0386caba2 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1086,7 +1086,8 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 		zpool_unmap_handle(zpool, entry->handle);
 	}
 
-	sg_init_one(&input, src, entry->length);
+	sg_init_table(&input, 1);
+	sg_set_page(&input, kmap_to_page(src), entry->length, offset_in_page(src));
 	sg_init_table(&output, 1);
 	sg_set_page(&output, page, PAGE_SIZE, 0);
 	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);

