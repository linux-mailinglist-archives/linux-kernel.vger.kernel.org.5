Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12047C5E96
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376351AbjJKUoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjJKUoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:44:07 -0400
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A61E90;
        Wed, 11 Oct 2023 13:44:03 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-5a7c08b7744so3355117b3.3;
        Wed, 11 Oct 2023 13:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697057042; x=1697661842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TEu2nxzdjrozp82JZwjJ2Z/IX8GNfCovktbioAc6Ivw=;
        b=dKQ4tReEzM+hPDp0Syu/X3awTrJ6MvYaMNgHbuDTMV131ABjDmi9QGHttvexy84CVg
         yMoMCc9CzxfBIqdxbp9b8VKmumLEKaTYRhEPei9c509GRubw0CrV4sg3EC/eZq6LKw6K
         v5XjLbPbG/hYw2WMZPV4TSZqaWTjRUOfyqwyVcYp1XQ1rlRLgaV1TXa4QSEUedOjeKRn
         O+eaTRWOP1NaLk+CeHYB0hfRweuCyRifHRrSJfTd6juoZdVGaVhz9QargkWJdNwH8CTW
         zeLNNE2lFdKe12+YCorB/A0fJDO2HP6pTbEwcqlCEiXqkOE6vgIacswgga/JMXS07jTs
         uc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697057042; x=1697661842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TEu2nxzdjrozp82JZwjJ2Z/IX8GNfCovktbioAc6Ivw=;
        b=tUh9D13mz4aP7KZwOUrIXWxh7q5n6cQ4yeBc+oWvC2WNRaO0+UjPhc13ULH1OeX9sO
         peVttlW/MQrwbtMhPYIVCC0Cl17llxM7QGAo8OKh5zlc/CcQBwmbFojEALneOVvj+cZw
         REXFQJLlTg3Y+oUys4nf28K+nujadC7qwS490sLJUz8qMCVX07uIfjPb4tS0xtiCn4Lj
         ARvez4nRfP5j2dW/PF3hJ/UyekHpPd8WVqx1gUowLJ1ju9IgWtH0XTZVUHEK9RMuFsxL
         6G3JDksdvAqnKZ1gXx4lmAk9clMPTtI/ZXDBJP49B/J5bTd58g/Bh9YalD9VOtY0c8Gd
         Plew==
X-Gm-Message-State: AOJu0YwJPA1EFV9NX/xtc147iFkDOR/fkvbYl2DGDgUj95NMNIBnAWyF
        Eaj6Ft8eFblNo8WQF5+ijQ==
X-Google-Smtp-Source: AGHT+IE+Ov/9UKHtGIN2HQ6O3ziPnP2i9l6R9GNRJ0PJ4WCq209SNH4jBa98cpw3Ij5HnAg6OvfDLg==
X-Received: by 2002:a81:49d0:0:b0:586:9f6c:41a0 with SMTP id w199-20020a8149d0000000b005869f6c41a0mr24595805ywa.14.1697057042368;
        Wed, 11 Oct 2023 13:44:02 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id q2-20020a819902000000b0059bc0d766f8sm1844588ywg.34.2023.10.11.13.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 13:44:01 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        akpm@linux-foundation.org, sthanneeru@micron.com,
        ying.huang@intel.com, gregory.price@memverge.com
Subject: [RFC PATCH v2 0/3] mm: mempolicy: Multi-tier weighted interleaving
Date:   Mon,  9 Oct 2023 16:42:56 -0400
Message-Id: <20231009204259.875232-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: change memtier mutex to semaphore
    add source-node relative weighting
    add remaining mempolicy integration code

= v2 Notes

Developed in colaboration with original authors to deconflict
similar efforts to extend mempolicy to take weights directly.

== Mutex to Semaphore change:

The memory tiering subsystem is extended in this patch set to have
externally available information (weights), and therefore additional
controls need to be added to ensure values are not changed (or tiers
changed/added/removed) during various calculations.

Since it is expected that many threads will be accessing this data
during allocations, a mutex is not appropriate.

Since write-updates (weight changes, hotplug events) are rare events,
a simple rw semaphore is sufficient.

== Source-node relative weighting:

Tiers can now be weighted differently based on the node requesting
the weight.  For example CPU-Nodes 0 and 1 may have different weights
for the same CXL memory tier, because topologically the number of
NUMA hops is greater (or any other physical topological difference
resulting in different effective latency or bandwidth values)

1. Set weights for DDR (tier4) and CXL(teir22) tiers.
   echo source_node:weight > /path/to/interleave_weight

# Set tier4 weight from node 0 to 85
echo 0:85 > /sys/devices/virtual/memory_tiering/memory_tier4/interleave_weight
# Set tier4 weight from node 1 to 65
echo 1:65 > /sys/devices/virtual/memory_tiering/memory_tier4/interleave_weight
# Set tier22 weight from node 0 to 15
echo 0:15 > /sys/devices/virtual/memory_tiering/memory_tier22/interleave_weight
# Set tier22 weight from node 1 to 10
echo 1:10 > /sys/devices/virtual/memory_tiering/memory_tier22/interleave_weight

== Mempolicy integration

Two new functions have been added to memory-tiers.c
* memtier_get_node_weight
  - Get the effective weight for a given node
* memtier_get_total_weight
  - Get the "total effective weight" for a given nodemask.

These functions are used by the following functions in mempolicy:
* interleave_nodes
* offset_il_nodes
* alloc_pages_bulk_array_interleave

The weight values are used to determine how many pages should be
allocated per-node as interleave rounds occur.

To avoid holding the memtier semaphore for long periods of time
(e.g. during the calls that actually allocate pages), there is
a small race condition during bulk allocation between calculating
the total weight of a node mask and fetching each individual
node weight - but this is managed by simply detecting the over/under
allocation conditions and handling them accordingly.

~Gregory

=== original RFC ====

From: Ravi Shankar <ravis.opensrc@micron.com>

Hello,

The current interleave policy operates by interleaving page requests
among nodes defined in the memory policy. To accommodate the
introduction of memory tiers for various memory types (e.g., DDR, CXL,
HBM, PMEM, etc.), a mechanism is needed for interleaving page requests
across these memory types or tiers.

This can be achieved by implementing an interleaving method that
considers the tier weights.
The tier weight will determine the proportion of nodes to select from
those specified in the memory policy.
A tier weight can be assigned to each memory type within the system.

Hasan Al Maruf had put forth a proposal for interleaving between two
tiers, namely the top tier and the low tier. However, this patch was
not adopted due to constraints on the number of available tiers.

https://lore.kernel.org/linux-mm/YqD0%2FtzFwXvJ1gK6@cmpxchg.org/T/

New proposed changes:

1. Introducea sysfs entry to allow setting the interleave weight for each
memory tier.
2. Each tier with a default weight of 1, indicating a standard 1:1
proportion.
3. Distribute the weight of that tier in a uniform manner across all nodes.
4. Modifications to the existing interleaving algorithm to support the
implementation of multi-tier interleaving based on tier-weights.

This is inline with Huang, Ying's presentation in lpc22, 16th slide in
https://lpc.events/event/16/contributions/1209/attachments/1042/1995/\
Live%20In%20a%20World%20With%20Multiple%20Memory%20Types.pdf

Observed a significant increase (165%) in bandwidth utilization
with the newly proposed multi-tier interleaving compared to the
traditional 1:1 interleaving approach between DDR and CXL tier nodes,
where 85% of the bandwidth is allocated to DDR tier and 15% to CXL
tier with MLC -w2 option.

Usage Example:

1. Set weights for DDR (tier4) and CXL(teir22) tiers.
echo 85 > /sys/devices/virtual/memory_tiering/memory_tier4/interleave_weight
echo 15 > /sys/devices/virtual/memory_tiering/memory_tier22/interleave_weight

2. Interleave between DRR(tier4, node-0) and CXL (tier22, node-1) using numactl
numactl -i0,1 mlc --loaded_latency W2

Gregory Price (3):
  mm/memory-tiers: change mutex to rw semaphore
  mm/memory-tiers: Introduce sysfs for tier interleave weights
  mm/mempolicy: modify interleave mempolicy to use memtier weights

 include/linux/memory-tiers.h |  16 ++++
 include/linux/mempolicy.h    |   3 +
 mm/memory-tiers.c            | 179 +++++++++++++++++++++++++++++++----
 mm/mempolicy.c               | 148 +++++++++++++++++++++++------
 4 files changed, 297 insertions(+), 49 deletions(-)

-- 
2.39.1

