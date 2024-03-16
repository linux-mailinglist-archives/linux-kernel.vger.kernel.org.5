Return-Path: <linux-kernel+bounces-105210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5BA87DA8F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAFCD282216
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 15:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34EE1B968;
	Sat, 16 Mar 2024 15:20:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAD018E1E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710602405; cv=none; b=pz0t/SWlzIOpYB5N1MYw9Vh5O7MHtONrdc76zMva9WqWnpkXv0/0CAtbtSCitMwMElZs2CR1GEvyOBWuq5uN/au9pcYfjXHK5lZIvlvJV6zNbKH6e8NGF5taftCkSxjVitgGie3S0J+qMC+GNp33PzpHM/7JgQy6pnpt1ls410Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710602405; c=relaxed/simple;
	bh=po6C+6UERN35FXCr59wZF6It8p90ooJtSle5rHvyZsI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=M2Cqw5luaUY355v061bKb5KSs5rEyMGNrGZ+1MvPVTkyw2pbuJrke7ecD+tmDlm5MQf4pUDc92fhKcfFXZW5FLGhO+D442YRO0hEPIKtOEjwIN1sGFRa7T5qKocVn9TFdEeJOs+gfr8/1OfW3sjXxDNV+Fg2vNkwYV//hTAN02Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbf0ebfda8so175992739f.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 08:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710602403; x=1711207203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/sqHBBaMOeAnurYIhwPVCqQ5vnkrKRfkMuwUxyQYMH0=;
        b=e2STorOeZkRGSkNtlvYpmQUNd1BsfpI8dQ8KjZ9Lx5LnKuRJwi/CPefd16TEPy3QXD
         uoO3uJ+HlSDDzSxgWt1eMia3ATbpXR63OmD9n5hAXPpu6OZXSHXPJan3vQO+7ruq8LzB
         ov02G0wKBjTIL9mUnK+TYz4+/QDLrMu/0A+9XuhW1UnsKF0zA5smFwcT3xVkmhZb2rvh
         RIdfNJLVnn23jWIDEFnGx1ZVdf2tuy5P0tXiskNfaXFAAIJSXXcDV7gSIKw+cE5e5XfY
         9tyGoprLLDEln1S9KhBOaZ9g+AGvxUD2BKlK59CONG1s+bFSV8OZAh1Jj5Mcu29LOtCN
         VL9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqQOvUGMMYbysPcTl7J3itp0dB0KH0HHRiVGNW/FPfmp5G4vcOQCMs/zj5zdipE0N9+U/U8CMDow+NzaUujUBQx1xKyYpbAgS1HwTN
X-Gm-Message-State: AOJu0YzoPkrYDzxOX2akiBNHasu/ZSQpFntVJDOX4rDN4r6ZiYz2WSTv
	T9q19Rq13FN2l8W7bkI3lCUmQUjccPbM3sNeI/LqYSQtBpgmEqbeHa3D4hiW8OXl0fFg3dhIOv8
	1U4+LvlAOZgzCaE4sOiA3mjoXdbOXHHbnt/vzFCvTDCmQ9MCjGQ1H3RY=
X-Google-Smtp-Source: AGHT+IG/nqTTOwQfXe2tKerJxpBXR+GKZ4ab+GuQzTv0EBBAIn/L0gzKbUC3pLyBBeAw374/WnlvnAcl3JF9YpuJT74s/yM6a3Ik
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b21:b0:477:3040:5856 with SMTP id
 fm33-20020a0566382b2100b0047730405856mr311449jab.0.1710602403066; Sat, 16 Mar
 2024 08:20:03 -0700 (PDT)
Date: Sat, 16 Mar 2024 08:20:03 -0700
In-Reply-To: <8e639192-cb6b-40c3-9892-db0ac0cbae52@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000964cf40613c8a85f@google.com>
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_sendrecv_fail
From: syzbot <syzbot+f8e9a371388aa62ecab4@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f8e9a371388aa62ecab4@syzkaller.appspotmail.com

Tested on:

commit:         c9285260 io_uring/net: ensure async prep handlers alwa..
git tree:       git://git.kernel.dk/linux.git io_uring-6.9
console output: https://syzkaller.appspot.com/x/log.txt?x=162a6711180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a271c5dca0ff14df
dashboard link: https://syzkaller.appspot.com/bug?extid=f8e9a371388aa62ecab4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

