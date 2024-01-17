Return-Path: <linux-kernel+bounces-28800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F19B830326
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB64287C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D5B1DFD1;
	Wed, 17 Jan 2024 10:00:09 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F141BF4B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485609; cv=none; b=pLeaSK6qL/rZg7xNCcG39Qn+0wxfrtBklJMSxINjyATLV7kNT1YQq/66qdtLpKYaKUZY57KUBPMu7V/15SAI9FtU1dnBxVJ3w1CP7znj/uNxKGhI61n7d9wvaA4H+0OVqF5rbVzQnietEOoX0YXAHlzCZD6Te5skXesxM0j4PMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485609; c=relaxed/simple;
	bh=V+2etrmWvlbG8txrOcr7VyaNx1VG1Hy4oQA7XD2JAhw=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=vExzuoZX6hg+n92n2Uf8p3eB1U7hioAoxzXV02++YL+HLWF6MZWy95oxsOWy5iYWjt5T0z9najOYkE0Ru64lxhzKV6a//n2hv4OiEZgt3CDVymMlpzyPOF+Ot2sHeTHVORT3sYfPB2tim7nRTk6gT9LPuDGwdDo/eGWPFkGFEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3618ed4a2f5so10145995ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 02:00:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705485606; x=1706090406;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yEWYXMygqwjqpXLX4r5FFUWm4Vr0B8II2TW/fN+KFgA=;
        b=s4miIbPpbQibYw0qZojd3qeE2HTCKhsfjN3U2/J1cYbSbJmprjb75TCLa+DEJrTgtO
         wQp8d3kVtphEVX/yXdjz56r4FN6CB12/bJfSEixuCc3tJxz7BqiMgqPF+cXFjMmfySEL
         ZaXHlL21vOM3icyruJjguHERJdMvFf9f1WQnhZZImpslmMH4NRHvYBgt3XENz/Zm5Viz
         L519i5nXWNuhAQnDf/pq8hj00R624vLScX2KWU9QcgnBGtB+MRjpCbAcBQitDAXOVd+0
         GBex0cfblljgf2GjVSm5oNng35QTHu4+PTVcLMGE2oVZata/o/3IHqKboxhVBB2nE6/P
         qDjg==
X-Gm-Message-State: AOJu0Yyeo/pi4pYTx80d2WzQX7EzYokhGDFLgdOvE65Adjmj8JHckGcF
	JXvpUmgd8Gma4MThLC7TeybUIjfKTxllVnlACJH92tiwgU33
X-Google-Smtp-Source: AGHT+IFxzxlQiBQcX55AFmPxoteq4urJfMDjyvSOi68dybWh2/wMstcQoWDRkMhtdU1DXGkmkpRcVxbUE2YlVxE0/SEPmN1ghQFF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180d:b0:35f:9ada:73a8 with SMTP id
 a13-20020a056e02180d00b0035f9ada73a8mr1265663ilv.2.1705485606163; Wed, 17 Jan
 2024 02:00:06 -0800 (PST)
Date: Wed, 17 Jan 2024 02:00:06 -0800
In-Reply-To: <5746181.DvuYhMxLoT@ripper>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9996f060f214f9f@google.com>
Subject: Re: [syzbot] [btrfs?] memory leak in corrupted
From: syzbot <syzbot+ebe64cc5950868e77358@syzkaller.appspotmail.com>
To: b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, sven@narfation.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ebe64cc5950868e77358@syzkaller.appspotmail.com

Tested on:

commit:         a67d6793 batman-adv: mcast: fix memory leak on deletin..
git tree:       git://git.open-mesh.org/linux-merge.git
console output: https://syzkaller.appspot.com/x/log.txt?x=100a3dcde80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87c229fb8ad5e9a0
dashboard link: https://syzkaller.appspot.com/bug?extid=ebe64cc5950868e77358
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

