Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBA979E404
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239391AbjIMJok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239390AbjIMJoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:44:37 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C33199E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:44:33 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6c0822f46a1so4383424a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694598273; x=1695203073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWFwqBTg42FzEjeZenH3abFymmd/sjkvDp9dR8Hpb+I=;
        b=Ts48pPJ+8OtzPYlWMJx/vSU4pLkmtB4PPgiFYJA1tm8blBYR7qXflVCInOyZ/mKg0r
         U4+Gk60O8yUNS9+4fsZyAasmuOC08nH+f3rHnnW19Gha46UKznLXtcR54fyn9YQe/pFX
         R5oti7pQ8MDt13PBY2k0oxVp6P5voVGGLVF7qqUlnMcWGsvxAjGZtRm0gjACxLwFIqPl
         rnUTYneQquO71wy3CKekgyonKLy1AsoIoirmiECfNtS+OiHLj6w2kXJOGMPMy4W0P9KN
         44Zz7Kfju9GV0638sW1ITBkY0ABP78Ttm1T9yRqYKb0wGQBZnZyH401NSf6W1F+JRjsj
         sNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694598273; x=1695203073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWFwqBTg42FzEjeZenH3abFymmd/sjkvDp9dR8Hpb+I=;
        b=kTyzYArTrT3dFVizHQpuTYUHm5MhZrD47T6gzMm6ZSaL3UmL9GJBQPekYrnLrGgc3v
         P4SwHBGlNKbpe2jfFpMsoowg/DrWCbFrD/6TrbSkzJmdWrNo1tzLDevyDYOY43qncnI2
         4rGMqqotgQtWkwLvB0Q/e9a0qansvuTUUmTksfAliaWnRt7iktIaigHMK94Asv29XFbb
         owlu1Ac5xqHpXGvNw771riuk53e/coCd3FC+e06AhNvAgyqGGG3Cqp2JBARR6NUr5GxE
         kcCM76PtyqrpxWUNgLkBu1bGEd2Tspv1dRHiB/ge2o+KXJL5uaCwdkUC5OJucdHMVv/L
         kqHg==
X-Gm-Message-State: AOJu0Ywd+j9zSicmPbhV+LHipGZYBAOy0flRur9tN1w6uiQuKzdNlA6Z
        F1Kl8tX3Yn9SJPWB2edasZ74bQ==
X-Google-Smtp-Source: AGHT+IEzsIpJlV/49NAghRov86goyt9rsAYRDsP4bYudI9e8SJcY1zheqBcLVqc74vCe3iV8uDLOWA==
X-Received: by 2002:a05:6358:2906:b0:13a:a094:737d with SMTP id y6-20020a056358290600b0013aa094737dmr2198056rwb.18.1694598272723;
        Wed, 13 Sep 2023 02:44:32 -0700 (PDT)
Received: from PF2LML5M-SMJ.bytedance.net ([220.243.131.6])
        by smtp.gmail.com with ESMTPSA id 3-20020a056a00070300b00689f1ce7dacsm4989474pfl.23.2023.09.13.02.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 02:44:32 -0700 (PDT)
From:   guojinhui <guojinhui.liam@bytedance.com>
To:     robin.murphy@arm.com
Cc:     catalin.marinas@arm.com, guojinhui.liam@bytedance.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, will@kernel.org
Subject: Re: [PATCH] arm64: cpufeature: Expose the real mpidr value to EL0
Date:   Wed, 13 Sep 2023 17:44:26 +0800
Message-Id: <20230913094426.2787-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <759c91b9-856e-a778-0e0a-e52240e5c8ce@arm.com>
References: <759c91b9-856e-a778-0e0a-e52240e5c8ce@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > In EL0, it can get the register midr's value to distinguish vendor.
> > But it won't return real value of the register mpidr by using mrs
> > in EL0. The register mpidr's value is useful to obtain the cpu
> > topology information.
> 
> ...except there's no guarantee that the MPIDR value is anything other 
> than a unique identifier. Proper topology information is already exposed 
> to userspace[1], as described by ACPI PPTT or Devicetree[2]. Userspace 
> should be using that.
> 
> Not to mention that userspace fundamentally can't guarantee it won't be 
> migrated at just the wrong point and read the MPIDR of a different CPU 
> anyway. (This is why the MIDRs and REVIDRs are also reported via sysfs, 
> such that userspace has a stable and reliable source of information in 
> case it needs to consider potential errata.)
> 
> Thanks,
> Robin.
> 
> [1] https://www.kernel.org/doc/html/latest/admin-guide/cputopology.html
> [2] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/cpu/cpu-topology.txt

1. If we can get the infomation of the vendor (by MIDR), i think it possible to obtain
the die infomation from the MPIDR value. Such as the kunpeng-920, 
4 cores per cluster, 8 clusters per die, whose MPIDR value is as follow:

```
<DIE>.<CLUSTER>.<CORE>.<HT>

cpu = 0, 81080000
cpu = 1, 81080100
...
cpu = 3, 81080300
cpu = 4, 81090000
...
cpu = 7, 81090300
cpu = 8, 810a0000
...
cpu = 11, 810a0300
cpu = 12, 810b0000
...
cpu = 15, 810b0300
cpu = 16, 810c0000
...
cpu = 19, 810c0300
cpu = 20, 810d0000
...
cpu = 31, 810f0300
cpu = 32, 81180000
...
cpu = 63, 811f0300
```

we can get the die infomation by 0x810, 0x811.

2. we can bind the task to the specific cpu to obtain the MPIDR value.

3. I have checked the sysfs interface `/sys/devices/system/cpu/cpuN/topology/*`
in Ampere and kunpeng-920 with the latest linux kernel before i submit the patch,
but it doesn't provide the information of die.

```
# ls /sys/devices/system/cpu/cpu0/topology/
cluster_cpus  cluster_cpus_list  cluster_id  core_cpus  core_cpus_list  core_id  core_siblings  core_siblings_list  package_cpus  package_cpus_list  physical_package_id  thread_siblings  thread_siblings_list
# cat /sys/devices/system/cpu/cpu0/topology/*
00000000,00000000,00000000,00000003
0-1
616
00000000,00000000,00000000,00000001
0
6656
00000000,00000000,ffffffff,ffffffff
0-63
00000000,00000000,ffffffff,ffffffff
0-63
0
00000000,00000000,00000000,00000001
0

# uname -r
6.6.0-rc1
```

Then I check the code which parses the cpu topology infomation from PPTT:

```
int __init parse_acpi_topology(void)
{
        int cpu, topology_id;

        if (acpi_disabled)
                return 0;

        for_each_possible_cpu(cpu) {
                topology_id = find_acpi_cpu_topology(cpu, 0);
                if (topology_id < 0)
                        return topology_id;

                if (acpi_cpu_is_threaded(cpu)) {
                        cpu_topology[cpu].thread_id = topology_id;
                        topology_id = find_acpi_cpu_topology(cpu, 1);
                        cpu_topology[cpu].core_id   = topology_id;
                } else {
                        cpu_topology[cpu].thread_id  = -1;
                        cpu_topology[cpu].core_id    = topology_id;
                }
                topology_id = find_acpi_cpu_topology_cluster(cpu);
                cpu_topology[cpu].cluster_id = topology_id;
                topology_id = find_acpi_cpu_topology_package(cpu);
                cpu_topology[cpu].package_id = topology_id;
        }

        return 0;
}
```

Actually, it just gives the infomation of thread, cluster and package
though the PPTT provides the dies infomation.

May be we can implement some code to obtain die information from PPTT?

thanks,

guojinhui
