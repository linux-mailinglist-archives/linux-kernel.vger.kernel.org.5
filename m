Return-Path: <linux-kernel+bounces-45204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E865B842CF0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780962880CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75A37B3E7;
	Tue, 30 Jan 2024 19:34:16 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF587B3C4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643256; cv=none; b=hXiePLI4VVCFa+FO1DdNFvKkxt7oK8x8iqby0Wd0dVldS4Wm7pi2N/sOmMmhnPKPwD9jx2j43mvs+dqs5hHoyenHi0HATql9B0WW1TJs02m5zCC4Dhf0cFyIq6Ceh+RCI1UAfUBpiU+DfhGJnZeET0GiKsOOXPp4EQIuYCPH95A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643256; c=relaxed/simple;
	bh=z3MCYUijz1PXmmrFbnYvUcWANdHMheRECQhPlEaS9Vo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pV0tT78ULMkFR04SY5UzFlpRWdPGW75PrNt9TSqhnEndPuIi6q7grO3ku5jL3rXkdCYlUdK9xxSgSLuZX/Kl486SmXvh/UN31xSYpM/mRC7O13hf1XZKA6ZtaC+tOAJ0ePnecTpm2UCwgwkSQsunulub7Tbeg/ZVSJ+A558BRuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bf36117dfbso361388939f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:34:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706643254; x=1707248054;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3MCYUijz1PXmmrFbnYvUcWANdHMheRECQhPlEaS9Vo=;
        b=hoNRmpE4QL1Fu/EJN0z+K920yB6AwuCU9sXkdFH16lR5v0yBNE8iPjhWvtnI7WZX5D
         nSVRF0uRbdCOMUNpfrXV6zhmS3uv7u1VXGoZst8IIUUZDSZQo30T+JwvCePymlVf0oZa
         1P13p4dVZDSmiEeXDeVsaJjjwQAj/4QwSzVYznPwiyUhT2aY0boQskPvmDM7KU+PQ4vp
         hOfrM3VK4HuTwmIzGedwgm8Iymi0uenH8ItwztSHKX/jBS2Qu9Dh+fn1GcHbqp53oV1f
         mfxqz7XeWIF6BVOMzF7Eh/alpbI/03b+eLJdjRel+M3ZFtK9IyVIT6TeZKBzMzdnlIz2
         lIEg==
X-Gm-Message-State: AOJu0YzAeQEoEgM0ft6jVakzGHL7UJyHCNU5ZkxkgzgD6QsA9B1SuR8H
	Qz0/hITHWGLbpAUigQneAgRICAKIR+URpIBVZZ6JwAaDPy4/HyALCWOxUeg+qZ7izoXC//lJJWp
	fQOY8cp4KLNx+D8M7JtQnsm3vn00a3QyiU5dRxmMY6QiDKtGSkSfOS2q9ww==
X-Google-Smtp-Source: AGHT+IEKoWGdC7VZyZrrcEu5cvbhrQGEJc49lsn/FgHDi33Sfh4O0fP3Smg80QiBv+I/13bSpOgXR1aEHKE8gVvuxgWVJa/6DRlH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3056:b0:7bf:4a96:b7bf with SMTP id
 p22-20020a056602305600b007bf4a96b7bfmr79967ioy.3.1706643254221; Tue, 30 Jan
 2024 11:34:14 -0800 (PST)
Date: Tue, 30 Jan 2024 11:34:14 -0800
In-Reply-To: <000000000000a654800596d61d1d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed265606102ed817@google.com>
Subject: Re: [syzbot] WARNING in bcm5974_start_traffic/usb_submit_urb
From: syzbot <syzbot+348331f63b034f89b622@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in bcm5974_start_traffic/usb_submit_urb
Author: javier.carrasco.cruz@gmail.com

#syz test

