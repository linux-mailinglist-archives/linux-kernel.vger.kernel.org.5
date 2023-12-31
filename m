Return-Path: <linux-kernel+bounces-13797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1C6820FA9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 23:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9647282704
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 22:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B0AC154;
	Sun, 31 Dec 2023 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyQZ3Rhq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1144BC12B;
	Sun, 31 Dec 2023 22:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD22C433C8;
	Sun, 31 Dec 2023 22:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704061381;
	bh=KmAQIyNbg0TjiM1i32dUecZ2z6g0ha/CR4/e07hbrbQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ZyQZ3Rhq5HmWC6+gQOZKcQhbt6tzXmlyaoEY3qii5yYl+TOhot3rbk5A9ZxqzW1dW
	 OQTwtW2QrEFfQa2NRwvs+OR35QBVEgZAuQhXXPMWO8bsUy9mB16tgNElc9jgMCfW0V
	 A8/WwZRT4OT9DgxMj27zwz5AKe0RwP7/BonBsXNlALRuPPVGPcm5DquEPNf3bZeDTQ
	 NDAJ1yuWBz8BUbOjfu5uba2ltom+7QPvC8q11po9yxoL7Ey57NGTkx/Sq22H20qB58
	 Kr9E/w8pw0gbqGo5csUJ90c8VkddCNfRWDk9aAwO/yQUBazK6QLYqkyQBgMarVUH72
	 LDeAVelP7BpzA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com
Subject: Looking back on DAMON development in 2023
Date: Sun, 31 Dec 2023 14:22:50 -0800
Message-Id: <20231231222250.140364-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,


Last year around this time, I shared a humble retrospect of DAMON for 2022[1],
which was effectively the first year it had after it was merged in the
mainline.  As one more year has passed, I'd like to share that again for the
second year of DAMON, with some events and statistics of this year's DAMON
development that I was personally interested in.  I'd like to use this chance
to say huge thanks to the community, too.

Summary
=======

2023 was yet another year of active and healthy DAMON development.  DAMON has
continued active development but hopefully further stabilized.  The growth of
the DAMON user-space tool, damo, was noticeable.

DAMON has been explored and used by more people and products.  'damo' got its
100th GitHub star and has been deployed by seven major Linux distros.  Four
papers and three articles that explore and/or introduce DAMON have been
published.  A product that manages tiered memory using DAMON has officially
been released.

A substantial amount of development was also continued.  Four major DAMON
features have been developed.  With a significant amount of new features, damo
released its second major version (v2.0).

24 people contributed their great code to DAMON by making 158 commits merged
into the mainline.  About 28% of the commits were made by Amazon-external
contributors.  Among the changes for DAMON's parent subsystem, mm, about 9.35%
of commits and 8.63% of changed lines were made for DAMON.  About 0.21% of the
commits for the whole Linux tree were made for DAMON.  Six people contributed
1,872 commits to damo.

Compared to 2022, the absolute number of contributors and changes for DAMON
(kernel-only) has reduced (about 40%), though those relative to the numbers for
its parent subsystem, mm, and the entire Linux tree were increased (about 10%)
or not changed.  Meanwhile, the numbers for damo have impressively increased to
about 600% and 180% for contributors and changes, respectively.

Key Events
==========

DAMON user-space tool, damo[2], got significant achievements in 2023.  'damo'
has deployed via PyPI since August 2021, and ArchLinux started packaging it in
March 2022[3].  In 2023, Fedora has been the second major Linux distro that
packaging the tool since May[4].  The tool has been packaged by more distros,
and as of this writing, ArchLinux, Debian, Devuan, Fedora, Kali Linux,
Raspbian, and Ubuntu are[5] packaging the tool.  It also got its 100th
release[6] and GitHub star in August.

A few articles and papers introducing or exploring DAMON have been published.
Two LWN articles[7,8] that each briefly introduces a new feature of DAMON as a
significant change of a new Linux kernel release, and shares detailed LSFMM
DAMON discussion, were published in March and May.  A blog post[9] from Hocus
that introduces DAMON as a way to reduce memory footprint on virtual machines
together with free pages reporting was published in July.  Two arXiv
papers[10,11] and one SOSP paper[12] exploring DAMON on tiered memory management
were published in February, September, and October, respectively.  One more
paper from Intel that improves DAMON for terabyte-scale memory systems was
published by ArXiv in November[13].

We shared the development status and plans with other kernel developers at
LSFMM[14] and Kernel Summit track of LinuxPlumbers[15] in May and November,
respectively.  We introduced DAMON at a high level for wider audiences at the
Open Source Summit North America[16] and Europe[17] in May and September,
respectively.  In LinuxPlumbers, we had the second in-person DAMON community
meetup[18].

DAMON community started participating[19] in the stable kernels release
candidates testing in August.

SK Hynix released[28] their second major version of the Heterogeneous Memory
Software Development Kit (HMSDK), which uses DAMON for their CXL-based tiered
memory management, in December.

A more exhaustive list of events in 2023 is available on the DAMON news web
page[29].

Key Features
============

We started 2023 with Linux v6.2 which delivered DAMOS tried regions feature[20]
that was developed in 2022.

DAMOS filters[21] feature has been developed and merged in the mainline by
v6.3-rc1, which was released in March.  The feature was later expanded[22] for
more use cases and merged in the mainline by v6.6-rc1, which was released in
September.

Two more DAMON features for pseudo-moving average-based reliable and speedy
DAMON snapshot generation[23] and DAMOS-dedicated apply time interval[24] have
been developed and merged in the mainline by v6.7-rc1, which was released in
November.

Finally, we developed user feedback-based DAMOS aggressiveness auto-tuning[25],
which is currently merged in the mm tree.  Hopefully, it will be merged in the
mainline by v6.8-rc1, which is expected to be released in January 2024.

Development Statistics
======================

To appreciate and list all names of people who made DAMON available, and to
quantify what 2023 was for DAMON development, I collected some numbers using my
humble and buggy scripts.  The scripts are available as open source[26,27].

Please note that numbers don't say everything.  Nonetheless, in my humble
opinion, those are better than nothing and fun ;)

Contributors
------------

According to the humble script, 24 people have contributed to DAMON development
in 2023 (v6.2-rc1..v6.7-rc8).

    $ ./lazybox/git_helpers/authors.py ./linux \
            --commits_range v6.2-rc1..v6.7-rc8 --skip_merge_commits \
            --linux_subsystems "DATA ACCESS MONITOR"
    1. SeongJae Park <sj@kernel.org>: 119 commits
    2. Kefeng Wang <wangkefeng.wang@huawei.com>: 10 commits
    3. Ryan Roberts <ryan.roberts@arm.com>: 4 commits
    4. Jinjie Ruan <ruanjinjie@huawei.com>: 3 commits
    5. Bjorn Helgaas <bhelgaas@google.com>: 2 commits
    6. Vishal Moola (Oracle) <vishal.moola@gmail.com>: 2 commits
    7. Hyeongtak Ji <hyeongtak.ji@sk.com>: 1 commits
    8. Dan Carpenter <dan.carpenter@linaro.org>: 1 commits
    9. Huan Yang <link@vivo.com>: 1 commits
    10. Andreas Gruenbacher <agruenba@redhat.com>: 1 commits
    11. Juntong Deng <juntong.deng@outlook.com>: 1 commits
    12. Levi Yun <ppbuk5246@gmail.com>: 1 commits
    13. Suren Baghdasaryan <surenb@google.com>: 1 commits
    14. Feng Tang <feng.tang@intel.com>: 1 commits
    15. Hugh Dickins <hughd@google.com>: 1 commits
    16. Anders Roxell <anders.roxell@linaro.org>: 1 commits
    17. Thomas Weißschuh <linux@weissschuh.ne>: 1 commits
    18. andrew.yang <andrew.yang@mediatek.com>: 1 commits
    19. Baolin Wang <baolin.wang@linux.alibaba.com>: 1 commits
    20. Thomas Weißschuh <linux@weissschuh.net>: 1 commits
    21. Liam R. Howlett <Liam.Howlett@oracle.com>: 1 commits
    22. Huaisheng Ye <huaisheng.ye@intel.com>: 1 commits
    23. Hui Su <suhui_kernel@163.com>: 1 commits
    24. Xu Panda <xu.panda@zte.com.cn>: 1 commits
    # 24 authors, 158 commits in total

The last line of the output for 2022[3] was as below.

    # 40 authors, 275 commits in total

The number has quite reduced compared to that of 2022 (40 -> 24).  That's
hopefully because DAMON code has more stabilized.

For the DAMON user-space tool, damo, six people contributed 1,859 commits in
2023.  Note that there were contributors using multiple email addresses.

    $ ./lazybox/git_helpers/authors.py ./damo --since 2023-01-01
    1. SeongJae Park <sj38.park@gmail.com>: 1788 commits
    2. SeongJae Park <sj@kernel.org>: 58 commits
    3. Honggyu Kim <honggyu.kp@gmail.com>: 8 commits
    4. sjpark <sjpark@amazon.com>: 5 commits
    5. Michel Alexandre Salim <salimma@fedoraproject.org>: 4 commits
    6. SeongJae Park <sjpark@amazon.com>: 3 commits
    7. Honggyu Kim <honggyu.kim@sk.com>: 2 commits
    8. Andrew Paniakin <apanyaki@amazon.com>: 1 commits
    9. fdu <1050329+fdu@users.noreply.github.com>: 1 commits
    10. Puranjay Mohan <pjy@amazon.com>: 1 commits
    11. Puranjay Mohan <pjy@amazon.de>: 1 commits
    # 11 authors, 1872 commits in total

The numbers for 2022 are as below.

    $ ./lazybox/git_helpers/authors.py ./damo \
            --since 2022-01-01 --until 2022-12-31 --skip_merge_commits
    1. SeongJae Park <sj38.park@gmail.com>: 1021 commits
    2. SeongJae Park <sj@kernel.org>: 22 commits
    3. SeongJae Park <sjpark@amazon.com>: 10 commits
    4. SeongJae Park <sjpark@amazon.de>: 1 commits
    # 4 authors, 1054 commits in total

So the number of commits and the contributors have increased to about 180
percent (1,054 -> 1,872) and 600 percent (1 -> 6) respectively, compared to
those of 2022.  I'd call this a huge increase.

Please note that there were many unsung hero contributors gave valuable inputs,
discussions, and many more things for DAMON development.  So shameful that I
cannot put everyone's name here.

Thank you so much to all the awesome contributors!

Contributions from non-maintainer
---------------------------------

The maintainer, SJ (sj@kernel.org), has driven the development of DAMON, but
the help from the community was huge.  About 28.31% of DAMON commits have been
made by people other than SJ.  Again, the number is reduced compared to that of
last year (33% -> 28%).

    $ ./damon-hack/stat_damon_portion_community_commits.sh \
            ./linux ./damon-hack/stat_branches_2023
    range               from_sj  non_sj  non_sj_portion
    v6.2-rc1..v6.3      32       16      33.33%
    v6.3..v6.4          0        5       100.00%
    v6.4..v6.5          19       8       29.63%
    v6.5..v6.6          20       7       25.93%
    v6.6..v6.7-rc8      48       11      18.64%
    v6.2-rc1..v6.7-rc8  119      47      28.31%

The output for 2022 was as below.

    range               from_sj non_sj    non_sj_portion
    v5.15..v5.16        50      13        20.63%
    v5.16..v5.17        16      10        38.46%
    v5.17..v5.18        26      10        27.78%
    v5.18..v5.19        23      7         23.33%
    v5.19..v6.0         15      14        48.28%
    v6.0..v6.1          33      36        52.17%
    v6.1..v6.2-rc1      28      6         17.65%
    v5.15..v6.2-rc1     191     95        33.22%


The Portion of DAMON Commits in MM and Linux
--------------------------------------------

To show how much change DAMON made to its parent subsystem, MM, and whole
Linux, I counted the number of commits that touched files for DAMON, MM, and
the whole Linux tree in 2023 releases (v6.2-rc1..v6.7-rc8).

According to the buggy and humble script, about 9.35% of MM commits, and 0.21%
of Linux commits were made for DAMON.

    $ ./damon-hack/stat_damon_portion_nr_commits.sh \
            ./linux ./damon-hack/stat_branches_2023
    range               damon  mm    damon/mm  linux  damon/linux
    v6.2-rc1..v6.3      47     458   10.26%    16273  0.29%
    v6.3..v6.4          5      346   1.45%     14835  0.03%
    v6.4..v6.5          26     327   7.95%     13561  0.19%
    v6.5..v6.6          25     402   6.22%     14069  0.18%
    v6.6..v6.7-rc8      55     341   16.13%    17138  0.32%
    v6.2-rc1..v6.7-rc8  158    1690  9.35%     75876  0.21%

The output for 2022 was as below.

    range               damon mm   damon/mm linux  damon/linux
    v5.15..v5.16        45    307  14.66%   14190  0.32%
    v5.16..v5.17        17    223  7.62%    13038  0.13%
    v5.17..v5.18        29    448  6.47%    14954  0.19%
    v5.18..v5.19        24    399  6.02%    15134  0.16%
    v5.19..v6.0         15    283  5.30%    15402  0.10%
    v6.0..v6.1          61    536  11.38%   13942  0.44%
    v6.1..v6.2-rc1      20    250  8.00%    13687  0.15%
    v5.15..v6.2-rc1     211   2446 8.63%    100347 0.21%

Compared to the numbers for 2022, absolute number of DAMON commits has reduced
(211 -> 158), but the proportion of DAMON commits against MM commits has a bit
increased (8.63% -> 9.35%), while the portion against Linux has not changed
(0.21%).

By Number of Lines
------------------

I further counted the portion of the number of changed lines.  Didn't count
that for Linux here due to the slow speed of the script.  The script argues
about 4.05% of the changed lines for MM subsystem were for DAMON.  This is a
quite decrease compared to that of last year (14.32%).  Hopefully, that's
because DAMON became more stabilized.

    $ ./damon-hack/stat_damon_portion_lines.sh \
            ./linux ./damon-hack/stat_branches_2023
    range               damon  mm     damon/mm
    v6.2-rc1..v6.3      962    13852  6.94%
    v6.3..v6.4          32     14226  0.22%
    v6.4..v6.5          113    9852   1.15%
    v6.5..v6.6          322    7862   4.10%
    v6.6..v6.7-rc8      850    10489  8.10%
    v6.2-rc1..v6.7-rc8  2279   56281  4.05%

The output for 2022 was as below.

    range               damon mm    damon/mm
    v5.15..v5.16        2157  8503  25.37%
    v5.16..v5.17        324   9370  3.46%
    v5.17..v5.18        3462  16288 21.25%
    v5.18..v5.19        929   10185 9.12%
    v5.19..v6.0         870   8665  10.04%
    v6.0..v6.1          1752  25844 6.78%
    v6.1..v6.2-rc1      3309  10544 31.38%
    v5.15..v6.2-rc1     12803 89399 14.32%

Conclusion
==========

DAMON community delivered multiple important features and a significant amount
of changes to the world via the collaboration between the 24 great
contributors.  I would call 2023 as yet another successful and grateful years
of DAMON development.

Huge thanks to you again, DAMON community.  Looking forward to continuing our
journey in 2024.

Hope you all enjoy the remaining holidays and a happy new year!


Thanks,
SJ


References
==========

[1] 2022 retrospect: https://lore.kernel.org/damon/20221229171209.162356-1-sj@kernel.org/
[2] DAMON user-space tool, damo: https://github.com/awslabs/damo
[3] ArchLinux damo package: https://aur.archlinux.org/packages/damo
[4] Fedora damo package: https://packages.fedoraproject.org/pkgs/python-damo/damo/
[5] damo packaging status: https://repology.org/project/damo/versions
[6] 100th damo release: https://lore.kernel.org/damon/20230807202044.98700-1-sj@kernel.org/
[7] LWN article about DAMOS filter: https://lwn.net/Articles/924384/
[8] LWN article about DAMON LSFMM discussion: https://lwn.net/Articles/931769/
[9] Hocus article: https://hocus.dev/blog/qemu-vs-firecracker/
[10] arXiv paper exploring DAMON: https://arxiv.org/pdf/2302.09468.pdf
[11] arXiv paper exploring DAMON: https://arxiv.org/pdf/2309.01736.pdf
[12] SOSP paper exploring DAMON: https://dl.acm.org/doi/10.1145/3600006.3613167
[13] arXiv paper improving DAMON: https://arxiv.org/pdf/2311.10275.pdf
[14] LSFMM DAMON talk: https://www.youtube.com/watch?v=bbC23ApPvow
[15] Ksummit DAMON talk: https://lpc.events/event/17/contributions/1624/
[16] OSSNA DAMON talk: https://ossna2023.sched.com/event/1K5HS
[17] OSSEU DAMON talk: https://osseu2023.sched.com/event/1OGf9
[18] LPC DAMON meetup: https://lpc.events/event/17/contributions/1652/
[19] DAMON's stable rc kernel test results report: https://lore.kernel.org/damon/20230802173033.108621-1-sj@kernel.org/
[20] DAMOS tried regions: https://lore.kernel.org/damon/20221101220328.95765-1-sj@kernel.org/
[21] DAMOS filters: https://lore.kernel.org/damon/20221205230830.144349-1-sj@kernel.org/
[22] DAMOS filters extension: https://lore.kernel.org/damon/20230802214312.110532-1-sj@kernel.org/
[23] DAMON pseudo-moving snapshot: https://lore.kernel.org/damon/20230915025251.72816-1-sj@kernel.org/
[24] DAMOS apply interval: https://lore.kernel.org/damon/20230916020945.47296-1-sj@kernel.org/
[25] Goal-oriented feedback-driven DAMOS auto-tuning: https://lore.kernel.org/damon/20231130023652.50284-1-sj@kernel.org/
[26] Statistics tool: https://github.com/sjp38/lazybox
[27] Statistics tool 2: https://git.kernel.org/sj/damon-hack/h/master
[28] SK HMSDK v2 release: https://github.com/skhynix/hmsdk/releases/tag/hmsdk-v2.0
[29] 2023 DAMON News: https://sjp38.github.io/post/damon_news/#2023

