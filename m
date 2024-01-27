Return-Path: <linux-kernel+bounces-40937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B230983E87C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE0DB2465F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2F181A;
	Sat, 27 Jan 2024 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hy4Szcyq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E8223D6;
	Sat, 27 Jan 2024 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706315506; cv=none; b=fpWHVeuT2vTB0Iat0klMLpwf5V3MV/LtYpgFJNMmeGYgUUgVQvrQPGEOQiBm/zFcUg68Ioh/CuL/YWFfJk+Pm9n29zHmmltmignr8eeUwjra44qIz7IgfabI1ExnTKVAONyf58J1iOZpmViupA9H3egaW/tpyNAPf6PycZE7Bf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706315506; c=relaxed/simple;
	bh=RaDKuFVZhN0vb+fPL3ijd0J96m8fpHt5sVQD+K/787s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cX3yw3ThoFb/F4Crm/E52s5A31TgN5DQQm4hddsvkvl7MQzUx5uyR4tT+eqtZGUxdYgJRlZYrcPukz78qzqZN8U3ajahI9Lvn/0lpFqZzCjc/I8Jvuup5zxrAQ7sQdltx+I+bpiffpvv+SJxv87o1tmKr2TnDWQdInvwuZ3Yjdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hy4Szcyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEFDC433F1;
	Sat, 27 Jan 2024 00:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706315506;
	bh=RaDKuFVZhN0vb+fPL3ijd0J96m8fpHt5sVQD+K/787s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hy4SzcyqDfyPcPSDeZEBcJ38qca/wNicOZrEybVUoHSIwtJygLHgV3fQWWYhi8KuR
	 i2Ma4Sw5f8NwiIqa9eXF18gfZmEL/2W7/JlkGLmByqvbJKYJPBdj2J3xFb1A900cfj
	 ro9qrL9Syj5sb7Pqj1CWFJBqwMsjvGvxYiUeAaYU=
Date: Fri, 26 Jan 2024 16:31:45 -0800
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
	"david@redhat.com" <david@redhat.com>,
	"quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"mgorman@techsingularity.net" <mgorman@techsingularity.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"vbabka@suse.cz" <vbabka@suse.cz>,
	"quic_charante@quicinc.com" <quic_charante@quicinc.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"quic_cgoldswo@quicinc.com" <quic_cgoldswo@quicinc.com>
Subject: Re: [RESEND PATCH V2] mm: page_alloc: unreserve highatomic page
 blocks before oom
Message-ID: <2024012635-stoneware-backboned-2ca0@gregkh>
References: <1700823445-27531-1-git-send-email-quic_charante@quicinc.com>
 <3fe3b3edd33cd784071dd9b459d20a79605ec918.camel@infinera.com>
 <2024012205-undrilled-those-2435@gregkh>
 <PH0PR10MB461565CEE892267025BC697BF4752@PH0PR10MB4615.namprd10.prod.outlook.com>
 <2024012210-outshoot-dragonish-fe8e@gregkh>
 <01010dd280badd149291cf4d2a4a88847113cf6d.camel@infinera.com>
 <Za-PWcwmHFl3wmth@tiehlicka>
 <98318c510e39cf83beaa07a4dbf33f18209eb358.camel@infinera.com>
 <Za-h5t7HX5rNrVdq@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za-h5t7HX5rNrVdq@tiehlicka>

On Tue, Jan 23, 2024 at 12:24:22PM +0100, Michal Hocko wrote:
> On Tue 23-01-24 11:08:28, Joakim Tjernlund wrote:
> [...]
> > Mar  9 12:52:40 xr kern.warn kernel: [ 1066.001379] Mem-Info:
> > Mar  9 12:52:40 xr kern.warn kernel: [ 1066.003665] active_anon:18 inactive_anon:2435 isolated_anon:0
> > Mar  9 12:52:40 xr kern.warn kernel: [ 1066.003665]  active_file:1 inactive_file:0 isolated_file:0
> > Mar  9 12:52:40 xr kern.warn kernel: [ 1066.003665]  unevictable:267 dirty:0 writeback:0
> > Mar  9 12:52:40 xr kern.warn kernel: [ 1066.003665]  slab_reclaimable:384 slab_unreclaimable:2223
> > Mar  9 12:52:40 xr kern.warn kernel: [ 1066.003665]  mapped:1 shmem:0 pagetables:309 bounce:0
> > Mar  9 12:52:41 xr kern.warn kernel: [ 1066.003665]  kernel_misc_reclaimable:0
> > Mar  9 12:52:41 xr kern.warn kernel: [ 1066.003665]  free:1054 free_pcp:24 free_cma:0
> > Mar  9 12:52:41 xr kern.warn kernel: [ 1066.037938] Node 0 active_anon:72kB inactive_anon:9740kB active_file:4kB inactive_file:0kB unevictable:1068kB isolated(anon):0kB isolated(file):0kB mapped:4kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:9
> > Mar  9 12:52:41 xr kern.warn kernel: [ 1066.061723] Normal free:4216kB min:128kB low:160kB high:192kB reserved_highatomic:4096KB active_anon:72kB inactive_anon:9740kB active_file:4kB inactive_file:0kB unevictable:1068kB writepending:0kB present:36864kB managed:2944
> > Mar  9 12:52:41 xr kern.warn kernel: [ 1066.087595] lowmem_reserve[]: 0 0
> > Mar  9 12:52:41 xr kern.warn kernel: [ 1066.090918] Normal: 206*4kB (MEH) 198*8kB (UMEH) 79*16kB (UMEH) 13*32kB (H) 2*64kB (H) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4216kB
> > Mar  9 12:52:41 xr kern.warn kernel: [ 1066.104104] 269 total pagecache pages
> > Mar  9 12:52:41 xr kern.warn kernel: [ 1066.107768] 9216 pages RAM
> 
> OK, so this is really a tiny system (36MB) and having 4MB in highatomic
> reserves is clearly too much. So this matches the patch you are
> referencing and it migh help you indeed.

Ok, now queued up, thanks.

greg k-h

