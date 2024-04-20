Return-Path: <linux-kernel+bounces-152317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E266D8ABC46
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 17:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A026928173A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA803BB21;
	Sat, 20 Apr 2024 15:56:40 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C591E3AC2B
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713628600; cv=none; b=I2j6Jmrapd/kt6NDc24XwnZ1kZssNQC0BCx06x584Z3QdvR3KSvP/FHGvSQBcov44qUlLwJKfeoI9ZpoHqkDNT6MYh55Cg/J3CYn64yhoOiNfxv7q4ooW1KrO5kRctC1SI+DS9e60r4RSxb1kc2uvoEzUXv6khcTegFFsIrwZdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713628600; c=relaxed/simple;
	bh=MrauLE7vTIJ56o0G5yI1/rmSGSVS4GvOYwtIC8oySNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XlBcqK737RF49YiprLD8/P1F4k3ADNONgXXCW5+QZ/RBg68XmSMQ1J1twe3QoPFkshSNxPcO/DzSIQDByta5nBZWPsI//SHQi6oh2KkyZfsYJG5j35bsXs5AkR1dLThLWETl15alNLbEYC03ajgjKGDHNWfqXa3K+Rb/ypUhrtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43KFuXli052608;
	Sun, 21 Apr 2024 00:56:33 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sun, 21 Apr 2024 00:56:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43KFuWKB052604
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 21 Apr 2024 00:56:33 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5211f90a-f4e1-4a2c-a566-a06939f467bf@I-love.SAKURA.ne.jp>
Date: Sun, 21 Apr 2024 00:56:32 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [trace?] [bpf?] possible deadlock in
 pwq_dec_nr_in_flight
To: syzbot <syzbot+92438ab91cb6348b16fa@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000005143c806160c8d98@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000005143c806160c8d98@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: bpf, sockmap: Prevent lock inversion deadlock in map delete elem


