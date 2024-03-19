Return-Path: <linux-kernel+bounces-107078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CC987F743
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A131F22656
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FFC7BB1E;
	Tue, 19 Mar 2024 06:26:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBB34594E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829564; cv=none; b=upG3DOM6HhkgjK6p0HWbhhSONPUcKQDrYMeNeF4SIc5ubLQjPqp0QDZMveO2R+9j3yN1F0PU2Y1GTYnM3AaCtigLw5/ECtb3CXSkqg2iPGWOvjNchompibO/424h7hWnnE5qUtW2t8w458vs2no7eGBpsCB2o2ml+A90/Ta1evY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829564; c=relaxed/simple;
	bh=Vdnf5nY/czOnJuaGBtdc0SPAtrzeEIXDsmcxSs4q/hk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qR36gZrHF4Ft4QCNu6pTxhtc0jRDmgU3/M5qMlKyhhRLWUkqBNQ+BkL+8ff0vc/AnQAs0NPiRk3h3FYtjikebDiW+Fs3zqEykDpdIY/fYONzKR7SShveVb2W+K2lpVS6nvK1VtBn71gJ7WulM2AuXn2gQ/+pr2gkNdGdyJjydAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c874fb29a3so364266739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710829562; x=1711434362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGyIYPow4NlrefKnKPQPE6bAcLRxnsVwIJ5cTlLJan8=;
        b=lCHoVmjCjEoFbfpoNkep7aCsoXXEjqePM7hINFlbtciCXj4sphH1yu7tzt3MMnH6Zi
         L/nYas3hFahFnxNLr+HI15Uy31db58dgob4P40kav6ZsBuT7e/QPDzfN6ECDQvdb6rIz
         anM2T9C9/iiEON1Yvh3R7nOXgZtQUHZXxjrhO4sGGS56rft2J6nAWhS+hXPgbaQk58+N
         JiNEy4hhFBZ7w0a0/OHehv+zJS/rOELv5AlretG5zZtCDE07pQoMv5SSF7nQXA9XTWO9
         De+YYrGPJ1Y74k4i/qMmMUMfOVmEUysRmZfsM5iUHmJGxm3bywgyaY2A94vJ//KGSq1R
         qS/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8XTXXV6xxTQY8dca/mswPHrnv603ZDZvSFwwPItYlNARp5J+gEteu29wbdur2l4h90Scs2zGyJxPokZweZ69epNN0nlndT8rcU+bP
X-Gm-Message-State: AOJu0Yzow07aD+Jj/hhNdZOqFpscXUKR5ItaA059XZS5abzOHzNcNb+Y
	BhVSwZ5VczcofdkbUGhz4epoF0+pnrgsYATvUotsacIEzT9J4qkm10WI8vBfmcmVS7/LAT7oEQw
	Ys+Tr8lEyKbqn4OFOsr/9TtyajCW2rO+d75Y2emUxZW9Re4/J1SkCv7Q=
X-Google-Smtp-Source: AGHT+IE2QD0gDlbEx3Hy3y/Bkl9ZHnqqTTwLra5wel1Aa+fBhvD4Qk670jJxAR1r48q58RoFOTHF+8ak7zpqJ97cuZoc/2yby5Dw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c7:b0:366:b696:e943 with SMTP id
 r7-20020a056e0219c700b00366b696e943mr559353ill.5.1710829562024; Mon, 18 Mar
 2024 23:26:02 -0700 (PDT)
Date: Mon, 18 Mar 2024 23:26:02 -0700
In-Reply-To: <ec51cc1d-beaa-4aa1-a54d-e503223dd365@posteo.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050e6310613fd8ccd@google.com>
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in v9fs_evict_inode
From: syzbot <syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, charmitro@posteo.net, ericvh@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/9p/vfs_inode.c
patch: **** unexpected end of file in patch



Tested on:

commit:         b3603fcb Merge tag 'dlm-6.9' of git://git.kernel.org/p..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=48bb382b96e7eda7
dashboard link: https://syzkaller.appspot.com/bug?extid=eb83fe1cce5833cd66a0
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13a5fe81180000


