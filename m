Return-Path: <linux-kernel+bounces-143956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 070898A4009
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A27E281C83
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939CB175BE;
	Sun, 14 Apr 2024 04:02:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDC03FF4
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 04:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713067325; cv=none; b=uXRLbKGlZaP2wmtl3KX8DCrBiey1iuySlkRjlfWqLNnC1ElpFHVPnKJoShdh2BdxD98PJWjHzPtpZGq1WF7PAqfBiWHv6dVCxnHMsH+qr9LUfLq01FQmMnxydE7Glv2Z5TW4kkJ4r2wrx7qpUrkqqwVm1h8lHUtrnPLhjFP5j3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713067325; c=relaxed/simple;
	bh=cLiDg5X/fCmSIJ1UdPqS7CwsOVyL1jOQRhab/XFk6zk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JznPbg1nUDPiBt9SXFscq9dn3D5gh5vjhaZNJu1J93n0Yyt5VMc0IPvMYsi37IOSrukplE+YZtMcA+mgzte3Tz7/KJpWpD3Tz+60x46WqRhrH+EHcmh6pEX+UczgThbK4P0VJ1mknt3kgwxdKyRBjXe1wu/dFFGzBpH9P29tnB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d5e2b1cfabso225547339f.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 21:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713067323; x=1713672123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wn4d26eFrYk5AFnRTclNewtTfJfSsW6ayzUDan9jgB8=;
        b=E7ueT/tLqalI+8fhOKodp18WkHcGZUdC+mqHqhUK1F3si/aiDRaEQyDHgBjiMGuUtM
         u3+h/YgRZ1E9K60JI9xMzrTGqXy6QHxQ7VlvNsrW9ckyO1EoghprluuGAM9+OZrMgoqe
         iaBVpGwY+TIlbw9PZD/n/6fa0KBIlQCkSbcBNPwv5WLm0YbDAD2n/IB0Qw2oHmwZb+eF
         KbxJv5K5knbeWUCe/K2hb2Eo8w86JsR9/aSe+uXH6lw3wPuUVuoF3eZ8fp40p1pg9ufU
         rE8uTqQc9hacH/OjSvQ7LaX/v1nGS2XYc444goZx60KO65+dGSCf92tCFTgp+K2sM5GH
         RB5g==
X-Forwarded-Encrypted: i=1; AJvYcCXbA6+5eJXBbcR/+1w92uTo4jfRBHvk38M4SxJ8Z2nIHD8ufY/K9nOPxffIx55zxYmIy+ajp8dBp3Ky4n/r5BL3cOlbVj3sUBcUuGcE
X-Gm-Message-State: AOJu0YyarXMRkC5ZHq1niTaH0Zf9XE/j+nlWmpJD9ftZFdLDdAUaWaH8
	MjKuYaT1VJTk9CoknlE5nZ+RnZXLrFuhyLFjdAvhG1KP9fy2edEonf48a1u9q4o8gjz2y4FJywp
	TW/AWrOLC37r9I7Qlosyl4WXPsPev2hX6Wx1hpdp8Oj8kcXSDuRlB5sA=
X-Google-Smtp-Source: AGHT+IFWaX/CEDVujWHI+IQ371zVQH/FUn+j8sGr4THgUPRvt/FkljSDPb17H2O3ilxpFMLd19/dOK6qXTD/wjuVzw6Xswv51YdC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fc6:b0:7d6:27c9:b815 with SMTP id
 fc6-20020a0566023fc600b007d627c9b815mr235398iob.4.1713067323195; Sat, 13 Apr
 2024 21:02:03 -0700 (PDT)
Date: Sat, 13 Apr 2024 21:02:03 -0700
In-Reply-To: <20240414033119.2079-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046a1890616069166@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in __vma_reservation_common
From: syzbot <syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com

Tested on:

commit:         9ed46da1 Add linux-next specific files for 20240412
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17d54961180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ea0abc478c49859
dashboard link: https://syzkaller.appspot.com/bug?extid=ad1b592fc4483655438b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=118851eb180000

Note: testing is done by a robot and is best-effort only.

