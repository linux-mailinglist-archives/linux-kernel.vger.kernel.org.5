Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528437B7E28
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242138AbjJDL3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjJDL27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:28:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14162A6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 04:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696418889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cdSHfe2J9tX/CZK02hK8nd5jgBFEGIUPIxT9+V2vDwg=;
        b=B4svQ+mYIiU10+h85BbtxoSmYxkQKrKGJNrHaDX2R9mQAu82lAwePT6VVs8bOXTsB1NrOW
        xsF9mpbbvL1rL+zhvZVKeB7ylmMwCOBSi/h0Hdwtmx3YOhaPfNbLLVqmYJDxygLAkDq7G5
        lOprNydfHnbm7qczVCEkUP70NjsvoLc=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-etxSEicOOeCMPkxVKr-rQg-1; Wed, 04 Oct 2023 07:27:57 -0400
X-MC-Unique: etxSEicOOeCMPkxVKr-rQg-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-49a4fc85779so583147e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 04:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696418876; x=1697023676;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdSHfe2J9tX/CZK02hK8nd5jgBFEGIUPIxT9+V2vDwg=;
        b=SIcpD4g6zwvOccxGf0H+Satk38PGZPX4IgvIqRInw36VTxwrilNPkc1P1qyJazoVkA
         L8QElZUZHVlfza/682vvf1hcfV9LKZ/mJYeSU/i7W2Pu6++eWsb/Wdu3R/9D8Zpt6O1+
         1jWInNZXc+ggqa5KgmZGUM7nE+O+zwA3bNerrsWTYFSFamKSpFIy1ixrN8/x5W8Lsi0p
         VdSANGRgZD7trgOdHNlmtJqEscsxOl8YXKTbXqRl1GC8u0Me5xXmrXUjvjGdh7BoduvW
         DYhzW96kz5sSd50PPId1Gk6biJMDIzA7xaF6Lj6ujX+t3ZHpW/HggaN42pn1W0nlgl7B
         xQtw==
X-Gm-Message-State: AOJu0YyvG15dKwRjx7gzCX6RcJ7ZHzp/AanC/NE+oYmpvgNxI5rhBZHB
        a2Yav7yimMPNC9qdJGjGuBolk6pnhLL//E81ZPGRdDtjF3DzerKGtF2KY6BYcicLWZEwTWBydGM
        BCl3hRlopObXGh31q0saWoxYU
X-Received: by 2002:a1f:d687:0:b0:499:dec9:e1a7 with SMTP id n129-20020a1fd687000000b00499dec9e1a7mr1466070vkg.10.1696418876473;
        Wed, 04 Oct 2023 04:27:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqNF0zOVj059OFBBhwaXxiooYEPYkXZwSeFwrBxTJnmjzT3Zjs0XhqZTgjd89sE+eJY+TS6g==
X-Received: by 2002:a1f:d687:0:b0:499:dec9:e1a7 with SMTP id n129-20020a1fd687000000b00499dec9e1a7mr1466049vkg.10.1696418876198;
        Wed, 04 Oct 2023 04:27:56 -0700 (PDT)
Received: from vschneid.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id t3-20020ac87383000000b0041957506ca9sm1149451qtp.15.2023.10.04.04.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 04:27:55 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org
Cc:     sshegde@linux.vnet.ibm.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        qperret@google.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org,
        pierre.gondois@arm.com, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com, pauld@redhat.com, lukasz.luba@arm.com,
        linux-doc@vger.kernel.org, bsegall@google.com, linux-eng@arm.com
Subject: Re: [PATCH v5 2/2] sched/topology: change behaviour of sysctl
 sched_energy_aware based on the platform
In-Reply-To: <20230929155209.667764-3-sshegde@linux.vnet.ibm.com>
References: <20230929155209.667764-1-sshegde@linux.vnet.ibm.com>
 <20230929155209.667764-3-sshegde@linux.vnet.ibm.com>
Date:   Wed, 04 Oct 2023 13:27:50 +0200
Message-ID: <xhsmhttr6oceh.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/23 21:22, Shrikanth Hegde wrote:
> +static bool sched_is_eas_possible(const struct cpumask *cpu_mask)
> +{
> +	bool any_asym_capacity = false;
> +	struct cpufreq_policy *policy;
> +	struct cpufreq_governor *gov;
> +	int i;
> +
> +	/* EAS is enabled for asymmetric CPU capacity topologies. */
> +	for_each_cpu(i, cpu_mask) {
> +		if (per_cpu(sd_asym_cpucapacity, i)) {

Lockdep should complain here in the sysctl path - this is an RCU-protected
pointer.

rcu_access_pointer() should do since you're not dereferencing the pointer.

> +			any_asym_capacity = true;
> +			break;
> +		}
> +	}

> @@ -231,6 +295,15 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
>               return -EPERM;
>
>       ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);

Shouldn't this happen after we check sched_is_eas_possible()? Otherwise
AFAICT a write can actually happen despite !sched_is_eas_possible().

> +	if (!sched_is_eas_possible(cpu_active_mask)) {
> +		if (write) {
> +			return -EOPNOTSUPP;
> +		} else {
> +			*lenp = 0;
> +			return 0;
> +		}
> +	}

But now this is making me wonder, why not bite the bullet and store
somewhere whether we ever managed to enable EAS? Something like so?
(I didn't bother making this yet another static key given this is not a hot
path at all)
---
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index e0b9920e7e3e4..abd950f434206 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -209,6 +209,7 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 DEFINE_STATIC_KEY_FALSE(sched_energy_present);
 static unsigned int sysctl_sched_energy_aware = 1;
+static bool __read_mostly sched_energy_once;
 static DEFINE_MUTEX(sched_energy_mutex);
 static bool sched_energy_update;
 
@@ -230,6 +231,15 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
 	if (write && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (!sched_energy_once) {
+		if (write) {
+			return -EOPNOTSUPP;
+		} else {
+			*lenp = 0;
+			return 0;
+		}
+	}
+
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (!ret && write) {
 		state = static_branch_unlikely(&sched_energy_present);
@@ -340,6 +350,8 @@ static void sched_energy_set(bool has_eas)
 		if (sched_debug())
 			pr_info("%s: starting EAS\n", __func__);
 		static_branch_enable_cpuslocked(&sched_energy_present);
+		// Record that we managed to enable EAS at least once
+		sched_energy_once = true;
 	}
 }
 

