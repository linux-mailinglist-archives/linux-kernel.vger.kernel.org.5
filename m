Return-Path: <linux-kernel+bounces-56426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0FA84CA02
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9611C25F8B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1042562C;
	Wed,  7 Feb 2024 11:55:10 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6F625601
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306909; cv=none; b=bfr5vIawUddqoKW733evZzy4Kbv//Ne/eiEbg07jHfWZKn0eV22l8DbWdGsAEzRXkO6YIXlPS6Ho7rZuhsnkJ8v0prGYVIlStzZqhWeXtL2AFTotVT3AHR3+xvkeyE9+zKvWjbf8jKMYU06THfRcFXCI9H/fWY3/2qj9iNDUFWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306909; c=relaxed/simple;
	bh=WFvfFlWD/8IMy2/dJpwf56GaEP2C8M7/8q4Wp+kAr/Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eNhqcabfPqZ9AgdKIjlgT+EC9NbcfcDXnNfRXnIt1Si0OuQHlF34271C2W/TA3thhp5OauaktbOCjUWOon11G49ioVLmmmM2tUoW5xNanjXCmA7A9D1hEh5UGW+zbSk3bFKIIm/qeGo7o9qNKOroc36gMeSJriY5YFJxCWv5p5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bad62322f0so54101639f.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 03:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707306907; x=1707911707;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndjlTd4J/Wiv6hu/2/S5v5NylWcxXzlMvklSePCITWM=;
        b=BRZUj4C8TPm3vaQXXaNRYuesqlys7VArTAoYtlLIG+ebNVFWaUUn/+39CMFoh+d/7k
         3CRjtdItVThKiib3dyThGXl45xZhX6ri5QEp0Bii0gSkhpNvw+xLvV+F90idnLgqamOZ
         2MzguoEjO/L5BNfXuA1auBf7WGMncbVfWu0j3wceptmkZPvO09/vctuDYw5gBf4zH1HN
         fv53hud2+IXRVMTwM6CFyWcmTbs8It5143uMt01Icvn06z86Zwe80iwdbBfdtDKUIv5+
         b5nfctsBxaP8bDoHluZNWtx2mLPAom9WzJZ0irAr0DXuhldzBWeThwr+FdEGzWBe+55p
         u1oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg0wv2d/BC6Akx1bFfaysRrkCwdf9XrlZjgi4gWc3xjyaBW7wg2/abLNBzZIG91lOqAryY7+n4WXeHKc7FGN4lUrN4qIoWKxXh3mhE
X-Gm-Message-State: AOJu0YxvmZ5qjUzp6brJO3Oryy2otkgPgx0gyV+865afHMC5eA3eWy4q
	8zDlpuce8grt2LSHAgdiUQqKVDWAN7hI2+pqw5iaV0MnWvxdnB7pMORbghCu/V3mWgZHPsKi7lt
	C2+ez7xX8IvibjcGuIC4ksv8u++JgAO20HyapPuFTLRMkiTs/9ny7dmQ=
X-Google-Smtp-Source: AGHT+IFwVUOLoT/aBZEgX3b3Ox7dnqNqr133m63zsEKoNHPbbWV4HZOHoE785FMSpEhLgDnC/LSsd4qconW9yJaHb2ujjnB2MXVN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1585:b0:7c0:23fe:cd9d with SMTP id
 e5-20020a056602158500b007c023fecd9dmr136527iow.1.1707306907492; Wed, 07 Feb
 2024 03:55:07 -0800 (PST)
Date: Wed, 07 Feb 2024 03:55:07 -0800
In-Reply-To: <20240207114459.1057-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be665b0610c95dec@google.com>
Subject: Re: [syzbot] [xfs?] INFO: task hung in xfs_inodegc_flush
From: syzbot <syzbot+0260338e3eff65854d1f@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git on commit 076d56d74f17: failed to run ["git" "fetch" "--force" "--tags" "fc608f7504e8b3e110eb6e7b798cef357818c5e1" "076d56d74f17"]: exit status 128
fatal: couldn't find remote ref 076d56d74f17



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 076d56d74f17
kernel config:  https://syzkaller.appspot.com/x/.config?x=428086ff1c010d9f
dashboard link: https://syzkaller.appspot.com/bug?extid=0260338e3eff65854d1f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b53360180000


