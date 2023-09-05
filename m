Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E505792C20
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354072AbjIERHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354495AbjIEQ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 12:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCA535A3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 09:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693930651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U9FhosmOuX/2kxCqSD0g8v7LrAhamscfVyLfIomDXec=;
        b=Rfpa8ZuUkCGDf/jIW1Xxgk79b8RtztxwJrDzo1Oxvo/H3cxETFZFD/9Sis5eZ8WSKxdQiA
        7urwtLQ3kiE1l8Fqrzvm1a4kP5yxRZg/P0GdVb4yim1yqPQbeDN1xyGIaBenXkzzffHLvJ
        NUjq5b5ssnB9Nesm/teUYDD5l633NQs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-AOVEbKYANlmgYISdBYFobQ-1; Tue, 05 Sep 2023 12:17:30 -0400
X-MC-Unique: AOVEbKYANlmgYISdBYFobQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-52a5e65d9b4so2082184a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 09:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693930649; x=1694535449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9FhosmOuX/2kxCqSD0g8v7LrAhamscfVyLfIomDXec=;
        b=ctDQZwCotbplmZERdiS1e4oQVCZJUb9e0mRW4iR5d+s9bVBdQY89M2fg1qPAV2HcHv
         njvYaf413rKT9Rg4dF9YYfn0p3Erf0QB2LPID3S9xGG+rbwtSuRH0y+Ct9vEjej2RuT1
         46jWwx1I90FwSDonfR6fSglDp/z26v9I2knwx1IcRpXqt5pHHV/A10v24rKMYxGzlQ8N
         4OhE7fmNkfsR8Xpj9BQJaQLEGGQx0XCHNMSR9jV7ASzq9qpYz+6D4Deui0V/TD1Fzqet
         YNsRC9PN9XVzJvgmxc9IruVusermpsmG2FUNV7KlOwxGEGP7o7Pz95u7ki+LtssPu868
         xXEA==
X-Gm-Message-State: AOJu0YxnTRXStPuIt4hjoMXv1izFuUK/4rWFkIxsrYjpLaUzceZJ5c1q
        0d17oWEGUtcraHOP4WxKbE0j6oZwEbAbENMRD6fPOsL7NVkOqTZOfQLrOSOY0PQz5PM0lhqoWWf
        2oT9XvVm8uDXqHMXRT8X1mufM
X-Received: by 2002:aa7:c392:0:b0:523:2e63:b9b with SMTP id k18-20020aa7c392000000b005232e630b9bmr255962edq.24.1693930648989;
        Tue, 05 Sep 2023 09:17:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdZ4V2E5MhG38N8ZjsIoKBtNqCIGRlanPTQRsG/UZ5V1Q9XE0rUNc8DpFyG1DVZlMd0pR2rw==
X-Received: by 2002:aa7:c392:0:b0:523:2e63:b9b with SMTP id k18-20020aa7c392000000b005232e630b9bmr255947edq.24.1693930648686;
        Tue, 05 Sep 2023 09:17:28 -0700 (PDT)
Received: from [192.168.0.224] (a-rm20-17.tin.it. [212.216.165.208])
        by smtp.gmail.com with ESMTPSA id q6-20020aa7da86000000b0052a063e52b8sm7208162eds.83.2023.09.05.09.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 09:17:27 -0700 (PDT)
Message-ID: <ee0ac345-e3b0-52ea-d70e-0048b2296e67@redhat.com>
Date:   Tue, 5 Sep 2023 18:17:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 7/7] sched/fair: Fair server interface
To:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
References: <cover.1693510979.git.bristot@kernel.org>
 <db775d65b18ddac4a75faad6761c6c2abf3efb78.1693510979.git.bristot@kernel.org>
 <20230905135500.GB20703@noisy.programming.kicks-ass.net>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20230905135500.GB20703@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 15:55, Peter Zijlstra wrote:
> On Thu, Aug 31, 2023 at 10:28:58PM +0200, Daniel Bristot de Oliveira wrote:
>> +static ssize_t
>> +sched_fair_server_runtime_write(struct file *filp, const char __user *ubuf,
>> +				size_t cnt, loff_t *ppos)
>> +{
>> +	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
>> +	struct rq *rq = cpu_rq(cpu);
>> +	unsigned long flags;
>> +	u64 runtime;
>> +	int err;
>> +
>> +	err = kstrtoull_from_user(ubuf, cnt, 10, &runtime);
>> +	if (err)
>> +		return err;
>> +
>> +	raw_spin_rq_lock_irqsave(rq, flags);
>> +	if (runtime > rq->fair_server.dl_period)
>> +		err = -EINVAL;
>> +	else
>> +		rq->fair_server.dl_runtime = runtime;
>> +	raw_spin_rq_unlock_irqrestore(rq, flags);
>> +
>> +	if (err)
>> +		return err;
>> +
>> +	*ppos += cnt;
>> +	return cnt;
>> +}
> 
>> +static ssize_t
>> +sched_fair_server_period_write(struct file *filp, const char __user *ubuf,
>> +			       size_t cnt, loff_t *ppos)
>> +{
>> +	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
>> +	struct rq *rq = cpu_rq(cpu);
>> +	unsigned long flags;
>> +	u64 period;
>> +	int err;
>> +
>> +	err = kstrtoull_from_user(ubuf, cnt, 10, &period);
>> +	if (err)
>> +		return err;
>> +
>> +	if (period < fair_server_period_min || period > fair_server_period_max)
>> +		return -EINVAL;
>> +
>> +	raw_spin_rq_lock_irqsave(rq, flags);
>> +	if (period < rq->fair_server.dl_runtime)
>> +		err = -EINVAL;
>> +	else
>> +		rq->fair_server.dl_period = period;
>> +	raw_spin_rq_unlock_irqrestore(rq, flags);
>> +
>> +	if (err)
>> +		return err;
>> +
>> +	*ppos += cnt;
>> +	return cnt;
>> +}
> 
>> +static ssize_t
>> +sched_fair_server_defer_write(struct file *filp, const char __user *ubuf,
>> +			      size_t cnt, loff_t *ppos)
>> +{
>> +	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
>> +	struct rq *rq = cpu_rq(cpu);
>> +	unsigned long flags;
>> +	u64 defer;
>> +	int err;
>> +
>> +	err = kstrtoull_from_user(ubuf, cnt, 10, &defer);
>> +	if (err)
>> +		return err;
>> +
>> +	if (defer < 0 || defer > 1)
>> +		return -EINVAL;
>> +
>> +	raw_spin_rq_lock_irqsave(rq, flags);
>> +	rq->fair_server_defer = defer;
>> +	raw_spin_rq_unlock_irqrestore(rq, flags);
>> +
>> +	*ppos += cnt;
>> +	return cnt;
>> +}
> 
> Surely we can write a single function that does all of that with less
> duplication?

I agree, I will use your code as starting point for that...

> 
> Additionally, should not the deadline parameters be vetted by access
> control before being accepted ?

like security_task_getscheduler(p)? But we have no p...

I checked rt throttling, but it seems that it does not check. Do you have
a pointer?

-- Daniel

