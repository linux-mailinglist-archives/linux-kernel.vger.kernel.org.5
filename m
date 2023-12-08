Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF9C80A50E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573896AbjLHODh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573881AbjLHODf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:03:35 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A48F9;
        Fri,  8 Dec 2023 06:03:41 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5d7346442d4so20489317b3.2;
        Fri, 08 Dec 2023 06:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702044220; x=1702649020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vq1VOSqoVjxWvcT4zuInZBLiz41JyrThxjwY/ZgTFVU=;
        b=fOm59JhL+2qGq1LVM/oE7xTxCeolcamuek9FFvbLaWLe4NVCqnHOaiVQhKQzAbVsoO
         8IOmOPOlq7Q0yht44wUKi4kNMwRPC4DLYD2C08HJLcUUQobnJAyyGtSHxMpOxS1sEPez
         JvF0VliM4q4O0OtjjEOdCIHczQnwk+yJXMLRQqox/fX005f5MujtxgNX8ehpSzD69pm3
         3OrsaUzHggAftxtzzQOwUXB25F0DMBVfmICKfwkN+uqqDfdOXg3W8pR77Yz0Ul2owgNp
         as4i3JA9fNIo7Z8lhE/91GSA3k1PqeP5deuzdKeVAcQdnihO1tO4swsWNS8MqHtY0II2
         m/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702044220; x=1702649020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vq1VOSqoVjxWvcT4zuInZBLiz41JyrThxjwY/ZgTFVU=;
        b=vghIf+iSQPkZp/iD9ZbzF5dwrkjw/2Xg8igEnM78VBLrp+CKqzfD7ns4d4o/+Aahit
         MMgOekHIMHE1Tif1hCFULeNozUXWjrRNHYxFqsrtiyHM6SJpt92rfr5FlEAYwh1H7gyJ
         uBH1IO8KljYaFAlmF1d/qDQZpEWfev0tTupINxK02U8WfqTrRCuxA3ec5kcAlrFYD0Pr
         1u3u05D/cVnvvoKPPZjQewRDh2dQoeyAzLLv4WlAvNIDT0GsANjZR6YEuS9xsmpoapSs
         IMIMyuJRbuK2us3SmpqQ61klGSSu3L4xuymKypTFscHWheTuj4DVnMkyl7FhwY3fxMl8
         FWjg==
X-Gm-Message-State: AOJu0YyFUbZPMjRajwIs3MI0JBOQOIA5+lbDzuHdXEzyXH5hh/wt22vG
        +FpqJmaP5Iz1brAYyTOh4xw=
X-Google-Smtp-Source: AGHT+IFZPGq/PPeI2SQ4w5pXqgaG1TPzCcDB20LoxYTWV05p7WatZaKHyKzuZMA8VTYLe7M1JHSKGw==
X-Received: by 2002:a81:4990:0:b0:5d7:1941:3579 with SMTP id w138-20020a814990000000b005d719413579mr3614832ywa.96.1702044220488;
        Fri, 08 Dec 2023 06:03:40 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cd3e:7dc3:93ad:7de2])
        by smtp.gmail.com with ESMTPSA id o130-20020a0dcc88000000b005d392d15725sm676865ywd.94.2023.12.08.06.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:03:40 -0800 (PST)
Date:   Fri, 8 Dec 2023 06:03:39 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, schakrabarti@microsoft.com,
        paulros@microsoft.com
Subject: Re: [PATCH V5 net-next] net: mana: Assigning IRQ affinity on HT cores
Message-ID: <ZXMiOwK3sOJNXHxd@yury-ThinkPad>
References: <1702029754-6520-1-git-send-email-schakrabarti@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702029754-6520-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 02:02:34AM -0800, Souradeep Chakrabarti wrote:
> Existing MANA design assigns IRQ to every CPU, including sibling
> hyper-threads. This may cause multiple IRQs to be active simultaneously
> in the same core and may reduce the network performance with RSS.

Can you add an IRQ distribution diagram to compare before/after
behavior, similarly to what I did in the other email?

> Improve the performance by assigning IRQ to non sibling CPUs in local
> NUMA node. The performance improvement we are getting using ntttcp with
> following patch is around 15 percent with existing design and approximately
> 11 percent, when trying to assign one IRQ in each core across NUMA nodes,
> if enough cores are present.

How did you measure it? In the other email you said you used perf, can
you show your procedure in details?

> Suggested-by: Yury Norov <yury.norov@gmali.com>
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---

[...]

>  .../net/ethernet/microsoft/mana/gdma_main.c   | 92 +++++++++++++++++--
>  1 file changed, 83 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 6367de0c2c2e..18e8908c5d29 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1243,15 +1243,56 @@ void mana_gd_free_res_map(struct gdma_resource *r)
>  	r->size = 0;
>  }
>  
> +static int irq_setup(int *irqs, int nvec, int start_numa_node)
> +{
> +	int w, cnt, cpu, err = 0, i = 0;
> +	int next_node = start_numa_node;

What for this?

> +	const struct cpumask *next, *prev = cpu_none_mask;
> +	cpumask_var_t curr, cpus;
> +
> +	if (!zalloc_cpumask_var(&curr, GFP_KERNEL)) {
> +		err = -ENOMEM;
> +		return err;
> +	}
> +	if (!zalloc_cpumask_var(&cpus, GFP_KERNEL)) {

                free(curr);

> +		err = -ENOMEM;
> +		return err;
> +	}
> +
> +	rcu_read_lock();
> +	for_each_numa_hop_mask(next, next_node) {
> +		cpumask_andnot(curr, next, prev);
> +		for (w = cpumask_weight(curr), cnt = 0; cnt < w; ) {
> +			cpumask_copy(cpus, curr);
> +			for_each_cpu(cpu, cpus) {
> +				irq_set_affinity_and_hint(irqs[i], topology_sibling_cpumask(cpu));
> +				if (++i == nvec)
> +					goto done;

Think what if you're passed with irq_setup(NULL, 0, 0).
That's why I suggested to place this check at the beginning.


> +				cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
> +				++cnt;
> +			}
> +		}
> +		prev = next;
> +	}
> +done:
> +	rcu_read_unlock();
> +	free_cpumask_var(curr);
> +	free_cpumask_var(cpus);
> +	return err;
> +}
> +
>  static int mana_gd_setup_irqs(struct pci_dev *pdev)
>  {
> -	unsigned int max_queues_per_port = num_online_cpus();
>  	struct gdma_context *gc = pci_get_drvdata(pdev);
> +	unsigned int max_queues_per_port;
>  	struct gdma_irq_context *gic;
>  	unsigned int max_irqs, cpu;
> -	int nvec, irq;
> +	int start_irq_index = 1;
> +	int nvec, *irqs, irq;
>  	int err, i = 0, j;
>  
> +	cpus_read_lock();
> +	max_queues_per_port = num_online_cpus();
>  	if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
>  		max_queues_per_port = MANA_MAX_NUM_QUEUES;
>  
> @@ -1261,6 +1302,14 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
>  	nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
>  	if (nvec < 0)
>  		return nvec;
> +	if (nvec <= num_online_cpus())
> +		start_irq_index = 0;
> +
> +	irqs = kmalloc_array((nvec - start_irq_index), sizeof(int), GFP_KERNEL);
> +	if (!irqs) {
> +		err = -ENOMEM;
> +		goto free_irq_vector;
> +	}
>  
>  	gc->irq_contexts = kcalloc(nvec, sizeof(struct gdma_irq_context),
>  				   GFP_KERNEL);
> @@ -1287,21 +1336,44 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
>  			goto free_irq;
>  		}
>  
> -		err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
> -		if (err)
> -			goto free_irq;
> -
> -		cpu = cpumask_local_spread(i, gc->numa_node);
> -		irq_set_affinity_and_hint(irq, cpumask_of(cpu));
> +		if (!i) {
> +			err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
> +			if (err)
> +				goto free_irq;
> +
> +			/* If number of IRQ is one extra than number of online CPUs,
> +			 * then we need to assign IRQ0 (hwc irq) and IRQ1 to
> +			 * same CPU.
> +			 * Else we will use different CPUs for IRQ0 and IRQ1.
> +			 * Also we are using cpumask_local_spread instead of
> +			 * cpumask_first for the node, because the node can be
> +			 * mem only.
> +			 */
> +			if (start_irq_index) {
> +				cpu = cpumask_local_spread(i, gc->numa_node);

I already mentioned that: if i == 0, you don't need to spread, just
pick 1st cpu from node.

> +				irq_set_affinity_and_hint(irq, cpumask_of(cpu));
> +			} else {
> +				irqs[start_irq_index] = irq;
> +			}
> +		} else {
> +			irqs[i - start_irq_index] = irq;
> +			err = request_irq(irqs[i - start_irq_index], mana_gd_intr, 0,
> +					  gic->name, gic);
> +			if (err)
> +				goto free_irq;
> +		}
>  	}
>  
> +	err = irq_setup(irqs, (nvec - start_irq_index), gc->numa_node);
> +	if (err)
> +		goto free_irq;
>  	err = mana_gd_alloc_res_map(nvec, &gc->msix_resource);
>  	if (err)
>  		goto free_irq;
>  
>  	gc->max_num_msix = nvec;
>  	gc->num_msix_usable = nvec;
> -
> +	cpus_read_unlock();
>  	return 0;
>  
>  free_irq:
> @@ -1314,8 +1386,10 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
>  	}
>  
>  	kfree(gc->irq_contexts);
> +	kfree(irqs);
>  	gc->irq_contexts = NULL;
>  free_irq_vector:
> +	cpus_read_unlock();
>  	pci_free_irq_vectors(pdev);
>  	return err;
>  }
> -- 
> 2.34.1
