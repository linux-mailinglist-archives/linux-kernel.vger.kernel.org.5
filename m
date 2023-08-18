Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D694B7802E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356816AbjHRBNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356784AbjHRBNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:13:20 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8464C3A88
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:13:15 -0700 (PDT)
Received: from 104.47.7.177_.trendmicro.com (unknown [172.21.201.37])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 0633C10000D00;
        Fri, 18 Aug 2023 01:13:13 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1692321192.295000
X-TM-MAIL-UUID: 483eacfe-0f22-436e-a90e-d0b8e881b6c8
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.177])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 4839110045534;
        Fri, 18 Aug 2023 01:13:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOEQ2MzhrlrdMhJkW/eudMWB9s/ws01lLYETYhi/swLlaD3j1sLE9GiFTTDFXJlO3L0MAd3HkLbjOMnR3QB0BuFdMtKZ3BKwLb0pt7mtS3JQ1Wgt/Mmfyb35SUeyrxJptA2wUZv1BdM2xj6gr2ZTWWA3cNonKP2us3V9/srVJ8PWN6lL6ESWMrKUwF23ykPb96iqHKzMI4dZwliOqftbVft/ktHXkY4Mj+YbDIUdwk6Ns4S0GlfFTeLkLdB1veHKMsg3PdcOa3YHPFSLlpraycQLJaoYI9QG4itWfVC2Ya3ZN2CThqjNjkTBDXzuTlIsN3xSYLHrFbxMgiHIyPXFsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sOMR9yqKcgDMiBxCiqIGcTs+3kwO8/J1xL+310D3Uk=;
 b=h/9Zzk5+UczmT9zYYPX44cYNpvqrtQffnvh/CbUh93raP1mqWlPo5GzGR1VvnzhPJdroqsHdtZiJcfcBf3ta5kRXOa643bYWO2ju/VJ1o5e3bMcr3TJLM4uZOrznEZrpr73gKdhhVxYRnQU0kP/w9hyot8znY6+qk1gshnIFjG5CEciHQ3pBVkP18u8mj2Q3PP9wBsnTNtPVVp18hfP2CJ7iHtdhSxvjpm6guutnkoYk5zusALahPyRP/vv71lZSSj3ZOcXIm5OiHi744j+MsnGmmr1lVcG5ukp9CeEmjSXiiw5njL6FMjbVDUkEzHbFX7eF+Yrt4uDfm+eg/Lmh8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=alien8.de smtp.mailfrom=opensynergy.com;
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
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 1/4] x86/tsc: Add clocksource ids for TSC and early TSC
Date:   Fri, 18 Aug 2023 03:12:52 +0200
Message-Id: <20230818011256.211078-2-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818011256.211078-1-peter.hilber@opensynergy.com>
References: <20230818011256.211078-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6EUR05FT054:EE_|BEZP281MB2085:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3b96c4b3-3646-43ea-782d-08db9f8849eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D33cskVbHb2qLeogC9Re7yYoOqD5+DfFRlY85LZKBUHzkTYWf/1I4bDMAVibl+M+ZSda9L9l4ow4kQNMHynFdcBhZEDrApiITcUvzEhTKJWOJo8TVn15d1CM8LBbla0yDJmn7FVM2Cg9fuOn5seaNMjROC+y2+SSVF9xGTKUU3pTCSA+DAE/yVwigTzmzPAyE/idhVQUShOzS/0aD/51rhAI0iS4vPMOW1ZJKYH1UzjGAs/M4pqlbjcqIB6iLO2oDAYUQheIhRrP77QopmHP5DB0eXPJodQahWig95KYz2Wp5eJiYUO4OLo9qw1WIiHp9v+CkdK/3T/kqbvUoGicjgzkBFmYhtabwHkUUi7s+gYu101dS1vIWmIwhwDsXKcNAFLp5fgy6dnrB+KhR8nwTCQZGWKUuApRGphHePmZbd70Gqy5Rx9qAReAvmjmvkxT3rmM7ae/Mo8QPdlYK7I2m8/HTwz5mPBhKrGFnpuF6DedWJh6vHYIUmjVsnfC6ASu/o4LJAKTkFzES1WguXpUGL6j7r2sylMvTem8WdA3zof8VKBl6/0JOy4yDaJpjyqTQ+c0b0E2dtY+fnlWlX58eNxl7UyGO5ohCkqpUHpXb2uaX1SripjdyPFv7ruopgFxxk/p1dpA+H6nrO9ZAGj7cYk5d2dpPUxFy9PGEr1dxHAbW2Oa0Y2OMuzLhfFJ5Y8hbrd/BEzKLjT6t8aJhGRlsaLO+zYgHtIdFWX7mvdsGwvnh2H4VaI/XyKoJzNXD4gz11uqd4/SDhGC11GTm9PSqxHO68u3bG3ahRqqoK7lux9CQaOEZt2p4BWvqWcGW4pF
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(39840400004)(1800799009)(82310400011)(186009)(451199024)(46966006)(36840700001)(40480700001)(36756003)(86362001)(81166007)(12101799020)(316002)(6916009)(42186006)(54906003)(70206006)(478600001)(70586007)(41300700001)(26005)(47076005)(1076003)(336012)(2616005)(8676002)(8936002)(4326008)(5660300002)(2906002)(44832011)(36860700001)(83380400001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 01:13:10.6813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b96c4b3-3646-43ea-782d-08db9f8849eb
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT054.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2085
X-TM-AS-ERS: 104.47.7.177-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27820.003
X-TMASE-Result: 10--9.801300-4.000000
X-TMASE-MatchedRID: a3KJLn6RIiLJ+P2VFrJmrKwODSO9Fuc1zmG9pmg8ncJNbINBwEGUTQSg
        qzsOhOQ62Otu9g2VXrOnyNbHJWoNRfrBKWABOnETkh0LRDkkMBzc7b6k5+X69zAsn09lQFCFrIC
        z6b6B6MtYtDiJe+zJcXYtZP3AsqrJ/OIuFyfbszTHfnPG7+BDZhJFEvBK54Paqa5aeVMSQixPQF
        Fk0j5jBsA2iDfbpfy+AVpeDm8nJoLwnQHFZbUP3moEkqixPwVYOfEmq6feyfNuRXh7bFKB7krGa
        k09WZA2JV8q4hsCB06KOcJAbqGnmZhCSgtKeJ6gvuvB6gAgryg=
X-TMASE-XGENCLOUD: 3b7e7e8a-bca8-4d17-90b4-50e461f8b50b-0-0-200-0
X-TM-Deliver-Signature: F41066E4853ECF7FA0B1A77A1B6A12E2
X-TM-Addin-Auth: l4et64hzRsGu2xuAAOr7dsN4iePtFXbvSAhd79MMz0saXKtPD8S6+nsPG2o
        dnRO4dSOy58JVRy/2ir07/nAtlLUpdj3ilY/2PdWsjHhxD5FEh202+MNYzcXbpfXZqt7M2DJTza
        0i3eLH9f4E8rMVxrliexca+EnrPyUbJh8Guh5ptGcyrgJOW9nLi0OeAsWakj0PFFg+omFYkaJOz
        egfXSUYP34zg6OlQ+5GUzU0WfW+TgdUWK4aK87H7SvEW6RwcS9KrIq+hMxnIK+mbmMCZT3p1VAD
        4V7JAzQo4SwDTfs=.ZDeXhrUR3tYqCiBNMIFyItIDuXYVMU2ldb9252ED8z/9qARQKtWrry/uFh
        WzQBX2gssZLV026yWmauHBDulbUKVDBSGLpIIy0Anxd2ovhT+GE/vMMJ670kweTzSsF1PwTGFSx
        /C+Muc6iC4nVPbZQSZZeKUeVappSDy7AxbvNz0x7X2pYrPidwefQ6L9ViQo9sOmpskQT/kHQyWx
        D4PaE8OcU2cm7MuWAo/oPhmYtbW/BC566N3WkMt2L6Cacdm6K8Uopkp43snHDG+b+Fuju1zhU+0
        wynL/iodOiubWDWavW/y9mUg+bI0RtPT4GWDvHhWKRd3xpOj1z36+EwQhBQ==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1692321192;
        bh=E0NpG45K0Wv0WD2Xku/H7DuHx7ilNy7QV5/QPdKlANQ=; l=2056;
        h=From:To:Date;
        b=exYL7u/DOIjMgCXyx0XqW9WhRSWoncSSiBWpb/jCAKxvX8SMtideHY445ApXBSb5f
         oQfvOo4qBq9tnM425tjB2tuXJxHAuREjy70ilqZs+RforjVtulTMzY++PFeSM+qWWi
         nVvcY+W3Rl8IneWhSZfPOq1QwD+SDPdq+9MBShRPa1r3kxisNRgc0HwZlG0FQ0JGNj
         RJat0ybGCBAedPHh2x88wFXaVYsRFlmMVMONfqFkJUENfneMXHCb7xm8gGK+FPfUQP
         QolI9xKOU8BJUaXDmRQECoWMA9eqFOASJOr5vlqvFZW+w/6UNth4M5b+P4Faed8mX7
         KmiuZnO80ZvGA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a clocksource id for TSC and a distinct one for the early TSC.

Use distinct ids for TSC and early TSC, since those also have distinct
clocksource structs. This should help to keep existing semantics when
comparing clocksources.

This change will keep ioctl PTP_SYS_OFFSET_PRECISE working on x86 in the
future, when get_device_system_crosststamp() would be changed to compare
enum clocksource_ids, rather than struct clocksource *. It also makes
identifying TSC easier for outside code in general.

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 arch/x86/kernel/tsc.c           | 3 +++
 include/linux/clocksource_ids.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 15f97c0abc9d..132045be76d0 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -11,6 +11,7 @@
 #include <linux/cpufreq.h>
 #include <linux/delay.h>
 #include <linux/clocksource.h>
+#include <linux/clocksource_ids.h>
 #include <linux/percpu.h>
 #include <linux/timex.h>
 #include <linux/static_key.h>
@@ -1168,6 +1169,7 @@ static struct clocksource clocksource_tsc_early = {
 	.mask			= CLOCKSOURCE_MASK(64),
 	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
 				  CLOCK_SOURCE_MUST_VERIFY,
+	.id			= CSID_TSC_EARLY,
 	.vdso_clock_mode	= VDSO_CLOCKMODE_TSC,
 	.enable			= tsc_cs_enable,
 	.resume			= tsc_resume,
@@ -1190,6 +1192,7 @@ static struct clocksource clocksource_tsc = {
 				  CLOCK_SOURCE_VALID_FOR_HRES |
 				  CLOCK_SOURCE_MUST_VERIFY |
 				  CLOCK_SOURCE_VERIFY_PERCPU,
+	.id			= CSID_TSC,
 	.vdso_clock_mode	= VDSO_CLOCKMODE_TSC,
 	.enable			= tsc_cs_enable,
 	.resume			= tsc_resume,
diff --git a/include/linux/clocksource_ids.h b/include/linux/clocksource_ids.h
index 16775d7d8f8d..86d23abfde2a 100644
--- a/include/linux/clocksource_ids.h
+++ b/include/linux/clocksource_ids.h
@@ -6,6 +6,8 @@
 enum clocksource_ids {
 	CSID_GENERIC		= 0,
 	CSID_ARM_ARCH_COUNTER,
+	CSID_TSC_EARLY,
+	CSID_TSC,
 	CSID_MAX,
 };
 
-- 
2.39.2

