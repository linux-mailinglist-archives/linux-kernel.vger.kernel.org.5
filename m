Return-Path: <linux-kernel+bounces-63896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDA1853627
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451741F2735B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B39BA2D;
	Tue, 13 Feb 2024 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jV2UfaHY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6873D2919;
	Tue, 13 Feb 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842125; cv=none; b=d9rkDf7oN4c4l5ctyRsGxRSU1L8tC/xFHPzBCHVqDVgjVH7WQZirYpi+yChFRecsXQ94jk5ya29FleIo3OOFixa55kKTKAhTf7gQTEoEdNydPcdb2rdD6qXeIUu4wnwMlUcXBNaSkpqcEuFOVL2oM5xhcwk+YXHiMYSffLsd0no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842125; c=relaxed/simple;
	bh=YCcie0zAZHdXXCutJQ7kG+dvXcsnwrHdF2tff2UKPsY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V0mVTWVJyrlX/1VHVwvarJg3A4/XXpFnpSX9r1/3980fYrBcLzDtDKXUL6iidWdK90ImybMUyfqxm+48hXBOdjDi05MURd6G7951uJvoPq6+3fpdHS58+2vqurDpCcd+03M/M3EBEqO75Ljfqn9XOw4ncZkTZby1zhnCaHW9uWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jV2UfaHY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707842123; x=1739378123;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=YCcie0zAZHdXXCutJQ7kG+dvXcsnwrHdF2tff2UKPsY=;
  b=jV2UfaHYT3SH/MCwi/2PMHXkh1KdmzezKucDfeK51AOBsrMmU0N12ab6
   cK2hHRtUDCjbGgXqdBeQkimVWbowD5r4wiUqWmOJ02syLHPj0+EOazLQ7
   i8IGjtdpmrzz4qEFTA/MmNgSC+wugUhQ45p+Y8Pet1Ohj2Tc/5XlCKgiz
   4GMxw3n41fuHLg1zlFvN3li9acPi/OA1uQ2efIoGX6qmiZyfdsJY37tPv
   oHVNw5oq4aIpOFttHVV1fooCH/ad4UUr6um6BBncM6niNnbKv5yrBE2aj
   Ort4TCl9P/qcbexaR6BM/hnIUF+/OWDjpWGaQNXzNUv4OwDzRGrQA3GSt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="12405100"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="12405100"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 08:35:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="3299363"
Received: from arieldux-mobl.amr.corp.intel.com (HELO [10.209.91.178]) ([10.209.91.178])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 08:35:22 -0800
Message-ID: <967027adabdc8aa654cd788b21147427477a0f08.camel@linux.intel.com>
Subject: Re: [PATCH] tracing: Have saved_cmdlines arrays all in one
 allocation
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Vincent Donnefort
 <vdonnefort@google.com>, Sven Schnelle <svens@linux.ibm.com>, Mete Durlu
 <meted@linux.ibm.com>
Date: Tue, 13 Feb 2024 08:35:22 -0800
In-Reply-To: <20240212191336.5c502f78@gandalf.local.home>
References: <20240212180941.379c419b@gandalf.local.home>
	 <ef94259e139e4579ee27db99975dc4cf397e2a06.camel@linux.intel.com>
	 <20240212191336.5c502f78@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-12 at 19:13 -0500, Steven Rostedt wrote:
> On Mon, 12 Feb 2024 15:39:03 -0800
> Tim Chen <tim.c.chen@linux.intel.com> wrote:
>=20
> > > diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_s=
ched_switch.c
> > > index e4fbcc3bede5..210c74dcd016 100644
> > > --- a/kernel/trace/trace_sched_switch.c
> > > +++ b/kernel/trace/trace_sched_switch.c
> > > @@ -201,7 +201,7 @@ static struct saved_cmdlines_buffer *allocate_cmd=
lines_buffer(unsigned int val)
> > >  	int order;
> > > =20
> > >  	/* Figure out how much is needed to hold the given number of cmdlin=
es */
> > > -	orig_size =3D sizeof(*s) + val * TASK_COMM_LEN;
> > > +	orig_size =3D sizeof(*s) + val * (TASK_COMM_LEN + sizeof(int)); =
=20
> >=20
> > Strictly speaking, *map_cmdline_to_pid is unsigned int so it is more co=
nsistent
> > to use sizeof(unsigned) in line above.  But I'm nitpicking and I'm fine=
 to
> > leave it as is.
>=20
> I was thinking about making that into a macro as it is used in two places=
.
>=20
> /* Holds the size of a cmdline and pid element */
> #define SAVED_CMDLINE_MAP_ELEMENT_SIZE(s)		\
> 	(TASK_COMM_LEN + sizeof((s)->map_cmdline_to_pid[0]))
>=20
> 	orig_size =3D sizeof(*s) + val * SAVED_CMDLINE_MAP_ELEMENT_SIZE(s);
>=20
>=20

Looks good. This makes the code more readable.

Tim

