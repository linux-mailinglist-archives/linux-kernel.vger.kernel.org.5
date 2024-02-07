Return-Path: <linux-kernel+bounces-57236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B72384D572
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE79A1F2B5DC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876AD12C7F8;
	Wed,  7 Feb 2024 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjDM162x"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDDE12882A;
	Wed,  7 Feb 2024 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341759; cv=none; b=dt/TnL7sasXfvo360JDOBrj0eSf8u70r+eZk/YkvTarykBHmjrSKWB6VRJ9CdDzwWb1k0F3qE+xophgl0QfrZOP5n8PbgabRoRWMzky9JHguNT7ViVyRgHw7hRf2eCguoEYeiL/otS1Ogh3gSeINzRH14L9k6PR5CAW06NfhAH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341759; c=relaxed/simple;
	bh=Hi8WKTB2SHPguJc94yPFvuzcB+jOfKYMDIOG7OJiqG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJXIQ70XmUzZV9LIfAYv+lRuCv6aQMLrl5SIwWKUAbHfq2RzpDefT96Pz5xVTqitPmHRvPs8pnfURaedzR4IaT0FCtcWZMmaAw9F7Ryr896snDquuUdzTm64UlV4hnr/J4InYFWQJkv9ykmWRg5LuNKZkf1qDzDiXV+RXctK/1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjDM162x; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d7354ba334so9442885ad.1;
        Wed, 07 Feb 2024 13:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707341756; x=1707946556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BEz0l2Yktui+FbUn+gXIBN0iRKIGqS5+WthaqhNu9Zo=;
        b=TjDM162xmRUPmFwQaJLmu+t4MZS/IKG2kEDrNkvAaIKeuSSmCToJIDsYycQcopvx8w
         hWcTnjtPixuptmvnS7R/4v26iINH8EXkclrDV2HOdd35JhqKv+SE5gBvctE/eV8T8sbn
         opK8fMymnbp5eEzSRBnasF6Ki6H8aY0OHIAFtgvoNHSgAEdYHsFDZkXxjf+MCam3Mpoq
         S8Z0YoFAolnj0uDsCOae2I41lvCICbsJdmVsqDRK/NjxCJgyGBhddK+tFL7Ao2R+VQp2
         cnmAqL9aJcD9FGb9m+LHjChV1aYivwQvLSSFBiDav6Ubd6vtA36iF4kemYI8GOUgpGY1
         HQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707341756; x=1707946556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEz0l2Yktui+FbUn+gXIBN0iRKIGqS5+WthaqhNu9Zo=;
        b=vDlMsG7T2ZrtcQcD6xga0/KMY4wLQlbBZefPAwJ8rbac+k8yO6mARa2LOhmVstEcCO
         Aidn2qa16oDywWuAOw0pFz9t2VaA1j7vNR6ZGAPEdgx7QUdmaZDXhwxi8z70eflFD8T5
         7sZXUj0eP0ZAgnfbMqwuetPM3mzv1XKKex48Bnnf03iwsIzEmBMIU1CZJ9cH6UYmlc6W
         qwuHOseawh9aaZsP4MSWLthducy4y3X8vTF9T3KGbPjop/FeA35upDUhCmRrmo8MyzEt
         s1gEcodZGj6J9dCmFGkSVfZJEjLLmLcTLggUzMARZN9k/6YlPvhYNO5C01yQ0doZROWq
         TtHw==
X-Forwarded-Encrypted: i=1; AJvYcCVzNFKkLVe8MMLH+7R+vJjEBxyxyUxUOwLW1F71Q/QTCbVpgrAp8WSe//dGeWFXtpiF9Omt/lJlUaTiBfq3/SVYexVHqB8+flrGzsExJRxd5qJup4ciTxFb/5QntqpRl6N2eMKivyU=
X-Gm-Message-State: AOJu0YwFVJAlUSDAMlNkAW3TzsG3HxYhrBd3ChYE1GAs9p6Wu3+KdINs
	u+TuA5A/Aws5jZoJaA14B2jlgJ0eNLKVusZi2MUJjwIN2hs4y8iI
X-Google-Smtp-Source: AGHT+IHlW28ss/Xeqx89EIojs4+hQi1/0sypdExhbT0Arg+HXWNUfkHvwwm7hcOamuzrJqrnLTlR+Q==
X-Received: by 2002:a17:903:2582:b0:1d9:c37d:7182 with SMTP id jb2-20020a170903258200b001d9c37d7182mr5692295plb.53.1707341756543;
        Wed, 07 Feb 2024 13:35:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULypFOwtRQarob0m/v0WdCZw8KY9+25kXEnP14XY3Wd7Y7G/k59LIoEvBuZ+oVTj8nnVxkU4EjItTcrVpQz5p6kdEQwkEGq+T4jQUG6xg43o/HgBJetk5qWsRIeTR3OrUdeAefMtRUVRNTyyPyCpU0Q5cGjDZfIY6aQ/Gx8ZHnF0kKMhy0MLwifBBmw2BYlTe0Dq+RjiMN7xuUesiyWE7Ww5+ZgE2rZ0zoWmAmcQKEVQ9Q6814tKQpkB8MmvMGM4n+LLYzN+7W+oyoiencN1GJ/tvWW+FN/k3kpGCAD0YZOAWWOTvlESFgqxdEE6UlVh0GdLgmiJw7AOgvBdmH6PRkSbmCyrsW16wdZB/by5gLN8CSJLuhB/r3tj4UKPo=
Received: from localhost ([2620:10d:c090:400::4:3c45])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902d3cd00b001d8d71b8807sm1953042plb.97.2024.02.07.13.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:35:56 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 7 Feb 2024 11:35:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume
 optimization
Message-ID: <ZcP3uiapKGZqw0q5@slm.duckdns.org>
References: <10423008.nUPlyArG6x@kreacher>
 <708a65cc-79ec-44a6-8454-a93d0f3114c3@samsung.com>
 <CAJZ5v0hn=KgaWn9pwtLsH2a8n61BNxzb1xrNoxUfEi3o9OAZGw@mail.gmail.com>
 <4a043533-009f-4db9-b107-c8374be28d2b@samsung.com>
 <CAJZ5v0hDmwaFEtLc8yDc4cXn2wODXAqATe0+_Hpm9QPODUPMQw@mail.gmail.com>
 <ZcOyW_Q1FC35oxob@slm.duckdns.org>
 <2f125955-8c7c-465c-938c-8768f7ca360b@samsung.com>
 <ZcPSuUBoL_EDvcTF@slm.duckdns.org>
 <ZcPelerpp3Rr5YFW@slm.duckdns.org>
 <b4ceab79-3208-419b-9a79-f34540db3f70@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4ceab79-3208-419b-9a79-f34540db3f70@samsung.com>

Hello,

On Wed, Feb 07, 2024 at 10:30:58PM +0100, Marek Szyprowski wrote:
..
> Disabling non-boot CPUs ...
> XXX wq_update_node_max_active: wq=events_unbound off_cpu=1 total=3 range=[32, 512] node[0] node_cpus=3 max=512
> XXX wq_update_node_max_active: wq=events_unbound off_cpu=2 total=2 range=[32, 512] node[0] node_cpus=2 max=512
> XXX wq_update_node_max_active: wq=events_unbound off_cpu=3 total=1 range=[32, 512] node[0] node_cpus=1 max=512
> Enabling non-boot CPUs ...
> XXX wq_update_node_max_active: wq=events_unbound off_cpu=-1 total=2 range=[32, 512] node[0] node_cpus=2 max=512
> CPU1 is up
> XXX wq_update_node_max_active: wq=events_unbound off_cpu=-1 total=3 range=[32, 512] node[0] node_cpus=3 max=512
> CPU2 is up
> XXX wq_update_node_max_active: wq=events_unbound off_cpu=-1 total=4 range=[32, 512] node[0] node_cpus=4 max=512
> CPU3 is up

So, the node max_active does stay at 512. The only pwq which uses min_active
would be the dfl_pwq but I'm not sure why that'd be being used. Can you
please post the output of `drgn -v vmlinux tools/workqueue/wq_dump.py`?

Thanks.

-- 
tejun

