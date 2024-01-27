Return-Path: <linux-kernel+bounces-40945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA2783E8A2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D594B1F23BAD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B452433DD;
	Sat, 27 Jan 2024 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CSH2c6np"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037202573
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706316212; cv=none; b=kCp5lQX661j9nIUFB4SVwLvTnwggPaaWdmh5mL1cxOO9myTySkMODWNT7fE5ZvJIZ6IVRLiRywTIO7VgTXFIBQqbjmsfBDjgW5ehYwGotB0sqbx3uF2n3/8KUxO11q8ImTme5aOeKjKoNcQHRXRZle3yOq+LeM2bhYtAw2XfCSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706316212; c=relaxed/simple;
	bh=uZXq87fZbOy8X8X4YB3z0r7He7f5J2osNpl120Cy6vE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Eabb9DELHvCbt9HlORZWTwo3CrUTFd2X/V+51T9opPyabLJl1pHqkfs2NFlVM1bGMwXffL5CwOedoCUBazOFf5A5hmCaPZ47+mrM8unRK/RhY6gVLUGBlygIDdnoWSpdUL46YyjAK8jdXr4xuYPPy+RGYdtSXksZf9W1repG5og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CSH2c6np; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidai.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc652e598e5so833474276.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706316209; x=1706921009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g1l7DUVc1FSnM/OQ9KeypMMMXjP/pECxBMOU4nUGNfE=;
        b=CSH2c6npY7v27/x49lb8aqTrVJrwFw1WrPRnyQ5ZwCHqgmp9coj/dN//w944Ibehww
         phmjh0O/ik4xufjlnJkITiP43lOo+JvHobvTRf7X7izZknmzrVKnb2slHQuQopbWSxmn
         j2qbu9owynxgYOQMv3FvNivhqgcx9vB0WxETGyWIOl/6UAfJOuo+PMMQOHtBYTYTCEQr
         tl6lw/czA0tXokAJnhDkcX8tB2KmpHxL/VF2N+E0pK2zr4fB+8H14HLmCax3PT/neNvb
         83AhotF0+jPkVHN/MRsYULJf1UeaXFMYgCqEqrGVn+tWf2RUkxQqwHAixVjQ7oAvYiKE
         QRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706316209; x=1706921009;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1l7DUVc1FSnM/OQ9KeypMMMXjP/pECxBMOU4nUGNfE=;
        b=UeH9TXa6TwNx9NFqXHMtOITn66LehB8GhMF7Al2yU8+dKNPHw9+utOdI/ZfME7R8qo
         8dC1KK/enyn0iorQzMgFzFGOTqT8aM/HFJYlds4UZLADCQ+jJbYEYHfOXYcrwvCLGRAO
         hizL+rRVu1toibgKUjV4x1kCrai0kg7gShiImifxiAefuo0G9WcnutpSnxkVCatDQDvR
         3SZnMIE25Gg500FDXcpFG3EHJ0jG2mtWxG/20l0/+tumVbutuuHREoqo2siUudr2wh27
         Rd1XYiGYdxo2JwFlKGs8ku+gx2fpgAottWWLrxansHn7H8avCssvNxwo+5mr6wK0HaHp
         Twqg==
X-Gm-Message-State: AOJu0YxcOmndwfiAFkjHvscFKCHDcqC5gmjj/DBbdYsSRMIcZYUAHxUq
	W3gjOaTwUySjIoqVOEfpLHhvwCkJT9kTVF9Q36j6PmndLKg6W/Qxpla0XjsE4ILkx2e30TqACYa
	IkVdw3A==
X-Google-Smtp-Source: AGHT+IEyedawWdVp7uNmfPzCdW0L9+a+xzXw6ggkcgvxwlpzp7Ui6UQPEYnnzuU9P5+ntYS/1PmljDQQTZa0
X-Received: from davidai2.mtv.corp.google.com ([2620:15c:211:201:d621:88fa:6f6:1b46])
 (user=davidai job=sendgmr) by 2002:a25:9782:0:b0:dc6:587d:eba2 with SMTP id
 i2-20020a259782000000b00dc6587deba2mr40830ybo.12.1706316209063; Fri, 26 Jan
 2024 16:43:29 -0800 (PST)
Date: Fri, 26 Jan 2024 16:43:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240127004321.1902477-1-davidai@google.com>
Subject: [PATCH v5 0/2] Improve VM CPUfreq and task placement behavior
From: David Dai <davidai@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, David Dai <davidai@google.com>, 
	Saravana Kannan <saravanak@google.com>
Cc: Quentin Perret <qperret@google.com>, Masami Hiramatsu <mhiramat@google.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Pavan Kondeti <quic_pkondeti@quicinc.com>, Gupta Pankaj <pankaj.gupta@amd.com>, 
	Mel Gorman <mgorman@suse.de>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This patch series is a continuation of the talk Saravana gave at LPC 2022
titled "CPUfreq/sched and VM guest workload problems" [1][2][3]. The gist
of the talk is that workloads running in a guest VM get terrible task
placement and CPUfreq behavior when compared to running the same workload
in the host. Effectively, no EAS(Energy Aware Scheduling) for threads
inside VMs. This would make power and performance terrible just by running
the workload in a VM even if we assume there is zero virtualization
overhead.

With this series, a workload running in a VM gets the same task placement
and CPUfreq behavior as it would when running in the host.

The idea is to improve VM CPUfreq/sched behavior by:
- Having guest kernel do accurate load tracking by taking host CPU
  arch/type and frequency into account.
- Sharing vCPU frequency requirements with the host so that the
  host can do proper frequency scaling and task placement on the host side.

Based on feedback from RFC v1 proposal[4], we've revised our
implementation to using MMIO reads and writes to pass information
from/to host instead of using hypercalls. In our example, the
VMM(Virtual Machine Manager) translates the frequency requests into
Uclamp_min and applies it to the vCPU thread as a hint to the host
kernel.

To achieve the results below, configure the host to:
- Affine vCPUs to specific clusters.
- Set vCPU capacity to match the host CPU they are running on.

To make it easy for folks to try this out with CrosVM, we have put up
userspace patches[5][6]. With those patches, you can configure CrosVM
correctly by adding the options "--host-cpu-topology" and "--virt-cpufreq".

Results:
=3D=3D=3D=3D=3D=3D=3D=3D

Here are some side-by-side comparisons of RFC v1 proposal vs the current
patch series and are labelled as follows.

- (RFC v1) UtilHyp =3D hypercall + util_guest
- (current) UClampMMIO =3D MMIO + UClamp_min

Use cases running a minimal system inside a VM on a Pixel 6:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

FIO
Higher is better
+-------------------+----------+---------+--------+------------+--------+
| Usecase(avg MB/s) | Baseline | UtilHyp | %delta | UClampMMIO | %delta |
+-------------------+----------+---------+--------+------------+--------+
| Seq Write         |     13.3 |    16.4 |   +23% |       13.6 |    +2% |
+-------------------+----------+---------+--------+------------+--------+
| Rand Write        |     11.2 |    12.9 |   +15% |       11.8 |    +8% |
+-------------------+----------+---------+--------+------------+--------+
| Seq Read          |      100 |     168 |   +68% |        138 |   +38% |
+-------------------+----------+---------+--------+------------+--------+
| Rand Read         |     20.5 |    35.6 |   +74% |       31.0 |   +51% |
+-------------------+----------+---------+--------+------------+--------+

CPU-based ML Inference Benchmark
Lower is better
+----------------+----------+------------+--------+------------+--------+
| Test Case (ms) | Baseline | UtilHyp    | %delta | UClampMMIO | %delta |
+----------------+----------+------------+--------+------------+--------+
| Cached Sample  |          |            |        |            |        |
| Inference      |     3.40 |       2.37 |   -30% |       2.99 |   -12% |
+----------------+----------+------------+--------+------------+--------+
| Small Sample   |          |            |        |            |        |
| Inference      |     9.87 |       6.78 |   -31% |       7.65 |   -22% |
+----------------+----------+------------+--------+------------+--------+
| Large Sample   |          |            |        |            |        |
| Inference      |    33.35 |      26.74 |   -20% |      31.05 |    -7% |
+----------------+----------+------------+--------+------------+--------+

Use cases running Android inside a VM on a Chromebook:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

PCMark (Emulates real world usecases)
Higher is better
+-------------------+----------+---------+--------+------------+--------+
| Test Case (score) | Baseline | UtilHyp | %delta | UClampMMIO | %delta |
+-------------------+----------+---------+--------+------------+--------+
| Weighted Total    |     6190 |    7442 |   +20% |       7171 |   +16% |
+-------------------+----------+---------+--------+------------+--------+
| Web Browsing      |     5461 |    6620 |   +21% |       6284 |   +15% |
+-------------------+----------+---------+--------+------------+--------+
| Video Editing     |     4891 |    5376 |   +10% |       5344 |    +9% |
+-------------------+----------+---------+--------+------------+--------+
| Writing           |     6929 |    8791 |   +27% |       8457 |   +22% |
+-------------------+----------+---------+--------+------------+--------+
| Photo Editing     |     7966 |   12057 |   +51% |      11881 |   +49% |
+-------------------+----------+---------+--------+------------+--------+
| Data Manipulation |     5596 |    6057 |    +8% |       5694 |    +2% |
+-------------------+----------+---------+--------+------------+--------+

PCMark Performance/mAh
Higher is better
+-------------------+----------+---------+--------+------------+--------+
|                   | Baseline | UtilHyp | %delta | UClampMMIO | %delta |
+-------------------+----------+---------+--------+------------+--------+
| Score/mAh         |       87 |     100 |   +15% |         92 |    +5% |
+-------------------+----------+---------+--------+------------+--------+

Roblox
Higher is better
+-------------------+----------+---------+--------+------------+--------+
|                   | Baseline | UtilHyp | %delta | UClampMMIO | %delta |
+-------------------+----------+---------+--------+------------+--------+
| FPS               |    17.92 |   21.82 |   +22% |      20.02 |   +12% |
+-------------------+----------+---------+--------+------------+--------+

Roblox Frames/mAh
Higher is better
+-------------------+----------+---------+--------+------------+--------+
|                   | Baseline | UtilHyp | %delta | UClampMMIO | %delta |
+-------------------+----------+---------+--------+------------+--------+
| Frames/mAh        |    77.91 |   84.46 |    +8% |     81.71  |     5% |
+-------------------+----------+---------+--------+------------+--------+

We've simplified our implementation based on community feedback to make
it less intrusive and to use a more generic MMIO interface for
communication with the host. The results show that the current design
still has tangible improvements over baseline. We'll continue looking
into ways to reduce the overhead of the MMIO read/writes and submit
separate and generic patches for that if we find any good optimizations.

Thanks,
David & Saravana

Cc: Saravana Kannan <saravanak@google.com>
Cc: Quentin Perret <qperret@google.com>
Cc: Masami Hiramatsu <mhiramat@google.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc: Gupta Pankaj <pankaj.gupta@amd.com>
Cc: Mel Gorman <mgorman@suse.de>

v4 -> v5:
-Added dt-binding description to allow for normalized frequencies
-Updated dt-binding examples with normalized frequency values
-Updated cpufreq exit to use dev_pm_opp_free_cpufreq_table to free tables
-Updated fast_switch and target_index to use entries from cpufreq tables
-Refreshed benchmark numbers using indexed frequencies
-Added missing header that was indirectly being used

v3 -> v4:
-Fixed dt-binding formatting issues
-Added additional dt-binding descriptions for =E2=80=9CHW interfaces=E2=80=
=9D
-Changed dt-binding to =E2=80=9Cqemu,virtual-cpufreq=E2=80=9D
-Fixed Kconfig formatting issues
-Removed frequency downscaling when requesting frequency updates
-Removed ops and cpufreq driver data
-Added check to limit freq_scale to 1024
-Added KHZ in the register offset naming
-Added comments to explain FIE and not allowing dvfs_possible_from_any_cpu

v2 -> v3:
- Dropped patches adding new hypercalls
- Dropped patch adding util_guest in sched/fair
- Cpufreq driver now populates frequency using opp bindings
- Removed transition_delay_us=3D1 cpufreq setting as it was configured too
  agressively and resulted in poor I/O performance
- Modified guest cpufreq driver to read/write MMIO regions instead of
  using hypercalls to communicate with the host
- Modified guest cpufreq driver to pass frequency info instead of
  utilization of the current vCPU's runqueue which now takes
  iowait_boost into account from the schedutil governor
- Updated DT bindings for a virtual CPU frequency device
Userspace changes:
- Updated CrosVM patches to emulate a virtual cpufreq device
- Updated to newer userspace binaries when collecting more recent
  benchmark data

v1 -> v2:
- No functional changes.
- Added description for EAS and removed DVFS in coverletter.
- Added a v2 tag to the subject.
- Fixed up the inconsistent "units" between tables.
- Made sure everyone is To/Cc-ed for all the patches in the series.

[1] - https://lpc.events/event/16/contributions/1195/
[2] - https://lpc.events/event/16/contributions/1195/attachments/970/1893/L=
PC%202022%20-%20VM%20DVFS.pdf
[3] - https://www.youtube.com/watch?v=3DhIg_5bg6opU
[4] - https://lore.kernel.org/all/20230331014356.1033759-1-davidai@google.c=
om/
[5] - https://chromium-review.googlesource.com/c/crosvm/crosvm/+/4208668
[6] - https://chromium-review.googlesource.com/q/topic:%22virtcpufreq-v5%22

David Dai (2):
  dt-bindings: cpufreq: add virtual cpufreq device
  cpufreq: add virtual-cpufreq driver

 .../cpufreq/qemu,cpufreq-virtual.yaml         | 110 +++++++++
 drivers/cpufreq/Kconfig                       |  15 ++
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/virtual-cpufreq.c             | 209 ++++++++++++++++++
 include/linux/arch_topology.h                 |   1 +
 5 files changed, 336 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-=
virtual.yaml
 create mode 100644 drivers/cpufreq/virtual-cpufreq.c

--=20
2.43.0.429.g432eaa2c6b-goog


