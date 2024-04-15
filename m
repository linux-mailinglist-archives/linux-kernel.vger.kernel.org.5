Return-Path: <linux-kernel+bounces-145376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FB38A551F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F308282B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE62762CD;
	Mon, 15 Apr 2024 14:41:09 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F363BBE1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192068; cv=none; b=fKOCCbipoAopF+C6ktrBoHBOeOuj4mZwLDi9g7Ne2o/CZvVSFiGtlodhdJBzyekXRzfsqJsLauFstLtxnXBOnL/xWfTMs4uPD4fBk4H4pi55VybSla9Q3UUIZi3sslUVyL7TAVCN9gdDzYtadSENpY2kQHeC+7kklECxS/Irt14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192068; c=relaxed/simple;
	bh=m+HdDt86hIVHu8K5Kb8QTBfIr0zwmXUnaLGV+V+Lq9g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Eb8xx5LovOvzk1ZWejxM68ZilY5LdMAOOOCI5cDgZsFw+0NhTRKJYeO/SM3WElYB686YmKsDCbbDgtkwxUyt3RJyIHLjrXtlZLPTE9B93oH8KIzqkuRNnVM98um/ogaveAZnrAPjybiyo3EQ/BZjJJw1VLViD1r/6v68rrQMz+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d663e01e24so354919339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713192067; x=1713796867;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+HdDt86hIVHu8K5Kb8QTBfIr0zwmXUnaLGV+V+Lq9g=;
        b=fagNQFQMqRGz5ujX9H7Pzn6wzeH74AP6TmMx6jSXJDZlany4mHYlfTtwmRj/NFk4Ts
         6X7CNpsq0dbst9aFnftYLhATZbLG6izUjreB3jCg0BfORJGDwTgzD7e0ltNFtohZUsSz
         AA+njvV73nQkfZHJPEoAIsUXoTgEjWDi4wq2npNN2V5EOrhiyhHCxueyRtTZO62pECEV
         TYdcEwVeU4EdtpVNmn1t6nEGmNmxzRCeuNY/p/l7hwNtgCXbau+bBnv+X4n2UoIek232
         6CmGF44ecRn7cr9FscHe1+MXyVn4WZQTOL6c77pR5rpqeM/9zVN1m6zGoqpRJaHQcAm0
         fjUQ==
X-Gm-Message-State: AOJu0YxTLkmGJuMnPhTyIDnhAHxObYqoc2RsOUyVCu97+HqvI3SSbBcZ
	m+CIsyhmHm5+ujdDU+0UCjbD+3xNBYGN7AhPiTSYekWikzgMjj6OanBWNdXPd3Oly1duQCeoaeX
	HpQnsWfoLr775QvU9D3j1VOnGL5+2qa1QWME7PjwQhPE6YIEf3Leo9FE=
X-Google-Smtp-Source: AGHT+IFNjNumE/WdzKBUfKsFw3/dL1afZQp7XmDqdwFbiMedemz6Ym+ze6536DieN7xt8E+/EA2OvbxW7Sps/1nhjYWtYeystSiK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:130f:b0:482:b67c:4573 with SMTP id
 r15-20020a056638130f00b00482b67c4573mr615933jad.5.1713192066867; Mon, 15 Apr
 2024 07:41:06 -0700 (PDT)
Date: Mon, 15 Apr 2024 07:41:06 -0700
In-Reply-To: <000000000000346bbd0613dc4396@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093f45c0616239cf3@google.com>
Subject: Re: [syzbot] Re: [syzbot] [usb?] WARNING in usbnet_start_xmit/usb_submit_urb
 (2)
From: syzbot <syzbot+d693c07c6f647e0388d3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [usb?] WARNING in usbnet_start_xmit/usb_submit_urb (2)
Author: n.zhandarovich@fintech.ru

Test if this issue wasn't a fluke.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fe46a7dd189e

