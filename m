Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5C6791654
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352828AbjIDLmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352825AbjIDLmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:42:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2128.outbound.protection.outlook.com [40.107.93.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF961AB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 04:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNF7NVqDvD4ZtHqdqvKNi27a6xmr1giK+KGpRQeTa6+SBQi41PaMnQUEZoqN7nsQSRdODrkQGvM3d4pJWtEYxCEC9I3mvpj7UWXpNmVFK18tyP95wlC4GqrX7pj/O/uVGxcyp782ykvk7OZcG7II8oosVVfYq4kCgA7NUphst13zCOBixLPZLX0nlHpmp3zgbjsooPP4id+8Qvu9B6HHcJ53wInmKPX5yL+wPOfJBbm6MlU+TQ83VlC0jlBWgecEUMTr5MO1Cm3hWEOyaCkauNGrGNKvJLnh2k+uMty8YbbaYoCAvAqAcvZMc5iluAxSGvbhyfiHo/suXXsF8ZebzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAWHa3Rzkfi0jSRL4txY+3k0+qOfPGWEp0Mmjerpemg=;
 b=lxzyYniWbBCBUi4HHvhC0GZuNED6d5tr6hkHyk8qDlVZ7Y+kFb8wan0MII/hJMeqejfTDS4aFQHM/yZu+c4FS1W1CVLV2SKEmw3jt7ZPEyH6zFOIBhlbyU0uFfpO+bBj7e1hBeIN+qBzq800/GxOvHTY5RFvOuZBpzQGYbirnoD8p0B+WF1cjy9fuRBvoDPgx63ZCx6PDqPjCHh1d00lX5RUYWb+FxFhzce0X04UAZjYxlE5RPHT9ill6XYlxFz9GLg7olmspE4sHSrbdvU5XrUZwfBySqAdU0PsvNKoXxyIMcak8e3BUkzjGunBgIdY/H2PENrAwfI3l1/UbFfP6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAWHa3Rzkfi0jSRL4txY+3k0+qOfPGWEp0Mmjerpemg=;
 b=qrU9ShS2pwbn84D+tRkOjSQafbIdheyqf4s2/PmC8t1oS2/8SWEK31nTrXlGY6NR/JnKPMpDKxfcKhRe9+IedjkkQFLujXL5jfPF6GzPxCahuBz3MiljN5kKGgoxaNYJOzjFnZbxzf6HZqr4sKRlXTG15HG4GGyPJFQ22ybUjVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SJ2PR01MB8008.prod.exchangelabs.com (2603:10b6:a03:4cb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.30; Mon, 4 Sep 2023 11:42:43 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::460c:bded:60ff:3254]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::460c:bded:60ff:3254%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 11:42:42 +0000
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To:     linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org
Cc:     Christoffer.Dall@arm.com, eauger@redhat.com,
        miguel.luis@oracle.com, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com, gankulkarni@os.amperecomputing.com
Subject: [PATCH v2 0/2] Avoid spurious ptimer interrupts for non-zero cntpoff
Date:   Mon,  4 Sep 2023 04:42:16 -0700
Message-Id: <20230904114218.590304-1-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:610:50::34) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SJ2PR01MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 1423fa02-af62-4153-7d20-08dbad3c0c74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9qI2L1+SoqSVQl2DpHwV93d6w7vYxN+0xiwCcaVSJzbgGkk4gETPRv9B4VBvvcqz6elOO4m4It8u7qsk5OhRYbCk9A1Egcm14xBca2qC5bPHaJD+hyz+envLVqrhghNLmrRXMrJU+/3lsMZZ3S/D+BrWNK4iYlp8RsOFWrGpz7dO4c3sJ3pc/Pe5FYC95w4Uc1+kKNWNaASfQLGqALxBFC16MBLNgeHCXeMFF79PtkNmKDM1V/sFOoiwsxkNidrgGhpvB1qwT83fcslgPRe/PaRJ6cfnjx7rxCvHaYspOdfyuLdNt2FpLtg7okqvFsHsmgeXlXyXOWOW0UI8YxCStuaoH9JSbvbdFeIyellHLgqqXh0LjLbCDjY2ITzprbqQ2kueYad1MV6LIDHGqS7bkzKlAMJF59knSUhtP4+URX8Kp7BeK2JliLl6E3avIUzCRqLdAvrKITm88Uxb+V9RLBbvUgMcF8lds8s86ZAoUPGosWQXq7N/phUErhhsQac9Rs3YSpWWpD2cQ9Bb0CSKJKrSN99KqO372gDVCv6WSHX2fSbRQDN6ck9XAgDwGgwGBsO5SBJY58TOCY3fqq1oXo8IU+4wreh+xiNKq1jvUwCP9YgjanyqKHtzdquVXR+JgwTy3Fl3uCcQQLi01kk4yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39850400004)(396003)(451199024)(186009)(1800799009)(38100700002)(38350700002)(41300700001)(5660300002)(86362001)(83380400001)(66476007)(66556008)(66946007)(26005)(1076003)(107886003)(2616005)(478600001)(6666004)(966005)(8676002)(4326008)(316002)(8936002)(6512007)(52116002)(6486002)(2906002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OYzWxSy0Afh/1qqnEujkCNjNlQqLPbe8Lr/nCkTvIEgJ+FgW7CIUtM7UQl7w?=
 =?us-ascii?Q?vxZEvClpnCjZ4UYsElHWuDVtq1zWT+KbPs0fLUqASxReBp39PSE1EOrfD1Ro?=
 =?us-ascii?Q?MIl9v8rcFZ+h1sW4n74tHDEIUqyFzY5taAdgoBKtQyAK3jD4rIOs49UGVtn/?=
 =?us-ascii?Q?YAe1MctyHmAIMVd5Te+xyVRtj6LP8vRe1d44cXeKkc3LHDpfUOjVXb0Wm15n?=
 =?us-ascii?Q?XOHoy9YvFx3n6EiJIYSQT990GZbm6qYPjz07ZepTB8qLT84mCdde2i02clJ/?=
 =?us-ascii?Q?4otkt5/dQMK3XMHDP358nH1qjyvq601Zo1P6mLUmFPnW4Mhsl0C6u6MTX/r0?=
 =?us-ascii?Q?2CbQBvsyCwBf6e/xBKOwiTlJcf2JGG3blvg7caSh7vzT9SPhkR7fKZIpSobv?=
 =?us-ascii?Q?0X6FOVHj8WOUUeDN+KPnMRXyoiBw5o7gcZSiGsG7TzVqljlp4MRtW4+llU6v?=
 =?us-ascii?Q?dOBrSgGMVseq2ehZ39QFsY1a6Q5TypqohjkdIr/KgQS9efxoI7TtH5wPkNh3?=
 =?us-ascii?Q?ghWQna2/CtX0KUCd5Pf5rmtIFjHq+IZ2Q/cI+0lyQv9gsAlW2wqT6p3e/kU9?=
 =?us-ascii?Q?zTdf5tL0qxVP79M2yZ+9IwiVgLBCXptZabkXHouGNRnd3HOPnvncq67OESV/?=
 =?us-ascii?Q?zV1HuUvpf8ORl2Arli8eYRw03g1ooSTUgEK6a+lUPHVmtv+tJquJVm6mdXke?=
 =?us-ascii?Q?cpXAwXjcDsjQj4ebkN5i7aC3Ff3qjNgNWNEB1aICzycwo0/pa1oACA/fKa0q?=
 =?us-ascii?Q?nxDz0OWRlofoRts7hknJF2t42dT6jGJJRBbMVWo81d+Gud5dFGoyqtoi6hBb?=
 =?us-ascii?Q?Oo9mSaVOBRiq5P4gMzr/n7ApNOVUoblHywZOoQjp5EE/dAYW6QLLI51S6kwD?=
 =?us-ascii?Q?OTuw7Ha1yLgYy+4kSUKZL5l0HpkhxaFlbEi+9xU+hAUchk/zEtZp4L/WzEPt?=
 =?us-ascii?Q?FWLxdvtALi+qEV+pG1G9Zq4o6gEXraPmOuuJqe0wFSOd3VEa3pcKYITrtzHK?=
 =?us-ascii?Q?GfazxCHcps+E6HUCU4dBmLpq5UrxZByWlSvTqWH5yAWrSk2U2yH8SKq8Sbnx?=
 =?us-ascii?Q?8roy9gYur6GFtmHdKHAlMHEOSDE/zrI7+9hjBT54eJMa3WDJZGonyTCQze6O?=
 =?us-ascii?Q?vm4gzrriygFRlI+QAnmQn2kMHe5wunzqN0MkIUExwQsAHulPxMUl6OIU82O5?=
 =?us-ascii?Q?MCQDodwytYcNo/B5LCHL+JvigbI66CiJ+EgBWzGh3jR3Q6boOSv06IwC0tl6?=
 =?us-ascii?Q?+I6GtQ36jiVJbVppIt1UohgHw+upzbW7xTPp03+5DC8YDUDACwKwwFco9tBS?=
 =?us-ascii?Q?I3o9e6S6iBituOxT7X2xtj3ZJnW76pA2Sh3v1PfJ69t9tkmFq4pf6URC2+WJ?=
 =?us-ascii?Q?rOdVr+ecVHIxTLBnvs842cyyJg/lRc4HLZVTtgCimTYQ4ni1FtjpFRJ+cmJ1?=
 =?us-ascii?Q?Zhh+hJUw4G4jjk5Vla4LECpkGWud7KN9a9GPZb+BvX7b6gNqtKiI2Au9G9mq?=
 =?us-ascii?Q?wvSL/bRZTSrMsI9dFaSxKetrMxRGin34VjNC6f0vGrdOKNtCtFAgpIFdUq1b?=
 =?us-ascii?Q?7IGTDOArJBOKXFzhCyv3AtcXnxxnrP7XBi8DPxF4TqknkKcOO/K3haAANt40?=
 =?us-ascii?Q?q7UPpRqU9aiYvlECrfVjkRRbA/gR5Ysc6pbcKGLwndps?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1423fa02-af62-4153-7d20-08dbad3c0c74
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 11:42:42.4810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vx6o4VpzQDXGdWhTCjrYE2uz8i9AvkhSKQONrdIFhRObXF7HeHcVP13uqa+mgGwuLmzblSV6p2R6tVp3hjP7FZpeXDjdcG80NAF8LWt09hdosnvnHWN7cs1WTbpHC3wC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guest-Hypervisor(NV use-case) uses ptimer as an arch_timer.
While running Guest-Hypervisor from a VHE host on a platform which
supports FEAT_ECV/CNTPOFF_EL2, burst of spurious ptimer interrupts
were generated for a non-zero offset, causing the boot to hang.

The issue is due to the value of CNTPOFF_EL2 is treated as zero while
on VHE host. This patch fixes the issue by adjusting the CVAL of a
loaded ptimer across the entry and exit of a guest.

v2:
     Updated as per review comment [1].
[1] https://lore.kernel.org/lkml/a4dac5af-44e2-0485-446f-fae09fa66a3c@os.amperecomputing.com/


This patchset is rebased on NV-V10[2][3].

[2] https://lore.kernel.org/linux-arm-kernel/19c775ad-9573-b4d4-886d-c631b468856f@redhat.com/T/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/nv-6.5-WIP-6.4

Ganapatrao Kulkarni (2):
  KVM: arm64: timers: Move helper has_cntpoff to a header file
  KVM: arm64: timers: Adjust CVAL of a ptimer across guest entry and
    exits

 arch/arm64/include/asm/virt.h   |  5 +++
 arch/arm64/kvm/arch_timer.c     | 65 ++++++++++++++++++++++++++++-----
 arch/arm64/kvm/hyp/vhe/switch.c | 13 +++++++
 include/kvm/arm_arch_timer.h    |  1 +
 4 files changed, 74 insertions(+), 10 deletions(-)

-- 
2.41.0

