Return-Path: <linux-kernel+bounces-29025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C99A7830723
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD7C1C21639
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DD91F5E7;
	Wed, 17 Jan 2024 13:35:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D111EB4D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705498508; cv=none; b=n3B9fuxWNIfB1H/0qceRr/zpVGcOPdtq7ihOHHUCK17t7BzpDGqHt0hPgP3EsSnJLzWXkSCH+xHctLltY6xd/mWu344XC/9xKgvTycd8a7BNIgJA9WJ+JL6zJU62VJEoopKhwZB4d+TJEAywvFXmfloM5JAOs7wdBtVzSif03Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705498508; c=relaxed/simple;
	bh=OUMfXeArj0HXVgSvfgSasLkiXApnYxPN3j76HDFRTS4=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=DkRDcoUsFZrEiqX7W9OkUYGVqegyLiw0vQw6Z0C/PnE3oGCQkGBoKZLLhaT9tIRHaoVTKJrI8Q11q24oYIeyT+gKTDk/MLSwWXJNc8vMVIfYvZ9/fzEmm+cq1+dI6VfvfGI9HiPeU9SIcScRWyXyO6O83A0fArydNywaXba4gBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bf4ce8405dso216553839f.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 05:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705498506; x=1706103306;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZaEyxO71I8qdcKlz7TGqyeN+SJMsm6CO+OgGEYalDo=;
        b=mzLNcfbpwTjPS0xCroEUhTlJjEKt0id/4rdIx2JcWHZ2ptA/GWTkmaBM0LjQsYMu4r
         W3n7HxLTuPgDfBQYphjgtMMzhv7Yyz3atNIyD8CEuOY/QPH6re2FydpvSQNsadmSEtYs
         JF3e+OmMCHnS1KEybZgV7OWYAj7rMAg732takwv3jN+QL2WUxu5tzc3w9I9vKdD2Wh3J
         SUm5PAdJ3WcHAhf2X0CvjS0Js63pKicL+lOHa11nJYXPBgvoyd+ftVgH9eH1U/svla8P
         8eDW6MQWl4W5OuARttw+bx6BxtfJDMDA9+XNW3BAE4EtQJLwyUcEP3EwdRmcrYYUq+V3
         sJ7w==
X-Gm-Message-State: AOJu0YwcUr2slTyoQTZkvfGGHspZw4vR7jyDjZpQOcIqHa+n53EDMt2x
	BHXJcPfAThz2lzZPqr+6Rnbqbg1Y7VbFhkR27hu+pGfdMbIu
X-Google-Smtp-Source: AGHT+IG/osXct4btBMAUb4tjq//ky5reC00Q6e26CjJI3sxj9Aekygxhe/hyVAiz/cD99I+wiZfUovk5e/AvN30yyNF7ia1s+Hzz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:ce91:0:b0:46e:65a3:48ea with SMTP id
 y17-20020a02ce91000000b0046e65a348eamr349545jaq.0.1705498506228; Wed, 17 Jan
 2024 05:35:06 -0800 (PST)
Date: Wed, 17 Jan 2024 05:35:06 -0800
In-Reply-To: <20240117131417.1132-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0fcd7060f24505c@google.com>
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
From: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/core/flow_dissector.c:1169:29: error: assignment to 'const struct iphdr *' from incompatible pointer type 'unsigned char *' [-Werror=incompatible-pointer-types]


Tested on:

commit:         052d5343 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=da1c95d4e55dda83
dashboard link: https://syzkaller.appspot.com/bug?extid=bfde3bef047a81b8fde6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ed3ab9e80000


