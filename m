Return-Path: <linux-kernel+bounces-81300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5008673C1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE0828CFE2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876911F605;
	Mon, 26 Feb 2024 11:46:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AAA1D54B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947965; cv=none; b=cZDuRJJYYyKOOLjb2lXte0P0INR6X5FfE7+gLv9YNuruG/7qoWPlhRWP9wtbJp+/8Cq5q5w+KRyOQZ+JP7L/KvlvNEU+jT21B+WHzcND0KHLUWAx7YWnvAvFBvgiaSH5UoZBiw7VtyV7+eBoIo5MmmnlERn8ewFX+ikY9qKT220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947965; c=relaxed/simple;
	bh=S1DH6N129w+vMq5/UljzKNmTTX+FRMOyP1Xrb7w06Bs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JhC7C/fQXsoe4Ts0zUurCSfDLkldn2MrTmqxqvcA/fD65OuoWHK2YPem0EU3spauZvWaaNpOnj//W7ce2TEl/y7Nya9+MozIUd/WmztAmtbInbFC5XAwNKIDoW37NX0VAAP74sBQ1zPdRMekTKvtRjHcNgYnt4kZM+TZMRZaZlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3657ef5f01eso39601745ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708947963; x=1709552763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Co4mHqcajZ+TaVXtj1uAZr7j1bhwGXeKEUyHjDEeql4=;
        b=XKQRSHpU+VkyzZL0Pgq+iHIkvl0vpdlFYSNzhfMUdDFkkUdJmqL0epYcbjFDv++kqI
         NFfU9IZUEUmdMqPtirZD1HyQUM2UqoAtNJdTUfDQ0UWawzXVje8NFOhvRDNcIDzW2s+A
         WnqzYniibw6b486fnsOqy5Wu+VNkfsYI0g+QgKozATCHLRMzSU7WT3GfqXyWKIS0YHPY
         lDo3dU0fsC16hwhadZkv4ekgVxL//+xmlisuSFEWQc1r5gpU29vks3J4bAGB3D07T7uM
         jL4aolgnwWGtSEGiS1cBNAN5IRP3LPVUswSKkMzuknAcdZRX1EaO6Br7lJyH8TvdPduc
         sWqg==
X-Forwarded-Encrypted: i=1; AJvYcCW7iRhwwMMHgcEX699VJSysDT/C5CiYAA2NFa91Sa/LlWZgCH/LFg2/q95LZIK43DzPklqiMybTc2jJh6/klZlwkaAeGuOR3nTH3TtF
X-Gm-Message-State: AOJu0Yw74OJTNnY6OvczX01DzDPtn8GBV1tcsWw8ZaHrnrl6WpcTATRX
	c/V/Z0CpqsONXj1bnNsvncW4KJY83GynCspQT4H0j7S4AYPaGQKjxM8yuZhRxS9d4R8WYwEl1Qo
	07gA0eXy5NgWkZF7liFm3kmaLe5W72ifWCLqN4O7HXfTEBvNpGgR6fCc=
X-Google-Smtp-Source: AGHT+IHIVqTZZ7YCL3IN8GhgKNZ48yzHqYO4fermQmaHfAwR6BgfFyKH6DsdKtx8xrqBPkzE+Y2WHuiAXDPL2Aoeo4nERWuFkxCB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3885:b0:365:2f9d:5efc with SMTP id
 cn5-20020a056e02388500b003652f9d5efcmr328599ilb.6.1708947962903; Mon, 26 Feb
 2024 03:46:02 -0800 (PST)
Date: Mon, 26 Feb 2024 03:46:02 -0800
In-Reply-To: <20240226105506.1398-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044c2da06124774f7@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_set_state (2)
From: syzbot <syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, boqun.feng@gmail.com, 
	hdanton@sina.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git on commit 716f4aaa7b48: failed to run ["git" "fetch" "--force" "--tags" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "716f4aaa7b48"]: exit status 128
fatal: couldn't find remote ref 716f4aaa7b48



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 716f4aaa7b48
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d7c92dd8d5c7a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=c2ada45c23d98d646118
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=172e5f4a180000


