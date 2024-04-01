Return-Path: <linux-kernel+bounces-126521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65988893907
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2B62B20E70
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA97613C;
	Mon,  1 Apr 2024 08:36:21 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D2A1113
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711960580; cv=none; b=hcww1R53zXn4y1xQKmiFj8HK1eJ4ut9zxDM6C3W2kujyLH8EhtbBuNqRo7YACuXu/w3Dz3pa8bpBee+MlnzraPHgpn2Mqr0fNSLbBOGEGeIcx9e88Uol/YGc45bXmm4etP1U5PMy+5hDckN7KUr4J0Q7A0uwO+962/C66EwMa6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711960580; c=relaxed/simple;
	bh=atTYbdmCAY25zl1jksRR2HFkj9lyqDiWX5HEGlQUorQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h7KfsM4JQRwlZuC61Sq+tGPIYcW3hdD1elYWK98eTCpKAlNGrnUQOOzIV9e6DbHS3FvJvP+zRVJCYgFjSVTzEAJBGbnVaioD5K67ufRemLn3U7m0GkzuIBrjLevDcI2ccKNzHWnD6SEP1GnqLtAlaZrOwVj3W1IvdtHkZhld0fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d0330ce3d4so442415439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 01:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711960578; x=1712565378;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIhjoeOynb3lRObJxaxadEdrd7xsN4WBzbWXXiEPgdA=;
        b=UZyhlAhWue7yC9i1hx2CKp9hAjCLJemhxs8q0bFZYnhgX2KytEjwv3UyNiwJ3pMi/k
         6cxfco8umgfKAO+9WGYeMBvrrB2JPi+uJIPMqT5SYgbVPPNehJp+9TMSiZF5JH6vCIce
         J62kMi3PJEICC8jf6RdAw6QibsmGScs8g1OjnmmCEzc5iH6KHz/zS85pi1pvuINvZBso
         GU+FQ6iUhtbgD5KQL2/Yuy0LY358LPivWoETWkyHbOzIkmc5VaGIkXiRuB7q51vj042v
         RIAA2XU9Pv2l+o3gwDDNTBqAqh49RVOIC/1ZmnqAJ8BXBm0PZeKVJbHF4IP/64lb1nkF
         Wf+A==
X-Gm-Message-State: AOJu0YyZsviT5ySyzcoD0ItkSuCrTQ/fG8TDKG+Jrq8NCuQod9V8Q+t0
	LTAUYkSVVmF4bMBNkmuOgfjI933BTD+eqB0GvWsQl4f0z5lxhb3PGXGY9r8QJgCwkse95x3Zmog
	0fao1d9ecIGoKZuP/hokU5Cu13LBbDpKJD/v4u3KaSIUAlccJKSf2loukLQ==
X-Google-Smtp-Source: AGHT+IEjQodeOnmWatXcPbGclr6dGdTKZ/5enCsS12gtqGhcFtpLPq4OMQGmEBlwd9frPg0eoYd8BvECU0oPJT32FqXlSrZMFsGZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16c1:b0:47c:561:dbbf with SMTP id
 g1-20020a05663816c100b0047c0561dbbfmr368843jat.6.1711960578601; Mon, 01 Apr
 2024 01:36:18 -0700 (PDT)
Date: Mon, 01 Apr 2024 01:36:18 -0700
In-Reply-To: <0000000000003ad27a0614fa0b99@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002844af061504e249@google.com>
Subject: Re: [syzbot] [syzbot] [kernel?] inconsistent lock state in sock_hash_delete_elem
From: syzbot <syzbot+1dab15008502531a13d2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [kernel?] inconsistent lock state in sock_hash_delete_elem
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fe46a7dd189e

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 27d733c0f65e..ae8f81b26e16 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -932,11 +932,12 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 	struct bpf_shtab_bucket *bucket;
 	struct bpf_shtab_elem *elem;
 	int ret = -ENOENT;
+	unsigned long flags;
 
 	hash = sock_hash_bucket_hash(key, key_size);
 	bucket = sock_hash_select_bucket(htab, hash);
 
-	spin_lock_bh(&bucket->lock);
+	spin_lock_irqsave(&bucket->lock, flags);
 	elem = sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_size);
 	if (elem) {
 		hlist_del_rcu(&elem->node);
@@ -944,7 +945,7 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 		sock_hash_free_elem(htab, elem);
 		ret = 0;
 	}
-	spin_unlock_bh(&bucket->lock);
+	spin_unlock_irqrestore(&bucket->lock, flags);
 	return ret;
 }
 
@@ -1136,6 +1137,7 @@ static void sock_hash_free(struct bpf_map *map)
 	struct bpf_shtab_elem *elem;
 	struct hlist_node *node;
 	int i;
+	unsigned long flags;
 
 	/* After the sync no updates or deletes will be in-flight so it
 	 * is safe to walk map and remove entries without risking a race
@@ -1151,11 +1153,11 @@ static void sock_hash_free(struct bpf_map *map)
 		 * exists, psock exists and holds a ref to socket. That
 		 * lets us to grab a socket ref too.
 		 */
-		spin_lock_bh(&bucket->lock);
+		spin_lock_irqsave(&bucket->lock, flags);
 		hlist_for_each_entry(elem, &bucket->head, node)
 			sock_hold(elem->sk);
 		hlist_move_list(&bucket->head, &unlink_list);
-		spin_unlock_bh(&bucket->lock);
+		spin_unlock_irqrestore(&bucket->lock, flags);
 
 		/* Process removed entries out of atomic context to
 		 * block for socket lock before deleting the psock's
-- 
2.43.0


