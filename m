Return-Path: <linux-kernel+bounces-151598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0C48AB0EE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE5E1C218B6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FA212F360;
	Fri, 19 Apr 2024 14:44:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D6612EBE9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713537844; cv=none; b=ocQ+I2/CNufGEImPcWAmHGUvtOVmZ34//2NLnBkEraOOzqCWQzEt7ZfXHBbHDYeUoAbsZ1TuElxz+arjX5vYEUQnAyVzs3TCXzB4iZuYfVKlEH4usomZAJqCl+9wuG/pvnqy10XEiLvHjPPqOn8+CIUCxWZqoe8Gm29gmuX13Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713537844; c=relaxed/simple;
	bh=LD48Sw1WpiPQCpYyQ814xnVQ1uWcVv0UtsHG39DjOso=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=M5AUDV/poBe1/gClNiTuD1G7EJIlkb6G7YltZ+H5MKqJOSTbeuUvUOBuAR2B7PGXo1d2uo91dSq45vXI0GEturGwa7lKt9M+YnDzhirsUpUSVTrnWhJPRRzWi2lBWLGH8DOGnYYr7oa8NE6aIt/ZQBkVpozWTarJ6ueKA60TW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc78077032so334591439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713537842; x=1714142642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zYZppOBJWKnVX7vwWZPMw6STn9C7IqoP1bKYIc5ZeKc=;
        b=sDyslA/O2w3Fk7eQlxF/KH/bAiFq9ZEDzonD/ImChIE1MpVW0IeQhfHBT6YfgHvttX
         HePREntkzME2ux9RhxFfLpStjB0mQTpgGAttjNd3H3/EY2b4t2o1r2sV+ZBCWh266EJf
         e9oSbYJYzTfkdjIq1fsTFqTApU1vmzF5BV2EkPksoglPRRyh3aFbTo5rLfWmWSdVXX7o
         5DuyyaIBBS70wYXsgTbFQlqoJhgMhl6LcFZhRoJjmM5uI3mfK/mHawjdCwk1rzX+MTAY
         g/hKWID+rSqB83A+zgtjRMeya//omeYtfn35z+Sp1d9Rk0MPbDNybP2IcWrmnraehoYc
         nDhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZL5txBAh6DyzqM2RP2RPW2pdL2e3zdxtFzhVEAXRBtyjEsNbqTwG7d/0FS4cRq+GX0S6fq8vrZgyxHRW4LSzpcqdLrk8vTwMfCEas
X-Gm-Message-State: AOJu0Yyi2fUzznkeza9haauYuunWUVMHI/SeeiXiZzevefpe70nZ9Ckk
	lQjhnQVHm4LLX4rnI+y81y/oQ57+k3jJSmjHlG24YI7kwKVcaOneDx9Cj+a2FVnbyECQz9R2csk
	lZ+1/t/+hblGNM+I9GoeUlyDLVgVX6Q4GGleLj0t7DiQ5cDkfa6sIWSw=
X-Google-Smtp-Source: AGHT+IGjRP2FCmxShK69geBEj/RLXx4N4/HZcfbzBo3evBAYWWS1KLkXlDJ9s68eTXRcEOKvJwr15ZyragaxQX/ABa7wzh/JXiOI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34a8:b0:484:e6f6:f2f7 with SMTP id
 t40-20020a05663834a800b00484e6f6f2f7mr30809jal.2.1713537842559; Fri, 19 Apr
 2024 07:44:02 -0700 (PDT)
Date: Fri, 19 Apr 2024 07:44:02 -0700
In-Reply-To: <20240419123959.8572-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a4f070616741edc@google.com>
Subject: Re: [syzbot] [virt?] [net?] KMSAN: uninit-value in
 vsock_assign_transport (2)
From: syzbot <syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/vhost/vsock.c:659:10: error: call to undeclared function 'kvzmalloc'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
drivers/vhost/vsock.c:659:8: error: incompatible integer to pointer conversion assigning to 'struct vhost_vsock *' from 'int' [-Wint-conversion]


Tested on:

commit:         2668e3ae Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=87a805e655619c64
dashboard link: https://syzkaller.appspot.com/bug?extid=6c21aeb59d0e82eb2782
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120f5af5180000


