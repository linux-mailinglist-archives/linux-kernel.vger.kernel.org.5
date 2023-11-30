Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54007FF325
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346043AbjK3PDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbjK3PDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:03:09 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6CED48;
        Thu, 30 Nov 2023 07:03:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuXxCCq93TEs+cYSdr60I22HQfUnnoKryJ3HAmvy+lkYS7KRa7bvT9HUaHIHk3R7LmhrFF4RIr2QpOzw9kKY06u2/88wLiYmxnyNkUv4BOCXY/DCxmZDVdTi/m42vEEeSnqcpSjL+Q3n/UzSzzUxFK03J3y/I/GE/SFbVrJNK2h3J3YyzfJuijvlz1XavrUuD2xL8TlFH/zBg51zc6Cu8seSYB4TrKreiNejvmctPqfglrQZ7K9jW93liagvMLqtWHX1r8NvVYtLH/9/xbK9h34AvtwKdtyA9uJYJCCRX/8UG2Mi1u0ZF7/emZBEpbcp+93qVcIGyID4/xwB9sxIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBFIVtiQXa0sNx/4VzJnx+rOix4DIGI+pZcFJLf3UZw=;
 b=ZuaUS0uxj68MnNbglX1WG9af5nVMtnfzFVYl9HGNf0LIHCDMbbR2fLgJtWSrtCGSdE+q3qYn81IAddJX7ptJad9MpYrXIbvWlrQiDYrv5f/DjYsLL0LB2n+5Ey0hIGjTqD4xDEv4T7R1m3+V3Wtzn7vEqz0mxDcMW9CjBvGW5xlCjciNGVEaNUUl711YlDM1kf4pUgwivaE8OZpZck2uQjqn1hIuMeieV1dZ+/6Dj9OS1Gl+FVBUHhKfp/qDSY4C5R/tKiY2rdXZ8voZmpAtErZR2xgW9uHW0L+BoF03OSoEgIkPehVbofQxrJk4IlcMcmlqM0bIknr5cXmRYTtZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBFIVtiQXa0sNx/4VzJnx+rOix4DIGI+pZcFJLf3UZw=;
 b=r0Ras1tkhSDJVNk+S8BIv8KY1eqp9ZB61akeaVyeDaQWKJYUb3wGiIU8WSWtexrhex3RKznrjJb7lCX5sbxoAiFAnPIhc3aS+aTUh8QUOPPIfcwV7Wd0SrOY5ygboUIC2cRveJ3OfYeX/HSrHR10Ug8GcqYS/URiqpG29G010s4=
Received: from CH0PR03CA0085.namprd03.prod.outlook.com (2603:10b6:610:cc::30)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 15:03:11 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::a7) by CH0PR03CA0085.outlook.office365.com
 (2603:10b6:610:cc::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Thu, 30 Nov 2023 15:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 15:03:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 09:03:07 -0600
Received: from [172.27.137.28] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 30 Nov 2023 09:03:04 -0600
Message-ID: <f78395f3-6588-4bc9-8612-3450a8f44be7@amd.com>
Date:   Thu, 30 Nov 2023 10:03:02 -0500
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
From:   Stewart Hildebrand <stewart.hildebrand@amd.com>
In-Reply-To: <BL1PR12MB58490EB260D226500141557EE782A@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c753df2-6631-4fdb-5150-08dbf1b57823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vqNgQS6+MyAmGysQyzTvULI2XB9tcAY7ALXeSWoFkM+jhBkNSccCU6PvqCnnKB51BcVkpiBqrwGwi8T0NVI51dDQHZOBHHWI8SOHMrw9ffY8AoOe6I21mvDRaovgrSnKgMRUaU4pPUulyB6Nh6cxSZ07QiJleHlMCsFr3Yj6Bv020ouNNLCIh4oLh732ZlWl2Sxx4WfF3Eb07wwwkwJC6GrIqNfyh2qQcr4wzzRZWucQK6YB0xwUYyVzcFrwxwHgIRpWRvxuKIiMR46jD+1GeHdRDJeux6U0YxlUGfQ2pjtDL+5+92Hj7VuGZISnDnyjHYb9cz9cYHA8P04yQkOnGa7NkckVGuVixHPcogly74Vp/87Pv5IuhyNC2+KyNt2vC4JY0rflMghsHLaGHGUakBXv6SLOZVub4nAFkDiPnA4+VXhalzfEkKNZdITnKVU15YeLHXRQN2fdOTZ+dcD+Lb5PB2zeRkJEKom+k/vXX3gWghwCY9IDmD4BJZB71oLuy8xvTCpHreJNxNXamY5YX1OT8+HYbwDe6sOfgQUa9pACrhgDd2ZkC/ffoO06EE8jHu1XIImIxNfaD1lQ9XMGl8Nl030V/wANPLojhqOoGoW6iDqwt0PoncQZRbJrMy/6/pCajd2dVVL+jEO1Xof9/iK6ikkZR6NwZ920lPi/YgPxIwyY+Jx/YDHuZH/PyaQlhM7boQzbR/QSRIyiNmpKJis8EXzGuhHLh0KF3KaSC6eXRQE7EVChoE0GbjmP3Xu5w7UcIqtYap0iSbC/wKFPeirW+1b2GDxS5YQUQ/deHDiUieAFrNgR8faYvwQRyA+lHhmfkpxBYCCD+dnyi+Bx17Slu8o4NZkSkGprRZqJz50=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799012)(46966006)(36840700001)(40470700004)(31686004)(40460700003)(40480700001)(2616005)(478600001)(53546011)(336012)(47076005)(26005)(36860700001)(356005)(81166007)(86362001)(36756003)(82740400003)(31696002)(70586007)(5660300002)(70206006)(44832011)(54906003)(41300700001)(426003)(7416002)(2906002)(83380400001)(4326008)(8676002)(316002)(8936002)(110136005)(16576012)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 15:03:10.9230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c753df2-6631-4fdb-5150-08dbf1b57823
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/23 02:03, Chen, Jiqian wrote:
> 
> On 2023/11/30 11:46, Stefano Stabellini wrote:
>> On Fri, 24 Nov 2023, Jiqian Chen wrote:
>>> When device on dom0 side has been reset, the vpci on Xen side
>>> won't get notification, so that the cached state in vpci is
>>> all out of date with the real device state.
>>> To solve that problem, this patch add a function to clear all
>>> vpci device state when device is reset on dom0 side.
>>>
>>> And call that function in pcistub_init_device. Because when
>>> we use "pci-assignable-add" to assign a passthrough device in
>>> Xen, it will reset passthrough device and the vpci state will
>>> out of date, and then device will fail to restore bar state.
>>>
>>> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>>> ---
>>>  drivers/xen/pci.c                  | 12 ++++++++++++
>>>  drivers/xen/xen-pciback/pci_stub.c |  3 +++
>>>  include/xen/interface/physdev.h    |  2 ++
>>>  include/xen/pci.h                  |  6 ++++++
>>>  4 files changed, 23 insertions(+)
>>>
>>> diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
>>> index 72d4e3f193af..e9b30bc09139 100644
>>> --- a/drivers/xen/pci.c
>>> +++ b/drivers/xen/pci.c
>>> @@ -177,6 +177,18 @@ static int xen_remove_device(struct device *dev)
>>>  	return r;
>>>  }
>>>  
>>> +int xen_reset_device_state(const struct pci_dev *dev)
>>> +{
>>> +	struct physdev_pci_device device = {
>>> +		.seg = pci_domain_nr(dev->bus),
>>> +		.bus = dev->bus->number,
>>> +		.devfn = dev->devfn
>>> +	};
>>> +
>>> +	return HYPERVISOR_physdev_op(PHYSDEVOP_pci_device_state_reset, &device);
>>> +}
>>> +EXPORT_SYMBOL_GPL(xen_reset_device_state);
>>> +
>>>  static int xen_pci_notifier(struct notifier_block *nb,
>>>  			    unsigned long action, void *data)
>>>  {
>>> diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
>>> index e34b623e4b41..5a96b6c66c07 100644
>>> --- a/drivers/xen/xen-pciback/pci_stub.c
>>> +++ b/drivers/xen/xen-pciback/pci_stub.c
>>> @@ -421,6 +421,9 @@ static int pcistub_init_device(struct pci_dev *dev)
>>>  	else {
>>>  		dev_dbg(&dev->dev, "resetting (FLR, D3, etc) the device\n");
>>>  		__pci_reset_function_locked(dev);
>>> +		err = xen_reset_device_state(dev);
>>> +		if (err)
>>> +			goto config_release;
>>
>> Older versions of Xen won't have the hypercall
>> PHYSDEVOP_pci_device_state_reset implemented. I think we should do
>> something like:
>>
>> if (err && xen_pvh_domain())
>>     goto config_release;
>>
>>
>> Or even:
>>
>> if (xen_pvh_domain()) {
>>     err = xen_reset_device_state(dev);
>>     if (err)
>>         goto config_release;
>> }
>>
>> depending on whether we want to call xen_reset_device_state also for PV
>> guests or not. I am assuming we don't want to error out on failure such
>> as -ENOENT for PV guests.
> Yes, only for PVH dom0, I will add the condition in next version. Thank you!

We will want to call xen_reset_device_state() for Arm dom0, too, so checking xen_pvh_domain() alone is not sufficient. I suggest instead to check !xen_pv_domain().

> 
>>
>>
>>>  		pci_restore_state(dev);
>>>  	}
>>>  	/* Now disable the device (this also ensures some private device
>>> diff --git a/include/xen/interface/physdev.h b/include/xen/interface/physdev.h
>>> index a237af867873..231526f80f6c 100644
>>> --- a/include/xen/interface/physdev.h
>>> +++ b/include/xen/interface/physdev.h
>>> @@ -263,6 +263,8 @@ struct physdev_pci_device {
>>>      uint8_t devfn;
>>>  };
>>>  
>>> +#define PHYSDEVOP_pci_device_state_reset     32
>>> +
>>>  #define PHYSDEVOP_DBGP_RESET_PREPARE    1
>>>  #define PHYSDEVOP_DBGP_RESET_DONE       2
>>>  
>>> diff --git a/include/xen/pci.h b/include/xen/pci.h
>>> index b8337cf85fd1..b2e2e856efd6 100644
>>> --- a/include/xen/pci.h
>>> +++ b/include/xen/pci.h
>>> @@ -4,10 +4,16 @@
>>>  #define __XEN_PCI_H__
>>>  
>>>  #if defined(CONFIG_XEN_DOM0)
>>> +int xen_reset_device_state(const struct pci_dev *dev);
>>>  int xen_find_device_domain_owner(struct pci_dev *dev);
>>>  int xen_register_device_domain_owner(struct pci_dev *dev, uint16_t domain);
>>>  int xen_unregister_device_domain_owner(struct pci_dev *dev);
>>>  #else
>>> +static inline int xen_reset_device_state(const struct pci_dev *dev)
>>> +{
>>> +	return -1;
>>> +}
>>> +
>>>  static inline int xen_find_device_domain_owner(struct pci_dev *dev)
>>>  {
>>>  	return -1;
>>> -- 
>>> 2.34.1
>>>
> 
