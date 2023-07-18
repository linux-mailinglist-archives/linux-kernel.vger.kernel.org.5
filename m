Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58777758192
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjGRQAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjGRQAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:00:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E807F1;
        Tue, 18 Jul 2023 09:00:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E555F61652;
        Tue, 18 Jul 2023 16:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7A6C433C7;
        Tue, 18 Jul 2023 16:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689696036;
        bh=jvMVNhdv/97zl9sPMxZQndXVmhxPoD5xlaUndo6zZv8=;
        h=From:To:Cc:Subject:Date:From;
        b=FteMW5mLmz58s7a9E5NDYgKBur+BL1NbhXkAd4O+2Vti6gO1zw0GdngI1Rj4ZL862
         pMizkXjotag4O3QHuwSSkFMDZ+QorloBhXZgsq2kItnp4Mqf/N6Wz6AZdJFmJAXell
         exStooah3RAcIGnY/9HYqsLG1eVkNjtSkeRbSd6NT9ZSNoiM1qRsfdQD+2yQEbhhCG
         bmhmqjLQuTTCjZ8FgR4UHoNVe7tZoS10M1S67p13ROH9gUucgWZd/9aj/2TgJ5SsJL
         k62fkbZ7JZU9RcvyuAQ+n95aIb6W5Z3uHSqyybZ5lR4x1Y8Gyxj+JrhpkwDcyyKy6a
         jOoEZAYeU3TiQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     corbet@lwn.net
Cc:     Jakub Kicinski <kuba@kernel.org>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org,
        linux@leemhuis.info, broonie@kernel.org, krzk@kernel.org
Subject: [PATCH docs v2] docs: maintainer: document expectations of small time maintainers
Date:   Tue, 18 Jul 2023 08:58:14 -0700
Message-ID: <20230718155814.1674087-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We appear to have a gap in our process docs. We go into detail
on how to contribute code to the kernel, and how to be a subsystem
maintainer. I can't find any docs directed towards the thousands
of small scale maintainers, like folks maintaining a single driver
or a single network protocol.

Document our expectations and best practices. I'm hoping this doc
will be particularly useful to set expectations with HW vendors.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - use Thorsten's wording for bug fixing requirements
 - put more words into the review/response timeline expectations
v1: https://lore.kernel.org/all/20230713223432.1501133-1-kuba@kernel.org/

CC: workflows@vger.kernel.org
CC: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Cc: linux@leemhuis.info
Cc: broonie@kernel.org
Cc: krzk@kernel.org
---
 .../feature-and-driver-maintainers.rst        | 155 ++++++++++++++++++
 Documentation/maintainer/index.rst            |   1 +
 2 files changed, 156 insertions(+)
 create mode 100644 Documentation/maintainer/feature-and-driver-maintainers.rst

diff --git a/Documentation/maintainer/feature-and-driver-maintainers.rst b/Documentation/maintainer/feature-and-driver-maintainers.rst
new file mode 100644
index 000000000000..7064b5de076d
--- /dev/null
+++ b/Documentation/maintainer/feature-and-driver-maintainers.rst
@@ -0,0 +1,155 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+Feature and driver maintainers
+==============================
+
+The term "maintainer" spans a very wide range of levels of engagement
+from people handling patches and pull requests as almost a full time job
+to people responsible for a small feature or a driver.
+
+Unlike most of the chapter, this section is meant for the latter (more
+populous) group. It provides tips and describes the expectations and
+responsibilities of maintainers of a small(ish) section of the code.
+
+Driver and alike most often do not have their own mailing lists and
+git trees but instead send and review patches on the list of a larger
+subsystem.
+
+Responsibilities
+================
+
+The amount of maintenance work is usually proportional to the size
+and popularity of the code base. Small features and drivers should
+require relatively small amount of care and feeding. Nonetheless
+when the work does arrive (in form of patches which need review,
+user bug reports etc.) it has to be acted upon promptly.
+Even when single driver only sees one patch a month, or a quarter,
+a subsystem could well have a hundred such drivers. Subsystem
+maintainers cannot afford to wait a long time to hear from reviewers.
+
+The exact expectations on the response time will vary by subsystem.
+The patch review SLA the subsystem had set for itself can sometimes
+be found in the subsystem documentation. Failing that as a rule of thumb
+reviewers should try to respond quicker than what is the usual patch
+review delay of the subsystem maintainer. The resulting expectations
+may range from two working days for fast-paced subsystems (e.g. networking)
+to as long as a few weeks in slower moving parts of the kernel.
+
+Mailing list participation
+--------------------------
+
+Linux kernel uses mailing lists as the primary form of communication.
+Maintainers must be subscribed and follow the appropriate subsystem-wide
+mailing list. Either by subscribing to the whole list or using more
+modern, selective setup like
+`lei <https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started>`_.
+
+Maintainers must know how to communicate on the list (plain text, no invasive
+legal footers, no top posting, etc.)
+
+Reviews
+-------
+
+Maintainers must review *all* patches touching exclusively their drivers,
+no matter how trivial. If the patch is a tree wide change and modifies
+multiple drivers - whether to provide a review is left to the maintainer.
+
+There should be multiple maintainers for any piece of code, an ``Acked-by``
+or ``Reviewed-by`` tag (or review comments) from a single maintainer is
+enough to satisfy this requirement.
+
+If review process or validation for a particular change will take longer
+than the expected review timeline for the subsystem, maintainer should
+reply to the submission indicating that the work is being done, and when
+to expect full results.
+
+Refactoring and core changes
+----------------------------
+
+Occasionally core code needs to be changed to improve the maintainability
+of the kernel as a whole. Maintainers are expected to be present and
+help guide and test changes to their code to fit the new infrastructure.
+
+Bug reports
+-----------
+
+Maintainers must ensure severe problems in their code reported to them
+are resolved in a timely manner: regressions, kernel crashes, kernel warnings,
+compilation errors, lockups, data loss, and other bugs of similar scope.
+
+Maintainers furthermore should respond to reports about other kind of
+bugs as well, if the report is of reasonable quality or indicates a
+problem that might be severe -- especially if they have *Supported*
+status of the codebase in the MAINTAINERS file.
+
+Selecting the maintainer
+========================
+
+The previous section described the expectations of the maintainer,
+this section provides guidance on selecting one and decribes common
+misconceptions.
+
+The author
+----------
+
+Most natural and common choice of a maintainer is the author of the code.
+The author is intimately familiar with the code, so it is the best person
+to take care of it on an ongoing basis.
+
+That said, being a maintainer is an active role. The MAINTAINERS file
+is not a list of credits (in fact a separate CREDITS file exists),
+it is a list of those who will actively help with the code.
+If the author does not have the time, interest or ability to maintain
+the code, a different maintainer must be selected.
+
+Multiple maintainers
+--------------------
+
+Modern best practices dictate that there should be at least two maintainers
+for any piece of code, no matter how trivial. It spreads the burden, helps
+people take vacations and prevents burnout, trains new members of
+the community etc. etc. Even when there is clearly one perfect candidate,
+another maintainer should be found.
+
+Maintainers must be human, however, it is not acceptable to add a mailing
+list or a group email as a maintainer. Trust and understanding are the
+foundation of kernel maintenance and one cannot build trust with a mailing
+list.
+
+Corporate structures
+--------------------
+
+To an outsider the Linux kernel may resemble a hierarchical organization
+with Linus as the CEO. While the code flows in a hierarchical fashion,
+the corporate template does not apply here. Linux is an anarchy held
+together by (rarely expressed) mutual respect, trust and convenience.
+
+All that is to say that managers almost never make good maintainers.
+The maintainer position more closely matches an on-call rotation
+than a position of power.
+
+The following characteristics of a person selected as a maintainer
+are clear red flags:
+
+ - unknown to the community, never sent an email to the list before
+ - did not author any of the code
+ - (when development is contracted) works for a company which paid
+   for the development rather than the company which did the work
+
+Non compliance
+==============
+
+Subsystem maintainers may remove inactive maintainers from the MAINTAINERS
+file. If the maintainer was a significant author or have played an important
+role in the development of the code they should be moved to the CREDITS file.
+
+Removing an inactive maintainer should not be seen as a punitive action.
+Having an inactive maintainer has a real cost as all developeres have
+to remember to include the maintainers in discussions and subsystem
+maintainers spend brain power figuring out how to solicit feedback.
+
+Subsystem maintainers may remove code for lacking maintenance.
+
+Subsystem maintainers may refuse accepting code from companies
+which repeatedly neglected their maintainership duties.
diff --git a/Documentation/maintainer/index.rst b/Documentation/maintainer/index.rst
index 3e03283c144e..eeee27f8b18c 100644
--- a/Documentation/maintainer/index.rst
+++ b/Documentation/maintainer/index.rst
@@ -9,6 +9,7 @@ additions to this manual.
 .. toctree::
    :maxdepth: 2
 
+   feature-and-driver-maintainers
    configure-git
    rebasing-and-merging
    pull-requests
-- 
2.41.0

