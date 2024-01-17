Return-Path: <linux-kernel+bounces-29169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637458309F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93CA91C21950
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F0921A0F;
	Wed, 17 Jan 2024 15:45:09 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38EC21A0C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705506309; cv=none; b=rrPKQ/3KFwCnEPGiK0/R+8DKFP8N/gxgiLWOIL8Co1ooA4lvnsPDvNqtxlikO6waT/yzQkXRhTLHgOpbh/JopBYNbVRcASTOxcek3eBeT9bDUpBfteY6B+koSprzMAKSbXsVCyti1bs03sBBd6MeXG2NOCLcwavfLRdWZxOTHtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705506309; c=relaxed/simple;
	bh=fRfIfB275i6tbdA5GzDC+PKs467tlGzzsVCQ7WQHn4M=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=NP3D2RlYnYL1JF+hecrpETrzyf2xo9A7pgrehuCmxSsgDUEQ+4UvnWl7ZGgexyDf50bqqqJ9FMsUJCFN8suPCbrDCdRfFt46+Qu4cMMNcNiU4D61vu79d4LzhlGkajormUUqA6CfqoFyefG+aavlnthf189racpCCF+GSCLXFQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3618e0060d1so12927285ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:45:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705506307; x=1706111107;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnzSZvHffCKHfFrIDjf0t4Z+bI+RUL9lfT0kZL9cMH8=;
        b=KMwkQNkzvhi3qxGJiZnigand5TiZUGLRinE+viXPbC1FSWgNhjrUWP3r7ofqNXia+e
         iEu3wlg/UJ51WplGMwjYT7EgPso8q/AR1w7kGOwhvUfi37eImU/QQmFap1r8evxeONMN
         agwIt1JYpyWHsN7LUkhpJ/SZJYajE9U6bMK0aAYEwjDtEqTbdb35MOKfkplJ0E7mSJW6
         dIEckGtpQ8NA820s3aimR6gJ4eLAg2sT3O/WKrXSoIhPHON0QJF+Hf4humnMAwAS7eGa
         sMRpT247Ubv4pgWQg6hZDTZoruZWOcUnxUkIFFotR64SDcGEiBP2MOhFQjSobv2bHU9B
         Lr3A==
X-Gm-Message-State: AOJu0YyycEMnuYANBJo/RBbnhGYcW1TmuVyJ064//olH4ePiEwyEjiV7
	xOmSfU8AbMZFsaWYHpfnn19juvFd6KVJS0m1GqphYCB+du4l
X-Google-Smtp-Source: AGHT+IEHwp2hpT3E9epLxabct7NyFU5ltsKSnDZZxzN5wpx4Cpjqcqc/8T25g25kKwor1m71AYCu8tCu/wCXyCVlNf6cyHxS+RhW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ce:b0:360:7c34:ffa7 with SMTP id
 i14-20020a056e0212ce00b003607c34ffa7mr1284200ilm.1.1705506307119; Wed, 17 Jan
 2024 07:45:07 -0800 (PST)
Date: Wed, 17 Jan 2024 07:45:07 -0800
In-Reply-To: <tencent_891761177606DD73662373096203B5C44305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000992331060f2621c9@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in btintel_read_version
From: syzbot <syzbot+830d9e3fa61968246abd@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git on commit 943b9f0ab2cf: failed to run ["git" "fetch" "--force" "--tags" "fc608f7504e8b3e110eb6e7b798cef357818c5e1" "943b9f0ab2cf"]: exit status 128
fatal: couldn't find remote ref 943b9f0ab2cf



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 943b9f0ab2cf
kernel config:  https://syzkaller.appspot.com/x/.config?x=12af1d067b6a6d19
dashboard link: https://syzkaller.appspot.com/bug?extid=830d9e3fa61968246abd
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10f9e90be80000


