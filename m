Return-Path: <linux-kernel+bounces-98629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52347877CED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED3B2814CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7642E410;
	Mon, 11 Mar 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fCndtFff"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8F2C695
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149685; cv=none; b=kzcCrvYYqgle4sV7W9v4omCbmf52R7fedztzJ8dFFhBdkBy23swBFC44qsQz5oTxNmigxIpUj2jM2iNdWq6TYDC79XhiHcXTG07+Whm1ArPrvFNKWo2I4D5Mgig4Io1mfyHghZQpTTW5E6ZUSa95DAuFGhHvP8KSAUgds/rD5Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149685; c=relaxed/simple;
	bh=gPSHW2/9unWuAhFncICuut3hiBk/07uto75Q0YZZP+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BBEqwjTDvZtCc0j/MQrUmBLTbtoSODDhP2MGS1WGxizcaB/ZM55dxk6bWDp0MlZfyIbcMv2YHGi4pOpmvtp9KbDFK6J5z27zK4/rFh3rp6yjPxc6nC0t2lPxwhmGheRlQ7RotjM2vtzUdBE4efnUpEQ8Q58IzbyeV6yupimGO1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fCndtFff; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e676ea4e36so1807268b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710149683; x=1710754483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjSWV41JlB3dq7HwIpKEF4e0TQa/o2d+dOhHoSuTF7U=;
        b=fCndtFffu1Ss2NcYN91svt0lbgvg/8XEuiKcZFBYKp7qeeF+XLcmbg+m63YznekLld
         GRZI7k/jvSHxYlpUhAl51sQNowp1tN0KStmqyTY58z+irKn+wdBqUqbuygyeyIrgBtEU
         t5F747/SOt7yRqdumXdtJrM2+s7N27vDv/23Tc/kpoR86DnCGK5aM5jRiUfNM2R9d8LX
         QXoebEhGQoGQzulAGDVWHrS43KwnxkOLJvXdDsl3XESVcCGBiArmh9gtRJBpz5sElNA/
         Moey35A9/O63/cbjNgddzv+E44rO0Q1G7dbN91co4eRiYSx6W5P9WJ8/6UKao6Mbsq+6
         sEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710149683; x=1710754483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjSWV41JlB3dq7HwIpKEF4e0TQa/o2d+dOhHoSuTF7U=;
        b=SmV+64/PZm4wERF57q/y4GJG+FF4OrylndPS84I2OwpBar8vCZq6lgJvssLEgWFHYt
         H1ESWsHr48RvX36n5L/bDjXWNl33Bxd9SkmSyUoCZN4oLTNaTGVTOv4JM7ni7OClVrmi
         J13xoY1gVIrwvGuB1KO6u1BV/F6U8xGBCpui8hAoMV/56qrTsu28Jpjoc7tAs9MLdcDQ
         Y8ya1vx/5LUoxWnCE47dZY+q+peRnwt5AuaEJmhIvat1INQBMcuLder6iwvrSCfbMgUP
         7c9mpysgdJ3PXlrglilkHf3xJf28sUkjoY1DX2SopBYqkv1wV+kMC6zL5kRN1o/WcF3n
         t3TA==
X-Forwarded-Encrypted: i=1; AJvYcCXLUtPptVuoNM0z8dKW7hH7C5FWN/prZDOZjS4Kf8fer0AJzje3Y72bN6ZBvPt4u4cebIQYeN7mnnClkyyYWpi6yzZWq+XwjARq0zk8
X-Gm-Message-State: AOJu0Ywgf3u/ItrdtGZ2rewzFGXdRf5c50M5T12f1IRKS5Us3rYmvjMa
	vtsSvj0Efe3SwSlZyErvoK0FVEazkXUa9Zrh7G3uEzuYy/plpkDXbgl+xn5RD0w=
X-Google-Smtp-Source: AGHT+IFbj6YfcHBYvXMM2NWizkuYpniqg3bImjqE4WhHnt6u4m7Hz7unmoAwRceekSZcHEkG6VDAnw==
X-Received: by 2002:a05:6a20:438a:b0:1a1:431c:6696 with SMTP id i10-20020a056a20438a00b001a1431c6696mr4574882pzl.49.1710149683554;
        Mon, 11 Mar 2024 02:34:43 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001dcad9cbf8bsm4253365plw.239.2024.03.11.02.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 02:34:43 -0700 (PDT)
From: Menglong Dong <dongmenglong.8@bytedance.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	quentin@isovalent.com,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Menglong Dong <dongmenglong.8@bytedance.com>
Subject: [PATCH bpf-next v2 2/9] bpf: refactor the modules_array to ptr_array
Date: Mon, 11 Mar 2024 17:35:19 +0800
Message-Id: <20240311093526.1010158-3-dongmenglong.8@bytedance.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the struct modules_array to more general struct ptr_array, which
is used to store the pointers.

Meanwhiles, introduce the bpf_try_add_ptr(), which checks the existing of
the ptr before adding it to the array.

Seems it should be moved to another files in "lib", and I'm not sure where
to add it now, and let's move it to kernel/bpf/syscall.c for now.

Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
---
 include/linux/bpf.h      | 10 +++++++++
 kernel/bpf/syscall.c     | 37 +++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c | 48 ++++++----------------------------------
 3 files changed, 54 insertions(+), 41 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0f677fdcfcc7..997765cdf474 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -304,6 +304,16 @@ struct bpf_map {
 	s64 __percpu *elem_count;
 };
 
+struct ptr_array {
+	void **ptrs;
+	int cnt;
+	int cap;
+};
+
+int bpf_add_ptr(struct ptr_array *arr, void *ptr);
+bool bpf_has_ptr(struct ptr_array *arr, struct module *mod);
+int bpf_try_add_ptr(struct ptr_array *arr, void *ptr);
+
 static inline const char *btf_field_type_name(enum btf_field_type type)
 {
 	switch (type) {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f63f4da4db5e..4f230fd1f8e4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -479,6 +479,43 @@ static void bpf_map_release_memcg(struct bpf_map *map)
 }
 #endif
 
+int bpf_add_ptr(struct ptr_array *arr, void *ptr)
+{
+	void **ptrs;
+
+	if (arr->cnt == arr->cap) {
+		arr->cap = max(16, arr->cap * 3 / 2);
+		ptrs = krealloc_array(arr->ptrs, arr->cap, sizeof(*ptrs), GFP_KERNEL);
+		if (!ptrs)
+			return -ENOMEM;
+		arr->ptrs = ptrs;
+	}
+
+	arr->ptrs[arr->cnt] = ptr;
+	arr->cnt++;
+	return 0;
+}
+
+bool bpf_has_ptr(struct ptr_array *arr, struct module *mod)
+{
+	int i;
+
+	for (i = arr->cnt - 1; i >= 0; i--) {
+		if (arr->ptrs[i] == mod)
+			return true;
+	}
+	return false;
+}
+
+int bpf_try_add_ptr(struct ptr_array *arr, void *ptr)
+{
+	if (bpf_has_ptr(arr, ptr))
+		return -EEXIST;
+	if (bpf_add_ptr(arr, ptr))
+		return -ENOMEM;
+	return 0;
+}
+
 static int btf_field_cmp(const void *a, const void *b)
 {
 	const struct btf_field *f1 = a, *f2 = b;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 241ddf5e3895..791e97a3f8e3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2873,43 +2873,9 @@ static void symbols_swap_r(void *a, void *b, int size, const void *priv)
 	}
 }
 
-struct modules_array {
-	struct module **mods;
-	int mods_cnt;
-	int mods_cap;
-};
-
-static int add_module(struct modules_array *arr, struct module *mod)
-{
-	struct module **mods;
-
-	if (arr->mods_cnt == arr->mods_cap) {
-		arr->mods_cap = max(16, arr->mods_cap * 3 / 2);
-		mods = krealloc_array(arr->mods, arr->mods_cap, sizeof(*mods), GFP_KERNEL);
-		if (!mods)
-			return -ENOMEM;
-		arr->mods = mods;
-	}
-
-	arr->mods[arr->mods_cnt] = mod;
-	arr->mods_cnt++;
-	return 0;
-}
-
-static bool has_module(struct modules_array *arr, struct module *mod)
-{
-	int i;
-
-	for (i = arr->mods_cnt - 1; i >= 0; i--) {
-		if (arr->mods[i] == mod)
-			return true;
-	}
-	return false;
-}
-
 static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u32 addrs_cnt)
 {
-	struct modules_array arr = {};
+	struct ptr_array arr = {};
 	u32 i, err = 0;
 
 	for (i = 0; i < addrs_cnt; i++) {
@@ -2918,7 +2884,7 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
 		preempt_disable();
 		mod = __module_address(addrs[i]);
 		/* Either no module or we it's already stored  */
-		if (!mod || has_module(&arr, mod)) {
+		if (!mod || bpf_has_ptr(&arr, mod)) {
 			preempt_enable();
 			continue;
 		}
@@ -2927,7 +2893,7 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
 		preempt_enable();
 		if (err)
 			break;
-		err = add_module(&arr, mod);
+		err = bpf_add_ptr(&arr, mod);
 		if (err) {
 			module_put(mod);
 			break;
@@ -2936,14 +2902,14 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
 
 	/* We return either err < 0 in case of error, ... */
 	if (err) {
-		kprobe_multi_put_modules(arr.mods, arr.mods_cnt);
-		kfree(arr.mods);
+		kprobe_multi_put_modules((struct module **)arr.ptrs, arr.cnt);
+		kfree(arr.ptrs);
 		return err;
 	}
 
 	/* or number of modules found if everything is ok. */
-	*mods = arr.mods;
-	return arr.mods_cnt;
+	*mods = (struct module **)arr.ptrs;
+	return arr.cnt;
 }
 
 static int addrs_check_error_injection_list(unsigned long *addrs, u32 cnt)
-- 
2.39.2


