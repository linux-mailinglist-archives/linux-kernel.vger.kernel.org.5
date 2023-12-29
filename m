Return-Path: <linux-kernel+bounces-13158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 476B182007D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91552B21CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A9F125D1;
	Fri, 29 Dec 2023 16:17:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3868125BD;
	Fri, 29 Dec 2023 16:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC999C433C9;
	Fri, 29 Dec 2023 16:17:55 +0000 (UTC)
Date: Fri, 29 Dec 2023 11:18:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix possible memory leak in
 ftrace_regsiter_direct()
Message-ID: <20231229111846.36d09812@gandalf.local.home>
In-Reply-To: <170368070504.42064.8960569647118388081.stgit@devnote2>
References: <170368070504.42064.8960569647118388081.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Dec 2023 21:38:25 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> If ftrace_register_direct() called with a large number of target

There's no function called "ftrace_register_direct()", I guess you meant
register_ftrace_direct()?

> functions (e.g. 65), the free_hash can be updated twice or more
> in the ftrace_add_rec_direct() without freeing the previous hash
> memory. Thus this can cause a memory leak.
> 
> Fix this issue by expanding the direct_hash at once before
> adding the new entries.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Fixes: f64dd4627ec6 ("ftrace: Add multi direct register/unregister interface")
> Cc: stable@vger.kernel.org
> ---
>  kernel/trace/ftrace.c |   49 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 8de8bec5f366..9269c2c3e595 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2555,28 +2555,33 @@ unsigned long ftrace_find_rec_direct(unsigned long ip)
>  	return entry->direct;
>  }
>  
> -static struct ftrace_func_entry*
> -ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
> -		      struct ftrace_hash **free_hash)
> +static struct ftrace_hash *ftrace_expand_direct(int inc_count)
>  {
> -	struct ftrace_func_entry *entry;
> +	struct ftrace_hash *new_hash, *free_hash;
> +	int size = ftrace_hash_empty(direct_functions) ? 0 :
> +		direct_functions->count + inc_count;
>  
> -	if (ftrace_hash_empty(direct_functions) ||
> -	    direct_functions->count > 2 * (1 << direct_functions->size_bits)) {
> -		struct ftrace_hash *new_hash;
> -		int size = ftrace_hash_empty(direct_functions) ? 0 :
> -			direct_functions->count + 1;
> +	if (!ftrace_hash_empty(direct_functions) &&
> +	    size <= 2 * (1 << direct_functions->size_bits))
> +		return NULL;
>  
> -		if (size < 32)
> -			size = 32;
> +	if (size < 32)
> +		size = 32;

Hmm, why the limit of 32? I know this was there before this patch, but this
patch made me notice it.

In dup_hash() we have:

	bits = fls(size / 2);

	/* Don't allocate too much */
	if (bits > FTRACE_HASH_MAX_BITS)
		bits = FTRACE_HASH_MAX_BITS;

Where bits will determine the number of buckets.

If size = 32, then bits = fls(32/2) = fls(16) = 5

So the buckets will be 2^5 = 32. Thus, you will get 32 buckets even with 64
entries, which will cause a minimum of two loops to find a bucket.

Is this a concern?


>  
> -		new_hash = dup_hash(direct_functions, size);
> -		if (!new_hash)
> -			return NULL;
> +	new_hash = dup_hash(direct_functions, size);
> +	if (!new_hash)
> +		return ERR_PTR(-ENOMEM);
>  
> -		*free_hash = direct_functions;
> -		direct_functions = new_hash;
> -	}
> +	free_hash = direct_functions;
> +	direct_functions = new_hash;
> +
> +	return free_hash;
> +}
> +
> +static struct ftrace_func_entry*
> +ftrace_add_rec_direct(unsigned long ip, unsigned long addr)
> +{
> +	struct ftrace_func_entry *entry;
>  
>  	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
>  	if (!entry)
> @@ -5436,11 +5441,19 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  		}
>  	}
>  
> +	/* ... and prepare the insertion */
> +	free_hash = ftrace_expand_direct(hash->count);

Why does the direct_functions need to be expanded before new items are
entered? Can't we do it the way ftrace does it, and that is just to fill
the hash, and then expand if necessary.

Hmm, also, I think there's a bug here too. That is, hash_dup() does not do
what it says. It doesn't copy it actually moves. So when you use hash_dup()
with the source being direct_functions, it's removing the entries from the
direct functions, and not copying them :-/

That is, during the resize, the check against direct_functions will not
find them and things will be missed!

What I think we need to do, is what ftrace does, and that is to add
everything to a temp hash first and then do an RCU assign to the
direct_functions.

> +	if (IS_ERR(free_hash)) {
> +		err = PTR_ERR(free_hash);
> +		free_hash = NULL;
> +		goto out_unlock;
> +	}
> +
>  	/* ... and insert them to direct_functions hash. */
>  	err = -ENOMEM;
>  	for (i = 0; i < size; i++) {
>  		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> -			new = ftrace_add_rec_direct(entry->ip, addr, &free_hash);
> +			new = ftrace_add_rec_direct(entry->ip, addr);
>  			if (!new)
>  				goto out_remove;
>  			entry->direct = addr;

This should fix both the leak and the fact that direct_functions are being
modified while in use.

Also, by reusing add_hash_entry() and removing ftrace_add_rec_direct(),
this simplifies the code. The biggest change is changing add_hash_entry()
to return the entry and not an int, which required updates to its other
users.

-- Steve

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8de8bec5f366..78ad2c4210cf 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1183,18 +1183,19 @@ static void __add_hash_entry(struct ftrace_hash *hash,
 	hash->count++;
 }
 
-static int add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
+static struct ftrace_func_entry *
+add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
 {
 	struct ftrace_func_entry *entry;
 
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
-		return -ENOMEM;
+		return NULL;
 
 	entry->ip = ip;
 	__add_hash_entry(hash, entry);
 
-	return 0;
+	return entry;
 }
 
 static void
@@ -1349,7 +1350,6 @@ alloc_and_copy_ftrace_hash(int size_bits, struct ftrace_hash *hash)
 	struct ftrace_func_entry *entry;
 	struct ftrace_hash *new_hash;
 	int size;
-	int ret;
 	int i;
 
 	new_hash = alloc_ftrace_hash(size_bits);
@@ -1366,8 +1366,7 @@ alloc_and_copy_ftrace_hash(int size_bits, struct ftrace_hash *hash)
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			ret = add_hash_entry(new_hash, entry->ip);
-			if (ret < 0)
+			if (add_hash_entry(new_hash, entry->ip) == NULL)
 				goto free_hash;
 		}
 	}
@@ -2536,7 +2535,7 @@ ftrace_find_unique_ops(struct dyn_ftrace *rec)
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 /* Protected by rcu_tasks for reading, and direct_mutex for writing */
-static struct ftrace_hash *direct_functions = EMPTY_HASH;
+static struct ftrace_hash __rcu *direct_functions = EMPTY_HASH;
 static DEFINE_MUTEX(direct_mutex);
 int ftrace_direct_func_count;
 
@@ -2555,39 +2554,6 @@ unsigned long ftrace_find_rec_direct(unsigned long ip)
 	return entry->direct;
 }
 
-static struct ftrace_func_entry*
-ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
-		      struct ftrace_hash **free_hash)
-{
-	struct ftrace_func_entry *entry;
-
-	if (ftrace_hash_empty(direct_functions) ||
-	    direct_functions->count > 2 * (1 << direct_functions->size_bits)) {
-		struct ftrace_hash *new_hash;
-		int size = ftrace_hash_empty(direct_functions) ? 0 :
-			direct_functions->count + 1;
-
-		if (size < 32)
-			size = 32;
-
-		new_hash = dup_hash(direct_functions, size);
-		if (!new_hash)
-			return NULL;
-
-		*free_hash = direct_functions;
-		direct_functions = new_hash;
-	}
-
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return NULL;
-
-	entry->ip = ip;
-	entry->direct = addr;
-	__add_hash_entry(direct_functions, entry);
-	return entry;
-}
-
 static void call_direct_funcs(unsigned long ip, unsigned long pip,
 			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
@@ -4223,8 +4189,8 @@ enter_record(struct ftrace_hash *hash, struct dyn_ftrace *rec, int clear_filter)
 		/* Do nothing if it exists */
 		if (entry)
 			return 0;
-
-		ret = add_hash_entry(hash, rec->ip);
+		if (add_hash_entry(hash, rec->ip) == NULL)
+			ret = -ENOMEM;
 	}
 	return ret;
 }
@@ -5266,7 +5232,8 @@ __ftrace_match_addr(struct ftrace_hash *hash, unsigned long ip, int remove)
 		return 0;
 	}
 
-	return add_hash_entry(hash, ip);
+	entry = add_hash_entry(hash, ip);
+	return entry ? 0 :  -ENOMEM;
 }
 
 static int
@@ -5410,7 +5377,7 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
  */
 int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 {
-	struct ftrace_hash *hash, *free_hash = NULL;
+	struct ftrace_hash *hash, *new_hash = NULL, *free_hash = NULL;
 	struct ftrace_func_entry *entry, *new;
 	int err = -EBUSY, size, i;
 
@@ -5436,17 +5403,44 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 		}
 	}
 
-	/* ... and insert them to direct_functions hash. */
 	err = -ENOMEM;
+
+	/* Make a copy hash to place the new and the old entries in */
+	size += (1 << direct_functions->size_bits);
+	if (size > 32)
+		size = 32;
+	new_hash = alloc_ftrace_hash(fls(size));
+	if (!new_hash)
+		goto out_unlock;
+
+	/* Now copy over the existing direct entries */
+	size = 1 << direct_functions->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &direct_functions->buckets[i], hlist) {
+			new = add_hash_entry(new_hash, entry->ip);
+			if (!new)
+				goto out_unlock;
+			new->direct = entry->direct;
+		}
+	}
+
+	/* ... and add the new entries */
+	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			new = ftrace_add_rec_direct(entry->ip, addr, &free_hash);
+			new = add_hash_entry(new_hash, entry->ip);
 			if (!new)
-				goto out_remove;
+				goto out_unlock;
+			/* Update both the copy and the hash entry */
+			new->direct = addr;
 			entry->direct = addr;
 		}
 	}
 
+	free_hash = direct_functions;
+	rcu_assign_pointer(direct_functions, new_hash);
+	new_hash = NULL;
+
 	ops->func = call_direct_funcs;
 	ops->flags = MULTI_FLAGS;
 	ops->trampoline = FTRACE_REGS_ADDR;
@@ -5454,17 +5448,17 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 
 	err = register_ftrace_function_nolock(ops);
 
- out_remove:
-	if (err)
-		remove_direct_functions_hash(hash, addr);
-
  out_unlock:
 	mutex_unlock(&direct_mutex);
 
-	if (free_hash) {
+	if (free_hash && free_hash != EMPTY_HASH) {
 		synchronize_rcu_tasks();
 		free_ftrace_hash(free_hash);
 	}
+
+	if (new_hash)
+		free_ftrace_hash(new_hash);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(register_ftrace_direct);
@@ -6309,7 +6303,7 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 
 				if (entry)
 					continue;
-				if (add_hash_entry(hash, rec->ip) < 0)
+				if (add_hash_entry(hash, rec->ip) == NULL)
 					goto out;
 			} else {
 				if (entry) {

