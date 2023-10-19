Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8CB7CFBB1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345838AbjJSNv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345774AbjJSNvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:51:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7929B9B;
        Thu, 19 Oct 2023 06:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1697723485; x=1698328285; i=w_armin@gmx.de;
        bh=AxltyYmFHaymahO+4+pGheB+ct+TZ7Uc/Q3HcmAQ28w=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=TpAgjHZNerr30oSXW9odupHfYqOyzpcTTylA5GZdPCoQxg723mOm/enu/+NbzYpz
         7Iq7OtCWCk9w4K8XPUuxB2YY2D4xJlZ6E8zugUt8sNfubK6z99YMqu/krMuVDho/h
         14b9Mn84oCbwdd6nPWW1RhEH+/tlAk/a2xC6WLPrjLATPVXw9t7ych08O+I9GhW/l
         pe2geY7+8lHgYJXkF2WldbFf1oLS0y0M3Srh8orjQfcGq+xtFhWQ1PeB5DzjvUNRZ
         bczhgrsO/vHRuuHMSpAG3Q1rN03Z/WIkWR5oiWky7WIImSJW0HP9mH4Sn4XSYM/nQ
         TiD31H/SdrcuBysQQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MdvmY-1rUSPS20ZS-00b3j5; Thu, 19 Oct 2023 15:51:24 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     naveenkrishna.chatradhi@amd.com, carlos.bilbao@amd.com
Cc:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/amd/hsmp: Fix iomem handling
Date:   Thu, 19 Oct 2023 15:51:22 +0200
Message-Id: <20231019135122.21774-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YSzIdPZ1K/kTuZ6D+lnJIC7iviBFVYhoLVUKouTZNBO4YXyhq/o
 0BerRQS13EMJ1MqKY5ZGjTSXhZxvCbCp8q9qEw2NT2G3xFB3gOI3puxHGKZQ4FITX0giT+p
 WUNfRrlQfbn+1oVxJ8f9Q84HDnUm/YlA4XLuYiNdU+DVh0xuvW64l0ZzXhRY8bHyj37OqOV
 27JgN3kVCo5vtIay69wow==
UI-OutboundReport: notjunk:1;M01:P0:QxefclDEr/8=;EXIQQAbNvfU7ZWdsarCUokZIjbp
 OCtv9V4HEvbcs2Q00/0G87U1lDZk5cyeE+JvSWFxPbqiL+WxJHz6//QaoJVJPQlboihEu75vh
 D9WdnFKtMyo9ZLAC/vjzvQySryUUghxQARkQm+m0MhIh3CJXixPeN+W3Uznjc3WJMxVtpunxX
 l7XweQZ009hi3HyEaZ4kysOAgUwllJxZRl/SDCwzYjfqtI0/eoC8oi2KfOX94Y2oeoyEdIzeL
 EKZCgPbhYYz02wPsFm0lfSPwjoNy6+WX0y51SWa4KHEBrwQv2Vomk0Eoi4rYtctXE2fbIuQ8g
 3FV6f8MImJmVddHeoU+Rbyl1KrWI/J5eOo8A9Bo32AHHjUmZq9Nzse3UCiRa0Ozf0HbN1wmH6
 U22LUvduqTLK0aoWchSn7kicLgdTrNkBoc++pWcz5Yq7VCTS4l84DDvztqub9E0lsYsbCK5pA
 tO7cgkmnSwWVh10+0arQokVXds163KNv0kAjpPRODlGL9XY6HQASI80GkOplbrnzLyEE2k88O
 fT+4tVvUSfMVW4dQ7XIqtFu87P+Ao11rKKK//ek28O6PG62rGgnGYEusCZgYuEZUYacvcuLCz
 Apdb81V8LfwFHijvLprqoy6pvtPLLf+QgmTUsWwS64IAebKqEAceHuTvkKw1VjeVNj9tJnGfd
 Aoy3IlOnHkD5AePePRN94NkfXG38PsR301M+yW+jnqAykJVI/4BRcfpn6c7T281A09qyS6+6m
 SR4gGJ5GzqnvrSviLiAYdeVq2SIRn01WHjH+0k/LDduYFHLYPsh2jjTjA4QJdYrfeCVw+P+RF
 Uf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the metrics table is marked as io memory,
use memcpy_fromio() when copying its contents.

Compile-tested only.

Fixes: 5150542b8ec5 ("platform/x86/amd/hsmp: add support for metrics tbl")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/amd/hsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/hs=
mp.c
index b056a5c8654a..b55d80e29139 100644
=2D-- a/drivers/platform/x86/amd/hsmp.c
+++ b/drivers/platform/x86/amd/hsmp.c
@@ -362,7 +362,7 @@ static ssize_t hsmp_metric_tbl_read(struct file *filp,=
 struct kobject *kobj,
 	ret =3D hsmp_send_message(&msg);
 	if (ret)
 		return ret;
-	memcpy(buf, sock->metric_tbl_addr, bin_attr->size);
+	memcpy_fromio(buf, sock->metric_tbl_addr, bin_attr->size);

 	return bin_attr->size;
 }
=2D-
2.39.2

