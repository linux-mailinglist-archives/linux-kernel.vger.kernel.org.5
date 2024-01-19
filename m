Return-Path: <linux-kernel+bounces-31068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0512A832843
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364AA1C2297D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4764C604;
	Fri, 19 Jan 2024 11:04:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663D53C499
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662244; cv=none; b=FXosRNaxyrhIQIskPzFXpxDqSDLFXueqfIxAq+T+dmvVVlU/7sVKjfrlmyPz14bmlb8rQTA876PFctnX9vYDet21ikYXzscoLX5y78ribN7IoVUWTfSi7idCj8sif570tLAPRtcob85iwssy+gkT++QW2rF9t15vTU9zUmAZkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662244; c=relaxed/simple;
	bh=IF/Rdlrjllh8QV/PUzrMwYrGi6xbVZIT9IwYV2AAntU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pjdGYeiPBA/LPaAgaNH9CylEHHE943GQlN3MHloHa++EUYI2VY6mX+pp2sC+AswM8GJqw2s2BOpPOQvVgjTDZezNAVGbOA7Ap9nT3FWUzUcgzhW5+sCGa0uZhPZ+FVhZtGgpTaGUEGZ3gAVtDZjUzXCpNk0kcShh87gP1NH6IK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bf2a5cd631so83518939f.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 03:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705662242; x=1706267042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOtvIsf9ONM/3dDPhEij7SYWNFyY5phEsz4MSqai1n0=;
        b=qfwveKSYGbyWTQraY8Ms48Uf6/wWvObNvylTcni020gZedP8rvwhzBlF6v3qZYF8z+
         hEO00+3dL1bvyLBGNZECWNPYH0X2+8c8E/OR5fAovxSDKB5YjTcEs+ZHvocHFybvswsC
         UzKVq4rUA4ejXFl7OO0x2VfQGelThYXS+9wZUdKzYMc/inb1fO9bYEjKgpnn9G6kcunc
         Tbx6RJ5ISRNqs93ojMtPy35rwDdzFa/1HgL+L8q97GFbxpTefG+g8hoTkTGI4BYp0+Ka
         rzocnRlsOvKMzeU97DxADQXiCBBbumtHADfO8CUFUq2RXTPKf4gTCt5lKovg7yOLmPfz
         MYHg==
X-Gm-Message-State: AOJu0Yz4LLFeWb1gmx9MAKQHkSi68BIg/0Ztnj9xRR1lMOYfF5d3z5zJ
	WgNU7YPDc+poZ0u2REKwfr7jcvMz4kATSoBhGXW7r90bTN8J4lDRpiNInWPqKPFUgYvYvWWC8z6
	PIonw1kxTAti6h/ebigGnE7GslTIH4rrs0iNGYswNElFQm7tb27zCpG4=
X-Google-Smtp-Source: AGHT+IHkC02YIb7UAr9lOtTJxcbJydZGSWnFwflcqCDXH0WO+28lddqWBJidlqX0g/rdd0vtVjksdXFRGIKIxGoCrCmlBEybfx/E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3410:b0:7ba:9bc1:1fe0 with SMTP id
 n16-20020a056602341000b007ba9bc11fe0mr109222ioz.1.1705662242621; Fri, 19 Jan
 2024 03:04:02 -0800 (PST)
Date: Fri, 19 Jan 2024 03:04:02 -0800
In-Reply-To: <tencent_1B2ECE8078726E5C2D856C0497A0E80EED0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000141046060f4a7031@google.com>
Subject: Re: [syzbot] [exfat?] kernel BUG in iov_iter_revert
From: syzbot <syzbot+fd404f6b03a58e8bc403@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git on commit 052d534373b7: failed to run ["git" "fetch" "--force" "--tags" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "052d534373b7"]: exit status 128
fatal: couldn't find remote ref 052d534373b7



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 052d534373b7
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c8840a4a09eab8
dashboard link: https://syzkaller.appspot.com/bug?extid=fd404f6b03a58e8bc403
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147423afe80000


