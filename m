Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7F07AAEE4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjIVJ5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIVJ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:56:58 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2091.outbound.protection.outlook.com [40.92.73.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8108F;
        Fri, 22 Sep 2023 02:56:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7ebV1Y9j7D8qbBioJhAOUBVjBN3Bhc5ZsXPfK+rL6b1qbOPpG7Tq7bhqNL0G529W1ERpox0+XZc8lJWmRSYgS76TCldRBqfytz7W/irpwzK7jGZk5Xd7Yz6J0svEqCuVy0kOM7VliaavFfuy7SKrkiBavyM8EnZ+QrcIgc/JagaU0ZlK7X/ej8mE8Viiq9FrIWeRr8u2J9FmqwgeQNm9622RBkI+RnDJgE8ExzItqXmYmtymKnASIcRWpzMfsdi4DXvNLv38PUM5/GRUkTg/XDA6T37R9RXQnHShtLe0WIF7sf0xBnCUG6cViwGxJkCKOlfAcS3AL9RJYlz4lURwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WJHavu7VmoqxPsXvEm7wfp2pltei6FoWFUR62ifGy0=;
 b=E5Z0MR7DGoy6xBPqDYyFpogRy1F/7pc0g3e6b9Mrds5mPVSadZK356o8ltH6VzMf+sIBT6sHiNwcPZTbNcTf8votAX+AVTrBMy2OlJJUT1bw/PSwtRjcJ5GHMilzO5117U1IYF2jZnPZI7w+Bhw3EUPjPVxyc7zRr8Dc24q3u5koe3WsHTEbz6XcnrfDEsS9+J2MjbD1weel7RrLu9qpTVxZOiNlU6smfinmERqWsliyghBIEPDDoNaS8hPH0mVcx61S8S8RDjOTJXEYEHzRhRoLeqrrPeJe1gCDE/Q+mdQLKSgpKwEAT1i4rop5y6hKAp6I6xQtMPpnkJFYEbbm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by DB5PR02MB10453.eurprd02.prod.outlook.com (2603:10a6:10:4a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 09:56:48 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%6]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 09:56:48 +0000
Date:   Fri, 22 Sep 2023 10:56:43 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 4/4] tty: 8250: Add more support for and fix up
 Brainboxes cards
Message-ID: <DU0PR02MB7899C4BBB0C099596F32F7BBC4FFA@DU0PR02MB7899.eurprd02.prod.outlook.com>
References: <DU0PR02MB7899EABA8C3DCAC94DCC79D4C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com>
 <2023092134-wizard-nintendo-9b74@gregkh>
 <2023092216-outcome-police-4a79@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023092216-outcome-police-4a79@gregkh>
X-TMN:  [wHBQpHaIMkD+NngL0dRY5mt+cwIeII5g]
X-ClientProxiedBy: PA7P264CA0400.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39b::19) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZQ1k23Gs4ESgz7Qb@archlinux>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|DB5PR02MB10453:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ae7109-76f6-4f8d-e84f-08dbbb523c77
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bQbFpEXIusdxqZWhDKb2XlJKBR0yOg5cpm5v3H/4JIR7pJEgr+tDe1DehF5gyTWOcgz90alqHHMYmZ95N6HASTTM0JiO8nOxoXFKMIX6LYNdmCUFRrKe1jjOrdeBoj56Pbm87EBSDe2hO+jEmozmTPlK66h8h/+JhGQo36upzvhC6mUectNe5qXIIfjC413x3cyGMhfneKRU7IuYEvpYsGuwHk2BEr6iUNS08QHcJQOR/OvRP8Oi9JR35wzhd3CnooH7G+134YL2Enh6T0JbKbrsrAMjgaf5MopAdtwVHcOoiU1LbTpjk7jOYxoLp7DCD9vOe8QaeGvJP/+THUhX7YJxxRYpB5WbnFQwau1xgrf83maO2MzyRfZM5xHVnwS50IfLE9l8vpFtspEwdQXGUwQcOd0Q8vK7ufCBFflGk8423uE5Ph9k+q4kwU79eb/uaAce7ZYXknSwBkqACMnRIA0vkUvKMZ7ZlSWdxH3vWsLVkBBhWxDGUkG3AxYuSqc0Ap03YPLfL4TdGfCQsGOWzVWj6/zqEkwBzP6j667oSF231EO65sYzjGOEiTBGUkC9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ISo+NY9ExRFYu2hJrV/KGFfDlDN8bIArKZoAVmUAccZvGS4PdSIe8sDgN4j1?=
 =?us-ascii?Q?LOSin63T4DAt2cdlFfTdFyXg2R2SP8rR/RGHcHYroLC/YGCBrAwO8J8guhFK?=
 =?us-ascii?Q?DAPp1thPe6Zu263VbevzwYYd0KQ0xXkwNCUhoWjAsBaXoPZWtreSf5OFhVuz?=
 =?us-ascii?Q?vkElf1k8H1IdyNyAXfaet3dOKGgaxdWSUN/nQ1eyA9ERHxUBFcbVjtVmeN3j?=
 =?us-ascii?Q?8b7yHjkLtb6a9SKfswybPfuVLZBjcIfKMUnN0ScswUeKIj95vW9ebAtGPDmB?=
 =?us-ascii?Q?CXR7mMcO8PyIhsQKCaDQ06uADxY+tC/fE96hB5KVBhodMmW1DrrxspHF03uV?=
 =?us-ascii?Q?59pAxAy2eAgsRDFtpGgUM01kerkGMgRQ0lHa53iku1OUWV9zwS5Zll33cmab?=
 =?us-ascii?Q?BlEmmDqXJRUVuroBPhgK9aM+wJMG0WvobuvwgVoqPpaw2axKziBmtWpvJSce?=
 =?us-ascii?Q?8OvG2KWp7LKEBotBbiS+XOs7/M/heaGlRz4QCY4b/AXJ63YS5fGk7o/bfwvT?=
 =?us-ascii?Q?FQlvf4f2c8LT1OfZqLz4tr64aod6qNlV74i6gdMjgLO7QrfP7PCC5+fSLbGr?=
 =?us-ascii?Q?EDM1NYsWd7+4N4S1qIYn9p+0ycyidNwCP3Pj7Vrph3Moi8cDtSVsPLRE0qNs?=
 =?us-ascii?Q?jIU7BlbJXP4dTXsZU8TeaJf3cngIWzmNe9BVQTLhUTfAdj8xUyeGIuYFnEo3?=
 =?us-ascii?Q?+bJZx0OGahPqMxmURh1fys8laWtfiJmjuh3+Fx+wOCM7Bo5QHbyeXp1tnHUp?=
 =?us-ascii?Q?PWm0kgr2hQC4cgk8e2SSAk+sKRUCeP+rn8sa8oXClith+SI5jaeY02tqxEHc?=
 =?us-ascii?Q?YpWdZQHcrmrUgpcymO/lDW8Gc70kyWdoXexFQSqxI6YlznzZ33kefs7llF7n?=
 =?us-ascii?Q?sXezuYiC2FiFOqstXdLOKvvOXlVZD1gxE6oPp/T8Wjsi7LhT3QQZCD/ZupCF?=
 =?us-ascii?Q?WSgl2gsec+wNx8ScAVR+yQp4QPYuYftscvavEvezFXD48RO/ofDIf5BA2uKr?=
 =?us-ascii?Q?QYAZDLFzOeGCZrgly3gaCkkCUliQr8HUgR8FY1HQR1WeO/miqFIaRKerGIyd?=
 =?us-ascii?Q?2mkw5SazOTVDxZlCA4P4D8sO326x0cN5akV6dOvH+1ZN9mYZfMeFB51kE79o?=
 =?us-ascii?Q?++TQfbjQz+dx2E9rJ33RdwQqTFtRgLm1eItWSVW8aoJqNNu/WeX49drGaDvI?=
 =?us-ascii?Q?JFGWp3StQL1JBk1OnIYwQqDS4n3gKMiY62QrOg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ae7109-76f6-4f8d-e84f-08dbbb523c77
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 09:56:48.2979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR02MB10453
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 11:19:27AM +0200, Greg KH wrote:
> On Thu, Sep 21, 2023 at 11:29:14PM +0200, Greg KH wrote:
> > On Thu, Sep 21, 2023 at 10:13:33PM +0100, Cameron Williams wrote:
> > > Add support for the rest of the Brainboxes range of serial cards,
> > > except the 3-port variants as there is no suitable configuration
> > > in this driver.
> > > 
> > > - The pci_ids.h file has been updated to define each card's ID, cleaner
> > > than using the raw ID.
> > 
> > That's not happening in this patch, are you sure you got this correct?
> 
> And where are patches 1-3 of this series?
> 
Patches 1 to 3 were cc'd to the LKML [1][2][3].

Please disregard this patch series. Bjorn [maintainer of the PCI subsystem]
has declined the pci_ids.h update so I will have to v2 this series using
raw hex IDs. I guess thats what I get for doing kernel work without putting in
enough time to check everything :(. Sorry for the mess.

With regard to the 8250_pci.c file in particular, should I split each change
into its own commit? I just want to avoid merge conflicts, and making all the
changes in one commit made more sense to me but rules are rules, so I will
follow them to get these devices supported. I'm still sort of new to patching
like this so sorry for any mistakes :(.

[1] https://lore.kernel.org/all/DU0PR02MB789950E64D808DB57E9D7312C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[2] https://lore.kernel.org/all/DU0PR02MB7899DE53DFC900EFB50E53F2C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[3] https://lore.kernel.org/all/DU0PR02MB7899033E7E81EAF3694BC20AC4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/

Thanks
Cameron.

> thanks,
> 
> greg k-h
