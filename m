Return-Path: <linux-kernel+bounces-64933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A35FC8544D1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F86E1F24630
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B974912B6D;
	Wed, 14 Feb 2024 09:15:35 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D333E12B60
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902135; cv=none; b=qD9l3EXksC87lXR7ZQIRG4fqkt7mSrKJxSVN9zDFbkgBau9HVn+NhPyTBAjqJ30Xh0bNYnWFn6lUUTJxK+4lqubjsrsIcedICzHXO1GabbSnKu5GH62sg2I340WhIyydWqkOLLuuIE35CkZBd7MviEEWSNGpy0ABORHEtJYz1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902135; c=relaxed/simple;
	bh=N1vn1RGyIVAdNk/YMP2vn7TOWML6WFwAUh3/oQgJnm8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EEph5YK5kOGAtJwanNOszJrPJfCR1xP65dOl6Ya/OtpX0G4CRE35zua7rJw0W1soo1n64uNvqYEkC8IPEITkcX+XRm50Pz9+o9A7GcKbgMteWztBtghXyzGWR62v+IsiUTnKwqhbNj0FotIXcJM9VDBsNlSLUOwuL+stYEf7QSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36424431577so9754755ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:15:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902133; x=1708506933;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aq75ToyQ5CdNZrWgi0NGlGMJbrmY+i1lpdyRF5BXO3g=;
        b=WwL8kkwDvHuf6T7YHOMWoJJ9Uv7VDyuXKIDbgeDZmsNff3uBWf9C1e5dbo443sZF/U
         jzgUhbycTd6K2783WPkY5WX7YKctrd8EiCPNSHtu9lO3uSAsTWakaeocmYbeOLfYC3i0
         QYtxla9oKf9iYeLVPjPiQAcxoeFd6Y0og53PYsPvnwt/R+Ge/mrSokDWtrwzm6PWybkO
         Fa1T4/Kr0RUVD2ke8yz+YqmPklRTyHMAgX9gwVS4jbrdM6wa6MxWop6i0SwoNOa6EDNr
         oCBhmi0ujt0kF38Bh7ODmCu4ZK6nwSVHp6LQGQArzzo3nlztAZ80tqwEiLEtNxmL0WEr
         W16g==
X-Gm-Message-State: AOJu0YwKtF7YB7kcXiNbrKlEDpqQSmprfxauV6LPEAA0wbH+hy0Q9e9H
	GURi9St9c91ER33R1jkM6lboJ1HkTrLzY/4oXy2Y3k1RgpvqhPpBBHPHEY+3uMUXJjKqaaKlUpJ
	rpU1nL/GyvxGQE/XM0rGY8ZnkFb1n4t3a0O7pVwTNnrWstES0xsMkjSSwXw==
X-Google-Smtp-Source: AGHT+IEY2xvbibeh0NzyuXyJffWf0t+dmUomB6119z2yofk5aXjgILU6gucvenA7wQyLUA8gIROy3QzO5RfkKmmVBnA75vhR7LjJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2f:b0:363:d88a:4640 with SMTP id
 g15-20020a056e021a2f00b00363d88a4640mr172893ile.5.1707902132966; Wed, 14 Feb
 2024 01:15:32 -0800 (PST)
Date: Wed, 14 Feb 2024 01:15:32 -0800
In-Reply-To: <000000000000d42dae0611477922@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2617d061153f3a3@google.com>
Subject: Re: [syzbot] #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 for-kernelci
From: syzbot <syzbot+ebbab3e04c88fa141e6b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
Author: kadlec@netfilter.org

diff --git a/net/netfilter/ipset/ip_set_bitmap_gen.h b/net/netfilter/ipset/ip_set_bitmap_gen.h
index cb48a2b9cb9f..60f5e29ac8fd 100644
--- a/net/netfilter/ipset/ip_set_bitmap_gen.h
+++ b/net/netfilter/ipset/ip_set_bitmap_gen.h
@@ -294,7 +294,7 @@ mtype_cancel_gc(struct ip_set *set)
        struct mtype *map = set->data;

        if (SET_WITH_TIMEOUT(set))
-               del_timer_sync(&map->gc);
+               timer_shutdown_sync(&map->gc);
 }

 static const struct ip_set_type_variant mtype = {


