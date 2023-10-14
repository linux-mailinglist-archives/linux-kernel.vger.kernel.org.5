Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E899A7CC8D8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343794AbjJQQ3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbjJQQ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:29:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2096.outbound.protection.outlook.com [40.107.93.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EB5FE;
        Tue, 17 Oct 2023 09:29:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtEn/5MDLK5pvj21Ysq3xL5ewfHUJxuPBmDphX2iy8jDCXZ72b0IyJEWnyzqtGRQoXO7MOJ9jrtbWLzno8PBjcskWwl4wHooEPW2S8ZOSAZKGhaYWkKJG6b/2EamIrphvXrBPV0K+8/I2JFMdO3RHEz54Nv6Ct1op9n07lDaSLl+2343jydcMgeNm+E0K2DK11tlXOpHBPFMzQVYPv4VIfGIvC8oPgaUem59GM8CVVteHLiqs6Jm+/mj16wFZXTKLSZYp1M/umpBmfeJFf6rs97F2mxmOYA2bYbTwAgsW4eVXBq0OR7KyJpibjdrjQVZ2o5vIABn+MMdKm7cnHgnCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjSvNPWYHym5yElBt/JtE2RYOAUx7H1HOOCu+q8apq4=;
 b=ePA6EZWoaXzlAtsOUZl/U64E4O0qiiDE0M36Nm8a2wGgsXGevRXEOsgDYdwDzmwwR+MkNkY54n0IGa2LlvfAf1Rg1QLCQ6M3AR9z5b61TAgwXqHd1zZxhg60iZgnReLp6XLHPbYvjC4DuhVhACLM8xaYpc8sZGmatjoTvLR+B5s3RQSIEgyKl5iQj2tHlMV1sssUfWjEZJNBNu9OGjQCKj6n+bw4V346PRWSmlOoaD5rmaIEZkCuz16UcPnJIuHxmMNEEOb9Wer2kVJjqfK6r3CfsMgGgD6oHtu2BQh4MVGcNMNtE/24yX10IGe4z5CqIkCdggtKu1s7yiS8FgiFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjSvNPWYHym5yElBt/JtE2RYOAUx7H1HOOCu+q8apq4=;
 b=RA6aITxGtMUL6tpGwiGvl6DNeagSERliUOUpNwR1Ddq0Kfezj33OGlEyOS9+eEijAhZYt0NZFeawvb6OoHQoJlP3SwRd4HL+hf40owugJ0CVJwwp7KhddsJP5xEkJvzoJ6DxdvxBfmQoeQSIbAE74t+Z66o2rn3XLvp41atWobo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8007.prod.exchangelabs.com (2603:10b6:a03:4c4::21) by
 BL3PR01MB7212.prod.exchangelabs.com (2603:10b6:208:347::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21; Tue, 17 Oct 2023 16:29:34 +0000
Received: from SJ2PR01MB8007.prod.exchangelabs.com
 ([fe80::9dd8:9d28:4e63:28e2]) by SJ2PR01MB8007.prod.exchangelabs.com
 ([fe80::9dd8:9d28:4e63:28e2%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 16:29:33 +0000
Date:   Sat, 14 Oct 2023 02:12:29 -0700
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] sbsa_gwdt: Calculate timeout with 64-bit math
Message-ID: <ZSpbfXzFeaoUJRZ3@Fedora>
References: <7d1713c5ffab19b0f3de796d82df19e8b1f340de.1695286124.git.darren@os.amperecomputing.com>
 <bcc41311-075c-44fe-b0f7-30564d7ac58c@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcc41311-075c-44fe-b0f7-30564d7ac58c@roeck-us.net>
X-ClientProxiedBy: CH5PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::10) To SJ2PR01MB8007.prod.exchangelabs.com
 (2603:10b6:a03:4c4::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8007:EE_|BL3PR01MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d92c352-64d2-4029-758b-08dbcf2e3ebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPPPbETphkLBenksXYG1BtTR7VaNoMA3xkXsh3Xq5SsfKsEnXwKZTQbzQyiKMNTuIHCUpt9T1CqaoPWItyjhww2fpfMGPt0if8msbjS4DpnafY9VyovdGW746f18tgYWqi8PSufJRGn9ZyUdSrmBOOSDN1jYBIDsxvtiSWqLKmC99XvKyQ2D8pt2SJKIpGVlR30a3PMxgDXoBXpHId3QLQzqdf756hP20/3bGxvubV2fEvplUcsh/EMvYydYyZlO89Vyhpfpr3Zir3NyvXwWs9dDJtnz7JVaNYNr5yNk+aKgJpTD7ugk+qzg2e/X1kyZdUl1W4EC0selQFJGwvISg6L54nO+IthpGoE0WYmiRbv87ri2ODeTsaKwig9Pz4LDfiwinTLX4vW2Im9buzkDW0i0eY9V3QWWya+/BdEEptN74ykNJRvKiqpi0vBlNQ+v0Sf9A6yYFT1d+6ivqlfLcIobmtdmpa8s23OWRfgKGeLuojRDiXZMwTVq3NwMa043ywD7KPxeOzxAFhaswg+P6MAko9CB1sBFTaj5rF6/ZwrUppFlbjAiK67/xGqKqYhpfieEMO7IZ/rTKJpQuBBX0LOelJLr5TZbT6acJqR1Cy8hrt7m+b8Fkf5alw/JjT9z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8007.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(346002)(376002)(366004)(39850400004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(26005)(6666004)(6506007)(8936002)(6512007)(9686003)(52116002)(83380400001)(4326008)(41300700001)(8676002)(5660300002)(2906002)(33716001)(6486002)(478600001)(66946007)(66556008)(316002)(6916009)(54906003)(66476007)(38100700002)(86362001)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sc8KgtfuVhGSIk7A6e3+xkbZEnb6Qyyq2fo98yFGTH51XxVhXI5eIzTfYv8R?=
 =?us-ascii?Q?rakNhvkxl1kPdB2Gg/bVt/k4GPDosXhg9Olt4giqbe3jbTr6obizKrpWNrTi?=
 =?us-ascii?Q?Wzjyv7/QDQ/TyWzrp2VDWAOk25c7k/el7OdwJfymZ1hgUtliVWk9JlyllJJo?=
 =?us-ascii?Q?HttToX49DjdvyXwvajjv0lN5ziNJhJ+NMJs0XXNddGqUbPA3V+Oymp3uSM+Q?=
 =?us-ascii?Q?fR5jVrxjtnQjRiGjTOf7YHghHekgU+DsGVwzY4xvHwwCNY5Kpm12UfAVU2cW?=
 =?us-ascii?Q?KB79Hds5+7689VrLjky1ojO7thlA074uIUpe8bmBWfEyagZ8SS24ugY36gyh?=
 =?us-ascii?Q?pBHdmPRuoc2j8HlO3cCwCN1JpvuvH23KmlzShw6ZDocfvtjo4Ji0KE7TLxRs?=
 =?us-ascii?Q?y30QON7cJT2exBXADVUdjGu0TcWKt0sIkECeNiaxRaJdcWB3qt0dWZk04E59?=
 =?us-ascii?Q?OPH3ab/K80WmdW4Ze8EeWo+uayQfJp7o35vatvE4ShUss8bm/5Xm6DH4MuTo?=
 =?us-ascii?Q?WT/2fw2PkI/9X8HZldVBFVR+W5bVu+g2dzgVn/R/7BbwCPzU33EDDtJd1Mys?=
 =?us-ascii?Q?oTCyT6dZbN2d9vLMgP19IUtCUVpX/uoMyBCQj5RThmOneBKjg+uXCL96K5nF?=
 =?us-ascii?Q?vNR69KZa0QzepUQ9mTmspeyghW0IoD2aJYGXn78ZOfzswr5nVHT5hziFkRKg?=
 =?us-ascii?Q?GylN6r5En9fvZv8LkWIhOMNk8z6ozVdMncD0uRosHAgGPVQ9Ssi3FfD1QzBj?=
 =?us-ascii?Q?oE9iuA47UGfH2EMsXXVqSTbhdpi/7QvkMKGJXCRxnVbXCzJeFoVXTImrr8sa?=
 =?us-ascii?Q?MwwyMJDqUjdFMvcm0j4/mUP44lJDF+IrB8/8Slxy6xbXOD6muLoJ4nEbuAOp?=
 =?us-ascii?Q?BrLrBTWPs8BTFY4xQJqPxK5Zz/SgOQMJxFOV6cSrSbbZKoLIvuIKhHzxrWy5?=
 =?us-ascii?Q?LcduNrB/fm+1WuLFz7aldax8Rws6Tot8SR4cDyFCQ94PrIpRzRXSF7udvck9?=
 =?us-ascii?Q?eb3tAkUdtb61+nTNNubrGShux9fAU+tznoDFnifXP54SVaGTgTkD7KPYwsgi?=
 =?us-ascii?Q?qMFPGMLnREyKIUt+XQBEzfIfCCVKGiBWGRLLgMmeGm4T81vtNANQkNGl7GRQ?=
 =?us-ascii?Q?aX1fzwjFbja8F5ogWUAbwmIV3sTQ7CAkjobl87n/JD/aeK0nLZCoUSBPiqQ6?=
 =?us-ascii?Q?kh6Lj3NBB0UgdVhYFlAbS+2/qmdDYLGVq70WWm9JsEyK6ve5Z1JvmIz67x3R?=
 =?us-ascii?Q?67NQIzGMB2Mv8NGCbQIBex70j8IYhbMCDTo535kJV4ff0qnX6ez+4ob2BWsL?=
 =?us-ascii?Q?EZjJA2L96x7rszLXskV7xK+pCntU53pXcZiy3rglVSwhcMG/fi/vLAEM+Lhk?=
 =?us-ascii?Q?SWN+ST3L+1DNwCC3usjKvgfN19zE+664dcRdVEgYrMLj86tm4XPC7HhkHSmc?=
 =?us-ascii?Q?n/Me9+Rkr1IYvu9pnDvbU/jRLyf4lg5Ae47F4riWyua/P75bvOD9c6VSzi9q?=
 =?us-ascii?Q?+u5MN/htJoNNdD0gM1BZdc9AFFlrJbr/hYsZyortYM7GQ4SzAIRNyH7X5sJz?=
 =?us-ascii?Q?qPuIK+Tjs/sD2KIhOtYMBYuY61L4UXj8f2me78HOXERX5PjU7pqugUf/6o25?=
 =?us-ascii?Q?sWaNl8nyEK1m+20VMMCWGik=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d92c352-64d2-4029-758b-08dbcf2e3ebe
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8007.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 16:29:33.5743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zuJ1bQ3CqjKICFEf4QVaaWWEUbIsKcR/T9dX0wVTXsvrMS5DsylVx+PHgrJQ4Tgil9i7WwrLlOr2QkiN4AKRhN5GcgJGZVOhU80Qu4wDQD5BOzfCcr7XUVq+Lvw3ovCc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7212
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 05:45:13AM -0700, Guenter Roeck wrote:
> On Thu, Sep 21, 2023 at 02:02:36AM -0700, Darren Hart wrote:
> > Commit abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
> > introduced new timer math for watchdog revision 1 with the 48 bit offset
> > register.
> > 
> > The gwdt->clk and timeout are u32, but the argument being calculated is
> > u64. Without a cast, the compiler performs u32 operations, truncating
> > intermediate steps, resulting in incorrect values.
> > 
> > A watchdog revision 1 implementation with a gwdt->clk of 1GHz and a
> > timeout of 600s writes 3647256576 to the one shot watchdog instead of
> > 300000000000, resulting in the watchdog firing in 3.6s instead of 600s.
> > 
> > Force u64 math by casting the first argument (gwdt->clk) as a u64. Make
> > the order of operations explicit with parenthesis.
> > 
> > Fixes: abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
> > Reported-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> > Signed-off-by: Darren Hart <darren@os.amperecomputing.com>
> > Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: linux-watchdog@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: <stable@vger.kernel.org> # 5.14.x
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter or Wim, I haven't seen this land in the RCs or in next yet. Have
you already picked it up? Anything more needed from me?

Thanks,

-- 
Darren Hart
Ampere Computing / OS and Kernel
