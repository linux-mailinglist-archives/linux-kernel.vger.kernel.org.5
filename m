Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C079F7DAD33
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 17:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjJ2QRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 12:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjJ2QRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 12:17:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE13DBA;
        Sun, 29 Oct 2023 09:17:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPopxEBsw0i+9bZlmCSZx4ICQZVUHUFSdiwV/eAY9oYPU35njDTirmkGDNaSDWd/5HBvgH09CVXpN6CASEZXeju6tvMNuQAPhoxvxq/VUWCfF2+lmXqDtNW8wX6EEKgiZ+tr7jySYT3K4liiU5YSDhhyo8gL9NcZq8Yhx5115hijthvNf7fhd17OrMQzjQkmfHdneKJCKkTyxYbwjl0Px6GWzTzpRD2ui+QsSm3BfWpFTJ9FiCeJvZKalnfib8WL0G++489HFUyhI9OnReRq5Fm+qI0Gjm6UNrbMSNUAx9NVfbM6Z4JZhCMttuqrqedm2f3upSehNPE1dJjgokha2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtCi6otNAwt+RbVkVQe78WHGi8VotgbIjtSmRr2r9ig=;
 b=SxoTK9AySpev/Xh/vrRcuBgsrOH7e32eDTqGxwLMav+62ZtoxOJmJRk1a9RMQQcZhuI5oHioOqn2+Jt4uY7DQB8FS9lAqiZfTCxm3odE+DbUj3iM8fBfFNrU4bRHcCyi7kw1Wj5zdRvIxhZvXv+EVDMQWUENyiOx990Zw+xNSU6xbhqnsLDSPtBdwEQClxtcdds8gkRRnWdMiJW6Al1jofN3vUY4d0RxCnGryie4ABQIXU8zGoy+OI86rAxcTKfBRvmQzN4HwthB64jRH4Zneww80CNGV8zJNtIDc54cp+FpWb57hzn2dFbNYe96JMX9mfh1io2gwmRDWPIcX2N97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtCi6otNAwt+RbVkVQe78WHGi8VotgbIjtSmRr2r9ig=;
 b=yElrQgEyz0fbO88Jkmfl79fHHBBY60fm1X3InSDkHuLNOdjyWx9v8yS/38dPepEdaw4H7Y4BsRfKnNHQkic36iun9ic4JckIjgyu7oZl136dshIxoR1A6WCk/k5ziUKzJq+2K71eU9yqWunUFNFgaL+SMiaCIo15YKTTQe/ZG9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Sun, 29 Oct
 2023 16:17:46 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::302f:131b:a9e1:7751]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::302f:131b:a9e1:7751%4]) with mapi id 15.20.6933.027; Sun, 29 Oct 2023
 16:17:45 +0000
Date:   Sun, 29 Oct 2023 17:17:38 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v12 01/20] cxl/port: Fix release of RCD endpoints
Message-ID: <ZT6Fov84g5FxrBEj@rric.localdomain>
References: <20231018171713.1883517-1-rrichter@amd.com>
 <20231018171713.1883517-2-rrichter@amd.com>
 <653b3299c1a33_244c8f29449@dwillia2-xfh.jf.intel.com.notmuch>
 <ZTw_xd2_uaApAzoL@rric.localdomain>
 <653c5691a2372_780ef2949b@dwillia2-xfh.jf.intel.com.notmuch>
 <653c66507bf8d_244c8f294ea@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <653c66507bf8d_244c8f294ea@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: FR2P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::12) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: f96351c8-68a0-4be7-54d0-08dbd89a9561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WeD7hDwpGAOhpAfWOoy0JhG4hlU/30zlbjlL/L3ctaRGqWb1iEsDDecm4Ia15GuaakljxmtmWZ1BI3LkT3R0cFwXipZjaQA4wS4hESLF2cIZ4pTJU314DOBywh+QGhK9jwOj82vBnRy29oj9nGtLZ2t8EDh7R+uRlw+UXPNkx2Dz6jdqlxg9f1AdwFWLQ42hDoi3lmFVBRtKb9+AlMSdOZeC3J9obqEGYKHpcnZz2/q5ZvoRXA03GWX9Qd5EBB5lBEHkbvOTaY99cr5dli7NPCvwcHmcWy9H3PlJ1PkWSRn0mB/imGz5IaE9Nb/hlAzHrHA4mxNbhthUHTqPdLIvwk9WPXkhjhEYWcqYYmF0f+0MLZZlJIIexZ3qwMMX3+ZBOXPJvzVSXj0mVntV8NJMbv2PGIO7Vx8YHm5xtX//Si54mFzQiQWDbsZVu3MweRNOqMVC/yxo27nN5CeJODZ+LCBbhC0wtsjncQpwlSVYNbs3PwdxcsuPPxf3AHSFmVm9YYj6pvKajlrKmL3ON6iSjpfKZva2e3LzDjGoRJuhRmKhttWIKWriGKl7nkVPbN6h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(41300700001)(7416002)(4326008)(8676002)(8936002)(5660300002)(478600001)(6486002)(6512007)(9686003)(38100700002)(6506007)(6666004)(53546011)(6916009)(54906003)(316002)(66476007)(66556008)(26005)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eas75Scr/U6jlCdSxkCPCpFZp79ARUs6nQrNkzXW/2sWmEVh1gZqdyVUO54F?=
 =?us-ascii?Q?xUTw+iz2YrQd5f39lEhZfHeM7M3mnsNOPecuIUDpZ8CLUm2gjdkBjQCh8nj2?=
 =?us-ascii?Q?OTLojLf8+YKiKdQfZIUUVBhZ6dSySaPaSsAetof4eRSDT7HpbrICOONEYUm5?=
 =?us-ascii?Q?cuj4TTwjPJIulsuwnqE2i/9rZ0ajKcrPh2vguYj4qIiu54K4iHePl9ByOEoB?=
 =?us-ascii?Q?NTmE7xYiQj64llFkUKlB7BrQT857chWHhPvP4Ox5b+4yI6sPJOSqwzHJAC7y?=
 =?us-ascii?Q?kIOsOi84oZz/sv8yqJOik1M+skhucWUFfOd0AVjVLfKj5MPNNyfLofJrKRL+?=
 =?us-ascii?Q?xrPP/Uelz7OlbnZ3NwY8/jzTlPXgqF1Dx6uWFSgf1Gd7nZmEOFo0wY2Veuz6?=
 =?us-ascii?Q?GIfcR/UeFEommWc4iyKbGNBSoMyYCMRTQE/X38RERLitsYu4MB7DZ6TZ6Qzi?=
 =?us-ascii?Q?9jhXGmlXUD0b4i5JYtxBICCppuO3wsrKlBFwxAOISmPJNWZydT5/IqECHM7/?=
 =?us-ascii?Q?23n7ndF1WMd4JLjyWvY6d+BaW2uSz81DW7HcOCpiFpVN6rLudc8iJs/hplqZ?=
 =?us-ascii?Q?MzYcK4/5V80oqNIwcB9XuTO+4adPLvlgb73hZh/ehhIO9xRjF30pFkDWTtF7?=
 =?us-ascii?Q?GsxCsNuTILqwM07LXA86qnaotxuey7k9S3fEljGCbvYx+yynk/nbxNj6n1VJ?=
 =?us-ascii?Q?nrSZ1UoAk8jyKl4DRvrytUfv4mRt+K3iLUOHavcBjk3veV2PXx+zkvDegheI?=
 =?us-ascii?Q?UbuDW1zxB8KuASer45KYeWFGxz+U705T+uIV3KwGrlh+u0KZ8///MGzangzZ?=
 =?us-ascii?Q?rF/vd8QS/vM0IoRhJ0q6ltnDubGOX/cUcrbeXDCAJ3PeboQozvl3W+c2dLPj?=
 =?us-ascii?Q?gF0zYu8ko+kGEE/VxPMgS5PKcincU+oK0+4ve0tCxzu+nuZPHPD4LuOiG7BG?=
 =?us-ascii?Q?5W202UKipLrib2TFma2ZyUIANcPNMxon8+v2R0zit6gvnLcVvvL1MeubkIbB?=
 =?us-ascii?Q?dcCRj8EWx9zTg3vEc+w6IqV9w3F7zJIn1Rc6yAETC5uGahsHVvHs4gMTv7A8?=
 =?us-ascii?Q?gAjnTsNXjmGt5EhYSJjOyV4Q/xo7BChOdzJoGqr0zPTOD5SSCg94UsIbLyyo?=
 =?us-ascii?Q?ptqVf6bF2CFZ8j9QHrqM6o/+PpCNqfydtqsBKdidY69sC8GdgEY5t9DO6X9L?=
 =?us-ascii?Q?xpWDAxsNtMp2mIGQLyldns2ewbcSLsyP4Ob8dLq9Oj177W0ewQh0Rpwv1Fcd?=
 =?us-ascii?Q?o3tvdXro3jZp+j0Mx2ETDp7KDEGDeH5z1yEKZdlcV7kJflwvN0Ay5kStwbGU?=
 =?us-ascii?Q?XGz54LekJksKL+nwyztHz8DYJLdgRv5nU9ewwStSxZz6nrdUMzBZAQd3BpvI?=
 =?us-ascii?Q?52srgOl/X3lgqcHI7iDHRyav0n+nRr/ceqJ8tmLbf25Ne2Y7T3oKEwN3F1hb?=
 =?us-ascii?Q?HNP+SMwvTmFc6gES/X4l3gUv+7Zyxp4gXKBdnJFWOGCK5HwLAIlIbGJa6FLn?=
 =?us-ascii?Q?LKlUuBvfr9az9EknUbmWDGxewEPHYV9v+J0x4k4cSCBigGdqoIaHlQNbdVQR?=
 =?us-ascii?Q?CwaWV4zPfgy2eyVVHhQz6MXWpkIi1ck7ztUu3wJj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96351c8-68a0-4be7-54d0-08dbd89a9561
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2023 16:17:45.1585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+IWNzENLxW4yaX5ynixXE814kCd4uMDBRpvvdGqL1ymouluv+ayWpmycWJ4mGJstIQU966V3hJI1OZLBciK6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.23 18:39:28, Dan Williams wrote:
> Dan Williams wrote:
> > Robert Richter wrote:
> > > Dan,
> > [..]
> > > 
> > > delete_endpoint() is called here, but the uport etc. is not unbound.
> > > Which means this is not true:
> > > 
> > > 	if (parent->driver && !endpoint->dead) {
> > > 		...
> > > 
> > > I don't remember this with my patch. The parent is there different, so
> > > that could be the reason.
> > > 
> > > I could not yet look into more detail but wanted to let you know. Will
> > > continue.
> > 
> > Apologies, I didn't have that regression going, I think I see the issue.
> > Thanks for the heads up.
> 
> Here is the incremental fix on top of the lifetime fix:
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 6230ddfc0be8..0fe915ec2cc2 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1217,30 +1217,39 @@ static struct device *grandparent(struct device *dev)
>  	return NULL;
>  }
>  
> +static struct device *endpoint_host(struct cxl_port *endpoint)
> +{
> +	struct cxl_port *port = to_cxl_port(endpoint->dev.parent);
> +
> +	if (is_cxl_root(port))
> +		return port->uport_dev;
> +	return &port->dev;
> +}

Yes, that works.

Reviewed-by: Robert Richter <rrichter@amd.com>
Tested-by: Robert Richter <rrichter@amd.com>

Thanks,

-Robert
