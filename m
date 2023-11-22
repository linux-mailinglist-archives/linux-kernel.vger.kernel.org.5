Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BC27F3B34
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjKVBWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKVBWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:22:38 -0500
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B688390
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:22:33 -0800 (PST)
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
        by cmsmtp with ESMTPS
        id 5XX4rcsOoL9Ag5bwnrqVXA; Wed, 22 Nov 2023 01:22:33 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTPS
        id 5bwmrBrDeRGmS5bwmrSqjX; Wed, 22 Nov 2023 01:22:32 +0000
X-Authority-Analysis: v=2.4 cv=efcuwpIH c=1 sm=1 tr=0 ts=655d57d8
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=-Ou01B_BuAIA:10 a=HaFmDPmJAAAA:8
 a=VwQbUJbxAAAA:8 a=h0uksLzaAAAA:8 a=FaRPtKN-LDzFtTmNnPgA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=AjGcO6oz07-iQ99wixmX:22 a=MSi_79tMYmZZG2gvAgS0:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RlgtElTiAV+jkl5pCJINQq0IuuUqHZbOY44uni2U2rE=; b=Ee+RiHyyQXj1YX0NaENvHkjCwV
        z76604NUHk6uXKg6+ZUdadTz5DH//m/+z/UAfR3ROAfT9TbKRWXEVFQzW6JkRYBPcbnDf8RWW6eju
        TJiDGMmP9UG1qiLqen+s3cLZ79Lxa1ZyVt3vUzt2YPpkaz/5K6mxIxh7y+KN+Dk4NXbGWXxG4I3ZC
        M6m8n6u7w97iJL30WRG62IS/KfEbLpeRdaBIeNadmXPH+voj8Q3kLD2YF16My6P78C6Fv+JZYvyeh
        lQ9HgZBsxF4IcnLJmqD08S8qfnR+Voqavy8iX1+mf/8BAdKbON+e8P/TbzO8Kr9xQFZZVBGrSipo/
        n1txBuRQ==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:56208 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <re@w6rz.net>)
        id 1r5bwl-003wdA-2V;
        Tue, 21 Nov 2023 18:22:31 -0700
Subject: Re: [PATCH v2] riscv: Safely remove entries from relocation list
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231121-module_linking_freeing-v2-1-974bfcd3664e@rivosinc.com>
From:   Ron Economos <re@w6rz.net>
Message-ID: <dd1fe9eb-68ab-cbe3-8c07-1b7209236be2@w6rz.net>
Date:   Tue, 21 Nov 2023 17:22:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20231121-module_linking_freeing-v2-1-974bfcd3664e@rivosinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1r5bwl-003wdA-2V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:56208
X-Source-Auth: re@w6rz.net
X-Email-Count: 6
X-Org:  HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCCGLYJkmhe9CQQRA5vxWoMvgvmPiraF7Et2SAlRkUCPbANb6shk+aK1RK48JUzBdB6sAcVan82OS/7MPnesu2afdu4YLi17l/kHiHD0Nd5sCSw1jMdP
 RyuLW511emsMCcWh6OjwyiEBJODGowIrPNetGQKOBPxNVFMsPsxAtYWDd62tqPU3ZJ3ZK6fFZMY2KZml2wpnt5/kQpX4AIMTCKU=
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/23 2:50 PM, Charlie Jenkins wrote:
> Use the safe versions of list and hlist iteration to safely remove
> entries from the module relocation lists. To allow mutliple threads to
> load modules concurrently, move relocation list pointers onto the stack
> rather than using global variables.
>
> Fixes: 8fd6c5142395 ("riscv: Add remaining module relocations")
> Reported-by: Ron Economos <re@w6rz.net>
> Closes: https://lore.kernel.org/linux-riscv/444de86a-7e7c-4de7-5d1d-c1c40eefa4ba@w6rz.net
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Changes in v2:
> - Support linking modules concurrently across threads.
> - Link to v1: https://lore.kernel.org/r/20231120-module_linking_freeing-v1-1-fff81d7289fc@rivosinc.com
> ---
>   arch/riscv/kernel/module.c | 76 +++++++++++++++++++++++++++++++---------------
>   1 file changed, 51 insertions(+), 25 deletions(-)
>
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 56a8c78e9e21..f53e82b70dff 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -40,14 +40,17 @@ struct relocation_handlers {
>   				  long buffer);
>   };
>   
> -unsigned int initialize_relocation_hashtable(unsigned int num_relocations);
> -void process_accumulated_relocations(struct module *me);
> +unsigned int
> +initialize_relocation_hashtable(unsigned int num_relocations,
> +				struct hlist_head **relocation_hashtable,
> +				struct list_head *used_buckets_list);
> +void process_accumulated_relocations(struct module *me,
> +				     struct hlist_head **relocation_hashtable,
> +				     struct list_head *used_buckets_list);
>   int add_relocation_to_accumulate(struct module *me, int type, void *location,
> -				 unsigned int hashtable_bits, Elf_Addr v);
> -
> -struct hlist_head *relocation_hashtable;
> -
> -struct list_head used_buckets_list;
> +				 unsigned int hashtable_bits, Elf_Addr v,
> +				struct hlist_head **relocation_hashtable,
> +				struct list_head *used_buckets_list);
>   
>   /*
>    * The auipc+jalr instruction pair can reach any PC-relative offset
> @@ -604,7 +607,9 @@ static const struct relocation_handlers reloc_handlers[] = {
>   	/* 192-255 nonstandard ABI extensions  */
>   };
>   
> -void process_accumulated_relocations(struct module *me)
> +void process_accumulated_relocations(struct module *me,
> +				     struct hlist_head **relocation_hashtable,
> +				     struct list_head *used_buckets_list)
>   {
>   	/*
>   	 * Only ADD/SUB/SET/ULEB128 should end up here.
> @@ -624,18 +629,25 @@ void process_accumulated_relocations(struct module *me)
>   	 *	- Each relocation entry for a location address
>   	 */
>   	struct used_bucket *bucket_iter;
> +	struct used_bucket *bucket_iter_tmp;
>   	struct relocation_head *rel_head_iter;
> +	struct hlist_node *rel_head_iter_tmp;
>   	struct relocation_entry *rel_entry_iter;
> +	struct relocation_entry *rel_entry_iter_tmp;
>   	int curr_type;
>   	void *location;
>   	long buffer;
>   
> -	list_for_each_entry(bucket_iter, &used_buckets_list, head) {
> -		hlist_for_each_entry(rel_head_iter, bucket_iter->bucket, node) {
> +	list_for_each_entry_safe(bucket_iter, bucket_iter_tmp,
> +				 used_buckets_list, head) {
> +		hlist_for_each_entry_safe(rel_head_iter, rel_head_iter_tmp,
> +					  bucket_iter->bucket, node) {
>   			buffer = 0;
>   			location = rel_head_iter->location;
> -			list_for_each_entry(rel_entry_iter,
> -					    rel_head_iter->rel_entry, head) {
> +			list_for_each_entry_safe(rel_entry_iter,
> +						 rel_entry_iter_tmp,
> +						 rel_head_iter->rel_entry,
> +						 head) {
>   				curr_type = rel_entry_iter->type;
>   				reloc_handlers[curr_type].reloc_handler(
>   					me, &buffer, rel_entry_iter->value);
> @@ -648,11 +660,13 @@ void process_accumulated_relocations(struct module *me)
>   		kfree(bucket_iter);
>   	}
>   
> -	kfree(relocation_hashtable);
> +	kfree(*relocation_hashtable);
>   }
>   
>   int add_relocation_to_accumulate(struct module *me, int type, void *location,
> -				 unsigned int hashtable_bits, Elf_Addr v)
> +				 unsigned int hashtable_bits, Elf_Addr v,
> +				struct hlist_head **relocation_hashtable,
> +				struct list_head *used_buckets_list)
>   {
>   	struct relocation_entry *entry;
>   	struct relocation_head *rel_head;
> @@ -667,7 +681,7 @@ int add_relocation_to_accumulate(struct module *me, int type, void *location,
>   
>   	hash = hash_min((uintptr_t)location, hashtable_bits);
>   
> -	current_head = &relocation_hashtable[hash];
> +	current_head = &((*relocation_hashtable)[hash]);
>   
>   	/* Find matching location (if any) */
>   	bool found = false;
> @@ -693,7 +707,7 @@ int add_relocation_to_accumulate(struct module *me, int type, void *location,
>   				kmalloc(sizeof(struct used_bucket), GFP_KERNEL);
>   			INIT_LIST_HEAD(&bucket->head);
>   			bucket->bucket = current_head;
> -			list_add(&bucket->head, &used_buckets_list);
> +			list_add(&bucket->head, used_buckets_list);
>   		}
>   		hlist_add_head(&rel_head->node, current_head);
>   	}
> @@ -704,7 +718,10 @@ int add_relocation_to_accumulate(struct module *me, int type, void *location,
>   	return 0;
>   }
>   
> -unsigned int initialize_relocation_hashtable(unsigned int num_relocations)
> +unsigned int
> +initialize_relocation_hashtable(unsigned int num_relocations,
> +				struct hlist_head **relocation_hashtable,
> +				struct list_head *used_buckets_list)
>   {
>   	/* Can safely assume that bits is not greater than sizeof(long) */
>   	unsigned long hashtable_size = roundup_pow_of_two(num_relocations);
> @@ -720,12 +737,12 @@ unsigned int initialize_relocation_hashtable(unsigned int num_relocations)
>   
>   	hashtable_size <<= should_double_size;
>   
> -	relocation_hashtable = kmalloc_array(hashtable_size,
> -					     sizeof(*relocation_hashtable),
> -					     GFP_KERNEL);
> -	__hash_init(relocation_hashtable, hashtable_size);
> +	*relocation_hashtable = kmalloc_array(hashtable_size,
> +					      sizeof(*relocation_hashtable),
> +					      GFP_KERNEL);
> +	__hash_init(*relocation_hashtable, hashtable_size);
>   
> -	INIT_LIST_HEAD(&used_buckets_list);
> +	INIT_LIST_HEAD(used_buckets_list);
>   
>   	return hashtable_bits;
>   }
> @@ -742,7 +759,13 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
>   	Elf_Addr v;
>   	int res;
>   	unsigned int num_relocations = sechdrs[relsec].sh_size / sizeof(*rel);
> -	unsigned int hashtable_bits = initialize_relocation_hashtable(num_relocations);
> +	struct hlist_head *relocation_hashtable;
> +	struct list_head used_buckets_list;
> +	unsigned int hashtable_bits;
> +
> +	hashtable_bits = initialize_relocation_hashtable(num_relocations,
> +							 &relocation_hashtable,
> +							 &used_buckets_list);
>   
>   	pr_debug("Applying relocate section %u to %u\n", relsec,
>   	       sechdrs[relsec].sh_info);
> @@ -823,14 +846,17 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
>   		}
>   
>   		if (reloc_handlers[type].accumulate_handler)
> -			res = add_relocation_to_accumulate(me, type, location, hashtable_bits, v);
> +			res = add_relocation_to_accumulate(
> +				me, type, location, hashtable_bits, v,
> +				&relocation_hashtable, &used_buckets_list);
>   		else
>   			res = handler(me, location, v);
>   		if (res)
>   			return res;
>   	}
>   
> -	process_accumulated_relocations(me);
> +	process_accumulated_relocations(me, &relocation_hashtable,
> +					&used_buckets_list);
>   
>   	return 0;
>   }
>
> ---
> base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
> change-id: 20231120-module_linking_freeing-2b5a3b255b5e

That did the trick. Booted ten times on Unmatched with no problems.

Tested-by: Ron Economos <re@w6rz.net>

