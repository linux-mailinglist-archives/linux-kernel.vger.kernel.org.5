Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1091C80AA8F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574434AbjLHRUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbjLHRUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:20:17 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5C22D40;
        Fri,  8 Dec 2023 09:19:52 -0800 (PST)
Received: from [192.168.1.104] (178.176.72.145) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 8 Dec
 2023 20:19:49 +0300
Subject: Re: [PATCH v4 09/22] MIPS: traps: Handle CPU with non standard vint
 offset
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-mips@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Th=c3=a9o_Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20231208161249.1827174-1-gregory.clement@bootlin.com>
 <20231208161249.1827174-10-gregory.clement@bootlin.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <94e4bafb-7c4d-d6bf-7440-f487243a1a59@omp.ru>
Date:   Fri, 8 Dec 2023 20:19:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20231208161249.1827174-10-gregory.clement@bootlin.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.72.145]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.0.0, Database issued on: 12/08/2023 17:00:03
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 181987 [Dec 08 2023]
X-KSE-AntiSpam-Info: Version: 6.0.0.2
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 6 0.3.6 62f5a4619c57459c9a142aa1486ed27913162963
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.72.145
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/08/2023 17:07:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 12/8/2023 1:21:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/23 7:12 PM, Gregory CLEMENT wrote:

> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> 
> Some BMIPS cpus has none standard start offset for vector interrupts.
> 
> Handle those CPUs in vector size calculation and handler setup process.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/kernel/traps.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index ea59d321f713e..651c9ec6265a9 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -74,7 +74,6 @@
>  
>  #include "access-helper.h"
>  
> -#define MAX(a, b) ((a) >= (b) ? (a) : (b))
>  
>  extern void check_wait(void);
>  extern asmlinkage void rollback_handle_int(void);
> @@ -2005,6 +2004,7 @@ void __noreturn nmi_exception_handler(struct pt_regs *regs)
>  unsigned long ebase;
>  EXPORT_SYMBOL_GPL(ebase);
>  unsigned long exception_handlers[32];
> +static unsigned long vi_vecbase;
>  unsigned long vi_handlers[64];
>  
>  void reserve_exception_space(phys_addr_t addr, unsigned long size)
> @@ -2074,7 +2074,7 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
>  		handler = (unsigned long) addr;
>  	vi_handlers[n] = handler;
>  
> -	b = (unsigned char *)(ebase + 0x200 + n*VECTORSPACING);
> +	b = (unsigned char *)(vi_vecbase + n*VECTORSPACING);

   Add spaces around * for consistency please.

[...]
> @@ -2370,20 +2370,33 @@ void __init trap_init(void)
>  	extern char except_vec3_generic;
>  	extern char except_vec4;
>  	extern char except_vec3_r4000;
> -	unsigned long i, vec_size;
> +	unsigned long i, vec_size, vi_vec_offset;
>  	phys_addr_t ebase_pa;
>  
>  	check_wait();
>  
> +	if (cpu_has_veic || cpu_has_vint) {
> +		switch (current_cpu_type()) {
> +		case CPU_BMIPS3300:
> +		case CPU_BMIPS4380:
> +			vi_vec_offset = 0x400;
> +			break;
> +		case CPU_BMIPS5000:
> +			vi_vec_offset = 0x1000;
> +			break;
> +		default:
> +			vi_vec_offset = 0x200;
> +			break;
> +		}
> +		vec_size = vi_vec_offset + VECTORSPACING*64;

   Here as well...

[...]

MBR, Sergey
