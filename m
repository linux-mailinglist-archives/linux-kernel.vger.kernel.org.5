Return-Path: <linux-kernel+bounces-145479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853B88A56B5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1366F2839D8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E31779DDB;
	Mon, 15 Apr 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPXQTqaw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A960745FA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195804; cv=none; b=VxfFBfypdYGgmQwfby71ATuWmDPeGP6MtuJu/QvHUZvcGOH2+oVMXGCVlnc0340soyTDeQk8yobjIstCCBLIzZMQUhTfeBq9nAwEjnBnVq+JVmgb8fL3Srkk9605XUsDPAHepyQ1mSI06zQZcpqqj6lNk2EUsz2EH3tYF/yBYL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195804; c=relaxed/simple;
	bh=RW3d7vTJghgiMV437lhTjGgUKySV6NdqsxYM3udeZKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTw62FHWpHa2jfIUk7KVi1zMrJL4FM/KfG8rRPd5t3B3nJPDWtmxG73z3ZvGp4jzEadR9Ni7H6R/rTdNEimPA0iPVTVBVC6tc2q+F9Zt7i0FWltdAMDJByEBCMPe5QhftviHTI9+GjfcPbFDYz6StmPF9gQI7rdMcItKphyctRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPXQTqaw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713195802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zKI8JI2JVtueDvfCh2ciyoRp7Mesn9PR1z6aZyw0Ixo=;
	b=CPXQTqawcmzrsTLTIz2hoZg/cHli2uvB2tN5eCqkhADjX6aOqCcv0a9Mi51UKx9XwpQRQ0
	1hcewBSngLSMybcW9wDOMoZS8klxXcW9g6SmlAJXxiAMqwh03/Zdk9Q3GMslhbw5V6tZXG
	DU+SVve/AYaHlpTnhK/p9nPVRFI2Qgs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-mTipFDouN72LIau7fSngZA-1; Mon, 15 Apr 2024 11:43:20 -0400
X-MC-Unique: mTipFDouN72LIau7fSngZA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78ec9b4f850so40058485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713195800; x=1713800600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKI8JI2JVtueDvfCh2ciyoRp7Mesn9PR1z6aZyw0Ixo=;
        b=E4NaRpnI75TCvPYNObm/SrslOPypgcfgAOU3NQ1vP/QOzu5cXB4werHiZhSAuuKLKy
         vArT+K9n922UHvAgPUoP890/jzngshlkLHJGY8+Cx23gZUiWvP0FCcd6774wl4lw7gze
         R3RZAmFO8w2KVRnrV22b2PY+zFexkczKhXfe0pvJh1dfMvjmFQQ4tSfjOKqazbkxjgyT
         1XUyEmfX4wcwUwLvgodxwmIiEa0wbNxxkj9OotjbLUkoL4ZC9Vg569Pyd1RK4jXgo/uR
         zf3J7J/xJJAbPaB5u06pbAsjuAAay+EQGN5OFnAbfm1jTfvRf0RzVNB03JMIOS0uKCH5
         u7pg==
X-Forwarded-Encrypted: i=1; AJvYcCXSEaddJymqJ/LIF+4+Xi5dDF4yA4pSKOueIJYg6NsytQ1bppiIyE4VW+QMNsFH42BYqZYNc9PcdWtsfpTQi1+qj1bW9XzaRpPJmQYQ
X-Gm-Message-State: AOJu0Yxe4ZMpLo2TI+p/vlPqlrsEyMD8lFKiNQND7/qed4GhF1vP6IZe
	XYEN94LEhmaJjS1PnRkgaFQVazjKFpWlnXkk5i9W5j5PoYW9ZzqFWW/jNnS7cFXY800XWujFrCT
	qPlElffCcoXfFZVZNsq81Y3cglw83Jj7F38mcn3DW0g0CZT3qs4LeDMElIoThUA==
X-Received: by 2002:a05:620a:248a:b0:78d:7760:e797 with SMTP id i10-20020a05620a248a00b0078d7760e797mr12240616qkn.2.1713195799908;
        Mon, 15 Apr 2024 08:43:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+uDHPOzVtV+vJoMo/6qGG38yrAtqH/iV6TKhT63vDZo/KxGU82JQlEtfHXPbvRctTuWi3MA==
X-Received: by 2002:a05:620a:248a:b0:78d:7760:e797 with SMTP id i10-20020a05620a248a00b0078d7760e797mr12240592qkn.2.1713195799358;
        Mon, 15 Apr 2024 08:43:19 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id v27-20020a05620a123b00b0078eec8445dbsm854807qkj.47.2024.04.15.08.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 08:43:19 -0700 (PDT)
Date: Mon, 15 Apr 2024 11:43:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+ddf4b4c0005944105a9e@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in try_to_migrate_one (2)
Message-ID: <Zh1LFYTrAq1JNcXz@x1n>
References: <0000000000001a87b90613389171@google.com>
 <000000000000dce0530615c89210@google.com>
 <20240411125513.b779991117a4dea92ce77269@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240411125513.b779991117a4dea92ce77269@linux-foundation.org>

On Thu, Apr 11, 2024 at 12:55:13PM -0700, Andrew Morton wrote:
> On Wed, 10 Apr 2024 19:04:21 -0700 syzbot <syzbot+ddf4b4c0005944105a9e@syzkaller.appspotmail.com> wrote:
> 
> > syzbot has found a reproducer for the following issue on:
> 
> Thanks.
> 
> > HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=14db82bd180000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ddf4b4c0005944105a9e
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13111a4d180000
> 
> Seems to be userfaultfd related.
> 
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156ae155180000

I can't easily trigger with the reproducer, neither did I get more
information from the syzbot reproducer, and it doesn't include an
UFFDIO_REGISTER.

Before go reading more on syzbot itself on this specific reproducer, I'll
see whether I can come up with something better than commit c2da319c2e2: I
don't remember the details why I didn't do the sanity check when updating
the pgtable rather than walking it.  I'll give it a shot this time.

Thanks,

-- 
Peter Xu


