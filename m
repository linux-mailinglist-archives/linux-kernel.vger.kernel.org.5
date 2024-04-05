Return-Path: <linux-kernel+bounces-132919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B51AD899C07
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53BB81F239B0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4816816C698;
	Fri,  5 Apr 2024 11:44:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF1F12AACC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712317445; cv=none; b=hgytYKx+H76xtCqlfMcBmjDbxi4vnLtt8SuqHFGjFKWNSbvNs4cmnzfvmd8p0ide3IhZK1eEb64Wg5cuafmD2EyJYToMgr0z57yVYirIjp97jkP+BwvsbolzwtfJcVoXz4gVToIgPVKUZIpkty5MMyyV2fnitvL76K5gugvrZgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712317445; c=relaxed/simple;
	bh=1n69jQnZNKEzS+BuCynTJ6wVLAELOXGFXKr66F84Wh0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gkJmshlG0VWJymU1rZjkRZlmV+Zc0f6WRExYuRf66vd9GTOwhoY/7g+kldUDvvaB8yt/9ItWmupjRQjVrAwSr0cGOt7thxeG5vuT+BFcZOSZpu/JBUUzJysFNFwzgq62rwcSU6bgrNYFOVi6n43BdAg8De4n79+Pg9IYQeTRceg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc7a930922so240496039f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 04:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712317443; x=1712922243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3W1dhKn+FkCzjrz6qZe3J8mK4nAfdKOIBP/9TwsFfk8=;
        b=oU0YSBSjOTqkR9U6VjYb6rWQlt3dp/sA8nbEkrqHeG3Se26vXYiIgcDJC7SemShRHC
         8DCju4iqfa979dh4UhknWJDmWdmM0ht7nloOgceCRuTJNs97wYpXAM30xSx6q1IfSe5O
         mg1PbPozmYsSYfFwc9yFoPjn8jcN7C1v0XH+O42DN4Xi2JKRDXWUYlnh1Dtn6C6HQfYl
         Mof4bGMXbMe9gjU8LDquRlg0jlAxMw0+SPT5TUs7sGeUGawh+Dq/e3yWH++mkTPi3BUW
         KLgz+Eljf7pF1xhfC45tK3OjeeXgSHoRTkl+8Dw1lIsjNABBQ4oHtfaV4ZZRFRzhsU10
         8Kmg==
X-Forwarded-Encrypted: i=1; AJvYcCUtl7JIqY/Xvm8NhdgZ4dZSeaKwjilUQ9UC9uUxTi3fZ4djn7rZ30gMktUoES9ii+MG53fgS28QCY/bhCX+Xj/AAa2bql3LnP8seML8
X-Gm-Message-State: AOJu0YxHPVHoP92V6Xn0iEFA7tEIqnWE6KfbPQGfxmFwSb7nXE3APkMd
	WBxYBLewM4rujv+8WKMy4VZwPSyunedIOAqb+H8yYxgI/i/P/5J/PLrqfSY6kZljBlOf4jTDn7O
	3Tb5Sn8LQKpayia20fC3JOpOV0XqvQBZCGU89r9WJz0wlH++Yz/fOhYM=
X-Google-Smtp-Source: AGHT+IF1B54lz2GNKBGpo9CB2HDcO5BX30XoyjcTHrl6IQMYGyJfgiMBpRzXZ+ON/P4IcwwJUfOSNWH0QZPvTA6NZ71t4FDGY8tC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22d0:b0:47f:1ad4:2c66 with SMTP id
 j16-20020a05663822d000b0047f1ad42c66mr42868jat.5.1712317443514; Fri, 05 Apr
 2024 04:44:03 -0700 (PDT)
Date: Fri, 05 Apr 2024 04:44:03 -0700
In-Reply-To: <f42ee0ef-8754-4acc-94ea-9574de83c9c9@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6bbc4061557f8ad@google.com>
Subject: Re: [syzbot] [arm] BUG: bad usercopy in fpa_set
From: syzbot <syzbot+cb76c2983557a07cdb14@syzkaller.appspotmail.com>
To: keescook@chromium.org, linux-kernel@vger.kernel.org, 
	penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

/include/linux/stddef.h:16:33: error: invalid use of undefined type 'struct task_struct'
/arch/arm/include/asm/processor.h:44:24: error: invalid application of 'sizeof' to incomplete type 'struct thread_info'


Tested on:

commit:         8cb4a9a8 x86/cpufeatures: Add CPUID_LNX_5 to track rec..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0bf9b3a0ca93c59
dashboard link: https://syzkaller.appspot.com/bug?extid=cb76c2983557a07cdb14
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
patch:          https://syzkaller.appspot.com/x/patch.diff?x=157e1bb5180000


