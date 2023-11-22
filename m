Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057A77F3C7D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343602AbjKVDlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKVDlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:41:35 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E4190
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:41:30 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b82541da51so1640125b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700624490; x=1701229290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lTFMml4INEv5C+irajH43nV2pQy7Qcw7rpWXL+qKufA=;
        b=RBIlTfw2fo8A76aayj12LVgCuhIGb4tI2evm68mOylhCYUeYrls8ZVVJQcxzzPzJI2
         eVeEkEXpTm2/L31+Aeg20Leyu/mcNJZocdv7fs0gnuLR1TcuzZ2YymhjvmUuOGxOHqyW
         QmeF6NLh8GTg36x70CwyCd060IWYRag7GN/tYbVpHqiZQsjnX20ofmiT9njTlHaebsDb
         smnmLglQ0xoOEcX3hsuBlPSGNlW1HX/iBeBSbsu1CrT9Xpi6+WdypQV24aAIS2/yyVJb
         Mmu6eMOP0S1WXHakW/ZxIh/SyalS87qRAFmBm0RR/EYm7RfoqaHFtWoURxBk5bLRaJ0d
         +Mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700624490; x=1701229290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTFMml4INEv5C+irajH43nV2pQy7Qcw7rpWXL+qKufA=;
        b=Qwwq146DsPUdUnGaPniXCBloEy0svxM9s92s8bBfFS8wb7vpktnTAVnZhz/s2ipgGU
         E/u9s12wlKkR+ELbEshMqGFtLbvbtb9MxgD3mFHLjbWTW1xTIzICqLiGFSTlgRDPL7tQ
         RxLnHMCVRpPjp5xJdx90PZ1BbDF9ou0l1lndVFvXc2+96c2QMlpiNJ6FF2dH7hLiYu9v
         1tINUXYuWRerTu7H2BjzScIf7FRaN5jUmA2Il1e9Fyc/8x0uSsToJ7YO2N4eTQxnaNVN
         5EpxU0GWv+F+CqB4iu0Z3W8kMp5gxciDRsSP7y79Zacut+HcYZ5ILT4HgIwHUaTGloGk
         0ADw==
X-Gm-Message-State: AOJu0YxG60n7skFocy1y1p+3YAKdP5QXuJZB9lHxPVB9qFC9Z+miPf3X
        wTAaBRCzOO3DmjsDa19fSUlGHQ==
X-Google-Smtp-Source: AGHT+IFYwkUlZO9Um/1JZYOKR+I/W6wYbdoWHN4/eWoT5eNGGZUVMxGdSjF+fhcJMFLWF6MZ7xLXOg==
X-Received: by 2002:a05:6808:1144:b0:3ae:1675:700e with SMTP id u4-20020a056808114400b003ae1675700emr1892632oiu.36.1700624490176;
        Tue, 21 Nov 2023 19:41:30 -0800 (PST)
Received: from ghost ([65.158.198.2])
        by smtp.gmail.com with ESMTPSA id c19-20020a056808139300b003b83ec68a3dsm66571oiw.4.2023.11.21.19.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 19:41:29 -0800 (PST)
Date:   Tue, 21 Nov 2023 22:41:26 -0500
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Ron Economos <re@w6rz.net>
Subject: Re: [PATCH v2] riscv: Safely remove entries from relocation list
Message-ID: <ZV14ZrI8pqe9kTH1@ghost>
References: <20231121-module_linking_freeing-v2-1-974bfcd3664e@rivosinc.com>
 <43359fc7-957a-4f48-a1d4-fffee238463a@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43359fc7-957a-4f48-a1d4-fffee238463a@sifive.com>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 06:04:14PM -0600, Samuel Holland wrote:
> Hi Charlie,
> 
> On 2023-11-21 4:50 PM, Charlie Jenkins wrote:
> > Use the safe versions of list and hlist iteration to safely remove
> > entries from the module relocation lists. To allow mutliple threads to
> > load modules concurrently, move relocation list pointers onto the stack
> > rather than using global variables.
> > 
> > Fixes: 8fd6c5142395 ("riscv: Add remaining module relocations")
> > Reported-by: Ron Economos <re@w6rz.net>
> > Closes: https://lore.kernel.org/linux-riscv/444de86a-7e7c-4de7-5d1d-c1c40eefa4ba@w6rz.net
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> > Changes in v2:
> > - Support linking modules concurrently across threads.
> > - Link to v1: https://lore.kernel.org/r/20231120-module_linking_freeing-v1-1-fff81d7289fc@rivosinc.com
> > ---
> >  arch/riscv/kernel/module.c | 76 +++++++++++++++++++++++++++++++---------------
> >  1 file changed, 51 insertions(+), 25 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> > index 56a8c78e9e21..f53e82b70dff 100644
> > --- a/arch/riscv/kernel/module.c
> > +++ b/arch/riscv/kernel/module.c
> > @@ -40,14 +40,17 @@ struct relocation_handlers {
> >  				  long buffer);
> >  };
> >  
> > -unsigned int initialize_relocation_hashtable(unsigned int num_relocations);
> > -void process_accumulated_relocations(struct module *me);
> > +unsigned int
> > +initialize_relocation_hashtable(unsigned int num_relocations,
> > +				struct hlist_head **relocation_hashtable,
> > +				struct list_head *used_buckets_list);
> > +void process_accumulated_relocations(struct module *me,
> > +				     struct hlist_head **relocation_hashtable,
> > +				     struct list_head *used_buckets_list);
> >  int add_relocation_to_accumulate(struct module *me, int type, void *location,
> > -				 unsigned int hashtable_bits, Elf_Addr v);
> > -
> > -struct hlist_head *relocation_hashtable;
> > -
> > -struct list_head used_buckets_list;
> 
> This hunk conflicts with your other patch, which is still needed for the __le16
> change. Since they are both fixes, do you intend to rebase and send them together?

I wasn't sure the best way of doing that. I will bring the __le16 changes into this series.

> 
> > +				 unsigned int hashtable_bits, Elf_Addr v,
> > +				struct hlist_head **relocation_hashtable,
> > +				struct list_head *used_buckets_list);
> 
> minor: the indentation is off by one here.
> 
> >  
> >  /*
> >   * The auipc+jalr instruction pair can reach any PC-relative offset
> > @@ -604,7 +607,9 @@ static const struct relocation_handlers reloc_handlers[] = {
> >  	/* 192-255 nonstandard ABI extensions  */
> >  };
> >  
> > -void process_accumulated_relocations(struct module *me)
> > +void process_accumulated_relocations(struct module *me,
> > +				     struct hlist_head **relocation_hashtable,
> 
> You only need the double pointer in initialize_relocation_hashtable(). If you
> pass the single pointer here and in add_relocation_to_accumulate(), you can
> avoid the extra dereference operations.
> 
> > +				     struct list_head *used_buckets_list)
> >  {
> >  	/*
> >  	 * Only ADD/SUB/SET/ULEB128 should end up here.
> > @@ -624,18 +629,25 @@ void process_accumulated_relocations(struct module *me)
> >  	 *	- Each relocation entry for a location address
> >  	 */
> >  	struct used_bucket *bucket_iter;
> > +	struct used_bucket *bucket_iter_tmp;
> >  	struct relocation_head *rel_head_iter;
> > +	struct hlist_node *rel_head_iter_tmp;
> >  	struct relocation_entry *rel_entry_iter;
> > +	struct relocation_entry *rel_entry_iter_tmp;
> >  	int curr_type;
> >  	void *location;
> >  	long buffer;
> >  
> > -	list_for_each_entry(bucket_iter, &used_buckets_list, head) {
> > -		hlist_for_each_entry(rel_head_iter, bucket_iter->bucket, node) {
> > +	list_for_each_entry_safe(bucket_iter, bucket_iter_tmp,
> > +				 used_buckets_list, head) {
> > +		hlist_for_each_entry_safe(rel_head_iter, rel_head_iter_tmp,
> > +					  bucket_iter->bucket, node) {
> >  			buffer = 0;
> >  			location = rel_head_iter->location;
> > -			list_for_each_entry(rel_entry_iter,
> > -					    rel_head_iter->rel_entry, head) {
> > +			list_for_each_entry_safe(rel_entry_iter,
> > +						 rel_entry_iter_tmp,
> > +						 rel_head_iter->rel_entry,
> > +						 head) {
> >  				curr_type = rel_entry_iter->type;
> >  				reloc_handlers[curr_type].reloc_handler(
> >  					me, &buffer, rel_entry_iter->value);
> > @@ -648,11 +660,13 @@ void process_accumulated_relocations(struct module *me)
> >  		kfree(bucket_iter);
> >  	}
> >  
> > -	kfree(relocation_hashtable);
> > +	kfree(*relocation_hashtable);
> >  }
> >  
> >  int add_relocation_to_accumulate(struct module *me, int type, void *location,
> > -				 unsigned int hashtable_bits, Elf_Addr v)
> > +				 unsigned int hashtable_bits, Elf_Addr v,
> > +				struct hlist_head **relocation_hashtable,
> > +				struct list_head *used_buckets_list)
> >  {
> >  	struct relocation_entry *entry;
> >  	struct relocation_head *rel_head;
> > @@ -667,7 +681,7 @@ int add_relocation_to_accumulate(struct module *me, int type, void *location,
> >  
> >  	hash = hash_min((uintptr_t)location, hashtable_bits);
> >  
> > -	current_head = &relocation_hashtable[hash];
> > +	current_head = &((*relocation_hashtable)[hash]);
> >  
> >  	/* Find matching location (if any) */
> >  	bool found = false;
> > @@ -693,7 +707,7 @@ int add_relocation_to_accumulate(struct module *me, int type, void *location,
> >  				kmalloc(sizeof(struct used_bucket), GFP_KERNEL);
> >  			INIT_LIST_HEAD(&bucket->head);
> >  			bucket->bucket = current_head;
> > -			list_add(&bucket->head, &used_buckets_list);
> > +			list_add(&bucket->head, used_buckets_list);
> >  		}
> >  		hlist_add_head(&rel_head->node, current_head);
> >  	}
> > @@ -704,7 +718,10 @@ int add_relocation_to_accumulate(struct module *me, int type, void *location,
> >  	return 0;
> >  }
> >  
> > -unsigned int initialize_relocation_hashtable(unsigned int num_relocations)
> > +unsigned int
> > +initialize_relocation_hashtable(unsigned int num_relocations,
> > +				struct hlist_head **relocation_hashtable,
> > +				struct list_head *used_buckets_list)
> >  {
> >  	/* Can safely assume that bits is not greater than sizeof(long) */
> >  	unsigned long hashtable_size = roundup_pow_of_two(num_relocations);
> > @@ -720,12 +737,12 @@ unsigned int initialize_relocation_hashtable(unsigned int num_relocations)
> >  
> >  	hashtable_size <<= should_double_size;
> >  
> > -	relocation_hashtable = kmalloc_array(hashtable_size,
> > -					     sizeof(*relocation_hashtable),
> > -					     GFP_KERNEL);
> > -	__hash_init(relocation_hashtable, hashtable_size);
> > +	*relocation_hashtable = kmalloc_array(hashtable_size,
> > +					      sizeof(*relocation_hashtable),
> > +					      GFP_KERNEL);
> 
> You need to check for allocation failure here and inside
> add_relocation_to_accumulate(). Module loading under memory pressure is a
> reasonably likely scenario.
> 
> > +	__hash_init(*relocation_hashtable, hashtable_size);
> >  
> > -	INIT_LIST_HEAD(&used_buckets_list);
> > +	INIT_LIST_HEAD(used_buckets_list);
> 
> This is the only place used_buckets_list is used in this function. If you move
> this line out to apply_relocate_add, you can drop the parameter.
> 
> Regards,
> Samuel
>

Thanks for the suggestions, I will send out another version.

- Charlie

> >  
> >  	return hashtable_bits;
> >  }
> > @@ -742,7 +759,13 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> >  	Elf_Addr v;
> >  	int res;
> >  	unsigned int num_relocations = sechdrs[relsec].sh_size / sizeof(*rel);
> > -	unsigned int hashtable_bits = initialize_relocation_hashtable(num_relocations);
> > +	struct hlist_head *relocation_hashtable;
> > +	struct list_head used_buckets_list;
> > +	unsigned int hashtable_bits;
> > +
> > +	hashtable_bits = initialize_relocation_hashtable(num_relocations,
> > +							 &relocation_hashtable,
> > +							 &used_buckets_list);
> >  
> >  	pr_debug("Applying relocate section %u to %u\n", relsec,
> >  	       sechdrs[relsec].sh_info);
> > @@ -823,14 +846,17 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> >  		}
> >  
> >  		if (reloc_handlers[type].accumulate_handler)
> > -			res = add_relocation_to_accumulate(me, type, location, hashtable_bits, v);
> > +			res = add_relocation_to_accumulate(
> > +				me, type, location, hashtable_bits, v,
> > +				&relocation_hashtable, &used_buckets_list);
> >  		else
> >  			res = handler(me, location, v);
> >  		if (res)
> >  			return res;
> >  	}
> >  
> > -	process_accumulated_relocations(me);
> > +	process_accumulated_relocations(me, &relocation_hashtable,
> > +					&used_buckets_list);
> >  
> >  	return 0;
> >  }
> > 
> > ---
> > base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
> > change-id: 20231120-module_linking_freeing-2b5a3b255b5e
> 
