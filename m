Return-Path: <linux-kernel+bounces-43547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D502984155C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD3BFB23238
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F39F15956C;
	Mon, 29 Jan 2024 22:07:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62E83C463
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706566027; cv=none; b=BoDIDyKAdLOLI/sGMsr/FXptuSetQOZ6HLMLi0fKaS5Fgog6l9LUhsJaaCG1rMa59OOt4P7GEazUqJXZy9LeYotEdSJNLOpo4MYBVKmIgu5ASFfUpIOU28MLdDNnYaUR7yF4oQyoLH2F+bY9YNfd84qK4y86j8Jl6+UWT8miMJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706566027; c=relaxed/simple;
	bh=euiU8terl0EWpgqFQ5bL3X18nbX+ON45QTpVACbbAjE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jIKNLmgu3P3dVYJ4yr6bPBVMq4uGRsnVK31LsrYtriCOjBNeS0N7tFeA5pHgVT9v+YslHl40+C0HtDA3ZSPJ217LDBLRXnKX9UHjxwPRSstI3qSF6+ybelJxWp2U71R4seSOuRzXpA1nH3WIzFzyHntN/um3fmwFZXAJA0Kbe6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bffd174992so63805339f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706566025; x=1707170825;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LaawQ/30rYEp7t57BKkjQDVYrmgcFT0eTG0oi7N4Mk=;
        b=GIjpAcdys7Y9rloLMzzkM93ayBAyudH1QwIE2Af23i6ejjvF5KiyASPDC/IhtfSWVR
         s/vj3CEqDkr+ma04eUugjErOZ9c4WAdx+fLhX/4Z809/EmJX8QNhcquXEKhkhl0SG4Gc
         RZI/7jTv0MsWacuETrzK7dHixuhqdnnrbxNYdSmjzCxJBiVXYcVchPerF1/eoMajOATa
         NQWxjh5Z+vrkuEStSZ0VWc5S/2WzkKznVXwUkoKn8grH7amwUgBQJztN7kflPsDH0QWH
         as/LQlA7B9nloE59QnpHuRbgPB6akaBvWPOHEtVnO2S1RzOOJLpdQG/4TtaoUPUEpmxc
         E4uw==
X-Gm-Message-State: AOJu0YxoagPM2U7bvpFzbgEbva6AqWvI7pjNuYgrkg74FRSwiUoFQt4G
	oJGsXMZz48F2vz7WsG9nVZDUnLhn3/exWYn2f2eHD+jn3iCyzTWSAGUj1xI4nJIA47IKiUVk1gn
	6cEJUuA2sF9SrAaD8D6YvBoedvc/xZaK5j50h++DUSjozcQ7lPa7P5c+hxA==
X-Google-Smtp-Source: AGHT+IF55UGDYPROeqY5ZA2WleSzpQX1y4+WvsjuGJsTymzzNaZ+GZ9IS/VP1IBuEM2wlwvWQ9On3snuoWCSUE1NjXf/0MWSzUZp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:e307:0:b0:7bf:1f3:3f42 with SMTP id
 u7-20020a6be307000000b007bf01f33f42mr76105ioc.3.1706566024870; Mon, 29 Jan
 2024 14:07:04 -0800 (PST)
Date: Mon, 29 Jan 2024 14:07:04 -0800
In-Reply-To: <990fd3ca-fdb6-4e8e-96ae-b7e939060d7b@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2c04006101cdd70@google.com>
Subject: Re: [syzbot] [net?] WARNING in ip6_route_info_create
From: syzbot <syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, sinquersw@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git@github.com:ThinkerYzu/linux.git/fix-gc-uaf: failed to run ["git" "fetch" "--force" "7f85d17015ba166311ead463ef566bfcdfcee3b7" "fix-gc-uaf"]: exit status 128
Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.



Tested on:

commit:         [unknown 
git tree:       git@github.com:ThinkerYzu/linux.git fix-gc-uaf
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
dashboard link: https://syzkaller.appspot.com/bug?extid=c15aa445274af8674f41
compiler:       

Note: no patches were applied.

