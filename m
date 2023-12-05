Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C7C804328
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbjLEAN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjLEAN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:13:56 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B470BB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 16:14:02 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-357d0d15b29so23135ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 16:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701735241; x=1702340041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLzSL3Jb2F9LTZ1ZEdqtxXNYWjmxNxgFEpLbnW87rzA=;
        b=muTkysTKQKgWIDFMM04bENVqf5fJOCka66aSBxOgwNu5HJnw9npUg1N0ILUH/RhPRJ
         py2qD6gQ7zP0eV9IgFzjj79vixSUEiZOzjVLcdaAgQp/xn2Rd1wqpMESseFR2V+kjyZm
         IEhr/0cKJ1wiU+fAlK6LnOcPevMMiztFIIJtE0qaWfhWG9OZtXJUM27QeHAHfn1flA12
         NgBBnpaZM46nipukfKOvg9GacC4WUzaLDACLP4Mwy1qBImW7K3HxRSXtoxLs3Fn//crP
         qOaQrjCp0yjdBaLI1dlPbTNgdy4nnaXE0RQvazvYTVkE/MwN6oz4km0LTGd1iyRDkx1L
         vxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701735241; x=1702340041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLzSL3Jb2F9LTZ1ZEdqtxXNYWjmxNxgFEpLbnW87rzA=;
        b=aiX5+klPuYfC7FXqBJdFhmoFeJ45kEA3Ha3x6JLqpunQBDFqqJFmwQCGP06l1LLKLm
         NmDUQqRN2kFF8fvuVLzI6wQBI8XtMRw4ISUsHMPLKzsrElw8vmD+wGzafjSs/zm9+FQU
         A9KMWYsrrRvAMKCztNo/nRIbwtyo3sHZ4L0NVru4QXbitvqQ2hs9a7KFWfdwj4eA+yoT
         3RVEMwzkmIr/p3WC24YJU7sP67x1MD0tTLCW3ZKuarQzXmJk/tI5Tdtm8jBmObNjTJRk
         3S05FSobEqWQ1Hen5oxesTD2oHb7fDgOh3PcX/WpKLgePi5cv4WjCEeUZr4X9hePZ9IB
         uLIw==
X-Gm-Message-State: AOJu0YwbJiasd99PMLht4FicU8lpYlQqTPSvIasyi5XwrXaIt0Jio/26
        q1cY0eNk24YpUR25uRKidybW1YGLfWwM9ZROM8P0dw==
X-Google-Smtp-Source: AGHT+IH8HxG66gT32D+ljPbvRX7VBCTwj3rltRGlf2BI6abzHjWnqopDCLis88Tlkv12mol+a6As9pNOzWyU7qFD4Hg=
X-Received: by 2002:a05:6e02:3207:b0:35c:efe7:e9fa with SMTP id
 cd7-20020a056e02320700b0035cefe7e9famr753391ilb.23.1701735241297; Mon, 04 Dec
 2023 16:14:01 -0800 (PST)
MIME-Version: 1.0
References: <20231201005720.235639-1-babu.moger@amd.com>
In-Reply-To: <20231201005720.235639-1-babu.moger@amd.com>
From:   Peter Newman <peternewman@google.com>
Date:   Mon, 4 Dec 2023 16:13:50 -0800
Message-ID: <CALPaoCgZ=eXJj4xVsy9x8a39cpPv+3LDF0KS0RKuTknn5k=9VA@mail.gmail.com>
Subject: Re: [PATCH 00/15] x86/resctrl : Support AMD QoS RMID Pinning feature
To:     James Morse <james.morse@arm.com>
Cc:     corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
        peterz@infradead.org, seanjc@google.com, kim.phillips@amd.com,
        jmattson@google.com, ilpo.jarvinen@linux.intel.com,
        jithu.joseph@intel.com, kan.liang@linux.intel.com, nikunj@amd.com,
        daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
        rick.p.edgecombe@intel.com, rppt@kernel.org,
        maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com, dhagiani@amd.com,
        Babu Moger <babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+James]

Hi James,

On Thu, Nov 30, 2023 at 4:57=E2=80=AFPM Babu Moger <babu.moger@amd.com> wro=
te:
>
> These series adds the support for AMD QoS RMID Pinning feature. It is als=
o
> called ABMC (Assignable Bandwidth Monitoring Counters) feature.
>
> The feature details are available in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC). The documentation is available at
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537
>
> The patches are based on top of commit
> 346887b65d89ae987698bc1efd8e5536bd180b3f (tip/master)
>
> # Introduction
>
> AMD hardware can support 256 or more RMIDs. However, bandwidth monitoring
> feature only guarantees that RMIDs currently assigned to a processor will
> be tracked by hardware. The counters of any other RMIDs which are no
> longer being tracked will be reset to zero. The MBM event counters return
> "Unavailable" for the RMIDs that are not active.
>
> Users can create 256 or more monitor groups. But there can be only limite=
d
> number of groups that can be give guaranteed monitoring numbers. With eve=
r
> changing system configuration, there is no way to definitely know which o=
f
> these groups will be active for certain point of time. Users do not have
> the option to monitor a group or set of groups for certain period of time
> without worrying about RMID being reset in between.
>
> The ABMC feature provides an option to pin (or assign) the RMID to the
> hardware counter and monitor the bandwidth for a longer duration. The
> pinned RMID will be active until the user unpins (or unassigns) it.  Ther=
e
> is no need to worry about counters being reset during this period.
> Additionally, the user can specify a bitmask identifying the specific
> bandwidth types from the given source to track with the counter.
>
> # Linux Implementation
>
> Hardware provides total of 32 counters available for assignment.
> Each Linux resctrl group can be assigned a maximum of 2 counters. One for
> mbm_total_bytes and one for mbm_local_bytes. Users also have the option t=
o
> assign only one counter to the group. If the system runs out of assignabl=
e
> counters, the kernel will display the error when the user attempts a new
> counter assignment. Users need to unassign already used counters for new
> assignments.
>
> # Examples
>
> a. Check if ABMC support is available
>         #mount -t resctrl resctrl /sys/fs/resctrl/
>         #cat /sys/fs/resctrl/info/L3_MON/mon_features
>         llc_occupancy
>         mbm_total_bytes
>         mbm_total_bytes_config
>         mbm_local_bytes
>         mbm_local_bytes_config
>         abmc_capable =E2=86=90  Linux kernel detected ABMC feature.
>
> b. Mount with ABMC support
>         #umount /sys/fs/resctrl/
>         #mount  -o abmc -t resctrl resctrl /sys/fs/resctrl/
>
> c. Read the monitor states. There will be new file "monitor_state"
>    for each monitor group when ABMC feature is enabled. By default,
>    both total and local MBM events are in "unassign" state.
>
>         #cat /sys/fs/resctrl/monitor_state
>         total=3Dunassign;local=3Dunassign
>
> d. Read the event mbm_total_bytes and mbm_local_bytes. Note that MBA
>    events are not available until the user assigns the events explicitly.
>    Users need to assign the counters to monitor the events in this mode.
>
>         #cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>         Unavailable
>
>         #cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>         Unavailable
>
> e. Assign a h/w counter to the total event and read the monitor_state.
>
>         #echo total=3Dassign > /sys/fs/resctrl/monitor_state
>         #cat /sys/fs/resctrl/monitor_state
>         total=3Dassign;local=3Dunassign
>
> f. Now that the total event is assigned. Read the total event.
>
>         #cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>         6136000
>
> g. Assign a h/w counter to both total and local events and read the monit=
or_state.
>
>         #echo "total=3Dassign;local=3Dassign" > /sys/fs/resctrl/monitor_s=
tate
>         #cat /sys/fs/resctrl/monitor_state
>         total=3Dassign;local=3Dassign
>
> h. Now that both total and local events are  assigned, read the events.
>
>         #cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>         6136000
>         #cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>         58694

We had briefly discussed this topic of explicit counter assignment in
resctrl earlier this year[1], but you didn't want it to be unique to
MPAM.

Now that a similar capability exists on AMD and an interface is being
proposed, we can talk about this in the context of MPAM again.

With some generalization and refinements, I expect this proposal could
be applied to assigning a limited number of MBWU monitors to
monitoring groups.

Also, I had proposed in another thread[2] applying such an interface
to previous AMD hardware where the monitor assignments cannot be
directly controlled to avoid or reduce the overhead in my soft RMID
proposal.

Thanks!
-Peter

[1] https://lore.kernel.org/all/f8a25b5f-4a7d-0891-1152-33f349059b5d@arm.co=
m/
[2] https://lore.kernel.org/all/CALPaoCjg-W3w8OKLHP_g6Evoo03fbgaOQZrGTLX6vd=
SLp70=3DSA@mail.gmail.com/
