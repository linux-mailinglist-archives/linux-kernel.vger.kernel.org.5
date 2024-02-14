Return-Path: <linux-kernel+bounces-64938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDF28544E3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E921F2AACA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7081173D;
	Wed, 14 Feb 2024 09:19:00 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049AB12B61
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902340; cv=none; b=uCKVLhYoBANEcZp65+QRE2jD3ODrmZsV3EfC/IBY5/qhs+PGwRPOwbqi2NhViILdTRgeQptdleA8TMQ5QflVTnfLAVQ+4Di+H4vdqm9WmJD+Aj3omNAuyYA/BNGvpD39oIuI91R3YFyQoMWUCZIrrIqx6J8rWv3eI2Fy2K+JWXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902340; c=relaxed/simple;
	bh=gWbUd0drnRSDrqgqJIa+9c4urnKTHYxtuJvzbpSWmIo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cnBxS56WIXGrzECvfHYxTdZs9CbcT/9sZeru0m0XIhz+5TXDUoPi9rX7+Px9hdQZLzb2OgqHJ+ruzAV0g3/cOkWKgON0uDUVIBZwzl9+XNcZgHFqxOwqe6k4KBieTnerFwJ9bsrlXbKQfijuClH48Kzgqs3pLULZyGVBnTGM3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c488098701so11077639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:18:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902338; x=1708507138;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWbUd0drnRSDrqgqJIa+9c4urnKTHYxtuJvzbpSWmIo=;
        b=Y1UsAUZeraKcNetmGKaCoYpx6Im9XawVJ1x6lqe9oe+BI3K3X2X2oLOM63wcdgRepf
         189MLwXcXSSTs4wUOKcxkzn2jTQRcdskoycYm8xY2PT8NtFoW1DeWDml5mXt3P5d4K55
         SzWGdWDtQ3ECxwnNnwCZ4NSH0qterTVCz98XBQg81VhB2xWtzjpiMp9oH7L/M3c3CCJZ
         OyU8mEh9WQmQF6FWMhs368dtinxoAyA6iZ0/CR9I9RzdNYpNjFNlnVgFHiyLODcRy+qX
         ukwuLIQBussUKXUxCgGZSyEFdcsunhLnN9JwagnagFN3EEDb8Pg3hBgoCnA+WQjxn9C3
         AKfg==
X-Gm-Message-State: AOJu0YxMZDiccEOTeLnOtfMX0brYTlKJ81djVh6LcS3X/611gzYUVaky
	UYTeC82h8iThyjl7u2TKnRnKLVIV1i3QNxv4sQhdKlFDIsEJu9A+p8oL0sJXrYgzVWDUH72xk6W
	6nH8fmoBBazho08dNxuOKPtEjpFO4aEzuKApLUE5BzfiV1kYRJot2/LZVxg==
X-Google-Smtp-Source: AGHT+IFXVGkWLQi0Atk6MC6pZu/s3FpmjZsd4gVvKtLm36/j1vbsteGFPODF5/vR5C4RtKqHrznURdmHHrln0b6yySTIRcjjxJ3+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a09:b0:360:134:535e with SMTP id
 s9-20020a056e021a0900b003600134535emr98559ild.1.1707902338123; Wed, 14 Feb
 2024 01:18:58 -0800 (PST)
Date: Wed, 14 Feb 2024 01:18:58 -0800
In-Reply-To: <000000000000d42dae0611477922@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002cd15c06115400d6@google.com>
Subject: Re: [syzbot] #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 for-kernelci
From: syzbot <syzbot+ebbab3e04c88fa141e6b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
Author: kadlec@blackhole.kfki.hu


