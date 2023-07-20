Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B2275A47F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 04:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjGTCq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 22:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTCqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 22:46:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62062111
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 19:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwEMoaudJenTJ5UVsJHjJGof6bxdjpEOGQbzCO8nMAFIOxQOeYSimKykaYkulqQ7dLI1xSxuP3B7frJqt+HNFQUFZK9jOScPLHqOLY8xAyvA8StM6c1XKewrsUA3tu9CozDh7JfQW1Et4vN5D+j/JPc5+S3EFCy5DODWHQOIXDf1x+tlwDW4o6r+JpFaecDTFkHyvsB2HLdr2GqMORvrvScglM0kzCimEOPPsbxyt0mC/VFyKiAp3xqTvo/GzjDueLqrAaYu0AXNrcAEJvfqlgs2zliTlF9ByWsvHLigSa+HcO+s7aUS3m7/s5R+X+VBLq9hSLtv6WDvSh3ewWEyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeW3HFiQYHUy84qtunjfI/wpCmNeHvxvLYOnZRY22jM=;
 b=N+IJLmxCwJs+M3TxHXSx/T5FEhqnlNdi4pcEj9AzkfVE1THNcIj+jU6h5vPUMPbmvLR1xY/MPsfa9FbEf1TbYRpF7DrBR4MNJWE8iEV53+PvHOS9cz8i33l4FzgsVsATw/B7esJP+ug9wX6/GK4JVcx7lbwmF5lvDbUxY0zkNH2TGqYx9EHLf3PDtpD2SpFGxLq6kTZHk+02So2vN9gnqQqBXx9ExbD+2AkbG3c1Ms+VlYXSjt/nHBNaUlEO9jL4L9XeDfS2a7vQpkRGqppdoi/yyL2QgBaTbUk7uDZmYEqxrDCvERGMhk+Yz4h7mlnaBCaRO2Y1QtweC3WgSV/lWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeW3HFiQYHUy84qtunjfI/wpCmNeHvxvLYOnZRY22jM=;
 b=YfIZyF7EwisnUhtS9thBI2/nZrbldGwwhp1Mv9K3xVtebsxwaZ3u94mi2CO1XaPGfCZ12jKkh9VpC+s/WA65jZbn4TF6NsVw9Yyj63Bp45qRd8Kdb9ZtNQx481zVZY/hw1E6+mvwGKRogu+VgnqnJUjhT9e7eq/d7aWE5xiHpt4lSGW8QT2FanQXkr9f5+cD7jw7cabFHSehaqfoTb1hvLNxnvyQrvtqKGao1pKxdwQ/HVPHgXlvur1crnxCBbdl45q6n2J5eKdri2+DatZsEPBMm6HAYt7rHDoSr7nD+UUrlZ5SXLh2KjPW5L/FoLw51hF/JiU6Hlqx/gX196klTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by CYYPR12MB8992.namprd12.prod.outlook.com (2603:10b6:930:bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 02:46:21 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260%4]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 02:46:21 +0000
Message-ID: <056393df-2ce5-f636-4d84-50b2c64b10d5@nvidia.com>
Date:   Wed, 19 Jul 2023 22:46:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v1] virtio-pci: Fix legacy device flag setting error in
 probe
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Bodong Wang <bodong@nvidia.com>,
        Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
References: <20230719154550.79536-1-feliu@nvidia.com>
 <CACGkMEv1b698NcpZHxpDoNokWH0gEs07D2eYSAjsiF1efhxORw@mail.gmail.com>
From:   Feng Liu <feliu@nvidia.com>
In-Reply-To: <CACGkMEv1b698NcpZHxpDoNokWH0gEs07D2eYSAjsiF1efhxORw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:806:23::33) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|CYYPR12MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f22c74-56b5-45ba-2d11-08db88cb7fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8BNBa6g+Ji1G12YcvWp7l5DNr/TQ6MnMLNF1sO4wUf3qTaMqE4RESj2xcA24AOvw2YcfhksQKW+mPPHaQspwqzFp1knT89ikCW2/2ZMkscfO5q17mKbsUzQRKbKM8d052pnXhgp321jB6ljx038ldM2v8xkCma2Mic1cqNvyPGc9B/VyEMAQ/O7fpUF8mcEbQEiuGLAPUms9FK/PDbYSBRoKemDcUZ9o7J+OUVaNqCeGH8764tBalyVKVW5XDg/uU1yEfHDRCPFDqueP7e5qEkMkDQYwPDt6WtzuKGmRmknLYVeHIhCtM0pcpvNXLEfKBg6TyrZKnlMZv45hjULEeF1pmr5n8niKNSeBXa0tMeXvbooLzYaVsWXn3bA91BsEC8g7ZEw16FfjewcZxVOCKyKCZvxbjLA3JTTXJokp3Le8Cmga3fcq6HQFlTyct9ssg684ibID46A7/kDTLiFDEaC7MLYWUP7QoK0zzc7WEKPg3IM+I/yqQQ8UEsiEePDqsL/S4SlCFIA9zNmvwQ9C1BOHD4mhJWiHoymdwRD4oruyzot8FikaDtXwaT4wGtE88FMRTUTT/OmLRhyqdGs/I+tb+JRYOjHwXhm+JdJe8kKQkzRJgL2wLIpccdmz9jIkBYx0+FR4Aefbpyi0pkkBKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(66556008)(54906003)(478600001)(6666004)(6486002)(107886003)(36756003)(186003)(316002)(6512007)(2616005)(2906002)(6506007)(5660300002)(38100700002)(66946007)(8936002)(66476007)(4326008)(41300700001)(8676002)(6916009)(26005)(31696002)(83380400001)(86362001)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTdxRzRpcWZhMnllTkFQZEh2ejQ3MU91OWpEb1E0NG9sVDRuQnNVK0lseXBt?=
 =?utf-8?B?bTM0WCtQeGxNQ0V3ZmNmNWY5MGgxUWJRQS9BM0FCdEU3VEUvaDYvSUxXaE1y?=
 =?utf-8?B?azNHTU1xK0lzTFVHUVhLR2kvMlRCdHNlRUlCYWFIa09vMW1OQVV3SHZmclVH?=
 =?utf-8?B?bHI5SVJ6UGNybUhBazF1R0FRV2orTnpDc0NtUS85VldhbHlzNDQyVEtNSVZh?=
 =?utf-8?B?UWI1VmdnQWl2U0JzYUVsN2lCQ2wwcWhITXB6T0VNSUZqZ3RaOUNCZkx4MmNx?=
 =?utf-8?B?SU4vdlA2RnQvK3ErT0Njbk1RT1FmQzRJZ3hyVTY4VG40WGVnMUxQWG5SYWFN?=
 =?utf-8?B?OS94QWkwTGQ3RXBXSFRxQk9JcEhmYkJBc2hCb3kzclNwQ3EzQTBOZDVFQVV3?=
 =?utf-8?B?akV3S0ZrWU1LMTRFbjZNblg2cVlDVnNyZ2U5WGN5cHFqYXlucVE2T0VFc2pV?=
 =?utf-8?B?OFBRWkhuOC9OR0dFRHlDcmFEUUVKQWsrUjBkT2dEbnBLRW81MFpCRnRiRUx5?=
 =?utf-8?B?Ym1hbHhCakVadThEYkVXNmdoV2k4OGx5ODFxRmg2clQwa096b29FNGVjNlh3?=
 =?utf-8?B?OCtoRStEbFYwVCtqRVJTNDd6dU0vRHpuZlZaaG93dUxPVFl4dzRDTUJwazYw?=
 =?utf-8?B?bnk1TldySEdxNzh1dmRnWkRLUnpMN291MHdrN2VUOGw3QkJ1Z3Z3aVllaTFs?=
 =?utf-8?B?UFozNTJsZlRYcTZMS0pxRWZkVWVldVkyb1o0M2NYM0FrVERBTGhIaElLTTll?=
 =?utf-8?B?c2FHcG5aN3VFaXp4UVhORnJYN3hmUDZRQ0x6TkZHdDllNnBERllnMDBKTzBL?=
 =?utf-8?B?OUM3ckt1aG9MeGpGV0JlVlNLV2VLUGZEbDYxeVR0bTg2MStYTHB2c3Y4NE5U?=
 =?utf-8?B?QTI4RThDOGhOUHZRK1VGK1oweXV1Um0wekY2VlYxYUwxbGZYdE16VFpPTUFq?=
 =?utf-8?B?aHFSVzlHMTVNMENlV0RhOXpyWFlFeXZCRTJuU0NWNVMrWmplU0oxY2Z3SDBk?=
 =?utf-8?B?Zm9LTm5HdlVUTnFlS1U3ZjFNQnhBUDRkMjM5Sys1b0E0SUR1UHZTcTh2YXNJ?=
 =?utf-8?B?aTJtN3pLV1pwT3ZIVGJ0ZzhzSEYrWEtIV0hjc250SEl4Q3RZVTI3WUx6d3J2?=
 =?utf-8?B?ZDdwNEo4b01zMi9uY2cwbU9uQjFxcTNjQnFsMzVBaEN5azd0algyMVpmdWRQ?=
 =?utf-8?B?SWgxUmlITXNXOTYzS20rRkh3VEVTY2g2UERRekM0NWd2N0hJRVg5OWZMdzVP?=
 =?utf-8?B?RzZsMnZOR1N1cmh4b2J2SVJiekIzRFRzMU0vRjBiRmc4TzRYak16SldQK1Rm?=
 =?utf-8?B?VkxDYjRKNXRSRWRPZWc1K2dzRDdMRXhoa3V3TmdyUDViNys1OW5yY0xkSEc1?=
 =?utf-8?B?ODBFb2taK2VodmRzWkpEc1h4NjV4UzNRSnRJMFVXcWk2eW9TeVJKZ2RxMDNP?=
 =?utf-8?B?VkZqemNRYW0yQXZIVUN2OEN4aHBaaGNYamZuV2d3Y0tZRE5pMTNnZG0yMm5T?=
 =?utf-8?B?RVI0eW4wR3BFdXpmSzdXSE5kTG9WaGxaeldPK05JYmlZNEVZTUdZSEhHVC9F?=
 =?utf-8?B?eXQwU1JzaTVIS016a1BPRSttcU4vbE83QzlOZ2hBdGlRN0ZDcVpleDl5SHQx?=
 =?utf-8?B?NSszNzczN2JXaXE4dG1IaWEzZ0ZZQjEwQUxKVTMzUDl5Yk1SMnI2cXBsT0xo?=
 =?utf-8?B?SEwvTktBaU12Q21LVE5hTG4vWG05OHFaa2xndnlLYjNkNEVvWCtGZjRQM1U3?=
 =?utf-8?B?Y2ozNzR4anh2UnJVWnRqRnhBNC9pdDZQZmNabFpyV1U0QkZ2Y0pUZk44UE5Y?=
 =?utf-8?B?cXVSZExFS3JkYiswUE9kbFJmNi9pU0s2ajNuRERpZTNlVjE5bVl2eXl6eHFR?=
 =?utf-8?B?OHU1Q1AzQlBQZlg4SG56YzV2YkJYYzFHTWxWK09Yd1pXM1F5KzE0RS9Ma3o2?=
 =?utf-8?B?TXVEKzJvT1V0RXUwSERCdFB4UldRZm5ralEwZVUzeW9McUJ1dkN3TGxIOHNB?=
 =?utf-8?B?dGJqN0dRRUc3KzJ0dzY4aDlreTVYOXIvZklLZCt2Q2pBajRJOVI5VFhvaVZZ?=
 =?utf-8?B?OVRSclZtSjlhWDY4Mk1hRldFeUZDSHZ1cEZCaU1KdWtXMGhtbjAwanpGTHdn?=
 =?utf-8?Q?IvZSbq9Xvxj6MKC1kxQ6JL/u/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f22c74-56b5-45ba-2d11-08db88cb7fc4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 02:46:20.7749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ybdd9m0C0cbs+CvM++zX+S8Y555gsz+ODQ1pFbNOD2IF2I08aDxmplWzrw6f/xQObWzk+Ku9ukyvhxduPPCYzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8992
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-07-19 p.m.10:27, Jason Wang wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Jul 19, 2023 at 11:46 PM Feng Liu <feliu@nvidia.com> wrote:
>>
>> The 'is_legacy' flag is used to differentiate between legacy vs modern
>> device. Currently, it is based on the value of vp_dev->ldev.ioaddr.
>> However, due to the shared memory of the union between struct
>> virtio_pci_legacy_device and struct virtio_pci_modern_device, when
>> virtio_pci_modern_probe modifies the content of struct
>> virtio_pci_modern_device, it affects the content of struct
>> virtio_pci_legacy_device, and ldev.ioaddr is no longer zero, causing
>> the 'is_legacy' flag to be set as true. To resolve issue, when legacy
>> device is probed, mark 'is_legacy' as true, when modern device is
>> probed, keep 'is_legacy' as false.
>>
>> Fixes: 4f0fc22534e3 ("virtio_pci: Optimize virtio_pci_device structure size")
>> Signed-off-by: Feng Liu <feliu@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>   drivers/virtio/virtio_pci_common.c | 2 --
>>   drivers/virtio/virtio_pci_legacy.c | 1 +
>>   2 files changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>> index a6c86f916dbd..c2524a7207cf 100644
>> --- a/drivers/virtio/virtio_pci_common.c
>> +++ b/drivers/virtio/virtio_pci_common.c
>> @@ -557,8 +557,6 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>>
>>          pci_set_master(pci_dev);
>>
>> -       vp_dev->is_legacy = vp_dev->ldev.ioaddr ? true : false;
>> -
>>          rc = register_virtio_device(&vp_dev->vdev);
>>          reg_dev = vp_dev;
>>          if (rc)
>> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
>> index 2257f1b3d8ae..d9cbb02b35a1 100644
>> --- a/drivers/virtio/virtio_pci_legacy.c
>> +++ b/drivers/virtio/virtio_pci_legacy.c
>> @@ -223,6 +223,7 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
>>          vp_dev->config_vector = vp_config_vector;
>>          vp_dev->setup_vq = setup_vq;
>>          vp_dev->del_vq = del_vq;
>> +       vp_dev->is_legacy = true;
> 
> This seems break force_legacy for modern device:
> 
>          if (force_legacy) {
>                  rc = virtio_pci_legacy_probe(vp_dev);
>                  /* Also try modern mode if we can't map BAR0 (no IO space). */
>                  if (rc == -ENODEV || rc == -ENOMEM)
>                          rc = virtio_pci_modern_probe(vp_dev);
> 
> Thanks
> 
Will do, thanks

>>
>>          return 0;
>>   }
>> --
>> 2.37.1 (Apple Git-137.1)
>>
> 
