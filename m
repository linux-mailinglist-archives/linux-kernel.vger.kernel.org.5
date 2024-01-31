Return-Path: <linux-kernel+bounces-46716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F0084432A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F743B2ABAD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57039129A8D;
	Wed, 31 Jan 2024 15:32:11 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8942D84A45
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715130; cv=none; b=YwKI+9aC7fvOeya3SmrLqvK+iQ5ARl22LwMw4WVnW9wubVUet3Ly4KUWvgJhqETC/y7D4kpd69EvQrb5yrkrs+V1i1hBG5JX/AJ4gK0Pxc8Fa13GVy8yJ/b0vqP6YJuflQXr1MhaSl7JmijOyNaYjg8Rd9wvggIj4BKB0enSpWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715130; c=relaxed/simple;
	bh=Y1Xc0AC7HL8/cnHoPiq+KV34VkBmQB5v7UgHz7Qvbe8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=oMX836lRDHIBphLU9TT/hmk//pgFcjnx1CQdPugfsccegU3Sp2Bn1/pGxP59cem2CurFzwZdtDbNDslzQewAdhnO+slGPmQvZAjnsmfEDkySqN4LkoNR9WF61ivrxW9bkBxQcT/SQasLICMYYZhmx3vg51XaIgASF0r+mnEaRQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bf4698825eso387677739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:32:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706715128; x=1707319928;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1Xc0AC7HL8/cnHoPiq+KV34VkBmQB5v7UgHz7Qvbe8=;
        b=sN+wKGjO/5ulrETnZY3aQ1IEHtpwh6D8ghrlJW2/IuM0q4oBsuypOy4h2whu6NvWaf
         SNLmR5lR4Wd6r3Bk9GjYzgnChN1rTCoOQSQeoakiv+7KWIF++Q7p0I0pdlYqQPHx09Y7
         i8mGEDwjb3lj6/Q1zm3shE0hAKdZ6hdmjlsLc8LIxYdWyscpSSdsHkEXFZD2WIUSbwDg
         h0I4rK/k2vl+tWPUtcRT199WYCA0R5CCz1wudUQ4ekCBLAIn6kUC1iXAL7CFx39I+vKQ
         A3ecaQn5Qeud/z331HfVCPflV8D7F2hD7omdD1W+Dci+Z7GA4iUqH73fQpszxYO0kB/j
         qYLg==
X-Gm-Message-State: AOJu0YziKaKCg8em3onBDaawrql6nqmSwPoy0tLTQXsXv7OQOETeKgEo
	JLGJJoEgOCESOss0GmBuOa2dyLZLBCAyrDpLuyaSKDyoeTrIGKyj7deK/eJebOCMvubZIMvAZuC
	3zjx5Rr81vyfL746e0eV6X7ih9Vt47lIIol4DJj04tlNnRyAf84sTzVE=
X-Google-Smtp-Source: AGHT+IE4Oti9kRwZUi5hdAPV5qfmiFigWM13dbMJ+5h2dqvUS/x5sGLx3jdUZWup3CqkQglg0oFD48uAs4jSy+3W4qVzcwAsGJ+3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c263:0:b0:363:9162:c45c with SMTP id
 h3-20020a92c263000000b003639162c45cmr181019ild.6.1706715128684; Wed, 31 Jan
 2024 07:32:08 -0800 (PST)
Date: Wed, 31 Jan 2024 07:32:08 -0800
In-Reply-To: <e9046bc8f02da086c1dc39deb4dc1757f387bc7c.camel@oracle.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa6cf006103f945e@google.com>
Subject: Re: Test [syzbot] possible deadlock in rds_wake_sk_sleep
From: syzbot <syzbot+dcd73ff9291e6d34b3ab@syzkaller.appspotmail.com>
To: allison.henderson@oracle.com
Cc: allison.henderson@oracle.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: https://github.com/allisonhenderson/rds_work branch syzbug_f9db6ff27b9bfdcfeca

want either no args or 2 args (repo, branch), got 3


