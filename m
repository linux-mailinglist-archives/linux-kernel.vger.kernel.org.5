Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC3F7880CA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbjHYHTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243175AbjHYHTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:19:24 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1479919B5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:19:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RXBCP1xy8z4f3kjV
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:19:13 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgBH16nuVehkUYQkBg--.15410S3;
        Fri, 25 Aug 2023 15:19:14 +0800 (CST)
Subject: Re: [PATCH] kallsyms: Fix kallsyms_selftest failure
To:     Yonghong Song <yonghong.song@linux.dev>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Fangrui Song <maskray@google.com>, kernel-team@fb.com,
        Leizhen <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel test robot <oliver.sang@intel.com>
References: <20230825034659.1037627-1-yonghong.song@linux.dev>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <95a7d98c-b227-7929-b833-f6adc3b7e3ca@huaweicloud.com>
Date:   Fri, 25 Aug 2023 15:19:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230825034659.1037627-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBH16nuVehkUYQkBg--.15410S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyxCw1xAF1rZFyrtFW7CFg_yoW7Xw47pr
        WSyFsrGF48Ar1Fka4UJay8WryxCws5Xw1UGayqkFykCFn5ury0qwn7Kw4fu3s8ZrZ8uFWr
        XanYvFyxtF10yFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/25 11:46, Yonghong Song wrote:
> Kernel test robot reported a kallsyms_test failure when clang lto is
> enabled (thin or full) and CONFIG_KALLSYMS_SELFTEST is also enabled.
> I can reproduce in my local environment with the following error message
> with thin lto:
>   [    1.877897] kallsyms_selftest: Test for 1750th symbol failed: (tsc_cs_mark_unstable) addr=ffffffff81038090
>   [    1.877901] kallsyms_selftest: abort
> 
> It appears that commit 8cc32a9bbf29 ("kallsyms: strip LTO-only suffixes
> from promoted global functions") caused the failure. Commit 8cc32a9bbf29
> changed cleanup_symbol_name() based on ".llvm." instead of '.' where
> ".llvm." is appended to a before-lto-optimization local symbol name.
> We need to propagate such knowledge in kallsyms_selftest.c as well.
> 
> Further more, compare_symbol_name() in kallsyms.c needs change as well.
> In scripts/kallsyms.c, kallsyms_names and kallsyms_seqs_of_names are used
> to record symbol names themselves and index to symbol names respectively.
> For example:
>   kallsyms_names:
>     ...
>     __amd_smn_rw._entry       <== seq 1000
>     __amd_smn_rw._entry.5     <== seq 1001
>     __amd_smn_rw.llvm.<hash>  <== seq 1002
>     ...
> 
> kallsyms_seqs_of_names are sorted based on cleanup_symbol_name() through, so
> the order in kallsyms_seqs_of_names actually has
> 
>   index 1000:   seq 1002   <== __amd_smn_rw.llvm.<hash> (actual symbol comparison using '__amd_smn_rw')
>   index 1001:   seq 1000   <== __amd_smn_rw._entry
>   index 1002:   seq 1001   <== __amd_smn_rw._entry.5
> 
> Let us say at a particular point, at index 1000, symbol '__amd_smn_rw.llvm.<hash>'
> is comparing to '__amd_smn_rw._entry' where '__amd_smn_rw._entry' is the one to
> search e.g., with function kallsyms_on_each_match_symbol(). The current implementation
> will find out '__amd_smn_rw._entry' is less than '__amd_smn_rw.llvm.<hash>' and
> then continue to search e.g., index 999 and never found a match although the actual
> index 1001 is a match.
> 
> To fix this issue, let us do cleanup_symbol_name() first and then do comparison.
> In the above case, comparing '__amd_smn_rw' vs '__amd_smn_rw._entry' and
> '__amd_smn_rw._entry' being greater than '__amd_smn_rw', the next comparison will
> be > index 1000 and eventually index 1001 will be hit an a match is found.
> 
> For any symbols not having '.llvm.' substr, there is no functionality change
> for compare_symbol_name().

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Fixes: 8cc32a9bbf29 ("kallsyms: strip LTO-only suffixes from promoted global functions")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202308232200.1c932a90-oliver.sang@intel.com
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/kallsyms.c          | 17 +++++++----------
>  kernel/kallsyms_selftest.c | 23 +----------------------
>  2 files changed, 8 insertions(+), 32 deletions(-)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 016d997131d4..e12d26c10dba 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -188,16 +188,13 @@ static bool cleanup_symbol_name(char *s)
>  
>  static int compare_symbol_name(const char *name, char *namebuf)
>  {
> -	int ret;
> -
> -	ret = strcmp(name, namebuf);
> -	if (!ret)
> -		return ret;
> -
> -	if (cleanup_symbol_name(namebuf) && !strcmp(name, namebuf))
> -		return 0;
> -
> -	return ret;
> +	/* The kallsyms_seqs_of_names is sorted based on names after
> +	 * cleanup_symbol_name() (see scripts/kallsyms.c) if clang lto is enabled.
> +	 * To ensure correct bisection in kallsyms_lookup_names(), do
> +	 * cleanup_symbol_name(namebuf) before comparing name and namebuf.
> +	 */
> +	cleanup_symbol_name(namebuf);
> +	return strcmp(name, namebuf);
>  }
>  
>  static unsigned int get_symbol_seq(int index)
> diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
> index a2e3745d15c4..e05ddc33a752 100644
> --- a/kernel/kallsyms_selftest.c
> +++ b/kernel/kallsyms_selftest.c
> @@ -196,7 +196,7 @@ static bool match_cleanup_name(const char *s, const char *name)
>  	if (!IS_ENABLED(CONFIG_LTO_CLANG))
>  		return false;
>  
> -	p = strchr(s, '.');
> +	p = strstr(s, ".llvm.");
>  	if (!p)
>  		return false;
>  
> @@ -344,27 +344,6 @@ static int test_kallsyms_basic_function(void)
>  			goto failed;
>  		}
>  
> -		/*
> -		 * The first '.' may be the initial letter, in which case the
> -		 * entire symbol name will be truncated to an empty string in
> -		 * cleanup_symbol_name(). Do not test these symbols.
> -		 *
> -		 * For example:
> -		 * cat /proc/kallsyms | awk '{print $3}' | grep -E "^\." | head
> -		 * .E_read_words
> -		 * .E_leading_bytes
> -		 * .E_trailing_bytes
> -		 * .E_write_words
> -		 * .E_copy
> -		 * .str.292.llvm.12122243386960820698
> -		 * .str.24.llvm.12122243386960820698
> -		 * .str.29.llvm.12122243386960820698
> -		 * .str.75.llvm.12122243386960820698
> -		 * .str.99.llvm.12122243386960820698
> -		 */
> -		if (IS_ENABLED(CONFIG_LTO_CLANG) && !namebuf[0])
> -			continue;
> -
>  		lookup_addr = kallsyms_lookup_name(namebuf);
>  
>  		memset(stat, 0, sizeof(*stat));
> 

-- 
Regards,
  Zhen Lei

