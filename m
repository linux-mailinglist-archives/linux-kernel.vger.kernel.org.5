Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB7A7B104E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 03:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjI1BSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 21:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1BSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 21:18:35 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F4CF5;
        Wed, 27 Sep 2023 18:18:31 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0925681796;
        Thu, 28 Sep 2023 01:18:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a245.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6035681907;
        Thu, 28 Sep 2023 01:18:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1695863907; a=rsa-sha256;
        cv=none;
        b=V4wYvncNg7bEDdCPtYHL+fbFo8S181rnzS/3S+9PYcembfJCHai+NfQXQoqKRHK+iFcxi9
        8GBeqVTLC1nNkbYoIg1m92PPxWnq5++vc9g6zlcITra05VYL+maeOh4By5/cKT+bUYlnTN
        A5ry1Ziiii4Lkfl0uzaj6i/KEw6cNkj1H/ufu0Bzsk7USMGzC3X9ycBdv4SwvjsVQp0GLQ
        MGCk+GEOLYXZgu2I4ehra+neCg3n9it/j0i66YrFm9gi7IQcp33BHd8Ym+sNlg+ohjOfnt
        PBB2wc73OT2aBOt23qF/ZOHT9cAIYsc0jRYweZeGLw5GZeXAFUrjVslQMuVIUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1695863907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=l+vBFqPjBMKFbqu5XhbV2rCmcl4slYz26Cs5fxb/yqc=;
        b=koec0pYPCw9g0QRdwaUdTM5lKi8bcpDDkH628od9Ivo9tlfb1AhyTnbSMlfIF3k35mPm1T
        i7/68OIGBoAfVRidX3GGb4ThoXjHSZqqxW/ZPXh+luSgGYnY2bmC7aSxser7DcyefuFbdK
        Y4UNAybBO9aE9u+sQQ9hgxbEbI/oQMD+9fWIAO5N7DxArTiKso7KBfLUMln3gc1FRlZlEb
        +qxC4YtFnTYowA4XzQmce5+SbUJbWA71ltusozXnjmsdb04UGU+xYKzxo1x2TFiX5UNsUy
        tALZfnDi0e2TBXdwmZq1sBjy7RVKN3LahwyUoXavqT09ZxDEfGWZehMYlToVhA==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-mc6tx;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Arithmetic-Turn: 159e1a1812a75633_1695863907725_2640573531
X-MC-Loop-Signature: 1695863907725:2557605338
X-MC-Ingress-Time: 1695863907725
Received: from pdx1-sub0-mail-a245.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.110.212 (trex/6.9.1);
        Thu, 28 Sep 2023 01:18:27 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a245.dreamhost.com (Postfix) with ESMTPSA id 4RwwbQ3gL3zK5;
        Wed, 27 Sep 2023 18:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1695863907;
        bh=l+vBFqPjBMKFbqu5XhbV2rCmcl4slYz26Cs5fxb/yqc=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=rJgekkcoy7Q8C/P9/eF8+K1d9bkC2cx9hbqs0snKgxexK5VLvQ3fQ298p9phsEqSD
         4INrjIaxHYy+BSiXnr2s5AcKmHdIjbg0KDP3sF58PyfHxsRJ4T90Esv6rDKpMGhMV6
         3Wv15rL/aMnmhqMXGuShpco3pgocfHTjvldifqcn4jyR2OTJ8FUeItexnVWPU3/1YO
         gi2K//U+19T9LI3ikyVQTPbKMMc0mxU8SGqk8qBgIT87+Ewx8+lKzQN1j9IKHU59A+
         0BpKre3NWP9SQhyrQb+jk0cRwxacZqbtjiqMpMWsiNgLnkFzsY+Po3lXA63efNHpwd
         TRy9yu5g9FcrA==
Date:   Wed, 27 Sep 2023 18:18:23 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: Annotate struct cxl_cxims_data with
 __counted_by
Message-ID: <2jvukfliknlhy2j4fespmmezbjc4q4kffznfyeloirs6flya42@hniebubdznlh>
References: <20230922175319.work.096-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230922175319.work.096-kees@kernel.org>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023, Kees Cook wrote:

>Prepare for the coming implementation by GCC and Clang of the __counted_by
>attribute. Flexible array members annotated with __counted_by can have
>their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
>(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
>functions).
>
>As found with Coccinelle[1], add __counted_by for struct cxl_cxims_data.
>Additionally, since the element count member must be set before accessing
>the annotated flexible array member, move its initialization earlier.

Nice.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>
>[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
>
>Cc: Davidlohr Bueso <dave@stgolabs.net>
>Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>Cc: Dave Jiang <dave.jiang@intel.com>
>Cc: Alison Schofield <alison.schofield@intel.com>
>Cc: Vishal Verma <vishal.l.verma@intel.com>
>Cc: Ira Weiny <ira.weiny@intel.com>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: linux-cxl@vger.kernel.org
>Signed-off-by: Kees Cook <keescook@chromium.org>
>---
> drivers/cxl/acpi.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>index d1c559879dcc..40d055560e52 100644
>--- a/drivers/cxl/acpi.c
>+++ b/drivers/cxl/acpi.c
>@@ -14,7 +14,7 @@
>
> struct cxl_cxims_data {
>	int nr_maps;
>-	u64 xormaps[];
>+	u64 xormaps[] __counted_by(nr_maps);
> };
>
> /*
>@@ -112,9 +112,9 @@ static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
>			      GFP_KERNEL);
>	if (!cximsd)
>		return -ENOMEM;
>+	cximsd->nr_maps = nr_maps;
>	memcpy(cximsd->xormaps, cxims->xormap_list,
>	       nr_maps * sizeof(*cximsd->xormaps));
>-	cximsd->nr_maps = nr_maps;
>	cxlrd->platform_data = cximsd;
>
>	return 0;
>--
>2.34.1
>
