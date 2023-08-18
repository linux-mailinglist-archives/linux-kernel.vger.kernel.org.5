Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65282780304
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356904AbjHRBUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356882AbjHRBU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:20:29 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E6A3A9C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:20:27 -0700 (PDT)
Received: from 104.47.7.176_.trendmicro.com (unknown [172.21.196.113])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 830881000007D;
        Fri, 18 Aug 2023 01:20:26 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1692321626.183000
X-TM-MAIL-UUID: 3fab948a-8b7a-40be-ac8c-11e5537d2e33
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.176])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 2CDE0100003DA;
        Fri, 18 Aug 2023 01:20:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIZMBMb0/onzjpoksuB4f3Kh63MtjCjCf7G1BB91VXiIb8JiHfUb4D8pY5apJ1WqiU3GunFs6KfWNL/zNIkjdXABK5RGep1L75H/BZz1xoxS7thuxTFYrWJI5jfiACaNVrOi0d85xc8q8GbPJh2FMg4T9qBtu7bKpuNyATJtoyyVFgZYCUy94E4q+GMceLzK6u3VHm93XeLis6pEbhE6GqpUbpFYhjh9iOb4Ny+UPZivlK8lieASevSjLcuN/Hv7dO1GOc3Q7jWI14JCc+eFv6ZmqZAzjSK32N+WZidYPlj/usct0VGVncZL9ufujopvHjLEDkuOSrT/hImcFsO42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jMpDW3EhM/DPZc/6Ftfol/s8Po8YoQrXZd9PFLo2ww=;
 b=k2TyGdqIICJFXBnIJdDNNleS2vRzHVGTujbQupGzyaLp4xg3mi1hJp3TSyuM4SzPnTiZoEzS6vQ+/WIHSOpYcq8HWg3YrTW4MWdNrFfiV1lES1nwYpHSDObCnbNbvnH6o6/e07C8Yxhmht78WQ72QwfcuEwkufVEKieJti5DXq1TUJy41RMLK+BoHZhtacTRO7QS+F+2Muuf7N9/sBm79l9U6Q90W2jcat6Mu95FJH85YvaAkr7UBQMvRvu8S2lQTDPvkhFwXDwEF5KSsf5v+5v+hyApLuWgmgsChIJDWIIAu8nUJC+O3dllDBRMXQtZGx5gtRdCOvcJRobre4SVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=google.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Hilber <peter.hilber@opensynergy.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Christopher S. Hall" <christopher.s.hall@intel.com>
Subject: [RFC PATCH v2 1/6] timekeeping: Fix cross-timestamp interpolation on counter wrap
Date:   Fri, 18 Aug 2023 03:20:07 +0200
Message-Id: <20230818012014.212155-2-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818012014.212155-1-peter.hilber@opensynergy.com>
References: <20230818012014.212155-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1EUR05FT018:EE_|BEZP281MB3029:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4c7e8aee-aad3-43c5-525d-08db9f894c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lkM0T3nHOnmAcNPq8FOBynIAXSF4tfSOkbX+QE1azUHtNqv7q4U92Mro/DNkLFadHGqXQY8PUJi2Qj+ZYyj5U3QkRBVxUPdiiJNyJQ0oNal4nj8oR629dOqRRqUWsWmA6eH38W6WcXgyY+Ku6piZwebk/OieqxIq9POWsBGPcswKOQEv6lb4PavjVFosuMf9Bchx0OoObftKa8/8vZnzJ/sYNApV6ENaH1qAqq6QjXBDFqh0T+OiIGENgC2cSiOiOF7fe+Cgbm0s6iPyEJAOZ9E9x4df5IsWS+rkCmjZEGGZM3AfIuz0ePBgDGJDXzu7w2KspPF0hY3uVcLC6XT4xdz3hRvbVZes/qoMXsoDiVz61nKlLvB2JnFmJ+qbGf2Pj1jtoISGpF/ZDBqvuCTeMeel+xE7KSc8z3z1LbMZpZNlkySwweg7X58zu+qdzalGc+KJeMW/IuGgPNfkOjsC0XG17CXDLDjM4EfFF5EcVXuF0e7b4rVQypZxreeEEkhHE7qIDZ/XVUNFJbL2Wq0exFl+gdHMwshLCxlJauMmGps4LIoh5PZYNdAsWudlsuY3GAar5Eo7Sd0wV5FpHsAcY11TnPRy2qpDtZSIfsqIhZdchVzWxZPw5eKxUcErVd28oFuaKP0h+oXXf625e/W1Z1QaCuIg/HmVIHPCd5oVB/37rsfm5dTNL7otOemprJDGlrS+pw1qGqYMxWKwpy3gkZls2raTk008KHONOCGajlXBxPOfBBioPDHrRFvZ+8rvJBTELyeKA1HtOUIwbWXQSF0Qniu4wWqUmrXM3DO/I+M6+cbTKTnPvXV9sKLCHLTh
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(136003)(39840400004)(396003)(376002)(346002)(186009)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(83380400001)(336012)(81166007)(86362001)(36756003)(47076005)(36860700001)(1076003)(40480700001)(26005)(2616005)(8936002)(8676002)(4326008)(4744005)(41300700001)(54906003)(70206006)(70586007)(42186006)(6916009)(2906002)(316002)(5660300002)(478600001)(12101799020)(44832011)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 01:20:24.4212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7e8aee-aad3-43c5-525d-08db9f894c75
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT018.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3029
X-TM-AS-ERS: 104.47.7.176-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27820.003
X-TMASE-Result: 10--3.038700-4.000000
X-TMASE-MatchedRID: vveLpsopuKu6TyUO/xKZhTakEkBtr136rutCeVh17xk7dRmDCUrvToyD
        IPOAt5xjKy3tE1HfkQHDxsdOfchH340cVCEiK1Pf0pUa1RtpyoMqq8hD1DGRIIloy91GB/ZEZSL
        4AKI4WH7m9Tc/GgfFJwFtWueZlMH03IFzQVLcaPdCPQBD3xA/3aODSWu0oxbK6gfKtA7Yhlrtmy
        EvxwC5ZFJxK/8gkcZzWa6vTkKxwrI7AFczfjr/7FNYczJS4TbyEZmZTL07e5zsGsMHPmPu+4Pka
        zp5pG9Ly2RhSSvTaLc=
X-TMASE-XGENCLOUD: 3c362cb4-d461-4c7f-a4df-3dc55808fe4c-0-0-200-0
X-TM-Deliver-Signature: 31C04E106467642A94659F29739D9854
X-TM-Addin-Auth: /ypS+Gi8TQfdEhWjPcDU3XqNVRbGbZZ4PiKT3vmEz0zDBu2G4PpcCmlvfVX
        XZfv/Vzgh8wbDvgKmHnv+FdgHViHKuRunmDi+r01eAtqoD/Gth4Q8yV8obfoNM8qBn8OBK/xMdN
        cIfZTkLXAt0hhWCqpLlYc8IsVrjNldBprutwgecXMttqPBQl6ITDazoYcD9WF5EzxOFBUXU/4Jy
        8TfYWM9abRYdLrVdK/kjiqZHQTUkl1c+TRhnOLJiv8dpDR5AHEj5zuR6DUeuPaa9lOV3jTPpL3v
        8rfUJ0AScAyN8Ng=.s5AGlrpyNmFcF4ROBFkHtInc9YX7yij46V5OmbgeHvZKAntD54kpLNh3LT
        /IgbxJbbgi9z+hPOENavZFKibpEVdA54m1RIMhg4q0sXyYqNYvhH8Pxq2tljZWy6QgZ4gZXPnyr
        RlBr4hKd4bvQuQRgxRyEy4ZhpjQJbnnNEFd56i9BDbbCyExsvKs5AOgX01R8ALBcOmQwdVIv23b
        Z8UuW5GhutnImS3mOP6qqTNevBTpJGd7i+lXOxESAP5WsWGFxDcpFKtY4ftP7eH1OjrnkXnH0zU
        5LggoUQSVYg6IMF7Qf2HBmfp7bgx565cZy5HRAGZgjse7ECq7NFtcHjVDRg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1692321626;
        bh=wfDRhMsYwY4h6R3+IqAH47PsOI2FJDn9J7CtyBigWeQ=; l=1035;
        h=From:To:Date;
        b=Vjk2tjn+FIZ26gu9yWRB7sX5h5VtnqvI2yeQmbG8xKQkdQhh7gejjSC85jYhEOofk
         8wt+n30h34AnaCLYL2okL0zzeufhUYXOAegdVGwrSd4SCVRSDuHvb1JDD0u3ca/5ni
         x4tZ45WbjKnSF6aJwiP7Ua9qiVos3zdkApA5IfrGAzm0vGUtJb/w701Zpbk4F+29Id
         cH59Il9dRzmnOY79k2Wu8OsgCKqKRWnW859lsEuG6LsVwX1efJ6c5bgCtGQGYAxWPY
         B/+fyVaujqTB5HIwu2gBeg18W/ol7zcx5TZjjg945l5gJ5Omjt97i5LIyFp5O1/hW0
         IlJwJQjcR14Dg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cycle_between() decides whether get_device_system_crosststamp() will
interpolate for older counter readings.

cycle_between() yields wrong results for a counter wrap-around where after
< before < test, and for the case after < test < before.

Fix the comparison logic.

Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supporting slower devices")
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Acked-by: John Stultz <jstultz@google.com>
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 56428eadf4c1..cd5c83473bab 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1186,7 +1186,7 @@ static bool cycle_between(u64 before, u64 test, u64 after)
 {
 	if (test > before && test < after)
 		return true;
-	if (test < before && before > after)
+	if (before > after && (test > before || test < after))
 		return true;
 	return false;
 }
-- 
2.39.2

