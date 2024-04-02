Return-Path: <linux-kernel+bounces-127427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00BF894B29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508761F22539
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE821C683;
	Tue,  2 Apr 2024 06:15:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ACE19BBA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712038505; cv=none; b=G6om3Es5eIihVCarhpyQAo8WZrvhXWXhSmtrYm6+v9CUHGt3L/KUlOty2l5+ZZQ3mu+JSWmz8w6tJMbjN8siCfZg6HxJpWJGAP1uFrzM8+516rHEfQOGszWP+qzSng+68ZSDJFo+/tAlrW7ovZmUAx3MvJq44j8L5BIDgk2Jpjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712038505; c=relaxed/simple;
	bh=3YNS8+ykmIEecFhewogOz1dmLXuPDQhzStbI/IWLiWc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YjFZ69HVp1rcwdWH9wlT7v23u1Rf1/52yxEgMT12peRYkpjDhHvyneY5l7uatlmLebSpxKnlDgiX+dFDXgMWqvCcoSQ9biVKAcAu98WJpVdvj0qw+tyA9Lbl636GuZU3MTbmjT8zcEqCgqS3WEsePFZYofg6L0tgI9JFWrnJ+S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbef888187so488502639f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 23:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712038503; x=1712643303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6UFWp4FuxnTr/2M14mTu9k8f3Em6EGv16/Tnq0QyFpc=;
        b=hS3uMY3ZXu/GpvmcMUo69jGeDMvhA5ejLWUiejdXj+OGVFoRc2i6dv5qxwKhiuuxUu
         Ub+Bv4U60P7Mds4p3wmTAhWbSyl7FBq8jCMZUMBZ+P+yNKk+qHOIOZ60IQSvJQsoGGBo
         Jn8jJrh7/Y5ftUzFWV2JC1UAMXmUGoy4oT9l8c/lHHzuEjZLh5daI5eVquQcQP8W604W
         ft1D1G2ty0BIFlYHDk42GqQhUmkuj1/EARjXBUNGnOhS6Hz027lEtenEGqi0LmSe5kmW
         TVkky5tFQNSZM9xnHCw1TVwsIbkYYX9WIS6BHid9vWKOOu+/FFpmjrCKpmN/wfOWDMG8
         73uQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6mMJJyFVGk9FtNH8b0OT1FKJwtlZ7bMng02uL1NYMKXG60cLccZCn4XHoZivQ/cbpyyJ2FXgLobcD1vIhFKnfip5+jZexFoYilGES
X-Gm-Message-State: AOJu0YwXF2db8U2sgEjOnZroTRSgJzzdMw7snQxRzNyuOfSJtnfE/yiq
	gUbc/D7rlszjlFJQnJTJPgoGCwqVXZxnhX13Yoe33AmuXdQuP17/5Q3mmojjQACVsaMSAksZPnP
	g7yr7X1JmRVsJ92A+H7Vq8+AqxrKA2BqG7TjPl30wuVrLp4DSnPHyceg=
X-Google-Smtp-Source: AGHT+IEZlelYUHWUm7SitrZcCNT4BOy+cxK9vpwOM7ErB1k/AoV2Z/ANxfKvzMC4X008n2s6vEw06UCdqqwuC7CGrfKVh8QJVYJu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:60c6:b0:7cc:ce74:4293 with SMTP id
 ft6-20020a05660260c600b007ccce744293mr618506iob.0.1712038503400; Mon, 01 Apr
 2024 23:15:03 -0700 (PDT)
Date: Mon, 01 Apr 2024 23:15:03 -0700
In-Reply-To: <tencent_1F326FF82C456F509544E992ECBECE087A0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d653450615170654@google.com>
Subject: Re: [syzbot] [mtd?] WARNING: zero-size vmalloc in ubi_read_volume_table
From: syzbot <syzbot+f516089d7815b10197c9@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/mtd/ubi/vtbl.c
Hunk #1 FAILED at 791.
1 out of 1 hunk FAILED



Tested on:

commit:         026e680b Merge tag 'pwm/for-6.9-rc3-fixes' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=f516089d7815b10197c9
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1084f5c3180000


