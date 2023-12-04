Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038B0802A96
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 04:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjLDDpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 22:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDDpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 22:45:36 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F346B6;
        Sun,  3 Dec 2023 19:45:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8yjozKDYYgAtYu82XyvXrhBToASlpy+QAdgHvzUv93BSJS9moa7KDDOVDHGyRNJaoGxezIlMti3MzjcXXTqkUCVmh4Du4uOCTIUgS+GF/+bzZ4uux72GB+btPgN7ydaOzD8rSOeYsLnifzIv0fSFdMgAEVrMe6lQQZPxx2kADk/RxRZ7ROA4SkmMYucuRZfKDJ3cyNVNUw0cAPwJybVDLtMFpom6qvUGPbGsq20nBEepzcRD7ZfmSw01GbpBFNjKnMf/7cQto2/l78aWGrsQk+325D/nnTh0+OoAHOfxM3uaH2j7NO5TtUzlskLVxGys0pPWuTCwTBw7H6xivPhXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaQ2MMiy6Jn8wfLuIiDszGFIPaf1JoUCtKXHgC9Kw8g=;
 b=VK6y6stcpGnHD7LT5dZrTWm3q9C/DFec7VSl3qOoPSOZxNbEUotDW+MRCNjUNTfwDfnB7OekDm3htM/3aPsV8bukviJTaNsJwjO11PatG+Ke5rotSZQHKHCPYJX2EmHjfPTtEO8GRSfseXjEbjJQXLT+NbnTjKl3AsjZ2vBFDPW1YviwzJebV1WQ46L1OUGAUnOgLHErEQUSgwXmq/sXwX7yNRzfYr+IInbbY7N+4+9D4NlEy5+JjKyPbDRjYALnWqFjFIwRZaPD5pUM/9Xypy6txqeBHjxDQGpCs7iiAmrjRmIrLJgYoBKUKB3uVmnmu005F0KxS0rQXldm3IV4JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaQ2MMiy6Jn8wfLuIiDszGFIPaf1JoUCtKXHgC9Kw8g=;
 b=E9TG+hEs6fkpO3w8MYQCmOD7N3YvATN6wl+5M1KHM8aLhEHYDzhNgJte0RzNlWZ6FtGYfuQW7o47nij8HCmQCteHpqQk0AaVok4TfzFRWK3KT11bjM0kmlHREfyE6FjvzRFyaZxz6VVXzj/dWU1axaBpKmO+IasGDTD0LZm9Cdk=
Received: from BL1PR13CA0189.namprd13.prod.outlook.com (2603:10b6:208:2be::14)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 4 Dec
 2023 03:45:38 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::30) by BL1PR13CA0189.outlook.office365.com
 (2603:10b6:208:2be::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22 via Frontend
 Transport; Mon, 4 Dec 2023 03:45:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 03:45:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 3 Dec
 2023 21:45:35 -0600
Received: from [172.27.137.28] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Sun, 3 Dec 2023 21:45:31 -0600
Message-ID: <4f21ce4f-7b79-47cb-baad-e31702b8887e@amd.com>
Date:   Sun, 3 Dec 2023 22:45:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC KERNEL PATCH v2 1/3] xen/pci: Add xen_reset_device_state
 function
Content-Language: en-US
To:     "Chen, Jiqian" <Jiqian.Chen@amd.com>,
        Stefano Stabellini <sstabellini@kernel.org>
CC:     Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Stabellini, Stefano" <stefano.stabellini@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
        "Huang, Honglei1" <Honglei1.Huang@amd.com>,
        "Zhang, Julia" <Julia.Zhang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
 <20231124103123.3263471-2-Jiqian.Chen@amd.com>
 <alpine.DEB.2.22.394.2311291943260.3533093@ubuntu-linux-20-04-desktop>
 <BL1PR12MB58490EB260D226500141557EE782A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <f78395f3-6588-4bc9-8612-3450a8f44be7@amd.com>
 <BL1PR12MB5849C9BFEBECAF3C5BCBB09DE786A@BL1PR12MB5849.namprd12.prod.outlook.com>
From:   Stewart Hildebrand <stewart.hildebrand@amd.com>
In-Reply-To: <BL1PR12MB5849C9BFEBECAF3C5BCBB09DE786A@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e09e39-a133-4033-c156-08dbf47b7abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lH/1UGWZqIYIT8cQNn0ECF798tKZc7ufZzvhS/qFwNvMoQ/LwasxCZJSsG+1SYlSB0sV//1EYVemHcUjiLdSMtAOoefCHxCA+DcAHxVp1ypHAFPPJliFQ1Js+WkCJZ4UxGoHa8ms4qPkdxHEzU4XvzaMes3Dzb16vKEu1KJnk+2epmAFI3Xm0WtazaQgX53DvMItphU+x1QNMU2JFNZ+D3JEpq8OrW88Ljgd6RGl30amwgGkd4Ce1Ds5bItOFaeMsIEo17aSOaJ7SvVBhhTL7wWjC+48C/gqLjJ0eMoeD9tfjdOoHfP7jSDcTvFZGNRTFdxHdQat+vx+IrdJTVaY++uxka8J2Gag5IRPnCmHOeOL8cUbGpx+TBUtIHGYe/zDzmaySKhyyKur2UOjVJTjrNPh5EoLzAjC/g1SGeDbk5KzngBKK+5yQ3zCBcAwYeLBDqQCWjvciT7JerIvBAPU7GIa3A2OnVInJA7pZCSznvAclxy+brY0ZJ+xfYkPdO7ce3laCq6d0oHX35wLnCPxv3GX4w1FyVJ7mKsFHvrfRQtIayzqJuxZVF/VhtIiYPtraZLi8YqF3Z8lzNJR2RgmG4Udjp2wEexI/lDuEDsrLo5yZUq9gXujJilCNNW1sohPtJHf2VYIPmD776Tqdk9wYXhNLC1SWTKeKbGBuzkfG3j2WpGBj84+XZvWXma3tz/kfzgdm0yjpYGarhRozYOFJmIxZAKc0TfKO7EXGAulMHbFrbto4sqpa8W4FL6elNgzGw+JXQQjUCFiGREt/tLnx2/PScefqMIC7fSzKZGgM9a70BwBkmrUoQtJkYTrcVwk
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(4326008)(8936002)(8676002)(31696002)(478600001)(53546011)(40460700003)(110136005)(316002)(16576012)(54906003)(31686004)(36860700001)(86362001)(47076005)(356005)(26005)(36756003)(40480700001)(2616005)(41300700001)(44832011)(70586007)(81166007)(2906002)(7416002)(82740400003)(70206006)(426003)(83380400001)(336012)(5660300002)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 03:45:38.0130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e09e39-a133-4033-c156-08dbf47b7abf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/23 22:25, Chen, Jiqian wrote:
> Hi Stewart,
> 
> On 2023/11/30 23:03, Stewart Hildebrand wrote:
>> On 11/30/23 02:03, Chen, Jiqian wrote:
>>>
>>> On 2023/11/30 11:46, Stefano Stabellini wrote:
>>>> On Fri, 24 Nov 2023, Jiqian Chen wrote:
>>>>> When device on dom0 side has been reset, the vpci on Xen side
>>>>> won't get notification, so that the cached state in vpci is
>>>>> all out of date with the real device state.
>>>>> To solve that problem, this patch add a function to clear all
>>>>> vpci device state when device is reset on dom0 side.
>>>>>
>>>>> And call that function in pcistub_init_device. Because when
>>>>> we use "pci-assignable-add" to assign a passthrough device in
>>>>> Xen, it will reset passthrough device and the vpci state will
>>>>> out of date, and then device will fail to restore bar state.
>>>>>
>>>>> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
>>>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>>>>> ---
>>>>>  drivers/xen/pci.c                  | 12 ++++++++++++
>>>>>  drivers/xen/xen-pciback/pci_stub.c |  3 +++
>>>>>  include/xen/interface/physdev.h    |  2 ++
>>>>>  include/xen/pci.h                  |  6 ++++++
>>>>>  4 files changed, 23 insertions(+)
>>>>>
>>>>> diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
>>>>> index 72d4e3f193af..e9b30bc09139 100644
>>>>> --- a/drivers/xen/pci.c
>>>>> +++ b/drivers/xen/pci.c
>>>>> @@ -177,6 +177,18 @@ static int xen_remove_device(struct device *dev)
>>>>>  	return r;
>>>>>  }
>>>>>  
>>>>> +int xen_reset_device_state(const struct pci_dev *dev)
>>>>> +{
>>>>> +	struct physdev_pci_device device = {
>>>>> +		.seg = pci_domain_nr(dev->bus),
>>>>> +		.bus = dev->bus->number,
>>>>> +		.devfn = dev->devfn
>>>>> +	};
>>>>> +
>>>>> +	return HYPERVISOR_physdev_op(PHYSDEVOP_pci_device_state_reset, &device);
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(xen_reset_device_state);
>>>>> +
>>>>>  static int xen_pci_notifier(struct notifier_block *nb,
>>>>>  			    unsigned long action, void *data)
>>>>>  {
>>>>> diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
>>>>> index e34b623e4b41..5a96b6c66c07 100644
>>>>> --- a/drivers/xen/xen-pciback/pci_stub.c
>>>>> +++ b/drivers/xen/xen-pciback/pci_stub.c
>>>>> @@ -421,6 +421,9 @@ static int pcistub_init_device(struct pci_dev *dev)
>>>>>  	else {
>>>>>  		dev_dbg(&dev->dev, "resetting (FLR, D3, etc) the device\n");
>>>>>  		__pci_reset_function_locked(dev);
>>>>> +		err = xen_reset_device_state(dev);
>>>>> +		if (err)
>>>>> +			goto config_release;
>>>>
>>>> Older versions of Xen won't have the hypercall
>>>> PHYSDEVOP_pci_device_state_reset implemented. I think we should do
>>>> something like:
>>>>
>>>> if (err && xen_pvh_domain())
>>>>     goto config_release;
>>>>
>>>>
>>>> Or even:
>>>>
>>>> if (xen_pvh_domain()) {
>>>>     err = xen_reset_device_state(dev);
>>>>     if (err)
>>>>         goto config_release;
>>>> }
>>>>
>>>> depending on whether we want to call xen_reset_device_state also for PV
>>>> guests or not. I am assuming we don't want to error out on failure such
>>>> as -ENOENT for PV guests.
>>> Yes, only for PVH dom0, I will add the condition in next version. Thank you!
>>
>> We will want to call xen_reset_device_state() for Arm dom0, too, so checking xen_pvh_domain() alone is not sufficient. I suggest instead to check !xen_pv_domain().
> I am not using Arm. But is Arm dom0 not a PVH type dom0?

Apparently not, Arm dom0 appears to be a xen_hvm_domain() from the kernel's perspective.

> 
>>
>>>
>>>>
>>>>
>>>>>  		pci_restore_state(dev);
>>>>>  	}
>>>>>  	/* Now disable the device (this also ensures some private device
>>>>> diff --git a/include/xen/interface/physdev.h b/include/xen/interface/physdev.h
>>>>> index a237af867873..231526f80f6c 100644
>>>>> --- a/include/xen/interface/physdev.h
>>>>> +++ b/include/xen/interface/physdev.h
>>>>> @@ -263,6 +263,8 @@ struct physdev_pci_device {
>>>>>      uint8_t devfn;
>>>>>  };
>>>>>  
>>>>> +#define PHYSDEVOP_pci_device_state_reset     32
>>>>> +
>>>>>  #define PHYSDEVOP_DBGP_RESET_PREPARE    1
>>>>>  #define PHYSDEVOP_DBGP_RESET_DONE       2
>>>>>  
>>>>> diff --git a/include/xen/pci.h b/include/xen/pci.h
>>>>> index b8337cf85fd1..b2e2e856efd6 100644
>>>>> --- a/include/xen/pci.h
>>>>> +++ b/include/xen/pci.h
>>>>> @@ -4,10 +4,16 @@
>>>>>  #define __XEN_PCI_H__
>>>>>  
>>>>>  #if defined(CONFIG_XEN_DOM0)
>>>>> +int xen_reset_device_state(const struct pci_dev *dev);
>>>>>  int xen_find_device_domain_owner(struct pci_dev *dev);
>>>>>  int xen_register_device_domain_owner(struct pci_dev *dev, uint16_t domain);
>>>>>  int xen_unregister_device_domain_owner(struct pci_dev *dev);
>>>>>  #else
>>>>> +static inline int xen_reset_device_state(const struct pci_dev *dev)
>>>>> +{
>>>>> +	return -1;
>>>>> +}
>>>>> +
>>>>>  static inline int xen_find_device_domain_owner(struct pci_dev *dev)
>>>>>  {
>>>>>  	return -1;
>>>>> -- 
>>>>> 2.34.1
>>>>>
>>>
> 
