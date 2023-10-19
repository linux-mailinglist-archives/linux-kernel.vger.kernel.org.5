Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EB17D0023
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345346AbjJSRDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjJSRDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:03:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE61A126
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fb6FUiRq4QEMmOm69XWbuPjBMNzU6L5S+wUQjjcG9GjL/8qAS3GnJFi/kiFWAuEuElysoyYX8ly41RXgqUvXSlw6uBcolO+t1O9TTY3zUEPQY2lXNxHVS2yUmObLQW0+819egovFf7azrw93EeORLLkaQNYh9PxW1fIq3UUoWx1kBSjBLVh9Eh1UOlTOqpsU2009J3Sn1mZ+AZYTdKW4aO66kieHeU4P0OhzhVWLHjaKpn9vEOpBW0K8Yc8LFsH2zFilEdJE3xNI95HPFeigE1BrC3OyrH+6a90B3vLDfMkYFplBmaSs1ri/lU+1hSukmdmyYSL9NOawNd6Er6wG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvlfkSiwtS80Dvasq4eGxpZBCwpGQw7Vn/Ww3EQth54=;
 b=Vnl8ma1ZO/7RuprPCNkltJvR3aKHcETcY+m6LeFq+gzt5cN5btK959rTSboJTcZIWsprUL+lzbMPcaMemUS1gRpIPuWm/tnyXU/SBGzg7xSawKaE1mjtrzH4ry4HvgQfa/YLMZ08i5p8nwNRbBil8G08d8tTgAVnVv2XZLpyjuwQ8T3QeXRH1Gp8vqrJg4O+GrfPPHo6Vvmn3CNNiOXkR+6HvZiETf5MfJnyQuIgxKu1N9MXNkA22xdj9cu3wlv+NcBnutbkHO9iVf3FxcGP7okga3WPtNm+Rb7TI/VzD6Z109aMi6+V9s2gt111it8uBCBSnQ9OddzNda3EGIB/jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvlfkSiwtS80Dvasq4eGxpZBCwpGQw7Vn/Ww3EQth54=;
 b=IEb/kTefI7zoks1vGvHLj5YineEsulKlZruJO0+6K1+u6eNMmmqjj0adi6e6OlK6YN36vkz+bh20ARLDL2qcV4aL39bnNxfftIefBFX6Gmqis1Qqq3E+FX4hlbA1tyqwRGs9AwZt11Xw3JOOElyXmEaywSVVQcvixDNJMTn44Es=
Received: from MN2PR15CA0053.namprd15.prod.outlook.com (2603:10b6:208:237::22)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 17:03:39 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::11) by MN2PR15CA0053.outlook.office365.com
 (2603:10b6:208:237::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Thu, 19 Oct 2023 17:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 17:03:39 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 12:03:38 -0500
From:   John Allen <john.allen@amd.com>
To:     <jwboyer@kernel.org>, <linux-firmware@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <suravee.suthikulpanit@amd.com>,
        <bp@alien8.de>, John Allen <john.allen@amd.com>
Subject: [PATCH] linux-firmware: Update AMD cpu microcode
Date:   Thu, 19 Oct 2023 17:03:20 +0000
Message-ID: <20231019170320.1154960-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 614f6136-6093-410a-c340-08dbd0c5571e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NiQq10gRjFs9dsSv6CMSRyzF/HJBoJ6MVKWVMrKEFXuft/GnpI3+EN6taNPVVPDDL0hZnyiy8ZP4SdT6rpiKDrRt9b4VErGwIKVcGTh+rKXJk+1Rbq/Yt4tkNtWL7z3EjjOPrlXUZ4eEruALflu3ReFS8ng+gOa1kc5mQYXR/lR661e+3hbIFsBhb/y5M/sXRApVg4qvcW87MB9S4h8wSerbq3dxVfBugMEQwF0dhgxbe04XCW9uVixrWH3AWbrUSDiClei6WvdmQT9TcPGgci0HnV9/u7uwo6iVMI/CSkICsYRSfs0FcX4KYCkDwA4o9yqgoGyGp91/cEOccc23xjK2LfR/Uz23qT/B7S9NsSi/6V0IBQb7pqzMh1/JFThWUE+Kzdttpdc449YJw8jgDtZTRhQiNU63G7mVZunLLgJG/R5TLnTbR8uijIOW07wyctZklXJqcnNdDJYPX88H/lLD5Mo4K7yA0u968+8U1Bg8OZg3jpL3vIlRb4kmT01kKcXcMwsLnIiSzcgudR0AdayV4vAbXVkSSFxix3XAwUDQ5tHlLGBKUksin0BYkHcRTblgy5Z3d37OjDGSygpbMjfMeC/JW7ZJRN3dAkX1dFp80QcvhQ6gMWj4iXAY6gRUtjww9sr4RLwkZZvTJPpOhUnbiovM5xX00JVLZNFcJqODcsJaZPTx+JmvQqwDiQEq8WjArBw2BPjrAnEDe4duVt1yw2ii5n6FMD5LXzA1XzkRNkM9dkmw3bhQb096qyDgEqRw/yYz97/B2+mbgmsza8hdfWckTv0cVwLZfmaa+puxc1wnkH8tHIJFmD9aVsnS
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(36756003)(8936002)(40480700001)(40460700003)(110136005)(54906003)(1076003)(86362001)(81166007)(82740400003)(356005)(426003)(336012)(316002)(83380400001)(7696005)(16526019)(26005)(2616005)(4001150100001)(6666004)(70586007)(19627235002)(15650500001)(45080400002)(70206006)(47076005)(2906002)(41300700001)(36860700001)(478600001)(8676002)(5660300002)(44832011)(30864003)(4326008)(36900700001)(579004)(197154004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 17:03:39.1356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 614f6136-6093-410a-c340-08dbd0c5571e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Update AMD cpu microcode for processor family 19h

Key Name        = AMD Microcode Signing Key (for signing microcode container files only)
Key ID          = F328AE73
Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73

Signed-off-by: John Allen <john.allen@amd.com>
---
 WHENCE                                 |   2 +-
 amd-ucode/README                       |   6 +++---
 amd-ucode/microcode_amd_fam19h.bin     | Bin 39172 -> 39172 bytes
 amd-ucode/microcode_amd_fam19h.bin.asc |  16 ++++++++--------
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/WHENCE b/WHENCE
index 0758a86a..c06f5d80 100644
--- a/WHENCE
+++ b/WHENCE
@@ -3970,7 +3970,7 @@ Version: 2014-10-28
 RawFile: amd-ucode/microcode_amd_fam17h.bin
 Version: 2023-07-19
 RawFile: amd-ucode/microcode_amd_fam19h.bin
-Version: 2023-08-08
+Version: 2023-10-19
 File: amd-ucode/README
 
 License: Redistributable. See LICENSE.amd-ucode for details
diff --git a/amd-ucode/README b/amd-ucode/README
index f47743c1..86d69822 100644
--- a/amd-ucode/README
+++ b/amd-ucode/README
@@ -37,13 +37,13 @@ Microcode patches in microcode_amd_fam17h.bin:
   Family=0x17 Model=0x01 Stepping=0x02: Patch=0x0800126e Length=3200 bytes
 
 Microcode patches in microcode_amd_fam19h.bin:
-  Family=0x19 Model=0x11 Stepping=0x01: Patch=0x0a10113e Length=5568 bytes
-  Family=0x19 Model=0x11 Stepping=0x02: Patch=0x0a10123e Length=5568 bytes
-  Family=0x19 Model=0xa0 Stepping=0x02: Patch=0x0aa00212 Length=5568 bytes
+  Family=0x19 Model=0x11 Stepping=0x02: Patch=0x0a101244 Length=5568 bytes
   Family=0x19 Model=0x01 Stepping=0x01: Patch=0x0a0011d1 Length=5568 bytes
   Family=0x19 Model=0x01 Stepping=0x00: Patch=0x0a001079 Length=5568 bytes
+  Family=0x19 Model=0xa0 Stepping=0x02: Patch=0x0aa00213 Length=5568 bytes
   Family=0x19 Model=0x01 Stepping=0x02: Patch=0x0a001234 Length=5568 bytes
   Family=0x19 Model=0xa0 Stepping=0x01: Patch=0x0aa00116 Length=5568 bytes
+  Family=0x19 Model=0x11 Stepping=0x01: Patch=0x0a101144 Length=5568 bytes
 
 NOTE: For Genoa (Family=0x19 Model=0x11) and Bergamo (Family=0x19 Model=0xa0),
 either AGESA version >= 1.0.0.8 OR a kernel with the following commit is
diff --git a/amd-ucode/microcode_amd_fam19h.bin b/amd-ucode/microcode_amd_fam19h.bin
index 02a5d051d58b8028275ee6a0b091f11f8d1b6e27..412e5fc83dafd35177aeb39bd75c463658694587 100644
GIT binary patch
delta 15313
zcmV;?J1)e8vI2y%0vbe3K>z>%004jh000sXp#T5?00000000u9kvbv{0uQPH00000
z000000;-W(A`TG`p#T5?00000000r8k$M~h5eY<-VHO*IHFS{Lv@m<0RP$?^U>$L<
zwEq|1f`au?B#Z9oUK3)SoU?4AXM)eFtTDw5iQ#=AL;mZJ3x`aPi@wp&FxYzH>u(b9
zF_rrgaC#9i#1vOiC+IA=8ic`){^&qRPee_k1s^x!A@ZAs${SvTMqc;&r<R<WBqE(5
zRkCq3{uJAP7Vdy6AO>X8&Z0~~Y_ByH5NXaE=<>%-Aje0LO*B)2Rh`Pb3su3dLK61d
z4vdg|D$6TWmk&>G>M=EFZCKQ74BONrNHT-s)zR>++^q}k3;LEl%Nh=2+$VVl4W6i|
zLSS_2Q0EH65aA%<+pN6{90i$6xkMBZI=61~C9aJEl8Li?7X$)-L=q4REc}5GQ74tF
zq)CJdg2!Ts<vr~$ivgo&GR69ShSSl-)rPthX+tPt)3y2v9+A?`Xk}(YCxt`U&7<lz
zG47iV%r=~p|4vR!)US|LH$xDIV;KcJTfj-lJ6~MvVAdk0AOy{@h1B?rMdxBnu3~OU
z+&vS2p@9xZOMK#ge$1vF4L4zxG{&}Ws@Xy&1@4BiXk|sM#G{3*Xp{RWa8Ip8=jcc*
z+`#!J-{&$S@JfgM@ZHLtepmC<iUDVS69Ug0<80Ly4fzTN+8v61yL-7Q>BQ)eOaTl)
zD8{}A<<%_~7%TMAA>3C7rOmsm2QW~SM18OJwNZZocyTd*C|=yf^;wGJm-Pv6fwSj+
zw{dHb&a?J*FzhTC;8S$#aN_>A8)iUyf-_x7%eY2{+rje9>nRDzM#m|2sVd5dBB7lc
zk<4}3+_l_vFUCpM6U=LYt+MkXpIr?qm#QMHi*@n<^2MjZKc9{YS7yvF_4CQ-odwif
z<)%?k6MUk7HO<X5!ja4k-8hSDWdOnLiS;w&YUQAkEWUsQe3}OrMw2^`LEVR}aAuk+
zx_Ql+fu*yMvuU-*TnFJ^-S*<4YnA`@kN-Afo$mX>cC{HK(JWktSk_TUi|bAD|I-^8
zd_9pwFcyYC+0T4r(~=d~XDd32r2%J{XUBHrTk}SLlJ$Ihk4NvFa*+PQ(x?JdVzYZz
zbv#7Y*Ci4|g`F>hKGT?38{olNUrw--qO=9h07kvvmxM8d+xELEyHM$z`IMw$O~|^q
z+B<lvm7{DGw~N9a=FbY%@7*oqMkKDSghP!A%E3S-9gl_FL?G-){$`6*A)w=LT3g8N
zppX53$<@*~U@_scM9Hp0qW>Qcw+b*WwxhyB@%%~*45J)lP(Su-dQ&KQw9%s6w1WO<
zlL!&syuDwLtAVKo;mRT4SurBfjf-N=WH(|rYy<n!Q!xVlzho!D!rRk9Z3KwMWi{1w
zu-7wI2*>YUi*Fkc`dpk?lM{W=Z!hFWeZSm)?IWwpFho*adAunueI>v)yy`2o;!KP0
zFJifD1_<k{f4UHD!uWsLcJxnqVW(Z)Zdh3IOI?q=V~?J|5P_#z5^jD&F|Ns8-(T6}
z*{zhUPNVMbr%Qx21#a}0T|~{Voa>4e$kWRKS?aS4jXUj^pbg=CNUieoQ9<&nKbRSR
zeuZ#|neK)sw!yX!XkL5lLIK4fr>{fXh9}u!c{~egq_c^*${Du5*$4P=elC`ZI%aWi
zAztU8aQGI2g4htSq4>rmjyJn4`})xiNSC3c-NJY%i=Icw2Nk6b65hx2py@<VY9m)*
z1C3iD#=A(Y&LSC>72+K@S9|2WH2=PTMmj=nv5kG0KH847eUK@avFT|Dj1}fQt@26F
zWmh7}4KivCO4ej4bviKVYxPfAKeHuaB2XjW-gGU>KLdAPDSappgju3Yp(UC`1il#w
zSCQ(7V*)}yv$ZR*t;<VB8OLgamRH#uV?6e=pilBd=rUC0Jv09()$6hb&imPa_n}@6
zm62aXOV5kz$5shUg>Fl~$Ybb9j=Lwm^6X61mQNCMfEs(4vrv0aoox)3FrZyB^%3fe
z%fvtVQj9k%+!(X#TrsW=Q!+@Ew@|G9ZuDH=Ily%pbzn=+y!D!{-&-klzJN;dp#oJ(
zf>PuzJ2kziXyDE2$eW`o9YW!MEglap5MH8aE)tZzV)Pe7Z8~bV;0AeC^PTHM*{&_c
zBWy<7pM5^CisN{>kB2%_W=U5?#uMHFiN)e)J(NCIs9r=+LTfu(M>k_FmR>zidIn>5
z3dey|nqPc__P5-pOR`?Az66R=O<mJCqeSsLu%#?|^rjOfdC-O5rj`|diFaJN*&oZY
z%HmZ}bj;NNwKW<Df!mLoNCph;GgH4mCHM-T;ykOY_9VO2P{0sa(_Z`t-LEgixeNE8
zG&B(LG-1twbg~8ry{|NKc^1X?Y<lMamaq?z6L2tjf+eXXojEJqa-RR9VWa@Rn-3r>
z71@gjS5vE)#$is^DdSCl@&0Z8eY<d3z23@=Sbo-(u&1h66g>uinn^FxWEJlyDpq&@
z*PuK2tICIAj{g4Y+&i-(xQoG(-R;#y6f5~n%b2N&$febxMB&%ND#^6itw9I4j)e(O
z>xpkeYe10?O*#@w;MmSA;`xaQ3Nt|mjBSdlZ1x`78fBz`;1&~qo~Mf_2wF!0hz6^$
z+$=t!V`{F0#7%r>QGNKMY;(b`1b6u4szFVuo>KCf9b9)3#bFU|kQEp?Q~A@=mbCqw
zVrPbaRWYz!zA!tu6J{-60kSTg!M&;3u<r6A#jP{3mSbb!9z{*K*?5tyy*bNJuX3~3
z{8sAXi#=TwxxHzBYdn43r99RIM=F;HJ1+Wh%rt3j20W54#AH)vVA99R))xRejXkH%
za0=RE>a%d@24>L-yk9K<c`AAC0}VAr2OP?+MSft2;R$3HaYexIv*cgkL+OF3iqNr_
zD<YgQmNUT-ui{l5TJ*oJe?*95HhudZKiJ}T+_5(qUFkM|+2u!Qx|~6wFxKdJUmZ_y
ztgEFF(Eb-wloQPZ^1`otpupl+K$Xw*_ogHo?6ARrQ-@V~6u)wC6>K`Nzq}xYw_8Jx
z#74FtvYAU&@wRtPI=A=DpSQqRprK^W>w*IzVsAKnXnf2Z%@3gFMIq?37;Xncb*<B~
z!i5^lpIQ-rB@`gp_GzqVOj=n34DC{_)s|dij@#4(D9~u97_}yBB^DujCMe!<a0=)c
z(*pQjw%*|dG7qQ)NM*8eIpR4=Nh>Q!RjfsruyC`QTwuAhChi?2G1617ypE?~L+%5?
zC0wJnr4bXUZ4_>FiHn<9^czDNqxd#|#T}Y}WLV>WUm>CHhctc;QL-z41}zvZ9&WyW
zHFMcnKbyM*v6{o7e=um72y%YdVAlsG1*|_C;Hb9_=g}d+kg`&vSu$}Srr=i4l=qYw
zz3`zG6m$&lS57P}JU=T=O3vxF`f3=yf{GP8`bX1r;Z6#)?D!`%WZI5~$uMRjN=%0>
zwb!kG61*QhwDoy$^1>kfV*=J}V^Ry@5;4Dpl@DsJv;~!|vToXS%MyhUd;zo}irDK?
zNf*^XNpOrO-$EZbF%y7pRp>2RSiDXty}zt%#RtV=EMSZpdIa}I>)fY~ayP=OSe{@9
zRo$w-jCQPKqq@392;x;B;8s9#s)b}0L4m7()}!LAS{ap<{$V-Tk}S0{!+k)FMs#=_
z^x<D!mn&Z&Br&-xx3m(4S87*LM8MpbSU!Mb%4}bxTTG(8f2Q2NAXGzbnNzQL)c<R*
zB<~A=WV9b-K?0&Dzft(NWnLzL%hr*!$V~~t4PfDM;u0^D$X8U`)v3q-D`he!zVh#X
ziBs7E!G}ZZAJAM~vR$X$Wm#TW9!FZhV|9?HIW~d80QUWBu{c})F*fs69nqS5PNP@N
zy3ItGoAiAkdRRK$wb^0A$V*r2O+JuY2~0Dtu+7ijG%9M!tRkhcgbI}}pEn|uXwf99
zc&`9gAN&l<i#ksl1!j)FgCLu#nIlbq1Tn>n7uU(XlUh$}sW8U5iibvL=_FcIu~%(X
zxDBk@Yo{8X9XPD9H7+EUs`j9?c)cTc&oKQbobw%K9~0-;<F8z((Id+`^aBD<=4v{g
zUg0~h+w!Jz5=Q;^|F?O(C`Zf~I}NQ_v*>7pYTXD;cZpPVq1z-|vCq*v;*?;2z3t4c
zN6oPxGMVTL(+y(YBTHMcNO~NxwS78SL#Q_G89%WtUiAJ}5kXYT74m?E3Y}}Ub;BG#
zMlC;Fx`?fp=_3h}h-9WjS;a~`KEC@_I<}LfZ(g4{FVIMnWBshM(n{hvA-l4o_J75I
zpo`&Rj&<y*(3Y>?3{Q)=RaT^btYkl1fR=_pWV5GdA<&%*z3Ocb*ZV&ppzF^jqra;&
zF++gyo8MPa9%Uw=*r@Ik>l+4lO_XfA8|s1?ZB!DYi8|sh1t%GBWYH)IG(t3(ZXWb>
z9${?&&JW6Os*=)h)#*t>5@9%}LA&5hRxV|-HZfnJ<k=!*Ty$<P67(E@_G503la%~I
zOy&6N@Eb=@hh8H#L!PtOq0PDj1Vqs28sq@l0Ju=*x*pyHLkk}S0<D-=oMc{G*?ui*
z%_0jq8*b{*#2f>}c)u|`II?C+%)Az~8Wl!NiK)%)ihKcg8(~1zcJOT`yt*y~v_Az2
z5=`>B^rd<*VUTFZnf2*^i8nvT??dv*@QH0b=9{uvP%pTE&8Bcx?N;XkQVB-uT_Tu=
z)3YcEbe@nEXP}lPX<Sbs%}T<V7ChMRcqvMM*0@9+7m2{e5`Cwxm`y60d-H3;)ZIy-
z1l;&CkM8;vz5SQ(-M~ENLZBs#e9Sa~iY(Btd6Zr(y!<3M{ZKuB0aFs(qY7b({U9e;
zAX16%951s)*`{-fF4j>qGkc3MqUn}6@r;B2DXa+GYZxd@L?xQk=Sw}Hg<zf@OW%9$
z@w@o6q^rhTF4Wi5u~Zb<_PS=shuAsCyksn)ZvE0r0SYCC(M=VTn4Cy+dp3=u!+w0-
zPSF0)q#OqsA1lLu)+CZGsgCm!@*yZr{)7@fh`bm{TNW<#a6jV9y6cFGL3|qotJ0#|
zX&2>VK1jUt2AJ1Yb1$xM&S}iJ?(_1tR)<HJ!MIUVA+;bOulA{8R0!O^(-Pe?M{WKU
z7(}f*Q4W>J=HVIepFF$|*Np@(_Yaz9a+7exhN(K>w+f+u20h<(N=I#iS34%)L^(f^
zUY2C?9=5V%vnUOS1Cr!HFXl}~PE7XbJADv^oUwv}*#Pa~KJ)OX8Ggp4HO!D#qc~V)
z=hg5@G26ORMN;o>ZQ?JkT@z{uCyIM6B99-NluK#FbdzvpzWA$T9+u!Yvd!Jc_XmGI
z9|DL%-aD{=pgKxtux!6Iv#t-Y4I_$iG14qrgMHf6mlevM5nMc6Tm_53!EfT@C(Sz>
z2+o-4N_D1&q9TRYK)7L|bRmyMin2^6$n8k6`Wv6HuJzyYL_5Z{-#t>bw0G7YDdlHK
zAqp%r8NcDIN#C|mp)mmYRnE?VHo+F;A$DRut}u~*{Xr+jBzX+;w~F&G&x~JO8WdAm
zqqoqZiFSXdV87zZbf={LUBUQuSVUNRtAk11<)2Q*r@lX*n1yOtWf4j0FvEi$-_KG(
z^S$eUiJ#Jz{x&(7$u8bO6WnQ3_9co^>Is!HAdfQ0$nzbekni2`anp07^xKGqhG?Ee
zWv)?w*)OxZ%MJ>!sxk@b@{ARwMFdw~#|*6^hA?0aWU1sHvi_tiNV8#8wq}VJedJfO
zl{<SjR0S3x9qx7@OAT(phgCay$OlzQBnzx==3h9xAZvh^+>_BX+6T$IA1hL7*iVxz
zXyF(^FX{A53HV*Uas4NN0U%Ha^SQLqd7c}8oS)~QdgM;KjL+NQ%<Z&i!LN8KK5Uj~
zhlNnC3GyUm4s4O*m%XUSeDI@%vz-^-F!JhHo7d%&h;2K-8{zDa2Jke-AuyDj-aZOC
zg+o;Fh~1n2`XptF61=(v-pfmiE@BW**?wl}sw<090rP2$mOZ!EXCHqS`?#};(sXiv
z`y;%jGWsc%(ZBIW({96TR)uYl4qtTUZpDX`q%4Y}sF{x=RJA9i$Ph)@By4PL{)VG*
zhpla+A5;uKVcPtxE*BI*)zJXm<mitG_OqWb&>=yp$?hQAkAP~|ZxVXLiSMLC)fU!n
znL!%o?NgeTVfPfSuXtqdm0!^6Y7_W>Y(0D65*NWIY9Pg0CmmyBJznD)zc~Rz08-@o
zq7SY9n;A}Q1?n8@CDx+C`StqB)DTSu9@`*&kqyln*yFx&H&V)+zJLT;-u7L9<QVJO
zlH025?!YsQKIe<oANuUDDPPM&`1MHB%O9bm`AN4RkWeTSCY?kxbe(%xN3O?zR?sSo
z>Rkm~smgPB@XIcj2#=I_p8fOvg~^4-H*$Zp#Lg!9;2r+=kdW22TAdW^;{*9OQ$J5h
zR-*^&40|~*4PZ`8Rm9{hMzGRMHd?#0YtvE$ygGhAfm-&G<c!r+e*DAcb^hQXd6Fc%
zQ9x3J7EJx#32I!8I?AHrQfcacpr7M2Nsf{$H511o@D$M!ZRU?nyIZW07$#gz&C#@R
z42`U&jCCv4N+@4P5BRVb{ywh_4N#!<tw*OW9Cyd3FG((0z{zY&d5YO4-{gKEG_dkS
z@Zi8&GhOjnZj(=l4EeBaK_2o@r~w`YJUU6tiqgP{gxCW%#6a}*vs!vVcs69*r)C=%
z+D2HOmoNul$$h+;dtZ;lC8FMHe7RL%D$rJC-LU^K+ZX~!^?9<>o+~`fcj>>$nTr%0
zVo&<gfwSa6nkxel2@{hkEE|88qWF6m`<g_@CtomCzJOWm(b74~B1ScJ26Xa7D$$Q_
zKJu1oN<qPsi^YMu;+i$n^5yTi032Tjklp@?aHC6Z`DjqWRM#+ktmh9l2VKtCCd6)~
zfb}T%S+E<b(!F2M1C(*9?c=;IA@1j<5|1Q7;HU~OW4Hy5kE@9GJKcZHUXzqX%UJu^
zLD5fJAQa@@oV5E(IKl4|)yqHqzUpD#TSf3YK6EPX8TS;37Tc?EX^On6rvMdpEiCfz
z3PlcVXndi7BPb!FT8Ud6A5UxFhne{+uR$V;u!k%yVAQij;DA0Vk6H*z8%0{jFxcYx
zQ&agd7we(sTUN6|IsO8*S+jf>1Ok5(0-y?Ws%7qa4YF5HgrPiTfQJVzmJyE_#}p2N
zTN!`$*62hSG_-l*YXaOh9`y!|pmy^9LFt=G(012<d20>M8y?RxHbd7dkru|g(b5&!
zp(+qPVY=u4s>O*)4cNT{ZXQCni8DDfS!u9)A|{SlSf($nH2-^NImPQ<3@(33<a!zc
z=;j3Q9V3e54BW9PNQE=_dMl@y2;y>ii%9_Inmj(5E~xkjt{xSW4m7(MbYNFoFDg93
z)sK#gjIYt@MM58x5nml!xvPaFm%+T<yD6ZpX6ED(=!Cs&JwNsjEC@l0w20U&jqM8n
zO19NJ%)cr$Wzp!tJ?+a=PXK>oh_7dEk7>J7we$spN<+USmO<zK`CQ{lVGiV~h(Lb^
zNoz65QI6s`J%GrAQ?K<0*E?&HhU3rVkhvSXeu06A3pS_#7(T<0UiktI$EpybPuFTq
zmj%R=>_duBWtP9G7VOJwK#1f(7GFt}v>`+Y`aNUKXj)9Y3y?To;g5gTsVhh%Gf?&D
zZju<et6X*ZxybFCC><UU2oL6Nud3HINT~M!DoGg;6OvNhXjM8n&Le+`0B<|gQU_SD
zw-OFtzSlsJ)%%VX`&Ovc(d)fA=T`oEGMBQ|>OOXE?I~xbIM_>VTRb2*!Or421U4{{
zeWLd|s?gj7sH<eIHR^u?4aw6Xo|40u2eJXICC;b)diuS*p(A{8Z`6XSyMMf(qZJYm
zMvpgl`Uz$Y53!oiXuIGl$LCi)b|ISn&*YA5`8&_A4mg0h{~o+-C=K(jByMG_Ayl>C
zP+^*2?0FTh!%P8)^}^HyPSlQ<iqxgQO@L*2WD>hC7YB%yi@bj{HNYY8qAv(6kw{bL
z2H2%h^Hnv)ix1LkjmMBEZFuNG5aHkIvF8~Var6Kf1^aQ>(op>tSfzAyj`!uZ@(!F;
zy~HVU*6~Lte<Lq;I#O#Qm4&ddhWdKlu4D&lUb@g(i;(!%Z}3>tSv-(JruG?@2Qr7E
zNw8g~g;>q7AmD%TDCC&{sUdB7*fIEJ!!t&$j>_0(KnMIMhkbnsVFaS$E;#_UiZdH(
zT4hdV@?Cf@&79kf=x=Mf25K=z$_8G5`53;P61t}k#n`8W9CV4IRP|HOjeQ_x9tpiw
z71Cek%%oGFGOdgy+6P0*siM`+T6yC_1{mFwkTn?ubtHdT6vP{QUtW#FCH3(dEKAa@
zBFa!>c{ghc>1mrk|Llksx^y>*x0>)QyWN(PkNK&WoA*s?!A2k1kP7=e?46Sb$k#dB
zW~IblSHG-W%<HT9kE_=QO%rI#+lzWlIljA7;$zNu;nj<Ltt{S+l=dM_n8hYzJXK)w
zpO{%Do#%h!VH%@@ObS_^HqvTOm$W26U5czVBBPxa;=!V>2Bf=xt|NNuzyXE?nPs6!
z<hmb9sxQAp=x}B?VI_cndl`EW)ZLPQRl8&RLpyiCSyyTfr};DzoO#ngd`c9Z&fZEu
z%bL&nE)%fsxhAipOMO-w+G{mcjF-?so3iuApR<44$QOus2Go2JSHr1pktr0U!J(_y
zULRp5X%W*tMs8MXHp8$1-Ai`QZXBCfFK@4>@To8W#B)v335IzdgsCGiwt`4_(J+i8
z;PdVnJu|&wUN;^qKYtIFePBu080?TMFm&r#{(zjVM3x5B{00Y?iVax9UMHY4tHW11
z+k$^|o-bt}zc}0#V2|FD_Qh0EvP1AbOgw9Oc~<IixP+(|^00ss&)*8iO(wFM#rp7g
z1+piZwn-7*hf-mQq$_&E!t1y6RA8C_>?{YntQ+c%`<y2FScvE5N|5vSWTV;#D^nFF
zG6MN0iej}h4Bie2R2B$b7o2S8#9mZ4Zc2Yuq#KdeGvu5$xQ!K>OP=B<`gmu5T4Le_
znYe`ZWU#unZgUHj;p#1;%XFooQ0?3BoS(JNNQD@}_oaj<CA_ir#N=KooZd@S8@ghx
z`d+DcX?M5!3g~t#mfYe=XJE6s!RI$1j9XVYb9L{z)%YO#Db8281_=Dm>1${RYcqe0
zD2I{w>wzPf^<nFn{2>vez4ghU$*$&A(yo$~1)3n9-z7``(^k?g#aZ4Em#vSU=A$au
zRRma2?X_ZkGxA5|$}~wF3-r^pb^(pI_sKCB&YLFMKP^4M+;}_)IH(^7`-g(0O2>#3
zbfbz)w!7NEeM?6&DJc6>IXy@&1!;dHlWZmhG<gtWW9z=8jLQ)N_p&OO{_c6>rN>d{
zQ_q!7e%;B+>N-J-KJR}xKR2qoc`obvLk}KoQ&~BGX)>e0u<(wjz!-WK&Xw|~PW3MU
zm88~WNPb!StA9V8gbUlkvlnb`(4z{noU2sB_3JSDb8U2%&i9@y!OUTsAI*Q$@ckr!
zXZUXb<6o)WiC{}p<DL6D)J_T6lb3$)0xEo|)z*6v1r0QQ9`;If{%mchs2#Cr#OYwC
zvMf+b)YtR3(y@%AL!&EdbxEfj8*34XwLoo2l2wWXa&97@CSG$4-7k(wuxyR=Y9lbJ
zp{MSAhqg1_W)ij3M4nGj7!!Y}z3}lVH2o?9&RDKtA;jkci~D4p5|?|Yv{5_OspeSn
z(1N!;GBj3|s4oD)+q<_+mvr#?^sOl+^S%9>)L(V-UqoR=fWT)~Mwzd>76!P@84naW
zPm-w(ee32+PQZ0jsE3()8%_Now_#g8UV<TxcPYDlJhoJCP1+<$OG<yIZxI9E^d?R_
z7SZSE)Y3dB!rV;tt^-G!B%6g%kl>U*^*-R~I{=7aeU#u^fZV4N0|ggI2ZSxOa<2kr
z`4$GbpIeVy_TPgmEj@0Nk{{f|>vm}J>kt)grFXZ(I{HMWoZVH3n-qG=hHgqOJvLV`
zczJ6ybfLt{`rKZj{cL|RKP5G|r<I=K83TB&2%G)beL+S@k&{}KXt&@^)`vL3h{9^K
zk?9P3Bm4{xTwVC))hTx9B*h9|X%BI&KS~A3^I`FLK{`aZod1Jn4nZdYQ;)b&_wFXw
zPlKjnQDDN(7mxmH1WbT)Lf3{x!UiOTT)>t=u0=fp1AcU!1Z01WwV4-O;8Y|aS(n@P
zfRJBBHR7tD%)_DJPTxJ1DQ#<xl*lDYZ&?8&(}zz8wat6Ul)IA$6~QqKN-kr#$Rm<T
z!S-TTGZ~cqn~c0gFYme#`pXJKrV7Oh7w)l=X+7_+nTep@VG=OH6~e<iM}g1&35_3o
zX3bNtxuknqrVM`*o~9_eL-ucBiXc^a+(tmd)CH4VK~kXSAc>uR>A2CD0~Zdv0VIbQ
zhK&`Iuqf&5Png*5Lp!vMx#hT^hBNI|)oRAO)|h&lD&xjt7%t0HPpQEsnPFoH3#K34
zhIJQA<ao)8^L`yljWjie70Frn!A~GeHg#a=i!{ybxkG<P2GHVODV(h~{NCCmn02{@
zwg1uZ*5qv|gmxTNV0#{IofW3y7>jOI>s=E;$2&kx<2vQ(IoNwe5Y%n^Zz-G>-5oy*
z1XcjM(Ljj1*o}>}9MHn%&}NP`D{Q|oOXON%AwZ3$?}Rb?WPgEw3^8ExJyjo#$Vm4B
zrbfhE4vc>{x?;V5O3kZ59qt9*t*Xg5$Gb2R2b@TC%d(V^kGaBxM1kby0F>!k6p{Vv
z*f~<$7CTpYhHJSFpAgH{O#zb+z$hu>F7(ih;TKJ^Yk~*yun~DEt<;aLF1LY~Hv;5n
z>|L&WWOHM6D$3r*!Bk2dfopV@i=<4K^AUzL6s&&_BQjJr&<s$FDMu+8>-U!sWmQ@#
zSYTqW13eFCJv$u6+P<&o^r0IZl-|?Em(LKN5Dk!E+{%66Ouq(G$?jpR{j8N!W285;
zMRD6&kL^K-$Kc`<jHnT2N~s~(=9+Om9cI0MiG#?4EnAr-G46j6YX6@L51#)`4l;x}
zoj899NlV!iijC@!{o0o9TG|f)?ooR`h0WIq;Bj8j=WVK3i=JqW&*a-i9&pAV6E!n8
z2QE(@K0T}KWP0nI&*IXvu5YBZshxo+aY>3)<|hH!8E@dt4p%vaUsra-F2M@LA{fAb
z8|R-KJXNMfQ=A{=Pl+4JVskNNxZ#J?S1x~G^LH5>7*`dh*u3@XJ^rY3=hqNthpq<7
zCZ%KIScg*z%XzNckwBkdk+!Ri_NqI3uU}lhxxPW5m(X$)j2_n#=N6yz91NL0L&=D&
z+38itBIgXW2=i~6ow1R^QrH)p9*x#o+S3rbY$(1%T_@UAL)Dq7rvBt<r1<_rd$fP_
z^Th&qV-@>*?-001LJrlDgQRRW2spMc=w8bOXB_%jSR;@QYL%~QrCubzq$291eNQx*
z<ug2yXLX5(kj;7cE#OMrwLj8e?gNoCgEo%6Y877JEinbX=0H~LGOZ^tV_$jkhCQx8
zj?sJ+S0<bN+DaflM<(R}wbQCl%CvvpD->8!kw2r>XO-z*E(F+~SovXEVHyku9^oL_
znpObNL(MHMzNN_3@RQeh=wf|ZcN@N90BYDK>FgUPJ?o-OMkqa}exxB(%b*|9y0>^k
zIB&d*4evc=b6R7`Xa%qxOhLg>-*t9Xsz<$EOrwCl_?8(A{$KX5pPwTJIlq5}Z;`w@
z62(;6n!xlewwtqJ#fg$4#db@-nwF93`nG$mBE%=Xf~AO#K^2RND3=T`Z6H1FQtKq_
zW=JT6Cc#@8%RCn|2WBwU(ityM-95KxGpD<-@mi5av(6`0K(dI0x7=HBz-f8K4b(9|
zV|)$5u9W=?Dm7(t#56e;Uxa_%?V7{4o<8u#)we%u?-q|m-=ICX=a=%t^pUn4S<0kr
z9K1p9OOyN}=<Cu@d=u1L)ruivzVg@0-@HghSpnW57Qq&tmUVxx@f1eqHD^IUzOtTV
z*Ak0b;#z|EH6d_0lYsk_7#0S=E;pZdr$$vQqPUS<y5aM-P6?@Q&;NhcWd`j7<xfkn
zMJ5yYMFKlHU@U4EQ{%$R)Hjj<i&_CD(<f;p?XTJ5m>Sf~&oOX1ZM>Zo17~p!I0x`!
z_d-NUT-9FY+X=8d22^=lt-vlR`AJ0#fVL8lS*>&matDo5K+cqQ2wv(V{hUNpQxtHM
zwHJ@_g?sijSz`6Qb<2MTmhi9Zf=r`TTM5W;N?gAO6(-4wsCC*#HobV%0^&Y!MR<?~
zz(ZiDQbk+156|{@%`G{-Q&>*k5F^HyAQQy8#K5Mh6%AYQQJv_?R_(hm3UUi41-J7G
z8JmrnA27tjBQ|bTEkTxbvCC7H&6Iu18Q)3aL=Cn*P=gbZ7#)8GOp~j2J^?LG_t7eO
z=<p^#MG`GUQlU_kl$M`+*v5x7kKTS*dz2Yn|K-c`=~fx(*Du+Yd=7R3?vhyqXn~^u
zJ9v2n<&F34b3O9BzWd^-e?Bwdl*?jY-xQFLiaAwA(DDBx&S8&MPWl4<uL#pLpY4}s
zyF2_Dq<!Ds_BMa*s<=JJ5GkX3edY^?F~zHz&4<$A_-dsW2`rh0Jpa$ahu((^bhBg0
z*iyM}3;^5yS5>%0O>QRN=4?#2qoBq9et}h!7&-$}z0$k#EpZB;C;`{uGj<SqrCOmK
zpcJ>=Uz6^GUd|J)SZtmyL_v#zmpD@IG&QmHf4f6ZhRJ_W_YEvs_gLsnaVfl~R!jWF
z0>&!wvVna<qws(~`4<;ac2i0)&K}`)oUNCHCMOdKY>g>=$Qk#1gC2??AS>c~j7~<H
z>uF{fnX)ryZ&|q4#2*DkgiHV5Q2*@Kjv(kwwqit6#$guAoe^RLp@B`IaIQfon>}KF
zlCQP8>Xd(a-SFx$e>9ZDk)hm?cwKlL(^;*KL#+#R895%;A4fUm(~%ncIUb4c)0;Fy
zlyT5$UU0;4P~ah=mtr;)!llF}qd;MZaKJ>4!RoW`tu;_7|Ivb)2MLSJU-iaJjDc%0
zF;8Z7)vFdinRpQmJn6tmessNXG&&iy;7YpJvRQw2lnJ@b+6|+^r>0<W6`1az^wN(Q
z%t=fL25ac_0x-~-5q<s_-IOzlzS4tw(Dm_gi=GS8so~vlgG;Ume42h-tcn36(?l(X
zS>G3HAvo24jURGM3am#;hB^__bd?$QKq?>^8BVPo=`92xmikQ;XmAJ&eZVI&@P}`K
z|8alXM}h9Fwdw+aqsFrKygFMIortio22>lH9otU!+0PR6y1O^Vk5QQRSeT1m*TjKJ
zu}}B12fD8%It03GkDQr?*j+UESwjgQpDm_p&~VhFxyMK~NqiQwAyQA`tOWilZx}1R
zs8h$%++!jCONV#;4#cNeOflos?&AprjC?^m<tsHD6EpYR`lpohUg(yguPV;>sNW<D
ze1R<kXQG#*a7jeIZi8lHEHmgbElzlKwVL!yg)PF0x@=w#Mx3;cvvh5cD-8hv006)h
z001K(1_?xwnHzs5tz;Y7b!4d+rMRc6!LRWWf6Ui?2J%7vrf;LdA51~0Cy168WNkV0
zpmJoTz+EpnI|)n(DS<*1w&Kp9Hx#nx%DiX5&Ca3H>%lP0qO+bO01el8tpXj7LyU9s
zx|<}NL%*dydy#=c=pvf(^(SMO4X}_LBK_$9Pr>iVFcW{oM~oa@M`ASG<8d0x>Xr~q
z-KF9ItIW~(jOO5x5>JZC4oS%Qg`>7@inK;bZTLJ$&5I}iaUr(GYyZolfjD-qxXMm?
zVXkORiwg{-*@A1=4S!MvG4qxA^7EE3*<7ZNE;f?oYmjM(qIGPGyt}HlFt+2h%&p!V
z(k<@zmG}a<ce8vK1Ok6V5fBRH0=^n-CeKqHO?U1?qM9Y-(COXiPG{8PC4>T1PR$5)
zDJ(<2f#=$hjc5@FIwED&XXxhb^=y}j-re=2qVA0tqI@*N4_BSa0Ov6PZ$74R8vRUm
z*C0g&7EJK|wxAT))CXJ==-KH;scB`aSSStII3Ad@YIajf(UyM=ed%%yW=IZ&!iFAp
zc~V~fcZ!(4y~*<ydslyA=^%yJhOs8O35Agy8GlN!1hZ17vVqzXj3IOjeraPX#QM6(
z+x?@<mpiLnRf$--VRphc=Ui;T`s<uoY$TlYY8_--TG+vqV~uwTz^c*Tur`_oh$L$F
z8ubm=NmBPQzu<o%#?x^XR;||nJvU|obw63XBgHI?ikN-I2p;BUrhnR_ZH*-}QLj&g
zPdoe8nEsx_p~_$5oJ*EAPi%qcv5YmcP;fIgdG-Hi6|kmR82$=~BLq;kTkeMB<D7#*
z>m%o*Ls`nNW?_heZM%@ncIIzJxdt0Rd)+JS%Cda+tEPWhiwN*(RW0_lN8=68e@4#>
zM@~Wpeux0@Hqkk!vHw#6+&v9y`de;WW-lC-1AR^MvQi-(@w$)c7CZ-|-PUKv*e_@Z
z3q@B|J~HdGK+Jo3!qL>}{t)Ee(XBD1YNxM(W^Fo#Zd?kus6U_hKa8>T^$trjmSJy>
zvnN|Xc=dl#YLBH<BhcnEGw&VHP3*BtL!M0K%P*}Qf1w}B?;pjhu?H|{PJzsfP6>MT
zyf%)jb#!=y4qAut%<wO^NT-bd8T8sc(FCV5B;?O6&yQ4J82pF;gM$ic1V1P$$RlPq
zy&taj%3rAho}{Mm{}mBbkIO@LH=3=V6eTB#<=}tSKK&nDp85SD<^%ZhaQXnhvC0H6
zyQ6Expeox)z-=zH@NZ_7?z)%-N3o{aYWp6OwfJmL$)nKXel@xFwf=bb65H()=ESDU
z58Kn;77xbffLt#nLhYXRn2`ZAb)|*akc`B)--CgK8@ypuse(3@1)K4PW!0RQ1*>Wx
zM-YFM|88>LaH6-V%nTk$FgY2*Y>9>mFr8q%h{o}2N{B#5H;eZjC+v-?BBR7+owDAU
z*N~auYD_LnyhZyw7~C-cv=1G_H9kf??48C(0zR1@>eDGUrclpf+5Pu_YcZRFcxfMX
zcA%SeZtagxtYuN6aj%j_cYo*8V6`d_(6oPOVKBav696-tZ$_1I3Yl57eFTxj=<=25
zI^G;-`0c?P#DgL7!D2v<Gahz*ayd6EW{`v#rBfl+TU2kVmGN_somrSa;da;LCYgeW
z5hwdL51)HGt*1c25hYVVkD)*{&D8w4JA0?CXmufDf5g}RFZ<r6`N*1A`P4}@Jpq4=
zlhJ=KCRDffJI9XDr;x6$8Rwo+h#hw2q_ps>Zlho?JuIpcU$nBdY225xo5P}$GlL#M
zWSeKe{Fcfv3JxIb<)-SWkXFT43&5X<HRuRsBP8Gjd}$}KKT5wF1!R)?^ml4L)~g+p
zi93!T@?r;dHOc<NCuxqfKsTFk8a{u-a*)MeV)KRrtA<P2Y@uqFniUh+174qTR9c51
zhf{1MWyWqT$9W7-UDrxj;1F{>^vU*2GLnGAvO3(_YJ?ji=1k&)=~6-_^RsT90Lm_`
zR{8s*#y@&m0vpoX!m3-v(c$pu)>8e}F8~7Dh;AJ9YPF6Uhu@JvT&9s82QYt(<l=P4
zZ416=^M>yVtU64I8t{HU4@fPd-wRteC~U&Imn6Y5U1Rg4GNcz@xE9?ig>l<;1xqjr
zMwN$eoWM_sxucPM?lCRKsDIl{#_=+>`AkC@8raQTa2d^uyMFX|B|?+R@;~GX7lmee
zjw4WAhLvE5Xy<j}rX{-_YPNr6YiV<(-7x>w<+8;msn@u06#|IrDWLtH9SgN5u9pV7
z;<`ag$Eu|hoN329-1YuY@v+qIb^0g;W}tX8ra~MKMOV<*o34{aUJk>F^X;w2IwMR-
zFyHVkWm7?!)CA+qUmaWvk)Cxdd@N0qwbSvu3~cnA&W6#alX_3O3psy#lvjKU|1E$Z
zih<Kib}>;}j?(Y>?!UuOB6D0ACT0A0pQKPrhct<o1ulxzi|#F&V3z%y8JWcFVXGJ`
z6lPnfnF25#vctgz3pNMZ(>$^a>8<oX3TIHHBVi5tDda?h9aNzEVYXk><W1(*OdO^8
zREm)6CcSnV@`}=2=T(11wme$H8xV6J>Sm{$nPi~XdL%ph>i(DS!~_$|kAbqgV%uT;
zC@MAg%l0<JJgTi)g@Ch-k;)`H`{Tm6(nOG^S9nVD#5<3{FZhh1I^CbDQXO35`1^Np
zn35`jeuY}?9xc2k6svf$!sJA*CIu!U<)jL_Bk$m;fXd<GxPX7djDY@?(Qx83G_T!{
zupqP+TPuc8zb3Q$Q{x(7hYERn+p0`~4W4WRGI)&^iPJm8pf#F%46dTvoI|HhmGtyJ
zuD%&F77T>=NxjZb58qzD+Y1*@?%G&POgFJMIdO^=1qe}!zw6!(jJ~pAuPPT14WfT8
zJaqX0=l)8o1%Q8k-V6U9VtGVW_x<XdxF`gtM<@rq)vV#O89!5^22<%uYOoUE$n}y4
zp^cj26ItIkLL>Xdp&DvqvfJ7l;bn@}NMYEN#6d60hpG55P;jd18O*?!FaU+~Wt-dQ
z3MZ)iKRiZ149sAzP9Xl{GF)z@Z4sp8UM>jNMw<O~595Cr^v$!1`6iIaqF8W}Cv`>6
zAdvx?IN|0&zVRYOyPaO33}M%|Xw@78lGsu*CA4+cu%M}p;O%EBD+!9t$>WE|sm@r@
z`CQbF{Cb_)+MY(&Vbx?v0fP2MGHtMsC(*h>pASstDoi*{046WtaO#D4612^d2kZSo
zs}r@&t|@=t$A_%-YuJS4%uPf2vNT~5(4}nx6&PToHHw^8WaBrU2I!$t$y>>s6-h$f
z{Pdv(oa}Ob)tmx{VhMEa+5DNaQR^~`AC?}XQ4)am+xUQxT(Z2%X&~H)AWww3IlnWV
zOI6<0F<!~{+|#VRs(JVe%@z6t$X=Jx7;8e3P0N4IOgtE%uak5S<89C=k(%<CGohh0
zhOD)tJ4aHuno&2R#h)ZylHv+eM`C!bTMQPa9hijmQZ&1CiAL^mr%>VKK6Z5mvQZ<l
z$1)K(tntaE_F>>`gQaC$!#`>L;b<6-dRny5|43I&59`NFfX%n&(0t#JUK3(SJbr7<
z3ITtDz*j=vLBmK3(`pPiX9&1vZm6Gr4sHAEdIzB{a2>6)(jov6wD|t1fwKcz$?QJD
zB+|zM_=U2pYrOIZdx@(Vnex_RWSuxv;R1WLjc<3?4fd4c4hMY(f{(pn7?;aTg&6OR
zc@rE&#(qu%8<x7IlC}DQ@(`d`1iJ8%qcwkotPX|f4y7aupfL$p=3YRa<WerZ(+eP>
zRo)*5v3+3Sc`q#m^GX+;0XgQ{@@~moomVs4+sWlPFBwE<jGELDA3E3cJRC|}Q~JD9
zUgP>6U!7D<7y5njv;ajWM740AGrM$t_JI>fU(G=@nDIM?;=#U_dNw4-Fq3d$o34Mt
zo^OdQIz~PGO~5ZnBdWp!HlV;{%fgJ(d}G7Ieh6^=&ko1x3`Pu$On~hI75`yiPm?IH
z$4^=L1@>jNh>FAS26U;&RAwbC22Oa-xSVO4@ew+J;WN`*L1emOgnn3lZ2xaiL5<0d
zlNOB^%!pjbFe_87@zD|?iFX$3kzapVZ((4Gl$R#S4_YvBPcqrqzT}{=2zmwa2M5Ti
znO!^Eo%((z`&w5Y3=XzR^5anZa+EKQjx@g?>Jv-z#wKPK3Mfxg=hfcwK?8A>{eLAO
zBKvCAU!7Z5%JHt&;s*&kds6w??mgZDQMsZf_u5NT)r|pRy&iiP0gIwutDS$j^!H09
zXW-}im+xUC=}TifDJC3WdJu%F%_<5)?K+Zf8^%ukUN2A6fscclcALEfs0Xw6zY`Fn
z@3-6`5ioxwT>hhpR|U;|L@TQb>rEk!VGjA6JbeDn3!c)2qPfQBgleDO{fzQ9x0b&+
z5jJ`CoP>a7RG4!<U%|rA8XkYj4+(A+JMrryY+-jM)pFu5^ZeCc7Re_s<w#eDJr2NB
zEJ|rC*w-M>e^~Mro6R9Ht=qP7&QAV;fU`pVpuRyq?PyoSr~UQevLWwZRoY6YTG)%E
zoy%C={BI((VXE}1eF{haJ$qEN7en7@;at^7#PiIk3;sWvuuNeCbM}9uWLduHPrv~0
zn2-F+I^G5{d=4>;_PB%O6&^Yba7?vAa?|eo^$q7yKe~OM6zBASHCv)w_riD`NMU+q
zoAt+#_6oWe5cwQ_P-g#_x39}{!PeofBSj5~+%L*%LGYzgM_-V8h2C4~71(qwsO9FE
zmhW=RBip77OXh`SOt^mp;L;m&36s^sD(5gDZGNSfg^E*pZ|8sa{t7@DZUAPMYT36I
z`|NWTcCcXSCnn$FX!7HFLgEgyrMI!MKxl|I%OM9?{Hk{TvZB|yQqXOsIt>)Xt(r^V
zU?$C&^p=3{O=a1Dt2Z|9rRPZ@k3jnADd~K?$BQ)rt7khL7zcm4^4PPemXd-LdZ%%s
z%=n<%an#6Uh_sIEMyr;Py^ICj?f~TXMMkV?!+DhS=L%AbX&%k^b9v?_V@ELR(@KVE
znR_6ObiI_fn;gLrD)r8gWnvLd19k;&HuX+i{YJQ^H=>5byEZXt8$7b)+BhIB%FPDJ
z_dVAkA2z1!?W%v5YCeJ{EFks3tPLaS$=I)VT-c&Hksi!8Uu%z!qnTH5zL2?$e!RDm
zvnN+#_34148?SQhkDZbcO|Fr6$RCDeyDa4OF({RrPDFi?l{cw+yUxlf7GO*TNB%hf
zSic^mVp~;+XBo2$tuhX5xRKv0>CquuezuR~Kbn}Z<{W=RQS-Na^zQDGR%5&dcgRcc
zJJ|76!-w6WJ;H0IgMP?8*`uO!U2CGN#|3rqC9_7p&dbDVZ*SA6i;ie}Fo~&OJbH*e
zA_c}x)D;Ce=I%$F6o&Cajx>!s(bFP^XmpD;4$<eEEi#qf@^kjjOj*Cx`Tq4m-2RM(
zz-K&{hU$OH*b|8+A!@4O4QRSIKxOA|mG8BI<&)rvZZKK^s6@BZm!UCe?azh7Hj*Pz
zhK9eGBlVd}u1xDA$>uOXM1$ra-0E^e9YOH-8po1)q4lN#SaqNnYrU{Z7o>G&bmRt3
zL|lQI&e=Q=FTJ6sX@MLJE|%1@+v0&(l$VzA{Pln51tko&X8u>A|6*K7tL2~#-%?{a
zkrs*bptlp`28R8)BEk@TNtv^!HvRWBX6s~=ulK=otMM{BgqO0YG83xFrZX`O;t^5+
zPtJ{|Uotl{c*+W~*bQ<FA#bey+)QhZ{HGFJmal{qU*+2ZGZE^dSe$>Zq%dA%CdmAk
zy|{muRg(y!Ht{wV6+L@O56f5;QZKSr=_^BC21-CF^vM#bIwPAsTWNu>sSep2l@VH*
zZl}Xbsiho`15?mxf3m^{%qSPzo3)d9ie(2PoO!q&0C!~j5T?Vazid)#m+OgWaT(Hw
zFrS4Vv!^^q>z_<5kbM!4cFrzD10P%C0Th37EJRnxnvlCy7_~U1c#2Bp*)*$N6ZQ<i
z(`FFWcQqOAj5&}F+`_3uMU0xU1Ch}rIk)JwvP|#>if;b|YLO)(i;$|>BjI0DaJuK_
z1r!7sY{e_@u_?zS&@pGi#taWAe{I@Mv8ZF+YHp|M=C%mjr>TtJ?8^izXt~N^COLnB
zL(n9&DlSj#x}cnU*YElE|5ZJo%^`Hi)RR1fTE=01`>JnX)WJQwZb$Sg;+sy{&xFgd
zj;(y0hurd*MjwPpwD6?Q0Y_4i{$b~W2~(0PoJ_514m4^g!sYs9FM=2(N}(4N1KU=8
z67AE>za7f0Jb{d(4<%aoAD^Chgb;rMFO%8hvBI;wmi+VICL7RO>ZV1RX{ME2PfzPh
z(X)&(72iJ{Sxc+4UON0O=ZLYrZV`4Thbz2WEkjMM$0zay^7!mcc%H#NgI5*dTJ*lX
z0RFo?Fpyg;W#>|sl|W@fv#qmyS#W1MIqYh?Gb!>#v|WB?QP6QTIBr&`U><)E*cLZ*
z3&XD?#%#efnPdrPZ6FDAyS%h$hGD#&M4@kWV^AJJwY}ArQhuU|KER@a+N4y&x(+g~
z#zH9*WmFsi!93@+1Ke8*@sQ2Aui&yt9o)|^{Pr?ST@q-wm+zJ;qT9<8T=0brCzLCT
zSu^*KNMxQYo%Cd!zk660=F34(P9Zmm-3ZFPGIS(H6nk0@u19@g-hg5X8+m3Sd<bsO
j{ey1F+*n!s`~Q7>8rF0d{KLdujTNXTN(VRmv@xaSpH_*2

delta 15323
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

diff --git a/amd-ucode/microcode_amd_fam19h.bin.asc b/amd-ucode/microcode_amd_fam19h.bin.asc
index 8cff9013..3955e529 100644
--- a/amd-ucode/microcode_amd_fam19h.bin.asc
+++ b/amd-ucode/microcode_amd_fam19h.bin.asc
@@ -1,11 +1,11 @@
 -----BEGIN PGP SIGNATURE-----
 
-iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmTEYrcACgkQ5L5TOfMo
-rnN4IQf/QKbOezXZ4OYzaPANvsZQEAzLNfuylC/aQMwrPaO7daz5/zmCN4HU5XkH
-dDT8DYfPg+fQHIgxAw0/L24xPOm5Op/QuLVDyDqVr4qvL8+65eeI+JqxD/wXMXYN
-V34kkLM2p8iuyY1Nc8IDLXu4X75KGNPbKZlMRKMU3Pr7ai5O4ihmiAM+N6qv1KEJ
-YToNN6vrg0qt1cv0SLM8sa4e7L1+oblUrg/o0FViYE8pxsU3ZRRVSJMUg+lKjvl/
-1ZPGKOdD80fcNJ+ItYGHNNs3eCc3WgW7Kc/E668eH75Yu9Zt7ewWZX8Sg/mygleY
-OzMwhbPJg4bF4zm7C/Pku7i1T2Omcg==
-=km2X
+iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmUoW6AACgkQ5L5TOfMo
+rnMHAAf/SxaKEu5l7FGXR+QJYc2oSJDpf9ZsHTkVnxqF1I3ReItEGAR3iqSWrsRw
+KA4niP9Ihr8EqwhOaOtqkRKKF9D5yg+DksnRWbh2VTUECO4KQxjHNrPp3JWEzBwb
+Xn+vRVP02ZRi3u4MCYbnDC4AfUSnKnldY3TTlNi/6HUaGS2pcw8Vjli/C06zwfgh
+WwUAoFMQl4SDJhbGfC9cb93MKjBl/0Hv4uhK5W8fJ1iUkMvY8Ijna/oDTZCNPqP0
+0AgOwdAdzoyOYWjbUXcwofz2Umpz12xmJW8yXNwdv1pmaCvv9aCJz1L49lGwFH9E
+lhhoFQ1SQL3hhPjTXO6DbeeT9+fjOg==
+=9Xav
 -----END PGP SIGNATURE-----
-- 
2.25.1

