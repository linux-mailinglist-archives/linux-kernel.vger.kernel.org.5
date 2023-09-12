Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D7079D34F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbjILOJe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 10:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbjILOJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:09:26 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A272BCA;
        Tue, 12 Sep 2023 07:09:22 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3a9e89fa553so710105b6e.1;
        Tue, 12 Sep 2023 07:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527762; x=1695132562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3t4Qi/o4fIqQV76oFp3RHORSTaJ6qjKQG0ecc7mN3So=;
        b=IKzTwe0EXtGwO4ZQeL/1rkVHm9HqWlUXueMxb9/blNrriCv+slGxSg8IMQqLDsTWrT
         fVRB9JdXMrpTzpG5rrbW9+9xEfOaHjJfO8Y/ZzdM9yIXFenTxPpkh/8C5dFHy00o3pYv
         5dB+2q0By9dBqxXeqnkK9YJdzA2DoJLbseGPZWnqYZubl9hZgOmQh7haWd65JpzK7fk+
         4Cw55HTws7fj0h7PBLtoddWpAGsmiOih10lISoics14RsieswxbVnfaW+xJ8heazxyfY
         GyOf+HkxuMe6f2Lgpjfq6ltxrzFXQjGpZ1WCrxB8dZULAehze6k0nU1Fh+eTi35l+CIu
         WPZg==
X-Gm-Message-State: AOJu0Yx/kphaXVPywCb0OWMyRw7BZpkF1aawAYBwHORvRJXZHx2bQoRL
        fIyAOC1KYNQh7mkrRvQrUaIj/L/Ijpj3EjByYAcN/MqcOMM=
X-Google-Smtp-Source: AGHT+IH3mrS7MlQfUNPGMEXfgKOtemdlIQtD3fvex6yDSsAozupccUersckBLSDXQRrpTIToVNxn/wydbIGhiDNZRzA=
X-Received: by 2002:a05:6808:20a5:b0:3a8:8b74:fd59 with SMTP id
 s37-20020a05680820a500b003a88b74fd59mr14216058oiw.0.1694527761846; Tue, 12
 Sep 2023 07:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230829002346.2104251-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230829002346.2104251-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Sep 2023 16:09:10 +0200
Message-ID: <CAJZ5v0jrKSUOGG72w-EdzhQqC==CA7zYUofNSEW1wV-58TOnLw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] thermal: processor_thermal: Suport workload hint
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 2:23 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add support for Meteor Lake workload hints. Before adding this support,
> some reorganization and clean up is required.
> First four changes are for clean up and to reorganize code to add
> support for workload hint. The last patch adds a test program as part
> of self tests.
>
> v3:
> Changes in the commit log
> Rename of files for using WT instead of WLT
> Address comments from Rafael on v2
>
> v2:
> Changes in comments and commit log
> Self test program is improved to disable workloadtype notification
> on exit
>
> Srinivas Pandruvada (7):
>   thermal: int340x: processor_thermal: Move mailbox code to common
>     module
>   thermal: int340x: processor_thermal: Add interrupt configuration
>   thermal: int340x: processor_thermal: Use non MSI interrupts by default
>   thermal/drivers/int340x: Remove PROC_THERMAL_FEATURE_WLT_REQ for
>     Meteor Lake
>   thermal: int340x: processor_thermal: Add workload type hint interface
>   thermal/drivers/int340x: Support workload hint interrupts
>   selftests/thermel/intel: Add test to read workload hint
>
>  .../driver-api/thermal/intel_dptf.rst         |  51 ++++
>  .../thermal/intel/int340x_thermal/Makefile    |   2 +
>  .../processor_thermal_device.c                |  17 +-
>  .../processor_thermal_device.h                |  21 +-
>  .../processor_thermal_device_pci.c            |  79 ++++--
>  .../processor_thermal_device_pci_legacy.c     |   3 +-
>  .../int340x_thermal/processor_thermal_mbox.c  | 179 ++++---------
>  .../processor_thermal_wt_hint.c               | 252 ++++++++++++++++++
>  .../processor_thermal_wt_req.c                | 136 ++++++++++
>  tools/testing/selftests/Makefile              |   1 +
>  .../thermal/intel/workload_hint/Makefile      |  12 +
>  .../intel/workload_hint/workload_hint_test.c  | 157 +++++++++++
>  12 files changed, 752 insertions(+), 158 deletions(-)
>  create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
>  create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.c
>  create mode 100644 tools/testing/selftests/thermal/intel/workload_hint/Makefile
>  create mode 100644 tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
>
> --

There is a slight issue with the patch ordering in this series,
because the interface to enable the interrupt should only be provided
after implementing the interrupt handlers.  I don't think that anyone
will apply the series partially and try to enable the feature, though.

Also, I'm not actually sure if proc_thermal_wt_intr_callback() can run
safely against the work item scheduled in proc_thermal_irq_handler()
in case the workload hint one triggers along with a thermal threshold
one.  I think that the access to MMIO is cached, so what if they both
try to update the same cache line at the same time?  Or are they
guaranteed to be different cache lines?

Anyway, tentatively applied as 6.7 material, but I've changed the
second patch somewhat, because I couldn't convince myself that the
implicit type conversions in processor_thermal_mbox_interrupt_config()
would always do the right thing regardless of the numbers involved, so
please check the result in my bleeding-edge branch.

Thanks!
