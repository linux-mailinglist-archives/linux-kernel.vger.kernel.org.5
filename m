Return-Path: <linux-kernel+bounces-71538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A9685A6D7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3111280D79
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81A93839B;
	Mon, 19 Feb 2024 15:05:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FD9381B1
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355107; cv=none; b=Qo4gACj8P400XYQi/EuqL5CeNgfyC9vrboU1xE05hWfqRZQfid5AlzbmAOL/zz3XUJnxpdqOoimpDysKHfHG7wfnJsjU+FYr20sIEAkqwvVqflyCqZUR243V8Am80WwlD96VleO7FQ3AZX3SGmHyGJbzi3LMI/3939LLbwd/uN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355107; c=relaxed/simple;
	bh=gmrF/d9fnvBujfvzzmEj2K6sNHpmgiuQK/4OQHkLnbM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JOpHG4m3/jJGJijW9Ny4jOLnW1KXHad7BxY/H2tG6zXcS3KFA9J0jWndvs4kQTGIga3Ac9uz2J3bCVYK7cGH4lR1Tcaupva5OwvPgTFVA9IPh4Z/ny7n+BDUxTkaelLJfg3KfPQ0AbB0HEZX90Fl5KnmPcfWA9+zoJy4FUG96EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c74d3ab389so82015139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708355105; x=1708959905;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DHKBFuNAT/YooSgZ/ha7+6WUrz4Zbm6cjlAajlAzOGQ=;
        b=Z9Nc3DRBe7yqI1qDMx0JBVGF74PIISZbJ7bPoHqEjPO3jxFQqvnEH/rsmwGbk+zq3E
         EWH9Y+qCPgKBD3D/unBdaL9l3XBOmrbmOEefgzQ/vsE9XdS12OVfBylb0/4z+NBEuYcR
         d9+BOln3fG3dmIXw0lVl7Jj5dVTV6rGjPkqA5Tvzl3130cyim8+hJ9efYFA8QS17zp+0
         2LZaIgrEc5rG1oUSMGvPkSenaV9MvDyDztXAiI/m97KQ43kbtMfRlgYU23srNKUtbOQd
         Qnqh/eHS1EpXt5KfqfHR4G8+eov3FLO++zAwRvAoMHeAT/W/HbgoPiGDzWR3S6m09zQe
         UEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZTw+/dl+u7VALKc+aDUqYPmTMP3nmYfs9bPIFnrxV0/SOyIRIKctcug74JkJH0RLDfZBLc3WC0QR8bsN7dG/uBNlhUnVFB9IZyIc7
X-Gm-Message-State: AOJu0Yw8uTHtVmQZJgIysLl2rU+WxWDML6cXyx5lG2geNZFp77+P5+SI
	ZfXQwzyxt5J/5w7BnWALj6LSiyTLToiKQNckoTyx+IAy7sMKg5GMjGYmHERfXBHiPXY6O7voN3R
	ysH35NIpCpX+VYAFYpeKgzFOqUQMV7dTBM1MgbTpp6YCEW6/x5aBQBjg=
X-Google-Smtp-Source: AGHT+IFlFXGsJ4D52+O4iBNFFJCNEZDJ5LbCNdjN7RFOLiN9InVzRRHKm9oS01hKvz4T0pp5os3+EuxIYwEXvmem1vANk80LbTNc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:ea04:0:b0:7bf:ffe2:3537 with SMTP id
 m4-20020a6bea04000000b007bfffe23537mr92123ioc.3.1708355105010; Mon, 19 Feb
 2024 07:05:05 -0800 (PST)
Date: Mon, 19 Feb 2024 07:05:04 -0800
In-Reply-To: <20240219140408.GB22070@breakpoint.cc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f3c3a0611bd6b5e@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING in __nf_unregister_net_hook (6)
From: syzbot <syzbot+de4025c006ec68ac56fc@syzkaller.appspotmail.com>
To: fw@strlen.de, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+de4025c006ec68ac56fc@syzkaller.appspotmail.com

Tested on:

commit:         34bfd872 netfilter: nf_tables: raise dormant flag agai..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/fwestphal/nf.git dormant-reset
console output: https://syzkaller.appspot.com/x/log.txt?x=1495c734180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52f6b87f61a6b59c
dashboard link: https://syzkaller.appspot.com/bug?extid=de4025c006ec68ac56fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

