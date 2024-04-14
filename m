Return-Path: <linux-kernel+bounces-144300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E87598A444B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EFA21F2132B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4760013540C;
	Sun, 14 Apr 2024 17:04:13 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAD21DDD1
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713114252; cv=none; b=uFMZpKZZ5yvc7LNo56nc+ARkxxYHk5QA3zfsz0fO6yWYAB+WQlBo7AQ4ooat4iIlfbi4KIoW2sEZfqAKss6ehOaEI9xvjqa3iVM12vUIPA+EM0H+fAYof1BqgVLR66rFK/GdP460SyzgNwwVJxnwQy9HFx13WBQO5JdteCL1bEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713114252; c=relaxed/simple;
	bh=debj838TIjKGGV2pF9ZfKT/BaVHNgGu9cDOaPEhzIv4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TMOOcWaRauhn8/gLXdlJR/lEZ9Nrgq9GKdamT5sfiK2JcGgy8zB1dS6CL8+gLh45cAGHwPalEUxXvYqYGSdAufu7zllUCXnq2RH+sFNH1xl6jm2AfpF1AY+ZizAFNcdRkoc2rDqayA/jsIMOtxNz9h5LVuuRNc/BgysPElWhsFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d5db4db530so241903739f.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 10:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713114251; x=1713719051;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=debj838TIjKGGV2pF9ZfKT/BaVHNgGu9cDOaPEhzIv4=;
        b=vYBDsRPKjB1kBR3HwdA6LNmwrxjG8yEjV0nariPvGOMyhEGMtxcd69dYhvAVDZna7H
         doiHEPjNBjLrgZHYRr0Bb1kuNAzGXxToxXAvYxAqWYtRUdF4C729QOOYuTR+o4hMcRU+
         E9SGgd4R7WB6aJdy224uMduulXoFuVQ5VEovMGup7WYAb+FtvbQB8grZeh0/m5OFw4zY
         zveyw5wb1ohOEamNyGt0+kVbE7U6yGjNPLidGb+JLWW0GDtNQ5g2Hqw4850PBMmsODWR
         nyfVgFxx81Mb+hiyVE8CvaXk1CLRventP77obKCTcZCAMlir/8sGsUZP1H9+9IKxZLoN
         DYng==
X-Gm-Message-State: AOJu0YzR0iOYx/kd9DWRJ8A5zo+vk4Pdg6YPTI/XIXBeNBlGCVcVdVnJ
	PdYrV/oeKWMoLFJfKUoSA2kY5fOgYy9F0/D0y/RAMQsmhcC+aCZyzgbMkk7zRVh124IOFI7lEiL
	BuqV8jWMQbbvZQIcKDuXNTYEKgk10mnqfdOyWnauImcj04+UJ7d0rUyo=
X-Google-Smtp-Source: AGHT+IFTv2itsETysGy+hw8HXIs/0UEl01bacw6HadxW2mu/1dv4LtumGYLih9IHjT9Me9ytlqVa9nOs/u8qdH8kfvRBrxR/KQgX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2110:b0:482:cfdd:daeb with SMTP id
 n16-20020a056638211000b00482cfdddaebmr464871jaj.5.1713114250898; Sun, 14 Apr
 2024 10:04:10 -0700 (PDT)
Date: Sun, 14 Apr 2024 10:04:10 -0700
In-Reply-To: <0000000000005ad04005ee48897f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062842d0616117ec0@google.com>
Subject: Re: [syzbot] mm: page_alloc: Fix uninitialized variable in hfs_revalidate_dentry
From: syzbot <syzbot+3ae6be33a50b5aae4dab@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: mm: page_alloc: Fix uninitialized variable in hfs_revalidate_dentry
Author: shresthprasad7@gmail.com

#syz test

