Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0E479FD23
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjINHTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjINHTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:19:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5945791;
        Thu, 14 Sep 2023 00:19:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPKYlpT+nyrai28ZieB+TpLde+qwpmTypSgNOlUYSTRCamRN1DSYymezH13td6yTM/Urj6EUhpxLZcMDag13EBI9fAYdIK7DWgpJPUF0zWGDTie62ChiwWWq50DWOS4j2d1GZ4iEG+wh6jON4QAn7WDsy+NQJcrAvRCHmVX0eaaF7Qwycg8Oyl1TzXcpTG0ohRq+eVSBex0hj9kF2mP884kUJJ2p2ZgQc4i7tuReJobzAe68V2cWrFme8ehGIuJPxALvT/xOwaqeUPcjXBRDCYUyIF1QeZfIsWqWwS2Wh28Z5AS4fpruD/z6IRLjOx4/R3G90Xq97nybhOdcGwjIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EKRXBk7rXYl3krFqB2ugFZ7t/smHoqT7ZZTeb789RA=;
 b=L6xY294OxxdKotZXbc/a1ku6Ip+RKgBjn2PL2X9+Opfze6c6XYXtPDX7CNBNqkc8Af/nrWsOoeWsFc6el2J+pwZ3DDe1xOTsa9hfmj/LrT7rB+q2bTixRVtOwaCZ+zw5r+TPrqgrrJ3j4UABvfiBwHgTZ5apNI1+vD4gpo4N7lCmm3bPEXuteDan6fOu3AvcA2IHNBFHJ8uzk5tehlQfM85tOg7O0vyES9jAADWyuD1yoCEf7QhwSEMF6XjBkc/WKGKL7TvhpH9kf542t0PBDWkvNeXejIDXNMnbpWo6uncEOKCNSXeHoUxknJSEN9OWi+IJRHSIxjKcfaqv84UoYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EKRXBk7rXYl3krFqB2ugFZ7t/smHoqT7ZZTeb789RA=;
 b=kLdcpINa98Nn9DXIlBM3P9yYD6ONLCpP3xYcIlmnLjDhMzb6ynG27ZG/ArXXxhUlLTvHF70C8Xtw+48M/wXmeKpEdFUHEfT23HUuBD9NA4OPb5pVDl8AjtxacbZUd67iCledm443BulQC/W/hr5ja1SeJ+l055hL4AqDU125Rn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24)
 by DM4PR12MB8450.namprd12.prod.outlook.com (2603:10b6:8:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Thu, 14 Sep
 2023 07:19:14 +0000
Received: from CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::b009:6291:f87a:33b6]) by CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::b009:6291:f87a:33b6%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 07:19:13 +0000
Message-ID: <f19e0cd4-0b2a-5075-44a9-961bc78a1bb8@amd.com>
Date:   Thu, 14 Sep 2023 12:48:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/5] crypto: ccp: Move direct access to some PSP registers
 out of TEE
To:     Mario Limonciello <mario.limonciello@amd.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     thomas.lendacky@amd.com, john.allen@amd.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230907184846.47598-1-mario.limonciello@amd.com>
 <20230907184846.47598-2-mario.limonciello@amd.com>
Content-Language: en-US
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
In-Reply-To: <20230907184846.47598-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0223.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::16) To CH0PR12MB5346.namprd12.prod.outlook.com
 (2603:10b6:610:d5::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5346:EE_|DM4PR12MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: c29fa54a-f041-48de-b639-08dbb4f2e58c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJfU5dj8N9/4eW9zXy7n9pk7Q6X5imMGzEnD7iN3hd3TQ0wAjQGuHTtNMUzerRnpl3mpVlZn6i5sZgHB8JcuN/ABxgxNdvTUFUkLaDhQMtkYGFShW6Dlk4PvTcE94nQZ5ONJTAu3qQsUfzfOAq7NlWI/T/V0Ga+83T5pbTKYxaCguAQwekDez9gHO6NpeguDIZ2+Kl0vkdGybzou6EO2xXprI3lj3tE3hVXBjPl9LoKwvLNe+veyF4HbmiQSnaFqkTCGufD9sEgeI6nxOeP5qimebqGC+YEmkTHf+qGqTUa5Hkp9G8ibp1L0GV36H7pn2iBfqT41mciydpIgmnImzT3J6Q8sumNS1+6PasvhOfeCacSmRAxW5Rh8hGYIXO4kObeHFsNoaZNZEIIcTrL9VrCv2PgLPhHpBsVwWyUM28gZQno1Kz4lS8cjJQzpTiXVx98vJ2dt8cqv7QidbvckCJbr3KCgd2UrdxccR+mM+9dTZIl5hcJMXT2UBqE9nZhsTtrxnus+fhPAJ9dsb9cedvLsxy0Axjs1P+k4P4qzoSPai+ySVeCDGMk6sJNIx+046qlSZpLSXKGF+dXWUIz04rNZeiFeI2DXglw/JUNOucP0pExisiZXXeN79jMWl9EIJ+XAF2G1LyXOWp7g+2qOcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5346.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(186009)(1800799009)(451199024)(6666004)(53546011)(36756003)(6512007)(6506007)(6486002)(478600001)(38100700002)(4326008)(8676002)(2616005)(5660300002)(41300700001)(8936002)(316002)(66476007)(66946007)(26005)(83380400001)(66556008)(31686004)(30864003)(2906002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODZIaXRTbXlMK2lkelVQNGovclpZaUpWUDdnN0tzS3NPUnM5Tk9TWC9tYTdH?=
 =?utf-8?B?Vi9ZUnJsb0dQZ2pOZHBhQklvcWxwZVYxWHNQanlxNE0yUllVL1pwVlhoYkVq?=
 =?utf-8?B?VDJpR1ZhZllrL003VUUwTnpoamw0R29HcVphZU5tcTQxaTdKKytrdUZqZ3Fw?=
 =?utf-8?B?NkM5Z1FyMStYNE5MLzBMOHBTaThoUzhEMGk4c09DNktGQmJDajFuNmRtVnRW?=
 =?utf-8?B?YmtVcitVeFJUMFNjVnJQOVptVTdJSzJwT1pmM1FSWndkMWYxU2RERXpPM1Ur?=
 =?utf-8?B?OWJ3STlFRHhZN2lXUWhWenk3N0FmQVhWa1Nkdm4vSmNMZ0ZUZW1ESFVia0sv?=
 =?utf-8?B?RHM4dGppSVQwZEx6ZGdqOUcraUd6ZGkzdy8vbDZ6bkY4ZXJOd2ZadWhKOXp2?=
 =?utf-8?B?T21wVkRqWHFFVnkzZ2pXU01aY0pwVWhhOVUxdnBEanNJV3ZETXU1VkJpVDd4?=
 =?utf-8?B?cGJKWklXaTJXamdLWjhmUGJ4d2tzWHhjbGhTMVh6TStkQWxmNE9lbmlHbnlS?=
 =?utf-8?B?TUhabWJSZGdXTDNLaDFQVzhpUVRMVndlM2E1Qk40Vk5kYitMMHpMaUx1Zzl1?=
 =?utf-8?B?OHdGU0VjOW5NU3huME9rZDN5Q0hXT29Fajc5eC9BMExEekpWN1B0bUVYa05l?=
 =?utf-8?B?RFJ5RG9pRmRsaTRYOEV4RUgzSk9QdUJVRE9Cc1Q4bGtjVm8vb3kxa04yUlM2?=
 =?utf-8?B?VUJKbDUvajF6blp4Y1ZTb1dJTGcxOEh4d1ZyclkzS2UySXIyR2djSVovWlFZ?=
 =?utf-8?B?bFdEU0ZsdWdlOTV2M1dycnRTb1JGTWc0NnZIV1NuL3NXSlJhL2NNOC9vdjkw?=
 =?utf-8?B?THo3em9wOXR6ckgvcUh6WjU1d08vVlZvK0xiRkh5YmZzb2NsVWV5Tm5uMTc1?=
 =?utf-8?B?NUtzSy9QbWJxbGRPVTNDMjR6UDExNkhqa040U2MzN2dFUVhnUVMwMFJBS3c1?=
 =?utf-8?B?ZzhpTk1DajJqSXdLSTJRQnF3QWt0RHhPdGhPM1U3SllhVnA4M0cwREc2MFF3?=
 =?utf-8?B?OTgwZkVEWUhmZGJ0SUdONGFJNDVUaDRLRWc1REtMaHpvNDVVbVFwUDZPelI1?=
 =?utf-8?B?RjZVUVZVVUpoVkRmUkRYZ3RLTng1RzlzTWVtL2haWllaMG1GRFJOU1dHQXlp?=
 =?utf-8?B?NndzRS9HY2x4anNHejYybkVsU1JFeGFBMmpEZ0g0TFpFb0tpRGo3N0NpcFhZ?=
 =?utf-8?B?TkFncWJHYnc5dW43Rzd3clJ1SUkvR3FXLzl5OHB4b1RueEd0aGpJVHRwbVBE?=
 =?utf-8?B?d2FTNkthcXduK1NkZXlnRWxQeEx5MERXQlcwbk5ncnROZTBOY2JFaGZZOGp0?=
 =?utf-8?B?eW9HNmt5UG9JWXBLZnJCenB3QUpua1JEMDQzdXBoclpFQjc2c0V0Um5WSG1L?=
 =?utf-8?B?MmRJaHRmYm5iOFN0bStBYlFlZEg0L3FHUWJ2ZUN1SkFsQjh4bUk4RVJnUUdu?=
 =?utf-8?B?WEErRmdReVJyQVhGOUZXdEdaTVhsMGhvbHdwVWRXQWdrR0xTMTJHcE91b3pO?=
 =?utf-8?B?SXBCaW02YTVKRHhXVFBnU003ZXg0UDZUMVdweE1HVGxZUnFHVWlidy9weDIw?=
 =?utf-8?B?UWJEWi9NZE1ncHFrekpBNEM1cHFUMmY3SG1xQnFmU1ZteisvU2Q0aUZSTUdU?=
 =?utf-8?B?eFhLd09PL2pid3IzRE9CVVhsMmY1WERrZnFSQnJPcjEvODNPcmpWTWZIKzRW?=
 =?utf-8?B?SDNZTTNYU3ZpbE92dEkvblRlSjdvVG1xTmZxcnlYOWhrTnhNUndxS2xuOXY2?=
 =?utf-8?B?VCt0TnM1LzN1UWp1dFBxaFFJNDhTSlhXZ3Q4RmtidTFid2xuRFhtMTk0Yi93?=
 =?utf-8?B?SjZlY3h0aTQvRzJpcW1Jd2hJWld2a29iOVBDOUZrc01LL1NpdnVVSTRTcjZy?=
 =?utf-8?B?QnVScC9tRE5VTmg2R3NrR0FSOHczU25FVjd0b00vNDdXYU9pM1UrL1pBRnpK?=
 =?utf-8?B?Z1ZWQlNVWkgxbmwrSWZpTXpKKzlvWlhhZWxqWm53VDZ4cEVteDFZc3hweXNN?=
 =?utf-8?B?WTdWNEZZMFRYSHJZYWR5MU1sRVViYzlCUFlhWmpYZGtrVjREeG5QcVdpeU5X?=
 =?utf-8?B?UmtIUkhtanFMUm5NcysrUUtaL25VYUxRemQ3dGZaSGFRM1ZOM2tiMjRYdUN0?=
 =?utf-8?Q?ihNbazst9hehEZWpKHsrrE48T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c29fa54a-f041-48de-b639-08dbb4f2e58c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5346.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 07:19:13.3099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66xPCY08OQPASIFLLef31PwS6dRxsQcwAM4Tbc4ZNd4QSxJCB4iJ6iQMf9ujLUDPiDO6EeJhSXU449kxRIX8vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8450
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2023 12:18 AM, Mario Limonciello wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> With the PSP mailbox registers supporting more than just TEE, access to
> them must be maintained and serialized by the PSP device support. Remove
> TEE support direct access and create an interface in the PSP support
> where the register access can be controlled/serialized.
> 

Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
Tested-by: Rijo Thomas <Rijo-john.Thomas@amd.com>

> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/crypto/ccp/psp-dev.c | 60 ++++++++++++++++++++++++++++++++++++
>  drivers/crypto/ccp/psp-dev.h | 18 +++++++++++
>  drivers/crypto/ccp/sp-dev.h  |  3 ++
>  drivers/crypto/ccp/sp-pci.c  | 18 +++++++----
>  drivers/crypto/ccp/tee-dev.c | 48 ++++++-----------------------
>  drivers/crypto/ccp/tee-dev.h | 15 ++-------
>  6 files changed, 104 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
> index d42d7bc62352..3258c4612e14 100644
> --- a/drivers/crypto/ccp/psp-dev.c
> +++ b/drivers/crypto/ccp/psp-dev.c
> @@ -9,6 +9,9 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/irqreturn.h>
> +#include <linux/mutex.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
>  
>  #include "sp-dev.h"
>  #include "psp-dev.h"
> @@ -19,6 +22,62 @@
>  
>  struct psp_device *psp_master;
>  
> +#define PSP_C2PMSG_17_CMDRESP_CMD	GENMASK(19, 16)
> +
> +static int psp_mailbox_poll(const void __iomem *cmdresp_reg, unsigned int *cmdresp,
> +			    unsigned int timeout_msecs)
> +{
> +	while (true) {
> +		*cmdresp = ioread32(cmdresp_reg);
> +		if (FIELD_GET(PSP_CMDRESP_RESP, *cmdresp))
> +			return 0;
> +
> +		if (!timeout_msecs--)
> +			break;
> +
> +		usleep_range(1000, 1100);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +int psp_mailbox_command(struct psp_device *psp, enum psp_cmd cmd, void *cmdbuff,
> +			unsigned int timeout_msecs, unsigned int *cmdresp)
> +{
> +	void __iomem *cmdresp_reg, *cmdbuff_lo_reg, *cmdbuff_hi_reg;
> +	int ret;
> +
> +	if (!psp || !psp->vdata || !psp->vdata->cmdresp_reg ||
> +	    !psp->vdata->cmdbuff_addr_lo_reg || !psp->vdata->cmdbuff_addr_hi_reg)
> +		return -ENODEV;
> +
> +	cmdresp_reg    = psp->io_regs + psp->vdata->cmdresp_reg;
> +	cmdbuff_lo_reg = psp->io_regs + psp->vdata->cmdbuff_addr_lo_reg;
> +	cmdbuff_hi_reg = psp->io_regs + psp->vdata->cmdbuff_addr_hi_reg;
> +
> +	mutex_lock(&psp->mailbox_mutex);
> +
> +	/* Ensure mailbox is ready for a command */
> +	ret = -EBUSY;
> +	if (psp_mailbox_poll(cmdresp_reg, cmdresp, 0))
> +		goto unlock;
> +
> +	if (cmdbuff) {
> +		iowrite32(lower_32_bits(__psp_pa(cmdbuff)), cmdbuff_lo_reg);
> +		iowrite32(upper_32_bits(__psp_pa(cmdbuff)), cmdbuff_hi_reg);
> +	}
> +
> +	*cmdresp = FIELD_PREP(PSP_C2PMSG_17_CMDRESP_CMD, cmd);
> +	iowrite32(*cmdresp, cmdresp_reg);
> +
> +	ret = psp_mailbox_poll(cmdresp_reg, cmdresp, timeout_msecs);
> +
> +unlock:
> +	mutex_unlock(&psp->mailbox_mutex);
> +
> +	return ret;
> +}
> +
>  static struct psp_device *psp_alloc_struct(struct sp_device *sp)
>  {
>  	struct device *dev = sp->dev;
> @@ -164,6 +223,7 @@ int psp_dev_init(struct sp_device *sp)
>  	}
>  
>  	psp->io_regs = sp->io_map;
> +	mutex_init(&psp->mailbox_mutex);
>  
>  	ret = psp_get_capability(psp);
>  	if (ret)
> diff --git a/drivers/crypto/ccp/psp-dev.h b/drivers/crypto/ccp/psp-dev.h
> index 8a4de69399c5..d917657c6085 100644
> --- a/drivers/crypto/ccp/psp-dev.h
> +++ b/drivers/crypto/ccp/psp-dev.h
> @@ -14,6 +14,8 @@
>  #include <linux/list.h>
>  #include <linux/bits.h>
>  #include <linux/interrupt.h>
> +#include <linux/mutex.h>
> +#include <linux/psp.h>
>  
>  #include "sp-dev.h"
>  
> @@ -33,6 +35,7 @@ struct psp_device {
>  	struct sp_device *sp;
>  
>  	void __iomem *io_regs;
> +	struct mutex mailbox_mutex;
>  
>  	psp_irq_handler_t sev_irq_handler;
>  	void *sev_irq_data;
> @@ -71,4 +74,19 @@ struct psp_device *psp_get_master_device(void);
>  #define PSP_SECURITY_HSP_TPM_AVAILABLE		BIT(10)
>  #define PSP_SECURITY_ROM_ARMOR_ENFORCED		BIT(11)
>  
> +/**
> + * enum psp_cmd - PSP mailbox commands
> + * @PSP_CMD_TEE_RING_INIT:	Initialize TEE ring buffer
> + * @PSP_CMD_TEE_RING_DESTROY:	Destroy TEE ring buffer
> + * @PSP_CMD_MAX:		Maximum command id
> + */
> +enum psp_cmd {
> +	PSP_CMD_TEE_RING_INIT		= 1,
> +	PSP_CMD_TEE_RING_DESTROY	= 2,
> +	PSP_CMD_MAX			= 15,
> +};
> +
> +int psp_mailbox_command(struct psp_device *psp, enum psp_cmd cmd, void *cmdbuff,
> +			unsigned int timeout_msecs, unsigned int *cmdresp);
> +
>  #endif /* __PSP_DEV_H */
> diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
> index 2329ad524b49..c4e125efe6c7 100644
> --- a/drivers/crypto/ccp/sp-dev.h
> +++ b/drivers/crypto/ccp/sp-dev.h
> @@ -71,6 +71,9 @@ struct psp_vdata {
>  	const struct sev_vdata *sev;
>  	const struct tee_vdata *tee;
>  	const struct platform_access_vdata *platform_access;
> +	const unsigned int cmdresp_reg;
> +	const unsigned int cmdbuff_addr_lo_reg;
> +	const unsigned int cmdbuff_addr_hi_reg;
>  	const unsigned int feature_reg;
>  	const unsigned int inten_reg;
>  	const unsigned int intsts_reg;
> diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
> index b6ab56abeb68..d1aedc5c1a68 100644
> --- a/drivers/crypto/ccp/sp-pci.c
> +++ b/drivers/crypto/ccp/sp-pci.c
> @@ -418,18 +418,12 @@ static const struct sev_vdata sevv2 = {
>  };
>  
>  static const struct tee_vdata teev1 = {
> -	.cmdresp_reg		= 0x10544,	/* C2PMSG_17 */
> -	.cmdbuff_addr_lo_reg	= 0x10548,	/* C2PMSG_18 */
> -	.cmdbuff_addr_hi_reg	= 0x1054c,	/* C2PMSG_19 */
>  	.ring_wptr_reg          = 0x10550,	/* C2PMSG_20 */
>  	.ring_rptr_reg          = 0x10554,	/* C2PMSG_21 */
>  	.info_reg		= 0x109e8,	/* C2PMSG_58 */
>  };
>  
>  static const struct tee_vdata teev2 = {
> -	.cmdresp_reg		= 0x10944,	/* C2PMSG_17 */
> -	.cmdbuff_addr_lo_reg	= 0x10948,	/* C2PMSG_18 */
> -	.cmdbuff_addr_hi_reg	= 0x1094c,	/* C2PMSG_19 */
>  	.ring_wptr_reg		= 0x10950,	/* C2PMSG_20 */
>  	.ring_rptr_reg		= 0x10954,	/* C2PMSG_21 */
>  };
> @@ -466,6 +460,9 @@ static const struct psp_vdata pspv2 = {
>  static const struct psp_vdata pspv3 = {
>  	.tee			= &teev1,
>  	.platform_access	= &pa_v1,
> +	.cmdresp_reg		= 0x10544,	/* C2PMSG_17 */
> +	.cmdbuff_addr_lo_reg	= 0x10548,	/* C2PMSG_18 */
> +	.cmdbuff_addr_hi_reg	= 0x1054c,	/* C2PMSG_19 */
>  	.bootloader_info_reg	= 0x109ec,	/* C2PMSG_59 */
>  	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
>  	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
> @@ -476,6 +473,9 @@ static const struct psp_vdata pspv3 = {
>  static const struct psp_vdata pspv4 = {
>  	.sev			= &sevv2,
>  	.tee			= &teev1,
> +	.cmdresp_reg		= 0x10544,	/* C2PMSG_17 */
> +	.cmdbuff_addr_lo_reg	= 0x10548,	/* C2PMSG_18 */
> +	.cmdbuff_addr_hi_reg	= 0x1054c,	/* C2PMSG_19 */
>  	.bootloader_info_reg	= 0x109ec,	/* C2PMSG_59 */
>  	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
>  	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
> @@ -485,6 +485,9 @@ static const struct psp_vdata pspv4 = {
>  static const struct psp_vdata pspv5 = {
>  	.tee			= &teev2,
>  	.platform_access	= &pa_v2,
> +	.cmdresp_reg		= 0x10944,	/* C2PMSG_17 */
> +	.cmdbuff_addr_lo_reg	= 0x10948,	/* C2PMSG_18 */
> +	.cmdbuff_addr_hi_reg	= 0x1094c,	/* C2PMSG_19 */
>  	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
>  	.inten_reg		= 0x10510,	/* P2CMSG_INTEN */
>  	.intsts_reg		= 0x10514,	/* P2CMSG_INTSTS */
> @@ -493,6 +496,9 @@ static const struct psp_vdata pspv5 = {
>  static const struct psp_vdata pspv6 = {
>  	.sev                    = &sevv2,
>  	.tee                    = &teev2,
> +	.cmdresp_reg		= 0x10944,	/* C2PMSG_17 */
> +	.cmdbuff_addr_lo_reg	= 0x10948,	/* C2PMSG_18 */
> +	.cmdbuff_addr_hi_reg	= 0x1094c,	/* C2PMSG_19 */
>  	.feature_reg            = 0x109fc,	/* C2PMSG_63 */
>  	.inten_reg              = 0x10510,	/* P2CMSG_INTEN */
>  	.intsts_reg             = 0x10514,	/* P2CMSG_INTSTS */
> diff --git a/drivers/crypto/ccp/tee-dev.c b/drivers/crypto/ccp/tee-dev.c
> index 5560bf8329a1..5e1d80724678 100644
> --- a/drivers/crypto/ccp/tee-dev.c
> +++ b/drivers/crypto/ccp/tee-dev.c
> @@ -62,26 +62,6 @@ static void tee_free_ring(struct psp_tee_device *tee)
>  	mutex_destroy(&rb_mgr->mutex);
>  }
>  
> -static int tee_wait_cmd_poll(struct psp_tee_device *tee, unsigned int timeout,
> -			     unsigned int *reg)
> -{
> -	/* ~10ms sleep per loop => nloop = timeout * 100 */
> -	int nloop = timeout * 100;
> -
> -	while (--nloop) {
> -		*reg = ioread32(tee->io_regs + tee->vdata->cmdresp_reg);
> -		if (FIELD_GET(PSP_CMDRESP_RESP, *reg))
> -			return 0;
> -
> -		usleep_range(10000, 10100);
> -	}
> -
> -	dev_err(tee->dev, "tee: command timed out, disabling PSP\n");
> -	psp_dead = true;
> -
> -	return -ETIMEDOUT;
> -}
> -
>  static
>  struct tee_init_ring_cmd *tee_alloc_cmd_buffer(struct psp_tee_device *tee)
>  {
> @@ -110,7 +90,6 @@ static int tee_init_ring(struct psp_tee_device *tee)
>  {
>  	int ring_size = MAX_RING_BUFFER_ENTRIES * sizeof(struct tee_ring_cmd);
>  	struct tee_init_ring_cmd *cmd;
> -	phys_addr_t cmd_buffer;
>  	unsigned int reg;
>  	int ret;
>  
> @@ -130,23 +109,15 @@ static int tee_init_ring(struct psp_tee_device *tee)
>  		return -ENOMEM;
>  	}
>  
> -	cmd_buffer = __psp_pa((void *)cmd);
> -
>  	/* Send command buffer details to Trusted OS by writing to
>  	 * CPU-PSP message registers
>  	 */
> -
> -	iowrite32(lower_32_bits(cmd_buffer),
> -		  tee->io_regs + tee->vdata->cmdbuff_addr_lo_reg);
> -	iowrite32(upper_32_bits(cmd_buffer),
> -		  tee->io_regs + tee->vdata->cmdbuff_addr_hi_reg);
> -	iowrite32(TEE_RING_INIT_CMD,
> -		  tee->io_regs + tee->vdata->cmdresp_reg);
> -
> -	ret = tee_wait_cmd_poll(tee, TEE_DEFAULT_TIMEOUT, &reg);
> +	ret = psp_mailbox_command(tee->psp, PSP_CMD_TEE_RING_INIT, cmd,
> +				  TEE_DEFAULT_CMD_TIMEOUT, &reg);
>  	if (ret) {
> -		dev_err(tee->dev, "tee: ring init command timed out\n");
> +		dev_err(tee->dev, "tee: ring init command timed out, disabling TEE support\n");
>  		tee_free_ring(tee);
> +		psp_dead = true;
>  		goto free_buf;
>  	}
>  
> @@ -174,12 +145,11 @@ static void tee_destroy_ring(struct psp_tee_device *tee)
>  	if (psp_dead)
>  		goto free_ring;
>  
> -	iowrite32(TEE_RING_DESTROY_CMD,
> -		  tee->io_regs + tee->vdata->cmdresp_reg);
> -
> -	ret = tee_wait_cmd_poll(tee, TEE_DEFAULT_TIMEOUT, &reg);
> +	ret = psp_mailbox_command(tee->psp, PSP_CMD_TEE_RING_DESTROY, NULL,
> +				  TEE_DEFAULT_CMD_TIMEOUT, &reg);
>  	if (ret) {
> -		dev_err(tee->dev, "tee: ring destroy command timed out\n");
> +		dev_err(tee->dev, "tee: ring destroy command timed out, disabling TEE support\n");
> +		psp_dead = true;
>  	} else if (FIELD_GET(PSP_CMDRESP_STS, reg)) {
>  		dev_err(tee->dev, "tee: ring destroy command failed (%#010lx)\n",
>  			FIELD_GET(PSP_CMDRESP_STS, reg));
> @@ -370,7 +340,7 @@ int psp_tee_process_cmd(enum tee_cmd_id cmd_id, void *buf, size_t len,
>  	if (ret)
>  		return ret;
>  
> -	ret = tee_wait_cmd_completion(tee, resp, TEE_DEFAULT_TIMEOUT);
> +	ret = tee_wait_cmd_completion(tee, resp, TEE_DEFAULT_RING_TIMEOUT);
>  	if (ret) {
>  		resp->flag = CMD_RESPONSE_TIMEDOUT;
>  		return ret;
> diff --git a/drivers/crypto/ccp/tee-dev.h b/drivers/crypto/ccp/tee-dev.h
> index 49d26158b71e..ea9a2b7c05f5 100644
> --- a/drivers/crypto/ccp/tee-dev.h
> +++ b/drivers/crypto/ccp/tee-dev.h
> @@ -17,21 +17,10 @@
>  #include <linux/device.h>
>  #include <linux/mutex.h>
>  
> -#define TEE_DEFAULT_TIMEOUT		10
> +#define TEE_DEFAULT_CMD_TIMEOUT		(10 * MSEC_PER_SEC)
> +#define TEE_DEFAULT_RING_TIMEOUT	10
>  #define MAX_BUFFER_SIZE			988
>  
> -/**
> - * enum tee_ring_cmd_id - TEE interface commands for ring buffer configuration
> - * @TEE_RING_INIT_CMD:		Initialize ring buffer
> - * @TEE_RING_DESTROY_CMD:	Destroy ring buffer
> - * @TEE_RING_MAX_CMD:		Maximum command id
> - */
> -enum tee_ring_cmd_id {
> -	TEE_RING_INIT_CMD		= 0x00010000,
> -	TEE_RING_DESTROY_CMD		= 0x00020000,
> -	TEE_RING_MAX_CMD		= 0x000F0000,
> -};
> -
>  /**
>   * struct tee_init_ring_cmd - Command to init TEE ring buffer
>   * @low_addr:  bits [31:0] of the physical address of ring buffer
