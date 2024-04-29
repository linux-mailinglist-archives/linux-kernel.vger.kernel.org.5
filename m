Return-Path: <linux-kernel+bounces-161755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8673D8B50C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9B71F21DF9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC87DF43;
	Mon, 29 Apr 2024 05:44:51 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5888BE2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 05:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714369491; cv=none; b=PLF7bWG9dwA7I2O12PwnM0cEI4zEhjKcaYHGiB5BVr78j7HH8d0fWTRMsienYB4XyPlP4mW3CXNsZRg8ECup2sTleVBg0LaflqJONYLG/6CmLbeXmuw6QGkncYc8hd0t029Gm6rMlHjmdjdUxGK1YUQMW3YCxkBwXWwvwZw0eMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714369491; c=relaxed/simple;
	bh=HW57DVsi0eXJ8v7ID3JgWt1fl60VOPRd5eNucuAZML8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Ch8FOOugNDT+J645Ke97ZygrbTSufS0MF7Xf5manXGNBKMbqsWVtm4CW/Y+1WgRHJ7IY7fW8R92gt0Bpx/FUGhtV1ezCggeST+6hdbGw5C97GeqLZ1LAGEL4e0Tzmf6i4DqdNLIfwni9q4uTsciQ+EQgQaaBHwFW2cwo4jpcsNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36c05c86944so46208665ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 22:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714369489; x=1714974289;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HW57DVsi0eXJ8v7ID3JgWt1fl60VOPRd5eNucuAZML8=;
        b=B8icIr9poMfBTd1zXKm3kYVfAaHq0eNVV7jzRvcKOt+NGnmOYca/j2Fr/zIp7Xlz6x
         jz/KKf4RFBCZNPkRRO3YHCRx93elHnXkMPUNcATMSilzcfQzk1opqXr6nMg4ER4qxqJM
         BbTN1ZU45maIg1ozcbDFJn4DFCfDe+e243mhhJw24cO9qg/LX4AHp4M2iuBq31OkWkWY
         /HuKHQlXW1ti8/Btwar1QnHuy9YDt7Rrdv77BKpAwJSnV/ND0qjxhKYmHWwKs1srnKRd
         a0JHcVvtwSMjNk+XI4GvjBGL0nDM8+jIcEyZSoD86TRq2JmwEAmTOaoJXooscTzkJeFE
         B1LQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4KoiScj19HT/5D2ZqBzQPjI9B1MLL1gsAO6sFcgpFIDf2XjZcTE9Ktx4spiCh22XiILiOooPLM7o2oXTea/L6qmi7J5eSswR5TlPp
X-Gm-Message-State: AOJu0YzOiSgLJ0ejkjbpm2IshQNTsaZLUMYtw9t4VyrT4cybO+EfbB/F
	MRJUms21CeJcLapXjJHR/qH+d2ZBYotK3BIOkzDTwrtvmGNzsrJk9OXDqMSncR/01w0n3HmGBB+
	8/nWfcbDP7RIOQ6ze0peiB3TKt+Q1UO3pPDUaM4w5AtLYiLQxU0GQH4Y=
X-Google-Smtp-Source: AGHT+IHzhCPGVaw9wH53yKmAgCnL2Dm8I85qFZbOwLWQ76vd5NBO3MqetO6itOxEl5chqoBbK5DgtZAHUPAQcJdzazDycrSVBleU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f13:b0:36c:4405:68af with SMTP id
 x19-20020a056e020f1300b0036c440568afmr205344ilj.6.1714369488930; Sun, 28 Apr
 2024 22:44:48 -0700 (PDT)
Date: Sun, 28 Apr 2024 22:44:48 -0700
In-Reply-To: <Zi8zzvqve98W-VJc@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066db4f061735c0fa@google.com>
Subject: Re: [syzbot] [xfs?] possible deadlock in xfs_fs_dirty_inode
From: syzbot <syzbot+1619d847a7b9ba3a9137@syzkaller.appspotmail.com>
To: hch@infradead.org
Cc: hch@infradead.org, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> #syz test git://git.infradead.org/users/hch/misc.git page-owner-fix

This crash does not have a reproducer. I cannot test it.

>

