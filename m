Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF317EB457
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjKNQDb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Nov 2023 11:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjKNQDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:03:30 -0500
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258C7132
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:03:25 -0800 (PST)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 5849480ADD;
        Tue, 14 Nov 2023 16:03:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id B79FD17;
        Tue, 14 Nov 2023 16:03:19 +0000 (UTC)
Message-ID: <1e7863ec4e4ab10b84fd0e64f30f8464d2e484a3.camel@perches.com>
Subject: Re: [PATCH 1/7] kexec_file: add kexec_file flag to control debug
 printing
From:   Joe Perches <joe@perches.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org
Date:   Tue, 14 Nov 2023 08:03:17 -0800
In-Reply-To: <20231114153253.241262-2-bhe@redhat.com>
References: <20231114153253.241262-1-bhe@redhat.com>
         <20231114153253.241262-2-bhe@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: B79FD17
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout06
X-Stat-Signature: hfguyu43qitk9i95uumxmjn7sq3qxaae
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+TPCSBX5eIBtFS7cutbFXyyoB+lO2Ea1A=
X-HE-Tag: 1699977799-197779
X-HE-Meta: U2FsdGVkX199MxvfdP2OiWMaMCgnF+zen3H+uDaMOt+eo18KFoigVkpo/j1mPnNdRxZsnaKbc/2TMWhhtZ1WYbE4xnaRnZ9D8ImVTw0nNbwHPVmM8K50LsJ54PlQr2IROfdWLMnnNPpRHRTXWI450/26vHlRs47bJHW69JfdozUlDgILIKSRfePjUbHAIXoIKr9/NzIpcA6QdsnzFrKhA8GVb/HExMWgTm+7q60/jyGC6TQFrwo3I1762UXDKC1ld2/TBOn7K4fNFKAezne04n/qoyaeJN2h75PDcDpXFrJm8izGV0wc97AWTmYxsKdc
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-14 at 23:32 +0800, Baoquan He wrote:
> When specifying 'kexec -c -d', kexec_load interface will print loading
> information, e.g the regions where kernel/initrd/purgatory/cmdline
> are put, the memmap passed to 2nd kernel taken as system RAM ranges,
> and printing all contents of struct kexec_segment, etc. These are
> very helpful for analyzing or positioning what's happening when
> kexec/kdump itself failed. The debugging printing for kexec_load
> interface is made in user space utility kexec-tools.
> 
> Whereas, with kexec_file_load interface, 'kexec -s -d' print nothing.
> Because kexec_file code is mostly implemented in kernel space, and the
> debugging printing functionality is missed. It's not convenient when
> debugging kexec/kdump loading and jumping with kexec_file_load
> interface.
> 
> Now add KEXEC_FILE_DEBUG to kexec_file flag to control the debugging
> message printing. And add global variable kexec_file_dbg_print and
> macro kexec_dprintk() to facilitate the printing.
> 
> This is a preparation, later kexec_dprintk() will be used to replace the
> existing pr_debug(). Once 'kexec -s -d' is specified, it will print out
> kexec/kdump loading information. If '-d' is not specified, it regresses
> to pr_debug().

Not quite as pr_debug is completely eliminated with
zero object size when DEBUG is not #defined.

Now the object size will be larger and contain the
formats in .text.

[]
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
[]
> @@ -264,6 +264,18 @@ arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
>  	return -ENOEXEC;
>  }
>  #endif
> +
> +extern bool kexec_file_dbg_print;
> +
> +#define kexec_dprintk(fmt, args...)			\
> +	do {						\
> +		if (kexec_file_dbg_print)		\
> +			printk(KERN_INFO fmt, ##args);	\
> +		else					\
> +			printk(KERN_DEBUG fmt, ##args);	\
> +	} while (0)
> +
> +

I don't know how many of these printks exist and if
overall object size matters but using

#define kexec_dprintkfmt, ...)					\
	printk("%s" fmt,					\
	       kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,	\
	       ##__VA_ARGS__)

should reduce overall object size by eliminating the
mostly duplicated format in .text which differs only
by the KERN_<PREFIX>


