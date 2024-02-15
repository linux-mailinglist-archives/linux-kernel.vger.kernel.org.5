Return-Path: <linux-kernel+bounces-66820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A93C8561DF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7DE1C23563
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B3B12B175;
	Thu, 15 Feb 2024 11:38:56 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE753369
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997136; cv=none; b=c5qyxKIqQDyjpsKSP8Pqw6SJghZBF4VANnulHOkCLggyWI1PewfG38Gf6QNv9PbQldZFjtntnSMuBHap/vEGs/ggF9VvGTmIkLtT/w8kiI5xpNJURVTEq6SylxZf6rusB+El4fPFeu+8Zn/Nbdsih1x6Z39s2iq3X/7KedxT1mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997136; c=relaxed/simple;
	bh=JMS8w2LKUm2OkHxaNoNm28yGSgofhi5bz3L5iXGnqfM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IY/E5nm/xCAUyrWVtAqCgp6cIPNNaYDCvGywPolDaTmWd3NpPv5iztYpFGnH15Qjp7ldVhVMHJV16zPcdA9afMuCyIpVODKROhfZzBexGyr2e1Yx7Of5Exog/qeT0CwxhZT/t05EhEEw1ylxRUtsZuR9mRhpZv2GypwEmq6PgYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bff2d672a5so50450839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 03:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707997133; x=1708601933;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JMS8w2LKUm2OkHxaNoNm28yGSgofhi5bz3L5iXGnqfM=;
        b=W5SAO+PH+Jv5IivWASbwEr6VBVVTQhUxXi0+OTNfoidMQddkEOioWQwnJ5EOllCpOa
         vulca2hMx4Ayrvn1xBP2SYcgtTTdPOglCj/ESIUVatlRqUwgjqoypm5lts9XT1HPdhG3
         U/vbVwIXHWm5nIGuZ0RVqYTQBpqD7fapqSCLOMTAv7eHQYsH0ZxrhveLIhUEkjFDzEoF
         aZQuwBYwdfeoZibMnDA+Az6ZoedKHhRRayAw5qTOhU+0uTQbLBLW53deRy5R1wApo97M
         5WqavEl53G7r7u5RjHIWjFqMm7GIEYX8QqNCix6PDs46WCOI77vT0hOkafHZ++j3mWUT
         dXPQ==
X-Gm-Message-State: AOJu0YxGm2f7ZwUN97joGfDsdrEpqYdM6ZRVZsJ26YrOxinxo4T+Z6fM
	mLmmWqkBFUxp4fK02Q3Dq6+wIhsXeZrEpcHnMcEp9OnX89ZKZNzIPrjoakDymLVdyjhPoUoCGey
	AU20H0jK0e3fC+lBe0P+r9uJl3aVrpAI4cfwgz00hYE4RvWsXdpCvF4198Q==
X-Google-Smtp-Source: AGHT+IE7rQ6mzK+MQsvZK3qB30fRyj+VrV1rqN3d68jaEc4jVWfqse/WiwsZwfnSAXxQcLIUvZHD4eFstcn2w3hL65y6MKcEpKkg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4387:b0:473:da99:924a with SMTP id
 bo7-20020a056638438700b00473da99924amr12887jab.1.1707997133659; Thu, 15 Feb
 2024 03:38:53 -0800 (PST)
Date: Thu, 15 Feb 2024 03:38:53 -0800
In-Reply-To: <000000000000d42dae0611477922@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006de55606116a12b1@google.com>
Subject: Re: [syzbot] Re: WARNING: ODEBUG bug in ip_set_free
From: syzbot <syzbot+ebbab3e04c88fa141e6b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: WARNING: ODEBUG bug in ip_set_free
Author: fw@strlen.de

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

