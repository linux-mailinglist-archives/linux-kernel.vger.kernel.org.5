Return-Path: <linux-kernel+bounces-125974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58992892EC5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 08:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898231C20B9F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 06:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32CF883D;
	Sun, 31 Mar 2024 06:54:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F7079E1
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 06:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711868044; cv=none; b=ldxvJ7IznID66tpSf8fAas//EpQIyaklR9wL4nPJNu3CQSlJpr9NdUUJVnZ2dOl5YC5hqCMvhr0qs3e9MMm8LXqWXN1K5JPxLbj6uTbGQ7R1u+qH259IUaEsSjrv+SSuZMnRr2btbzsfgRfOs1l+QA42hewi6babhjzIPJ69wwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711868044; c=relaxed/simple;
	bh=gAeHeDqDZlzLCVDs5UhPpbAlE8XS5q/x/XmievfiMQc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Od5getjjkCUD0luUTG1OVTs55Sz74MeU1K0Z0VhOMi5xE1XPe8zktO1DAqe9zf7IwpGbo0zkTLJegOvceis6/hJrMrNqckY+zWoWmIs7cYJlSZ2YDVOMMSZlpq/MUCY4oa2YkwhonX7/2hvXx5ralSmH/bikmquyaTsUmOUtjVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3689678c5efso31804135ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 23:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711868042; x=1712472842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/c71aCLeNuSVucPluIJTLhL57W85nwTQ5r36sQit2EE=;
        b=d+qC2kCnzWyCWax7ZRnr3cpxqzA0HqtMUoNy2tXo8v+tF3YAnxD9LoPLpXhgXAdnGB
         GpcPKOM7GgeKGEa3KRnpqWCJQQ3Lh9T42fpCae2y9VqN08dByXaiXMPbEM5cX1Vsqg5L
         96lw8DefsbonaRwQvMi4TX9eAtnlptgMtBiLywIOegPU/VeaxLdoCUqlFEoFBxtGPe4I
         OIJiEoLveQXsADLZrVZMb6O6hKk4XnsCzf0590OTC4hDBDO8DLRqBcBmM0yVjjjaBinc
         WmqnE2feF/lV2gFUHPbddVKgjclTALJayeuw09YBWdjiQKGbjCpqBr6PR1fJFe8Gn9Df
         VmKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFFgaRXCAJh6NJNuQfucCufzg9x+oym1znyzYV4ypSZKVldLKATAhK8Le/5WsvzorXU1vej4i9IQnNBaNuVJF9FH53o8H0sdDqAFVc
X-Gm-Message-State: AOJu0Yz3SMSn2zG/Ya4vxvQmNx30LD0WTrgr86BTJ1SqiDTdWD8yCk99
	v+hpIa8OirHe2qUiJ9HIZ/Dhd24H4rOgPoSsiA8kEus2PaDF7kpL5AC3T8OxsYZN1MlU4sce+vN
	IUy5ClJYa7RhhepPgTadKuVCaC9EV/N71gG5qGRlm9hZXf7kgf5pQmHA=
X-Google-Smtp-Source: AGHT+IHxEwKuH1DJmvaA6Sg9RrDUxGjxzJUVxMSc7LhNGfi59hnaBEgnkPN0IJT3LeUx0UnTNfMGs3HNY/FgPAl034VJ4Mxk85Vz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe3:b0:369:98a3:6f9d with SMTP id
 dt3-20020a056e021fe300b0036998a36f9dmr100831ilb.4.1711868042346; Sat, 30 Mar
 2024 23:54:02 -0700 (PDT)
Date: Sat, 30 Mar 2024 23:54:02 -0700
In-Reply-To: <ZgkChGTru7cc3Nsv@pc636>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009116390614ef561f@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in kvfree_call_rcu
From: syzbot <syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, urezki@gmail.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/rcu/tree.c
patch: **** unexpected end of file in patch



Tested on:

commit:         7033999e Merge tag 'printk-for-6.9-rc2' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=1fa663a2100308ab6eab
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1406ae29180000


