Return-Path: <linux-kernel+bounces-108822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8B4881078
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A2D283A82
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26513BBC8;
	Wed, 20 Mar 2024 11:09:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7F73B293
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932946; cv=none; b=t4HoG/jkGybzeZCnSqv2o4VkINQiTUbeX+R6S79Sxr5N0TLjiJQnZZqKbmAYHXvGyOZ/iHIUI4n0SPxIGo/gliUP1i1Oq+pr2Xd1I+v9YcDDtpWQ0gqlzgJevW3qpDOrmEaw3qKYbjjPR8+6KHrTUtS2zPF0jSwB87d+kT9Bu/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932946; c=relaxed/simple;
	bh=zyiVqRbQcvuPmGTEXSArdp75lxTjNAkJIY920NalIIQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZCc5vT6FUPJmTRp+SONuEx3nf56jRatUr016tns4jM/IoWKsxJz5N+ILK8oKElhd/HEE5BbYjceIlb4S6OvsdhOGj2RzHU8B8hODtY4J+0QrvKB21+mCL0N8ulTL+6bhYMcHIFObl09lZPDRgjsGi5JL0nO2j203JYLkuYhkkOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc0a422d43so414857039f.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 04:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710932944; x=1711537744;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1ISRsAmjUNpkEXjyKomgTS3T0vnbCkCoAF6I44gYNU=;
        b=E5LpX4gfGEIkk/xRK1M48AAhOyGgVEjT8jPAYG4rhaFcTmyR70mNUtoIEAeAaHcp3w
         nB/Ihq66VVV++aSMqdjpnOqVga2GMoDVkCKn1lIBo6CHp8Rs7BGbFdub30oY+qfLhm/W
         XXo8QW+XDXBhtvYNOZap/KfXpItCd7rMZbEFqHVW/sBqHVcl99sGvrm0vcB7K6m3aLJx
         l+aEpMLpEiDTmzIXVA7m7xRNW3K+REH9z4LywrfQ76KhxslA+LLbs4FbGHEofkCn9jBm
         Ae8KT8khod45U+r2LFzC1a8zqjAduMUQFx/hCeVfGaALCDa7Eb8ZV8SOPbDj2WTdRyO+
         QvnA==
X-Forwarded-Encrypted: i=1; AJvYcCWYxZKX3rVLanSMqtvmjlQ2KFztL4hVMj6EQsjwFcG2kxQjRjM0u5pnmeAjESl8P/uoSF8v9dtmQSuSAGfNNG1P26wQMVepgDKx9/j+
X-Gm-Message-State: AOJu0Yw3NtPQi0UPePyIAyxSKUoRXPlPIf4MAdpcpTmGZzCapmKD+QCF
	OIzOM9mvDedA22Y4hJ0t7Gqz4gVrnYS5pP2brxHAQqcY0jPox0nmRz31+e6sNHdFZZNlzY0hrAr
	t75XPBIOXzlejiVSRl3U2rn7mlOTPoZJPwX9djYjvJHnL9h1jhJ74OjU=
X-Google-Smtp-Source: AGHT+IH6jO4kXeXQBEiU9yCCDN8TRRVhGQgDcFgY74QR4i3qJcbVzU/58wPeVwBxNGaHwNkN8mwSl7Ulyr8+lRAnopUlxETxV/9H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24c3:b0:476:d09e:478 with SMTP id
 y3-20020a05663824c300b00476d09e0478mr174847jat.5.1710932944308; Wed, 20 Mar
 2024 04:09:04 -0700 (PDT)
Date: Wed, 20 Mar 2024 04:09:04 -0700
In-Reply-To: <20240320104554.2181-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000615c760614159e03@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in move_pages
From: syzbot <syzbot+49056626fe41e01f2ba7@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+49056626fe41e01f2ba7@syzkaller.appspotmail.com

Tested on:

commit:         e5eb28f6 Merge tag 'mm-nonmm-stable-2024-03-14-09-36' ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10b7afc1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ffb854606e658d
dashboard link: https://syzkaller.appspot.com/bug?extid=49056626fe41e01f2ba7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17d44231180000

Note: testing is done by a robot and is best-effort only.

