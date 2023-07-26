Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9348763886
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjGZOIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjGZOH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:56 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B482721
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:14 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230726140713euoutp022a7a318d8523ec94e8bed4d6a439290f~1cAxASY0q1520515205euoutp027
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:07:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230726140713euoutp022a7a318d8523ec94e8bed4d6a439290f~1cAxASY0q1520515205euoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690380433;
        bh=JW7CP4Fi6G/IV8T1nAiu1rAhykb9tptNcnfn6WjOSE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPdTn6KzY3FNTAgMP+RF/FRdbqkmUvfDA0eja1hkvhHVExd1a4wiodJQlGXmeBLfB
         Yg9HRdmaH9jpZEsLK4EqKQDK1u1MF8Ga6ZPK+46lGOX8j//eRASoTreX4NjQ69dQAj
         VPZEn78HI2EZtG3U0NsHB2OrdHFuPNxT/lrA02mQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230726140712eucas1p2a55c1427b18503a11470c8e14d66e08c~1cAwusIzF0694406944eucas1p2o;
        Wed, 26 Jul 2023 14:07:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 71.76.37758.09821C46; Wed, 26
        Jul 2023 15:07:12 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230726140712eucas1p1bc7b2d150482936d974ceba9c51d7bc4~1cAwan4r92257522575eucas1p1F;
        Wed, 26 Jul 2023 14:07:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230726140712eusmtrp2fca45d42ef0d1e8a0b96492448999419~1cAwaFtP52063520635eusmtrp2O;
        Wed, 26 Jul 2023 14:07:12 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-3a-64c1289048fb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 61.67.14344.09821C46; Wed, 26
        Jul 2023 15:07:12 +0100 (BST)
Received: from localhost (unknown [106.210.248.223]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230726140712eusmtip2f0fe322b3296998b4ab61e5f2597cf0a~1cAwPqTnT3059730597eusmtip2s;
        Wed, 26 Jul 2023 14:07:12 +0000 (GMT)
From:   Joel Granados <j.granados@samsung.com>
To:     mcgrof@kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     willy@infradead.org, keescook@chromium.org, josh@joshtriplett.org,
        Joel Granados <j.granados@samsung.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] sysctl: SIZE_MAX->ARRAY_SIZE in register_net_sysctl
Date:   Wed, 26 Jul 2023 16:06:33 +0200
Message-Id: <20230726140635.2059334-14-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230726140635.2059334-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djPc7oTNA6mGBy/r2Ux53wLi8XTY4/Y
        LZbuf8ho8X9BvsWZ7lyLC9v6WC0u75rDZnFjwlNGi2MLxCy+nX7DaPH7xxw2B26P2Q0XWTy2
        rLzJ5LFgU6nH5hVaHrde23psWtXJ5vF+31U2j74tqxg9Pm+SC+CM4rJJSc3JLEst0rdL4MrY
        tnwzS8EXzoq1m1+yNTBu4uhi5OSQEDCRWHhhIXsXIxeHkMAKRomNO6+wQThfGCVedC+Hynxm
        lNg2/zQzTMu2jj+sEInljBJ3rk5mhHBeMkqsmt8OVsUmoCNx/s0dZpCEiMBKRomu1gVgVcwg
        La8WX2UBqRIW8JLYevEDG4jNIqAqsf7XbKYuRg4OXgE7iXMLDCHWyUu0XZ/OCGJzAoVXrv3O
        CmLzCghKnJz5BGwMM1BN89bZYMskBD5wSJw/9wHqVheJtW92s0PYwhKvjm+BsmUk/u+czwTR
        MJlRYv+/D+wQzmpGiWWNX5kgqqwlWq48YQe5iFlAU2L9Ln2IsKPEhkPPWEDCEgJ8EjfeCkIc
        wScxadt0Zogwr0RHmxBEtYpE39IpLBC2lMT1yzvZIGwPiWNnvzNPYFScheSdWUjemYWwdwEj
        8ypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzApHX63/GvOxhXvPqod4iRiYPxEKMEB7OS
        CK9hzL4UId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzatieThQTSE0tSs1NTC1KLYLJMHJxSDUw2
        FZ8KHy15H6ildUY3pzvgsX/NR8EFNyfs6tFT+rV8tulKGabswh/TXig9sZn1effh1d+v3c76
        s+XxK5bymk6r7PsO3CqvbcQsupbFnf6XX3FYRVEhUPnmo7WBsuf4bhxxW/CzrfYsX0hMzc7v
        /KceGjJ8mzTvcL9ZV+gBxb0z31ny3rqpX/rzNIfdr8xOkZVNDYm8MReX7JzpYfXkewJLAqPm
        5+9MRv+lVx13kvDoO/w+8j774ifPtNcb3lZaM92A5XfmvI2tj1l1Tif1vn+mPzXoMmvv8S61
        zDOKB5qbfgqfeWWf/T6QSyatetvi6ueT2Sc5fC1LTmgS7L67JTzE83MdA1dSp8vM3JZFR/cp
        sRRnJBpqMRcVJwIAR5FDD8kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7oTNA6mGDycKGYx53wLi8XTY4/Y
        LZbuf8ho8X9BvsWZ7lyLC9v6WC0u75rDZnFjwlNGi2MLxCy+nX7DaPH7xxw2B26P2Q0XWTy2
        rLzJ5LFgU6nH5hVaHrde23psWtXJ5vF+31U2j74tqxg9Pm+SC+CM0rMpyi8tSVXIyC8usVWK
        NrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MvYtnwzS8EXzoq1m1+yNTBu4uhi
        5OSQEDCR2Nbxh7WLkYtDSGApo8T67rOMXYwcQAkpie/LOCFqhCX+XOtig6h5zihxveEMC0iC
        TUBH4vybO8wgCRGBtYwSN9+eYgdxmEGcedOngVUJC3hJbL34gQ3EZhFQlVj/azYTyAZeATuJ
        cwsMITbIS7Rdn84IYnMChVeu/c4KYgsJ2Er0TH3KDmLzCghKnJz5BGwkM1B989bZzBMYBWYh
        Sc1CklrAyLSKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMLK2Hfu5ZQfjylcf9Q4xMnEwHmKU
        4GBWEuE1jNmXIsSbklhZlVqUH19UmpNafIjRFOjsicxSosn5wNjOK4k3NDMwNTQxszQwtTQz
        VhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgmrp+3pNjXXoHLy5NWnHWQ+7aI8XTXQHXC/Ye
        i/xdW/rX/1i4jPK6vYKfd2fp1caafCudKHh7Q1vz38KTV9NvhT0tZNBY9TovXKNk+cWI3V/d
        xL5/6X+2R/iKpv2Vzu/nG6c93n3Bc8mrhX9++V5lWMnwUGkTS9Xlj/c6vjq0sdR3xOVYpF+e
        kyEv+WWC4VJn0/9n+bq9wnYufPmmILH/7R7DNU2fDsp4TBeUSvgT+WuD+5sT1YEPz7ftu1xX
        HWnXEr+E7W3MlULfD5N5Z1jadPzat97wbJ8Ov4OqlBtrVMOzpsAcsWuWDru1njywZk5IDTVI
        zqlxCgrki0zQ9fh84LuO2JW1C7esqnO8oDjlshJLcUaioRZzUXEiAIPY8mk1AwAA
X-CMS-MailID: 20230726140712eucas1p1bc7b2d150482936d974ceba9c51d7bc4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230726140712eucas1p1bc7b2d150482936d974ceba9c51d7bc4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140712eucas1p1bc7b2d150482936d974ceba9c51d7bc4
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140712eucas1p1bc7b2d150482936d974ceba9c51d7bc4@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is part of the effort to remove the end element (sentinel) from the
ctl_table arrays. Now that all the callers to register_net_sysctl are
actual arrays, we replace SIZE_MAX with ARRAY_SIZE of the table.

Stopping condition continues to be based on both size and procname null
test. This sets things up for when the sentinel element is actually
removed: Before removing sentinel the stopping criteria will be the last
null element. When the sentinel is removed then the (correct) size will
take over.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 include/net/net_namespace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index e4e5fe75a281..75dba309e043 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -470,7 +470,7 @@ void unregister_pernet_device(struct pernet_operations *);
 struct ctl_table;
 
 #define register_net_sysctl(net, path, table)	\
-	register_net_sysctl_sz(net, path, table, SIZE_MAX)
+	register_net_sysctl_sz(net, path, table, ARRAY_SIZE(table))
 #ifdef CONFIG_SYSCTL
 int net_sysctl_init(void);
 struct ctl_table_header *register_net_sysctl_sz(struct net *net, const char *path,
-- 
2.30.2

