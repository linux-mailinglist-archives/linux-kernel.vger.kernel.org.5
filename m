Return-Path: <linux-kernel+bounces-130159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03CA8974C4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5611F23C2E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C7314D42F;
	Wed,  3 Apr 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjV6Zyh/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8414D2A1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160142; cv=none; b=KXI9GecbOTnF6bzUO+lWOLHhtwT2T1FjthUyjz9y5go73ymyHDBB0HQbR0Dbnbb4tn4HYPs1WKTwfICBS0j4KTOjL+sknagJyJJ36IXzM23TQw9KG9LoavvVUvBqxjmPfgKIUUzJ9A6l+s1rTUkjKzduOqfTEcmGDtOU+oOsLAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160142; c=relaxed/simple;
	bh=EtQkIfas5F975pCNmO5rwqnv2ceEeeJPPr3zzLdQc80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b4HVkB7KG/MZFYc/qimy9Vngev0yBSHSJCdV7VmE/P20nJF/9rDB2km66NXsgj6Kr8DZLoR74Q2CWhIDauZEcJlWU0CuT2/Zkh4ZBzuJRzDqBSffi2q7aTaU8cn1J/Snawx/FpLjyVSLjGPJ8FFXLChYmJrTsjf9Ipa/0ZLfor8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UjV6Zyh/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712160139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZpJ0IxiRlaFYwJ6F+30f6cESCy9pq69KzZZhi/luDY=;
	b=UjV6Zyh/QdpDuZWk5mjKYWuLTDX8dZutrXu3KLZVd7xrua3k01giJCMhBlUkmhYC9AqFnT
	CwbTaQ+S3+XQpc+xXVvPdrNSKGfyqDSh7795Xeafypqva2y64IJJDr7+2rQ6zavIQktV/C
	zYlF+pXqd+eSfINBqkL6IoL2UZPlXBM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-NuSPCKfjM8aEZIePAIsUdg-1; Wed, 03 Apr 2024 12:02:17 -0400
X-MC-Unique: NuSPCKfjM8aEZIePAIsUdg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78bd232b170so504950285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 09:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712160135; x=1712764935;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZpJ0IxiRlaFYwJ6F+30f6cESCy9pq69KzZZhi/luDY=;
        b=WRVNTOinKrcvZPvL0edCHs1sDvR639XriJmiKrUmFigNCREAF88FQ5oSA1IM5g/BPy
         LpHA6hqI6aw4vCae7HKuUzrLmUGys95VaK/mqz8WIPmSqmosDDOwtS0AYz8NE8xAO8Xy
         tp9dpQ30fNP/5uxH/yAeGyJvmcpHeUGYhrd0eAUrOfXNuosbzx+AluRGWyYWNWBXaxzk
         ZvLNEMTmDAzqmMiVJw9hZOP6AUSX8ksoR4xkUovTqYcNMfg0h2XMXEMQaYJtTe1Jb2XF
         5Soxx/wUkL3sGtJCsnRXLr+mYMfbUShM6xNq5ECaFI6sPSODiPYaV+qEJVEqGvEYtDOz
         z6+A==
X-Forwarded-Encrypted: i=1; AJvYcCVSHvlIhirktWImzgC/59fvBfgkFZHvdpIZckzxs8UW2vFxLLeUCd5h+6O/IxRT1htCG1+dQWzC0178H0vknw2eP0M7Tui152WatwGU
X-Gm-Message-State: AOJu0YzKBceLWFdvARJM4Jf9zQO3mzczmfyusUyzZbTmGro8ksI4Sy4x
	bFK5uyv9L2mbNQYCzSnKmIyTjWmVuR04m6dP2P7zsGb5KvZ0QUIcQrp33U0HCzTO0hgELN3VcYF
	W1sIZXUH3JZMrRLEHlOQuGSyxAGXjzw4llbds5gyM4n0ZR2basa55WuyI584C3lLXKewOkw==
X-Received: by 2002:a05:620a:5841:b0:78a:69ab:e829 with SMTP id wn1-20020a05620a584100b0078a69abe829mr16850038qkn.68.1712160135677;
        Wed, 03 Apr 2024 09:02:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdnSbhhYZso0CoMvpl3Y3IaXvHWWX8w91ZynzApMi1NN5iXhRNBBdqMmiccCfrAXTIF7H8gA==
X-Received: by 2002:a05:620a:5841:b0:78a:69ab:e829 with SMTP id wn1-20020a05620a584100b0078a69abe829mr16849993qkn.68.1712160135251;
        Wed, 03 Apr 2024 09:02:15 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id pe30-20020a05620a851e00b00789f5a04b3esm5123833qkn.58.2024.04.03.09.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 09:02:14 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Zefan Li
 <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, Thomas
 Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, Frederic
 Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Alex Shi <alexs@kernel.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: Re: [PATCH 1/2] cgroup/cpuset: Make cpuset hotplug processing
 synchronous
In-Reply-To: <mhwbjfm3zsoinm2eozz6d7djtflf6tbpmfzsbbsscv3u5aijtr@p2edxl6voxoa>
References: <20240401145858.2656598-1-longman@redhat.com>
 <20240401145858.2656598-2-longman@redhat.com>
 <kce74bx6aafxfuw5yovaschym4ze4kommfk74eq5totojytest@mdxnfvl2kdol>
 <548efd52-e45f-41fa-a477-bc5112d7b00c@redhat.com>
 <u3naomgv34t5rnc7pmyy4zjppgf36skeo45orss2xnqcvtrcez@m74tsl2ws76f>
 <7e62b37d-6c9c-4e55-a01a-175695475cb5@redhat.com>
 <xhsmhedbmbjz5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <mhwbjfm3zsoinm2eozz6d7djtflf6tbpmfzsbbsscv3u5aijtr@p2edxl6voxoa>
Date: Wed, 03 Apr 2024 18:02:10 +0200
Message-ID: <xhsmhbk6qbfjx.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/04/24 16:54, Michal Koutn=C3=BD wrote:
> On Wed, Apr 03, 2024 at 04:26:38PM +0200, Valentin Schneider <vschneid@re=
dhat.com> wrote:
>> Also, I gave Michal's patch a try and it looks like it's introducing a
>
> Thank you.
>
>>   cgroup_threadgroup_rwsem -> cpuset_mutex
>> ordering from
>>   cgroup_transfer_tasks_locked()
>>   `\
>>     percpu_down_write(&cgroup_threadgroup_rwsem);
>>     cgroup_migrate()
>>     `\
>>       cgroup_migrate_execute()
>>       `\
>>         ss->can_attach() // cpuset_can_attach()
>>         `\
>>           mutex_lock(&cpuset_mutex);
>>
>> which is invalid, see below.
>
> _This_ should be the right order (cpuset_mutex inside
> cgroup_threadgroup_rwsem), at least in my mental model. Thus I missed
> that cpuset_mutex must have been taken somewhere higher up in the
> hotplug code (CPU 0 in the lockdep dump, I can't easily see where from)
> :-/.
>

If I got this right...

    cpuset_hotplug_update_tasks()
    `\
      mutex_lock(&cpuset_mutex);
      hotplug_update_tasks_legacy()
      `\
        remove_tasks_in_empty_cpuset()
        `\
          cgroup_transfer_tasks_locked()
          `\
            percpu_down_write(&cgroup_threadgroup_rwsem);

But then that is also followed by:

            cgroup_migrate()
            `\
              cgroup_migrate_execute()
              `\
                ss->can_attach() // cpuset_can_attach()
                `\
                  mutex_lock(&cpuset_mutex);

which doesn't look good...


Also, I missed that earlier, but this triggers:

  cgroup_transfer_tasks_locked() ~> lockdep_assert_held(&cgroup_mutex);

[   30.773092] WARNING: CPU: 2 PID: 24 at kernel/cgroup/cgroup-v1.c:112 cgr=
oup_transfer_tasks_locked+0x39f/0x450
[   30.773807] Modules linked in:
[   30.774063] CPU: 2 PID: 24 Comm: cpuhp/2 Not tainted 6.9.0-rc1-00042-g84=
4178b616c7-dirty #25
[   30.774672] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   30.775457] RIP: 0010:cgroup_transfer_tasks_locked+0x39f/0x450
[   30.775891] Code: 0f 85 70 ff ff ff 0f 1f 44 00 00 e9 6d ff ff ff be ff =
ff ff ff 48 c7 c7 48 82 d6 82 e8 5a 6a ec 00 85 c0 0f 85 6d fd ff ff 90 <0f=
> 0b 90 e9 64 fd ff ff 48 8b bd e8 fe ff ff be 01 00 00 00 e8 78
[   30.777270] RSP: 0000:ffffc900000e7c20 EFLAGS: 00010246
[   30.777813] RAX: 0000000000000000 RBX: ffffc900000e7cb0 RCX: 00000000000=
00000
[   30.778443] RDX: 0000000000000000 RSI: ffffffff82d68248 RDI: ffff888004a=
9a300
[   30.779142] RBP: ffffc900000e7d50 R08: 0000000000000001 R09: 00000000000=
00000
[   30.779889] R10: ffffc900000e7d70 R11: 0000000000000001 R12: ffff8880057=
c6040
[   30.780420] R13: ffff88800539f800 R14: 0000000000000001 R15: 00000000000=
00004
[   30.780951] FS:  0000000000000000(0000) GS:ffff88801f500000(0000) knlGS:=
0000000000000000
[   30.781561] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.781989] CR2: 00000000f7e6fe85 CR3: 00000000064ac000 CR4: 00000000000=
006f0
[   30.782558] Call Trace:
[   30.782783]  <TASK>
[   30.782982]  ? __warn+0x87/0x180
[   30.783250]  ? cgroup_transfer_tasks_locked+0x39f/0x450
[   30.783644]  ? report_bug+0x164/0x190
[   30.783970]  ? handle_bug+0x3b/0x70
[   30.784288]  ? exc_invalid_op+0x17/0x70
[   30.784641]  ? asm_exc_invalid_op+0x1a/0x20
[   30.784992]  ? cgroup_transfer_tasks_locked+0x39f/0x450
[   30.785375]  ? __lock_acquire+0xe9d/0x16d0
[   30.785707]  ? cpuset_update_active_cpus+0x15a/0xca0
[   30.786074]  ? cpuset_update_active_cpus+0x782/0xca0
[   30.786443]  cpuset_update_active_cpus+0x782/0xca0
[   30.786816]  sched_cpu_deactivate+0x1ad/0x1d0
[   30.787148]  ? __pfx_sched_cpu_deactivate+0x10/0x10
[   30.787509]  cpuhp_invoke_callback+0x16b/0x6b0
[   30.787859]  ? cpuhp_thread_fun+0x56/0x240
[   30.788175]  cpuhp_thread_fun+0x1ba/0x240
[   30.788485]  smpboot_thread_fn+0xd8/0x1d0
[   30.788823]  ? __pfx_smpboot_thread_fn+0x10/0x10
[   30.789229]  kthread+0xce/0x100
[   30.789526]  ? __pfx_kthread+0x10/0x10
[   30.789876]  ret_from_fork+0x2f/0x50
[   30.790200]  ? __pfx_kthread+0x10/0x10
[   30.792341]  ret_from_fork_asm+0x1a/0x30
[   30.792716]  </TASK>

> Michal


