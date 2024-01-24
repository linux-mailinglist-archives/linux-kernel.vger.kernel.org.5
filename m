Return-Path: <linux-kernel+bounces-36281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7853839E59
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68AB11F2AC34
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5C617CB;
	Wed, 24 Jan 2024 01:38:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22D220E6;
	Wed, 24 Jan 2024 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706060339; cv=none; b=VY9J2QJqTK8Ca7dWYFZqYpl4ZrG1T0JFzk7e8G7BRKyWuopqVaI3w7w/6vHUnU4+Ziq10210g6VyU+0e8taKMj9PZ8BVEMvuGGy2FX7WgtVyTvyIwJd/7Mto4AoPGe4QOvV7zr6aEqrIjhE58+49aUXrDH+lh7cE+eSwxSBBq5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706060339; c=relaxed/simple;
	bh=T/SApjS4NcwCV6e9qX6lfk7qF4ETSE5E2S3aJnDWIjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GH+1S5IGCRxl/nOwi2gNht2YynZcnCaZuPHiChyE7a1ZzQv43jlddyatpzJfnMqtNQGu705xtRL6JAQAujlAojixSMQsNdGp5SATKMLfCaXHpH+Ppa1XOQYViRDKNbU+V/7VNmTXnwaLNcQBqG3zN1kZ0CJjONod1yYNr4okYAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D956C433F1;
	Wed, 24 Jan 2024 01:38:55 +0000 (UTC)
Date: Tue, 23 Jan 2024 20:38:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: Tony Luck <tony.luck@intel.com>, Avadhut Naik <avadhut.naik@amd.com>,
 linux-trace-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
 yazen.ghannam@amd.com
Subject: Re: [PATCH] tracing: Include PPIN in mce_record tracepoint
Message-ID: <20240123203853.66655e95@rorschach.local.home>
In-Reply-To: <be870e14-eeb9-4dcf-ba43-a72ef66a3d87@amd.com>
References: <20240123235150.3744089-1-avadhut.naik@amd.com>
	<ZbBV4EGrZw6hJ5IE@agluck-desk3>
	<be870e14-eeb9-4dcf-ba43-a72ef66a3d87@amd.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 19:29:52 -0600
"Naik, Avadhut" <avadnaik@amd.com> wrote:

> > But some questions:
> > 
> > 1) Are tracepoints a user visible ABI? Adding a new field in the middle
> > feels like it might be problematic. I asked this question many years
> > ago and Steven Rostedt said there was some tracing library in the works
> > that would make this OK for appplications using that library.
> >   
> 
> I think they can be user visible through the "trace" and "trace_pipe" in
> /sys/kernel/debug/tracing. But you will have to enable the events you want
> to trace through /sys/kernel/debug/tracing/events/<event-name>/enable.
> 
> AFAIK, this (adding field in the middle) shouldn't be problematic as we
> have the tracepoint format available in debugfs. For e.g. with this patch,
> the format is as follows:
> 
> [root avadnaik]# cat /sys/kernel/debug/tracing/events/mce/mce_record/format 
> name: mce_record
> ID: 113
> format:
>         field:unsigned short common_type;       offset:0;       size:2; signed:0;
>         field:unsigned char common_flags;       offset:2;       size:1; signed:0;
>         field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
>         field:int common_pid;   offset:4;       size:4; signed:1;
> 
>         field:u64 mcgcap;       offset:8;       size:8; signed:0;
>         field:u64 mcgstatus;    offset:16;      size:8; signed:0;
>         field:u64 status;       offset:24;      size:8; signed:0;
>         field:u64 addr; offset:32;      size:8; signed:0;
>         field:u64 misc; offset:40;      size:8; signed:0;
>         field:u64 synd; offset:48;      size:8; signed:0;
>         field:u64 ipid; offset:56;      size:8; signed:0;
>         field:u64 ip;   offset:64;      size:8; signed:0;
>         field:u64 tsc;  offset:72;      size:8; signed:0;
>         field:u64 ppin; offset:80;      size:8; signed:0;
>         field:u64 walltime;     offset:88;      size:8; signed:0;
>         field:u32 cpu;  offset:96;      size:4; signed:0;
>         field:u32 cpuid;        offset:100;     size:4; signed:0;
>         field:u32 apicid;       offset:104;     size:4; signed:0;
>         field:u32 socketid;     offset:108;     size:4; signed:0;
>         field:u8 cs;    offset:112;     size:1; signed:0;
>         field:u8 bank;  offset:113;     size:1; signed:0;
>         field:u8 cpuvendor;     offset:114;     size:1; signed:0;
> 
> print fmt: "CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x", REC->cpu, REC->mcgcap, REC->mcgstatus, REC->bank, REC->status, REC->ipid, REC->addr, REC->misc, REC->synd, REC->cs, REC->ip, REC->tsc, REC->ppin, REC->cpuvendor, REC->cpuid, REC->walltime, REC->socketid, REC->apicid
> 
> 
> Just quickly tried with rasdaemon and things seem to be okay.
> 
> Also, not a cent percent sure, but the library you are mentioning of, I think
> its the libtraceevent library and IIUC, it utilizes the above tracepoint format.
> 

Yes, rasdaemon uses libtraceevent (or a copy of it internally) that
reads the format file to find fields. You can safely add fields to the
middle of the event structure and the parsing will be just fine.

-- Steve

