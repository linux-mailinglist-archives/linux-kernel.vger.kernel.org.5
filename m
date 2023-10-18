Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FDF7CD96A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbjJRKkD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Oct 2023 06:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjJRKj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:39:59 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8CDB0;
        Wed, 18 Oct 2023 03:39:57 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-57de3096e25so1371002eaf.1;
        Wed, 18 Oct 2023 03:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697625597; x=1698230397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtmjII0ee1f21HN24SIPEYP9xZN9qMse1/pApzruflA=;
        b=PBNdeV+68fXXHjm1LL8loE6LLA0ek8xGQQaF+B0Hk51y83nm7lsIfsr3MOeBo2QOsQ
         wO35nMfKal3ekCiaDfSUqGnDx9enbWReIIwOX7Mus9zPDfnG2H+lj7kGsU3AjOtRuHEE
         6lgMsKkX/vkXVFh6eR6cIxZjc/EHSmgbNXp9EfdhgvBvTzckHbaMpGbjQHCiP8MintRr
         yqizyy9okeyCi4wUgV+3nk8W6YwXBqCECgj4lu/px6IjjiP9KMFS+3C1C4MDYs/JvwJE
         YdX1NrZfG/DocQucLxCrlUuQDpw8/rCO2s4C4MK8qJQZ5DXU6X2XsSM21QwZ2v5O+eAM
         F+1Q==
X-Gm-Message-State: AOJu0YzBZrT2JX+QuCUfoxpy/T8i6kuZFtDhzZrdvm+Ev+bvEs8WYosZ
        BuykQLpxTnr/5bJbywIHJTl2ZuHox4uBX7q2jRU=
X-Google-Smtp-Source: AGHT+IFqHTgrARdc0q1r9FIddruvQnjJjU8onYjV7cSScx6lMxZRYIE772ygaGjJZnfdXpHVmL5HSXSsnZZYxUACNuE=
X-Received: by 2002:a4a:4f15:0:b0:581:e7b8:dd77 with SMTP id
 c21-20020a4a4f15000000b00581e7b8dd77mr3387616oob.1.1697625597298; Wed, 18 Oct
 2023 03:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231017082905.1673316-1-michal.wilczynski@intel.com> <652f5eddba760_5c0d29449@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <652f5eddba760_5c0d29449@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Oct 2023 12:39:46 +0200
Message-ID: <CAJZ5v0g5buHjd+EqMsHtuN2vcJHSTCd-cCchvo-44iPi1cKk5A@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: NFIT: Use cleanup.h helpers instead of devm_*()
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        rafael@kernel.org, vishal.l.verma@intel.com, lenb@kernel.org,
        dave.jiang@intel.com, ira.weiny@intel.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 6:28 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Michal Wilczynski wrote:
> > The new cleanup.h facilities that arrived in v6.5-rc1 can replace the
> > the usage of devm semantics in acpi_nfit_init_interleave_set(). That
> > routine appears to only be using devm to avoid goto statements. The
> > new __free() annotation at variable declaration time can achieve the same
> > effect more efficiently.
> >
> > There is no end user visible side effects of this patch, I was
> > motivated to send this cleanup to practice using the new helpers.
> >
> > Suggested-by: Dave Jiang <dave.jiang@intel.com>
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> > ---
> >
> > Dan, would you like me to give you credit for the changelog changes
> > with Co-developed-by tag ?
>
> Nope, this looks good to me, thanks for fixing it up.
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Are you going to apply it too, or should I take it?
