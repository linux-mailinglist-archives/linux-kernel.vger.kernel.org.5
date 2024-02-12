Return-Path: <linux-kernel+bounces-61505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 184AF8512FD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9924E281C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EC63C46C;
	Mon, 12 Feb 2024 12:02:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93513BB53
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739324; cv=none; b=HoDT/Tjd4haL2w+m/Paye7zH0+arqhlu9C6ezYpb7xOZjdp8sSs3jKs8WcX8ldp6mp7VSDkGfbPWNQ5OC3conA6/OrFY3LElkwPd2+rD1WHzosa3OMEvMpnec+i6ll8fI/zJFyk1F/i3v3GLtkBnyFI2H+fBzH7wsc3i1rsSFzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739324; c=relaxed/simple;
	bh=PIaPwW0UwPdOGWkHIoTGwTsL6fbqsTt5Utd4tbrj8sQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tc9tOoLfZbsSdpJg9/WDXH6HKJFs+hHsMkzTpo5PfGcwG1p6p4huK+SNgO5Oav8aQhAZoAtvrzFrmK4nsO/6fxFEatacm3RNwAnix7cfTW9WET7QsaHwSr51tW8X3iIQY5Kiu/9OkPOjHWJFtmU/h4Gi/dIy+LbxX2otjGUG43Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c064b035acso239860339f.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 04:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707739322; x=1708344122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLUFqJUUCUHl1oVTrSfdDrjpp0Ws316qkyNpeMA1VKE=;
        b=iFUynVEIMQzQKiUSLSWpcWwaIyEK4an6Z+CgVUVIphr0TAN0nUH4/b/uy8qujqv1PM
         yw+EQFoI5Gcvl0GAbA7FlXeMQzpi9Q5iopHwwiUJeIXip81gqk/YrCYvrTIDFI0Bykac
         jvYQu1qCCd0niWh7hoX5DBhmRIPouFGmHUtRBLplTqtvayTLGAKtm7D8EhyXhzqRyFHj
         MbrhjcaBIppdHnZoNjkZNC3DnHH++03EWGnEK03sntFxlFMlmQZN5P1UXHToYvycZyS0
         wT4PbQS6two+iVGIDBvVOwqQL4h6vYf/OzeNGEHDYeq6EgVr8eVL3iLN2DiKUFqYCLWI
         G2ZQ==
X-Gm-Message-State: AOJu0YwpJW0hm/CH09JsPvywkAs5Pcnlbil6QH+K9fDVHnRdqYyn3MKM
	LsLz34xDhOm4mQqZG8v7lf0jhOXdflEU6+6eMDYuQZfm/YDwgBOQkcLbhkO1qNEA00WXh9s7rA3
	KlXfuF/s8+U7fULauEi036xwVEkPJHRujaWjMHFdLefykoBZyzjOOsss=
X-Google-Smtp-Source: AGHT+IHXNYJgEF/AkDrtNb4kEIJByyoDwS+sF0q5AaLNeXuHqiIVd7G2w0RQ/jasVfBEFBbzDTRHIZoeDChkMqb1iXDan+dzO6sS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2162:b0:363:cc38:db1c with SMTP id
 s2-20020a056e02216200b00363cc38db1cmr474241ilv.6.1707739322012; Mon, 12 Feb
 2024 04:02:02 -0800 (PST)
Date: Mon, 12 Feb 2024 04:02:01 -0800
In-Reply-To: <000000000000587e0f06112cd973@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8616906112e0b4b@google.com>
Subject: Re: [syzbot] [dri?] divide error in drm_mode_convert_to_umode
From: syzbot <syzbot+0d7a3627fb6a42cf0863@syzkaller.appspotmail.com>
To: airlied@gmail.com, airlied@linux.ie, daniel.vetter@ffwll.ch, 
	daniel.vetter@intel.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
	melissa.srw@gmail.com, mripard@kernel.org, syzkaller-bugs@googlegroups.com, 
	tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit ea40d7857d5250e5400f38c69ef9e17321e9c4a2
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri Oct 9 23:21:56 2020 +0000

    drm/vkms: fbdev emulation support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14426df4180000
start commit:   445a555e0623 Add linux-next specific files for 20240209
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16426df4180000
console output: https://syzkaller.appspot.com/x/log.txt?x=12426df4180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85aa3388229f9ea9
dashboard link: https://syzkaller.appspot.com/bug?extid=0d7a3627fb6a42cf0863
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d4bd48180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106ae642180000

Reported-by: syzbot+0d7a3627fb6a42cf0863@syzkaller.appspotmail.com
Fixes: ea40d7857d52 ("drm/vkms: fbdev emulation support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

