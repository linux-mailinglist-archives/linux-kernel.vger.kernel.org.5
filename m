Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3903E788BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343763AbjHYOcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343746AbjHYOcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:32:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52086E7F;
        Fri, 25 Aug 2023 07:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5x2UXh4MX6kJ5RuEzYg+YJIiP55QdFd1i9QR8HC4a4Qc1Or1ah0bGIBpNpjdHhqLZdhx8SJHvHYaKnURVcR93k1fOZxYzjD0vA/a9sPfmG/2dDu4bGVoVC6m9mNQMXMAT5XhmjmJEYJ+Pq13FInLle+TtWQS4YfeO0YA//+w5M0kTBrLRnxTfGzut/blgJXAYFpIVB71q95JmoHd6UUufI7zrdbxVCVudrhPB/kNY7smgYvUY3HmyjhospPFibxNW9yDVoU/uhispyxNzK+Yr1VbtAOITYj9+geBccvh5SyW8nOIyak8wD33LuhSN/IezaNbjsLSIv0DOCUAxCM/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aMVn+ZoXAQLLbRA53vSWCZbQhDONdC6dkqFDK64uaA=;
 b=TTJ/io+Ve8E3zCcw5RjbLoixSDmq0nURWT0a1OVEqkhe5fiRI7/pxX8tie8/e2CkyAIclOzdca9+NbGcb/2M8oNuJTh1VzTUQ9LGuEYoMSCD2/JKvC6r2ax4wVw7payCFHVVoYfBljT6iK/kfmfoQtCAH4NUdDBFy31LDCYk7QXFKpN8Cruc5Z6ZpqbdOqLPx1bZIgSkELwhmHnPGyT2WRYnvmlFm7+WXXTZFZ0FY82/DWuty2moC+6s7fO27y3ES/UoYr2bE7pDhK71WkMgGv4qsPmrgfGTVMyeVIL9KzdSFM6WUn8uePpl50vpYu23ZUQVgl8RrRvWHi9bRyuPaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aMVn+ZoXAQLLbRA53vSWCZbQhDONdC6dkqFDK64uaA=;
 b=NSS6lyaEQyKZ5BvS73D3RkKjETMw3ZiK0yXYANIJz1LUCfv2WOg+PgWvpBKHu+n1ZoJ50ZY/yFy+RtLzEf38vgCyorFVawWMjI0GgDlUJqxZAvK4WRYHT1QjhIKVKBQZEdWgrbeXJEqofNmCpskIfO8Kgdj6ojbOwzHuOpt3xD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by PH7PR12MB8040.namprd12.prod.outlook.com (2603:10b6:510:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.32; Fri, 25 Aug
 2023 14:32:15 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::1dc1:222:24b8:16b8]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::1dc1:222:24b8:16b8%4]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 14:32:15 +0000
Date:   Fri, 25 Aug 2023 16:32:04 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Terry Bowman <terry.bowman@amd.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v8 03/14] cxl/hdm: Use stored Component Register mappings
 to map HDM decoder capability
Message-ID: <ZOi7ZOtb9j7TYib5@rric.localdomain>
References: <20230630231635.3132638-1-terry.bowman@amd.com>
 <20230630231635.3132638-4-terry.bowman@amd.com>
 <64a36a4a39351_8e178294c5@dwillia2-xfh.jf.intel.com.notmuch>
 <ZLGJ2Nm1OD/HoqZ6@rric.localdomain>
 <64d1afd97d33e_5ea6e2947e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64d1afd97d33e_5ea6e2947e@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: FR2P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::25) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|PH7PR12MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 60df2e10-0e69-4221-4604-08dba57813a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3iLby8kuNdxsfU4pBbXE2tkJZh0wB4ISfFe0LCUxve2xbDbPJ4DiYM6ByY+szuUaE7oRT4KbYXaVvawy3Ghn9zvyeshxfkqIhW6jnRD+t1UWdhFYsXZ7AqSpxLkutA8cHdmhIsQYAz7bIa90v+3CzP9dX6ugffTQplV/113nF23ESkzo4qESM6+Qpta9ZhFqqKRsdibAxptuTf/9NPROhPnmIQPArskZQGtB74cNYYjcGjg34cFD8WxfARu+nimMyNGEN9Qdc9HfAarmrq2olPiV1hqMML7nARRCVdKw7zjbWcooLC0p31C9gqbFuyQKHGN/BNZZbWdc/aKCTCyDXB0sNsa9Wx8DZF/TIrJ/pbBRUk2Xv4TjQ+NtlQmweurD443lkFqJouhQJ1SLRSGHGlEJ0jWuDWuBUe5WJ0csXEoHh3lQMqLijwMDNJfGxE67PybkKpBkdqhbeb7wNtHBX+GJynYQqLOJHJHVwOepZTVEnJ6NjMDImYPl9GtVD81A6e4Ik7I9D40mD0MMNuoRyiDBKD3y6Rv2gwpl/lABIWqQpXOaWAcKfVkl85/OQrX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199024)(1800799009)(186009)(7416002)(66946007)(66476007)(66556008)(2906002)(8936002)(316002)(6916009)(41300700001)(4326008)(8676002)(5660300002)(478600001)(6666004)(83380400001)(26005)(38100700002)(6512007)(6506007)(53546011)(6486002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mDrwr9NM+pcLqs2229srbPDtEjtMbgozX+rAgeGtinsUTYqZVc2I7NRYPfYv?=
 =?us-ascii?Q?M7E8cbNTogE6k6zNSwP774HLjnwg9GIn1152vfcQZsxTVULCcWd/8el9mp7b?=
 =?us-ascii?Q?Q3AbZ2na/4HhOXj2RhCGBRIov6eTmjRUExb0/U997BcQ7YyCquxj4WYw1NS1?=
 =?us-ascii?Q?sLvG4YdxXnp/h1R1yDG6Uq6qxXo9924qFcVxtFsQHrs00d6O1g5sG73PgCAh?=
 =?us-ascii?Q?OqG5z/UhKiRbgMPoOzThZjz4xI1tIt1Q8ezE+aANK56S60Z22YSgIhRiP3QG?=
 =?us-ascii?Q?1exU4lmz64/uUQ8dEXcbim8ER1jLdSHyiDV6tHl0YaPJosXRAQnVq2HmR+Uu?=
 =?us-ascii?Q?17Vq7m9ujorDjyay3UXE6gg+0tH8GoAo33ra4MBQvTXB4cT43BOA74X7NMAZ?=
 =?us-ascii?Q?Bx7g2tYZkmWV/5qhbUTPCu0hU1Fj1NomsGBTNAGutUTi++ZmD0gMYSUx4T2V?=
 =?us-ascii?Q?QuJDfHMtaX7Y/Wg7SSjh/X29GtfJoAec8U3QcFOExwZItcAFzUyUNHj5homw?=
 =?us-ascii?Q?a/o3lwNonJ1Ng6+Ds8Q0FRUPl+kKlTKln6mILIGWNjaOXNlhzb4UQwdYMgfO?=
 =?us-ascii?Q?zkq7RQXbo5KiBwAoGkKRs0tk2PrmOd/YCzkO/TIat6VzDQZruH48vzRiFnIe?=
 =?us-ascii?Q?sR3y4+KxouT5XDd1b6iMolmbv+JiiY92/c4BOdM5hiRPHSzuHUV5JlGmcXz3?=
 =?us-ascii?Q?HtA7irHRgym3Wu4Qir6t6ArH4ePuI/Am+9s5FiP2IWDLiCAUTUdsEYo/vlG2?=
 =?us-ascii?Q?SnCcrjB5aB8UX/j4ah3u9B32jdHRMNn/f0kNSJK63xs6oVqjZg9mIRbEaTvL?=
 =?us-ascii?Q?Vi9heJMgtI6qufVH9nb044SrhLR4z8ziP1txkRxE+iGS67+zcDzpW78ArcIV?=
 =?us-ascii?Q?5hjbGjVaihZong5Pof1/28VYWm4zKMXGVqStBYBWhdtz2IA+jb7iKoNszsM/?=
 =?us-ascii?Q?sbVYRm6sdbwsEtp1JWtOAE1YBPPgbkr5Sb4Gw7+NfYaIqd8Q2lxvY7cs++du?=
 =?us-ascii?Q?hmhcIUaToptxwTEvvTODDJQ029vjk8h9F2mGb7kAC/iI1UWv8yWxohpGhUwB?=
 =?us-ascii?Q?DldWHkxEp9jyOd2dTsLBJIn3hoHrIDazt/Ouk8cIvLVGVDo7lTgXNz9sjkDa?=
 =?us-ascii?Q?JDMhyJVph3asXRGnO66KPr8sm/fxyo5ukQUYVs+7/TpKzGk3b4CWvQw97Fh1?=
 =?us-ascii?Q?EZiiUy9Rqt3z8cRICTguzPJxY9a+fJOGJl05XTewJQFkWnH+siNxjLkhxfpQ?=
 =?us-ascii?Q?YWckqyWRLrTB78pI7fdFAJIE++LBf5EQUIU7L/IcbTbBaxN6XYHSR7Pkv+oj?=
 =?us-ascii?Q?nxnw2mrkTcXyN2ad4wK44IlnfVbwH/OuDU2C6iYFsQTzeFMz1b4A5/LXEYFP?=
 =?us-ascii?Q?PELqOdwDHP22cfem3cZtGvUcucNFy2uZgJ+2Om2V+/IrxhgrCyg8G9p6lcNO?=
 =?us-ascii?Q?po1YcQ/zNR4XAla51A4U721qBZiQCjLGYPiEJt2l/jDUAvwtL9+KRBcsT/m7?=
 =?us-ascii?Q?AwVo6r9AX4OPO/PEZtDsCYTwacKYNPj/3m7Tlh+ObpeWisPS4fLbFoYGu0D5?=
 =?us-ascii?Q?H2IwMBEqXRZ1pNLPdmEQxU6SX4cf5/ENt7Q1H1zy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60df2e10-0e69-4221-4604-08dba57813a3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 14:32:14.9944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzNSg4B11nJZLE9KSenPPPJ8AvgeYRq6wsGqfbyNwb9f4qEpFn3Uq7tIi9Tt56YtEOOSgGv34IjZHpIilHDh8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8040
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.08.23 20:00:41, Dan Williams wrote:
> Robert Richter wrote:
> > On 03.07.23 17:39:38, Dan Williams wrote:

> > [51/51] Linking target ndctl/ndctl
> > 1/6 ndctl:cxl / cxl-topology.sh             OK              18.59s
> > 2/6 ndctl:cxl / cxl-region-sysfs.sh         OK              12.26s
> > 3/6 ndctl:cxl / cxl-labels.sh               OK              28.25s
> > 4/6 ndctl:cxl / cxl-create-region.sh        OK              19.56s
> > 5/6 ndctl:cxl / cxl-xor-region.sh           OK              10.57s
> > 6/6 ndctl:cxl / cxl-security.sh             OK               9.77s
> > 
> > Ok:                 6
> > Expected Fail:      0
> > Fail:               0
> > Unexpected Pass:    0
> > Skipped:            0
> > Timeout:            0
> > 
> > Full log written to /root/ndctl/build/meson-logs/testlog.txt
> 
> So it turns out it is not cxl_test that is failing instead it is the
> tests noticing a regression of the VH base case. I am running
> cxl-topology.sh in a QEMU environment with a local device defined, and
> that local device is hitting a probe regression.
> 
> When cxl_test goes to count the expected disabled devices it sees one
> more because the QEMU device is also disabled.
> 
> ++ jq 'map(select(.state == "disabled")) | length'
> + count=5
> + (( count == 4 ))
> + err 170
> ++ basename /root/git/ndctl/test/cxl-topology.sh
> + echo test/cxl-topology.sh: failed at line 170
> 
> ...i.e. only 4 devices are expected to be disabled, not the 5th one that
> was not on the cxl_test bus. I assume you are running without any other
> CXL devices?
> 
> I will look into making that a more formalized case so that failure is
> not QEMU configuration dependent, but please make sure that QEMU CXL
> configs do not regress.

I finally could reproduce and root cause the issue.

I have isolated this to the operation on the qemu mem0 device, without
cxl_test involved:

root@qemu:~# cxl list
[
  {
    "memdev":"mem0",
    "pmem_size":536870912,
    "serial":0,
    "host":"0000:35:00.0"
  }
]
root@qemu:~# echo mem0 >/sys/bus/cxl/drivers/cxl_mem/unbind
[   65.957423] nvdimm nmem0: trace
[   66.001986] nd_bus ndbus0: nvdimm.remove(nmem0)
[   66.041053] cxl_mem mem0: disconnect mem0 from port1
root@qemu:~# echo mem0 >/sys/bus/cxl/drivers/cxl_mem/bind
[   75.076881] cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:34:00.0 parent: pci0000:34
[   75.077349] cxl_mem mem0: found already registered port port1:pci0000:34
[   75.077653] cxl_mem mem0: host-bridge: pci0000:34
[   75.078003] cxl_pci 0000:35:00.0: Failed to request region 0x00000000fe841110-0x00000000fe84119f
[   75.078415] cxl_port endpoint2: Failed to map HDM capability.
[   75.078683] cxl_port endpoint2: probe: -12
[   75.078911] cxl_port: probe of endpoint2 failed with error -12
[   75.079223] cxl_mem mem0: endpoint2 added to port1
[   75.079469] cxl_mem mem0: endpoint2 failed probe
[   75.079706] cxl_mem mem0: probe: -6
[   75.079943] cxl_mem mem0: disconnect mem0 from port1
bash: echo: write error: No such device or address
root@qemu:~# cxl list -i
[
  {
    "memdev":"mem0",
    "pmem_size":536870912,
    "serial":0,
    "host":"0000:35:00.0",
    "state":"disabled"
  }
]

The issue causes ndctl cxl tests with the cxl_test module to fail too.

> > > > +static struct cxl_register_map *cxl_port_get_comp_map(struct cxl_port *port)
> > > > +{
> > > > +	/*
> > > > +	 * HDM capability applies to Endpoints, USPs and VH Host
> > > > +	 * Bridges. The Endpoint's component register mappings are
> > > > +	 * located in the cxlds.
> > > > +	 */
> > > > +	if (is_cxl_endpoint(port)) {
> > > > +		struct cxl_memdev *memdev = to_cxl_memdev(port->uport_dev);
> > > > +
> > > > +		return &memdev->cxlds->comp_map;
> > > 
> > > ...but why? The issue here is that the @dev argument in that map is the
> > > memdev parent PCI device. However, in this context the @dev for devm
> > > operations wants to be &port->dev.

Right, I fixed this by changing the function i/f to pass @dev for the
devm operation. See below.

> > 
> > The cxl_pci driver stores the comp_map of the endpoint in the cxlds
> > structure, struct cxl_port is not yet available at this point.
> 
> When you say "this point" you mean "that point" in cxl_pci, right? I
> initially took that to mean literally "this" point in the quoted code
> above.

Yes, exactly. The mapping is in cxlds->comp_map, not port->comp_map.

> 
> > See patch #2 of this series ("cxl/pci: Store the endpoint's Component
> > Register mappings in struct cxl_dev_state").
> > 
> > > 
> > > > +	}
> > > > +
> > > > +	return &port->comp_map;
> > > 
> > > ...so this is fine, and folding in the following resolves the test
> > > failure.
> > > 
> > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > index b0f59e63e0d2..6f111f487795 100644
> > > --- a/drivers/cxl/core/hdm.c
> > > +++ b/drivers/cxl/core/hdm.c
> > > @@ -125,22 +125,6 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> > >         return true;
> > >  }
> > >  
> > > -static struct cxl_register_map *cxl_port_get_comp_map(struct cxl_port *port)
> > > -{
> > > -       /*
> > > -        * HDM capability applies to Endpoints, USPs and VH Host
> > > -        * Bridges. The Endpoint's component register mappings are
> > > -        * located in the cxlds.
> > > -        */
> > > -       if (is_cxl_endpoint(port)) {
> > > -               struct cxl_memdev *memdev = to_cxl_memdev(port->uport_dev);
> > > -
> > > -               return &memdev->cxlds->comp_map;
> > > -       }
> > > -
> > > -       return &port->comp_map;
> > > -}
> > > -
> > >  /**
> > >   * devm_cxl_setup_hdm - map HDM decoder component registers
> > >   * @port: cxl_port to map
> > > @@ -160,8 +144,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
> > >         cxlhdm->port = port;
> > >         dev_set_drvdata(dev, cxlhdm);
> > >  
> > > -       comp_map = cxl_port_get_comp_map(port);
> > > -
> > > +       comp_map = &port->comp_map;
> > 
> > Can you check if the following works instead, I think the
> > pre-initialization is missing in cxl_mock_mem_probe() for
> > cxl_test:
> > 
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index d6d067fbee97..4c4e33de4d74 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -1333,6 +1333,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
> >  	mutex_init(&mds->mbox_mutex);
> >  	mutex_init(&mds->event.log_lock);
> >  	mds->cxlds.dev = dev;
> > +	mds->cxlds.comp_map.dev = dev;
> > +	mds->cxlds.comp_map.resource = CXL_RESOURCE_NONE;
> 
> This has the same problem. @dev is specifying the lifetime of the
> mapping. The lifetime of the mapping needs to be relative to the driver
> using the registers. So if the cxl_port driver is mapping the component
> registers the only valid device in the comp_map is &port->dev.
> 
> I notice that cxl_port_get_comp_map() endpoint port as an argument. That
> endpoint port was instantiated with @cxlmd, but it seems not with
> @cxlmd->cxlds->comp_map information which is available. Lets just fix
> that. I.e. move devm_cxl_add_endpoint() into the core and make it
> initialize @endpoint->comp_map with @cxlds->comp_map while switching
> @dev in the @endpoint->comp_map to be @endpoint->dev, and not
> @cxlds->dev.

That does not work as we need the RAS cap early once cxl_pci is bound.
There are multiple devices using the comp_map. For proper devm release
we need to assign different devices depending on the users. That is,
the RAS cap is released with cxl_pci driver unbinding and HDM with the
memdev release. The fix I have chosen is to expand
cxl_map_component_regs() to pass the devm device to release it
together with the device using it.

> 
> ...but it turns out that is the second bug in this patch. As I went to
> try to reproduce this failure for a single port VH configuration I
> notice another bug, a regression of this fix:
> 
>    7bba261e0aa6 cxl/port: Scan single-target ports for decoders
> 
> ...because there is no requirement for single port switches /
> host-bridges to have HDM decoders per the specification, and the
> original patch is turning HDM decoders not present as a hard failure.

But if the HDM is not present, a -ENODEV is still returned?
cxl_switch_port_probe() does not fail then.

> 
> >  	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
> >  
> >  	return mds;
> > -- 
> > 2.30.2
> > 
> > The cxl_pci driver always has something valid or fails otherwise.
> 
> Understood, just copy that map at __devm_cxl_add_port() time. I am
> thinking devm_cxl_add_endpoint() moves into core/port.c and it calls
> __devm_cxl_add_port() directly with a new parameter to take a passed in
> @comp_map or @component_reg_phys for the switch port case.

Please take a look at the cxl_map_component_regs() update in v9. We
will send it out today. The changes compared to v8 are
straightforward.

Thanks,

-Robert

> 
> > 
> > If that works the change should be merged into patch #2.
> > 
> > Thanks,
> > 
> > -Robert
> > 
> > 
> > >         if (comp_map->resource == CXL_RESOURCE_NONE) {
> > >                 if (info && info->mem_enabled) {
> > >                         cxlhdm->decoder_count = info->ranges;
> > > 
> > > 
> > > Am I missing why the cxlds->comp_map needs to be reused?
> > > 
> > > Note that I am out and may not be able to respond further until next
> > > week.
> 
> 
