Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5E67CAAFF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbjJPOKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjJPOKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:10:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D331C9B;
        Mon, 16 Oct 2023 07:10:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIDwQBC17BZIgohGML72A+NdqufN2/+0G5KaOZ1KNwc3cF0HW1LyB5C4mnDbAbx38TV92vkIN2qy+VFntsYlyMivQu2DzY9SQlB0Phxzr/duj5iQHH9dpemqzteSOlugTcJ3DDUOZQ0oF/r6QX6PAJvVgA1jjknDc2o6hE4Bk0SMF+AxqQEeRNFbiuYdYVVEBcyWGtVN93cV6Q4HIZX03C5SiaqhRKIZKN/1WrPaSb3oMAl83mhrwF7Z8blArNCEtpZQgWLtJjH4WqTR5fwWLdBxZukK/gbvZullsB2Fa+vPaByg1eqO12ZcGSrU3ROyzACROYEDucOYB/HzoWITZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/X13Sq+BTs6yPzhEaC4iGuYQbW7UN36pbZnHWgYeto=;
 b=X0DLcGp+2D1OWAnzjGTkhWXptkBU/ywxvL4JOT4nTdwiJQuL8BL4XYwKe+rT+dupkeizYH8plN5xBHXEvM5tqHB18u9e0nO2qpzdXvgERD82v1z3t9zdYMCiGuVVT1qiuWJLZ+lpnCg8+s3HJckb6ANWjHaRfL5RWylEZfa2Gw+BjTGhei1Fkyf8xqoW9btZnnGBm7669AsHiUfeAT07pXYPE27GaVhzNff6sNID8+hrXcS9DLuU486Nvb6Y2peTBpqY8z1O83HzgK9/JRz+3vbxKUPmWXq73Lk2/Sm1hTUSO1UYfj1lv9zmnBzbTTG9bGDpaKQ01zLq1cC5kTAFfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/X13Sq+BTs6yPzhEaC4iGuYQbW7UN36pbZnHWgYeto=;
 b=cq7v2vcbg2O35LUgkAXLY5h3AWGTyBtfALO+Kpa8THwYZrcZUR0b8dzUYg2dLQCu/XFIaLlaDZP8wl7bzsbKw1OMI6QUx0TkXHdQ++zvAu0uZ/Wd7yvZfoX/6GN0UnLKpydOFIwcPCNfqEBR17jtCpyOZdAQhR+/jXTFHYZj7ms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Mon, 16 Oct
 2023 14:10:05 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::befc:607d:b3ce:7dbd]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::befc:607d:b3ce:7dbd%4]) with mapi id 15.20.6863.043; Mon, 16 Oct 2023
 14:10:05 +0000
Date:   Mon, 16 Oct 2023 16:09:58 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v11 07/20] cxl/hdm: Use stored Component Register
 mappings to map HDM decoder capability
Message-ID: <ZS1ENmg1OfNluhXm@rric.localdomain>
References: <20230927154339.1600738-1-rrichter@amd.com>
 <20230927154339.1600738-8-rrichter@amd.com>
 <20231002154351.0000136a@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002154351.0000136a@Huawei.com>
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: 59679528-f78c-40f3-5c33-08dbce519897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YH0xle3ek51WLjbq6QzVG9KID4cYBuhz8vJKfrqMLEB3E+YKU/0OYpN8TaP873ii6OHGzUtEL16+Z0N3Ahs9DP6Q/truogogQcdfPv2qYhq7w75cxhTe9pYdbgaN3Oo7m6ceN39bEDvMc/3TDBR+PzECCrEPdnz7LvrwyCoyTQrgTYSyTYF8DvtJUiJ2QR3bsSity/M5imTbs8g+GMnEiW7wNOIeKiWHgIqMM0CGNtQExWLrxDzeLJPWrwBU5oSVlpRBPkrNObAk1PnSgdvqec8M4I38IAQwhZ+tXhsTQKd4+Sw3npEN2WwXx0geCSKfOywvCw8xUeFg4V2EnlApWnfKnIencCwPDW2X/tKM8rDsFu/9xdgfNPgVGH+5xkvuu6wPH5ho3YAkHku6hVgZOAeycGAyFqVnnc85KLck6f4Lc5fKqs6brpRpLZVzh0SP7txA6x6Inp6qMZnJzI+xl7HhNOR4sluXKHaqVa6soTHS9Vf/tnTEnGNlVDkMAvHqK9ZNOXdO2xjvb3Qfgh2qtAmZUMEyNvAv6U7Wn52A6XGbxmXUcc9qjKOCHNElSWnf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(41300700001)(83380400001)(38100700002)(53546011)(9686003)(6512007)(6666004)(2906002)(8936002)(66476007)(7416002)(5660300002)(54906003)(316002)(6506007)(6916009)(66556008)(66946007)(6486002)(478600001)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aRJttsuBAJdZ6tV58Ny5KwmLJCGQGj2+5iz1UgajN17OL683ZN5LmD4sItij?=
 =?us-ascii?Q?Ad1m8CAMtNMgkDwX45j6MnfIWhcudFsMEBLf472otNjjUhifS+rSSHRrxZKq?=
 =?us-ascii?Q?OtUpHPrF71cQ5AoYrye0OYmytb/15WrkbrMGiXWqykFAzA2EHJEpeVJZTj3v?=
 =?us-ascii?Q?6K9JSUzUFKZWn5hTY0L7Dx51oMaIQQAjX0sv2mmsMPX/qFcbvzLpPhJO+sGU?=
 =?us-ascii?Q?MrHzm/3cRjq9+PFykNwfvi1PKmyEA+ycY2EouAcATVUTLauya6Uew0s+auMb?=
 =?us-ascii?Q?Y5AGqP9cC3sxXbk32v0UDxT6FlVCEGGbRDvDHjc4dCM6/5By67Me68bTCL0p?=
 =?us-ascii?Q?V9gI3Nd9qxSA40Z+Cd2/lUGeHVCo4MMWO5l2Hm4PcNrorVAFkyyqjtjeoi94?=
 =?us-ascii?Q?GHGZPx2sV7qk6v9qjXlpQpwD/yhfWfzs6QfluBzkSin2VDyF6cN73ygIGmiZ?=
 =?us-ascii?Q?pIzXls26Ws593VrYACcBXEckCXapgyi4f48vfqhU5aK25BCrLlx1+I/VBTjn?=
 =?us-ascii?Q?ln+Ecm8PjfVGqvxL265T8AUMPN4om1Hmnij4CkP5nZ7d3fVMX3+//toUPbMT?=
 =?us-ascii?Q?V2fK67Sssa/vnaZHJTJwVD6JxSfflKA9v48wA2wqkDfORmBlN77JdsbdcHK2?=
 =?us-ascii?Q?Ytlg/TtffUJ4+EXssODMmUGerRUo5xWOJ0x8XYETtUmqoCMItBGmDc/Qu+0z?=
 =?us-ascii?Q?igd2rszHJRQTVGaih8Mv3b6cmyBpPMGXXK/60Mukve+SUn79JxwOr4QyIEG7?=
 =?us-ascii?Q?EZw/1UYfAYNCyF4XJIafKqPfuT8T7wkdWBpQWwsQrwf6/Mhf0q/gXNLokYC7?=
 =?us-ascii?Q?5FUz77Eo9fMBTDtAiL33iO+LaZzvz9C9idLO7Ct7Mq0ZOBi3p4Fa6YieeUrk?=
 =?us-ascii?Q?33Sk7xi306+AiBdSQ0BJCyYQ6olj/Y9BER/tewH1kDPDoPrz4e4U5wRtP9n+?=
 =?us-ascii?Q?xAxzJeoRuLzEcmn0nNh/vqTTsbESxJVLq3QmmAisovytycFibh4//tRYao1w?=
 =?us-ascii?Q?5sk8VQ1emsUwBeJ8C7x3XeFt5nY5yijSevEtFRBvNvnP5VEuvKl6WP5MMdO5?=
 =?us-ascii?Q?F4BDIYQQjTYDOQWUcXi+mcQkP/6IjisE2YNQCcY1Qtk05KaAVBFeNDAk4zrq?=
 =?us-ascii?Q?DG055ki6mRW7cgWC0anCaLDgn6j/DGRfWT59+oFKxM6jAFSzQ7ZPZevPb87D?=
 =?us-ascii?Q?5iUJif+behBI8JrWLQlOYCVF6S0WET9K8plWQ/j1Edz2eeiLjASlpAi6FCmR?=
 =?us-ascii?Q?mmbRDTiyIryiWiWU1W7SZIZa5RWU4lJ6M85u4Npl3whCs2XkzGkrDxsn1F4W?=
 =?us-ascii?Q?KrRaBDilQwkDuGCnDqk+2k4+PIDVXgVTkhl/9IvUibeiA1RXoZnZyYYkMmNJ?=
 =?us-ascii?Q?GiWsNlhMBgdUiwwKs9QdCMK0RaLjuHz8Y3cKal/2Zf6a3d3kBDzOD4p1fJk5?=
 =?us-ascii?Q?OOkqzshTDJh4bpQhRtv8AM05SFDpnkJXG9H1PwlV/AMQ4QzbGwmNYwGjuzCa?=
 =?us-ascii?Q?8XK9b84/Gy0GttkRBd8SJ0U6M7366W2uUVWAh83KdgtKPED3tNf0r3Tn5GhX?=
 =?us-ascii?Q?hcU4nBz2520xFnWOSriaZ0WFOlBVSN7LYwYpfKT6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59679528-f78c-40f3-5c33-08dbce519897
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 14:10:05.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1Q5z25rYwI5zQBGI9PG5pXu2vApgbArVDE2gF2+t0MConvzmd2+ZS50tU9REB52ovTs6zwX8YDQA17RFVj1zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.10.23 15:43:51, Jonathan Cameron wrote:
> On Wed, 27 Sep 2023 17:43:26 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
> > Now, that the Component Register mappings are stored, use them to
> > enable and map the HDM decoder capabilities. The Component Registers
> > do not need to be probed again for this, remove probing code.
> > 
> > The HDM capability applies to Endpoints, USPs and VH Host Bridges. The
> > Endpoint's component register mappings are located in the cxlds and
> > else in the port's structure. Duplicate the cxlds->reg_map in
> > port->reg_map for endpoint ports.
> > 
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > [rework to drop cxl_port_get_comp_map()]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> A few comments inline.
> 
> Also, Dan's SoB doesn't make sense if you are the Author and he's not
> the one sending the email.  The fun of patches bounced back and forwards
> is sometimes you have to tweak this stuff on each posting... :(

Yeah, there was some back and forth with the code going on: Terry
changed a little, Dan was taking it and reposting, Terry was also
submitting the previous series, Dave reviewed it. So I decided here to
just swap Terry and my SOBs as I was posting the series now and left
the remaining to Dan the way as it will look like when he will apply
the patch, which means updating the SOB chain again. This keeps the
comment for the change he made to the patch.

-Robert

> 
> > ---
> >  drivers/cxl/core/hdm.c  | 48 ++++++++++++++++-------------------------
> >  drivers/cxl/core/port.c | 29 +++++++++++++++++++------
> >  drivers/cxl/mem.c       |  5 ++---
> >  3 files changed, 43 insertions(+), 39 deletions(-)
