Return-Path: <linux-kernel+bounces-125146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8788920F7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9331F27748
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486576A343;
	Fri, 29 Mar 2024 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a+ddMKtd"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985A458127
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711727564; cv=none; b=nqZO9tk81i5XtCYNV0dPcD6+9n+HK94t2hnzhe0/tfmQy7tHHZlJXE9mFizm024SQ3aTSwZonOseKt1CBM85fxegd1E40S7hkB2ZCybiFCxj/n8eGrStQ5zCI2wuioQfYgsMZiMq7AoZaSKSAVHDn4vqx7ws1UCzB+qF7n8TcyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711727564; c=relaxed/simple;
	bh=93fcRAx8zC3XL/YYOz1/itnqEkVWFV9/HC+YNw2rLV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTA9ISzbHK6UTj4VjW2uqQS4fgV/bxZ7/dU3pW1cot3y47OYX2/BQP7Ym3lZSWvt4ZU7VCbn/Bw1sKIRzMl9B0cNtxfu3aZ1hD+m+jLuetZtRwHan5vHgge6iJJt7MoscdFyHLJrTc7CTMIV5OCVFlUwHaSKa80s8GxUNVdmzPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a+ddMKtd; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3433e518c78so180343f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 08:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711727561; x=1712332361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DaRSKMpGgSpfDNUtqSIdr/VVtF3x8hhIBInqqXBE7qE=;
        b=a+ddMKtd+ox2Hv1p/kZINSH9QdrIExGhL1BaCoVO93wGXXUhFyqFidJVBEM8ZiQTIl
         KY7PSq/HDa9QjQ3eRlyMcEwUJRwsQmCeMc4Od+fZQARASHs5dmHxk2DJWXJ+tQbWheZ0
         F56Xa0FaOw2+ozwW6shl8tDWOnXVvExZQ7N6P1GcmVRH1cw0KN/jJ6Rm9XWiSTUHza0f
         Kk/UxR80sC5WHcE4UXWh2CbwoTIx8/Kz2FglZSNzldPeqvigU1vzh+sePQW50bAmT1PG
         6A7AH19VYwyHthVL09pz53+fMVsEWsKL/F6JHqy3lcqjP7tzY91BJSDWmcLQ3NS7N7VT
         dDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711727561; x=1712332361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaRSKMpGgSpfDNUtqSIdr/VVtF3x8hhIBInqqXBE7qE=;
        b=kJk0YgS0fh7dZy6FNYSGvN/T1Joj7EmXYipWhK9tO0HSFm9N1QV3OCnE5orz2mj3o9
         y4HUfVpiEGFlqKWO7c6Ky7xMdwbddo4PaDatxKUZCFEATLh03WW+t9+YZXdUhRLfKDyl
         xGnHfNH/9WZP22Gs+sNvTx7haZmttGhrNSf+Ugrdz86HD80gsSFK6EX00iIYNOtOlIZo
         WfARxN7L4TSbRuyoxB/bPIlJn4+/V8Juty7wBxKfO0PG2sb2f3dc71q1XwQhVroUaFlj
         O7xe66MJOgIRRhl4mviXpbqnmkvAzwsK1K5yxjPCrb6OnZ4Bj2WrXLhj7xLt09DBCNKi
         9tvA==
X-Forwarded-Encrypted: i=1; AJvYcCXRlT7TFrcBoiBW00ZLrEx2Gy0q16BCqj3NCMYpTXFlK7QrfgpErktEw/khmhyReeUl5WrZR4vL3C9wOX8WaamOYpWGGkaZfCsKKt/X
X-Gm-Message-State: AOJu0YxSsA849Ypq72WCeZe/PhNQgJTRiQ5+d7o7veeWgzgW8vo5+y2t
	HJ2bHfgry2FNecsBzxAJzvBfNOWFS5vAVOL+5QsLzqEu/FHxajxoTZ5CsmScCJI=
X-Google-Smtp-Source: AGHT+IGY7HPkzppphxXgM5h0At1hNgR5lKzpQA9yXBKEUqn+LOFbx8z+oJtbHZZ1I/5C6bO8uk34HQ==
X-Received: by 2002:a5d:64a2:0:b0:33e:cbec:e98 with SMTP id m2-20020a5d64a2000000b0033ecbec0e98mr5944277wrp.13.1711727560893;
        Fri, 29 Mar 2024 08:52:40 -0700 (PDT)
Received: from u94a ([2401:e180:8d50:7df:53a:80ac:6d18:d24c])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902f20300b001e0d6de7198sm3615107plc.283.2024.03.29.08.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 08:52:40 -0700 (PDT)
Date: Fri, 29 Mar 2024 23:52:31 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Edward Adam Davis <eadavis@qq.com>, John Fastabend <john.fastabend@gmail.com>, 
	syzbot+c4f4d25859c2e5859988@syzkaller.appspotmail.com, 42.hyeyoo@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, namhyung@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	peterz@infradead.org, songliubraving@fb.com, syzkaller-bugs@googlegroups.com, 
	yhs@fb.com, Xin Liu <liuxin350@huawei.com>
Subject: Re: [PATCH] bpf, sockmap: fix deadlock in rcu_report_exp_cpu_mult
Message-ID: <j6tugwevw3vrcnbf4zxa6apdq4twtmqkdvdj3ndjajajnvltnv@n2cvevln6dvx>
References: <000000000000dc9aca0613ec855c@google.com>
 <tencent_F436364A347489774B677A3D13367E968E09@qq.com>
 <CAADnVQJQvcZOA_BbFxPqNyRbMdKTBSMnf=cKvW7NJ8LxxP54sA@mail.gmail.com>
 <87y1a6biie.fsf@cloudflare.com>
 <87plvgbp15.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plvgbp15.fsf@cloudflare.com>

On Tue, Mar 26, 2024 at 11:15:47PM +0100, Jakub Sitnicki wrote:
> On Mon, Mar 25, 2024 at 01:23 PM +01, Jakub Sitnicki wrote:
> > On Sat, Mar 23, 2024 at 12:08 AM -07, Alexei Starovoitov wrote:
> >> It seems this bug was causing multiple syzbot reports.
> > Any chance we could disallow mutating sockhash from interrupt context?
> 
> I've been playing with the repro from one of the other reports:
> 
> https://lore.kernel.org/all/CABOYnLzaRiZ+M1v7dPaeObnj_=S4JYmWbgrXaYsyBbWh=553vQ@mail.gmail.com/

Possibly also related:
- "A potential deadlock in sockhash map"[1] report awhile back
- commit ed17aa92dc56b ("bpf, sockmap: fix deadlocks in the sockhash and
  sockmap")
- commit 8c5c2a4898e3d ("bpf, sockmap: Revert buggy deadlock fix in the
  sockhash and sockmap")

1: https://lore.kernel.org/all/CABcoxUayum5oOqFMMqAeWuS8+EzojquSOSyDA3J_2omY=2EeAg@mail.gmail.com/

