Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD3E7A1DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjIOMBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjIOMBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:01:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FFDECD8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694779220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t6AwsMQcTgK8IfZg/kAHcCA4w1VQf5DoeNfYEwAMbTw=;
        b=il5zaZv9g0YMzm1fFSZax5UHVWlqwFoFt4aLdSj+Kp/IPVBx20A4l/0qH/14l0mHYbg295
        +z+7bHaY05q86yHn48hQGldeuSVGF7/VpEb0L+u9uqsyodPp9Xf+I6mt6Ydt+oLIv0ygbS
        PfJ0OHdQ5FS7WZXSJlnI03B0PJQsjQQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-dhenyAccNAO54-i88cn7jA-1; Fri, 15 Sep 2023 08:00:19 -0400
X-MC-Unique: dhenyAccNAO54-i88cn7jA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-401e1c55ddcso16170955e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694779218; x=1695384018;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6AwsMQcTgK8IfZg/kAHcCA4w1VQf5DoeNfYEwAMbTw=;
        b=cnuWYR9ub5sFlbwrz4gBC17pomRvzaB6g48Ye5ixOMJpHd1XDVPEO/PHtOZzyFVEx8
         OtTb85cjDnLhDEkDhfltJlViwNDzwOgF/R8/z0zFKvLfW7GzKMRqaOwuVU/nZvggFT0Q
         17OOkxyaT8mm15794T9Q06iMwI9b4jaq6u45gF1CaD5HqrWJ8K//2XXa9UoPGrCV31K8
         igzkpTmfaGzrnLvCdzYQk40mLKX9KKUZ9oJyIX67nHo3QVRrmKOiF6j7EPAnOg5liBbE
         FXOPIAnlNyGgK66rxYXPlFSHMSjKaLyj0jfXi0Kqx14Zx9ASdKi5SunUawCfa7TCwz5a
         oMFg==
X-Gm-Message-State: AOJu0YwDgFAECIw+ogR7bL1No255LRJcZ9sl0Usw2u+EydtTe5Bg8bKj
        T235UJ1737wU4mjo/4/BBYPA/yjJUCFQA5H22arNVhEdGUhDsJTCcEZcI25qpbPHAmj1MzUSOso
        mpbtPCe0na2IGEHGVue2XowYS
X-Received: by 2002:a5d:5a97:0:b0:31f:fa1d:898 with SMTP id bp23-20020a5d5a97000000b0031ffa1d0898mr228960wrb.47.1694779217982;
        Fri, 15 Sep 2023 05:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD7fftI1tqIF0eF1TI3kJepSK+X7LF8u3Z2fQV1hk6iym525HU0w3zgYNysKavuVyNk1v9Og==
X-Received: by 2002:a5d:5a97:0:b0:31f:fa1d:898 with SMTP id bp23-20020a5d5a97000000b0031ffa1d0898mr228933wrb.47.1694779217663;
        Fri, 15 Sep 2023 05:00:17 -0700 (PDT)
Received: from vschneid.remote.csb (anice-256-1-26-111.w86-203.abo.wanadoo.fr. [86.203.135.111])
        by smtp.gmail.com with ESMTPSA id q30-20020adfab1e000000b003177074f830sm2809337wrc.59.2023.09.15.05.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:00:17 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, quentin.perret@arm.com,
        srikar@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, pierre.gondois@arm.com, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v3] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
In-Reply-To: <7c6dd2ec-b9a9-b364-5a29-05336127e519@linux.vnet.ibm.com>
References: <20230913114807.665094-1-sshegde@linux.vnet.ibm.com>
 <xhsmhil8cvi7s.mognet@vschneid.remote.csb>
 <7c6dd2ec-b9a9-b364-5a29-05336127e519@linux.vnet.ibm.com>
Date:   Fri, 15 Sep 2023 14:00:15 +0200
Message-ID: <xhsmhfs3fve7k.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/23 23:26, Shrikanth Hegde wrote:
> On 9/14/23 9:51 PM, Valentin Schneider wrote:
>> On 13/09/23 17:18, Shrikanth Hegde wrote:
>>> sysctl_sched_energy_aware is available for the admin to disable/enable
>>> energy aware scheduling(EAS). EAS is enabled only if few conditions are
>>> met by the platform. They are, asymmetric CPU capacity, no SMT,
>>> valid cpufreq policy, frequency invariant load tracking. It is possible
>>> platform when booting may not have EAS capability, but can do that after.
>>> For example, changing/registering the cpufreq policy.
>>>
>>> At present, though platform doesn't support EAS, this sysctl is still
>>> present and it ends up calling rebuild of sched domain on write to 1 and
>>> NOP when writing to 0. That is confusing and un-necessary.
>>>
>>
>
> Hi Valentin, Thanks for taking a look at this patch.
>
>> But why would you write to it in the first place? Or do you mean to use
>> this as an indicator for userspace that EAS is supported?
>>
>
> Since this sysctl is present and its value being 1, it gives the
> impression to the user that EAS is supported when it is not.
> So its an attempt to correct that part.
>

Ah, I see. Then how about just making the sysctl return 0 when EAS isn't
supported? And on top of it, prevent all writes when EAS isn't supported
(perf domains cannot be built, so there would be no point in forcing a
rebuild that will do nothing).

I can never remember how to properly use the sysctl API, so that's a very
crude implementation, but something like so?

---

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 05a5bc678c089..dadfc5afc4121 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -230,9 +230,28 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
 	if (write && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (!sched_energy_enabled()) {
+		if (write)
+			return -EOPNOTSUPP;
+		else {
+			size_t len;
+
+			if (*ppos) {
+				*lenp = 0;
+				return 0;
+			}
+
+			len = snprintf((char *)buffer, 3, "0\n");
+
+			*lenp = len;
+			*ppos += len;
+			return 0;
+		}
+	}
+
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (!ret && write) {
-		state = static_branch_unlikely(&sched_energy_present);
+		state = sched_energy_enabled();
 		if (state != sysctl_sched_energy_aware)
 			rebuild_sched_domains_energy();
 	}

