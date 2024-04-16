Return-Path: <linux-kernel+bounces-146042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AF08A5F58
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA141C20DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD077483;
	Tue, 16 Apr 2024 00:37:28 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1D15672
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713227848; cv=none; b=TgbmcvBKai3uXPAU+xVOyxJLadLCHxZ9QttL44JMUrd/gzZijqvs2NZ69hvFQfo+fpFpBoMeU6gVb7/OWq/S08qkyjpCNii8IZkupFJkVNKFvlDHLDL/iJhCQj9JbLWrmbWLmjDkoZloAbuvaqBWj0ESV078cHBs4+FI3tf0jNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713227848; c=relaxed/simple;
	bh=7J6ZGm5CDnAs5QG+bkk5fi6kYwsiJK9I+lK6nOQq50c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QDfg2cmzOWG3yk19CeMJSNRbPF9HnMueLH8c1xK6/FoKDVvox8fpLI3hheA6+fw7WWWy20AKXraUcAKyGggbC0i54bUWEE/qRkXcPZabAyD1rXuGvfySiF29XGN6a1uKsjozq1A4tsdST0RO7bTlif57RiXw4/O+gfsZ/P9st6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d622cae9e4so417895339f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713227846; x=1713832646;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4EGDd97yZC2zzxp33R1T3y2FHVivTeXkINHK9MRZer0=;
        b=X5JKpRhPjruNzPn2t4IMdDoVQ5lrUz2ip2g4YF6UJc7Ys7+3z+Jx9N3OxusNZBaTuN
         a+I/j1spP7EwsN/vTbQlcVHd8HaF7KDvLcvzjKMx9W5D0fGmcMmyuzu+kYT8OPRX3Jl1
         kQvk7LVQhMLXkIeGcIh5uBaPMzy8jQwuoVc5xzAJ+zudx1yZAtOb/ly1yM4OFYHd5yPz
         lASdmcc4RZXRBj1nENLyYLNqptrMfBsjtN8w/slxZLoXFQSjTO0HNV8WOO1yveUo5TuR
         Ckh6TKuM/SxMhBbKCBVZ/FhzvrtrxfDcsMGhZ/6MOXRoS9T10Pdv43gkq3D/a7flD1uW
         0eDA==
X-Gm-Message-State: AOJu0Yxwe+AMzMkG2n5+fFvRqtAbpDRrhrRRkCJZzJn2O8GSn0tKdGtU
	gsve+NFjAupqm7+YMQqqhZMigIZIPsoL7YtkNjloGfZa0clCMeJVyu7U3whP9g6rxiTRcn4tDit
	3r85JFwEtnfSSOmIxcmGjHYZeKysRgG62PKgDBOOfpdAhmL7m67x1DUk=
X-Google-Smtp-Source: AGHT+IHToNU0SPsX92zO/hwvR7EXBsOfrIAZhwqtBLo1uCDoOIUsrgK3WEO6znhVYPcXnaw2IzLBL0KTHzAoz1Gkx8cTNROKNRcM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2582:b0:482:ced6:e5f5 with SMTP id
 s2-20020a056638258200b00482ced6e5f5mr741508jat.1.1713227846277; Mon, 15 Apr
 2024 17:37:26 -0700 (PDT)
Date: Mon, 15 Apr 2024 17:37:26 -0700
In-Reply-To: <000000000000208dc20608a2cbb4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032680606162bf171@google.com>
Subject: Re: [syzbot] test arm64, please
From: syzbot <syzbot+84f695756ed0c4bb3aba@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: test arm64, please
Author: andrew.kanner@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

-- 
Andrew Kanner

