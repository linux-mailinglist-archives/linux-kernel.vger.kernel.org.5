Return-Path: <linux-kernel+bounces-143753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8EE8A3D02
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A169282436
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 14:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8121B45978;
	Sat, 13 Apr 2024 14:40:30 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF558224EE
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713019230; cv=none; b=sRza2cE/tR9Ki2E5snd/s+ML5axcxkSiTYqH6w3WLAV9TvEkoi2uzNxFW/AAL6cG/AOwyAR5lM8ExW8IYnjl5G41+7Cda1K8lEDVafNxXZ9kFgF6YIiqIFFeBFW7JzzC5BBRAKBJ57UgWQ+nKhafeLcSaURX5keAdCfN2rFsWIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713019230; c=relaxed/simple;
	bh=RQQzoGcTA6H4JIzpfeJj61LJPkub4GGavWVMwv1dkQY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PO6Kl6PD3kFCuWIY855IOlKhFsah8BLjPcSXwHtziDtqcedGAwBwthc3nku7BhejsYxl32tqQLWZVbrBpC0pLAqO/hCHhDcHJcBNf8sOLYajm8g5plZtjDp0VQsHhcBZxRonZSQ+PmCh5K38AHECjIuFYZforcf8V5TFNIA+weo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d667dd202cso206272839f.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 07:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713019228; x=1713624028;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Km9dnXwPQsStKWjNgok9y+DleaiYjugFVyAiM08sHuo=;
        b=QAcTVDZ57smk01WoyfWmtmpKEa4p4XIn493CYiIwTcFFtEsCnmREye03i7Njge8bJS
         RzTl5olsi13csbj76jHp8U/sHgJYtSOFvat/YexKhvnn/bWtgIcWA8oN1SQA4eh0pVZX
         Je0RidsKXlgHp5GijTRyjEzipaNfpAvSkOZS1U46ksh4gfvldDlXzjF4SAaO3/BEO7Ac
         qkEbGwjD6G2MGiw3g1aFquZX3TAARrCPQxBsi0WeRvk+PT2mt5F6dkNDCIiTl0WVmemv
         fpX2KhnHJNMU08mnyv8O7Q0aaSanVNhN34iiB0QA/kE5TL3Rmno0pnsNMnbZ6xRTiMaH
         OvBg==
X-Forwarded-Encrypted: i=1; AJvYcCVJqK3PuqlxeZ3djp9Mf9/Sxu7ge1JsxPJbDPsKuKSGoQgP00VZ8CErTU73gBEtxU5JV/5Q8RDW+Wm3xmhtxdh8w6+voPx+JmzU1ZZB
X-Gm-Message-State: AOJu0YyDH/190Z4BwBsOZ0PoRapl0pHrcQa9FpDQqDepbgJizuVr5FpE
	jcSlgW8TNn3MRipA20erqf43OJrysyaRd7MvaafPWHvzkZVyHHVt90FdpYYfQk4D08LHqUGA8ci
	AwlldV76nLom2ETqly3dNOzvO4ej3AMFbzFthW0NnkRmwTSyg4TuN81k=
X-Google-Smtp-Source: AGHT+IELSI+0N0PKPjsg+txhSCNZ7OeFTZ7g0KKIEHJir2gzmU6qG80slK+FY0kSqKXjtl2slbCb1X2u62+q+5UZtWrtVICWB+Uc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8504:b0:482:ead5:4f5d with SMTP id
 is4-20020a056638850400b00482ead54f5dmr66240jab.1.1713019227967; Sat, 13 Apr
 2024 07:40:27 -0700 (PDT)
Date: Sat, 13 Apr 2024 07:40:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000939d0e0615fb5e68@google.com>
Subject: [syzbot] Monthly udf report (Apr 2024)
From: syzbot <syzbot+liste7cc1caa67ef1e37ff9e@syzkaller.appspotmail.com>
To: jack@suse.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 1 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 27 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2562    Yes   WARNING in udf_truncate_extents
                  https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2> 440     Yes   KMSAN: uninit-value in udf_update_tag
                  https://syzkaller.appspot.com/bug?extid=d31185aa54170f7fc1f5
<3> 25      Yes   WARNING in udf_setsize (2)
                  https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

