Return-Path: <linux-kernel+bounces-135178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FBD89BC3D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 003BBB216E1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C814C62E;
	Mon,  8 Apr 2024 09:48:13 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27EF47F65
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712569693; cv=none; b=eB/R3DtbhEoi09LRQ9hzVi3jIMtvbWwEJupdq1sH+xD6YL9DoPQARUuEtzp3iqhVxlYiI07tQUt4Huoawsw1w2+OgplTnkbQPY4N6BldYnR3j8Y558aM28JVlq/g6xUXAtqKP9je5yZ/DVST1J3CWd26tPMaBVm9hiSuGYo4fmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712569693; c=relaxed/simple;
	bh=B3c7jNV9BXXJaRMCccWHNwl/HrlanMummeLPvpzZEEk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fITWDL6yDv5dG4lnyS6/AuC7/Ac/o1IYXBGME1dEic9brjlY34vAcxOtQO5D3U1PwImeXRLoWz1cDq+gx5SiQCLFh+27LxSSg6LW4Ee3gwW8PTCyQE2OuyLkVsDkDJm7J/NzjRt2R0GsleEjfPgqh/mLTxrxJYI+ZxzAbeuNf6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc7a6a04d9so529143739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712569691; x=1713174491;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3c7jNV9BXXJaRMCccWHNwl/HrlanMummeLPvpzZEEk=;
        b=dUleZwzEGdr/jn0Q0naa9o6ZtVZBM30xDYzH+c3J9OI7/h4Msu0JtudFGZ4lgYVlHf
         TrJ3vMR1MeSihuNZvFb63aJS9QS5LMYMYQbrw0AGLgt/hHKJ5qQm39pi/1zzrkAfGKNI
         xVrr8HmA1IQZyV1LpInMoW6dBWx86t3aVSoNDgDsMdk3kL6ncELcAhGrB47pr+rFzQ8Z
         jft42fjfSk7d0Se8brUEZQ5jQkGTZ7m9gZYBXe6J5C+PugUAjbJ2TzNxXcMnoJmzFoL0
         sBJAUQRP2vqZk+IXFKhyyL5Ueb1ixONFO6UM7edyRw+fkTMwpW2vWatQ4DvMgcE3esuc
         uDbA==
X-Gm-Message-State: AOJu0Yzsx5DwUQeDoo+iauaKCLlodmFbDCydsABAx8v+lJlkrXFrHUhs
	D+iQtJEj68j1oZFmNNMHIgvBC7wnJQqPAOFlJKgeXJ2Ok50K+HgmdVCQalkpRDQSm2FaeEkT8vs
	E2nMs4ijBb/kzn/ncO3A6s++r0nO6oG34vvzsVwmcOi0i8wCPGDq6Zajw9A==
X-Google-Smtp-Source: AGHT+IFsWl0feObcrLLO5++vJFpy63MtW2Wwk8VZFzzvYyy9iXhqKlyLbwoRB92xgM4guwu4mzJtE3PzHW4tBEr+mxugftVYd5q4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4115:b0:47e:c165:74dc with SMTP id
 ay21-20020a056638411500b0047ec16574dcmr523112jab.5.1712569691015; Mon, 08 Apr
 2024 02:48:11 -0700 (PDT)
Date: Mon, 08 Apr 2024 02:48:10 -0700
In-Reply-To: <00000000000092c8da06154be4f5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000161d41061592b467@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] KASAN: slab-use-after-free Read in bpf_link_free
From: syzbot <syzbot+b3851d693eb8edda5c7d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bpf?] KASAN: slab-use-after-free Read in bpf_link_free
Author: nogikh@google.com

#syz fix: bpf: support deferring bpf_link dealloc to after RCU grace period

