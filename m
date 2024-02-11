Return-Path: <linux-kernel+bounces-60736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA70A850906
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805CD281DD6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E835B5C5EC;
	Sun, 11 Feb 2024 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="KwcAboEw"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BD35B5D2
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654628; cv=none; b=ZLrjpgspxqkuTyOhiRo/O57Oqr+S0MpX9HRSesIOiZYRg5U+do2cXRmQurwVaN3OFAjzXPiT5+fZEOzdXX+hoZ5EY+x3Q4qipbzixtCWJwVzHJ8u56k4bdR7sKRlDljhk5T+4sPexX8F+rnVTXRDdRb3Mvq3211N9+5JhFzpksg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654628; c=relaxed/simple;
	bh=Z3zMja135IkB6Sq/twqD9jvdg6zxfmw5vu4HRvyqiCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IXazfIuI/UsMiHa19+FcmVVTjAsBiNa4FR2uQgl+HUW71cCY9OZ1e8NIz8UWjyTSFlP5tfCKgY1+UPtkQ0SgZDiwCb0o4qCpn2Q3VYg8T1TQhMDB3R6EpNsrH7bFSUfvVVYF3xv7BO8xKYOmmLmW/fO0aS+BV6WKGlknaqpReQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=KwcAboEw; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51182ece518so888248e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707654620; x=1708259420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eq1LER+rX57fPTUZ1MEt58uiuSP6Ee5pNi3jY4qxCyc=;
        b=KwcAboEwYeUbQ5aoDmu6hKpnzHirY+FawL9aC/IdvJUn3TsTgVt4Uw1GajJQ00QUo6
         TItPzE7DR+9LtZc9pN41CfAckAOas7qPaaJXqby0XFUys96t9qei6sRXbrRL4F1qXpJF
         2xjw78fSyTcslRYG9fmIWsFxdWG59bY3raWL9yI6n6mvUAbvf1ePrum4bj1p4T7+msZO
         eTjWBVBOY7kmBuDyQwh6srJfNQDN735EWkJ0V/GxI1FTftLPY6u8ixYYd7si53rN9Hc1
         lUDm7UJSesxqBU603KXvX8g520skhcdJ1ylvOy05eBlaa6DbsL3OX5RLIu4qSJFUn477
         MIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654620; x=1708259420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eq1LER+rX57fPTUZ1MEt58uiuSP6Ee5pNi3jY4qxCyc=;
        b=MnEzk6P4b2u4IzUPq+inTvMjuzOmIjEEOvoh6WSFvs/ph6WNYQ1zfi1JtD4bJ/kAiS
         DQiHu20r4kvd7ccyS8k8SzExS6XGQ/8kmr17WmqN/dXAWxQD60ERDMT02yUpbgudvJKE
         RmLEQwKIzP4ZesYli/aSIekOVlopFA6eEivfOUQGn5S1F0XoMlG2tfa+2/oqqeAbPJ+5
         GTX6/P7u55RGF/8eVSwK4ZKROwWmPOaknAqxQTLz5g/Iu27YRSrVHyyzl7dzR+OKmxoq
         rNVxUC+oWsrFt3Q987ZgU7X56QYVM1wmuiMGl3BPp0ykiTtAWIYFZMxzWens4O0zMlIb
         sIrA==
X-Gm-Message-State: AOJu0Yx1ClwMVp67b7LPjToJAc6pGW7c9eP9XURT1UpO589z+r4Di2sI
	4HUdrrczQEQQp7f7Q8dxx/qDEdW2JqDJP7Nh9YyXI1ih/edl6xx2oYBW3vN6zRutcoHmlRB4+EC
	p
X-Google-Smtp-Source: AGHT+IHyMfi4iD0ez1ukdQPff3t1SAZri5/6ou6jhE7+a7iMRaLnpX9X6A5u0x816xovw+65vVb3qg==
X-Received: by 2002:ac2:5924:0:b0:511:312d:6761 with SMTP id v4-20020ac25924000000b00511312d6761mr2535730lfi.47.1707654619524;
        Sun, 11 Feb 2024 04:30:19 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id fj18-20020a0564022b9200b0056187ca4120sm1024611edb.10.2024.02.11.04.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:19 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 08/35] maple_tree.h: move declarations to maple_tree_types.h
Date: Sun, 11 Feb 2024 13:29:33 +0100
Message-Id: <20240211123000.3359365-9-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211123000.3359365-1-max.kellermann@ionos.com>
References: <20240211123000.3359365-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By providing declarations in a lean header, we can reduce header
dependencies.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/maple_tree.h       | 323 +----------------------------
 include/linux/maple_tree_types.h | 341 +++++++++++++++++++++++++++++++
 include/linux/mm.h               |   1 +
 include/linux/mm_types.h         |   2 +-
 4 files changed, 345 insertions(+), 322 deletions(-)
 create mode 100644 include/linux/maple_tree_types.h

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index b3d63123b945..7f5dd33f4b94 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -8,147 +8,13 @@
  *              Matthew Wilcox <willy@infradead.org>
  */
 
+#include <linux/maple_tree_types.h>
+
 #include <linux/kernel.h>
 #include <linux/rcupdate.h>
 #include <linux/spinlock.h>
 /* #define CONFIG_MAPLE_RCU_DISABLED */
 
-/*
- * Allocated nodes are mutable until they have been inserted into the tree,
- * at which time they cannot change their type until they have been removed
- * from the tree and an RCU grace period has passed.
- *
- * Removed nodes have their ->parent set to point to themselves.  RCU readers
- * check ->parent before relying on the value that they loaded from the
- * slots array.  This lets us reuse the slots array for the RCU head.
- *
- * Nodes in the tree point to their parent unless bit 0 is set.
- */
-#if defined(CONFIG_64BIT) || defined(BUILD_VDSO32_64)
-/* 64bit sizes */
-#define MAPLE_NODE_SLOTS	31	/* 256 bytes including ->parent */
-#define MAPLE_RANGE64_SLOTS	16	/* 256 bytes */
-#define MAPLE_ARANGE64_SLOTS	10	/* 240 bytes */
-#define MAPLE_ALLOC_SLOTS	(MAPLE_NODE_SLOTS - 1)
-#else
-/* 32bit sizes */
-#define MAPLE_NODE_SLOTS	63	/* 256 bytes including ->parent */
-#define MAPLE_RANGE64_SLOTS	32	/* 256 bytes */
-#define MAPLE_ARANGE64_SLOTS	21	/* 240 bytes */
-#define MAPLE_ALLOC_SLOTS	(MAPLE_NODE_SLOTS - 2)
-#endif /* defined(CONFIG_64BIT) || defined(BUILD_VDSO32_64) */
-
-#define MAPLE_NODE_MASK		255UL
-
-/*
- * The node->parent of the root node has bit 0 set and the rest of the pointer
- * is a pointer to the tree itself.  No more bits are available in this pointer
- * (on m68k, the data structure may only be 2-byte aligned).
- *
- * Internal non-root nodes can only have maple_range_* nodes as parents.  The
- * parent pointer is 256B aligned like all other tree nodes.  When storing a 32
- * or 64 bit values, the offset can fit into 4 bits.  The 16 bit values need an
- * extra bit to store the offset.  This extra bit comes from a reuse of the last
- * bit in the node type.  This is possible by using bit 1 to indicate if bit 2
- * is part of the type or the slot.
- *
- * Once the type is decided, the decision of an allocation range type or a range
- * type is done by examining the immutable tree flag for the MAPLE_ALLOC_RANGE
- * flag.
- *
- *  Node types:
- *   0x??1 = Root
- *   0x?00 = 16 bit nodes
- *   0x010 = 32 bit nodes
- *   0x110 = 64 bit nodes
- *
- *  Slot size and location in the parent pointer:
- *   type  : slot location
- *   0x??1 : Root
- *   0x?00 : 16 bit values, type in 0-1, slot in 2-6
- *   0x010 : 32 bit values, type in 0-2, slot in 3-6
- *   0x110 : 64 bit values, type in 0-2, slot in 3-6
- */
-
-/*
- * This metadata is used to optimize the gap updating code and in reverse
- * searching for gaps or any other code that needs to find the end of the data.
- */
-struct maple_metadata {
-	unsigned char end;
-	unsigned char gap;
-};
-
-/*
- * Leaf nodes do not store pointers to nodes, they store user data.  Users may
- * store almost any bit pattern.  As noted above, the optimisation of storing an
- * entry at 0 in the root pointer cannot be done for data which have the bottom
- * two bits set to '10'.  We also reserve values with the bottom two bits set to
- * '10' which are below 4096 (ie 2, 6, 10 .. 4094) for internal use.  Some APIs
- * return errnos as a negative errno shifted right by two bits and the bottom
- * two bits set to '10', and while choosing to store these values in the array
- * is not an error, it may lead to confusion if you're testing for an error with
- * mas_is_err().
- *
- * Non-leaf nodes store the type of the node pointed to (enum maple_type in bits
- * 3-6), bit 2 is reserved.  That leaves bits 0-1 unused for now.
- *
- * In regular B-Tree terms, pivots are called keys.  The term pivot is used to
- * indicate that the tree is specifying ranges,  Pivots may appear in the
- * subtree with an entry attached to the value whereas keys are unique to a
- * specific position of a B-tree.  Pivot values are inclusive of the slot with
- * the same index.
- */
-
-struct maple_range_64 {
-	struct maple_pnode *parent;
-	unsigned long pivot[MAPLE_RANGE64_SLOTS - 1];
-	union {
-		void __rcu *slot[MAPLE_RANGE64_SLOTS];
-		struct {
-			void __rcu *pad[MAPLE_RANGE64_SLOTS - 1];
-			struct maple_metadata meta;
-		};
-	};
-};
-
-/*
- * At tree creation time, the user can specify that they're willing to trade off
- * storing fewer entries in a tree in return for storing more information in
- * each node.
- *
- * The maple tree supports recording the largest range of NULL entries available
- * in this node, also called gaps.  This optimises the tree for allocating a
- * range.
- */
-struct maple_arange_64 {
-	struct maple_pnode *parent;
-	unsigned long pivot[MAPLE_ARANGE64_SLOTS - 1];
-	void __rcu *slot[MAPLE_ARANGE64_SLOTS];
-	unsigned long gap[MAPLE_ARANGE64_SLOTS];
-	struct maple_metadata meta;
-};
-
-struct maple_alloc {
-	unsigned long total;
-	unsigned char node_count;
-	unsigned int request_count;
-	struct maple_alloc *slot[MAPLE_ALLOC_SLOTS];
-};
-
-struct maple_topiary {
-	struct maple_pnode *parent;
-	struct maple_enode *next; /* Overlaps the pivot */
-};
-
-enum maple_type {
-	maple_dense,
-	maple_leaf_64,
-	maple_range_64,
-	maple_arange_64,
-};
-
-
 /**
  * DOC: Maple tree flags
  *
@@ -181,7 +47,6 @@ enum maple_type {
 #define MAPLE_RESERVED_RANGE	4096
 
 #ifdef CONFIG_LOCKDEP
-typedef struct lockdep_map *lockdep_map_p;
 #define mt_lock_is_held(mt)                                             \
 	(!(mt)->ma_external_lock || lock_is_held((mt)->ma_external_lock))
 
@@ -194,36 +59,12 @@ typedef struct lockdep_map *lockdep_map_p;
 
 #define mt_on_stack(mt)			(mt).ma_external_lock = NULL
 #else
-typedef struct { /* nothing */ } lockdep_map_p;
 #define mt_lock_is_held(mt)		1
 #define mt_write_lock_is_held(mt)	1
 #define mt_set_external_lock(mt, lock)	do { } while (0)
 #define mt_on_stack(mt)			do { } while (0)
 #endif
 
-/*
- * If the tree contains a single entry at index 0, it is usually stored in
- * tree->ma_root.  To optimise for the page cache, an entry which ends in '00',
- * '01' or '11' is stored in the root, but an entry which ends in '10' will be
- * stored in a node.  Bits 3-6 are used to store enum maple_type.
- *
- * The flags are used both to store some immutable information about this tree
- * (set at tree creation time) and dynamic information set under the spinlock.
- *
- * Another use of flags are to indicate global states of the tree.  This is the
- * case with the MAPLE_USE_RCU flag, which indicates the tree is currently in
- * RCU mode.  This mode was added to allow the tree to reuse nodes instead of
- * re-allocating and RCU freeing nodes when there is a single user.
- */
-struct maple_tree {
-	union {
-		spinlock_t	ma_lock;
-		lockdep_map_p	ma_external_lock;
-	};
-	unsigned int	ma_flags;
-	void __rcu      *ma_root;
-};
-
 /**
  * MTREE_INIT() - Initialize a maple tree
  * @name: The maple tree name
@@ -260,56 +101,6 @@ struct maple_tree {
 		spin_lock_nested((&(mt)->ma_lock), subclass)
 #define mtree_unlock(mt)	spin_unlock((&(mt)->ma_lock))
 
-/*
- * The Maple Tree squeezes various bits in at various points which aren't
- * necessarily obvious.  Usually, this is done by observing that pointers are
- * N-byte aligned and thus the bottom log_2(N) bits are available for use.  We
- * don't use the high bits of pointers to store additional information because
- * we don't know what bits are unused on any given architecture.
- *
- * Nodes are 256 bytes in size and are also aligned to 256 bytes, giving us 8
- * low bits for our own purposes.  Nodes are currently of 4 types:
- * 1. Single pointer (Range is 0-0)
- * 2. Non-leaf Allocation Range nodes
- * 3. Non-leaf Range nodes
- * 4. Leaf Range nodes All nodes consist of a number of node slots,
- *    pivots, and a parent pointer.
- */
-
-struct maple_node {
-	union {
-		struct {
-			struct maple_pnode *parent;
-			void __rcu *slot[MAPLE_NODE_SLOTS];
-		};
-		struct {
-			void *pad;
-			struct rcu_head rcu;
-			struct maple_enode *piv_parent;
-			unsigned char parent_slot;
-			enum maple_type type;
-			unsigned char slot_len;
-			unsigned int ma_flags;
-		};
-		struct maple_range_64 mr64;
-		struct maple_arange_64 ma64;
-		struct maple_alloc alloc;
-	};
-};
-
-/*
- * More complicated stores can cause two nodes to become one or three and
- * potentially alter the height of the tree.  Either half of the tree may need
- * to be rebalanced against the other.  The ma_topiary struct is used to track
- * which nodes have been 'cut' from the tree so that the change can be done
- * safely at a later date.  This is done to support RCU.
- */
-struct ma_topiary {
-	struct maple_enode *head;
-	struct maple_enode *tail;
-	struct maple_tree *mtree;
-};
-
 void *mtree_load(struct maple_tree *mt, unsigned long index);
 
 int mtree_insert(struct maple_tree *mt, unsigned long index,
@@ -349,105 +140,6 @@ static inline bool mtree_empty(const struct maple_tree *mt)
 
 /* Advanced API */
 
-/*
- * Maple State Status
- * ma_active means the maple state is pointing to a node and offset and can
- * continue operating on the tree.
- * ma_start means we have not searched the tree.
- * ma_root means we have searched the tree and the entry we found lives in
- * the root of the tree (ie it has index 0, length 1 and is the only entry in
- * the tree).
- * ma_none means we have searched the tree and there is no node in the
- * tree for this entry.  For example, we searched for index 1 in an empty
- * tree.  Or we have a tree which points to a full leaf node and we
- * searched for an entry which is larger than can be contained in that
- * leaf node.
- * ma_pause means the data within the maple state may be stale, restart the
- * operation
- * ma_overflow means the search has reached the upper limit of the search
- * ma_underflow means the search has reached the lower limit of the search
- * ma_error means there was an error, check the node for the error number.
- */
-enum maple_status {
-	ma_active,
-	ma_start,
-	ma_root,
-	ma_none,
-	ma_pause,
-	ma_overflow,
-	ma_underflow,
-	ma_error,
-};
-
-/*
- * The maple state is defined in the struct ma_state and is used to keep track
- * of information during operations, and even between operations when using the
- * advanced API.
- *
- * If state->node has bit 0 set then it references a tree location which is not
- * a node (eg the root).  If bit 1 is set, the rest of the bits are a negative
- * errno.  Bit 2 (the 'unallocated slots' bit) is clear.  Bits 3-6 indicate the
- * node type.
- *
- * state->alloc either has a request number of nodes or an allocated node.  If
- * stat->alloc has a requested number of nodes, the first bit will be set (0x1)
- * and the remaining bits are the value.  If state->alloc is a node, then the
- * node will be of type maple_alloc.  maple_alloc has MAPLE_NODE_SLOTS - 1 for
- * storing more allocated nodes, a total number of nodes allocated, and the
- * node_count in this node.  node_count is the number of allocated nodes in this
- * node.  The scaling beyond MAPLE_NODE_SLOTS - 1 is handled by storing further
- * nodes into state->alloc->slot[0]'s node.  Nodes are taken from state->alloc
- * by removing a node from the state->alloc node until state->alloc->node_count
- * is 1, when state->alloc is returned and the state->alloc->slot[0] is promoted
- * to state->alloc.  Nodes are pushed onto state->alloc by putting the current
- * state->alloc into the pushed node's slot[0].
- *
- * The state also contains the implied min/max of the state->node, the depth of
- * this search, and the offset. The implied min/max are either from the parent
- * node or are 0-oo for the root node.  The depth is incremented or decremented
- * every time a node is walked down or up.  The offset is the slot/pivot of
- * interest in the node - either for reading or writing.
- *
- * When returning a value the maple state index and last respectively contain
- * the start and end of the range for the entry.  Ranges are inclusive in the
- * Maple Tree.
- *
- * The status of the state is used to determine how the next action should treat
- * the state.  For instance, if the status is ma_start then the next action
- * should start at the root of the tree and walk down.  If the status is
- * ma_pause then the node may be stale data and should be discarded.  If the
- * status is ma_overflow, then the last action hit the upper limit.
- *
- */
-struct ma_state {
-	struct maple_tree *tree;	/* The tree we're operating in */
-	unsigned long index;		/* The index we're operating on - range start */
-	unsigned long last;		/* The last index we're operating on - range end */
-	struct maple_enode *node;	/* The node containing this entry */
-	unsigned long min;		/* The minimum index of this node - implied pivot min */
-	unsigned long max;		/* The maximum index of this node - implied pivot max */
-	struct maple_alloc *alloc;	/* Allocated nodes for this operation */
-	enum maple_status status;	/* The status of the state (active, start, none, etc) */
-	unsigned char depth;		/* depth of tree descent during write */
-	unsigned char offset;
-	unsigned char mas_flags;
-	unsigned char end;		/* The end of the node */
-};
-
-struct ma_wr_state {
-	struct ma_state *mas;
-	struct maple_node *node;	/* Decoded mas->node */
-	unsigned long r_min;		/* range min */
-	unsigned long r_max;		/* range max */
-	enum maple_type type;		/* mas->node type */
-	unsigned char offset_end;	/* The offset where the write ends */
-	unsigned long *pivots;		/* mas->node->pivots pointer */
-	unsigned long end_piv;		/* The pivot at the offset end */
-	void __rcu **slots;		/* mas->node->slots pointer */
-	void *entry;			/* The entry to write */
-	void *content;			/* The existing entry that is being overwritten */
-};
-
 #define mas_lock(mas)           spin_lock(&((mas)->tree->ma_lock))
 #define mas_lock_nested(mas, subclass) \
 		spin_lock_nested(&((mas)->tree->ma_lock), subclass)
@@ -520,17 +212,6 @@ int mas_empty_area(struct ma_state *mas, unsigned long min, unsigned long max,
 int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 		       unsigned long max, unsigned long size);
 
-static inline void mas_init(struct ma_state *mas, struct maple_tree *tree,
-			    unsigned long addr)
-{
-	memset(mas, 0, sizeof(struct ma_state));
-	mas->tree = tree;
-	mas->index = mas->last = addr;
-	mas->max = ULONG_MAX;
-	mas->status = ma_start;
-	mas->node = NULL;
-}
-
 static inline bool mas_is_active(struct ma_state *mas)
 {
 	return mas->status == ma_active;
diff --git a/include/linux/maple_tree_types.h b/include/linux/maple_tree_types.h
new file mode 100644
index 000000000000..fe13414f239d
--- /dev/null
+++ b/include/linux/maple_tree_types.h
@@ -0,0 +1,341 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef _LINUX_MAPLE_TREE_TYPES_H
+#define _LINUX_MAPLE_TREE_TYPES_H
+/*
+ * Maple Tree - An RCU-safe adaptive tree for storing ranges
+ * Copyright (c) 2018-2022 Oracle
+ * Authors:     Liam R. Howlett <Liam.Howlett@Oracle.com>
+ *              Matthew Wilcox <willy@infradead.org>
+ */
+
+#include <linux/spinlock_types.h>
+#include <linux/string.h> // for memset()
+#include <linux/limits.h> // for ULONG_MAX
+
+/*
+ * Allocated nodes are mutable until they have been inserted into the tree,
+ * at which time they cannot change their type until they have been removed
+ * from the tree and an RCU grace period has passed.
+ *
+ * Removed nodes have their ->parent set to point to themselves.  RCU readers
+ * check ->parent before relying on the value that they loaded from the
+ * slots array.  This lets us reuse the slots array for the RCU head.
+ *
+ * Nodes in the tree point to their parent unless bit 0 is set.
+ */
+#if defined(CONFIG_64BIT) || defined(BUILD_VDSO32_64)
+/* 64bit sizes */
+#define MAPLE_NODE_SLOTS	31	/* 256 bytes including ->parent */
+#define MAPLE_RANGE64_SLOTS	16	/* 256 bytes */
+#define MAPLE_ARANGE64_SLOTS	10	/* 240 bytes */
+#define MAPLE_ALLOC_SLOTS	(MAPLE_NODE_SLOTS - 1)
+#else
+/* 32bit sizes */
+#define MAPLE_NODE_SLOTS	63	/* 256 bytes including ->parent */
+#define MAPLE_RANGE64_SLOTS	32	/* 256 bytes */
+#define MAPLE_ARANGE64_SLOTS	21	/* 240 bytes */
+#define MAPLE_ALLOC_SLOTS	(MAPLE_NODE_SLOTS - 2)
+#endif /* defined(CONFIG_64BIT) || defined(BUILD_VDSO32_64) */
+
+#define MAPLE_NODE_MASK		255UL
+
+/*
+ * The node->parent of the root node has bit 0 set and the rest of the pointer
+ * is a pointer to the tree itself.  No more bits are available in this pointer
+ * (on m68k, the data structure may only be 2-byte aligned).
+ *
+ * Internal non-root nodes can only have maple_range_* nodes as parents.  The
+ * parent pointer is 256B aligned like all other tree nodes.  When storing a 32
+ * or 64 bit values, the offset can fit into 4 bits.  The 16 bit values need an
+ * extra bit to store the offset.  This extra bit comes from a reuse of the last
+ * bit in the node type.  This is possible by using bit 1 to indicate if bit 2
+ * is part of the type or the slot.
+ *
+ * Once the type is decided, the decision of an allocation range type or a range
+ * type is done by examining the immutable tree flag for the MAPLE_ALLOC_RANGE
+ * flag.
+ *
+ *  Node types:
+ *   0x??1 = Root
+ *   0x?00 = 16 bit nodes
+ *   0x010 = 32 bit nodes
+ *   0x110 = 64 bit nodes
+ *
+ *  Slot size and location in the parent pointer:
+ *   type  : slot location
+ *   0x??1 : Root
+ *   0x?00 : 16 bit values, type in 0-1, slot in 2-6
+ *   0x010 : 32 bit values, type in 0-2, slot in 3-6
+ *   0x110 : 64 bit values, type in 0-2, slot in 3-6
+ */
+
+/*
+ * This metadata is used to optimize the gap updating code and in reverse
+ * searching for gaps or any other code that needs to find the end of the data.
+ */
+struct maple_metadata {
+	unsigned char end;
+	unsigned char gap;
+};
+
+/*
+ * Leaf nodes do not store pointers to nodes, they store user data.  Users may
+ * store almost any bit pattern.  As noted above, the optimisation of storing an
+ * entry at 0 in the root pointer cannot be done for data which have the bottom
+ * two bits set to '10'.  We also reserve values with the bottom two bits set to
+ * '10' which are below 4096 (ie 2, 6, 10 .. 4094) for internal use.  Some APIs
+ * return errnos as a negative errno shifted right by two bits and the bottom
+ * two bits set to '10', and while choosing to store these values in the array
+ * is not an error, it may lead to confusion if you're testing for an error with
+ * mas_is_err().
+ *
+ * Non-leaf nodes store the type of the node pointed to (enum maple_type in bits
+ * 3-6), bit 2 is reserved.  That leaves bits 0-1 unused for now.
+ *
+ * In regular B-Tree terms, pivots are called keys.  The term pivot is used to
+ * indicate that the tree is specifying ranges,  Pivots may appear in the
+ * subtree with an entry attached to the value whereas keys are unique to a
+ * specific position of a B-tree.  Pivot values are inclusive of the slot with
+ * the same index.
+ */
+
+struct maple_range_64 {
+	struct maple_pnode *parent;
+	unsigned long pivot[MAPLE_RANGE64_SLOTS - 1];
+	union {
+		void __rcu *slot[MAPLE_RANGE64_SLOTS];
+		struct {
+			void __rcu *pad[MAPLE_RANGE64_SLOTS - 1];
+			struct maple_metadata meta;
+		};
+	};
+};
+
+/*
+ * At tree creation time, the user can specify that they're willing to trade off
+ * storing fewer entries in a tree in return for storing more information in
+ * each node.
+ *
+ * The maple tree supports recording the largest range of NULL entries available
+ * in this node, also called gaps.  This optimises the tree for allocating a
+ * range.
+ */
+struct maple_arange_64 {
+	struct maple_pnode *parent;
+	unsigned long pivot[MAPLE_ARANGE64_SLOTS - 1];
+	void __rcu *slot[MAPLE_ARANGE64_SLOTS];
+	unsigned long gap[MAPLE_ARANGE64_SLOTS];
+	struct maple_metadata meta;
+};
+
+struct maple_alloc {
+	unsigned long total;
+	unsigned char node_count;
+	unsigned int request_count;
+	struct maple_alloc *slot[MAPLE_ALLOC_SLOTS];
+};
+
+struct maple_topiary {
+	struct maple_pnode *parent;
+	struct maple_enode *next; /* Overlaps the pivot */
+};
+
+enum maple_type {
+	maple_dense,
+	maple_leaf_64,
+	maple_range_64,
+	maple_arange_64,
+};
+
+#ifdef CONFIG_LOCKDEP
+typedef struct lockdep_map *lockdep_map_p;
+#else
+typedef struct { /* nothing */ } lockdep_map_p;
+#endif
+
+/*
+ * If the tree contains a single entry at index 0, it is usually stored in
+ * tree->ma_root.  To optimise for the page cache, an entry which ends in '00',
+ * '01' or '11' is stored in the root, but an entry which ends in '10' will be
+ * stored in a node.  Bits 3-6 are used to store enum maple_type.
+ *
+ * The flags are used both to store some immutable information about this tree
+ * (set at tree creation time) and dynamic information set under the spinlock.
+ *
+ * Another use of flags are to indicate global states of the tree.  This is the
+ * case with the MAPLE_USE_RCU flag, which indicates the tree is currently in
+ * RCU mode.  This mode was added to allow the tree to reuse nodes instead of
+ * re-allocating and RCU freeing nodes when there is a single user.
+ */
+struct maple_tree {
+	union {
+		spinlock_t	ma_lock;
+		lockdep_map_p	ma_external_lock;
+	};
+	unsigned int	ma_flags;
+	void __rcu      *ma_root;
+};
+
+/*
+ * The Maple Tree squeezes various bits in at various points which aren't
+ * necessarily obvious.  Usually, this is done by observing that pointers are
+ * N-byte aligned and thus the bottom log_2(N) bits are available for use.  We
+ * don't use the high bits of pointers to store additional information because
+ * we don't know what bits are unused on any given architecture.
+ *
+ * Nodes are 256 bytes in size and are also aligned to 256 bytes, giving us 8
+ * low bits for our own purposes.  Nodes are currently of 4 types:
+ * 1. Single pointer (Range is 0-0)
+ * 2. Non-leaf Allocation Range nodes
+ * 3. Non-leaf Range nodes
+ * 4. Leaf Range nodes All nodes consist of a number of node slots,
+ *    pivots, and a parent pointer.
+ */
+
+struct maple_node {
+	union {
+		struct {
+			struct maple_pnode *parent;
+			void __rcu *slot[MAPLE_NODE_SLOTS];
+		};
+		struct {
+			void *pad;
+			struct rcu_head rcu;
+			struct maple_enode *piv_parent;
+			unsigned char parent_slot;
+			enum maple_type type;
+			unsigned char slot_len;
+			unsigned int ma_flags;
+		};
+		struct maple_range_64 mr64;
+		struct maple_arange_64 ma64;
+		struct maple_alloc alloc;
+	};
+};
+
+/*
+ * More complicated stores can cause two nodes to become one or three and
+ * potentially alter the height of the tree.  Either half of the tree may need
+ * to be rebalanced against the other.  The ma_topiary struct is used to track
+ * which nodes have been 'cut' from the tree so that the change can be done
+ * safely at a later date.  This is done to support RCU.
+ */
+struct ma_topiary {
+	struct maple_enode *head;
+	struct maple_enode *tail;
+	struct maple_tree *mtree;
+};
+
+/* Advanced API */
+
+/*
+ * Maple State Status
+ * ma_active means the maple state is pointing to a node and offset and can
+ * continue operating on the tree.
+ * ma_start means we have not searched the tree.
+ * ma_root means we have searched the tree and the entry we found lives in
+ * the root of the tree (ie it has index 0, length 1 and is the only entry in
+ * the tree).
+ * ma_none means we have searched the tree and there is no node in the
+ * tree for this entry.  For example, we searched for index 1 in an empty
+ * tree.  Or we have a tree which points to a full leaf node and we
+ * searched for an entry which is larger than can be contained in that
+ * leaf node.
+ * ma_pause means the data within the maple state may be stale, restart the
+ * operation
+ * ma_overflow means the search has reached the upper limit of the search
+ * ma_underflow means the search has reached the lower limit of the search
+ * ma_error means there was an error, check the node for the error number.
+ */
+enum maple_status {
+	ma_active,
+	ma_start,
+	ma_root,
+	ma_none,
+	ma_pause,
+	ma_overflow,
+	ma_underflow,
+	ma_error,
+};
+
+/*
+ * The maple state is defined in the struct ma_state and is used to keep track
+ * of information during operations, and even between operations when using the
+ * advanced API.
+ *
+ * If state->node has bit 0 set then it references a tree location which is not
+ * a node (eg the root).  If bit 1 is set, the rest of the bits are a negative
+ * errno.  Bit 2 (the 'unallocated slots' bit) is clear.  Bits 3-6 indicate the
+ * node type.
+ *
+ * state->alloc either has a request number of nodes or an allocated node.  If
+ * stat->alloc has a requested number of nodes, the first bit will be set (0x1)
+ * and the remaining bits are the value.  If state->alloc is a node, then the
+ * node will be of type maple_alloc.  maple_alloc has MAPLE_NODE_SLOTS - 1 for
+ * storing more allocated nodes, a total number of nodes allocated, and the
+ * node_count in this node.  node_count is the number of allocated nodes in this
+ * node.  The scaling beyond MAPLE_NODE_SLOTS - 1 is handled by storing further
+ * nodes into state->alloc->slot[0]'s node.  Nodes are taken from state->alloc
+ * by removing a node from the state->alloc node until state->alloc->node_count
+ * is 1, when state->alloc is returned and the state->alloc->slot[0] is promoted
+ * to state->alloc.  Nodes are pushed onto state->alloc by putting the current
+ * state->alloc into the pushed node's slot[0].
+ *
+ * The state also contains the implied min/max of the state->node, the depth of
+ * this search, and the offset. The implied min/max are either from the parent
+ * node or are 0-oo for the root node.  The depth is incremented or decremented
+ * every time a node is walked down or up.  The offset is the slot/pivot of
+ * interest in the node - either for reading or writing.
+ *
+ * When returning a value the maple state index and last respectively contain
+ * the start and end of the range for the entry.  Ranges are inclusive in the
+ * Maple Tree.
+ *
+ * The status of the state is used to determine how the next action should treat
+ * the state.  For instance, if the status is ma_start then the next action
+ * should start at the root of the tree and walk down.  If the status is
+ * ma_pause then the node may be stale data and should be discarded.  If the
+ * status is ma_overflow, then the last action hit the upper limit.
+ *
+ */
+struct ma_state {
+	struct maple_tree *tree;	/* The tree we're operating in */
+	unsigned long index;		/* The index we're operating on - range start */
+	unsigned long last;		/* The last index we're operating on - range end */
+	struct maple_enode *node;	/* The node containing this entry */
+	unsigned long min;		/* The minimum index of this node - implied pivot min */
+	unsigned long max;		/* The maximum index of this node - implied pivot max */
+	struct maple_alloc *alloc;	/* Allocated nodes for this operation */
+	enum maple_status status;	/* The status of the state (active, start, none, etc) */
+	unsigned char depth;		/* depth of tree descent during write */
+	unsigned char offset;
+	unsigned char mas_flags;
+	unsigned char end;		/* The end of the node */
+};
+
+struct ma_wr_state {
+	struct ma_state *mas;
+	struct maple_node *node;	/* Decoded mas->node */
+	unsigned long r_min;		/* range min */
+	unsigned long r_max;		/* range max */
+	enum maple_type type;		/* mas->node type */
+	unsigned char offset_end;	/* The offset where the write ends */
+	unsigned long *pivots;		/* mas->node->pivots pointer */
+	unsigned long end_piv;		/* The pivot at the offset end */
+	void __rcu **slots;		/* mas->node->slots pointer */
+	void *entry;			/* The entry to write */
+	void *content;			/* The existing entry that is being overwritten */
+};
+
+static inline void mas_init(struct ma_state *mas, struct maple_tree *tree,
+			    unsigned long addr)
+{
+	memset(mas, 0, sizeof(struct ma_state));
+	mas->tree = tree;
+	mas->index = mas->last = addr;
+	mas->max = ULONG_MAX;
+	mas->status = ma_start;
+	mas->node = NULL;
+}
+
+#endif /*_LINUX_MAPLE_TREE_TYPES_H */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 95c29b8f573d..0e6bdce6e4e8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -13,6 +13,7 @@
 #include <linux/debug_locks.h>
 #include <linux/mm_types.h>
 #include <linux/mmap_lock.h>
+#include <linux/maple_tree.h>
 #include <linux/range.h>
 #include <linux/pfn.h>
 #include <linux/bit_spinlock.h>
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e44ef7852019..ff5d33ace0f9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -11,7 +11,7 @@
 #include <linux/list.h>
 #include <linux/spinlock_types.h>
 #include <linux/rbtree_types.h>
-#include <linux/maple_tree.h>
+#include <linux/maple_tree_types.h>
 #include <linux/rwsem.h>
 #include <linux/cpumask.h>
 #include <linux/uprobes.h>
-- 
2.39.2


