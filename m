Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530157B63E6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjJCISQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239206AbjJCISL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:18:11 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2041.outbound.protection.outlook.com [40.107.215.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0B6BF;
        Tue,  3 Oct 2023 01:18:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZiLpgmhHOn8J1PcRqBIoJ1ZagOvxCVz6JQy9bnKKX1wg2ID7tYdgR44aSXyJGgJNWrDgdGUpf0xszWE4ecPnGnNPXp7DGhAyvu4Kf65OvV86B6Jeiwwme1LmUcsfxVM9tQCgutBcrlJUkSZAqRWS8StIlRn8+uMMU9OZgPttJnPSFUaQC3f+KQN3GmxCB9lO35QtnJa9tVN53cJx4/XB4M5dhy0YHYP08cg/Imc7lZzN4ANEgKbpTFA+Wg/yXc82kvN+2oBp/XfO7aSshPjdlQMNMBtm8W0ZE159umoKYO2Q0Fx4x1APn6St2hugzqARaTfxDu8p3y7EGWMLFDjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivZ5q6JwarvWhjaIgwAiu6FE1eLpFM4ATkGD2a73X+k=;
 b=LHTqXxGNBXQ+5mrQe62F5EWB/nVnYzuRxn0C+vGUWVSoF/dWY6SvnXGtezP2ESFuZIFR3GXNEaxkGz0PsuKp5mBdP5DvwFEZqbs9L091dPAdk4Ly0J2udvKRhpNaNN9comlqYFOoFXVmZROe0Pof5PLzunNAuq7FyjG4oqMfT3jek3cbmkbTrdYobJjU7ZP7PUabwKmV9iqzBgWGFI666991gLlkA1HTTzlkalGKUPI776Fpqs4KGvSS76VH7cFtC+G0bI09FZ8vWS7Ci62ypBsGrB0vIwypfMuKZa7dh+5xrz95JZUEM8W0wioL+nluNty8IMW8Ilroq6A6958Amw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivZ5q6JwarvWhjaIgwAiu6FE1eLpFM4ATkGD2a73X+k=;
 b=QNGF1uwFQKv+La4u5qpK64aPpjND67blH1svASAS1G+cY9h8eMSb5bpVUEepHfstHj9BYg/OeQgoDtuZK9YRv9eNftay3vvsuI3DO3QRDXtvv32M7pzcdwb6pz3Fc+h9pCTyNqi3HIwuM5lHS6bwbXarX0sC83x5dARdYlPol5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SI2PR01MB4276.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1af::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Tue, 3 Oct
 2023 08:18:02 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 08:18:01 +0000
Date:   Tue, 3 Oct 2023 16:17:57 +0800
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/4] tty: serial: 8250: Add support for MOXA Mini PCIe
 boards
Message-ID: <ZRvONVIbgytC+ysT@moxa-ThinkCentre-M90t>
References: <20231002015702.30509-1-crescentcy.hsieh@moxa.com>
 <20231002015702.30509-3-crescentcy.hsieh@moxa.com>
 <1e99f3c4-e0b8-4951-80c3-f3c5a1eb5277@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e99f3c4-e0b8-4951-80c3-f3c5a1eb5277@kernel.org>
X-ClientProxiedBy: PS2PR04CA0021.apcprd04.prod.outlook.com
 (2603:1096:300:55::33) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SI2PR01MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc77956-4dd2-473b-b43c-08dbc3e942a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YwDlpKWRxyiFj5cusk/E9miDp2o2ZKZcMyZ86Zw8MTsR4Rvm6dD8jWgfWvDxNEJPXo43geAHq07MyIKdAT5Uceyo61wd/H6MCISsJtk9epp7StrWLj/ViDjU6jdpOfommPNUNYjhI/UFfJRMbW/mqIQgL7NixSasdoG6WbnLwhEcyMbuL+J0tCk9vA1b+inH6x1FgZyPL0NFeNZaQv9dl86jzKfcQruhYNvgKsyLbM5VeBnaBoRwYCUjfO068N9GlIbcppSxdbcdEEswsF0BeCcVJNAe+BEq2qDAs7ZGq51831r/vSaoQoZMGg70iakAoovrPu3Nnunv3TUcYxgEc98aXk5W4ytIuEguDkU8CQXerSbxNDTz3Hw93Ux+t9oHmuoRjnlPVCePEARRMOTWB0c45tqFlAQMvOYfo3ZlMJbX/dHn4YeV3ucflQz4ObUv1yilzUXy/0vP2zvW45rVixTYC4lX8Az57Yf6KhHI4JyJ/0+zR5rXN8iE2JMzH+DYlm7awB6j7otbbHtTaYBTClf4M12DkP9ItwOS93fCa1+TlHp/libGEePd1/F2Ht1MI+e3N27MJ9smDfUWDas+6wjHIEtYSOZmZAoPj7rJqqKzvQrUhMQkVDEMoSxTHeq4o2UYHwXHtaaFmMzPLSFJ1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(478600001)(6506007)(6486002)(38350700002)(66946007)(8936002)(41300700001)(66556008)(66476007)(38100700002)(316002)(6666004)(26005)(6916009)(52116002)(6512007)(9686003)(5660300002)(33716001)(8676002)(4326008)(86362001)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O4U1EmZf0cKXuz/LF0mgb0V2lQMP6axWVyRWWVh9hILq9ud6Q9rLdFTJXEU0?=
 =?us-ascii?Q?RBsM/dgrTUz+rboqdKlcEJxSqeF9eNPM9iQ0UPubLQ+DLPU1zRzCM19gsbLM?=
 =?us-ascii?Q?GarvZH2fHfRKTWBi5jJyuUTu/aiKeqKRYBfJhKgr56leDDpuqqP2unmma/zM?=
 =?us-ascii?Q?tmcvVRN8U1Wix+tKySYhUocP2d0ITRDGrIHnFWSgPOkmzU/Y/jm/DJY7Vm24?=
 =?us-ascii?Q?wI53jK/6JRZOsj9h/1aYAk7D6X+Kua9Fw7S9tXxlbq9dbWxvZ0TSdvgHadvM?=
 =?us-ascii?Q?83hQhgosiZ8RSyVcNxOq4Kz/WrYR4jDHvFNNcTXgWpBSXXgyjSS2OPDIzYM1?=
 =?us-ascii?Q?13FmooRAZr+yF1boI13f8NYwB2mEROZiUwc/f6J16g5ETK+pmoWO/4+Hq33E?=
 =?us-ascii?Q?U/tEuMhmKeSddobdL+7nJnGThtggrLDW7dlIRm1POO9Z51cRsQSzD0Djxh9D?=
 =?us-ascii?Q?J5BqJ8njq2leSHBazKeDmOryYIryk4tyLWeM6jW+p0X8jTmFrbD7lsODDYHZ?=
 =?us-ascii?Q?qys7MrDO0dBGIASJVNW814iuwZvO/VTTOvSJgK55TYdInKx28aQ7jg0YBZMD?=
 =?us-ascii?Q?xERp/pVuK+RDVpoo5pNpXSSQ/8J4mhwIumlv+I4qBJ79c4xVahF6E95XjL4O?=
 =?us-ascii?Q?zy6BOEGrEY5cBzHUxVClMNr4MvsJUeu87mzHz9NJJSa+ioHXz+H2g05dDWXx?=
 =?us-ascii?Q?+Itzf4MH6XqRwPFqXCazbXWH7h2tlXSP0//EO0+FIB3gxNOiUF8SE1vDzwMu?=
 =?us-ascii?Q?c4f/kjZef5o5p2J9dgNSIe2N7tuiSD83XEUBJ6G4miL0clrtKuRGPRjmNzj4?=
 =?us-ascii?Q?Kg+dASPq3plGcKDuCic0/yeyMNUd3o7hl+XZcWNCBmKgGro7HGRVwDtY/vU8?=
 =?us-ascii?Q?kbEJJBqRV84/rkhn+whH772D8QyEZehapQleksBr1WDvaeCmdRtNjjk7RkcJ?=
 =?us-ascii?Q?PeyL2emEmJwnDGp+NhYNJGj0HWVf8eTycgid/Pu6YY9wT+oZFepGX9ayLmqS?=
 =?us-ascii?Q?4FOOYJkTI5YCE0fwA7QdRGizN9xCiW27IOa8H9gypjqJVvsAif1cfiy7LUAu?=
 =?us-ascii?Q?Oqa7jPJa6Ly6tfFN5oBqFIKS3xOoi2+kuiWv5nMr6SqqiaAUuYN/t7V0TCxB?=
 =?us-ascii?Q?jp+o6RT4CTM8/Sp1GZntoBG9jnx9tiDJawIy1Ocy/Rmy+KxREsJ1FTh9rzkK?=
 =?us-ascii?Q?ib3xWBTvrGpp6ZG+9qa/9WNfq1XVaeegA/Xtn4kQLdzxC2zTD6jjXh/pxk8j?=
 =?us-ascii?Q?kew5VQ8RImW4qCWg05cOGu+T5KMvWlO1ANnqs28Eue5TlYmwGIhwa9tqx+d5?=
 =?us-ascii?Q?uyTgeOgSkh5Tbo9DIjsC62ChQt5Hcd+87mVk6AMUWEqy55zBtM6Ml+GU0/w2?=
 =?us-ascii?Q?+NVR0VOvOVi5fUabWxRk+NJ+d7/Fz3vuNbB4oQkmxzdR+NuhM3TvkKFBtx/w?=
 =?us-ascii?Q?XTTERPWhgb94AarimtAG/2bdLJoQrnPpaTechiDkHZJ+/I6OmU5/nzSVDh7J?=
 =?us-ascii?Q?Vx3gLu0Ljrrz8A4Uw4FvwQzOoVC85oRsW4CmQevjZmydFBHBOnekKUgIbw3Q?=
 =?us-ascii?Q?cKZVsCveYzsTyPuscGrBa3EJz1y1eOCifPoEaeb3TygNz+7aam9Guhtks8JP?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc77956-4dd2-473b-b43c-08dbc3e942a9
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 08:18:01.7931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSxbROgQ6XOR8hnkGL4d0y22mFuYdkT/twsaKvgoiPiEs4afp4j8leL24ZwcgtBlGHqCHYrmoF+kIjb4mpBGey7tsdK0rJfs3ZlBBFn/+JM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB4276
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 09:05:31AM +0200, Jiri Slaby wrote:
> On 02. 10. 23, 3:57, Crescent CY Hsieh wrote:
> > +	 * This hardware buffer is only supported on Mini PCIe series.
> > +	 */
> > +	if (device == 0x1027 ||	/* MOXA_CP102N */
> > +	    device == 0x1046 ||	/* MOXA_CP104N */
> > +	    device == 0x1121 ||	/* MOXA_CP112N */
> > +	    device == 0x1145 ||	/* MOXA_CP114N */
> > +	    device == 0x1323 ||	/* MOXA_CP132N */
> > +	    device == 0x1343) {	/* MOXA_CP134N */
> 
> Why not use the definitions below? You should define a function for this
> anyway.

I cannot use macros here, unless I put the definitions before this
function or into pci_ids.h.

> > @@ -1973,6 +2009,13 @@ static int pci_moxa_setup(struct serial_private *priv,
> >   #define	PCI_DEVICE_ID_MOXA_CP134EL_A	0x1342
> >   #define	PCI_DEVICE_ID_MOXA_CP138E_A	0x1381
> >   #define	PCI_DEVICE_ID_MOXA_CP168EL_A	0x1683
> > +/* MOXA Mini PCIe */
> > +#define PCI_DEVICE_ID_MOXA_CP102N	0x1027
> > +#define PCI_DEVICE_ID_MOXA_CP104N	0x1046
> > +#define PCI_DEVICE_ID_MOXA_CP112N	0x1121
> > +#define PCI_DEVICE_ID_MOXA_CP114N	0x1145
> > +#define PCI_DEVICE_ID_MOXA_CP132N	0x1323
> > +#define PCI_DEVICE_ID_MOXA_CP134N	0x1343
> 
> I am not sure it matters they are mini PCIe. I would sort them into the
> above preexisting list instead.

For these lines, classify the type of boards is just for clarity, but
sort them into preexisting list is also feasible.

---
Sincerely,
Crescent CY Hsieh
