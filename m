Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB47ACB75
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 20:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjIXSll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 14:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjIXSlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 14:41:40 -0400
Received: from pv50p00im-ztbu10021601.me.com (pv50p00im-ztbu10021601.me.com [17.58.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E7DA6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 11:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=claudiocambra.com;
        s=sig1; t=1695580891;
        bh=VQR4EtRBp7jWzudSp/FWLXg7bXlybMvQwwQhYXIOHTE=;
        h=From:To:Subject:Date:Message-ID:MIME-Version;
        b=na8+TlhClG6W/pLjdBT4WmQ7LPxT9XBcEO58pL68vD/uJVHtSqKhrs8c/zIdlwNSI
         ZX0rVjE2NEnQn6P69iGlTP3JHM61I0OyON3MWYKdKHgF9YLxvs4UxM4EA4peJjauP4
         0xGY3kGUdA7ltujJlQuG55vONgtqqLteQZxrI5BdsQDR4QuB4SlXFq1d82c8FH9IZv
         0+t+EMtskcu/O7PuGRbCpuzu291gKIfLEhafB+MihKRm6DS62vFaaV7fesAfXlaX9O
         c+fi9SWrfsd67UBl39vTdAc4nihXLy5vSAqq4JEGsUG/QR+vIoO22qrnG5aSd+DBoL
         uudd7RLXow00Q==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id 5680180262;
        Sun, 24 Sep 2023 18:41:28 +0000 (UTC)
From:   Claudio Cambra <developer@claudiocambra.com>
To:     skhan@linuxfoundation.org, ivan.orlov0322@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Claudio Cambra <developer@claudiocambra.com>
Subject: [PATCH] docs: Fix Sphinx 8 warning caused by paths represented with strings
Date:   Mon, 25 Sep 2023 02:40:57 +0800
Message-ID: <20230924184057.91861-1-developer@claudiocambra.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9S0jnjFqe4WtRWUxJnFWrNMT2F2RB_li
X-Proofpoint-ORIG-GUID: 9S0jnjFqe4WtRWUxJnFWrNMT2F2RB_li
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=394 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2309240164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running "make htmldocs" generates several lines of this warning:

Documentation/sphinx/kerneldoc.py:141: RemovedInSphinx80Warning: Sphinx 8 will drop support for representing paths as strings. Use "pathlib.Path" or "os.fspath" instead.
  doc = (env.srcdir + "/" + env.docname + ":" + str(self.lineno))

Making "doc" an fspath type and creating a new variable with the
appended colon and lineno fixes this warning.

Signed-off-by: Claudio Cambra <developer@claudiocambra.com>
---
 Documentation/sphinx/kerneldoc.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 9395892c7ba3..e2c835e10dba 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -138,7 +138,8 @@ class KernelDocDirective(Directive):
                     lineoffset = int(match.group(1)) - 1
                     # we must eat our comments since the upset the markup
                 else:
-                    doc = env.srcdir + "/" + env.docname + ":" + str(self.lineno)
+                    doc = os.path.join(env.srcdir, env.docname)
+                    doc_with_line = (doc + ":" + str(self.lineno))
                     result.append(line, doc + ": " + filename, lineoffset)
                     lineoffset += 1
 
-- 
2.42.0

