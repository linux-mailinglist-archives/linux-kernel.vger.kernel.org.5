Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD5E7DA343
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346635AbjJ0WN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbjJ0WNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:13:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A638110DA;
        Fri, 27 Oct 2023 15:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698444773; x=1729980773;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=neh5I6120FrVBS2KZx7RVxofhUwGqMqrw4vjPqrJV00=;
  b=N0FhC/m5HEt4L01c6ebJpDGsTKNoe1Zscyg8UEVN4EyzeDBmZy++mmBF
   hWT+bQEOgvFNIUYSGfA+rebpu4Ow+sgqiyU2uPQykHvi9v7kArgkSBgBx
   WZVwzaaKAMljAdGDGXEGKXU7C4LaZuI/E8VvWHOXKWIg1e+1cFxkFacT0
   0OZ1bEsfrhk4bRcaIQgyBISTWFwKZ7NMHsORdSHFfhH+OeZuThmdlbBxq
   7VjMj9/H+QJ5VeGavHv2uf3cHu0AW9lV+FVchwHvZNTOnbW6vlmUFN0YZ
   0Mm1YlNTAGngwcnv2cSms2r/PVmAV6YET6MaoHH9gSqkEpTH/qugasJIj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="387670025"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="387670025"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 15:12:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="7753874"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 15:12:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 15:12:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 15:12:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 15:12:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 15:12:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULip7+v+BZdFUm5+XCtu5w7inKpBRT9IGdjQ5JZQHZG+KVMldSgIY+eUknmylJ34PwnggjTWWPbrBYRJjmIp3XCY2h/Tx1526utyh6phgOCu1lG0oZqH4KNghTQL9koGrDp74fEi8HPrryMUMH/3zbpGBUELgOUR1r5cRrcyilV9Y8MTFIvInI8oMCsp9b/AXYsk9eQCCfQi8KbLcnxEQF3YhSIB027hi5AT8mbOd0EKu/AtIG5J7f/gxMD//eD5/EB/NwHbhkcuEATLXXKqSrPEFKCfwVBGAlG5PsHSyPIj8LFAHBWy9dgqLF7mqz6tnRoXCg+C5NEhMrsTW0O3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JMd1z7410CxrT4hUuV2mF2n8zuj1OWyNQGHLSS9JkA=;
 b=a/64eg2DZAsL0UAyvr5SCUEFxq4YMLRO4ljdsOyRuU2vRhFiT+lB1h08Dv+Q06qYsrKQ985hmoayIOreAQ6ShoC92jn4wvyYtpPSsbY9AqT97j2vO37yRA40uHbSW+fdDPwn7NqGpHx+5TLMk8tgFXtYQm2qzjdcS3fE64PD7RT2OjROijWV3Fa7RpAezpJ7grzuPhF27dUu6BJFANs3Serdl8/L03FvKVNEZNPHH38YJOy1EP7V7XzFgqy/U5jFHjCzOxNObxKdVPvKZ3CPHaDMteJ9d57FNjgaTz181LCZHbOJgvRadeeAwHrZeQvMb4PV3eTcx19Jys24G1glHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4778.namprd11.prod.outlook.com (2603:10b6:806:119::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 22:12:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 22:12:50 +0000
Date:   Fri, 27 Oct 2023 15:12:47 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v12 11/20] cxl/pci: Add RCH downstream port AER register
 discovery
Message-ID: <653c35df632a5_244c7829490@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231018171713.1883517-1-rrichter@amd.com>
 <20231018171713.1883517-12-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231018171713.1883517-12-rrichter@amd.com>
X-ClientProxiedBy: MW4P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4778:EE_
X-MS-Office365-Filtering-Correlation-Id: f166a252-0804-4adb-0513-08dbd739db7e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7/volDW3JVN9dUYXRyghsk/3KsvV8drlLICjvknofY3UChbUgyOGDnuLnUP85v+/p2ACfvKYvGlcvxxh6I4wxJsdzE2+HomwuTbZ5xY250qmQ0EbpdW+4YvDpGnmIwZAjYezt9HUskeQzPi2WNgWmcg1bnG7jLGrPLCwcc30GiBQTapgPfQk2ep7D3L7xoCsQ+t5WztkCkbpt965IfIJnL9xed+tkxjnu1ZZB0NwswSYxilAhqBfQO9HkBHymU8hQGCm2DNvgev5td63NVE5HtxvJb05mdQendU8Z8rwxcF2zcmS+daOEJf8/4Omm6EuzHe26fLkDCRztC1toICQmAgHuRcvMVE/QKaSz7vErPzRayMM9vXh2NpxCJfTjXBQHJ8GPdXUwM7GCiv3HL5JcoRm7hjpGCjqq0gqfy7PMxhO4tgXmmk54CZo0JB0yoFdd80BzyhdZNKb/dYEqsNN93hKYbGCG5k06B0oxm9BGVpj3tcnwjn4rmmL/jXG2u+nxA9cy3yJDnU3V+I9KY8aX4S4ciH1Q28+iUUPUZfa1f4biWPcDDtnsSIhMNb94TIk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(316002)(5660300002)(66556008)(26005)(82960400001)(4326008)(41300700001)(8936002)(8676002)(83380400001)(38100700002)(66946007)(6512007)(9686003)(66476007)(6666004)(110136005)(478600001)(6506007)(54906003)(86362001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0zf3JaacFa2efEQ+GJAoyImSsDWI62AfWCk2hH7ovXA0QISJDUz6GXpKvAv2?=
 =?us-ascii?Q?J+6IkwzVRcA7jNWB5MQbTUp5/o8MpJ/ews8LOseO9DoFkQY+w697J/r5E63J?=
 =?us-ascii?Q?TWk6oic1QfrpRF3Z7ptX5l5gusfVECwHZOhw3pldQPdihSa4WvcjsLwPpO4v?=
 =?us-ascii?Q?PLXmyfFBnJ3AOU05klriNOoZbgJy/3DjiGM6/FYAYC8aKpBEp4AhUmDWZTB/?=
 =?us-ascii?Q?lzvThiBNPjvRWxhHpV6zt4EVktJHQSlBmASULEnpanq/o2KBXFPphYyrfNnk?=
 =?us-ascii?Q?MsVJXJS20dgy4jTQgx3d5b2iR8b7If+TmW1fmDA0GcCtkKnPpaRNK+QTYRze?=
 =?us-ascii?Q?d8FFvfs396BA7ikb2pPp1oGuOJMjgPpO2xgBWq31JsSDg0ykwfSt8l9AcF9k?=
 =?us-ascii?Q?pT19+n4yin5rGd38zAu/PIDtkTHS+CZ9V2uTX9Ecans6b9eJ1F6JEj773pFi?=
 =?us-ascii?Q?VYOw9UTccQUgW5/9hlK6nOIW2fTQLujMn5+gLEwPOfjmcEdAohtScJ+y35lS?=
 =?us-ascii?Q?SyQRJyrf53N7FZ567HUUz2UtVgfV3S89HYucONTXW2ytG2DJMn3fyt9qOqG3?=
 =?us-ascii?Q?j2x+alcy9Z2tBZvZEMfIDsHc+YfhPJC1wr8b8LyunMN7vdkZr+9+/Enurhej?=
 =?us-ascii?Q?vVWF25lPjQnc1vdjpoixuyVYBJnPXUevOsLxM5c/tIvu5WdHdYfZ3143wcsK?=
 =?us-ascii?Q?v6SjmFwWxFxtwkPE/hfncoQe3V5df1ozAU+fojRG8BwxdwxDw1e6QQAJjgmL?=
 =?us-ascii?Q?QhO8h2cQOX3E4UaNmP2WoGQb405J1S6F8u/9Ue7iGXNfaeDA8PtNPnATGTKQ?=
 =?us-ascii?Q?EpHtXvKNBZ3jePx574gnk5uRPA9FlASJy8vU7yPMAzSx4sVL99fd4ss+Ukq/?=
 =?us-ascii?Q?Mc7Z3lyZIsQ44qzcLhX7Ut8VfZQ9P/K/eyBLRDxpP08y+Kh9Xw4ygoKN6/aq?=
 =?us-ascii?Q?+l5TY0mYtqMIKaU4tf9MI5giED1nPnqL2BE9GbAneSIoqozdAipV2y/6Mk1w?=
 =?us-ascii?Q?ytStVLEQL3mfA53RpL9DF54KXDiIJp2e6ER81jA1hxyLZRM8b17V68yxXxbh?=
 =?us-ascii?Q?tQkFAeNtBDiy1Atfpp2Cnjd1W48/azqsaaOeaLDH0Pb4d39+kqeGjBT8iAk3?=
 =?us-ascii?Q?K4CfFVHm/lIzBUecTnm4KSuPIzWFk4E7fiykUkLtYpBX3miRY433r8udv2az?=
 =?us-ascii?Q?9yQo6suLvLu1x5nCzZzMdgfyONtUI+ukmioSP5KftP2JWBVsBRNmmg4T9W0o?=
 =?us-ascii?Q?zUWOQONy/aHOcITnTuE9iqFrAcNztKK/z045xNX9KkEcFzspybB3z4bbfqiu?=
 =?us-ascii?Q?wOjX9wZDylOpKPBX2XP7Yo8nRX2Bk6yQBvO3S9KLS60hUxTEUfSuF/P1koG6?=
 =?us-ascii?Q?nh92X1o+Y67TbJGyprzBW0BlQz3/khcDJd20L39rbkAFH72OIWrpgXTMHi+s?=
 =?us-ascii?Q?7RbNCF3iZWhrGDHWzjdYmD3SBSEC5BEYhCMBK2t2fvcVO0+gai/4zYzEQdeA?=
 =?us-ascii?Q?/1TpQx1ugJutxTU9lx0ll8r65Yf2aieYupbWYyKKQLHAo7jhx3Izl0s6tAcD?=
 =?us-ascii?Q?1O7RdUWhPv/75T9Hd3g0fj+W4h4rlau1z0r/+zNoNgw/YxihrO4kRSzPZ5FF?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f166a252-0804-4adb-0513-08dbd739db7e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 22:12:49.9727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRABnNkVszS8sRTWwTgd0FfMejTrNc9E4HdFx4U0NBmFDDm/JINL3fz2qAIFsDx6afJM3GvQ60FX2ZFPccXeNQy8YTNSsfqW2jG/jN1IZMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4778
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> From: Terry Bowman <terry.bowman@amd.com>
> 
> Restricted CXL host (RCH) downstream port AER information is not currently
> logged while in the error state. One problem preventing the error logging
> is the AER and RAS registers are not accessible. The CXL driver requires
> changes to find RCH downstream port AER and RAS registers for purpose of
> error logging.
> 
> RCH downstream ports are not enumerated during a PCI bus scan and are
> instead discovered using system firmware, ACPI in this case.[1] The
> downstream port is implemented as a Root Complex Register Block (RCRB).
> The RCRB is a 4k memory block containing PCIe registers based on the PCIe
> root port.[2] The RCRB includes AER extended capability registers used for
> reporting errors. Note, the RCH's AER Capability is located in the RCRB
> memory space instead of PCI configuration space, thus its register access
> is different. Existing kernel PCIe AER functions can not be used to manage
> the downstream port AER capabilities and RAS registers because the port was
> not enumerated during PCI scan and the registers are not PCI config
> accessible.
> 
> Discover RCH downstream port AER extended capability registers. Use MMIO
> accesses to search for extended AER capability in RCRB register space.
> 
> [1] CXL 3.0 Spec, 9.11.2 - System Firmware View of CXL 1.1 Hierarchy
> [2] CXL 3.0 Spec, 8.2.1.1 - RCH Downstream Port RCRB
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/core.h |  1 +
>  drivers/cxl/core/pci.c  |  6 ++++++
>  drivers/cxl/core/regs.c | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 45e7e044cf4a..f470ef5c0a6a 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -73,6 +73,7 @@ struct cxl_rcrb_info;
>  resource_size_t __rcrb_to_component(struct device *dev,
>  				    struct cxl_rcrb_info *ri,
>  				    enum cxl_rcrb which);
> +u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
>  
>  extern struct rw_semaphore cxl_dpa_rwsem;
>  
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 7c3fbf9815e9..cbccc222bb91 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -722,6 +722,12 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>  
>  void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
>  {
> +	struct device *dport_dev = dport->dport_dev;
> +	struct pci_host_bridge *host_bridge;
> +
> +	host_bridge = to_pci_host_bridge(dport_dev);
> +	if (host_bridge->native_cxl_error)
> +		dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);

Nothing in this function has a compile dependency on CONFIG_PCIEAER_CXL
the enumeration can be done unconditionally, it's the usage that needs
to be gated.

I believe I had commented on this before, given the late hour I will
need to fix this up post -rc1.
