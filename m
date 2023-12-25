Return-Path: <linux-kernel+bounces-11125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B394981E1B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 18:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41328282229
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 17:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FF752F86;
	Mon, 25 Dec 2023 17:31:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2B952F65
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b7fa6cba91so490812639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 09:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703525467; x=1704130267;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFqI58q7VNYJmMslCgc+pTUxt4F8ra7+YSzIXJuw1CI=;
        b=N2GylGeCe+DKNyebnR0aQGziL7x2dinq30Wr6JiB+8E3wVJFdYBsP+Qf3f3cy0rP8g
         rMVIz9LfCHJEI3BwkYq8NHBv7AJHnURTTdVrAj3OEgDV0rwNaFim8Ev0sTtUTe/tTbV2
         AO46sidcOY0WQdmRc3K8UHpPtntTBqTHfDdQpa6QK1K1X3srMHDXh0hxooiYlmOO6AsF
         e300OCXCrjgBV6t/gaAV41n6rXjir7kVvV+l76BSKbCvz6N6ChzrKS35M6JMD2mD6bSr
         +gdJ5/JRC0WROlnz6YsO2t7wXlhFMz60LZbAi7gXG+8IiuqhWTh3cIw4NJbPsxV+Y967
         RYdQ==
X-Gm-Message-State: AOJu0Yz/LxJTa7uKyfGBFJsERpxoQy1LP4+U/FYb5ltm9O0P2cqfSSjj
	AGFvMU8S3xN6TLNsG67Ya/P5HFBGAgjBIZgZ0cIiY27rOzJX
X-Google-Smtp-Source: AGHT+IG150p2eMqab1PfIi2zECmHDFBS0UnssC+uKVBgIAlE5EIKxdwzS9Wj1PI8eSGg+CAuQ8PyuEKXFEI4yjrkYGt1uF1mvnCE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c243:0:b0:35f:e976:3283 with SMTP id
 k3-20020a92c243000000b0035fe9763283mr613348ilo.2.1703525467494; Mon, 25 Dec
 2023 09:31:07 -0800 (PST)
Date: Mon, 25 Dec 2023 09:31:07 -0800
In-Reply-To: <000000000000e8099a060cee1003@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b23dc060d58ee7a@google.com>
Subject: Re: [syzbot] [perf?] WARNING in perf_event_open
From: syzbot <syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	netdev@vger.kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 382c27f4ed28f803b1f1473ac2d8db0afc795a1b
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Wed Nov 29 14:24:52 2023 +0000

    perf: Fix perf_event_validate_size()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170e70cee80000
start commit:   5abde6246522 bpf: Avoid unnecessary use of comma operator ..
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=148e70cee80000
console output: https://syzkaller.appspot.com/x/log.txt?x=108e70cee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f565e10f0b1e1fc
dashboard link: https://syzkaller.appspot.com/bug?extid=07144c543a5c002c7305
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14857e81e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1126ac36e80000

Reported-by: syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com
Fixes: 382c27f4ed28 ("perf: Fix perf_event_validate_size()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

