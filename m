Return-Path: <linux-kernel+bounces-163454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6468B6B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495B32824FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77419374E3;
	Tue, 30 Apr 2024 07:13:02 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28C72C853
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461182; cv=none; b=KUDxIoYKaC+xoSI4TDB2DRWYpEUZQe93QA7BRZ9blTTJkBd/5NKUILgAczPEUcRUui7zjkK2dTY1M+PaeMKMbw6MUCO1WVhZW3CDo/uzZXzeZ1/T/KNhNGNVO2fkfm+PUzbvXr2TWWBZHTOb6GEaJ75syBxl87ojimLxO/wpKv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461182; c=relaxed/simple;
	bh=CXJgUhz8OYEEkYzJZrXQnLGGmaASP98O5B5szOrjNpw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EBL7wK7GqHDwe7XPmwWUTbtpvXieB3zyAxk0TRbYfSXRFbC40zZozLdoKJuBN7YK6Wwtn9LbyE8ZnB4Qa3odsFgUsf9U/UUGaAweevLRYh/Hae2trZXYA8xsPCpl/QGZEMfVe81I0GSmKcs1bCaTmgvv6vvFWyIw2xbJQR9xIRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dad65e5613so582805539f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714461180; x=1715065980;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXJgUhz8OYEEkYzJZrXQnLGGmaASP98O5B5szOrjNpw=;
        b=HOadIpoI25572YrOO2+xD5gxABuTeA3eqh1JwaqIMbI5y52yMEpG594ae3hKQ6HNEd
         pONn0buz7kSG+strpunhkNzCdYB5cdomv/8VWcKUgu0iTkrop9wvPMsDWcgDsqPTOc8A
         ineUbdwVMikTSsoh+nM1mqKh2/6plk1Nl18PoNaEato01vijVsjTWcMls4OPQbIIV4jt
         mJR+P57IDqYpfDTBJWvG2lbf6jHt2jDKzdRKChs7mqWOUtjm9Akf/YT/bF63GneuE9Y3
         7Kxgg9yFBLdBsndeWta4gCXuxNAFNhtoJidpTnT8HfCyUo8UB/os0IVeFL899+jpr26H
         a+6Q==
X-Gm-Message-State: AOJu0YzcdtQ9DdDWPQTLNDkHPoTYSBcECWQDUFrWtlmBcY5ea40UuJxj
	wLKmpLqW5j7zIq2UJBoOX0A2WqZaZ4qBrGrTrwRsv0wtHktIVz/f9dUb0P+qKGt1EGmzSOw9n+O
	oDydg/lce3ydX5JlIzwO7Ex/Wzk4IhgwOnAdH9Av0Z0cSt2Ba7d9X7GE=
X-Google-Smtp-Source: AGHT+IF5Acrq5/8chhE1GwMH4oFd0vDG/J9BQwPr2pkA6SsruNAOp2P/2SYJDJN/08TBDG5O06xAE/aJ5KPYY9Yy3pvdijfjFOba
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8314:b0:482:e78a:899c with SMTP id
 io20-20020a056638831400b00482e78a899cmr1072592jab.3.1714461180051; Tue, 30
 Apr 2024 00:13:00 -0700 (PDT)
Date: Tue, 30 Apr 2024 00:13:00 -0700
In-Reply-To: <000000000000440b0a06173e6ca8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e509d06174b1980@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in ext4_inlinedir_to_tree
From: syzbot <syzbot+eaba5abe296837a640c0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in ext4_inlinedir_to_tree
Author: shenxiaxi26@gmail.com

#syz test

