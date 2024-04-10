Return-Path: <linux-kernel+bounces-137844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419EC89E835
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59DC1F23543
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0552C28DC0;
	Wed, 10 Apr 2024 02:32:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E313219F9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712716326; cv=none; b=l1jpsw/UF0hTFwZ+McUilD53d14UCMY4A3DFofie8UUyyAwNg+3BbMsV3MGStJIynLmpUsAdtcm+QwcNjJrRjLP7GB+S1jj2P/7XvYED1fuKYp45/VBAUDkn3dy8OdrlR8K3HPzIde9e6lvezca8s7nWiCmfklL5OdKHwQ+Yo9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712716326; c=relaxed/simple;
	bh=GQIcsAEx/daRpeuwEh/AM6G+AM+13bbAyN6SGBk7DyY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MA8P0fuwvl7jcMXRzzzgN/M6UMu+m/jc8URS/PDyXjd9saq2HoAGLvb/sD9vvHfY7u5IWfGvhyak8atLd/xM7XDqTF8YbgEvg/wVgymrhxhOAY17VMi17+pXgkTaNjSbKZTopTBWT8r/Mczd5isa6AiFrhGzw+4OmLEl7o+qD2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36849578ac4so59903125ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 19:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712716324; x=1713321124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EFGWvLt9g+hWMy01EyX9UgHO431lxOqyljfqGnYCtRg=;
        b=EAtY/+gOlnFaC1UgxwJ+ihpJgGnEYPjDffd/j4dmAaSbUX9BAtbGIwuXYzPSTVSAHe
         pqVKXKAEdveUVQgmlUWiJLk4nILii7mLaTv1CllfYnUhwvHo9HsD2wUjGrgt7WWyxr4k
         D769bdXmk1SiNQTpaJnExeMkan/FYXzphayKzD/+Z/efQ/OSdSbKOzOQht1YlvuL3MO2
         ddTI4eunSvBQdnRuNbNs7Ez7h354vaHcXNoIZODQHnCTWqizsCBE1EFQiQmp2yu8cc15
         qMT8b+puX2x04MlgoRp6T6avcy3rj0yO3BCVGvsAOZJJwrn8/TqAmwayKvIe3RupwFy/
         uvfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7k6AnwYgSF8TYpUAKWfINd7+k2F/Hhypj1svJWQMf+dL4p6CHoEwhKzdZyWSoUUA2+u5OX8WfM2ebXhnQb+ag1RtsaFejFL/IH09/
X-Gm-Message-State: AOJu0YxiPGBY+jD1PJJBJLRw0DDRMwJijh2PMK9BAGToL+RvdM623HlD
	DhNy/RPNKccFFdVzb7OsKApTzwaWPAsNvHphXqmZ/jeEgDsfqbkUanN4mUmAgdxQoCk8OlFlYvD
	xmyGnvx9uhIxsJfXzGtrSEH2jnMRiCpyILPrQahORJi+z4ak5XkiZiuU=
X-Google-Smtp-Source: AGHT+IERHtnS87pg7WJglv4qdjNiW9YJKFawC8tyAxtiQBBk0VDOd+DOJZM8X496v+n/1+Krn+d5jbIMkmAWXbehXYRK3X+GqaoZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe9:b0:368:c9e2:b372 with SMTP id
 dt9-20020a056e021fe900b00368c9e2b372mr106541ilb.0.1712716324155; Tue, 09 Apr
 2024 19:32:04 -0700 (PDT)
Date: Tue, 09 Apr 2024 19:32:04 -0700
In-Reply-To: <tencent_66764A0C74FD776567343C4D36D6971A3609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a48d90615b4d8a9@google.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in strnchr
From: syzbot <syzbot+9b8be5e35747291236c8@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9b8be5e35747291236c8@syzkaller.appspotmail.com

Tested on:

commit:         04b8076d Merge tag 'firewire-fixes-6.8-rc7' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1499545d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
dashboard link: https://syzkaller.appspot.com/bug?extid=9b8be5e35747291236c8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13b200cb180000

Note: testing is done by a robot and is best-effort only.

