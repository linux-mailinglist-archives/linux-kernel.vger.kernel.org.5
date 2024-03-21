Return-Path: <linux-kernel+bounces-110296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA405885CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B321C22C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAF112C538;
	Thu, 21 Mar 2024 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xQ8TQAhU"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BCC12BF34
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036993; cv=none; b=X2O/aRmeMe2CrPqa8A8jNPl+EyamVKcLoJjQIMcjsFhVvBc9RV2kXhhqM5Y4fI6Tj0qeFBPiMByrK63lzG8ahjd4e5HowuLpmoyi75DmTAFUdDGHNdrYm5gF8dQf/D9NDyrIvsu8AERwbEGTWgRpKxtQP7EZWpJlk1sNyfzReFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036993; c=relaxed/simple;
	bh=RBrB5BXaNoo1IQoJ9V9QDA+EU1D4Wq30rZpNB+sQ3mE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=H6q+gOU09dVXGGgX2bfvlD9xtWeK9Upujpx9M3moJEpKrzxUQYyiyL5RPROCgxgLW4LMlhT0XHJZdfuoFazbQ3aRzwQk96UPBgWykT2ZEu8nAdd8RqgQt9HJ/2mECLdbB6tJUi3Qzrk7QkgQjf7v2c9/84FxD4M/rAKm+OGDTDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xQ8TQAhU; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd62fa20fso22939707b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711036989; x=1711641789; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f+MEbM++g16iMexStgeW5mWbub1tgw8efwRK0qIdUcA=;
        b=xQ8TQAhUpQZW/nj8RuwbyUQz8RtuI9qMw9Dud1a6giL8MFhn+V7ejMrnb0/0MV8TFT
         IXotjNJGtnbQOtx1ns3N8DN+O92S/0LNsfVMhlAmwF+gm7wV5nkTLWjrNDj5vjiVTQrh
         JQJ3CcgSK10GsZoqwrFDdUcoTYfx7bx4LbuKB1x1CwywnmV2YqySXEwTW1YJ4jUjWAX0
         ComgBD3LB/WhRRzFcSbMEhrC9h3n4d3W+P0fkR9aK4vEH3Wvj8k+0VkPQxITbcQYIihd
         Pi/5/KSRBH2r4NixZMeemwKZIA5GxVAjOKOx6a4LwGe09/Cq6YrjvYCSy11Vpngz59/f
         Qh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711036989; x=1711641789;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+MEbM++g16iMexStgeW5mWbub1tgw8efwRK0qIdUcA=;
        b=mNWfez2zGJsHX7lMPNN3nGFiM5U2ICrO1l4Jn7urHDS6GiR6XNLUlkW7RlYg4S4gEX
         6LPoEfFhmwGiaX19KlncSE81PQr/k9AbzCe+PTXbcLqds2Nu8d69uVUmOCozjM85wr6o
         c901BXiKnzwoJbf1TwMSVsevB0nfRwpzUI8fRsrrPuKIFKVr8HWmjIcfiQXYKFPemOZq
         pWu0LqRQfh/W+d5B8MzHTT9D5sx5dVltAjWXnlVKLnzwf+FJUkdtq8loyJx1eBOGpJZH
         E5aWR+ijIOxvDUBXjRg5N25fQ/Xiak9UCIa3Lz9LNj+DrtQLKTLttK3F+iceY/iVJu36
         aXmw==
X-Forwarded-Encrypted: i=1; AJvYcCVgEwKsyPjnJK91FPusUZXW6DguzrhvSHtlGlvJZl8HEvY9DAN3Wc3RA+ILl1lnRViXjl5rVOzm4bN9H32RtW7ONHghVHtoXHZrfq9b
X-Gm-Message-State: AOJu0YxChFgZT18X1cavgAsbPJq4iI14vebzkvKE278uwlnjB3YvzkAS
	AVi1QY3qCZc/MjewI8XQGaaCOSIzTgndhN6ofpBRfZRv/mYgGhGzf6z4YYvEMbVUzuuKHPC+/gv
	FT3aHkg==
X-Google-Smtp-Source: AGHT+IFpBo6k8tuUdOIJKcJBl2RWui1ScCSnQi70hMgOd5Gzx9PU8JVNw6XG+ulNbwPBSK4Y37K+Mi/3q7As
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f3:cf74:42c4:c0a])
 (user=irogers job=sendgmr) by 2002:a05:6902:240f:b0:dc6:e20f:80cb with SMTP
 id dr15-20020a056902240f00b00dc6e20f80cbmr1122314ybb.3.1711036989312; Thu, 21
 Mar 2024 09:03:09 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:02:48 -0700
In-Reply-To: <20240321160300.1635121-1-irogers@google.com>
Message-Id: <20240321160300.1635121-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321160300.1635121-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Subject: [PATCH v2 01/13] perf dso: Reorder variables to save space in struct dso
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, Leo Yan <leo.yan@linux.dev>, 
	Song Liu <song@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Changbin Du <changbin.du@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Paran Lee <p4ranlee@gmail.com>, 
	Li Dong <lidong@vivo.com>, elfring@users.sourceforge.net, 
	Andi Kleen <ak@linux.intel.com>, Markus Elfring <Markus.Elfring@web.de>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Save 40 bytes and move from 8 to 7 cache lines. Make variable dwfl
dependent on being a powerpc build. Squeeze bits of int/enum types
when appropriate. Remove holes/padding by reordering variables.

Before:
```
struct dso {
        struct mutex               lock;                 /*     0    40 */
        struct list_head           node;                 /*    40    16 */
        struct rb_node             rb_node __attribute__((__aligned__(8))); /*    56    24 */
        /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
        struct rb_root *           root;                 /*    80     8 */
        struct rb_root_cached      symbols;              /*    88    16 */
        struct symbol * *          symbol_names;         /*   104     8 */
        size_t                     symbol_names_len;     /*   112     8 */
        struct rb_root_cached      inlined_nodes;        /*   120    16 */
        /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
        struct rb_root_cached      srclines;             /*   136    16 */
        struct {
                u64                addr;                 /*   152     8 */
                struct symbol *    symbol;               /*   160     8 */
        } last_find_result;                              /*   152    16 */
        void *                     a2l;                  /*   168     8 */
        char *                     symsrc_filename;      /*   176     8 */
        unsigned int               a2l_fails;            /*   184     4 */
        enum dso_space_type        kernel;               /*   188     4 */
        /* --- cacheline 3 boundary (192 bytes) --- */
        _Bool                      is_kmod;              /*   192     1 */

        /* XXX 3 bytes hole, try to pack */

        enum dso_swap_type         needs_swap;           /*   196     4 */
        enum dso_binary_type       symtab_type;          /*   200     4 */
        enum dso_binary_type       binary_type;          /*   204     4 */
        enum dso_load_errno        load_errno;           /*   208     4 */
        u8                         adjust_symbols:1;     /*   212: 0  1 */
        u8                         has_build_id:1;       /*   212: 1  1 */
        u8                         header_build_id:1;    /*   212: 2  1 */
        u8                         has_srcline:1;        /*   212: 3  1 */
        u8                         hit:1;                /*   212: 4  1 */
        u8                         annotate_warned:1;    /*   212: 5  1 */
        u8                         auxtrace_warned:1;    /*   212: 6  1 */
        u8                         short_name_allocated:1; /*   212: 7  1 */
        u8                         long_name_allocated:1; /*   213: 0  1 */
        u8                         is_64_bit:1;          /*   213: 1  1 */

        /* XXX 6 bits hole, try to pack */

        _Bool                      sorted_by_name;       /*   214     1 */
        _Bool                      loaded;               /*   215     1 */
        u8                         rel;                  /*   216     1 */

        /* XXX 7 bytes hole, try to pack */

        struct build_id            bid;                  /*   224    32 */
        /* --- cacheline 4 boundary (256 bytes) --- */
        u64                        text_offset;          /*   256     8 */
        u64                        text_end;             /*   264     8 */
        const char  *              short_name;           /*   272     8 */
        const char  *              long_name;            /*   280     8 */
        u16                        long_name_len;        /*   288     2 */
        u16                        short_name_len;       /*   290     2 */

        /* XXX 4 bytes hole, try to pack */

        void *                     dwfl;                 /*   296     8 */
        struct auxtrace_cache *    auxtrace_cache;       /*   304     8 */
        int                        comp;                 /*   312     4 */

        /* XXX 4 bytes hole, try to pack */

        /* --- cacheline 5 boundary (320 bytes) --- */
        struct {
                struct rb_root     cache;                /*   320     8 */
                int                fd;                   /*   328     4 */
                int                status;               /*   332     4 */
                u32                status_seen;          /*   336     4 */

                /* XXX 4 bytes hole, try to pack */

                u64                file_size;            /*   344     8 */
                struct list_head   open_entry;           /*   352    16 */
                u64                elf_base_addr;        /*   368     8 */
                u64                debug_frame_offset;   /*   376     8 */
                /* --- cacheline 6 boundary (384 bytes) --- */
                u64                eh_frame_hdr_addr;    /*   384     8 */
                u64                eh_frame_hdr_offset;  /*   392     8 */
        } data;                                          /*   320    80 */
        struct {
                u32                id;                   /*   400     4 */
                u32                sub_id;               /*   404     4 */
                struct perf_env *  env;                  /*   408     8 */
        } bpf_prog;                                      /*   400    16 */
        union {
                void *             priv;                 /*   416     8 */
                u64                db_id;                /*   416     8 */
        };                                               /*   416     8 */
        struct nsinfo *            nsinfo;               /*   424     8 */
        struct dso_id              id;                   /*   432    24 */
        /* --- cacheline 7 boundary (448 bytes) was 8 bytes ago --- */
        refcount_t                 refcnt;               /*   456     4 */
        char                       name[];               /*   460     0 */

        /* size: 464, cachelines: 8, members: 49 */
        /* sum members: 440, holes: 4, sum holes: 18 */
        /* sum bitfield members: 10 bits, bit holes: 1, sum bit holes: 6 bits */
        /* padding: 4 */
        /* forced alignments: 1 */
        /* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));
```

After:
```
struct dso {
        struct mutex               lock;                 /*     0    40 */
        struct list_head           node;                 /*    40    16 */
        struct rb_node             rb_node __attribute__((__aligned__(8))); /*    56    24 */
        /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
        struct rb_root *           root;                 /*    80     8 */
        struct rb_root_cached      symbols;              /*    88    16 */
        struct symbol * *          symbol_names;         /*   104     8 */
        size_t                     symbol_names_len;     /*   112     8 */
        struct rb_root_cached      inlined_nodes;        /*   120    16 */
        /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
        struct rb_root_cached      srclines;             /*   136    16 */
        struct {
                u64                addr;                 /*   152     8 */
                struct symbol *    symbol;               /*   160     8 */
        } last_find_result;                              /*   152    16 */
        struct build_id            bid;                  /*   168    32 */
        /* --- cacheline 3 boundary (192 bytes) was 8 bytes ago --- */
        u64                        text_offset;          /*   200     8 */
        u64                        text_end;             /*   208     8 */
        const char  *              short_name;           /*   216     8 */
        const char  *              long_name;            /*   224     8 */
        void *                     a2l;                  /*   232     8 */
        char *                     symsrc_filename;      /*   240     8 */
        struct nsinfo *            nsinfo;               /*   248     8 */
        /* --- cacheline 4 boundary (256 bytes) --- */
        struct auxtrace_cache *    auxtrace_cache;       /*   256     8 */
        union {
                void *             priv;                 /*   264     8 */
                u64                db_id;                /*   264     8 */
        };                                               /*   264     8 */
        struct {
                struct perf_env *  env;                  /*   272     8 */
                u32                id;                   /*   280     4 */
                u32                sub_id;               /*   284     4 */
        } bpf_prog;                                      /*   272    16 */
        struct {
                struct rb_root     cache;                /*   288     8 */
                struct list_head   open_entry;           /*   296    16 */
                u64                file_size;            /*   312     8 */
                /* --- cacheline 5 boundary (320 bytes) --- */
                u64                elf_base_addr;        /*   320     8 */
                u64                debug_frame_offset;   /*   328     8 */
                u64                eh_frame_hdr_addr;    /*   336     8 */
                u64                eh_frame_hdr_offset;  /*   344     8 */
                int                fd;                   /*   352     4 */
                int                status;               /*   356     4 */
                u32                status_seen;          /*   360     4 */
        } data;                                          /*   288    80 */

        /* XXX last struct has 4 bytes of padding */

        struct dso_id              id;                   /*   368    24 */
        /* --- cacheline 6 boundary (384 bytes) was 8 bytes ago --- */
        unsigned int               a2l_fails;            /*   392     4 */
        int                        comp;                 /*   396     4 */
        refcount_t                 refcnt;               /*   400     4 */
        enum dso_load_errno        load_errno;           /*   404     4 */
        u16                        long_name_len;        /*   408     2 */
        u16                        short_name_len;       /*   410     2 */
        enum dso_binary_type       symtab_type:8;        /*   412: 0  4 */
        enum dso_binary_type       binary_type:8;        /*   412: 8  4 */
        enum dso_space_type        kernel:2;             /*   412:16  4 */
        enum dso_swap_type         needs_swap:2;         /*   412:18  4 */

        /* Bitfield combined with next fields */

        _Bool                      is_kmod:1;            /*   414: 4  1 */
        u8                         adjust_symbols:1;     /*   414: 5  1 */
        u8                         has_build_id:1;       /*   414: 6  1 */
        u8                         header_build_id:1;    /*   414: 7  1 */
        u8                         has_srcline:1;        /*   415: 0  1 */
        u8                         hit:1;                /*   415: 1  1 */
        u8                         annotate_warned:1;    /*   415: 2  1 */
        u8                         auxtrace_warned:1;    /*   415: 3  1 */
        u8                         short_name_allocated:1; /*   415: 4  1 */
        u8                         long_name_allocated:1; /*   415: 5  1 */
        u8                         is_64_bit:1;          /*   415: 6  1 */

        /* XXX 1 bit hole, try to pack */

        _Bool                      sorted_by_name;       /*   416     1 */
        _Bool                      loaded;               /*   417     1 */
        u8                         rel;                  /*   418     1 */
        char                       name[];               /*   419     0 */

        /* size: 424, cachelines: 7, members: 48 */
        /* sum members: 415 */
        /* sum bitfield members: 31 bits, bit holes: 1, sum bit holes: 1 bits */
        /* padding: 5 */
        /* paddings: 1, sum paddings: 4 */
        /* forced alignments: 1 */
        /* last cacheline: 40 bytes */
} __attribute__((__aligned__(8)));
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.h | 84 +++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 2cdcd1e2ef8b..17dab230a2ca 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -161,66 +161,66 @@ struct dso {
 		u64		addr;
 		struct symbol	*symbol;
 	} last_find_result;
-	void		 *a2l;
-	char		 *symsrc_filename;
-	unsigned int	 a2l_fails;
-	enum dso_space_type	kernel;
-	bool			is_kmod;
-	enum dso_swap_type	needs_swap;
-	enum dso_binary_type	symtab_type;
-	enum dso_binary_type	binary_type;
-	enum dso_load_errno	load_errno;
-	u8		 adjust_symbols:1;
-	u8		 has_build_id:1;
-	u8		 header_build_id:1;
-	u8		 has_srcline:1;
-	u8		 hit:1;
-	u8		 annotate_warned:1;
-	u8		 auxtrace_warned:1;
-	u8		 short_name_allocated:1;
-	u8		 long_name_allocated:1;
-	u8		 is_64_bit:1;
-	bool		 sorted_by_name;
-	bool		 loaded;
-	u8		 rel;
 	struct build_id	 bid;
 	u64		 text_offset;
 	u64		 text_end;
 	const char	 *short_name;
 	const char	 *long_name;
-	u16		 long_name_len;
-	u16		 short_name_len;
+	void		 *a2l;
+	char		 *symsrc_filename;
+#if defined(__powerpc__)
 	void		*dwfl;			/* DWARF debug info */
+#endif
+	struct nsinfo	*nsinfo;
 	struct auxtrace_cache *auxtrace_cache;
-	int		 comp;
-
+	union { /* Tool specific area */
+		void	 *priv;
+		u64	 db_id;
+	};
+	/* bpf prog information */
+	struct {
+		struct perf_env	*env;
+		u32		id;
+		u32		sub_id;
+	} bpf_prog;
 	/* dso data file */
 	struct {
 		struct rb_root	 cache;
-		int		 fd;
-		int		 status;
-		u32		 status_seen;
-		u64		 file_size;
 		struct list_head open_entry;
+		u64		 file_size;
 		u64		 elf_base_addr;
 		u64		 debug_frame_offset;
 		u64		 eh_frame_hdr_addr;
 		u64		 eh_frame_hdr_offset;
+		int		 fd;
+		int		 status;
+		u32		 status_seen;
 	} data;
-	/* bpf prog information */
-	struct {
-		u32		id;
-		u32		sub_id;
-		struct perf_env	*env;
-	} bpf_prog;
-
-	union { /* Tool specific area */
-		void	 *priv;
-		u64	 db_id;
-	};
-	struct nsinfo	*nsinfo;
 	struct dso_id	 id;
+	unsigned int	 a2l_fails;
+	int		 comp;
 	refcount_t	 refcnt;
+	enum dso_load_errno	load_errno;
+	u16		 long_name_len;
+	u16		 short_name_len;
+	enum dso_binary_type	symtab_type:8;
+	enum dso_binary_type	binary_type:8;
+	enum dso_space_type	kernel:2;
+	enum dso_swap_type	needs_swap:2;
+	bool			is_kmod:1;
+	u8		 adjust_symbols:1;
+	u8		 has_build_id:1;
+	u8		 header_build_id:1;
+	u8		 has_srcline:1;
+	u8		 hit:1;
+	u8		 annotate_warned:1;
+	u8		 auxtrace_warned:1;
+	u8		 short_name_allocated:1;
+	u8		 long_name_allocated:1;
+	u8		 is_64_bit:1;
+	bool		 sorted_by_name;
+	bool		 loaded;
+	u8		 rel;
 	char		 name[];
 };
 
-- 
2.44.0.396.g6e790dbe36-goog


