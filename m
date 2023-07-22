Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B32875DF71
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 01:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjGVX7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 19:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGVX7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 19:59:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B830A0;
        Sat, 22 Jul 2023 16:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=LdCxj801Ht28G0rQCx13yx2xtmGpyFI2ZkIeXhDpMo0=; b=C+1b9Mc+r/BExG40Gtw3eTuvMR
        tQuiJ1T8CLJ6kKeYXXIaeC7dqqzlVeL+mL286qomuXSUm9AOssj63PWZNw0yg2EfKRKDwfAljLW2J
        H4PyQUDPgmFBVMshlnygDT7y5vQU99TlPtJkgho1rGh4RESccFAt3lOipOBWF9lJoxN/qEPS9g+Dl
        L+1XXMLhrs7rdtOgKJA6LDuf1PzBhjM/CoBttnP0liw3nuRRhlMVRNOwHNWNO0NuTjHi2haZjF+sr
        GWhtrCzc2lKLQujHKAKMbqeIVlFWWp+i/4aRXjhxemTyXDBlCggXv4NNAYnb/V1bHrBRk3C22j5w1
        qRYso4Hg==;
Received: from 50-198-160-193-static.hfc.comcastbusiness.net ([50.198.160.193] helo=[10.150.81.113])
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNMVP-000xLy-2e;
        Sat, 22 Jul 2023 23:59:28 +0000
Message-ID: <52c883a3-5951-b298-cae4-a46fa0619411@infradead.org>
Date:   Sat, 22 Jul 2023 16:59:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/3] doc/vm: add information about page_table_check
 warn_on behavior
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        akpm@linux-foundation.org, corbet@lwn.net, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rick.p.edgecombe@intel.com
References: <20230722231508.1030269-1-pasha.tatashin@soleen.com>
 <20230722231508.1030269-3-pasha.tatashin@soleen.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230722231508.1030269-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/22/23 16:15, Pasha Tatashin wrote:
> The default behavior of page table check was changed from panicking
> kernel to printing a warning.
> 
> Add a note how to still panic the kernel when error is detected.
> 
> Signed-off-by: Pasha Tatashin<pasha.tatashin@soleen.com>
> ---
>   Documentation/mm/page_table_check.rst | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/mm/page_table_check.rst b/Documentation/mm/page_table_check.rst
> index c12838ce6b8d..f534c80ee9c9 100644
> --- a/Documentation/mm/page_table_check.rst
> +++ b/Documentation/mm/page_table_check.rst
> @@ -14,13 +14,14 @@ Page table check performs extra verifications at the time when new pages become
>   accessible from the userspace by getting their page table entries (PTEs PMDs
>   etc.) added into the table.
>   
> -In case of detected corruption, the kernel is crashed. There is a small
> +In case of detected corruption, a warning is printed. There is a small
>   performance and memory overhead associated with the page table check. Therefore,
>   it is disabled by default, but can be optionally enabled on systems where the
>   extra hardening outweighs the performance costs. Also, because page table check
>   is synchronous, it can help with debugging double map memory corruption issues,
>   by crashing kernel at the time wrong mapping occurs instead of later which is
> -often the case with memory corruptions bugs.
> +often the case with memory corruptions bugs. In order to crash kernel sysctl
> +panic_on_warn should be set to 1.

Better as:
   In order to crash the kernel, the sysctl panic_on_warn should be set 
to 1.

