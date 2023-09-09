Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773657997EB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 14:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238953AbjIIM3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 08:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjIIM3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 08:29:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FEBCDE
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 05:29:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D443C433C8;
        Sat,  9 Sep 2023 12:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694262578;
        bh=6n2dguQyPx59p7gyENxjNSLX5UTEUJlI6VNrTblnGaI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QAWhdtB1wj6ID1ku8rhtxsJdEnV+pTqfxI6nC3GRMV1EOCjdy4UGuATuJ9N3WpYN8
         ZUBt9WJ9OdjtO+pFwkRc+JLLLCweEg8Rs7D9obBOW2GuKF3lH3x9PRvWffGQeCEzgk
         SXipE1raL+OGHGJzqiuKhaCtMJHjVKMW0+NJv7UxtvyoN1P8l03YnRQ3hJsA9PrSvO
         7+tDuyG6yGnEpvQ5rU9xLzsNiIzePjM1TYOd9YP9lwL1ryzlVZYsefBYGUF27GTrlA
         z+RfPCMLUHd7ZUPuJ1D345VUDWEUPJzA/x5tp9wFM7jq/25x+QmNJyi1dIliJ6HCxL
         /UPiqU5jSyV6Q==
Date:   Sat, 9 Sep 2023 21:29:33 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Donglin Peng <pengdonglin@sangfor.com.cn>
Cc:     martin.lau@linux.dev, ast@kernel.org, song@kernel.org, yhs@fb.com,
        rostedt@goodmis.org, mhiramat@kernel.org, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
Message-Id: <20230909212933.1552f2842b06e50525a4daef@kernel.org>
In-Reply-To: <20230909091646.420163-1-pengdonglin@sangfor.com.cn>
References: <20230909091646.420163-1-pengdonglin@sangfor.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Sep 2023 02:16:46 -0700
Donglin Peng <pengdonglin@sangfor.com.cn> wrote:

> Currently, we are only using the linear search method to find the type id
> by the name, which has a time complexity of O(n). This change involves
> sorting the names of btf types in ascending order and using binary search,
> which has a time complexity of O(log(n)). This idea was inspired by the
> following patch:
> 
> 60443c88f3a8 ("kallsyms: Improve the performance of kallsyms_lookup_name()").
> 
> At present, this improvement is only for searching in vmlinux's and
> module's BTFs, and the kind should only be BTF_KIND_FUNC or BTF_KIND_STRUCT.
> 
> Another change is the search direction, where we search the BTF first and
> then its base, the type id of the first matched btf_type will be returned.
> 
> Here is a time-consuming result that finding all the type ids of 67,819 kernel
> functions in vmlinux's BTF by their names:
> 
> Before: 17000 ms
> After:     10 ms

Nice work!

> 
> The average lookup performance has improved about 1700x at the above scenario.
> 
> However, this change will consume more memory, for example, 67,819 kernel
> functions will allocate about 530KB memory.

I'm not so familier with how the BTF is generated, what about making this
list offline? Since BTF is static data, it is better to make the map when
it is built. And I also would like to suggest to make a new map to make 
another new map which maps the BTF ID and the address of the function, so
that we can do binary search the BTF object from the function address.
(The latter map should be built when CONFIG_BTF_ADDR_MAP=y)

Thank you,

> 
> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
> ---
> Changes in RFC v2:
>  - Fix the build issue reported by kernel test robot <lkp@intel.com>
> ---
>  include/linux/btf.h |   1 +
>  kernel/bpf/btf.c    | 300 ++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 291 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index cac9f304e27a..6260a0668773 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -201,6 +201,7 @@ bool btf_is_kernel(const struct btf *btf);
>  bool btf_is_module(const struct btf *btf);
>  struct module *btf_try_get_module(const struct btf *btf);
>  u32 btf_nr_types(const struct btf *btf);
> +u32 btf_type_cnt(const struct btf *btf);
>  bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
>  			   const struct btf_member *m,
>  			   u32 expected_offset, u32 expected_size);
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 817204d53372..51aa9f27853b 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -240,6 +240,26 @@ struct btf_id_dtor_kfunc_tab {
>  	struct btf_id_dtor_kfunc dtors[];
>  };
>  
> +enum {
> +	BTF_ID_NAME_FUNC,	/* function */
> +	BTF_ID_NAME_STRUCT,	/* struct */
> +	BTF_ID_NAME_MAX
> +};
> +
> +struct btf_id_name {
> +	int id;
> +	u32 name_off;
> +};
> +
> +struct btf_id_name_map {
> +	struct btf_id_name *id_name;
> +	u32 count;
> +};
> +
> +struct btf_id_name_maps {
> +	struct btf_id_name_map map[BTF_ID_NAME_MAX];
> +};
> +
>  struct btf {
>  	void *data;
>  	struct btf_type **types;
> @@ -257,6 +277,7 @@ struct btf {
>  	struct btf_kfunc_set_tab *kfunc_set_tab;
>  	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
>  	struct btf_struct_metas *struct_meta_tab;
> +	struct btf_id_name_maps *id_name_maps;
>  
>  	/* split BTF support */
>  	struct btf *base_btf;
> @@ -532,22 +553,142 @@ u32 btf_nr_types(const struct btf *btf)
>  	return total;
>  }
>  
> +u32 btf_type_cnt(const struct btf *btf)
> +{
> +	return btf->start_id + btf->nr_types;
> +}
> +
> +static inline u8 btf_id_name_idx_to_kind(int index)
> +{
> +	u8 kind;
> +
> +	switch (index) {
> +	case BTF_ID_NAME_FUNC:
> +		kind = BTF_KIND_FUNC;
> +		break;
> +	case BTF_ID_NAME_STRUCT:
> +		kind = BTF_KIND_STRUCT;
> +		break;
> +	default:
> +		kind = BTF_KIND_UNKN;
> +		break;
> +	}
> +
> +	return kind;
> +}
> +
> +static inline int btf_id_name_kind_to_idx(u8 kind)
> +{
> +	int index;
> +
> +	switch (kind) {
> +	case BTF_KIND_FUNC:
> +		index = BTF_ID_NAME_FUNC;
> +		break;
> +	case BTF_KIND_STRUCT:
> +		index = BTF_ID_NAME_STRUCT;
> +		break;
> +	default:
> +		index = -1;
> +		break;
> +	}
> +
> +	return index;
> +}
> +
> +static s32 btf_find_by_name_bsearch(struct btf_id_name *id_name,
> +				    u32 size, const char *name,
> +				    struct btf_id_name **start,
> +				    struct btf_id_name **end,
> +				    const struct btf *btf)
> +{
> +	int ret;
> +	int low, mid, high;
> +	const char *name_buf;
> +
> +	low = 0;
> +	high = size - 1;
> +
> +	while (low <= high) {
> +		mid = low + (high - low) / 2;
> +		name_buf = btf_name_by_offset(btf, id_name[mid].name_off);
> +		ret = strcmp(name, name_buf);
> +		if (ret > 0)
> +			low = mid + 1;
> +		else if (ret < 0)
> +			high = mid - 1;
> +		else
> +			break;
> +	}
> +
> +	if (low > high)
> +		return -ESRCH;
> +
> +	if (start) {
> +		low = mid;
> +		while (low) {
> +			name_buf = btf_name_by_offset(btf, id_name[low-1].name_off);
> +			if (strcmp(name, name_buf))
> +				break;
> +			low--;
> +		}
> +		*start = &id_name[low];
> +	}
> +
> +	if (end) {
> +		high = mid;
> +		while (high < size - 1) {
> +			name_buf = btf_name_by_offset(btf, id_name[high+1].name_off);
> +			if (strcmp(name, name_buf))
> +				break;
> +			high++;
> +		}
> +		*end = &id_name[high];
> +	}
> +
> +	return id_name[mid].id;
> +}
> +
>  s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
>  {
> +	const struct btf_id_name_maps *maps;
> +	const struct btf_id_name_map *map;
> +	struct btf_id_name *start;
>  	const struct btf_type *t;
>  	const char *tname;
> -	u32 i, total;
> +	int index = btf_id_name_kind_to_idx(kind);
> +	s32 id, total;
>  
> -	total = btf_nr_types(btf);
> -	for (i = 1; i < total; i++) {
> -		t = btf_type_by_id(btf, i);
> -		if (BTF_INFO_KIND(t->info) != kind)
> -			continue;
> +	do {
> +		maps = btf->id_name_maps;
> +		if (index >= 0 && maps && maps->map[index].id_name) {
> +			/* binary search */
> +			map = &maps->map[index];
> +			id = btf_find_by_name_bsearch(map->id_name,
> +				map->count, name, &start, NULL, btf);
> +			if (id > 0) {
> +				/*
> +				 * Return the first one that
> +				 * matched
> +				 */
> +				return start->id;
> +			}
> +		} else {
> +			/* linear search */
> +			total = btf_type_cnt(btf);
> +			for (id = btf->start_id; id < total; id++) {
> +				t = btf_type_by_id(btf, id);
> +				if (BTF_INFO_KIND(t->info) != kind)
> +					continue;
> +
> +				tname = btf_name_by_offset(btf, t->name_off);
> +				if (!strcmp(tname, name))
> +					return id;
> +			}
> +		}
>  
> -		tname = btf_name_by_offset(btf, t->name_off);
> -		if (!strcmp(tname, name))
> -			return i;
> -	}
> +		btf = btf->base_btf;
> +	} while (btf);
>  
>  	return -ENOENT;
>  }
> @@ -1639,6 +1780,32 @@ static void btf_free_id(struct btf *btf)
>  	spin_unlock_irqrestore(&btf_idr_lock, flags);
>  }
>  
> +static void btf_destroy_id_name(struct btf *btf, int index)
> +{
> +	struct btf_id_name_maps *maps = btf->id_name_maps;
> +	struct btf_id_name_map *map = &maps->map[index];
> +
> +	if (map->id_name) {
> +		kvfree(map->id_name);
> +		map->id_name = NULL;
> +		map->count = 0;
> +	}
> +}
> +
> +static void btf_destroy_id_name_map(struct btf *btf)
> +{
> +	int i;
> +
> +	if (!btf->id_name_maps)
> +		return;
> +
> +	for (i = 0; i < BTF_ID_NAME_MAX; i++)
> +		btf_destroy_id_name(btf, i);
> +
> +	kfree(btf->id_name_maps);
> +	btf->id_name_maps = NULL;
> +}
> +
>  static void btf_free_kfunc_set_tab(struct btf *btf)
>  {
>  	struct btf_kfunc_set_tab *tab = btf->kfunc_set_tab;
> @@ -1689,6 +1856,7 @@ static void btf_free_struct_meta_tab(struct btf *btf)
>  
>  static void btf_free(struct btf *btf)
>  {
> +	btf_destroy_id_name_map(btf);
>  	btf_free_struct_meta_tab(btf);
>  	btf_free_dtor_kfunc_tab(btf);
>  	btf_free_kfunc_set_tab(btf);
> @@ -5713,6 +5881,107 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
>  	return kctx_type_id;
>  }
>  
> +static int btf_compare_id_name(const void *a, const void *b, const void *priv)
> +{
> +	const struct btf_id_name *ia = (const struct btf_id_name *)a;
> +	const struct btf_id_name *ib = (const struct btf_id_name *)b;
> +	const struct btf *btf = priv;
> +	int ret;
> +
> +	/*
> +	 * Sort names in ascending order, if the name is same, sort ids in
> +	 * ascending order.
> +	 */
> +	ret = strcmp(btf_name_by_offset(btf, ia->name_off),
> +		     btf_name_by_offset(btf, ib->name_off));
> +	if (!ret)
> +		ret = ia->id - ib->id;
> +
> +	return ret;
> +}
> +
> +static int btf_create_id_name(struct btf *btf, int index)
> +{
> +	struct btf_id_name_maps *maps = btf->id_name_maps;
> +	struct btf_id_name_map *map = &maps->map[index];
> +	const struct btf_type *t;
> +	struct btf_id_name *id_name;
> +	const char *name;
> +	int i, j = 0;
> +	u32 total, count = 0;
> +	u8 kind;
> +
> +	kind = btf_id_name_idx_to_kind(index);
> +	if (kind == BTF_KIND_UNKN)
> +		return -EINVAL;
> +
> +	if (map->id_name || map->count != 0)
> +		return -EINVAL;
> +
> +	total = btf_type_cnt(btf);
> +	for (i = btf->start_id; i < total; i++) {
> +		t = btf_type_by_id(btf, i);
> +		if (BTF_INFO_KIND(t->info) != kind)
> +			continue;
> +		name = btf_name_by_offset(btf, t->name_off);
> +		if (str_is_empty(name))
> +			continue;
> +		count++;
> +	}
> +
> +	if (count == 0)
> +		return 0;
> +
> +	id_name = kvcalloc(count, sizeof(struct btf_id_name),
> +			   GFP_KERNEL);
> +	if (!id_name)
> +		return -ENOMEM;
> +
> +	for (i = btf->start_id; i < total; i++) {
> +		t = btf_type_by_id(btf, i);
> +		if (BTF_INFO_KIND(t->info) != kind)
> +			continue;
> +		name = btf_name_by_offset(btf, t->name_off);
> +		if (str_is_empty(name))
> +			continue;
> +
> +		id_name[j].id = i;
> +		id_name[j].name_off = t->name_off;
> +		j++;
> +	}
> +
> +	sort_r(id_name, count, sizeof(id_name[0]), btf_compare_id_name,
> +	       NULL, btf);
> +
> +	map->id_name = id_name;
> +	map->count = count;
> +
> +	return 0;
> +}
> +
> +static int btf_create_id_name_map(struct btf *btf)
> +{
> +	int err, i;
> +	struct btf_id_name_maps *maps;
> +
> +	if (btf->id_name_maps)
> +		return -EBUSY;
> +
> +	maps = kzalloc(sizeof(struct btf_id_name_maps), GFP_KERNEL);
> +	if (!maps)
> +		return -ENOMEM;
> +
> +	btf->id_name_maps = maps;
> +
> +	for (i = 0; i < BTF_ID_NAME_MAX; i++) {
> +		err = btf_create_id_name(btf, i);
> +		if (err < 0)
> +			break;
> +	}
> +
> +	return err;
> +}
> +
>  BTF_ID_LIST(bpf_ctx_convert_btf_id)
>  BTF_ID(struct, bpf_ctx_convert)
>  
> @@ -5760,6 +6029,10 @@ struct btf *btf_parse_vmlinux(void)
>  	if (err)
>  		goto errout;
>  
> +	err = btf_create_id_name_map(btf);
> +	if (err)
> +		goto errout;
> +
>  	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
>  	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
>  
> @@ -5777,6 +6050,7 @@ struct btf *btf_parse_vmlinux(void)
>  errout:
>  	btf_verifier_env_free(env);
>  	if (btf) {
> +		btf_destroy_id_name_map(btf);
>  		kvfree(btf->types);
>  		kfree(btf);
>  	}
> @@ -5844,13 +6118,19 @@ static struct btf *btf_parse_module(const char *module_name, const void *data, u
>  	if (err)
>  		goto errout;
>  
> +	err = btf_create_id_name_map(btf);
> +	if (err)
> +		goto errout;
> +
>  	btf_verifier_env_free(env);
>  	refcount_set(&btf->refcnt, 1);
> +
>  	return btf;
>  
>  errout:
>  	btf_verifier_env_free(env);
>  	if (btf) {
> +		btf_destroy_id_name_map(btf);
>  		kvfree(btf->data);
>  		kvfree(btf->types);
>  		kfree(btf);
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
