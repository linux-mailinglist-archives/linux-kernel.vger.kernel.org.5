Return-Path: <linux-kernel+bounces-105586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A4D87E111
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9F5EB20D41
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6ED2135B;
	Sun, 17 Mar 2024 23:21:55 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DA01E865
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 23:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710717715; cv=none; b=GbK5+tVnCZ229E2Lwt8HckxxBhzSzF81lpe0UNTYOCsg+saWYuhsiUteUXYkmElr+gMV4RWJla5XHHSuL/VBhcEYkmvFUBZkzKfPiEWyMSR0acQ3vgtHW3wLV7P9De9dVjy8D9/1yt9tqKJf0RqTEiwmMKjif/AMdg+Qx+W/2yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710717715; c=relaxed/simple;
	bh=mjMZn/TsoTLCeSjrcICd7OEFULTmo76hW19zPRx/dN4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RmnSIs3am4OpUPAbxYFwHDCqk/IZQCLHSKVrD7yE/ZLZ1SOqWp+2OA/q1d+tp5kqoets7w6iSmCE+iH0QeIgpCvVczhna2XZrrzr3J3WHM7Qs/RQKVvb00wRwXgzfWtVrOTBG3O03GHZFQfhj/3UPRQaQMJl110gQau4yW+xBxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc0a422d43so138751439f.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 16:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710717713; x=1711322513;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VovdwbrLMUQrTAVXK4SlQU2CYlJRHIqofTUQZAZWDqI=;
        b=qWor+HLeJVuvGOPC5zkij7CguwFOj5YrmFl0zzmrUBKMO6ftlpGc9bGaBVcxRNt3Hu
         ki6jf+9ZsIbLRrYdITvah2BhdES7fiJVQMvH+kxCo5EuteHWbc7JTzs1WGHjlykw50+p
         H53cP3wbv0X7nPNTns9xlJlWRTUybIbsTpbhJQnszaPyq9vH1Weblw1k53K1Jp3BCTc5
         7YYcCUVjBBxctazyBauIVJl4EvWWYjFjzqDV1zsauJCGbnEJOaieDsx2mkGmdQ+O7kvD
         MJ+0LhlXUNqmKyN7na8FXS1dfu+M+lg8B90vKA8LkEMfWgFBbTydOTpOKOuL+29cC24k
         qKEw==
X-Gm-Message-State: AOJu0Yw1rVfrJd+GXlBPJbR6Ne5i236iQeU6g2EdoPdYEMki486S04/s
	cKzKR+PIv2MgkmAcgBk5D62GQ0THSSK6JiVP8Nj8PmO80yrgacQRmwyBuyWVa1bNw75Ok+EAg3s
	4o2tXUGKVDqBjE8CJBjHNJYNi8eQ+vyBAntY4VnrBtuqW6XA4Dgi0v1HBUw==
X-Google-Smtp-Source: AGHT+IFiHRpbjXWEMyYZcgkFfel8JpEBsQIpOwklgC18jlt5/PPws4xxFmkwOW/3cd0y1cLaS0SIBN5ZMMht1P09/KwJkKgZOi7z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6298:b0:476:ed01:d221 with SMTP id
 fh24-20020a056638629800b00476ed01d221mr542730jab.2.1710717712808; Sun, 17 Mar
 2024 16:21:52 -0700 (PDT)
Date: Sun, 17 Mar 2024 16:21:52 -0700
In-Reply-To: <000000000000f66a3005fa578223@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000954b4e0613e381dc@google.com>
Subject: Re: [syzbot] Re: KMSAN: uninit-value in __crc32c_le_base (3)
From: syzbot <syzbot+a6d6b8fffa294705dbd8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KMSAN: uninit-value in __crc32c_le_base (3)
Author: david@fromorbit.com

On Mon, Mar 18, 2024 at 09:52:35AM +1100, Dave Chinner wrote:
> This XFS issue was fixed in 6.8 by commit 0573676fdde7. I'm closing
> this so the future reproduction of this same error signatiure on
> btrfs and other filesystems trigger a new issue to be reported..

#syz fix: xfs: initialise di_crc in xfs_log_dinode
-- 
Dave Chinner
david@fromorbit.com

