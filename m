Return-Path: <linux-kernel+bounces-69839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84797858F59
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08D31C2196D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF927A723;
	Sat, 17 Feb 2024 12:38:31 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAE0171A4
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708173511; cv=none; b=Z7NJqlJirBWgnkXlt33Ucplsn12omvQzmo9ydrh1Y+taw3YuaI16j8afDkFBEXs3BJ65LUmafyq2fh7oUWp/vcRL504haf4rCUZDx44fhFr6+r1wQQL/edoKKx1QU4BQQybmGLOOGCvbt1VrdfCWobGepBdSWn+j1BdtX+EvC30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708173511; c=relaxed/simple;
	bh=ZVaZWsNg6z12Mh5dCOKwS6qVkESFRBc4tEOsrxXFBNw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H+fM+11YZesPhPXfHS8o7NqM09Zi1B4GnWepErhmNgrtyaJcBUGdvGf12NHPzKyHVmV6MJj9gp+ns2binZs4ZY1QqfCVsYgrHz/Ectxw20PpOUGNex0RkoVs0dMMjse66on9ZD3GGZz6PPbNziUffZ98HnVp/5lutiUNhuP0urQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3651a2610d8so3996635ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 04:38:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708173509; x=1708778309;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVaZWsNg6z12Mh5dCOKwS6qVkESFRBc4tEOsrxXFBNw=;
        b=gbGCnQBL+/JJJHAdUjpklTPvHEvHqHHTfEFL8pvGzEe1bUgM2N5V0uL2F0J9Bz6nqZ
         bhJnGbe5l2XdKMp6hnJZ9o9aft5QCAWkODcKxBpJEMUCoRk7bjyV47u9MeHda/hIq4tI
         +UjPje7q9dLAiILpd9eqLRVIRByFWfhYZUZGgIkB9YP+HXWhpJhccP9o9QQucDasBLpJ
         WjlXrRaYzsJ9bbaKECGmwpE+HdzmCkFcVlIq/VL93qt6ncWJwOyJJGK5mA9FMZSVQGYA
         VbYeUhXP0zEb3W+FWRnqBzfUyuKDFLWZW3P/y7jvUOxx+bsma48eFOEhIz/5/KUe+Vvf
         o00A==
X-Gm-Message-State: AOJu0YwBI9WHvvA+RRtzls7Z+15td0NtO6ExvHWOq+zzY3PZUt2CU7yj
	EJ+Q85GeIFtUPP3C8cs3ReuG2hA9MUMDgE69OzT1zYHUC6I0Ue5n+wgntG14d3z0WXGDAUfTdzj
	lmpZZCe0YWmhIUxwXAWWv4Ef/ucR+cVt3+9wcsye7NcIeeCwrdaFawkqfRg==
X-Google-Smtp-Source: AGHT+IHXrJiGK45m2vIQP4dn6UuUSA3prwLLxqDcr4T8HgnnNU3m83ov63kLBW5Oih9XB/Xl7x7We5tMxISrD1cxEVTE93uC5Vhl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1749:b0:363:bc56:765a with SMTP id
 y9-20020a056e02174900b00363bc56765amr541768ill.0.1708173509355; Sat, 17 Feb
 2024 04:38:29 -0800 (PST)
Date: Sat, 17 Feb 2024 04:38:29 -0800
In-Reply-To: <000000000000635bfa0607ed5cdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d73360611932395@google.com>
Subject: Re: [syzbot] WARNING in __nf_unregister_net_hook
From: syzbot <syzbot+de4025c006ec68ac56fc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: WARNING in __nf_unregister_net_hook
Author: fw@strlen.de

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git main

