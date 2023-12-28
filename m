Return-Path: <linux-kernel+bounces-12423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F4481F4A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 05:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 391DCB223D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 04:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424F46FA7;
	Thu, 28 Dec 2023 04:57:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3F56FA2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 04:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3602a18e75fso981405ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 20:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703739458; x=1704344258;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DhT64IODvFTvXBcZay6JvH2lfLYI6IxHgQ6sp/5aqPM=;
        b=xNZEZUQMUug/e3xWBRKiPQ1qxBhFjxYacnGXybO3R9djguCXvp8IF6eoGQNxpIt7Gl
         UlH8ywyfp1o57uPQdTe+WU66dRLIaYFsr1Zzy1nLoOuXpgtDRBZL2XNLrhoLRMtDI1Uj
         KWD3FaD83Hzyx5e9S2b1esSqTDE1n91441fk9Ek1dxtyJvbfBYNDtRmtCMJCN7PedBZm
         9hSbUvlvt+3OqwhlHqVUdu4Y2ZgbWLVG61mqd/3tAg80As8+T41j1+uXuSUVUv/jKZK9
         I8B+OupLtssk8lwg1NcZeR2Y/iL6OajlWBLImXT8+VNVhfHXqr1SUQZgbeB2DwiiOGdc
         ha9w==
X-Gm-Message-State: AOJu0YxiKHzBCQFoktExipgW0sizkX9jEKfWRI2iELFg2K70pS53zQ32
	W8AKoQ69Pb/mwMYKHrmhkBnMGTvfibROaJ27sN7sSe7tnePr4pI=
X-Google-Smtp-Source: AGHT+IEpftVYNyqi7JtgJUOpgubfPS7fdPSkoyUxsiqPoFcciucHbYpkRmp9c+mJgKASVyIjjeqc9nRzNK532wsdeIpSaY2UtoY/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1d:b0:35d:61b6:c776 with SMTP id
 i29-20020a056e021d1d00b0035d61b6c776mr1470011ila.0.1703739458764; Wed, 27 Dec
 2023 20:57:38 -0800 (PST)
Date: Wed, 27 Dec 2023 20:57:38 -0800
In-Reply-To: <00000000000091a123060d7c18fb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ad0c2060d8ac1d2@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_cat_case_cmp_key
From: syzbot <syzbot+50d8672fea106e5387bb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [hfs?] KMSAN: uninit-value in hfsplus_cat_case_cmp_key
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fbafc3e621c3


diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index ca2ba8c9f82e..6773f6d2508f 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -23,6 +23,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 		return -ENOMEM;
 	fd->search_key = ptr;
 	fd->key = ptr + tree->max_key_len + 2;
+	fd->key->cat.parent = 0;
 	hfs_dbg(BNODE_REFS, "find_init: %d (%p)\n",
 		tree->cnid, __builtin_return_address(0));
 	switch (tree->cnid) {

