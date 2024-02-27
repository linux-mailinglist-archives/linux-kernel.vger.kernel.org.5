Return-Path: <linux-kernel+bounces-83352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 050F5869566
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C011F27FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F021420C9;
	Tue, 27 Feb 2024 13:52:27 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391EF13B2B4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041946; cv=none; b=e6kBj7gfvqL0tJIJrl6D+tYELcR3v7VlG9RNpd7RH+sm1rN3G+5Vtw7sIJqJZtL3rH+nKezzhjGpvRkfSEqkuMts6gHQBkZ9dvGTftCQ2X7fhi69UrsqaTT1URPsZgrtQ2ktsFm/wu+++C5UGel0KAULCfMHpPuUYoBOza4egsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041946; c=relaxed/simple;
	bh=2AdLu+ucxJHLDtKwPRAaF3U6U6SGp8sEoWncLh2+AGQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C7G6zE7B5ybB50m2b51ttvEsKLDelAKFLkSBqTxiNE04s2mygwZSyiTLtKyEtczfIT0a2RBOdtXzZUG5T6cKb6snTSuYCAJo6uuokOs64ssGI4Mntf8xeyCyfLtLckfziHtODbxLYP18ZMHkas6X989uauznDb0DqjVvYHxdq6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36579b46ebfso40720375ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 05:52:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709041944; x=1709646744;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xc24sYzbWiS2X1ZcJCVMmSpcVZnWckLM/vdNkcTyBBg=;
        b=SpZiAOVwWBovK36Z5+162pzwL0dNdcitlKGV9diuxkHe+rq//cYf6H7+hPJtvOIMmP
         9GX0p2bi5LTF8vG7YvVwJn4FtxQ0GaSnC3UHa8ej27Fujx5wzZjpyFzTvyjeqeVo2RRH
         ypIgSJZTFh9v1OZjb06OI0vM8yZlZvMkIk4aCDCDxg1IGI5S8cHKjVO+auNp0d1HQC2c
         bmQcYiN/FtjoO7mVYF/iRAqIEmieVniLxey6ODj9cIeTksEHj3zhxHIXEWB6OjIkY2eF
         lYbh8ZEnqPt5nUml5RFdUGCLl7Hie/D+rzKal75x20kKJmlUkTewQrNOJEsM++fzX2jk
         eB/A==
X-Gm-Message-State: AOJu0Ywjf2JmNxrwSCsHLmeHe9L5/dfIcSiW8CAt2yt6isGGNWt0LfaQ
	sl3NKyxVthHHSuMPbS60thmQDYCryH/uJwTTZZECj5sufc4R9L9CBJ8soGN3uN/CHN7hUStgCdA
	lWsdXUrpNJF9fbYXmBoE4Keeg5QAoYatmFTCiQmKyQ+xh9Ujq50eH4l0j7A==
X-Google-Smtp-Source: AGHT+IHb1wZe9qw+9rI3fQhTavjik/Ci8u9ELkfwWWJIBDTn9Fh/DzMAJByOivRTDTG9kcxxUECxZoA7cBPde35KrBfPdh3kY89m
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8b:b0:365:26e3:6e47 with SMTP id
 h11-20020a056e021d8b00b0036526e36e47mr665249ila.0.1709041944401; Tue, 27 Feb
 2024 05:52:24 -0800 (PST)
Date: Tue, 27 Feb 2024 05:52:24 -0800
In-Reply-To: <000000000000ed666a0611af6818@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000a79f06125d56f8@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] [net?] BUG: unable to handle kernel
 NULL pointer dereference in dev_map_hash_update_elem
From: syzbot <syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bpf?] [net?] BUG: unable to handle kernel NULL pointer dereference in dev_map_hash_update_elem
Author: toke@kernel.org

#syz test

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index a936c704d4e7..9b2286f9c6da 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -130,13 +130,11 @@ static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
        bpf_map_init_from_attr(&dtab->map, attr);
 
        if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
-               dtab->n_buckets = roundup_pow_of_two(dtab->map.max_entries);
-
-               if (!dtab->n_buckets) /* Overflow check */
+               if (dtab->map.max_entries > U32_MAX / 2)
                        return -EINVAL;
-       }
 
-       if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
+               dtab->n_buckets = roundup_pow_of_two(dtab->map.max_entries);
+
                dtab->dev_index_head = dev_map_create_hash(dtab->n_buckets,
                                                           dtab->map.numa_node);
                if (!dtab->dev_index_head)

