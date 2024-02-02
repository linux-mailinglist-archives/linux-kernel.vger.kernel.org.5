Return-Path: <linux-kernel+bounces-50527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 773B6847A3E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB9828459A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0959180609;
	Fri,  2 Feb 2024 20:07:11 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF7B15E5B8
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 20:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706904430; cv=none; b=JCWpHUAMQvWN82ti2Ha19mJCBNQOAxoNA4yFddWiAFW5udRhygQV34dd/7eEloCjUv5Kdp3JuAfqCgpbdYDLPFDtKSJra0Gkg65MNPaCQsHPU9rk0t+RsCt2mUR8LSFvET97ez30UkqhsMc6mAKpjr0JyWEcmNLf56mN4MzYByM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706904430; c=relaxed/simple;
	bh=Te5zVoY4lGAuebG0OZci+Zfj6mpoDeO64xLwy1nbzu4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sfUZRyL7qcAK2wOoU3hX47nRY6ONPJAEZv4kqum6HVHnbikFdGaE4hY/PvKKItyakWxpIeMNSJUnxP9uass+a4Y4e4xxNVL0SvyOH6H3M7fZfa32XMRXiaUX43+6ya+j/nmac6qivMofgjVAHWR4pLTBrTymsjrYvQqbGNO+APc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bad62322f0so265511039f.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 12:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706904428; x=1707509228;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Te5zVoY4lGAuebG0OZci+Zfj6mpoDeO64xLwy1nbzu4=;
        b=CZp1j42A+q1Z4Z5YMGKTQqx4q8nSGqRInh87eA+1rLh9B61N5p1UT3MDnoXsmmkO74
         dStSQ2ntafpuuj3rcxuc2m8gOnyqU7u3+i9QSbg+0fFcs7hEQHf9gaME+w6ptA1/ti7e
         GXilNbQR8UBbczsfEctOu8gCnfv/8eZuAA/a91VYmCMFOXPbnpKujKFPQiKi+NxZtSmw
         LOvfBi9iNlAeHAMwVdicoccYGfS5hCoHwxY7h5wNFwZMDdos8hzqn2v1YGTyes/5nPVp
         45z/RqcuEduN/TfgO8k7Xmy9/2wNiz7kAuZKt2T1GpPNj/HJmTYmJ8Cp0QO6BVvULAIU
         dDQA==
X-Gm-Message-State: AOJu0YzGHxAlQh0Cy+NmQ4RD2wlrsoqPjTnpRW3wFQVhUJQbCufYoM8/
	dF2189XCYgPbLh89Bme3SLv7pfsVbdnvQB10A5UwmhVXZl5En5epBzXGcQ/NOljf9RtI97qKN2Q
	SluS/YLHN1+KD6utQjup6/ijNRndyV+/abqiOGiEiWRi3PBc6ZlIhIN4EAw==
X-Google-Smtp-Source: AGHT+IEWzOl2OyHdEbF9n1McQox1dJfLFfHLAgV4JDrOBh74rX68utrXZVU3qwpqCGTzSRFLd3BBc39qb1Hcac6SYGD6t/uzV+A+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e5:b0:363:812d:d6a8 with SMTP id
 q5-20020a056e0220e500b00363812dd6a8mr485309ilv.0.1706904428342; Fri, 02 Feb
 2024 12:07:08 -0800 (PST)
Date: Fri, 02 Feb 2024 12:07:08 -0800
In-Reply-To: <0000000000009d3fa2060a3575ad@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001df5bd06106ba8b0@google.com>
Subject: Re: [syzbot] Re: possible deadlock in hci_error_reset
From: syzbot <syzbot+47d22a47f6bd21399c93@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: possible deadlock in hci_error_reset
Author: pchelkin@ispras.ru

#syz dup: possible deadlock in hci_rfkill_set_block


