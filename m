Return-Path: <linux-kernel+bounces-50526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85163847A3B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81B11C25308
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E97B80628;
	Fri,  2 Feb 2024 20:04:37 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BA7182B9
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706904276; cv=none; b=WhIsAO/un08cc35b4Tse4N5PGRmm4C7v1FNrium8kVqpc131oGvHco2hFoPUofms3jnZ7gz7k69h3EJ3DV+8ObT4t9wzVxXgz82NScvtSK6ZIathAoqOBkM1xGbjt8HS9gQ4LH1UcbFfP1hUthhNJfZa2iQpA3t/+CJlsggOcIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706904276; c=relaxed/simple;
	bh=V1VQqFLAkrpbWV7SZVFnSmm/4adUuUJqwtYUdKoILuw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=McRU+xXdckjiOwH1uCPAsCto13pwIxHjAfIWb+hT6iAfDSOn37BywyAyD2RA667Ea74UaeTtTyxKY7HlSc7EvGv/bR5pQjptPV2MiMMY5+CS6hyGy3/OnTbRlQl/L9fTBTUttrnHRCRnyMkvwce3LT1yNWwE4xKeoOUeY5geOJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c0001148c3so193584939f.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 12:04:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706904274; x=1707509074;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1VQqFLAkrpbWV7SZVFnSmm/4adUuUJqwtYUdKoILuw=;
        b=wMA6kD/+PqkarntW7jGl9QVFr2VKZP9zMls+nRh8BuX4oymCUy/ht+/y750fJIFvM2
         AeIxdpqXaMSvb/bQ819x79rI4holeQbL0f9EAyTCiKhQK+PkVK3Aef5hVYRZXEOTg52/
         nzoAeD7riBYemuYW77lnva8Crgk62CX6ljb51usTbn8LWQlOST0wh/+lOEssUu3zV1cS
         WBywat9x1BVnWhCOVvFO+GVOYmydewAzlHiy1UswxUlV1dZ95Kuz9w2BKJQd5pxhki/Z
         WW3IYmo7Bem3XLsfdr16Hr9nb3rXG1WSgJezIp3ATl6RAlI35WwyxzhoCEU7PZnR3Mpq
         lfjg==
X-Gm-Message-State: AOJu0YwyL+Ip7MEAF8b90bhfqOMY3KMHcFPydjX68y421hK2nxoDqvIZ
	ieVc8oNANBY/iAKJcj2oUGBuFF1Q3nJ/rDtgfJNqYdJGOV4eV7JlYhXMgV62E0oQfE1YRF3kPtX
	lpomTgyoEUtx2NX3pmctVSzU1K3+HriIbYGacMm43TZfEqxhBRAcsngIX3w==
X-Google-Smtp-Source: AGHT+IHhVQDv08DHAQTVM37VeRSedTQoMWl0+0fU8XPCxTleTIIWxK3pON4e42BaoNW9JeV5a6hE3evIy4xZJHpTjL0AySDeqnI+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a04:b0:363:b5e3:1082 with SMTP id
 s4-20020a056e021a0400b00363b5e31082mr162053ild.4.1706904274086; Fri, 02 Feb
 2024 12:04:34 -0800 (PST)
Date: Fri, 02 Feb 2024 12:04:34 -0800
In-Reply-To: <000000000000936c2d0606280cb2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec387a06106b9e75@google.com>
Subject: Re: [syzbot] Re: possible deadlock in hci_dev_do_close
From: syzbot <syzbot+4e3a76c5c505a3f49083@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: possible deadlock in hci_dev_do_close
Author: pchelkin@ispras.ru

#syz dup: possible deadlock in hci_rfkill_set_block


