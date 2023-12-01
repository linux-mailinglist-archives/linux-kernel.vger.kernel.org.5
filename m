Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64B28001F3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376975AbjLADPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 22:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjLADPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 22:15:32 -0500
Received: from pv50p00im-ztdg10012101.me.com (pv50p00im-ztdg10012101.me.com [17.58.6.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC9C1717
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 19:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1701400537; bh=J1e8MVpgYKHHT8qqYA/cG+J/c7QhLqjmRpXuY46jjUg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=p/ExqYdyjjh/7+kW7Oq553AaJ5HcCHmiEaAP2M9d1MXDz5q5U5gRldCdxABgimeP+
         oPkQpcLMTWS4MTAL7OTljh9keoVRHBWrgam/glg/9TAq36HleXB62Xj4/Iy/+yfwHL
         IbgxSTcB9dHe9BiFlfVj0yyiWQE1YBZeBhTx9u5ncXrXIKc1FU9hD+cOJFa3izxzXr
         CsO6wD8mMDMzf+T9/5sQshTe3+2OSuv+k/LweKyE2s86LAyXKodIeusLeHdC8Xz7CC
         Wk244t3BJX08DflI13bTIvq9iyCl2IoxKCXu9nS7eQMG1MIARirT/PYCjGHjWzcSCj
         x4AcBAJsQL7nA==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10012101.me.com (Postfix) with ESMTPSA id D9178740116;
        Fri,  1 Dec 2023 03:15:30 +0000 (UTC)
From:   sxwjean@me.com
To:     vbabka@suse.cz, 42.hyeyoo@gmail.com, cl@linux.com,
        linux-mm@kvack.org
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, corbet@lwn.net, keescook@chromium.org,
        arnd@arndb.de, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH 0/3] supplyment of slab allocator removal
Date:   Fri,  1 Dec 2023 11:15:02 +0800
Message-Id: <20231201031505.286117-1-sxwjean@me.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: i1IoE9P_OLRrjIyA_2bZMmMAKEmtUx-t
X-Proofpoint-GUID: i1IoE9P_OLRrjIyA_2bZMmMAKEmtUx-t
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 clxscore=1011 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2312010018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <xiongwei.song@windriver.com>

Hi,

Patch 1 is to remove an unused parameter. This patch acutually is v3, but
it is not reasonable to add v3 tag in the cover letter, so I put the
change history inside the patch.

---
Patch 2 is to replace slub_$params with slab_$params.
Vlastimil Babka pointed out we should use "slab_$param" as the primary
prefix for long-term plan. Please see [1] for more infomation.

This patch is to do that. However, the patch is big, I'm not sure if
everything is proper in it, so I added "RFC" in the patch title. For more
information please see the commit message of patch.

I did the basic tests with qemu, which passed values by sl[au]b_max_order,
sl[au]b_min_order, sl[au]b_min_objects and sl[au]b_debug in command line.
The values looks correct by printing them out before calculating orders.

One thing I'm not sure about the forth parameter of __setup_param(),
Is it correct to set the parameter to 0 directly?

---
Patch 3 is not related to slab allocator removal. It's to correct the
description of default value of slub_min_objects in
Documentation/mm/slub.rst. 

---
Regards,
Xiongwei

[1] https://lore.kernel.org/linux-mm/7512b350-4317-21a0-fab3-4101bc4d8f7a@suse.cz/

Xiongwei Song (3):
  Documentation: kernel-parameters: remove noaliencache
  mm/slub: unify all slab/slub parameters with "slab_$param"
  mm/slub: correct the default slub_min_objects value in doc

 .../admin-guide/kernel-parameters.txt         |  48 +++---
 Documentation/mm/slub.rst                     |   2 +-
 drivers/misc/lkdtm/heap.c                     |   2 +-
 mm/Kconfig.debug                              |   6 +-
 mm/slab.h                                     |  16 +-
 mm/slab_common.c                              |   8 +-
 mm/slub.c                                     | 142 +++++++++---------
 7 files changed, 110 insertions(+), 114 deletions(-)

-- 
2.34.1

