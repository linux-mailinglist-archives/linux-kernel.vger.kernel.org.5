Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C7E77C02E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjHNS7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjHNS7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:59:24 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3ECBC;
        Mon, 14 Aug 2023 11:59:23 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-76cdf055c64so386154885a.3;
        Mon, 14 Aug 2023 11:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692039562; x=1692644362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGuj3pRVjvLXxFets6pK1U3+m8DANPeXEAyiVK4FKOo=;
        b=Gwp8n/6UzoBCJaYg7AceV+/mpHWDJWuiAVCA7eVGfON4NuguGjk1WGr1/CXMvBUsLP
         aCC96+sw2hKzbxtyW3kpkKOTmV8qDtH2n+bpG8j7gidf5XBGHuCyQBnXz0fNWYREhxlQ
         6SyP9usJbR6a2ZThQoibnc68B2yON4h65J5UlsT51iLBDoHWRGonWxpWTeClloMAkWJu
         LoHouk3+dIXpEpP9N6QcNqwbi6xq+Hx1T1a3APR5VMw5DF5W2k7FAAZcnIQj753Ev6y+
         rLF7f9zXFgbiUboySuDvddv9nDf/5aJSzxKufuW59yDwmSC8oZimrd82ugLJM2d9vAaB
         +RqA==
X-Gm-Message-State: AOJu0YzMnUFps/MtGO354xL+wUxOmO/iDC7RcNmSSlnU+NWJTZdh+4/B
        YtGCds/6w0muCqdEmjmaPKgBW3nGjaYBpeiZ
X-Google-Smtp-Source: AGHT+IFUNtzoTJG24F+eBhk7JKeQDXT+j2FaivAC15MMTksndaxp3DTkXBifnR3oVJtUN6DYq9TXeg==
X-Received: by 2002:a05:620a:424b:b0:75b:23a0:deca with SMTP id w11-20020a05620a424b00b0075b23a0decamr12422534qko.72.1692039562527;
        Mon, 14 Aug 2023 11:59:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:93a1])
        by smtp.gmail.com with ESMTPSA id u2-20020ae9c002000000b00767c961eb47sm3217269qkk.43.2023.08.14.11.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:59:22 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, clm@meta.com,
        thinker.li@gmail.com, netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 2/2] bpf: Document struct bpf_struct_ops fields
Date:   Mon, 14 Aug 2023 13:59:08 -0500
Message-ID: <20230814185908.700553-3-void@manifault.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814185908.700553-1-void@manifault.com>
References: <20230814185908.700553-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subsystems that want to implement a struct bpf_struct_ops structure to
enable struct_ops maps must currently reverse engineer how the structure
works. Given that this is meant to be a way for subsystem maintainers to
extend their subsystems using BPF, let's document it to make it a bit
easier on them.

Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/bpf.h | 47 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cfabbcf47bdb..eced6400f778 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1550,6 +1550,53 @@ struct bpf_struct_ops_value;
 struct btf_member;
 
 #define BPF_STRUCT_OPS_MAX_NR_MEMBERS 64
+/**
+ * struct bpf_struct_ops - A structure of callbacks allowing a subsystem to
+ *			   define a BPF_MAP_TYPE_STRUCT_OPS map type composed
+ *			   of BPF_PROG_TYPE_STRUCT_OPS progs.
+ * @verifier_ops: A structure of callbacks that are invoked by the verifier
+ *		  when determining whether the struct_ops progs in the
+ *		  struct_ops map are valid.
+ * @init: A callback that is invoked a single time, and before any other
+ *	  callback, to initialize the structure. A nonzero return value means
+ *	  the subsystem could not be initialized.
+ * @check_member: When defined, a callback invoked by the verifier to allow
+ *		  the subsystem to determine if an entry in the struct_ops map
+ *		  is valid. A nonzero return value means that the map is
+ *		  invalid and should be rejected by the verifier.
+ * @init_member: A callback that is invoked for each member of the struct_ops
+ *		 map to allow the subsystem to initialize the member. A nonzero
+ *		 value means the member could not be initialized. This callback
+ *		 is exclusive with the @type, @type_id, @value_type, and
+ *		 @value_id fields.
+ * @reg: A callback that is invoked when the struct_ops map has been
+ *	 initialized and is being attached to. Zero means the struct_ops map
+ *	 has been successfully registered and is live. A nonzero return value
+ *	 means the struct_ops map could not be registered.
+ * @unreg: A callback that is invoked when the struct_ops map should be
+ *	   unregistered.
+ * @update: A callback that is invoked when the live struct_ops map is being
+ *	    updated to contain new values. This callback is only invoked when
+ *	    the struct_ops map is loaded with BPF_F_LINK. If not defined, the
+ *	    it is assumed that the struct_ops map cannot be updated.
+ * @validate: A callback that is invoked after all of the members have been
+ *	      initialized. This callback should perform static checks on the
+ *	      map, meaning that it should either fail or succeed
+ *	      deterministically. A struct_ops map that has been validated may
+ *	      not necessarily succeed in being registered if the call to @reg
+ *	      fails. For example, a valid struct_ops map may be loaded, but
+ *	      then fail to be registered due to there being another active
+ *	      struct_ops map on the system in the subsystem already. For this
+ *	      reason, if this callback is not defined, the check is skipped as
+ *	      the struct_ops map will have final verification performed in
+ *	      @reg.
+ * @type: BTF type.
+ * @value_type: Value type.
+ * @name: The name of the struct bpf_struct_ops object.
+ * @func_models: Func models
+ * @type_id: BTF type id.
+ * @value_id: BTF value id.
+ */
 struct bpf_struct_ops {
 	const struct bpf_verifier_ops *verifier_ops;
 	int (*init)(struct btf *btf);
-- 
2.41.0

