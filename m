Return-Path: <linux-kernel+bounces-71442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF1B85A54D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB1E284864
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1890A37142;
	Mon, 19 Feb 2024 14:04:12 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BA136AF8
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708351451; cv=none; b=AwiXq0MkBFBtG4947VgQvyfgpUPc0e9I73Y2aMHgDmBkbvdL9n5M67yI/lQSWMIhjnphRUb/44MW++2wradhnf7LPFhPJWwObBElD4MTm/fLDW0e3SwB4SjoClzXWxJl63de7FclVsnTqd5JTB59ZopGbtZtq9TFpZxVGdg8KSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708351451; c=relaxed/simple;
	bh=1h1rFxO/JcEOYbSUnkSRuRJY5k5j+jfv2C9vQpExf8g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YJB2uFRwltqh7OghzKoeWkXXHR7OvHH0XNe9TS/CGj6qH/xsYViCxyIZL5sFnx7Fp+S/rTLeQYeG4tPZLnCFFJf0Mgl5SFuZQ0GN+nAg0aSyJpZ9hHuRplrpCmlB97kiYCKZ3Ifx1ElOMzpsST5D3GX//4HjO1dtRN6+Mw8OKtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c7490332deso108271739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708351449; x=1708956249;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1h1rFxO/JcEOYbSUnkSRuRJY5k5j+jfv2C9vQpExf8g=;
        b=vn0srQeFEj74hYI8jedOc+3qUfY0nVLAg5KzA1RgAvDH45PWPd7hk5hDDWIqyPdThO
         qeqZmizFwNm2qy2zEB+YMNc9Vey4CgMFoIVJ03/jB1y4j/45JIuCkXAiOsRLWL4WvwVp
         FlYdaSqbTV9a2cp2TElzlVBZHcDCOt5q3O5l4/CtZ8yLjtyGxxx41dgjEg/wXkHhZGl0
         nXjOOuyMnhrcGG2Q1GycCpvhdrStTzflYQZqU6q3uVf7yRZCLwSWGle5HF0ZQgdRez9N
         FR2chgPPwI1NSvjnlK4Rhq4Jty0EunNikbQSjgu68z3JkrI2EbHc1p+JezjCdlxszYAh
         HZiQ==
X-Gm-Message-State: AOJu0Yw6A+DsFRzk4JZnysOwQUzinbpYYj3KcjjXGRqRx3xiwb0NPN/W
	R2csyGYu+ZX277Xy+ddFgM86Uk/gErQHHt6jGrZpUnit6xM2dqSag5qnOn/PRqZppGI73fKNQw0
	FF/afsp8C9txvqFY/c4M9LUmftd74wHUF5XHZDdl4VJnlcNpb580FFOWz7A==
X-Google-Smtp-Source: AGHT+IEpCMLvdtmSII+wS9hvc7sLS8o6ou5L57WNsPNL1L/IoFlmfhQ58QPzXQPOYZSGj73xsTvNmeYdsDy/LHkwnF8shQ0NdQ0p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3712:b0:474:c34:65b4 with SMTP id
 k18-20020a056638371200b004740c3465b4mr153684jav.5.1708351449465; Mon, 19 Feb
 2024 06:04:09 -0800 (PST)
Date: Mon, 19 Feb 2024 06:04:09 -0800
In-Reply-To: <000000000000635bfa0607ed5cdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c0cde0611bc910e@google.com>
Subject: Re: [syzbot] WARNING in __nf_unregister_net_hook
From: syzbot <syzbot+de4025c006ec68ac56fc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: WARNING in __nf_unregister_net_hook
Author: fw@strlen.de

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/fwestphal/nf.git dormant-reset

