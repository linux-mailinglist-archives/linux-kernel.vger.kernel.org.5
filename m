Return-Path: <linux-kernel+bounces-163453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 400758B6B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 795C5B21AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D10D3A8CB;
	Tue, 30 Apr 2024 07:12:30 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B332C184
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461150; cv=none; b=UJHYa7npUXYQk4AaD+pJrR002hbclusf1gavQ4axZs5xHYyTrr0QNJabXOaI+1Ix01DP5MtRUhvU+fAkA5gNUhjoQkkyBNclSKUjBcAePWXA2GmLADZvu0XXeREGqjA0XLIsx1pNg7rm0Q8eRbG8TM6390vLIMj7AgaCPlcpjNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461150; c=relaxed/simple;
	bh=8kOIIkTnsdnSonUhLv9/UaA+zad7K0ZVq0aEzCL8TUQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=T26HjBqx/IOIOq5oBuqOGvBkgNB/6PYH68h2N/TNKPtwfDHtkAgPZ618miqHKphcbjprf3yHrEsO4riCvK7gI7LdptTdovJmtE5D0o3r4OmLYEvyE3CogTCChsvIYef/KTosp3GCEe5EH92DzI6ReTvYOpMnqWfjII8usMN1CCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7da41da873bso685466139f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714461148; x=1715065948;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4bIJ2+4VC6gGGh8bBw9yymu72oC7PpvLlQwyhTnjnXY=;
        b=JD1+FnqHFsporJ9WXZP7VihcWueNadvGmK548E89mR7t9jEzh960JGfmdbTA2PTVYt
         mEI8fqf8p9O8/Tfuz/NdfxfqMxWYeCqVTc/OvtbOXcBctbrRKgafCogQy5c/HcpJvbwM
         ycaIgFXHsEUbrmv62zVTppvYOVCQXQ2TGr9bVxA6dQsdRqKmmnabJGp2bgTZlZlSwi/R
         vDoorN0+uwWzdrYTe676EqIxU5czDOu1s11JzxtweMBWbWrfMrMxADrcpFrjcBzEcMKd
         VNXnuAvWxHJ3ZCBAvMYNZ/4dF7D6j7cVxvXVmarQXvMfprJBza/QjOzGNqoZmsBPsfm8
         7NxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Xq4iLm78vpifnkrnhyH+SAyrQ/9ZJKD1sj3Ar+AP0BhgOXByRN6IJ7OWxGaucbz00+WRSguEaIN1g8sPw+cCQCa6kmSzKLeRjvQT
X-Gm-Message-State: AOJu0YwQG6SNFzOOipLr+vaLLMvlvHH5XQEggaY/9vJThDsyhxAxON2d
	IwFKpcFq1TbK+f9AuGYlj7hCMTZqRBJw9E8x8npkv9gjYhkwg4JvzncwAtot36t5xFb/EDqk9dL
	/5A0r2lM0LxKl2DbmC3LjAfSXi5ExUTlwUM+8VJKMDDhEtcb9TvDAfIU=
X-Google-Smtp-Source: AGHT+IFC19oIKhGX1rlYJgjVBL1OU7Ig1NdVc43Vgmk4vIZTiGKO3wuegWsILLqMgXIqc+uAApbL2U1YHW0jZrTQd6w8v46UpXIY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:450b:b0:487:4afc:b6b with SMTP id
 bs11-20020a056638450b00b004874afc0b6bmr647191jab.4.1714461148035; Tue, 30 Apr
 2024 00:12:28 -0700 (PDT)
Date: Tue, 30 Apr 2024 00:12:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5c82b06174b1793@google.com>
Subject: [syzbot] Monthly v9fs report (Apr 2024)
From: syzbot <syzbot+liste18b65911e42aaaf2e63@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello v9fs maintainers/developers,

This is a 31-day syzbot report for the v9fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/v9fs

During the period, 0 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 28 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2768    Yes   WARNING in v9fs_fid_get_acl
                  https://syzkaller.appspot.com/bug?extid=a83dc51a78f0f4cf20da
<2> 6       No    WARNING: refcount bug in p9_req_put (3)
                  https://syzkaller.appspot.com/bug?extid=d99d2414db66171fccbb
<3> 5       Yes   KMSAN: uninit-value in p9_client_rpc (2)
                  https://syzkaller.appspot.com/bug?extid=ff14db38f56329ef68df

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

