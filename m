Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7BE7FE76B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344208AbjK3CwY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 21:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjK3CwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:52:23 -0500
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF790CC;
        Wed, 29 Nov 2023 18:52:29 -0800 (PST)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id 0CD43406F7;
        Thu, 30 Nov 2023 02:52:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 2F8892000D;
        Thu, 30 Nov 2023 02:52:25 +0000 (UTC)
Message-ID: <81c62af671ebbfad61dd46aa056050a56bf535a2.camel@perches.com>
Subject: Re: [PATCH v3 2/7] kexec_file: print out debugging message if
 required
From:   Joe Perches <joe@perches.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, akpm@linux-foundation.org,
        nathan@kernel.org
Date:   Wed, 29 Nov 2023 18:52:24 -0800
In-Reply-To: <20231130023955.5257-3-bhe@redhat.com>
References: <20231130023955.5257-1-bhe@redhat.com>
         <20231130023955.5257-3-bhe@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 2F8892000D
X-Stat-Signature: gwk7qi3h7jx8h1ywf1jic8xo76gqerwm
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19dPUefOesSFHLQCs3wqOW/oGlv3aC7z+4=
X-HE-Tag: 1701312745-366478
X-HE-Meta: U2FsdGVkX18k/ADXByHc+CtueZc2/kIRg2iYeavR6SwxdbkG44laEheGJWfEZEWXVPPjQNlGsgWVgExQ2v2SkjkkfNjpPwEMSuNPMyCDovT0AEEC3qeJ3Q3CanYRUyaIkLf9UCVzbPHogNji1emX5sy1KMlEpsNMU2L1IT5Ygh0f8/d2RbC7l5Zlkk01sF8weznUFCSh7sTGbvtjt1bjs0D9vOhDdBlZRMDNhbUzmGZ+P97DoYPvnsvnrduPVTPJ/denAd96V06q4DDxaFl1zt06dspwDHAATuNX205GsU5+pYEk/u0vlxrjfS1T3iX3
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-30 at 10:39 +0800, Baoquan He wrote:
> Replace pr_debug() with the newly added kexec_dprintk() in kexec_file
> loading related codes.

trivia:

> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
[]
> @@ -551,9 +551,12 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>  		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
>  		phdr->p_align = 0;
>  		ehdr->e_phnum++;
> -		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
> -			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
> -			ehdr->e_phnum, phdr->p_offset);
> +#ifdef CONFIG_KEXEC_FILE
> +		kexec_dprintk("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, "
> +			      "sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
> +			      phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
> +			      ehdr->e_phnum, phdr->p_offset);
> +#endif

Perhaps run checkpatch and coalesce the format string.

