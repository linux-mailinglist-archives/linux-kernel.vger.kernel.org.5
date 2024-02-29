Return-Path: <linux-kernel+bounces-86839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B5B86CB75
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF2C28466F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8096C12FB1F;
	Thu, 29 Feb 2024 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="E1pBneX2"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3007D077
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216816; cv=none; b=TDBZfr4YfTRD4BwmpiBp38BYJrdeO26jLScgqb96UWgY7OnjJx+XqlZ/NX1xNDtSDAxgpMSFsb6hKl7KxQHFIg5j0lrJFatEipmJ7CJMAjTDEpavd2QEFuTC9aA7fMKnhxjowgwfmhjMQuCdoX07yNwChAbpGc9YH+yiDXBFZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216816; c=relaxed/simple;
	bh=bzjgNSKoSU8cQ4ureTNHKpEbcTPZZ48+o+gmq9XCD/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIVaEwFqk1DwKjLhYnE3/2rWPkqsS85/uFx4nBJrJZX9ZZcMs4PcaJFzbUyAflLb5NmzjIWSQ+ssd+kNtBJ3Xh5ECydELPMN8pNCxPWwRcep7C5Rt03ME6eVzaLp+pteI/7mhd9l1Mpd03BTeq/6+vFr1Wy2MoWqCDDFrmjFb4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=E1pBneX2; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29a430c3057so678500a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709216814; x=1709821614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZoxsmwunD3kBPWbwwdtLfnrTSWRtrCBfDnhBS5exbak=;
        b=E1pBneX2k/gyutOVJPwABXIT14ht7Pw+AQFNPQVVQn6GMqAXYjKo+ql84B48b+MKHm
         EYp7v7F8UHuNeyESqIAfGcmALGLrOpxEAo8eOE8cfdm7jms5knVDypzEbIxYMD0Oa5XZ
         0JSoBd6hijEPHwY0NN7Yw5HF1djt2Ae4Wzr8P+yRpPqc0dy/7GySyEnPe0rgPz7/TVPc
         IyyB6hWQHK870B2ARMfBrOTtORBuJaIs0YgliEZ4XU+7UQtuFS89kv7TKmL1OOr/yqEH
         Bz6WZQQTHX0yqJg3p+dbvPKu5ro1UvyBFJf/53+bX1/nEWRxN+G7BpcMTKjVGPH6mBro
         Exrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709216814; x=1709821614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoxsmwunD3kBPWbwwdtLfnrTSWRtrCBfDnhBS5exbak=;
        b=OHDb99ca7gYadtXi/2hTH0NW+uDWQjx7I1b2DpXUnvZfxt0NasiLdTB09UW22jtN/d
         havZAkdSMm4tBuSOcEaKP6AXJXkmjzUkR6ZhCJATwc/Q0ml0rfcKaRzpjGTIvSWKWwCA
         /pwaEz0C/9oEBaV9uPJKeYYVu0uYwObee3KZVn1TwJXCG+Jn+jQ32ApmDrrlBNrQKvMD
         5DZhdWefRu7FBkCW0MNE0RsWjH9vC9Mzm26L6ujEWcKmTYV48Fgj2h80uauDQehXYkEq
         NC6sKdYNNEsqpg1a0CVeTMVZkl8fz5jHdnu+rYtHwSHmzgTc5Ff+ub2h3UFerKT0SubL
         TLug==
X-Forwarded-Encrypted: i=1; AJvYcCU33buVMpAoNbbcJz8f0oXjGpfPqq1rePDuu0enb7rV9hWhe96zLg7XqmWmDSdrkUd43MucUMlIqZpcCK6zpWM/0j5aGyuxCWOIg6J+
X-Gm-Message-State: AOJu0YwYLQkdOydQ1IiLDOv4b6nPp8WE+75WnpsB4tusoX7UbdmDVa25
	vPT2vJqS84600X+xMEQF8kfHsa1t/rdRCBxlNzjEgfnm1hHeT2+cV3OjEemkPtU=
X-Google-Smtp-Source: AGHT+IFDujHDEpGzcRKCpejmIx29QpyEwREP5k2f97svfF1nbqXgXYH+keTGpqWs21ToWKSj1QuiXA==
X-Received: by 2002:a17:90a:4a15:b0:299:63ff:9c0f with SMTP id e21-20020a17090a4a1500b0029963ff9c0fmr2129502pjh.21.1709216813843;
        Thu, 29 Feb 2024 06:26:53 -0800 (PST)
Received: from [10.84.152.139] ([203.208.167.155])
        by smtp.gmail.com with ESMTPSA id db12-20020a17090ad64c00b00298ca3a93f1sm3741069pjb.4.2024.02.29.06.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 06:26:53 -0800 (PST)
Message-ID: <59585184-d13d-46e0-8d68-42838e97a702@bytedance.com>
Date: Thu, 29 Feb 2024 22:25:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 1/4] sched/eevdf: Fix vruntime adjustment on reweight
Content-Language: en-US
To: Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 Barry Song <21cnbao@gmail.com>, Benjamin Segall <bsegall@google.com>,
 Chen Yu <yu.c.chen@intel.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Mike Galbraith <efault@gmx.de>,
 Qais Yousef <qyousef@layalina.io>, Tim Chen <tim.c.chen@linux.intel.com>,
 Yicong Yang <yangyicong@huawei.com>,
 Youssef Esmat <youssefesmat@chromium.org>, linux-kernel@vger.kernel.org
References: <c2ceff07-e1b4-4dbc-b945-f91a9076375e@linux.alibaba.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <c2ceff07-e1b4-4dbc-b945-f91a9076375e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tianchen,

On 2/29/24 5:24 PM, Tianchen Ding Wrote:
> Hi Abel:
> 
> I'm not so familiar with eevdf and still learning. Here I've some questions about this patch.
> 
> 1. You did proof that V will not change during reweight (COROLLARY #2). However, according to the original paper, the new V will be:
> V' = V + lag(j)/(W - w_j) - lag(j)/(W - w_j + w'_j)
> So the V' in paper will change (when lag is not zero).
> Is the V in Linux code slightly different from the paper?

Good catch. And to the best of my knowledge, the answer is YES. The
above Equation in the paper, which is Eq. (20), is based on the
assumption that:

	"once client 3 leaves, the remaining two clients will
	 proportionally support the eventual loss or gain in the
	 service time"  -- Page 10

	"by updating the virtual time according to Eq. (18,19) we
	 ensure that the sum over the lags of all active clients
	 is always zero"  -- Page 11

But in Peter's implementation, it is the competitors in the new group
that client 3 later joins in who actually support the effect. So when
client 3 leaves competition with !0-lag in Linux, the rq's sum(lag_i)
is no longer zero.

> 
> 2. I print some log around reweight_entity(), mainly want to print V by calling avg_vruntime(cfs_rq). I found your algorithm only keeps the V unchanged during reweight_eevdf(), but not reweight_entity().
> 
> In detail:
> If curr is true (i.e., cfs_rq->curr == se), we will directly run reweight_eevdf(), and the V is not changed.
> If curr is false, we will have __dequeue_entity() -> reweight_eevdf() -> __enqueue_entity(). The V is finally changed due to dequeue and enqueue. So the result of reweight_entity() will be impacted by "cfs_rq->curr == se", is this expected?

Good catch again! It smells like a bug. Since this @se is still on_rq,
it should be taken into consideration when calculating avg_runtime(),
but in fact it isn't because __dequeue_entity() will remove its share.

And I seem to spot another bug, although not relate to this problem,
that we actually need to call update_curr() unconditionally if curr is
available, because we need to commit curr's outstanding runtime to
ensure the result of avg_runtime() is up to date.

Thanks & BR,
	Abel

