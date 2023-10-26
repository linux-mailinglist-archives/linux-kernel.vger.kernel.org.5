Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BB47D86C0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjJZQap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJZQan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:30:43 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1E618A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:30:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9c773ac9b15so165546366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698337836; x=1698942636; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=K49sQJlsvQ6YWsPJ1ZrLdAhGXeZjXDwIwIeJaPYwsv4=;
        b=HjoZ5U1c/Aj3krVfPie/ijWO0JsPPR+tbJN76NVVxKq+3JHuXKDi9GOaEX7DSHm+xT
         k5WL6/2KL5/nGAH9sesyUuQUfJ5g+YaCxNqW8Bgj6jDT3/5VR8CS5i9uEmIn69MUdnld
         PrL5/Y4cmNkj2vQwWeWs5KhiN/gUyoEvjJWijJrzi7K8hkfEyy4df5ZbndqwHccuclB9
         7eCJocn6arJehBihgHTOqaeSJLM5NYPtVJOoJTVI5PvZ4sfp9Tskr7Hrkye0W8Lml9tn
         11ucAJtVTOAk5XaGBnc24Rn1yJ+et2ot7AufDqBZ1gFzLTP9Cl5jBkFBLzzUYHFGPzCp
         j6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698337836; x=1698942636;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K49sQJlsvQ6YWsPJ1ZrLdAhGXeZjXDwIwIeJaPYwsv4=;
        b=GIBdPMa8nLBIZNMfpiaI5AlYN1UZAdYNNSt8tiWXW2LbwatoflfTTA1pILGqCDNeuV
         lXyPqf4EEbdxmoj9F6iON/UzATHswBld65wW3L5oEbfCcrUvR/6Bf3fLdNDHZUK6HgK+
         SxcRW4yZ94KmZPBgvNfrQr7ijodCq+VqRwtEXiw/UWYE7gzYG2U+tbik0huvzBBdn13s
         62RHZk6dqsxm3OUP41FZEx8q9w0+51E9ke3QEO6P2Sz05u77ihKHyMfyKe3cfODRqq6Y
         1KSkcUKsKHd1+Ahq0rk3ZUMmqG9EWGdnr1s7n6wm7oZq5UmZVGxCvfuXpy3X5D4/WQ3q
         oFeg==
X-Gm-Message-State: AOJu0Yx5L9SajZRYZaNTzFlSEvRYH3NtwH/64EQzRzzt6MSJjzp66QZ5
        BTiKKalRDrxcBHPJ4qOiOXJqQA==
X-Google-Smtp-Source: AGHT+IEX/vQ8j+z414JDsP93agMdjngSMn6VsCTV63ESqZ4tZjLeA+a50cbNzX+sVxTam8CrLzyhEA==
X-Received: by 2002:a17:907:31c8:b0:9a1:891b:6eed with SMTP id xf8-20020a17090731c800b009a1891b6eedmr139103ejb.76.1698337836027;
        Thu, 26 Oct 2023 09:30:36 -0700 (PDT)
Received: from cloudflare.com (79.184.154.62.ipv4.supernova.orange.pl. [79.184.154.62])
        by smtp.gmail.com with ESMTPSA id k15-20020a1709065fcf00b00997d7aa59fasm12151449ejv.14.2023.10.26.09.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:30:35 -0700 (PDT)
References: <20231025145319.380775-1-jakub@cloudflare.com>
User-agent: mu4e 1.6.10; emacs 28.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     virtualization@lists.linux-foundation.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH v2] virtio_pci: Switch away from deprecated
 irq_set_affinity_hint
Date:   Thu, 26 Oct 2023 18:25:08 +0200
In-reply-to: <20231025145319.380775-1-jakub@cloudflare.com>
Message-ID: <87wmv91h3p.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 04:53 PM +02, Jakub Sitnicki wrote:
> Since commit 65c7cdedeb30 ("genirq: Provide new interfaces for affinity
> hints") irq_set_affinity_hint is being phased out.
>
> Switch to new interfaces for setting and applying irq affinity hints.
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
> v2:
>  - Leave cpumask_copy as is. We can't pass pointer to stack memory as hint.
>    Proposed a change to IRQ affinity interface to address this limitation:
>    https://lore.kernel.org/r/20231025141517.375378-1-jakub@cloudflare.com

Just a note to the ^ - if we wanted to get rid of msix_affinity_masks,
we could call irq_set_affinity directly, instead of calling it through
irq_set_affinity[_and]_hint.

The hint wouldn't be available any more in /proc/irq/N/affinity_hint,
but the same information can be gathered from /proc/irq/N/smp_affinity.

[...]
