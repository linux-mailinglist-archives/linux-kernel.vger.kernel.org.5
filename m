Return-Path: <linux-kernel+bounces-145478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A818A56B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10101C210AF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701317A702;
	Mon, 15 Apr 2024 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="b99ZbIvg"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3734BA94
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195796; cv=none; b=cOmoXNK00yzAyPl0zviqlRp478s0+WKQPr8rVPOfB1Ug+3QbXkOuQMJWtoSNNpM3XUkbJhJ1SEKnP5qVC/GViIyOz+z2ejIpCekdTA6oOt7RtH9ATvkPtrvNUT4OWU0VpETAHHGrkBT9gpyBuTGFb1LNg64eMH0hXpe4MYZO5zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195796; c=relaxed/simple;
	bh=6ZzMmQQlxur4AJXe2u1N8jWtMrGUZYIa5t7CpFb8ORc=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=Y5VG93tJ43fiZySXr9LxmhN5FVQ1TzlAWUvAPP281ihip+HJFunTA8CsdoZKHkAWvdUiIbCYsrfHPK018vzryuRA06HVamYXHPFb+ajvwKx2r0wMxeBETy4eyedIemjVFANADaEoOUGrx/JClQ87AE3MO/UMiRqbxJrRehI/nBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=b99ZbIvg; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 96189404A2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713195792;
	bh=UCnYW/5UMVuS676TKLld3+Mry/+HuiD7VxWKXuU5V74=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=b99ZbIvgzzgtBo5Br9Yyf6hNCczHsM7uAjyKFafiO6Dge+ql3cr0YBUoTNyI64EpN
	 eOYw7+BZtmn02Pz+uF+AA8bw5LGAJDi2FUMur14SD7lHAsE93tOsYDA1KbKudHHVLY
	 yXxTxMSuCypr14sxKMJm8R+qPwvRSTmMatc5iahVfvVHYe9O61kfoJmRS5n8l3Ltuu
	 Hig5PgGoB1xap0/4TPPwZyqhNeohRSZXv0uOZOZPU5UYdrIPRQXJV7k3tpVaan2nOn
	 7m0ZcIklcHfQVJjqyJ75/YcwVUnY42TWQ3fRWohVCg+RJkLQSI7OJ8WolK+0yCtWxe
	 Jw7URCKJHA/Gw==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ed2e00aa22so1829612b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713195790; x=1713800590;
        h=message-id:date:content-transfer-encoding:mime-version:comments
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UCnYW/5UMVuS676TKLld3+Mry/+HuiD7VxWKXuU5V74=;
        b=mQAMyeVqQm2Xv3CF0BrUAGhhbIjL4epeh3s99bSX8St5Q1k8I4ch6fx0KrI7YxeIfL
         U82sTwg9WpIh9jPorsKIDwmK7ljG1ID9aIey3cAjA2X9Cg4Yq/8kN0DEckNoQclP+v0y
         8tqz48m4N34fFtwfpRi7nxQyEw7OJD/cf7yQJB22BfkTC27nATKEUa2g36UQ08N5MhOQ
         gkOXVfh9qQ1iyVCn2esRBJqJWGFcN8JXTn5LcQvWe4YQzsem6CBNxz0SkaAqQiVFV/fF
         mx5UZh3c+h4oNsv+0JZ2dJtLElfL5klJMhrU1fLlyNIszZmAMD5cGHMfAha8US1FkmIn
         N9PA==
X-Forwarded-Encrypted: i=1; AJvYcCVBFV3hsh1akows3RFFanOptTsgseEMIKpF4z7EA9xqR98c6e21hXPHKGcSpudsHMYNSy2/mekK7ecru/OcIfDwLJVCJUT9ffdWg+qY
X-Gm-Message-State: AOJu0YxWHV4xSSR8iuHfRQg4CZy8hzqGRBiK/112ndvqCNokvlnEf2f9
	oyk30j4vNqSEPZp7T2N7pSBAaX7bhhsJWe81SMyTM1j9KG3sLG7Z93OycbDg2OxthF/ExeX9wTc
	EKoAP2g5TXnHVTpnudKoLye92KwXbAHhf6/jmQlQkG3oR+61ZlgHDFDCvVllBjTzjJmGc8h2YGz
	Hlxg==
X-Received: by 2002:a05:6a20:7f8b:b0:1a5:6e11:2fd9 with SMTP id d11-20020a056a207f8b00b001a56e112fd9mr9538165pzj.6.1713195790163;
        Mon, 15 Apr 2024 08:43:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3/YOZCSDejeKCM6T3dzQlJ0Q4WLdS3RHSyPXkd8elDfeRaKsIKRoEQsaTWifvHHgHj5w3Qw==
X-Received: by 2002:a05:6a20:7f8b:b0:1a5:6e11:2fd9 with SMTP id d11-20020a056a207f8b00b001a56e112fd9mr9538139pzj.6.1713195789511;
        Mon, 15 Apr 2024 08:43:09 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id y15-20020a056a00190f00b006ecfa91a210sm7385100pfi.100.2024.04.15.08.43.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:43:09 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id AB3EF5FFF6; Mon, 15 Apr 2024 08:43:08 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id A406B9FA74;
	Mon, 15 Apr 2024 08:43:08 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Sam Sun <samsun1006219@gmail.com>
cc: Hangbin Liu <liuhangbin@gmail.com>, linux-kernel@vger.kernel.org,
    netdev@vger.kernel.org, andy@greyhouse.net, davem@davemloft.net,
    Eric Dumazet <edumazet@google.com>, kuba@kernel.org,
    pabeni@redhat.com
Subject: Re: [PATCH net v1] drivers/net/bonding: Fix out-of-bounds read in bond_option_arp_ip_targets_set()
In-reply-to: <CAEkJfYOebGdmKLtn4HXHJ2-CMzig=M+Sc7T0d6ghZcXY_iY5YA@mail.gmail.com>
References: <CAEkJfYPYF-nNB2oiXfXwjPG0VVB2Bd8Q8kAq+74J=R+4HkngWw@mail.gmail.com> <ZhzYCZyfsWgYWxIe@Laptop-X1> <CAEkJfYOebGdmKLtn4HXHJ2-CMzig=M+Sc7T0d6ghZcXY_iY5YA@mail.gmail.com>
Comments: In-reply-to Sam Sun <samsun1006219@gmail.com>
   message dated "Mon, 15 Apr 2024 16:46:24 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Apr 2024 08:43:08 -0700
Message-ID: <12281.1713195788@famine>

Sam Sun <samsun1006219@gmail.com> wrote:

>On Mon, Apr 15, 2024 at 3:32=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com>=
 wrote:
>>
>> On Mon, Apr 15, 2024 at 11:40:31AM +0800, Sam Sun wrote:
>> > In function bond_option_arp_ip_targets_set(), if newval->string is an
>> > empty string, newval->string+1 will point to the byte after the
>> > string, causing an out-of-bound read.
>> >
>> > BUG: KASAN: slab-out-of-bounds in strlen+0x7d/0xa0 lib/string.c:418
>> > Read of size 1 at addr ffff8881119c4781 by task syz-executor665/8107
>> > CPU: 1 PID: 8107 Comm: syz-executor665 Not tainted 6.7.0-rc7 #1
>> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 0=
4/01/2014
>> > Call Trace:
>> >  <TASK>
>> >  __dump_stack lib/dump_stack.c:88 [inline]
>> >  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>> >  print_address_description mm/kasan/report.c:364 [inline]
>> >  print_report+0xc1/0x5e0 mm/kasan/report.c:475
>> >  kasan_report+0xbe/0xf0 mm/kasan/report.c:588
>> >  strlen+0x7d/0xa0 lib/string.c:418
>> >  __fortify_strlen include/linux/fortify-string.h:210 [inline]
>> >  in4_pton+0xa3/0x3f0 net/core/utils.c:130
>> >  bond_option_arp_ip_targets_set+0xc2/0x910
>> > drivers/net/bonding/bond_options.c:1201
>> >  __bond_opt_set+0x2a4/0x1030 drivers/net/bonding/bond_options.c:767
>> >  __bond_opt_set_notify+0x48/0x150 drivers/net/bonding/bond_options.c:7=
92
>> >  bond_opt_tryset_rtnl+0xda/0x160 drivers/net/bonding/bond_options.c:817
>> >  bonding_sysfs_store_option+0xa1/0x120 drivers/net/bonding/bond_sysfs.=
c:156
>> >  dev_attr_store+0x54/0x80 drivers/base/core.c:2366
>> >  sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
>> >  kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
>> >  call_write_iter include/linux/fs.h:2020 [inline]
>> >  new_sync_write fs/read_write.c:491 [inline]
>> >  vfs_write+0x96a/0xd80 fs/read_write.c:584
>> >  ksys_write+0x122/0x250 fs/read_write.c:637
>> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>> >  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>> >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>> > ---[ end trace ]---
>> >
>> > Fix it by adding a check of string length before using it.
>> >
>> > Reported-by: Yue Sun <samsun1006219@gmail.com>
>>
>> Not sure if there is a need to add Reported-by yourself if you are the a=
uthor.
>>
>> Also you need a Fixes tag if the patch target is net tree.
>
>Sorry for missing the Fixes tag, I will add it to patch. I am also not
>sure if I should add Reported-by here, since it's my first time to
>commit a patch for linux.

	The submitting-patches.rst file in Documentation/ isn't
explicit, but the intent seems to be that Reported-by is for a bug
report from a third party that isn't involved in creating the fix.  I
don't think you need it here, just a Signed-off-by.

>> > Signed-off-by: Yue Sun <samsun1006219@gmail.com>
>> > ---
>> >  drivers/net/bonding/bond_options.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/net/bonding/bond_options.c
>> > b/drivers/net/bonding/bond_options.c
>> > index 4cdbc7e084f4..db8d99ca1de0 100644
>> > --- a/drivers/net/bonding/bond_options.c
>> > +++ b/drivers/net/bonding/bond_options.c
>> > @@ -1214,7 +1214,8 @@ static int bond_option_arp_ip_targets_set(struct
>> > bonding *bond,
>> >      __be32 target;
>> >
>> >      if (newval->string) {
>> > -        if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL))=
 {
>> > +        if (!(strlen(newval->string)) ||
>> > +            !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL=
)) {
>> >              netdev_err(bond->dev, "invalid ARP target %pI4 specified\=
n",
>> >                     &target);
>>
>> Do we need to init target first if !(strlen(newval->string)) ?
>>
>Good question. I think we don't need to init target first, since in
>original logic in4_pton() also leave target untouched if any error
>occurs. If !(strlen(newval->string)), bond_option_arp_ip_targets_set()
>just ret and target is still untouched. But I am not sure about it.

	I think the original code is incorrect, as target will be
uninitialized if in4_pton() fails.  The netdev_err() message shouldn't
include target at all, it will never contain useful information.

	-J

>If anyone finds other problems, please let me know.
>
>Thanks,
>Yue
>> Thanks
>> Hangbin
>> >              return ret;
>> > --
>> > 2.34.1
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

