Return-Path: <linux-kernel+bounces-167254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28338BA67B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00BFFB21CB8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9A6139584;
	Fri,  3 May 2024 05:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DpE6j94G"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404CAEEDD;
	Fri,  3 May 2024 05:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714713009; cv=none; b=BGj6q12HYbCVvi8qPT6Fg02PNeanpEDP2JUtHq8s2AWYa8Uko7VqrVSho8lEwgu7aejyaB4g/womIYxh5q5PlROH1a5ePlWCU9nDS/NL8KF6f7sONIP7gl0xf5IVBlprLO+xY8yMvGIRpHhw+2JU3ITZs3oYAQbu7l+IJQTAMm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714713009; c=relaxed/simple;
	bh=/5tPuTbMa7cDbxIgwPiugXD9H0Bq8yuFKYEWRRCjsxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=liP7kaPx21C0QwLbP/UyUgW3if1PlPxoXWaSoSz0FK13PIz/9oWtf0Tp5iBQJzMCEpm0/P1hpz/y3TYnj9XeA6owEUIXf7MN+BwAVao3Sb+t9heaG4Pt6N0OzjEB/t7clCYhUZ8KIwl8gECmr9FOe5FIKw757+4hjyo31LhxjuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DpE6j94G; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714713007; x=1746249007;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/5tPuTbMa7cDbxIgwPiugXD9H0Bq8yuFKYEWRRCjsxs=;
  b=DpE6j94G6qOUJjiPk0jEYaNdcstRzT7jqwDokt8FZWNrI9v2FSq3dXX5
   IPsX9QR42y+CMQgYHFgTyshIMo0HghHTZlqZafmNkPnlMZM2abusHufi7
   4yS4havWyDqZhQUvavVbJU/94x62BPAJtSrcPJFGO3pqi5ePo+EJ/26WJ
   F5PIT8ETt1ldCzxcZMZ0OG5G8wQ7ruAujTqU0RU34RX3bbw5MH9wNt7EP
   YpKMfHLQHegZozTYU7wr6g7spOiM6CdcXevS3sfbMXCvxfyFjGosO9qKM
   Od+buQApIpLcK+wTkTldcCkgui1v9UMZ/7MKkPc7UjU4af5GTFvOAQiOp
   w==;
X-CSE-ConnectionGUID: T2KILX19TDCUKTGIpjyBXw==
X-CSE-MsgGUID: gz5t9AmZReSZCPiLzFcT7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="21132390"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21132390"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 22:10:06 -0700
X-CSE-ConnectionGUID: yLpbXs2URP6znrjHeJaizw==
X-CSE-MsgGUID: yll8KhO3S3KLlGU+BU1/EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31826161"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.32.201])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 22:10:03 -0700
Message-ID: <902c993e-5d4b-4d97-8d48-450dc1ab2b30@intel.com>
Date: Fri, 3 May 2024 08:09:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] x86/insn: Add support for REX2 prefix to the
 instruction decoder logic
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, "Chang S. Bae" <chang.seok.bae@intel.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Nikolay Borisov <nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
References: <20240502105853.5338-1-adrian.hunter@intel.com>
 <20240502105853.5338-6-adrian.hunter@intel.com>
 <CAP-5=fX4UxekyxkaX8EH8UcAXe-JAdXRTCguWmTJ8mARg64h-Q@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fX4UxekyxkaX8EH8UcAXe-JAdXRTCguWmTJ8mARg64h-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/05/24 21:10, Ian Rogers wrote:
> On Thu, May 2, 2024 at 3:59 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> Intel Advanced Performance Extensions (APX) uses a new 2-byte prefix named
>> REX2 to select extended general purpose registers (EGPRs) i.e. r16 to r31.
>>
>> The REX2 prefix is effectively an extended version of the REX prefix.
>>
>> REX2 and EVEX are also used with PUSH/POP instructions to provide a
>> Push-Pop Acceleration (PPX) hint. With PPX hints, a CPU will attempt to
>> fast-forward register data between matching PUSH and POP instructions.
>>
>> REX2 is valid only with opcodes in maps 0 and 1. Similar extension for
>> other maps is provided by the EVEX prefix, covered in a separate patch.
>>
>> Some opcodes in maps 0 and 1 are reserved under REX2. One of these is used
>> for a new 64-bit absolute direct jump instruction JMPABS.
>>
>> Refer to the Intel Advanced Performance Extensions (Intel APX) Architecture
>> Specification for details.
>>
>> Define a code value for the REX2 prefix (INAT_PFX_REX2), and add attribute
>> flags for opcodes reserved under REX2 (INAT_NO_REX2) and to identify
>> opcodes (only JMPABS) that require a mandatory REX2 prefix
>> (INAT_REX2_VARIANT).
>>
>> Amend logic to read the REX2 prefix and get the opcode attribute for the
>> map number (0 or 1) encoded in the REX2 prefix.
>>
>> Amend the awk script that generates the attribute tables from the opcode
>> map, to recognise "REX2" as attribute INAT_PFX_REX2, and "(!REX2)"
>> as attribute INAT_NO_REX2, and "(REX2)" as attribute INAT_REX2_VARIANT.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  arch/x86/include/asm/inat.h                | 11 +++++++++-
>>  arch/x86/include/asm/insn.h                | 25 ++++++++++++++++++----
>>  arch/x86/lib/insn.c                        | 25 ++++++++++++++++++++++
>>  arch/x86/tools/gen-insn-attr-x86.awk       | 11 +++++++++-
>>  tools/arch/x86/include/asm/inat.h          | 11 +++++++++-
>>  tools/arch/x86/include/asm/insn.h          | 25 ++++++++++++++++++----
>>  tools/arch/x86/lib/insn.c                  | 25 ++++++++++++++++++++++
>>  tools/arch/x86/tools/gen-insn-attr-x86.awk | 11 +++++++++-
>>  8 files changed, 132 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/inat.h b/arch/x86/include/asm/inat.h
>> index b56c5741581a..1331bdd39a23 100644
>> --- a/arch/x86/include/asm/inat.h
>> +++ b/arch/x86/include/asm/inat.h
>> @@ -35,6 +35,8 @@
>>  #define INAT_PFX_VEX2  13      /* 2-bytes VEX prefix */
>>  #define INAT_PFX_VEX3  14      /* 3-bytes VEX prefix */
>>  #define INAT_PFX_EVEX  15      /* EVEX prefix */
>> +/* x86-64 REX2 prefix */
>> +#define INAT_PFX_REX2  16      /* 0xD5 */
>>
>>  #define INAT_LSTPFX_MAX        3
>>  #define INAT_LGCPFX_MAX        11
>> @@ -50,7 +52,7 @@
>>
>>  /* Legacy prefix */
>>  #define INAT_PFX_OFFS  0
>> -#define INAT_PFX_BITS  4
>> +#define INAT_PFX_BITS  5
>>  #define INAT_PFX_MAX    ((1 << INAT_PFX_BITS) - 1)
>>  #define INAT_PFX_MASK  (INAT_PFX_MAX << INAT_PFX_OFFS)
>>  /* Escape opcodes */
>> @@ -77,6 +79,8 @@
>>  #define INAT_VEXOK     (1 << (INAT_FLAG_OFFS + 5))
>>  #define INAT_VEXONLY   (1 << (INAT_FLAG_OFFS + 6))
>>  #define INAT_EVEXONLY  (1 << (INAT_FLAG_OFFS + 7))
>> +#define INAT_NO_REX2   (1 << (INAT_FLAG_OFFS + 8))
>> +#define INAT_REX2_VARIANT      (1 << (INAT_FLAG_OFFS + 9))
>>  /* Attribute making macros for attribute tables */
>>  #define INAT_MAKE_PREFIX(pfx)  (pfx << INAT_PFX_OFFS)
>>  #define INAT_MAKE_ESCAPE(esc)  (esc << INAT_ESC_OFFS)
>> @@ -128,6 +132,11 @@ static inline int inat_is_rex_prefix(insn_attr_t attr)
>>         return (attr & INAT_PFX_MASK) == INAT_PFX_REX;
>>  }
>>
>> +static inline int inat_is_rex2_prefix(insn_attr_t attr)
>> +{
>> +       return (attr & INAT_PFX_MASK) == INAT_PFX_REX2;
>> +}
>> +
>>  static inline int inat_last_prefix_id(insn_attr_t attr)
>>  {
>>         if ((attr & INAT_PFX_MASK) > INAT_LSTPFX_MAX)
>> diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
>> index 1b29f58f730f..95249ec1f24e 100644
>> --- a/arch/x86/include/asm/insn.h
>> +++ b/arch/x86/include/asm/insn.h
>> @@ -112,10 +112,15 @@ struct insn {
>>  #define X86_SIB_INDEX(sib) (((sib) & 0x38) >> 3)
>>  #define X86_SIB_BASE(sib) ((sib) & 0x07)
>>
>> -#define X86_REX_W(rex) ((rex) & 8)
>> -#define X86_REX_R(rex) ((rex) & 4)
>> -#define X86_REX_X(rex) ((rex) & 2)
>> -#define X86_REX_B(rex) ((rex) & 1)
>> +#define X86_REX2_M(rex) ((rex) & 0x80) /* REX2 M0 */
>> +#define X86_REX2_R(rex) ((rex) & 0x40) /* REX2 R4 */
>> +#define X86_REX2_X(rex) ((rex) & 0x20) /* REX2 X4 */
>> +#define X86_REX2_B(rex) ((rex) & 0x10) /* REX2 B4 */
>> +
>> +#define X86_REX_W(rex) ((rex) & 8)     /* REX or REX2 W */
>> +#define X86_REX_R(rex) ((rex) & 4)     /* REX or REX2 R3 */
>> +#define X86_REX_X(rex) ((rex) & 2)     /* REX or REX2 X3 */
>> +#define X86_REX_B(rex) ((rex) & 1)     /* REX or REX2 B3 */
>>
>>  /* VEX bit flags  */
>>  #define X86_VEX_W(vex) ((vex) & 0x80)  /* VEX3 Byte2 */
>> @@ -161,6 +166,18 @@ static inline void insn_get_attribute(struct insn *insn)
>>  /* Instruction uses RIP-relative addressing */
>>  extern int insn_rip_relative(struct insn *insn);
>>
>> +static inline int insn_is_rex2(struct insn *insn)
>> +{
>> +       if (!insn->prefixes.got)
>> +               insn_get_prefixes(insn);
>> +       return insn->rex_prefix.nbytes == 2;
> 
> It'd be nice to capture that a rex2 prefix is by definition 2 bytes.
> Playing devil's advocate, if there were a REX and a REX2 prefix,
> couldn't rex_prefix.nbytes be 3? I'm wondering about other prefix
> combinations that may confuse this logic, maybe someone dreams up
> doing this for say alignment reasons like "rep ret".

REX with REX2 is not allowed.


