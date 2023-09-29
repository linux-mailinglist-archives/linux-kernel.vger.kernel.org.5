Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418947B3B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjI2Uqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjI2Uq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:46:29 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84E210FD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 13:46:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-533e7d127d4so14453244a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 13:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1696020369; x=1696625169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2yGAxuVKjY9UBujT4OAOdn19ZrVW60t9TCfWwMCN4oY=;
        b=VVo/a+tB+7+4lgQXBl+8eyl6XzXAZmhQACvq0kKqh3Od3Q6cDaNPHS39Akrm1MqBon
         nV2lBb1BHpSWhWINbyX5EjRaDEF3LteqrKZC+j3CxPcUU81GFw5JiUVOR7l7DEQAqqms
         TNY0jGUGOb+qtzaVK/i9b/zhN/nhxydG49CK5qmX4ovhC3fTHUipT8+rsnBrRBa/9vqX
         HYEjWofz1hJI2FgZcWsWcNrpo8L+MkwYY11J9M5PLJj4Fq6Yxx+MqH+GiK4jHkBL7/e9
         YWEVRDIWPeMuU1TYFkjkGXjR4JUrDqbfVPgT9thZOR3QXx/FhkZCaap2mkpqml+A/OTD
         XwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696020369; x=1696625169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yGAxuVKjY9UBujT4OAOdn19ZrVW60t9TCfWwMCN4oY=;
        b=S587ptD0PKgHAgva5hzKOmtQ+7egFSthAY0cFDBPqNgh8pgUeVIGMiAGWC0qCxgZdP
         2gAM+tJ2fSmI8jsf43reb0IYfJvzaL7wvOsh5dPKa6vw3avUswuENaMT5m94wOUv75ka
         L4YgfDJ1wiuawnqolSXUccvpc7w0PBcNpSFYIVR7cINUNUGJ+wysjUq3NSLOZa/B30tk
         zGE3W2Ey40OLO5HnW+ZMrCKsmO+E1HNBxAUWgFh84pl+oD7A9+pWgnm+NCtIbn25kvJ6
         Doh35qcQaW2XuqfVfMB9EJrEDXeUT6kObUqLmGZbfFZMAUSIJxQsg5EOjw9OWdY/OJST
         G/AQ==
X-Gm-Message-State: AOJu0YywDcCZYnY4VMUvUHY7bltBuz98znqVmjxBCC+9K6pnoemzGNSG
        NUeZ/hMs2Rv0H5YWsKHp84SwJg==
X-Google-Smtp-Source: AGHT+IE0gLPCF4g8lR+4hgIf2TUj8oDAE99VhMfHP4X4Li5AlGHPuhZlE+Qk+QtDK+aaf0qetoPihA==
X-Received: by 2002:aa7:df93:0:b0:526:9cfb:c12 with SMTP id b19-20020aa7df93000000b005269cfb0c12mr5189031edy.38.1696020369248;
        Fri, 29 Sep 2023 13:46:09 -0700 (PDT)
Received: from cloudflare.com (79.184.153.47.ipv4.supernova.orange.pl. [79.184.153.47])
        by smtp.gmail.com with ESMTPSA id d19-20020aa7c1d3000000b0053660f76dbbsm1857623edp.10.2023.09.29.13.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 13:46:08 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     virtualization@lists.linux-foundation.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH 0/2] Support multiple interrupts for virtio over MMIO devices
Date:   Fri, 29 Sep 2023 22:46:02 +0200
Message-ID: <20230929-jakub-os-90-trim-v1-0-a3af0c08f812@cloudflare.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

# Intro

This patch set enables virtio-mmio devices to use multiple interrupts.

The elevator pitch would be:

"""
To keep the complexity down to a minimum, but at the same time get to the
same performance level as virtio-pci devices, we:

1) keep using the legacy interrupts, and
2) have a predefined, device type specific, mapping of IRQs to virtqueues,
3) rely on vhost offload for both data and notifications (irqfd/ioeventfd).
"""

As this is an RFC, we aim to (i) present our use-case, and (ii) get an idea
if we are going in the right direction.

Otherwise we have kept changes down to a working minimum, where we can
already demonstrate the performance benefits.

At this point, we did not:
- draft any change proposals to VIRTIO spec, or
- added support for other virtio-mmio driver "configuration backends" than
  the kernel command line (that is ACPI and DT).

# Motivation

This work aims to enable lightweight VMs (like QEMU microvm, Firecracker,
Cloud Hypervisor), which rely on virtio MMIO transport, to utilize
multi-queue virtio NIC to their full potential when multiple vCPUs are
available.

Currently with MMIO transport, it is not possible to process vNIC queue
events in parallel because there is just one interrupt perf virtio-mmio
device, and hence one CPU handling processing the virtqueue events.

We are looking to change that, so that the vNIC performance (measured in
pps) scales together with the number of vNIC queues, and allocated vCPUs.

Our goal is to reach the same pps level as virtio-pci vNIC delivers today.

# Prior Work

So far we have seen two attempts making virtio-mmio devices use multiple
IRQs. First in 2014 [1], then in 2020 [2]. At least that is all we could
find.

Gathering from discussions and review feedback, the pitfalls in the
previous submissions were:

1. lack of proof that there are performance benefits (see [1]),
2. code complexity (see [2]),
3. no reference VMM (QEMU) implementation ([1] and [2]).

We try not to repeat these mistakes.

[1] https://lore.kernel.org/r/1415093712-15156-1-git-send-email-zhaoshenglong@huawei.com/
[2] https://lore.kernel.org/r/cover.1581305609.git.zhabin@linux.alibaba.com/

# Benchmark Setup and Results

Traffic flow:

host -> guest (reflect in XDP native) -> host

host-guest-host with XDP program reflecting UDP packets is just one of
production use-cases we are interested in.

Another one is a typical host-to-guest scenario, where UDP flows are
terminated in the guest. The latter, however, takes more work to benchmark
because it requires manual sender throttling to avoid very high loses on
receiver.

Setup details:

- guest:
  - Linux v6.5 + this patchset
  - 8 vCPUs
  - 16 vNIC queues (8 in use + 8 for lockless XDP TX)
- host
  - VMM - QEMU v8.1.0 + PoC changes (see below)
  - vhost offload enabled
  - iperf3 v3.12 used as sender and receiver
- traffic pattern
  - 8 uni-directional, small-packet UDP flows
  - flow steering - one flow per vNIC RX queue
- CPU affinity
  - iperf clients, iperfs servers, KVM vCPU threads, vhost threads pinned to
    their own logical CPUs
  - all used logical CPUs on the same NUMA node

Recorded receiver pps:

                      virtio-pci      virtio-mmio     virtio-mmio
                      8+8+1 IRQs      8 IRQs          1 IRQ

 rx pps (mean ± rsd): 217,743 ± 2.4%  221,741 ± 2.7%  48,910 ± 0.03%
pkt loss (min … max):    1.8% … 2.3%     2.9% … 3.6%   82.1% … 89.3%

rx pps is the average over 8 receivers, each receiving one UDP flow.
pkt loss is not aggregated. Loss for each UDP flow is within the range.

If anyone would like to reproduce these results, we would be happy to share
detailed setup steps and tooling (scripts).

# PoC QEMU changes

QEMU is the only known to us VMM where we can compare the performance of
both virtio PCI and MMIO transport with a multi-queue virtio NIC and vhost
offload.

Hence, accompanying this patches, we also have a rather raw, and not yet
review ready, QEMU code changes that we used to test and benchmark
virtio-mmio device with multiple IRQs.

The tag with changes is available at:

https://github.com/jsitnicki/qemu/commits/virtio-mmio-multi-irq-rfc1

# Open Questions

- Do we need a feature flag, for example VIRTIO_F_MULTI_IRQ, for the guest to
  inform the VMM that it understands the feature?

  Or can we assume that VMM assigns multiple IRQs to virtio-mmio device only if
  guest is compatible?

Looking forward to your feedback.

Jakub Sitnicki (2):
      virtio-mmio: Parse a range of IRQ numbers passed on the command line
      virtio-mmio: Support multiple interrupts per device

 drivers/virtio/virtio_mmio.c | 179 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 135 insertions(+), 44 deletions(-)
