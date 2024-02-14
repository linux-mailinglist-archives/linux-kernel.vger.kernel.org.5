Return-Path: <linux-kernel+bounces-64599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFACE8540B5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4251F2A2D9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4065333EA;
	Wed, 14 Feb 2024 00:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MAbCvUUJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7813320D;
	Wed, 14 Feb 2024 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869399; cv=none; b=oRA6a18Yjgn50AeweW8W6o/bU31PMttxxHAA3UFV4FnJrlLcFkyNeuW4e0I78Ku7D5cY1NyD7pNS/h1f653e8KTFHQOTXpx/M3l3doHM5Yd+GvCNOOIw4/fC2WQ0nHlZkueEWrC/5TDJhLbXxi5Z3B+iDJxabP8KE+7VVBH3S0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869399; c=relaxed/simple;
	bh=BgkpVWsh6Bl9SCabE/LKap1VaB2tWhQF+tCO77wtpTw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c+T/inN38r5DKQjcDexfcCn2QMXfRrrdUnEMRvNBvrlXFQz6+txEz8B9tMC8bUJrpqEGJD0eDYbu+JlDcpGHe/5b8C5vJ75hT2TvSA+/YF3sw2eAJI0H7TO048jv9kDiNmUS3tljqa48cWQrolbZp9+w6BhpkYu4Sx1Fn3xXBwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MAbCvUUJ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707869398; x=1739405398;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=BgkpVWsh6Bl9SCabE/LKap1VaB2tWhQF+tCO77wtpTw=;
  b=MAbCvUUJzersLgsNV4dloobPAgUzGKHA/4R3pIIc4CMqYcX7J0vkHLtf
   KoUIP39uxfXqlxdZNSPjWUYFtCWGPuNFdH2hNpuYGoWxM00nLcvkEgmvZ
   buuhvqz10bxFikKZMH56z2H73J1PJ1UBj2Dx0gzfqTml2x79CdB9f3KLy
   nOJrSXlTAFQ4YWB4ou1qkfQ/qNtsYWlnE/dxHeLF4hLUBL+v8iIZ1dWB2
   XbTOhPTSn62XBwsLdaXQRRnMswhlR07+/8p8xG5Cc0O0VNgBKLZZFP5nL
   WhZhVucu7KYHXDkWsHpr9aUODadBXe80uv74YgYTpTOzUJ1/gc8gXE4p7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1775106"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="1775106"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 16:09:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="3331532"
Received: from arieldux-mobl.amr.corp.intel.com (HELO [10.209.91.178]) ([10.209.91.178])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 16:09:56 -0800
Message-ID: <889b1a2849f50eeda2b334a7045c6748449d3d38.camel@linux.intel.com>
Subject: Re: [PATCH v2] tracing: Have saved_cmdlines arrays all in one
 allocation
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
 Vincent Donnefort <vdonnefort@google.com>, Sven Schnelle
 <svens@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>
Date: Tue, 13 Feb 2024 16:09:56 -0800
In-Reply-To: <20240213115232.5fd9e611@gandalf.local.home>
References: <20240213115232.5fd9e611@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-13 at 11:52 -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>=20
> The saved_cmdlines have three arrays for mapping PIDs to COMMs:
>=20
>  - map_pid_to_cmdline[]
>  - map_cmdline_to_pid[]
>  - saved_cmdlines
>=20
> The map_pid_to_cmdline[] is PID_MAX_DEFAULT in size and holds the index
> into the other arrays. The map_cmdline_to_pid[] is a mapping back to the
> full pid as it can be larger than PID_MAX_DEFAULT. And the
> saved_cmdlines[] just holds the COMMs associated to the pids.
>=20
> Currently the map_pid_to_cmdline[] and saved_cmdlines[] are allocated
> together (in reality the saved_cmdlines is just in the memory of the
> rounding of the allocation of the structure as it is always allocated in
> powers of two). The map_cmdline_to_pid[] array is allocated separately.
>=20
> Since the rounding to a power of two is rather large (it allows for 8000
> elements in saved_cmdlines), also include the map_cmdline_to_pid[] array.
> (This drops it to 6000 by default, which is still plenty for most use
> cases). This saves even more memory as the map_cmdline_to_pid[] array
> doesn't need to be allocated.
>=20
> Link: https://lore.kernel.org/linux-trace-kernel/20240212174011.068211d9@=
gandalf.local.home/
>=20
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>


Patch looks good to me.

Reviewd-by: Tim Chen <tim.c.chen@linux.intel.com>

> ---
> Changes since v1: https://lore.kernel.org/linux-trace-kernel/202402121809=
41.379c419b@gandalf.local.home/
>=20
> -- Added SAVED_CMDLINE_MAP_ELEMENT_SIZE helper macro.
>=20


