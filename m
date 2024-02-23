Return-Path: <linux-kernel+bounces-77806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7426860A6E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACE91C22763
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F1E125A8;
	Fri, 23 Feb 2024 05:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x4rtgI3J"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925E12E54;
	Fri, 23 Feb 2024 05:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708667330; cv=none; b=AZokj92gg5JojHglhL/fFMSAPE+irt57e3dGIwYEqmIfLtQC22vD7CYRNBgaXzrysW1PagAleNeERbfEh5uCrBCPZcL6YhnPgCgbLAuHkbZDM/xoGXWlfPxptPsb79ebcgIHlIBzOCFM1CG0zU1DHfQhDbI/TZFq4PlulMNgIz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708667330; c=relaxed/simple;
	bh=3jvOJOenS8bIo5BODWqJCjPiewSig3n7C6kQdiu9Jxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JsRdQxAGswSG9jrD91/FgfqRXj7xZeWO5sCjX+otnYmCK7vJTb4yZE5GgjSv7ARTW5mX1AHr8cG78QMyBLJowp5sz13ocaEAaep+DBYxIQ707h4XJKMPLqeNslpjwJlsqidgZy8pYLr5F7z4kMGwvQZ0BelizW87XAEH5c98600=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=x4rtgI3J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jtMuWL2AutS3bf5fk3428X4Oh0qT8cBUDmPD7nVQRg8=; b=x4rtgI3JpUQO1Xa1AjZ9IotpEM
	eu55H7uAX+KYz7aoSHzz5YKb9olX+WDB5I6ghIpezPHv/yu0k/68bXt1wGdyVBrn7ZHcj4itWTdOm
	T8IGGq2CXCZJtz9RwSmcKWC3hpsLLDWjRvaj+GhHxGIcP8ytE8VslbCz1aawGjhC1107R1aQFAYFt
	dOACfG67ejsLzzgAqKThya5bFMLfOO0dqNCOvlN75YWUsY338q2lr8JQHiNNhI8sRUNfIgwnH4jG7
	EBrXDsEXdTzusBgTAJZtUFV9l+gQ4E2t45vEn+kDqgZ76QnO8iGBiR6opixV2rqIX96iF3Ftwfy95
	wNt5JrBQ==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdOQE-000000083hF-26K7;
	Fri, 23 Feb 2024 05:48:41 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ftrace: fix most kernel-doc warnings
Date: Thu, 22 Feb 2024 21:48:33 -0800
Message-ID: <20240223054833.15471-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce the number of kernel-doc warnings from 52 down to 10, i.e.,
fix 42 kernel-doc warnings by (a) using the Returns: format for
function return values or (b) using "@var:" instead of "@var -"
for function parameter descriptions.

Fix one return values list so that it is formatted correctly when
rendered for output.

Spell "non-zero" with a hyphen in several places.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202312180518.X6fRyDSN-lkp@intel.com/
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-trace-kernel@vger.kernel.org
---
This patch addresses most of the reported kernel-doc warnings but does
not fix all of them, so I did not use "Closes:" for the Link: tag.

 kernel/trace/ftrace.c |   90 ++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 44 deletions(-)

diff -- a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1160,7 +1160,7 @@ __ftrace_lookup_ip(struct ftrace_hash *h
  * Search a given @hash to see if a given instruction pointer (@ip)
  * exists in it.
  *
- * Returns the entry that holds the @ip if found. NULL otherwise.
+ * Returns: the entry that holds the @ip if found. NULL otherwise.
  */
 struct ftrace_func_entry *
 ftrace_lookup_ip(struct ftrace_hash *hash, unsigned long ip)
@@ -1282,7 +1282,7 @@ static void free_ftrace_hash_rcu(struct
 
 /**
  * ftrace_free_filter - remove all filters for an ftrace_ops
- * @ops - the ops to remove the filters from
+ * @ops: the ops to remove the filters from
  */
 void ftrace_free_filter(struct ftrace_ops *ops)
 {
@@ -1587,7 +1587,7 @@ static struct dyn_ftrace *lookup_rec(uns
  * @end: end of range to search (inclusive). @end points to the last byte
  *	to check.
  *
- * Returns rec->ip if the related ftrace location is a least partly within
+ * Returns: rec->ip if the related ftrace location is a least partly within
  * the given address range. That is, the first address of the instruction
  * that is either a NOP or call to the function tracer. It checks the ftrace
  * internal tables to determine if the address belongs or not.
@@ -1607,9 +1607,10 @@ unsigned long ftrace_location_range(unsi
  * ftrace_location - return the ftrace location
  * @ip: the instruction pointer to check
  *
- * If @ip matches the ftrace location, return @ip.
- * If @ip matches sym+0, return sym's ftrace location.
- * Otherwise, return 0.
+ * Returns:
+ * * If @ip matches the ftrace location, return @ip.
+ * * If @ip matches sym+0, return sym's ftrace location.
+ * * Otherwise, return 0.
  */
 unsigned long ftrace_location(unsigned long ip)
 {
@@ -1639,7 +1640,7 @@ out:
  * @start: start of range to search
  * @end: end of range to search (inclusive). @end points to the last byte to check.
  *
- * Returns 1 if @start and @end contains a ftrace location.
+ * Returns: 1 if @start and @end contains a ftrace location.
  * That is, the instruction that is either a NOP or call to
  * the function tracer. It checks the ftrace internal tables to
  * determine if the address belongs or not.
@@ -2574,7 +2575,7 @@ static void call_direct_funcs(unsigned l
  * wants to convert to a callback that saves all regs. If FTRACE_FL_REGS
  * is not set, then it wants to convert to the normal callback.
  *
- * Returns the address of the trampoline to set to
+ * Returns: the address of the trampoline to set to
  */
 unsigned long ftrace_get_addr_new(struct dyn_ftrace *rec)
 {
@@ -2615,7 +2616,7 @@ unsigned long ftrace_get_addr_new(struct
  * a function that saves all the regs. Basically the '_EN' version
  * represents the current state of the function.
  *
- * Returns the address of the trampoline that is currently being called
+ * Returns: the address of the trampoline that is currently being called
  */
 unsigned long ftrace_get_addr_curr(struct dyn_ftrace *rec)
 {
@@ -2719,7 +2720,7 @@ struct ftrace_rec_iter {
 /**
  * ftrace_rec_iter_start - start up iterating over traced functions
  *
- * Returns an iterator handle that is used to iterate over all
+ * Returns: an iterator handle that is used to iterate over all
  * the records that represent address locations where functions
  * are traced.
  *
@@ -2751,7 +2752,7 @@ struct ftrace_rec_iter *ftrace_rec_iter_
  * ftrace_rec_iter_next - get the next record to process.
  * @iter: The handle to the iterator.
  *
- * Returns the next iterator after the given iterator @iter.
+ * Returns: the next iterator after the given iterator @iter.
  */
 struct ftrace_rec_iter *ftrace_rec_iter_next(struct ftrace_rec_iter *iter)
 {
@@ -2776,7 +2777,7 @@ struct ftrace_rec_iter *ftrace_rec_iter_
  * ftrace_rec_iter_record - get the record at the iterator location
  * @iter: The current iterator location
  *
- * Returns the record that the current @iter is at.
+ * Returns: the record that the current @iter is at.
  */
 struct dyn_ftrace *ftrace_rec_iter_record(struct ftrace_rec_iter *iter)
 {
@@ -4010,6 +4011,8 @@ ftrace_avail_addrs_open(struct inode *in
  * ftrace_notrace_write() if @flag has FTRACE_ITER_NOTRACE set.
  * tracing_lseek() should be used as the lseek routine, and
  * release must call ftrace_regex_release().
+ *
+ * Returns: 0 on success or a negative errno value on failure
  */
 int
 ftrace_regex_open(struct ftrace_ops *ops, int flag,
@@ -4626,7 +4629,7 @@ struct ftrace_func_mapper {
 /**
  * allocate_ftrace_func_mapper - allocate a new ftrace_func_mapper
  *
- * Returns a ftrace_func_mapper descriptor that can be used to map ips to data.
+ * Returns: a ftrace_func_mapper descriptor that can be used to map ips to data.
  */
 struct ftrace_func_mapper *allocate_ftrace_func_mapper(void)
 {
@@ -4646,7 +4649,7 @@ struct ftrace_func_mapper *allocate_ftra
  * @mapper: The mapper that has the ip maps
  * @ip: the instruction pointer to find the data for
  *
- * Returns the data mapped to @ip if found otherwise NULL. The return
+ * Returns: the data mapped to @ip if found otherwise NULL. The return
  * is actually the address of the mapper data pointer. The address is
  * returned for use cases where the data is no bigger than a long, and
  * the user can use the data pointer as its data instead of having to
@@ -4672,7 +4675,7 @@ void **ftrace_func_mapper_find_ip(struct
  * @ip: The instruction pointer address to map @data to
  * @data: The data to map to @ip
  *
- * Returns 0 on success otherwise an error.
+ * Returns: 0 on success otherwise an error.
  */
 int ftrace_func_mapper_add_ip(struct ftrace_func_mapper *mapper,
 			      unsigned long ip, void *data)
@@ -4701,7 +4704,7 @@ int ftrace_func_mapper_add_ip(struct ftr
  * @mapper: The mapper that has the ip maps
  * @ip: The instruction pointer address to remove the data from
  *
- * Returns the data if it is found, otherwise NULL.
+ * Returns: the data if it is found, otherwise NULL.
  * Note, if the data pointer is used as the data itself, (see
  * ftrace_func_mapper_find_ip(), then the return value may be meaningless,
  * if the data pointer was set to zero.
@@ -5630,10 +5633,10 @@ EXPORT_SYMBOL_GPL(modify_ftrace_direct);
 
 /**
  * ftrace_set_filter_ip - set a function to filter on in ftrace by address
- * @ops - the ops to set the filter with
- * @ip - the address to add to or remove from the filter.
- * @remove - non zero to remove the ip from the filter
- * @reset - non zero to reset all filters before applying this filter.
+ * @ops: the ops to set the filter with
+ * @ip: the address to add to or remove from the filter.
+ * @remove: non zero to remove the ip from the filter
+ * @reset: non zero to reset all filters before applying this filter.
  *
  * Filters denote which functions should be enabled when tracing is enabled
  * If @ip is NULL, it fails to update filter.
@@ -5652,11 +5655,11 @@ EXPORT_SYMBOL_GPL(ftrace_set_filter_ip);
 
 /**
  * ftrace_set_filter_ips - set functions to filter on in ftrace by addresses
- * @ops - the ops to set the filter with
- * @ips - the array of addresses to add to or remove from the filter.
- * @cnt - the number of addresses in @ips
- * @remove - non zero to remove ips from the filter
- * @reset - non zero to reset all filters before applying this filter.
+ * @ops: the ops to set the filter with
+ * @ips: the array of addresses to add to or remove from the filter.
+ * @cnt: the number of addresses in @ips
+ * @remove: non zero to remove ips from the filter
+ * @reset: non zero to reset all filters before applying this filter.
  *
  * Filters denote which functions should be enabled when tracing is enabled
  * If @ips array or any ip specified within is NULL , it fails to update filter.
@@ -5675,7 +5678,7 @@ EXPORT_SYMBOL_GPL(ftrace_set_filter_ips)
 
 /**
  * ftrace_ops_set_global_filter - setup ops to use global filters
- * @ops - the ops which will use the global filters
+ * @ops: the ops which will use the global filters
  *
  * ftrace users who need global function trace filtering should call this.
  * It can set the global filter only if ops were not initialized before.
@@ -5699,10 +5702,10 @@ ftrace_set_regex(struct ftrace_ops *ops,
 
 /**
  * ftrace_set_filter - set a function to filter on in ftrace
- * @ops - the ops to set the filter with
- * @buf - the string that holds the function filter text.
- * @len - the length of the string.
- * @reset - non zero to reset all filters before applying this filter.
+ * @ops: the ops to set the filter with
+ * @buf: the string that holds the function filter text.
+ * @len: the length of the string.
+ * @reset: non-zero to reset all filters before applying this filter.
  *
  * Filters denote which functions should be enabled when tracing is enabled.
  * If @buf is NULL and reset is set, all functions will be enabled for tracing.
@@ -5721,10 +5724,10 @@ EXPORT_SYMBOL_GPL(ftrace_set_filter);
 
 /**
  * ftrace_set_notrace - set a function to not trace in ftrace
- * @ops - the ops to set the notrace filter with
- * @buf - the string that holds the function notrace text.
- * @len - the length of the string.
- * @reset - non zero to reset all filters before applying this filter.
+ * @ops: the ops to set the notrace filter with
+ * @buf: the string that holds the function notrace text.
+ * @len: the length of the string.
+ * @reset: non-zero to reset all filters before applying this filter.
  *
  * Notrace Filters denote which functions should not be enabled when tracing
  * is enabled. If @buf is NULL and reset is set, all functions will be enabled
@@ -5743,9 +5746,9 @@ int ftrace_set_notrace(struct ftrace_ops
 EXPORT_SYMBOL_GPL(ftrace_set_notrace);
 /**
  * ftrace_set_global_filter - set a function to filter on with global tracers
- * @buf - the string that holds the function filter text.
- * @len - the length of the string.
- * @reset - non zero to reset all filters before applying this filter.
+ * @buf: the string that holds the function filter text.
+ * @len: the length of the string.
+ * @reset: non-zero to reset all filters before applying this filter.
  *
  * Filters denote which functions should be enabled when tracing is enabled.
  * If @buf is NULL and reset is set, all functions will be enabled for tracing.
@@ -5758,9 +5761,9 @@ EXPORT_SYMBOL_GPL(ftrace_set_global_filt
 
 /**
  * ftrace_set_global_notrace - set a function to not trace with global tracers
- * @buf - the string that holds the function notrace text.
- * @len - the length of the string.
- * @reset - non zero to reset all filters before applying this filter.
+ * @buf: the string that holds the function notrace text.
+ * @len: the length of the string.
+ * @reset: non-zero to reset all filters before applying this filter.
  *
  * Notrace Filters denote which functions should not be enabled when tracing
  * is enabled. If @buf is NULL and reset is set, all functions will be enabled
@@ -7448,7 +7451,7 @@ NOKPROBE_SYMBOL(ftrace_ops_assist_func);
  * have its own recursion protection, then it should call the
  * ftrace_ops_assist_func() instead.
  *
- * Returns the function that the trampoline should call for @ops.
+ * Returns: the function that the trampoline should call for @ops.
  */
 ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops)
 {
@@ -7902,7 +7905,7 @@ void ftrace_kill(void)
 /**
  * ftrace_is_dead - Test if ftrace is dead or not.
  *
- * Returns 1 if ftrace is "dead", zero otherwise.
+ * Returns: 1 if ftrace is "dead", zero otherwise.
  */
 int ftrace_is_dead(void)
 {
@@ -8147,8 +8150,7 @@ static int kallsyms_callback(void *data,
  * @addrs array, which needs to be big enough to store at least @cnt
  * addresses.
  *
- * This function returns 0 if all provided symbols are found,
- * -ESRCH otherwise.
+ * Returns: 0 if all provided symbols are found, -ESRCH otherwise.
  */
 int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs)
 {

