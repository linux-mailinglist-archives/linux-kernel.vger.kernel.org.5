Return-Path: <linux-kernel+bounces-28401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F0B82FE17
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABE21F2661A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A4046B5;
	Wed, 17 Jan 2024 00:48:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973242904
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 00:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705452486; cv=none; b=ph0bHLJxefrUzrorDBTSAx7ac9BfIdgf8aUw3wxd/O8BDy2ScABBX+aVe4JvITJOeOvt3NcO5hTCMrbCCoxYqhDH+JY4uY0CJY+LdRbThmlvvPbSJP2YA3fBEp6uHfa0cUBbHZEcvgfJ6byGPCY4X/+JSYv8pAoQ9PjBQdQFsBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705452486; c=relaxed/simple;
	bh=AAf/I4I42rLMBWEVS3mffH9UrtbgCWfulkA5r6p8F0g=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=nynvQaPpOz3oaoC5qSAuChShKnY4yBhKeETBeBt4kZUxWhd2YOEvduZqk+zzUK+1Gz0NL+YWJFcfPTaZ9iXZd1a2F6ZVAoQvSq4KaRWJcBIzbpM9vivNlEe2+GiXugNq5IHOp1etZahBwwA3GiAs3vvvakRapK63UGd+PASdiY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3618c6a7a0fso8382395ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 16:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705452484; x=1706057284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzIe28wbwr/i91YfIe1SnCMYHz0m9HJdrPMgOmh1W7s=;
        b=oQLp3sW6vpC6J/BzuRad2Cu8X2C6D0rxZxRQrIgcQyzeZ4TyO8kqp22sk8RXnItvZg
         ouCoUQxsTFpaUARhAJ2PAcrdVzIiReVcbJsj6zem2iuv8wxON39IZ2GlNoWDtvZfjyCc
         Oa/86qqDl/nmBGm09i2v0Uh5mxiX8hJWj4k+HBF0eitmcX/V/w3okVX3PS67mZT6+vP6
         578RwRbmhizvQI9T1FVace1k+NStxWTijxxnNdG4uuX38wmB10XupX90XnK5ikbq6P4g
         /oxhBN130o2QqaY8ey/BqNNGgB3q9iJui7t8N791BUCNINK8Z32HIjhJBxxAHwo3VLba
         fiNw==
X-Gm-Message-State: AOJu0Yw88cQRrhB6cRDhLHNQ5gF8eK7ZISKJMt9FE7gMG0D1qdbv220e
	+dZcG2LWxdwsEErzbkJ3hH+2X/TlQZLw+QLTVqAMZpkf8Ovd
X-Google-Smtp-Source: AGHT+IHZVgMumbYxDDuWNDkufYNSG2RSuuRZw5AZC5yXzVcZyTrEb3BR3h9XXdNCm2Cw3PsN4qPkDImjOvsVezYDvFpng64qP0vK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:35f:db4b:69dd with SMTP id
 s7-20020a056e021a0700b0035fdb4b69ddmr837348ild.0.1705452484751; Tue, 16 Jan
 2024 16:48:04 -0800 (PST)
Date: Tue, 16 Jan 2024 16:48:04 -0800
In-Reply-To: <0000000000007caa3f06014cad2e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088f73f060f1999fa@google.com>
Subject: Re: [syzbot] [gfs2?] BUG: sleeping function called from invalid
 context in gfs2_make_fs_ro
From: syzbot <syzbot+60369f4775c014dd1804@syzkaller.appspotmail.com>
To: agruenba@redhat.com, axboe@kernel.dk, brauner@kernel.org, 
	cluster-devel@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126262dbe80000
start commit:   46670259519f Merge tag 'for-6.5-rc2-tag' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4
dashboard link: https://syzkaller.appspot.com/bug?extid=60369f4775c014dd1804
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1602904ea80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d67e9ea80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

