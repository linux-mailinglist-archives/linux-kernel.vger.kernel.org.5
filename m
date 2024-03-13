Return-Path: <linux-kernel+bounces-101562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C75787A8B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5491C21D9D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494EF4596F;
	Wed, 13 Mar 2024 13:48:22 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA9945033
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337701; cv=none; b=JpMaDCrv2kltF/sQEOP6CxvWK5CiLBdLUyVS1j23jsgMFD/mSeC8gwI1yXFXzhrcr9p+ebRReKmQZU3tbMnSngC+B63onGGHXC9pdU++GJFabJLCab1rPxq1Gh8bUQ2klFyM7t2g3sgsJORB0hDywDKBqhi2kDF9pX9Nuh1lySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337701; c=relaxed/simple;
	bh=J7uAPX7OeS6bA6lq6FyD33kqbbeigY+cd6q0Sfc6rts=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rQpPHi8CPeMDCywX3pTZP0JbzVfo+xECKmgB7ti3GI4t31nHrG/eOtXWoNCFy/J59O5R1kGpMMaNW9WWczHS10xoDlyXW0XmZtXwMCFswzkLRUbFIWzXi50+Rga5+T23CTTARjjiJJ4KLRiLPl9osXWFEpPS6B902b1+yxb+O9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36630680c5dso60121105ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710337699; x=1710942499;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ikndV0hRiImdaRH7K36X5nfDsUA1+XpvlkKvXQSFaRg=;
        b=hXZvH6cDeq29gkDbIIb7nuxlik15pkFZ/ZjuudrIF3or0UwevE+u1wFJk4B2QuC/tY
         PbTv366khtjr7VYKRlz9/GmEdnJ2fgqOfmSAFYViTjPgkrOGiN5DtW+Fteuc38ljzACq
         hS2Nto0gq/euPqM+n4PHbhkbN9aPLpcIe0DkcCMa/4wYXGowD8JPOGPEspH73+E5KBZP
         5ReMWM6BmMeZVVfkZhmINdAwAVYD2uJbuUPCg+HaguBvfhuhmPmxfpKy2hUNuqOxBzGZ
         BHU628xRAOGZN7032O4y6B9mtz0dAE/Rdo+krRFwz5Hb6Tok8jZPTRTrF46NJNsHVWrI
         Hn8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJLONZJjDVHYYa3pYJn6xdOXHnw4xaJlEXnPzwOu4HKh8BL7L4Tc/tAORLM2mDKaLdM8Ly7hGRFMT5YCWK2E8FBJQPvxgFyGTNt/0S
X-Gm-Message-State: AOJu0Yxzr3E7hkdEXhKZigouRx/LUCfIoheLSptH8E3PnKUorrRQhMZx
	otdN5jUzY1bn5d3vnVUxXcVz6vxX8mfV1zMRnIlP5pVFwHj5MikAzMbujRM+j8Lue/N512yLFFh
	TKmd9/PLKrkj1SFDyJTghp7lcNv4URnozdm/X5o37nFKzr8TvD5jdpCY=
X-Google-Smtp-Source: AGHT+IHLMglO+B6K34BPxVcH6Z4sKTBQ9OM9KGBIwPsHzQE8JQExZMv7EcEM0MAGcfTzq7vwDhh0CbxH4ou5ehju8MGosvJXY+M2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a61:b0:365:c9f8:4882 with SMTP id
 w1-20020a056e021a6100b00365c9f84882mr648780ilv.4.1710337699566; Wed, 13 Mar
 2024 06:48:19 -0700 (PDT)
Date: Wed, 13 Mar 2024 06:48:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000076aec06138b073d@google.com>
Subject: [syzbot] Monthly udf report (Mar 2024)
From: syzbot <syzbot+listbbb74d14bbf78e9e83c5@syzkaller.appspotmail.com>
To: jack@suse.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 27 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2138    Yes   WARNING in udf_truncate_extents
                  https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2> 399     Yes   KMSAN: uninit-value in udf_update_tag
                  https://syzkaller.appspot.com/bug?extid=d31185aa54170f7fc1f5
<3> 24      Yes   WARNING in udf_setsize (2)
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

