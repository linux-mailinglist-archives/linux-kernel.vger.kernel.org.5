Return-Path: <linux-kernel+bounces-133269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E97C89A17B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01D51C2369D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC47017108A;
	Fri,  5 Apr 2024 15:38:31 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117C616FF2B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331511; cv=none; b=W/ZgQQIzY0hdxg9VWyxreduxNr3PgriCt5EyIyIPdPS/DMdQ9Wa5atxH69mNnP/EOiIW+edjf2zFZf7tCM/ecF5xbk0mFcTwOp4BioJ932jIwAkFX8NKLukg2UO8RnprqR9Tga2Nm5epAai27bDf8GEkjs2LK8RaiOu3eMRLAC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331511; c=relaxed/simple;
	bh=ytYzoahinejCpQ2R5x0v/K/VoJy/00UGWBOd8vALhYk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=DD4dheYpv4cDZc0rEcI7CyxALemH/MwnSi6JJEOGp++aC/jBVEt9CtohV/jwJyhAtB+n40Zlc5ZwX3YdCLwVxNxbQalqnw4Jn7dR6BrDOQK0uqTcnjQzz6cfvXvzUComMuMy8wXb1XFFoM9C44sCISYBjC2PBmXw+lUVRyZUQ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-368a360baabso19600815ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331509; x=1712936309;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKzucjLpr0I1V5YLQUy7+tP5incwpmn1FHi9dn7tKpQ=;
        b=cRXKZZ+Mvyb4XUFoNF1ZNcSk6iCJ0vS3D2taoRxnYjHt2Jy3IX3CNEvl+f14x4kywa
         oE9vXHsfwouAWxk8GBAjidzwm2+CIYskjP3npsIFBWt+bfiDvt8ghtMJ/iDqQHApngJc
         nvT56//fKE8Th0RFp68GigSAfbi5O/YmNZw3RprEtyR9XiAhbdw82m3lB6XVkgolXjDZ
         YJ45/PGcRcjANUA2fY0h9OxbOkBCB7uK9CkhdC1JC3XIlMkAfEAbWx9E4NZwADDqSMue
         tmSDteUvH2sv3gA4EH5RbmmJ7n6OvgEG71DsfqfDY/Mzz9+FIgD1KzfWc2i0lsch5xXE
         QPOg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ6MuBvGXfJOuNRmkQIeEBNGr3+3lazxxF72MC0pm5MbLYl0ha/x5hJR+84SbnXIlOpwuocP51KX/jbzrI36mSPPQyvoC7GAIfWOs+
X-Gm-Message-State: AOJu0Yw1uYzxbU4Zc3ofFjaWqHizgA4DuwAHitPVr3p68LoWsro/IsqE
	h2Tt3/kCFHMdLb5G/EKrjVl0um0RJcReuGzY0K01xDNPPcw7XC5gp3QrM+l4BO4kaO3cerSbZ6d
	oPA/AaJpkwYLUs/CDEzKGgI/zB8uBuQiTPU0FcFL9NOqevteY3u8AmLY=
X-Google-Smtp-Source: AGHT+IEYaulUjnHJhIE1cZ1KiOZsb8PzwwBqn42XUaEf/Mpohq0DQN8irH6DApDXVfREmrUyE0kYlDJoc4feBEYkLdqGEpRtkd8q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdae:0:b0:369:b97e:7e49 with SMTP id
 g14-20020a92cdae000000b00369b97e7e49mr116579ild.1.1712331509296; Fri, 05 Apr
 2024 08:38:29 -0700 (PDT)
Date: Fri, 05 Apr 2024 08:38:29 -0700
In-Reply-To: <ZhAa7XH4uEM6yj5u@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059838206155b3fbb@google.com>
Subject: Re: [PATCH net] nfc: nci: Fix uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: ryasuoka@redhat.com
Cc: ryasuoka@redhat.com, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

want either no args or 2 args (repo, branch), got 5

>
> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index 0d26c8ec9993..b7a020484131 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -1516,7 +1516,7 @@ static void nci_rx_work(struct work_struct *work)
>  		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
>  				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
>  
> -		if (!nci_plen(skb->data)) {
> +		if (!skb->len || !nci_plen(skb->data)) {
>  			kfree_skb(skb);
>  			break;
>  		}
>

