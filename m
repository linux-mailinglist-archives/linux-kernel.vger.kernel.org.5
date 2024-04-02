Return-Path: <linux-kernel+bounces-127335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ACD8949E5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839DD1F23A40
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A4D15E8C;
	Tue,  2 Apr 2024 03:26:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB7314AB7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712028365; cv=none; b=TcKcRBheq4abTHbHgz1DzixuTEXkC1ulyxJWKpDRzyEFYsL/a5No8wNMqOeiHkHyvx+DeKyfoSVD2TtAESI2svoEnXl5RNk1gifYK0qY+0WlA5E2YLbKE0yf/uUvsGeE8+LfN+JdWRafVXX2JrLkXjQDcb8r/jNrSVWlVL7y0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712028365; c=relaxed/simple;
	bh=wSr3rHG9nJpkblrt+sv3U5SXJ+62qimKQYaXZjWG1lw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uQYu16G9hzw78VE39BYx/5hBNE18K7y98JjbfzQe3F1Mib0dLHM/cFLsq18BecJ8qk7NVs7G570QAOtUhGKnoax5gjOybMvj3zlDNRHG78AZpFbP+s+BEsTn5X30MRPV/Z3baHTx9oQ0wLNPTZDsobrO7UYg7NzENLn2ATnjOg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbf1ea053cso512725839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 20:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712028363; x=1712633163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Mees8FCkEDruqSqmIUhviuHEO5gv56mgH0AeESTS2Y=;
        b=YCUPn/RRw+uzpLtMqmeCCzo5/Pzzdih78ehJn1YzArLhJt9SlsjzEhi5RAhQEQCF4b
         +sAdQ08QHRrDXcCXbfPCmRUKlaivaapNtqppJbtnrgckdAFElYZ7zzUEHKKEys4vv501
         xlGROywDw38NH9J1Pi4I5tdojwCaVyLpC8fjOd/SJ/kb9Gy4q9iE3sKrulKzELFIP8pc
         NFM4gx2GQy+gry4kspD2X0Trgc+xc+H/I1iED+dlEn9GL52CS/oFY/eYhM5VBfpW+duy
         y1lAaZtgodmdMvAXLa+IKr+DQ7WoXsWUAiwcOvUKCLWUXQk5/LtWTuuFWNeCZ8jLr3Bd
         uJfA==
X-Forwarded-Encrypted: i=1; AJvYcCVnDAhdHs1+MomPwowFZDeH5rFMiGuAnIQupsFfKtZtMQA+HgD4z6blP++vkrIz/xtHTYLxv4e5W0j+YczJOyjJI5akvCHHwcBYt9T0
X-Gm-Message-State: AOJu0Ywcy8lJucuuYqxFYPbg1R2OEC5yvH4DirNgcaiVsZmKzdsA9GBj
	j3eauRE/pjOZb7M8nJJqF8kGLYTM7TmFE1IbUOxmguytgaen/htH63/t2zTyRLh51s8hkOMPAx3
	aphLs0HAaQEt8Ab6q4RoE8a37BkwLWGryHFWmo2l0QW9fd8qUncF+br0=
X-Google-Smtp-Source: AGHT+IEo2rSqQ15OlQCfn2L4f3vXzdxQRQ/Of88zK2yidJsVVjpMr/NNUFYe81KRvzr6I4LzNd3uEJWbz7wN1sxxZ1w2JTPIADMe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1413:b0:47e:e557:ba45 with SMTP id
 k19-20020a056638141300b0047ee557ba45mr417058jad.0.1712028363088; Mon, 01 Apr
 2024 20:26:03 -0700 (PDT)
Date: Mon, 01 Apr 2024 20:26:03 -0700
In-Reply-To: <20240401224417.3584-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d7564061514aa3e@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in hsr_dev_xmit (2)
From: syzbot <syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com

Tested on:

commit:         480e035f Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12e1130d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1321fac5180000

Note: testing is done by a robot and is best-effort only.

