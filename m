Return-Path: <linux-kernel+bounces-167783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DCE8BAF1C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DFCD1C21CEB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ACD41A87;
	Fri,  3 May 2024 14:41:09 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299F02B9C0
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714747269; cv=none; b=YDuxGg4VfyAeXPelPmvHVQih+nFV2T9XVXIQAVSdc81lj0LBEr5L84XuGHuk0DY4mG0As8guEmWsVaEyoAenhkLINTbCqO3bhbKHOS2PXKRXM+YabNmIToxbkZu671krjHeIoZQyIBFpN/rc7Bvnyf5h45Pjy7GOmDoszqo1Ee4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714747269; c=relaxed/simple;
	bh=WQN/EnPah1ram2Vd3RsbdX40jJtEnD2QyPPDAIT0EFU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=CTfjUHYkRuhCy2p/hQ+dZYFPBbn1QhtOopoI5xYP/9U5MUEarA300reOLR8Ain0zptnFlW9LEgAYryE9fAvpOV7zf2TI4uiJrxG7n5JvhQaICtnI7hv1uwgOXGLBnIG4VIIUPLHcy3VsTOylMcMvJhLa4CcdPJefhjlzZmMc1DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36c2ff79144so84416955ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 07:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714747267; x=1715352067;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCRfSlaPM1t5F/6SBS/FBJZDsXajbzGONBj6BMeCrak=;
        b=tsjxLJri9Dyvb+05GWkBjeDNljjSVBuvzz5wswFwxCHgdHFonD9Udm4Owz1wJ7YyND
         q6AtV1oEZIs3nwY38lijlJsEjOFjvhomaZMEduaXsSyVw+r5JhMjeDwvZANSbhS+dlJW
         Q1fCaqlh0OzMqZD2lAPjSqff7WkCHJgUVLCinrb5EAihs1zP+GH0aVBjyGvPWg5eVn+S
         nCL15HI95mlmzzNRgUsEiLP3WqSTbUFZlIvBRC7xUSp22tBJQQ3K01s7b3LlVSyurnjQ
         yE9k0gAZJWlj6jSj8hpGzwRjpEQTQ3oJ/nbwEelj3Fl0xnRCl8KbUJ6dbC9Hw/X+lzoG
         GpHw==
X-Gm-Message-State: AOJu0YxvsNZ0/RaEih2RHw/F5A5ugK6FKw2e6XPN+CWypz7FYAEpKz/m
	HhT5NEzRhTtuacut2tvfOhpCWyjSMGx2IoZKJ6Pqn0jvLb/h4FTYpz2d3NL7mnQHBWE+xpmtqrN
	mOyFrx0ppOzJvbqIRnBvLS6fCshodSnpE/Lugx81wJai4BZhW6BAcdNo=
X-Google-Smtp-Source: AGHT+IEZzzy0L3gvpaqgTyOdlHFloLgjERn7EHi0NtbTEiMb9YdgWxZGjYiWbMzZSOlTCNqqW+xmcMXbXZGwnhrLoqMczdzk/Who
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1522:b0:368:c9e2:b372 with SMTP id
 i2-20020a056e02152200b00368c9e2b372mr118992ilu.0.1714747267452; Fri, 03 May
 2024 07:41:07 -0700 (PDT)
Date: Fri, 03 May 2024 07:41:07 -0700
In-Reply-To: <20240503144055.3820-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1a36406178db530@google.com>
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in skcipher_walk_virt
From: syzbot <syzbot+97b4444a5bd7bf30b3a8@syzkaller.appspotmail.com>
To: n.zhandarovich@fintech.ru
Cc: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> req->base.flags were not initialized, zero might suit in this case.
> Do it with skcipher_request_set_callback() as it's common practice.
>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

This crash does not have a reproducer. I cannot test it.

>
> ---
>  fs/bcachefs/checksum.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/bcachefs/checksum.c b/fs/bcachefs/checksum.c
> index 7ed779b411f6..088fd2e7bdf1 100644
> --- a/fs/bcachefs/checksum.c
> +++ b/fs/bcachefs/checksum.c
> @@ -102,6 +102,7 @@ static inline int do_encrypt_sg(struct crypto_sync_skcipher *tfm,
>  	int ret;
>  
>  	skcipher_request_set_sync_tfm(req, tfm);
> +	skcipher_request_set_callback(req, 0, NULL, NULL);
>  	skcipher_request_set_crypt(req, sg, sg, len, nonce.d);
>  
>  	ret = crypto_skcipher_encrypt(req);

