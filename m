Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A837807DD8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442038AbjLGBXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443075AbjLGBWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:22:45 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEEE2691
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:18:35 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5caf61210e3so2081297b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911915; x=1702516715; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8GXZA6hMRGCFg0n3nYl/Wc8todk6+aryzhe46OarEso=;
        b=VnFK41HRkCfT/N7xYhzX10VBEYRSkPzmQ1CTIIHvfC8rHKC+FYBsp64vpZx4iLBnxe
         a/V0HKBfIkkMja5E8oWl1wz9y4zLq5MWIrMgBcioIJHmImzLL0liRnz1rE4kTNkEh2KT
         dbvXguAlj1zxM81xIb/kblmMG97/joc/8F3U76UJxT1Bb9e6u2SLSzPuqk6B1Fx1Vznw
         3FXNZNCwyF/GbLwC+e7mfaBd7oZPfoAdX0Y7hVZ8vn+EngE6+Rzik/771AnZqg6m70it
         Yrhk3WVD9QUtEeTe9S5clhSY/l4DYyGVSAtGoofad0wlaWyUYYF9iQyckwYJ2N5aXMW9
         VZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911915; x=1702516715;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8GXZA6hMRGCFg0n3nYl/Wc8todk6+aryzhe46OarEso=;
        b=WmQKR4NO2rkLGiZJuJPDTCAr8vIy3IkSbOJ6slmslAul9+H1ZycYYoAbPV/ZTtvtIe
         1o/3G5vOE5R8vLsxVLHa/5kxpyAOb1ZTlfG/t3Kk4TjFV2sedn1uJPV1tXaBMGV5cacA
         Umr2qXmChrNkcBQlKyDEGmHdmNCJTKxgT2oD5C3q10jpuqVLsKM/1i4gBB3WxzmucPaw
         IZ8csHavVH0V1bV9WH7v42auULlDxmz/GJOR9IP+bmaXEWYixJhPcffPz2hHkwTDKYW5
         zEIjBeupLwpHBP+9U3qvBwmgSad1Yz/lYia3n3/U1JUqoOHJOo7VQdh3ifHgJQWhaAV1
         lk2A==
X-Gm-Message-State: AOJu0Yxsj/yu0mjt5HkxsSdvhBN0LbzCCY8wwKJ7bmhZKzLxfviH7uPw
        VNrwb7K17luSWYIf7Fd9ZLq5DrY/XMod
X-Google-Smtp-Source: AGHT+IFKw8I9x+klEWZdpdhPj5xQTN3f72dIH4mJjHLMwan/AEtRg7MWSR7ORvDNvqtXgQs7AMVQrOdJiYGZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a05:690c:3146:b0:5d6:daf7:b53b with SMTP
 id fc6-20020a05690c314600b005d6daf7b53bmr24228ywb.9.1701911914787; Wed, 06
 Dec 2023 17:18:34 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:17:03 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-30-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 29/47] perf dso: Reorder variables to save space in struct dso
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 3759de8c2267..8bdc17d78b02 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -158,66 +158,66 @@ struct dso {
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
2.43.0.rc2.451.g8631bc7472-goog

