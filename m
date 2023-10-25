Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EF27D6F33
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344972AbjJYOgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjJYOgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:36:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A96136
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:36:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698244592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z2rcaRUnsSxQGFatqfmQRksZU9LSmKnPGglhZMYugXg=;
        b=sO9pbcpFsnjpKFbcEHAaWiqZLx9zAMoVP4AL+DUVxl4XWGas7kqF1KKj4F+oFgmT/Cy1TI
        se6/W1YsB5/2Asn/Y2FqcJ6hNa6V5ZrdDziycEjmcdnxNP3k7PiSR5PJ254olMEkyoFHSU
        CyRfXsOmvXNeYtVUM4V7xjvydIir29Fdp1QbjkkNgeieArDwMQYkEnO7edVdZpSoI3v9uB
        u4ASfoL2cAYkqhJ4gsMOConhjkXWq6DtuqNifrRwd1bCs7CWfSIXhGqkRDbjbO24rqmAzZ
        U1pdpN3Nl8gXh/dksZ1uG3cGKnBk+dcRdzMgGVSPOM1+4576K1bo+5+/vwflnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698244592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z2rcaRUnsSxQGFatqfmQRksZU9LSmKnPGglhZMYugXg=;
        b=XhBQVvLxaRoAc0VYEOJQXvpSoxSZ0YujFOOqU7p2i1bc0qSysnFqPKCeqSqiRuyMdgBF2N
        Saz5/2Fsrf5xMbBA==
To:     Chen Yu <yu.c.chen@intel.com>, Juergen Gross <jgross@suse.com>
Cc:     Len Brown <len.brown@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.chen.surf@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Wendy Wang <wendy.wang@intel.com>
Subject: Re: [RFC PATCH] genirq: Exclude managed irq during irq migration
In-Reply-To: <20231020072522.557846-1-yu.c.chen@intel.com>
References: <20231020072522.557846-1-yu.c.chen@intel.com>
Date:   Wed, 25 Oct 2023 16:36:31 +0200
Message-ID: <87sf5y6a6o.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20 2023 at 15:25, Chen Yu wrote:
> diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
> index 1698e77645ac..d245ad76661e 100644
> --- a/kernel/irq/matrix.c
> +++ b/kernel/irq/matrix.c
> @@ -475,7 +475,7 @@ unsigned int irq_matrix_allocated(struct irq_matrix *m)
>  {
>  	struct cpumap *cm = this_cpu_ptr(m->maps);
>  
> -	return cm->allocated;
> +	return cm->allocated - cm->managed_allocated;

The kernel documentation above this function is now misleading. Sigh...
