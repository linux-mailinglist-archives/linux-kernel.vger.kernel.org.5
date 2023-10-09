Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE3E7BE412
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376486AbjJIPNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376462AbjJIPM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F999E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696864329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lX/vBylIcMRc9YIP8k3FhefyCrF4dn1ywLpr16JKJDY=;
        b=TDHml3m5vpwN0eEGxPzeBvvJAKJgDicjZwyPD3bvFe1Ef9Cskw1njxt7qxFn8ehkNl7XAk
        +2JhKyfEbI5/RDTOpoq5bbej5HPvTRf8IPRdOjLk8aOKiGl7yAk5TzsSO0WczZaATGq/Gi
        AiLY44J3PgvEiD900+izg1gX/8sRDrg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-eo28g_okPhiASTwe-EOMPw-1; Mon, 09 Oct 2023 11:11:58 -0400
X-MC-Unique: eo28g_okPhiASTwe-EOMPw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6557c921deeso58228136d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 08:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696864318; x=1697469118;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lX/vBylIcMRc9YIP8k3FhefyCrF4dn1ywLpr16JKJDY=;
        b=OP6AwoeCBEUX/L2m9xQ3lwNrdqtUh1KWMXk/YYRNPivmi3btY3oQ11S5Svd7Sh5dLt
         AvgiQWT8iIGf7W+QX0uKaebHePZtCVgqG5m/8axtSAh63rBe+e+n/QjuMDLvii+JiECH
         Tb8ojXF+yeUd9wpiOPxc/fbUM/xcYzazVVESumFWxzgABr0Ba+j4An1NkeQjUc/AzzJl
         9CfcyWR8YdAsWwRID1lh9XHTA86s9fk1c+Fu2rWX/OENe8XWTSaGRZY+YxL/GbTJ6vQG
         g+i4C2OHD5AfDcknGSv+ocktVCEyBbAn99KLbZfaFLKJK4LWDp93RyvXd2LCTYO6LYJY
         77cg==
X-Gm-Message-State: AOJu0YxXjhI7xjW35dd65L2yschTcmlouZ0LG9VpNg66XB0fJbsWPZLy
        +tC3pyPYyeYMcV785lgfFHZW13FXlNDhIdidbVvzOebmqrU6yTCc60NJdmGWSTNSj+MyC+JdIrX
        8TF/St6F9NUN8zBUhEds7MvKf
X-Received: by 2002:a05:6214:2e49:b0:656:3407:f45a with SMTP id my9-20020a0562142e4900b006563407f45amr15525003qvb.43.1696864318035;
        Mon, 09 Oct 2023 08:11:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/1BySsGQEAJeeI+xmu1ENP9J3+lv+CYkF6JvxfeJwxeLVI9sdGAthMMXTBzldIOSbkvkA0g==
X-Received: by 2002:a05:6214:2e49:b0:656:3407:f45a with SMTP id my9-20020a0562142e4900b006563407f45amr15524991qvb.43.1696864317829;
        Mon, 09 Oct 2023 08:11:57 -0700 (PDT)
Received: from vschneid.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id w25-20020a0cb559000000b0065af366bdc1sm3909353qvd.103.2023.10.09.08.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:11:57 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/3] sched/nohz: Remove weird error handling from
 find_new_ilb()
In-Reply-To: <ZR/o8+EJGLMi3uPr@gmail.com>
References: <20231006102518.2452758-1-mingo@kernel.org>
 <20231006102518.2452758-4-mingo@kernel.org>
 <20231006103858.GB36277@noisy.programming.kicks-ass.net>
 <ZR/o8+EJGLMi3uPr@gmail.com>
Date:   Mon, 09 Oct 2023 17:11:53 +0200
Message-ID: <xhsmhh6mzomo6.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/23 13:01, Ingo Molnar wrote:
> * Peter Zijlstra <peterz@infradead.org> wrote:
>
>> On Fri, Oct 06, 2023 at 12:25:18PM +0200, Ingo Molnar wrote:
>> > find_new_ilb() returns nr_cpu_ids on failure - which is a weird
>> > choice in itself: not only is it a global variable, it is
>> > a +1 out of bounds CPU index...
>> 
>> FWIW this is what all the cpumask bitops return when they've exhausted
>> the mask. Eg. no bits left set etc..
>
> yeah, which then results in type-forcing uglies like:
>
>    kernel/events/core.c:	if ((unsigned)cpu >= nr_cpu_ids) {
>    kernel/events/core.c:   if ((unsigned)cpu >= nr_cpu_ids) {
>    kernel/smp.c:	   if ((unsigned)cpu >= nr_cpu_ids || !cpu_online(cpu)) {

I can't see why we'd want smp_call_function_single*() /
generic_exec_single() to take a signed int as input, shouldn't this just be
unsigned?

The perf thing does look like it wants signed though...

>
> :-/
>
> So I don't think this is a particularly well thought-out interface.
>
> Thanks,
>
> 	Ingo

