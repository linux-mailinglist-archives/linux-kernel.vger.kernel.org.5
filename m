Return-Path: <linux-kernel+bounces-38556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 516E783C191
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82FABB244FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA304655C;
	Thu, 25 Jan 2024 11:59:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17702405F2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706183946; cv=none; b=m4hdYt6tO/HIjAzbYRaJBZ9TH7UE+xyh3EjJhDNxUwDaMj0ol8bU9ob8G3QQRbO1SR9fUhuLreawPek/KQBW1nSO6GU+Udun+jh8f8zW1TO0KgxrcEYEzR+NA0R5wPJ5W16udm5L66tnzaxwVrfsP9n3n2FgHP4Io/JMzHntZak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706183946; c=relaxed/simple;
	bh=5IeaVdhF5LtzIsAPk6LztQlW/FDS4ghLmFVK+1cJZBA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DfRK8cT4MfomjnVO9UeblNOM2lyI34QWYt0iyDozriAiAMn3eY9uNFakfkJ2Czh7r8+Fc2i1kIpOnnNr+Ubxe8pHfiCa9ICethYYTiH9LVNx9HH2FhLj9RUoICroep9G+BQrXNCipCzHUpRcpyO5ggE+bqx90U/tFhuMAc/0s3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bef5e512b6so657010339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706183944; x=1706788744;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/iub3MHAFwcdo/Gqv4i8H6fRbSsG4isv2FzsUCWJ2Q=;
        b=w7aUfG2khAVgod1D9fNwQXnZWG0ZodUVmJ1NxZVpYouRRcq2mZjD6FJ5lrmoczI17R
         SZtp/qQNCCtS1nDpz20ZafkDXW7Qwrs4YneyXKKxjkhRnCnbv9So3ECCO+DLXjtGcIZu
         v6tHgDLndUMBKzV0iN0b1hyvv3Gz739RmGEeTHoGlXbRU4IKvIf+7hhT3rbuisw5UoPq
         56cuSiUZWHY86S+vhD43CSCCssX6BsqYcZ6cQ1BkteN6r06DUhTngJuy6R27y3mo6OET
         W41sBaZo3JW0LM7Ba3PUDTBnakYyvGXjr8eaegiZUHFOrTcVdPCFemUqg7XdDUtSTXV+
         e9ig==
X-Gm-Message-State: AOJu0YzBwQNZPxJLgYKcQfFUmHAaiT4j53Dcqguf17HbWqJL/ot58M2R
	5Vv2XUl5LQHeximxNPrVaZ5OgM99VZdxlk6IcQZMAdNztAGJ+FimB3y9+3gmSuUGMJ7Jut21UWm
	qtyqo4c6qVljbfE/y/O46Sbim5C3JkH2NWpJdtqefjQU+N4vLRu179YA=
X-Google-Smtp-Source: AGHT+IHyn2Qwd5HMJ7IxpvO0WYV/RjdhuSh6ltkRkTWpD1C389xewU6uddZnAn6Y8UCvfgydKDiM2O+RIWXKLEy9yto1g0WIYVHI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1921:b0:46e:d83d:472f with SMTP id
 p33-20020a056638192100b0046ed83d472fmr57559jal.0.1706183943905; Thu, 25 Jan
 2024 03:59:03 -0800 (PST)
Date: Thu, 25 Jan 2024 03:59:03 -0800
In-Reply-To: <00000000000083513f060340d472@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5e71a060fc3e747@google.com>
Subject: Re: [syzbot] [jfs?] INFO: task hung in path_mount (2)
From: syzbot <syzbot+fb337a5ea8454f5f1e3f@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, hdanton@sina.com, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13175a53e80000
start commit:   2ccdd1b13c59 Linux 6.5-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c37cc0e4fcc5f8d
dashboard link: https://syzkaller.appspot.com/bug?extid=fb337a5ea8454f5f1e3f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ba5d53a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14265373a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

