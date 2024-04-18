Return-Path: <linux-kernel+bounces-149501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E808A9216
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA3C4B21771
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B048D56454;
	Thu, 18 Apr 2024 04:27:51 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C39537FC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713414471; cv=none; b=Umxyr1nioUCL6IrTL1XyN+le6eixxwk3ICKqkdN7z4lz3SYYyHAoMl2fNzPf2ej+qKbtcRpHKxp1GT6TBp9HhVv6fHf7oqL9wuykTZDy+oWFVWnJ2Vca2eX7/6yyH/vA7ApL313bED4zJ9WQE5EAbYbkYaZffI6fgOg6qVHPmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713414471; c=relaxed/simple;
	bh=SfG1s1y1fbs4IRvRpyJEItMWdHRLy7BTd3xvVF3hb1Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=NBAmUq6y/cxOf+G3WdpnRK3AItVJ8H91qzivkNMi3Fg8ySnXc1iGui/X0jiTPOyHD4/pti4EuSnyP9yqxZ9/PSNS+3KWOPAusa78qi0O+OPd6O9+4JiDxPL9FRQUs5f+yHA3QVFrBuZG2D+qhihrfngigYebpIKy/oNpGnXm4VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d6c32ef13bso46011539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713414469; x=1714019269;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfG1s1y1fbs4IRvRpyJEItMWdHRLy7BTd3xvVF3hb1Q=;
        b=XHpjdLMW1yLFe1meujGmNZ/FnfknC0Lmj6jaQ7KKeER4ePmBJOqba7+4fHXSB3IYcf
         IzzPrv5X1/9a3nuWU39ulWNcal5C741yKe4La4K8NpvSfio24U/fl58KoKY6FHc/4tyA
         MJKlSFjeVeWlyj3lbZ2cJTISnhXKahO87fh9eaLl4XSgyzt+tiTCunhFEoJJMSNvjBJe
         5MqOyyVgiiJv47KGH6zk/VsWGBS+GIppdiI7eMeiNoq+9G1qWubewfjntRpqZysIQOFm
         Z0hPjDi0FJHsyuTV69/D3e4Y4GMcw5Rf8uNg5GTBfj6KS8/lFmysifkSyFqwDOkb7+IX
         1xnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3cWn+2969WX+nrnCZWxSTMaDHXHBJTJBIQx+59oQ65+FEwPwPJfrx49XZHVenaMmG82KdVRV3jLRdmedQTlG8aUoWKVunwRtbcTJ4
X-Gm-Message-State: AOJu0YyahtBfHPDyLjuPvimfHGprbGSbnRgTXx7kv9uNb4Ab8+HjPyZv
	tmoSJ9q84adWDPkBweIiKOOX8f6dhXN5PTYmtqpKV+36koKPa4NtzluGmmWo1ri9V2zNrSjJH96
	6QTcbzWMQzF4lVa2u2xpig/AhX10JKjQ8eTsBbqiMvV9pRTE5t+frFgE=
X-Google-Smtp-Source: AGHT+IFwL8qeN80Hv4nk9W+bxA3Mu/wX0/j/+lzG4a9AN7cCSGgQotKYvsLnIC5qQraEK1JJIlW4Sb3AG3WAp6IiyW2Ip0HUyaAR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8523:b0:482:e922:2823 with SMTP id
 is35-20020a056638852300b00482e9222823mr99129jab.0.1713414468938; Wed, 17 Apr
 2024 21:27:48 -0700 (PDT)
Date: Wed, 17 Apr 2024 21:27:48 -0700
In-Reply-To: <20240418042740.313103-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c63725061657646d@google.com>
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in __filemap_remove_folio /
 folio_mapping (2)
From: syzbot <syzbot+606f94dfeaaa45124c90@syzkaller.appspotmail.com>
To: aha310510@gmail.com
Cc: aha310510@gmail.com, djwong@kernel.org, hch@infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> please test data-race in __filemap_remove_folio / folio_mapping
>
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

This crash does not have a reproducer. I cannot test it.


