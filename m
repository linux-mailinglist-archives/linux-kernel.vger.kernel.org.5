Return-Path: <linux-kernel+bounces-46769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0338443DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805DC29244A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D355112AAEB;
	Wed, 31 Jan 2024 16:14:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085B212AAD0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717647; cv=none; b=RIYknUL0AbpigP/SXPAO/OUII1txKNs/GPhbwDim77Qzk0L0SwJaSuXR4HOWfq3LsaC/TOMCZiLBRPHa1wu7Ubb8xCx7pjUISbga+oIrGgAINaL2wenUVmKzVQeXm0R15efQdiXgczv2wJ73L5lfncn7JOISY7/kiQxs9OXtD8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717647; c=relaxed/simple;
	bh=A1fWPJMcPKVDe97TCze0kn9vCXMG7CGV77DI6GDTNKo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ta00XGSVD3ge7zNigZpu0KCA5YnD8VSZLztRq3beAVXozjnCA3OYv0qhrFVKeF7QzmIyP1EpHC25yZbHfs8wzcK4wdxNRhh0ZoYcgNFi7Eq/gQmteaSEdT2r45XxyeCQsaQXPeNV44c6cFk0cgHT4kiqWQRz5iNF+Si7CqnldiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bfeba24176so249051139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706717645; x=1707322445;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQUmwtOkFRM7KqPQ9qvbP84CReQbIyJiTbTpdPkrhRc=;
        b=CDudTQ6EI1lrXLUqjHg4hLInt2EeC/6HmjW/b+mjI2/VtZRlByJGGlVBKz/+tSI6O1
         W+fzQePDctEhorKlzuUgC5s5FY1kayCzqhsqDTW1lRVtPdIWMQkPLg48LxKnNQssYKZQ
         Z8aLaZzyG6qLSVCYlsRItie4n260fcD0d7+/16FOfHNHa5EMqOAVFw+QMlZH89gtA4+h
         GZC0nLYa2j0umfzrYIIIi4I4vMtpDzYD/dstnxieqnDiFXyie/S3ZfPUriqA0SEoJ00U
         ldq3rTwGp9es8CU/B6FOwwUV+vePcxHNmwaaWFsZPUumPO4uaCwJCONcyp/3ckPO1FJN
         q81Q==
X-Gm-Message-State: AOJu0YyaDK68mQTT1AiQslEWyjijNQn0pPgvrKLe7udvLjBRITqmcPSH
	TDHGTGSqdN/qOXgf5pCdKRb018Wr2QFCOx5bUdpUaTl3WY4EIqDhSICQibQlhaIidbLtIdSmyOb
	D6sVmpJdBaqWAgN3GwiXghL45KMNfyWI1ZYUe/dF8elhMRAlOHNM9vVE=
X-Google-Smtp-Source: AGHT+IHw2ii/HEUSAdi4sT5QuRvIX6/CZ+Bl4PHu69br2KK5dl/W82Tg0LiXZM2gMdtnbphUqSolO41faoJrX4m1RGuNTKUuTi14
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a08:b0:363:9e28:5e65 with SMTP id
 s8-20020a056e021a0800b003639e285e65mr2374ild.1.1706717645317; Wed, 31 Jan
 2024 08:14:05 -0800 (PST)
Date: Wed, 31 Jan 2024 08:14:05 -0800
In-Reply-To: <3e1b33041f1b661a28439685834dee4d7742c773.camel@oracle.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb2fa30610402aed@google.com>
Subject: Re: [syzbot] [rds?] possible deadlock in rds_wake_sk_sleep (4)
From: syzbot <syzbot+dcd73ff9291e6d34b3ab@syzkaller.appspotmail.com>
To: allison.henderson@oracle.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+dcd73ff9291e6d34b3ab@syzkaller.appspotmail.com

Tested on:

commit:         7fc83268 net:rds: Fix possible deadlock in rds_message..
git tree:       https://github.com/allisonhenderson/rds_work syzbug_f9db6ff27b9bfdcfeca
console output: https://syzkaller.appspot.com/x/log.txt?x=129da088180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f1c13e22f6d60
dashboard link: https://syzkaller.appspot.com/bug?extid=dcd73ff9291e6d34b3ab
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

