Return-Path: <linux-kernel+bounces-100352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A325D87961F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43CDAB213CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590247BAEF;
	Tue, 12 Mar 2024 14:28:02 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8893D7B3E7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253681; cv=none; b=pw8LTKCdlxI+j/Ndg3oktDAuIWfMjMJI0D7pCByS08Fbhzcsp9XVPSr4jdShImS62tDvGLtdzKCS+za3rUyRga5K44CJibCFx3IFASq/RqT/w6qYCMyYzb79bGqq8k00XmanF+91tId0d6/3suCycWXJ4E/8K9HGh7eiigc9aDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253681; c=relaxed/simple;
	bh=0NRSGEr/wpTigC3/337hWEuSXfopriFf7Yywx9Tkk+o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Qi3ep4pi8xjy+PpyRuGmxsWVEcdPcms4rZzM3HzvjwCKboODWx6lD5R5cMVreGxXzz3ndrerM8woscsXQUb4f4FxVdmrAh36+aIM+EoNaF9pneIuhbpIcgpNV73/J+7dXfKFhiMktnC5OxxW+2i5qUO3Kyepk5BZXXJpmV8GEIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c86ecb5b37so533756939f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710253679; x=1710858479;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OcPCnficp3UrC6QSvLYm7JvnZgLD0X7CWShh9pApXFY=;
        b=MW69qLckengA3/BrIv7HoWchjNOunmpKCGVMNDcyVjapp6QpS6Iai/zsUOk/ggSjkd
         qHyDzNNWNTJVP1A+zsKCQGXgPYM1x5kVgHkES8ei58zQyy5N1Mo6MBbQqLsTa+a8qQfu
         i+Wa8ZtW/vZGUwg17sjKCnyUZXzHjSFNsFAMvasuWBZicIV7j+Hnn0DTz7WipEh8/bSs
         WT2ymqMWOKP2VM9XIo2NgXKDIEmrPPeMHBoC4MHsZUGvWWVBPDsOfkzKy3a0BwZv+VbM
         N70WpktHwe4kydMmBDbK1vGxWIycMDUbqLLicSkTkQc4dtA3yO2TFO771ISWi4Jc3Q4u
         39Ig==
X-Forwarded-Encrypted: i=1; AJvYcCULNPNW6sQbEXW05N7wqpnuel71Z+W2lu1dTKcF5M+Hm9D+HOhr7ru7r9PYPWWafDyye27YMWBfW0yinynU/bj1IUj4JmQMsKjTQKEW
X-Gm-Message-State: AOJu0YyHLGtszS5dJYv1Z7Svitx/kKl5Fm+UJQVlWW/F49+cxZgA7pqd
	K1aU4Fp31XdMJEXnVXEbu1OpIX+l540tRkMOztJDwBtrfU3T2Sz3U9ThnKMJf4D87wRz7gRUNiL
	0XGgEh/DDvPmCk84ryDJ6+AdXl8p8Ym0Rdr7ihtSA5dYHdTc95LEy8SE=
X-Google-Smtp-Source: AGHT+IEfBkTQGaUgFknZSPuk/XqHz1LXLE+kJmWtemdQZHPxMqazt8jMdMcuzQMdmo64g1s43fk7W5Sz8BnW7/A0Wbc+OLNWRWcA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2391:b0:474:c3b5:a8b7 with SMTP id
 q17-20020a056638239100b00474c3b5a8b7mr9249jat.6.1710253678329; Tue, 12 Mar
 2024 07:27:58 -0700 (PDT)
Date: Tue, 12 Mar 2024 07:27:58 -0700
In-Reply-To: <ZfBmZmSHjcXgqVly@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f90e5a06137776f9@google.com>
Subject: Re: [PATCH net] nfc: nci: Fix uninit-value in nci_dev_up
From: syzbot <syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com>
To: ryasuoka@redhat.com
Cc: ryasuoka@redhat.com, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

want either no args or 2 args (repo, branch), got 5

>
> diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
> index 994a0a1efb58..56624387e253 100644
> --- a/net/nfc/nci/ntf.c
> +++ b/net/nfc/nci/ntf.c
> @@ -765,6 +765,9 @@ void nci_ntf_packet(struct nci_dev *ndev, struct sk_buff *skb)
>  		 nci_opcode_oid(ntf_opcode),
>  		 nci_plen(skb->data));
>  
> +	if (!nci_plen(skb->data))
> +		goto end;
> +
>  	/* strip the nci control header */
>  	skb_pull(skb, NCI_CTRL_HDR_SIZE);
>

