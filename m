Return-Path: <linux-kernel+bounces-109662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D22881C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61376282E77
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 05:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04916374C2;
	Thu, 21 Mar 2024 05:43:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C28B31A8F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 05:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710999785; cv=none; b=pGxxImubrG9JEOSCn5Pyk8lljhLZBcgTJYbDsemXtnNmSjK+Yjj9KUUyh98uIxitvH30muknKyiu/xP3m/cbRZ5L1DZyLb9Z0FMWSkyWMpCsEOSdFL34flJoNbwKFq43CgKrYANpsDwYVS7LHkfI6J52Zz6ngHjys09cGnvGQEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710999785; c=relaxed/simple;
	bh=BC/HbXx0sDRjMty/yF5fV9k6Dcx9U7uYLsJVV7kdmGk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aMgxFyQS6GlfgQxKHMqzVuOHyvyB0GKeQuaiZaEfFOWT3sotdnsxg/dUA8zC8z0W2Qu5i0Mn9NX4FU+T8eeqvodNqJUzzQ22CsSnZnGoHfz011gEey6aHVE/t/PvtBoEnw219UruefIdajg3JmkY0gSe1fH+IAQgaQdluaP2Feg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbf3ec6a96so159374939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 22:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710999783; x=1711604583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWwrhwNNNNE+NB4JvihuS8LMZ+Bf06QjFJCFhqJL6Ec=;
        b=I2UeST01yD4swy3Q0RAsXJ6xIhtnUuak3UzpdQYpic6LgnFgDo5MA8wUokA8Gph23v
         LnwJTPfXLSsCsJeJDA5d+ceZKhiinhVKyTbj4lJkOUEon8jahVoDEbSW3gjd8r3IKxHK
         mD4RVieF7SsZChTu2DnADQ+vtexxrP2WyW4HWhHf3ImpSuWDS2Y5WwwTFfoTLuijEHfB
         x4xq2wG3LAIy2jvz1yjbvJYsG3QZ+2IMBzyz1RbsXx5obrWlN7zwU4O4O+YE/B5visNF
         kt7fteHlq4jhN2PSnxxX7pEyWvBGzz4DEjFg8dyPL6sChdjQKK7m8+TDk7bGPhq95JBE
         O3QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfmJuhslLrGzpDwLz0a5PYZp81hBIxAVHS+SgmGc1wwiQNPuHe9+W/l2uf6MgoxGHvuK45/trixZm0xwkTItGFnSwoZT1wFkJaflR/
X-Gm-Message-State: AOJu0YyhPVfIhXfvtQOhCOeNJByQplKkpcl4yZ4h7/LwUKCwZJB1oRWO
	FOlvU1Df9Xwa3P2eUrKQ9xakMGKplbS7r+ff7OJ9EiDCixSX8O72Rw12Z3Ny3hkL6gOoJzvD747
	uKnq+XF6ybmkosZKepaX7YbHp1WxYtRIdQmdwwNqFTtBCmlr60mnmVjM=
X-Google-Smtp-Source: AGHT+IEhq6wH5bqieRKrMYmcjBNsnD4wyJZMgyZnaWNNmgPFVxikCGKaUJMAZziEfp653NS/K+iNocBORgfsvjyJLBSn33CO83Ui
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3052:b0:476:e038:7390 with SMTP id
 u18-20020a056638305200b00476e0387390mr100035jak.1.1710999783283; Wed, 20 Mar
 2024 22:43:03 -0700 (PDT)
Date: Wed, 20 Mar 2024 22:43:03 -0700
In-Reply-To: <tencent_3436E64BE674C577BF66883D6937C4979409@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b33640614252e35@google.com>
Subject: Re: [syzbot] [wireless?] [usb?] UBSAN: array-index-out-of-bounds in htc_issue_send
From: syzbot <syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com

Tested on:

commit:         a788e53c usb: usb-acpi: Fix oops due to freeing uninit..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=17b25385180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd8c589043bc2b49
dashboard link: https://syzkaller.appspot.com/bug?extid=93cbd5fbb85814306ba1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=103eb1be180000

Note: testing is done by a robot and is best-effort only.

