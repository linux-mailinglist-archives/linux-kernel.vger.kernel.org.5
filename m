Return-Path: <linux-kernel+bounces-50488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C21CA8479C8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012F21C23359
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940425FEE6;
	Fri,  2 Feb 2024 19:41:12 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D28D15E5DB
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706902872; cv=none; b=SVOdRJTxfXjBER7hmeYNIG5hYmAgp4271DDI22k9ex2YevQop3nA/Vk4/jXQPueSZ62m2821wNhp7WU6/Jzlq3jRZhaSRovHlH+Zp8r9f69fe9/DcDUO80Qq95d1SFAzRK/WCBXiHJeDW/hApQZP+19rQXM2PsbRA/MmRD53nxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706902872; c=relaxed/simple;
	bh=VpngUHRaXYWmrJgabtVDx1DpEtalXhvl7s08O1tQRK4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UPu3Bn0E9ogaAxgXEcIBIpnZIg0c0GkfyoIaAOPA6ozxicZTgewKLoCeLn5ussNRhcFs17k+RKV+KvU6rYEFcKOOmD/1txtCdCyup7slVqyO2TfaUn3lxx5/ef9Dg2SifrkhEhXfQj9edrMhePlrxdLOfujmpAquGOpSVKYNjao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3610073a306so21917725ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 11:41:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706902869; x=1707507669;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VpngUHRaXYWmrJgabtVDx1DpEtalXhvl7s08O1tQRK4=;
        b=WOL6Fpth1+l6eEFDd3tZzzdpCDnMif1rY+/N1aQQOZyucync1suNNlmvGbJeGtjiIN
         11SvdmmZMls4LvaGfKUNVOUzDV2GK8URbXcyNM6OI4+bxdfiamMWUNpym23cQra00tkx
         aYhDgVSOSo2ek+apHrrMctI2QkaA0tgArK0+dWpUN5vbNA1nN9GCKCG7uK1PnSnLdft0
         KtOsnThoPkakrf9zilkRnOtzRXQYTg7eJ4vL/+cXLziwy/xXf7Zu11kCHbdsMydCbODQ
         zbHX0jpeR+PfQwh8nmCmrCZEAe1KToixGWovRQgUpKMnrtKENU5dt93yQo8qUIzAU+7h
         87Vw==
X-Gm-Message-State: AOJu0YykYq9CYFJZy7TKDZwKtKwSZv2cABnTeFGBLNlctvhTt9wKdQXa
	N5Gdzj7VHLQ4QYnAtDH+pA3WRiXQ/4wjsBE52otiMbNmwEJ3fFlU5k5aXCBGJ/qcdwbROWv3ybz
	Zj4fKaZkX4AgUOfKvgjjXKi+9N0G3c9ibdnKS3NLZPHZCLc1NBjrfWQw5pg==
X-Google-Smtp-Source: AGHT+IEpFGyPGC251jR6NEJ01hBF20ClUjR41xzjeCM6BlTlcwfiKorhTaxqZqLyQIEqxpTLtNK+iz02ZC5EXMtL8VhF5iifpusU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cad:b0:361:a961:b31a with SMTP id
 x13-20020a056e021cad00b00361a961b31amr789526ill.5.1706902869444; Fri, 02 Feb
 2024 11:41:09 -0800 (PST)
Date: Fri, 02 Feb 2024 11:41:09 -0800
In-Reply-To: <00000000000021d73706086b097c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033111306106b4b52@google.com>
Subject: Re: [syzbot] Re: possible deadlock in hci_rfkill_set_block
From: syzbot <syzbot+f93d183bc91522d90de9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: possible deadlock in hci_rfkill_set_block
Author: pchelkin@ispras.ru

Was fixed by 769bf60e17ee ("Bluetooth: Fix deadlock in vhci_send_frame").

#syz fix: Bluetooth: Fix deadlock in vhci_send_frame

