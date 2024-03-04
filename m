Return-Path: <linux-kernel+bounces-90657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EED448702CB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7AA1F21CAE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451FC3EA6F;
	Mon,  4 Mar 2024 13:32:38 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9B33DB9B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559157; cv=none; b=UJXQYZYrFoIjRapLW+iotCMJdrHPlsIZcn6MBE9vRBm9hoIzHItDXpHHo6G5lAAZc8iha3ShOC6ab3eza1hya73lnisXr3zJBEGYKeyv8jhmNj6rWmzWxrWv77DoPb0KSiIoTajl4ltfZ1ELTvt67HAFkx4SCb/jePt2XzBWa/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559157; c=relaxed/simple;
	bh=WpEhD0DLpAmvkEc1e3g2sAW2YLB3LmBEFxRyGwWYYE0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bkvO36sDiat+fuCI/uPudaU/6wGxkN62CcRvcs3vY9xYghwvh+2pFhP/HnLYVpm0wX64uKIiEht02iMKBo4tb90fPyJ1I/a1s1COyWgVUR3xcS7r5MIa3BaCUsmFZbj9rFRrdVqGilV1+rM+rjg08GKpCiXpHLz5dhco8nhoJV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3651a261194so42041455ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 05:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709559155; x=1710163955;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WpEhD0DLpAmvkEc1e3g2sAW2YLB3LmBEFxRyGwWYYE0=;
        b=OZV/T8jMIaeFbaERBETx+9ybuPxLFIF063slcN/Wjx1CcZEd2sxxaw2Qp7LfO6Z9WI
         BORcWCH135tYxdE6O1mAMAmncYMah2w0e5TOQ3s2MhhvLRoB9lpevIVPzRSRjq+J57xz
         DULdMULLHUyRFXbj1V/ahL1+Lfv/IUfVXqZ7TtkzJIZ+mYlKXNTagd+9NezmHCMegXQ8
         uUZunYvufEYr8NqAOXtbNJz6/eI1VO3v3lyNxu4KCJ5hrNgNO3aszcI4g9Yf20U8y6yG
         1iGifbAr6DpoCkOUs4REBCavYEHnb0qE5q60wyQ5IvHbWK5wFlDlS0STa/odOKk4JuKd
         6ixw==
X-Gm-Message-State: AOJu0YwNwYWxg72ClUAqRejyOjiQa7ADOGGL9s8k9y9U9swuFYoEdlsM
	wl1AOKJhqOS6nm/w4WTh2S9rJU9/cl4kWwyUNdg6YE8sMSgKFjnPtJ2vHnbJ1qPjNMCIWSEGuIt
	dq+FII7W08jncTZts4dEM+HohhL0K+9aMaLLA3Y2lGjuFQfXa6uutNPpBDQ==
X-Google-Smtp-Source: AGHT+IEyv5Kf6/tqOOSOsxw4aG2t3DQmU0YJWsM6e9L2A5xttKNiLdGWwmKtgMwQ7xM1uF8oOIvDUDif9DIMFcKazp/it87ttRSD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a48:b0:365:2f19:e597 with SMTP id
 u8-20020a056e021a4800b003652f19e597mr494996ilv.5.1709559155718; Mon, 04 Mar
 2024 05:32:35 -0800 (PST)
Date: Mon, 04 Mar 2024 05:32:35 -0800
In-Reply-To: <000000000000c456810605e6997c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000330a080612d5c29d@google.com>
Subject: Re: [syzbot] Re: [syzbot] [fs?] BUG: sleeping function called from
 invalid context in bdev_getblk
From: syzbot <syzbot+51c61e2b1259fcd64071@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context in bdev_getblk
Author: penguin-kernel@i-love.sakura.ne.jp

#syz dup: BUG: sleeping function called from invalid context in __getblk_gfp


