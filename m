Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3467D5FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 04:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjJYCFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 22:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYCFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 22:05:12 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C9910D4;
        Tue, 24 Oct 2023 19:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSUfdJUyvPjudFHK0KVmsPGF4TSKPCw3Ib4q8T//oXRA9KwzU7nNp2MAmSwnbvR0XYKcJqIFz4YCetEo1u+aNPf7cGuFGaR50w+kEaMjVsFbDs+v47ZA8jooBmSYAfc8ffO0UcuqLFcAtb2QnuXBF9OMDcHsGgaUggZtW4Esp9Ph4ZO/MFMAeDSBeNlVuFG+uib6njQtJco3uTHEexb4hSbu0aT9eoWYs6x4KjBKXrGcc3R65N9OvBVqjD4FrOeP4FdvYy+/hFPOKsTxmXhzBIJwl+xjmussr/Q8kHIKShPQJ4awExZwp5gwOHuk/gWN/7vh+xCWtE16IOIQMkSk7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOGjRifQF1mXTUH1sp10dpnk1MO6fzukDHj/CvO9vVw=;
 b=SYR1NYkDLgIIL/GxEFp0ekePF5FKK0Pu6IsUO7bdFmJhwa4Q91EN61IsyRj3Nsa8bpbN0oXT/7XlJAid32YuEBkcr7RvOxxKZq1VGu392CD1+e9uRfjFPG2/DG/zjDXRmYWDx0XnKRwCFlVzrGUhAYcAhNk8OIsZqZbUd/PJBgnJl2i8uwN4H6J5dkJW1a4Uf873l7Exy7z+TIlJ0iejrxVuKtI3epekdL1z+KzjY79zRpDivfhcCzkxDuXCWZeEgUt/vbwR4Cm8fzAR68TnxlUrbzaVOEs6QkizQ6pD3pE1W2BVv66NX/98JmQfxkX/bEPn+QFv8a65zP8Hv0y+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOGjRifQF1mXTUH1sp10dpnk1MO6fzukDHj/CvO9vVw=;
 b=lS8GG6pKTOzxd2Ua9La8FnsLBHPXzuI7/sNC+3lVcOfPw8vF95jsMthTAdIEOgTCVrpKakexj8MImYlhF49qaqG4WbEP1xHTxvO73s/4XHP6guAcMphsj2R5+5kRMSiwLR44RPRTcKgfTPxw/qt7FcOyDp1xZ5fwSxNmXHviLWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by LV8PR08MB9127.namprd08.prod.outlook.com
 (2603:10b6:408:1f8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 02:05:03 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 02:05:03 +0000
Date:   Tue, 24 Oct 2023 21:04:55 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     James Ogletree <james.ogletree@opensource.cirrus.com>
Cc:     James Ogletree <james.ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] Input: cs40l50 - Add cirrus haptics base support
Message-ID: <ZTh3qSAjIaj/oonc@nixie71>
References: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
 <20231018175726.3879955-3-james.ogletree@opensource.cirrus.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018175726.3879955-3-james.ogletree@opensource.cirrus.com>
X-ClientProxiedBy: SA1PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::14) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|LV8PR08MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7c0259-b375-4100-8864-08dbd4fecce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7G2x3K4JjcTaFxGTDv5xJmhyd48fyukSAcYIg1XXZZYuUc7Skaf4TYUUlOQHPmOup1HJQCqFVDacEPhLIFaLizT1EIbCH+z59NGqdn4iYcoDu43fV7q5lKeGVSgHAdige6I5Szr7TFjyeoBMQPVXP3C8eKjvP7sNxWOLbM8KsQqHE+qjBJg+ghcVzHlnKPiI0RLAWtN2UTnBtc+ps3Unbv6ut20tIqb/hjMh44jDVDwtyZzOApPBvaUYbh9QrIDHd1Qnzol9WwS+fH2YWg8ZrwwpX0cpbLw7b6mZZQeUGEY9OHA/Y1GEHXWFdqUOPaFU9zx5WM4llmUXK85Z08yBor1uZklBSWI+B/CKPjpYv9pLz/ZrXWgbrEB6tKte7/pq7MnQEmzw6BF1ylzb670DbFporsbWAl2bJnLoFUHyGr4mRo9WsuMDCM/hlT1kTPPU2LVKLgrI0lFfxMERaM+IbVECbTAbnZ/OGwe5DfbV2br+aedGmqm4QG8/5dPhSnCXm4VpPH2mTMb6Wj1OOLTe5pKZBqPuvh794iZ63lyIzNuU6eVLH7UfK2Q3T2Vu1WX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39830400003)(366004)(376002)(396003)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(4326008)(8676002)(8936002)(66899024)(6512007)(9686003)(6506007)(33716001)(6666004)(86362001)(26005)(66556008)(54906003)(66946007)(66476007)(316002)(6916009)(6486002)(478600001)(38100700002)(83380400001)(5660300002)(7416002)(2906002)(30864003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bOmdKOJNigo5RirYz6SEyun9fI3v5rH/JOL+DV5v/D6YcLK+APBEOcGiC3qt?=
 =?us-ascii?Q?zyY8eyfy1cES9CBihjsPwUY/2aI6FrfKEMqyQm4NOqPITTokDMT11n3mJdqP?=
 =?us-ascii?Q?qiudlhNaU9uUDVYNN4n6tD35SXnT+5YAyjBz5JW0jJwg0aXuNRNmHn5FUvCJ?=
 =?us-ascii?Q?Zqxdkly9iZ5ViCqQV/Kk3WIBt/5ahrsZ3fv71FNGbKpJ8+hMN4LF9wdBymKY?=
 =?us-ascii?Q?i9leI1qsIapzK8z+3j8oLhy4bJQ1g1JGSwFxTpmii0UtKjFK3w9ecKg2SWUT?=
 =?us-ascii?Q?5pVjhL0G3P2aWjBO4CqEiQmvlzmEjNDDL57zX7S6USuuMTtc19b0tfBLNLIJ?=
 =?us-ascii?Q?Z1F0UPMIwk/+NGWc4XfOGWxkAYaOfsij4B9mfo7mPbB+xutTR2pMXdJ0dqjb?=
 =?us-ascii?Q?HbG8lsCbq3NA0p/JkXiXJvMutKPFiyf7SSfFKR06oprk1d9DMQj1ke0FFmYT?=
 =?us-ascii?Q?YauA/dJTCUxwk4kmaIrPTUCWx6K9/ae1Cr438AzbljwjMGfPmaDJMtvUdhO8?=
 =?us-ascii?Q?MlwO3x35Hj5a1s78vlb4YqvdE0jmCIrHOqTheb1l67ETnqDWcFMRM8x0XvYl?=
 =?us-ascii?Q?p3ubgvzvkhdwGu3cFnb0LzkUzyhKaowD6LQaVOdEKcDNI5AOqvQ4nCXce+Af?=
 =?us-ascii?Q?MGiInVywAww/OVYL1jhrA6AuPpXV+l5yjSufDx7VUx14YZ+VPIFQDTY0yw0f?=
 =?us-ascii?Q?x8R3pNa0PuWtr1jKsvIKFJspRgAVWg7oJq/liiZhSpSaelVm0yGt8TqhohkB?=
 =?us-ascii?Q?96Ij1ThuzsbXE5cd03awVkLesNwCKSVPdfH7iy3o4inke8Ma79vJEd5p0t1n?=
 =?us-ascii?Q?/LLTfie+uSpiGP5gr3qr4cgJLrUhSWj85ej+2/eDYQAMBDHHQcRC0iSqnBxm?=
 =?us-ascii?Q?ppFKvMgHxPQAa5Kk6DvaoX+tY3OvIuemxtRCDcZaO8FM9j6ftvToBjSt0n+z?=
 =?us-ascii?Q?kkD7TrxSjINLzr1Ggg9vrgsXcRBYnoPa7fxLkF9HqDiZDpAMZS53Cj8S2EyZ?=
 =?us-ascii?Q?BsnuhdUCZKw3AbHUJ27T5sYZ546oqFzC1+yS6ECqixmDQqMCHQyHJskye1ZW?=
 =?us-ascii?Q?KhY4MQ9AvNO83tHlYNniP95Yu1P2Yr4Pyh01A5pjzMZq1xPLk2sEr/QP7Rkf?=
 =?us-ascii?Q?kiNwkH9NIWV52FTtjdJ9on0jdSAeqxU0c7qm3HfBwTPrdTRCKQ9HA0mkBQCt?=
 =?us-ascii?Q?TsBx2F1hbPaH/oEsKEPs3BsKfJocLnKpO+5tum5d8ZY/nXEIw7Rwioc9Vbsh?=
 =?us-ascii?Q?uVqhh6f5QxtATu05mtlX9R0TpTwp70CFCzQbLLGebaRParT+XxgQOgLkb/Hn?=
 =?us-ascii?Q?xevD+dxlASWQc1M1vQLaSfezF8UBsgKEGO2K1hwn44k+uWl3mEvOp1o8/Axa?=
 =?us-ascii?Q?rjsMPe1qpkUE5vioAs/dFnRxfAfP5G+Xcel2KVtTHcNOO1/gK23VgeCYywuL?=
 =?us-ascii?Q?0jnIo+t8k/lFzktjrvSUY2MMkBYUvsZpJ63MznQH32n1NwbfzulcyIhJ1Omk?=
 =?us-ascii?Q?h4mjohKjGusRPlj+/HBlimSiGbIb77ZueQmTejtGabgY0T2A6HHqI3L7XNw8?=
 =?us-ascii?Q?RPvM7HdzhkUlocQQJp1WMDU5xtX30SEi/so5RiDA?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7c0259-b375-4100-8864-08dbd4fecce9
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:05:03.1752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0qqdVWpJhJqDfTpIhuKi6712tonDKWCbLoNM9ez5sEE/dELRFJrYDSNsZKxJSMTAGluGTgopyH3ITrzw7aFXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR08MB9127
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Excellent work as always!

On Wed, Oct 18, 2023 at 05:57:23PM +0000, James Ogletree wrote:
> From: James Ogletree <james.ogletree@cirrus.com>
> 
> Introduce the cirrus haptics library which factors out
> common haptics operations used by Cirrus Logic Input
> drivers.
> 
> Signed-off-by: James Ogletree <james.ogletree@cirrus.com>
> ---
>  MAINTAINERS                          |   2 +
>  drivers/input/misc/cirrus_haptics.c  | 586 +++++++++++++++++++++++++++
>  include/linux/input/cirrus_haptics.h | 121 ++++++
>  3 files changed, 709 insertions(+)
>  create mode 100644 drivers/input/misc/cirrus_haptics.c
>  create mode 100644 include/linux/input/cirrus_haptics.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 28f0ca9324b3..57daf77bf550 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4970,6 +4970,8 @@ M:	Ben Bright <ben.bright@cirrus.com>
>  L:	patches@opensource.cirrus.com
>  S:	Supported
>  F:	Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
> +F:	drivers/input/misc/cirrus*
> +F:	include/linux/input/cirrus*
>  
>  CIRRUS LOGIC DSP FIRMWARE DRIVER
>  M:	Simon Trimmer <simont@opensource.cirrus.com>
> diff --git a/drivers/input/misc/cirrus_haptics.c b/drivers/input/misc/cirrus_haptics.c
> new file mode 100644
> index 000000000000..7e539cd45167
> --- /dev/null
> +++ b/drivers/input/misc/cirrus_haptics.c
> @@ -0,0 +1,586 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Helper functions for dealing with wavetable
> + * formats and DSP interfaces used by Cirrus
> + * haptic drivers.
> + *
> + * Copyright 2023 Cirrus Logic, Inc.
> + */
> +
> +#include <linux/firmware/cirrus/cs_dsp.h>
> +#include <linux/input.h>
> +#include <linux/input/cirrus_haptics.h>
> +#include <linux/pm_runtime.h>
> +
> +static int cs_hap_pseq_init(struct cs_hap *haptics)
> +{
> +	struct cs_hap_pseq_op *op;
> +	int error, i, num_words;
> +	u8 operation;
> +	u32 *words;
> +
> +	if (!haptics->dsp.pseq_size || !haptics->dsp.pseq_reg)
> +		return 0;
> +
> +	INIT_LIST_HEAD(&haptics->pseq_head);

Anything that allocates or initializes an element that is normally held
in a driver's private data, like a list head or mutex, belongs in probe()
in my opinion. It's less of an issue here, but for more complex cases
where we may set something up in probe() and tear it down in remove(),
the driver is easier to maintain if helper functions such as cs_hap_pseq_init()
only manipulate or organize the data, rather than absorb additional work.

> +
> +	words = kcalloc(haptics->dsp.pseq_size, sizeof(u32), GFP_KERNEL);
> +	if (!words)
> +		return -ENOMEM;
> +
> +	error = regmap_bulk_read(haptics->regmap, haptics->dsp.pseq_reg,
> +				 words, haptics->dsp.pseq_size);
> +	if (error)
> +		goto err_free;
> +
> +	for (i = 0; i < haptics->dsp.pseq_size; i += num_words) {
> +		operation = FIELD_GET(PSEQ_OP_MASK, words[i]);
> +		switch (operation) {
> +		case PSEQ_OP_END:
> +		case PSEQ_OP_WRITE_UNLOCK:
> +			num_words = PSEQ_OP_END_WORDS;
> +			break;
> +		case PSEQ_OP_WRITE_ADDR8:
> +		case PSEQ_OP_WRITE_H16:
> +		case PSEQ_OP_WRITE_L16:
> +			num_words = PSEQ_OP_WRITE_X16_WORDS;
> +			break;
> +		case PSEQ_OP_WRITE_FULL:
> +			num_words = PSEQ_OP_WRITE_FULL_WORDS;
> +			break;
> +		default:
> +			error = -EINVAL;
> +			dev_err(haptics->dev, "Unsupported op: %u\n", operation);
> +			goto err_free;
> +		}
> +
> +		op = devm_kzalloc(haptics->dev, sizeof(*op), GFP_KERNEL);
> +		if (!op) {
> +			error = -ENOMEM;
> +			goto err_free;
> +		}
> +
> +		op->size = num_words * sizeof(u32);
> +		memcpy(op->words, &words[i], op->size);
> +		op->offset = i * sizeof(u32);
> +		op->operation = operation;
> +		list_add(&op->list, &haptics->pseq_head);
> +
> +		if (operation == PSEQ_OP_END)
> +			break;
> +	}
> +
> +	if (operation != PSEQ_OP_END)
> +		error = -ENOENT;
> +
> +err_free:
> +	kfree(words);
> +
> +	return error;
> +}

My first thought as I reviewed this patch was that this and the lot
of pseq-related functions are not necessarily related to haptics, but
rather CS40L50 register access and housekeeping in general.

I seem to recall on L25 and friends that the the power-on sequencer,
i.e. PSEQ, is more or less a "tape recorder" of sorts in DSP memory
that can play back a series of address/data pairs when the device
comes out of hibernation, and any registers written during runtime
must also be mirrored to the PSEQ for "playback" later. Is that still
the case here?

Assuming so, these functions seem like they belong in the MFD, not
an input-specific library, because they will presumably be used by
the codec driver as well, since that driver will write registers to
set BCLK/LRCK ratio, etc.

Therefore, I think it makes more sense for these functions to move to
the MFD, which can then export them for use by the input/FF and codec
children.

This leaves cirrus_haptics.* with only a few functions related to
starting and stopping work, which seem specific enough to just live
in cs40l50-vibra.c. Presumably many of those could be re-used by
the L30 down the road, but in that case I think we'd be looking to
actually re-use the L50 driver and simply add a compatible string
for L30.

I recall L30 has some overhead that L50 does not, which may make
it hairy for cs40l50-vibra.c to support both. But in that case,
you could always fork a cs40l30-vibra.c with its own compatible
string, then have the L50 MFD selectively load the correct child
based on device ID. To summarize, we should have:

* drivers/mfd/cs40l50-core.c: MFD cell definition, device discovery,
  IRQ handling, exported PSEQ functions, etc.
* sound/soc/codecs/cs40l50.c: codec driver, uses PSEQ library from
  the MFD.
* drivers/input/misc/cs40l50-vibra.c: input/FF driver, start/stop
  work, also uses PSEQ library from the MFD.

And down the road, depending on complexity, maybe we also have:

* drivers/input/misc/cs40l30-vibra.c: another input/FF driver that
  includes other functionality that didn't really fit in cs40l50-vibra.c;
  also uses PSEQ library from, and is loaded by, the original L50 MFD.
  If this driver duplicates small bits of cs40l50-vibra.c, it's not the
  end of the world.

All of these files would #include include/linux/mfd/cs40l50.h. And
finally, cirrus_haptics.* simply go away. Same idea, just slightly
more scalable, and closer to common design patterns.

> +
> +static int cs_hap_pseq_find_end(struct cs_hap *haptics,
> +				struct cs_hap_pseq_op **op_end)
> +{
> +	u8 operation = PSEQ_OP_WRITE_FULL;
> +	struct cs_hap_pseq_op *op;
> +
> +	list_for_each_entry(op, &haptics->pseq_head, list) {
> +		operation = op->operation;
> +		if (operation == PSEQ_OP_END)
> +			break;
> +	}
> +
> +	if (operation != PSEQ_OP_END) {
> +		dev_err(haptics->dev, "Missing PSEQ list terminator\n");
> +		return -ENOENT;
> +	}
> +
> +	*op_end = op;
> +
> +	return 0;
> +}
> +
> +static struct cs_hap_pseq_op *cs_hap_pseq_find_op(struct cs_hap_pseq_op *match_op,
> +						  struct list_head *pseq_head)
> +{
> +	struct cs_hap_pseq_op *op;
> +
> +	list_for_each_entry(op, pseq_head, list) {
> +		if (op->operation == PSEQ_OP_END)
> +			break;

Nit: a line break here makes this easier to read IMO.

> +		if (op->operation != match_op->operation ||
> +		    op->words[0] != match_op->words[0])
> +			continue;

And here.

> +		switch (op->operation) {
> +		case PSEQ_OP_WRITE_FULL:
> +			if (FIELD_GET(GENMASK(23, 8), op->words[1]) ==
> +			    FIELD_GET(GENMASK(23, 8), match_op->words[1]))
> +				return op;
> +			break;
> +		case PSEQ_OP_WRITE_H16:
> +		case PSEQ_OP_WRITE_L16:
> +			if (FIELD_GET(GENMASK(23, 16), op->words[1]) ==
> +			    FIELD_GET(GENMASK(23, 16), match_op->words[1]))
> +				return op;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +int cs_hap_pseq_write(struct cs_hap *haptics, u32 addr,
> +		      u32 data, bool update, u8 op_code)
> +{
> +	struct cs_hap_pseq_op *op, *op_end, *op_new;
> +	struct cs_dsp_chunk ch;
> +	u32 pseq_bytes;
> +	int error;
> +
> +	op_new = devm_kzalloc(haptics->dev, sizeof(*op_new), GFP_KERNEL);
> +	if (!op_new)
> +		return -ENOMEM;
> +
> +	op_new->operation = op_code;
> +
> +	ch = cs_dsp_chunk((void *) op_new->words,
> +			  PSEQ_OP_WRITE_FULL_WORDS * sizeof(u32));
> +	cs_dsp_chunk_write(&ch, 8, op_code);
> +	switch (op_code) {
> +	case PSEQ_OP_WRITE_FULL:
> +		cs_dsp_chunk_write(&ch, 32, addr);
> +		cs_dsp_chunk_write(&ch, 32, data);
> +		break;
> +	case PSEQ_OP_WRITE_L16:
> +	case PSEQ_OP_WRITE_H16:
> +		cs_dsp_chunk_write(&ch, 24, addr);
> +		cs_dsp_chunk_write(&ch, 16, data);
> +		break;
> +	default:
> +		error = -EINVAL;
> +		goto op_new_free;
> +	}
> +
> +	op_new->size = cs_dsp_chunk_bytes(&ch);
> +
> +	if (update) {
> +		op = cs_hap_pseq_find_op(op_new, &haptics->pseq_head);
> +		if (!op) {
> +			error = -EINVAL;
> +			goto op_new_free;
> +		}
> +	}

It seems we are relying on the developer to remember if he or she has
already written 'addr' using a previous call to cs_hap_pseq_write(),
then set the update flag accordingly; is that accurate?

If so, that is a high risk for bugs to be introduced as the driver is
maintained. Can we not search for an existing address/data entry upon
any call to cs_hap_pseq_write() using cs_hap_pseq_find_op(), and add
or replace a new address/data entry automatically?

> +
> +	error = cs_hap_pseq_find_end(haptics, &op_end);
> +	if (error)
> +		goto op_new_free;
> +
> +	pseq_bytes = haptics->dsp.pseq_size * sizeof(u32);
> +
> +	if (pseq_bytes - op_end->offset < op_new->size) {
> +		error = -ENOMEM;
> +		goto op_new_free;
> +	}
> +
> +	if (update) {
> +		op_new->offset = op->offset;
> +	} else {
> +		op_new->offset = op_end->offset;
> +		op_end->offset += op_new->size;
> +	}
> +
> +	error = regmap_raw_write(haptics->regmap, haptics->dsp.pseq_reg +
> +				 op_new->offset, op_new->words, op_new->size);
> +	if (error)
> +		goto op_new_free;
> +
> +	if (update) {
> +		list_replace(&op->list, &op_new->list);
> +	} else {
> +		error = regmap_raw_write(haptics->regmap, haptics->dsp.pseq_reg +
> +					 op_end->offset, op_end->words,
> +					 op_end->size);
> +		if (error)
> +			goto op_new_free;
> +
> +		list_add(&op_new->list, &haptics->pseq_head);
> +	}
> +
> +	return 0;
> +
> +op_new_free:
> +	devm_kfree(haptics->dev, op_new);
> +
> +	return error;
> +}
> +EXPORT_SYMBOL_GPL(cs_hap_pseq_write);
> +
> +int cs_hap_pseq_multi_write(struct cs_hap *haptics,
> +			    const struct reg_sequence *reg_seq,
> +			    int num_regs, bool update, u8 op_code)
> +{
> +	int error, i;
> +
> +	for (i = 0; i < num_regs; i++) {
> +		error = cs_hap_pseq_write(haptics, reg_seq[i].reg,
> +					  reg_seq[i].def, update, op_code);
> +		if (error)
> +			return error;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cs_hap_pseq_multi_write);
> +
> +static struct cs_hap_effect *cs_hap_find_effect(int id,
> +						struct list_head *effect_head)
> +{
> +	struct cs_hap_effect *effect;
> +
> +	list_for_each_entry(effect, effect_head, list)
> +		if (effect->id == id)
> +			return effect;
> +
> +	return NULL;
> +}
> +
> +static int cs_hap_effect_bank_set(struct cs_hap *haptics,
> +				  struct cs_hap_effect *effect,
> +				  struct ff_periodic_effect add_effect)
> +{
> +	s16 bank = add_effect.custom_data[0] & 0xffffu;
> +	unsigned int len = add_effect.custom_len;
> +
> +	if (bank >= WVFRM_BANK_NUM) {
> +		dev_err(haptics->dev, "Invalid waveform bank: %d\n", bank);
> +		return -EINVAL;
> +	}
> +
> +	effect->bank = len > CUSTOM_DATA_SIZE ? WVFRM_BANK_OWT : bank;
> +
> +	return 0;
> +}
> +
> +static int cs_hap_effect_mapping_set(struct cs_hap *haptics, u16 button,
> +				     struct cs_hap_effect *effect)
> +{
> +	u32 gpio_num, gpio_edge;
> +
> +	if (button) {
> +		gpio_num = FIELD_GET(BTN_NUM_MASK, button);
> +		gpio_edge = FIELD_GET(BTN_EDGE_MASK, button);
> +		effect->mapping = haptics->dsp.gpio_base_reg +
> +				  (gpio_num * 8) - gpio_edge;
> +
> +		return regmap_write(haptics->regmap, effect->mapping, button);
> +	}
> +
> +	effect->mapping = GPIO_MAPPING_INVALID;
> +
> +	return 0;
> +}
> +
> +static int cs_hap_effect_index_set(struct cs_hap *haptics,
> +				   struct cs_hap_effect *effect,
> +				   struct ff_periodic_effect add_effect)
> +{
> +	struct cs_hap_effect *owt_effect;
> +	u32 base_index, max_index;
> +
> +	base_index = haptics->banks[effect->bank].base_index;
> +	max_index = haptics->banks[effect->bank].max_index;
> +
> +	effect->index = base_index;
> +
> +	switch (effect->bank) {
> +	case WVFRM_BANK_OWT:
> +		list_for_each_entry(owt_effect, &haptics->effect_head, list)
> +			if (owt_effect->bank == WVFRM_BANK_OWT)
> +				effect->index++;
> +		break;
> +	case WVFRM_BANK_ROM:
> +	case WVFRM_BANK_RAM:
> +		effect->index += add_effect.custom_data[1] & 0xffffu;
> +		break;
> +	default:
> +		dev_err(haptics->dev, "Bank not supported: %d\n", effect->bank);
> +		return -EINVAL;
> +	}
> +
> +	if (effect->index > max_index || effect->index < base_index) {
> +		dev_err(haptics->dev, "Index out of bounds: %u\n", effect->index);
> +		return -ENOSPC;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cs_hap_upload_pwle(struct cs_hap *haptics,
> +			      struct cs_hap_effect *effect,
> +			      struct ff_periodic_effect add_effect)
> +{
> +	u32 len, wt_offset, wt_size_words;
> +	struct cs_hap_pwle_header header;
> +	u8 *out_data;
> +	int error;
> +
> +	error = regmap_read(haptics->regmap, haptics->dsp.owt_offset_reg,
> +			    &wt_offset);
> +	if (error)
> +		return error;
> +
> +	error = regmap_read(haptics->regmap, haptics->dsp.owt_size_reg,
> +			    &wt_size_words);
> +	if (error)
> +		return error;
> +
> +	len = 2 * add_effect.custom_len;
> +
> +	if ((wt_size_words * sizeof(u32)) < OWT_HEADER_SIZE + len)
> +		return -ENOSPC;
> +
> +	out_data = kzalloc(OWT_HEADER_SIZE + len, GFP_KERNEL);
> +	if (!out_data)
> +		return -ENOMEM;
> +
> +	header.type = add_effect.custom_data[0] == PCM_ID ? OWT_TYPE_PCM :
> +							    OWT_TYPE_PWLE;
> +	header.offset = OWT_HEADER_SIZE / sizeof(u32);
> +	header.data_words = len / sizeof(u32);
> +
> +	memcpy(out_data, &header, sizeof(header));
> +	memcpy(out_data + OWT_HEADER_SIZE, add_effect.custom_data, len);
> +
> +	error = regmap_bulk_write(haptics->regmap, haptics->dsp.owt_base_reg +
> +				  (wt_offset * sizeof(u32)), out_data,
> +				  OWT_HEADER_SIZE + len);
> +	if (error)
> +		goto err_free;
> +
> +	error = regmap_write(haptics->regmap, haptics->dsp.mailbox_reg,
> +			     haptics->dsp.push_owt_cmd);
> +
> +err_free:
> +	kfree(out_data);
> +
> +	return error;
> +}
> +
> +static void cs_hap_add_worker(struct work_struct *work)
> +{
> +	struct cs_hap *haptics = container_of(work, struct cs_hap,
> +					      add_work);
> +	struct ff_effect add_effect = haptics->add_effect;
> +	bool is_new = false;
> +	struct cs_hap_effect *effect;
> +	int error;
> +
> +	if (haptics->runtime_pm) {
> +		error = pm_runtime_resume_and_get(haptics->dev);
> +		if (error < 0) {
> +			haptics->add_error = error;
> +			return;
> +		}
> +	}
> +
> +	mutex_lock(&haptics->lock);
> +
> +	effect = cs_hap_find_effect(add_effect.id, &haptics->effect_head);
> +	if (!effect) {
> +		effect = kzalloc(sizeof(*effect), GFP_KERNEL);
> +		if (!effect) {
> +			error = -ENOMEM;
> +			goto err_mutex;
> +		}
> +		effect->id = add_effect.id;
> +		is_new = true;
> +	}
> +
> +	error = cs_hap_effect_bank_set(haptics, effect, add_effect.u.periodic);
> +	if (error)
> +		goto err_free;
> +
> +	error = cs_hap_effect_index_set(haptics, effect, add_effect.u.periodic);
> +	if (error)
> +		goto err_free;
> +
> +	error = cs_hap_effect_mapping_set(haptics, add_effect.trigger.button,
> +					  effect);
> +	if (error)
> +		goto err_free;
> +
> +	if (effect->bank == WVFRM_BANK_OWT)
> +		error = cs_hap_upload_pwle(haptics, effect,
> +					   add_effect.u.periodic);
> +
> +err_free:
> +	if (is_new) {
> +		if (error)
> +			kfree(effect);
> +		else
> +			list_add(&effect->list, &haptics->effect_head);
> +	}
> +
> +err_mutex:
> +	mutex_unlock(&haptics->lock);
> +
> +	if (haptics->runtime_pm) {
> +		pm_runtime_mark_last_busy(haptics->dev);
> +		pm_runtime_put_autosuspend(haptics->dev);
> +	}
> +
> +	haptics->add_error = error;
> +}
> +
> +static void cs_hap_erase_worker(struct work_struct *work)
> +{
> +	struct cs_hap *haptics = container_of(work, struct cs_hap,
> +					      erase_work);
> +	int error = 0;
> +	struct cs_hap_effect *owt_effect, *erase_effect;
> +
> +	if (haptics->runtime_pm) {
> +		error = pm_runtime_resume_and_get(haptics->dev);
> +		if (error < 0) {
> +			haptics->erase_error = error;
> +			return;
> +		}
> +	}
> +
> +	mutex_lock(&haptics->lock);
> +
> +	erase_effect = cs_hap_find_effect(haptics->erase_effect->id,
> +					  &haptics->effect_head);
> +	if (!erase_effect) {
> +		dev_err(haptics->dev, "Effect to erase does not exist\n");
> +		error = -EINVAL;
> +		goto err_mutex;
> +	}
> +
> +	if (erase_effect->mapping != GPIO_MAPPING_INVALID) {
> +		error = regmap_write(haptics->regmap, erase_effect->mapping,
> +				     GPIO_DISABLE);
> +		if (error)
> +			goto err_mutex;
> +	}
> +
> +	if (erase_effect->bank == WVFRM_BANK_OWT) {
> +		error = regmap_write(haptics->regmap, haptics->dsp.mailbox_reg,
> +				     haptics->dsp.delete_owt_cmd |
> +				     erase_effect->index);
> +		if (error)
> +			goto err_mutex;
> +
> +		list_for_each_entry(owt_effect, &haptics->effect_head, list)
> +			if (owt_effect->bank == WVFRM_BANK_OWT &&
> +			    owt_effect->index > erase_effect->index)
> +				owt_effect->index--;
> +	}
> +
> +	list_del(&erase_effect->list);
> +	kfree(erase_effect);
> +
> +err_mutex:
> +	mutex_unlock(&haptics->lock);
> +
> +	if (haptics->runtime_pm) {
> +		pm_runtime_mark_last_busy(haptics->dev);
> +		pm_runtime_put_autosuspend(haptics->dev);
> +	}
> +
> +	haptics->erase_error = error;
> +}
> +
> +static void cs_hap_vibe_start_worker(struct work_struct *work)
> +{
> +	struct cs_hap *haptics = container_of(work, struct cs_hap,
> +					      vibe_start_work);
> +	struct cs_hap_effect *effect;
> +	int error;
> +
> +	if (haptics->runtime_pm) {
> +		error = pm_runtime_resume_and_get(haptics->dev);
> +		if (error < 0) {
> +			haptics->start_error = error;
> +			return;
> +		}
> +	}
> +
> +	mutex_lock(&haptics->lock);
> +
> +	effect = cs_hap_find_effect(haptics->start_effect->id,
> +				    &haptics->effect_head);
> +	if (effect) {
> +		error = regmap_write(haptics->regmap, haptics->dsp.mailbox_reg,
> +				     effect->index);
> +	} else {
> +		dev_err(haptics->dev, "Effect to start does not exist\n");
> +		error = -EINVAL;
> +	}
> +
> +	mutex_unlock(&haptics->lock);
> +
> +	if (haptics->runtime_pm) {
> +		pm_runtime_mark_last_busy(haptics->dev);
> +		pm_runtime_put_autosuspend(haptics->dev);
> +	}
> +
> +	haptics->start_error = error;
> +}
> +
> +static void cs_hap_vibe_stop_worker(struct work_struct *work)
> +{
> +	struct cs_hap *haptics = container_of(work, struct cs_hap,
> +					      vibe_stop_work);
> +	int error;
> +
> +	if (haptics->runtime_pm) {
> +		error = pm_runtime_resume_and_get(haptics->dev);
> +		if (error < 0) {
> +			haptics->stop_error = error;
> +			return;
> +		}
> +	}
> +
> +	mutex_lock(&haptics->lock);
> +	error = regmap_write(haptics->regmap, haptics->dsp.mailbox_reg,
> +			     haptics->dsp.stop_cmd);
> +	mutex_unlock(&haptics->lock);
> +
> +	if (haptics->runtime_pm) {
> +		pm_runtime_mark_last_busy(haptics->dev);
> +		pm_runtime_put_autosuspend(haptics->dev);
> +	}
> +
> +	haptics->stop_error = error;

This seems like another argument for not separating the input/FF child
from the meat of the driver; it just seems messy to pass around error
codes within a driver's private data like this.

That being said, where are start_error and stop_error used? I didn't
see them in the input/FF child. We should only introduce code that has
at least one user.

> +}
> +
> +int cs_hap_init(struct cs_hap *haptics)
> +{
> +	haptics->vibe_wq = alloc_ordered_workqueue("vibe_wq", 0);
> +	if (!haptics->vibe_wq)
> +		return -ENOMEM;
> +
> +	mutex_init(&haptics->lock);
> +
> +	INIT_WORK(&haptics->vibe_start_work, cs_hap_vibe_start_worker);
> +	INIT_WORK(&haptics->vibe_stop_work, cs_hap_vibe_stop_worker);
> +	INIT_WORK(&haptics->erase_work, cs_hap_erase_worker);
> +	INIT_WORK(&haptics->add_work, cs_hap_add_worker);
> +
> +	return cs_hap_pseq_init(haptics);
> +}
> +EXPORT_SYMBOL_GPL(cs_hap_init);
> +
> +void cs_hap_remove(struct cs_hap *haptics)
> +{
> +	flush_workqueue(haptics->vibe_wq);
> +	destroy_workqueue(haptics->vibe_wq);
> +}
> +EXPORT_SYMBOL_GPL(cs_hap_remove);
> +
> +MODULE_DESCRIPTION("Cirrus Logic Haptics Support");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/input/cirrus_haptics.h b/include/linux/input/cirrus_haptics.h
> new file mode 100644
> index 000000000000..42f6afed7944
> --- /dev/null
> +++ b/include/linux/input/cirrus_haptics.h
> @@ -0,0 +1,121 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Helper functions for dealing with wavetable
> + * formats and DSP interfaces used by Cirrus
> + * haptic drivers.
> + *
> + * Copyright 2023 Cirrus Logic, Inc.
> + */
> +
> +#ifndef __CIRRUS_HAPTICS_H
> +#define __CIRRUS_HAPTICS_H
> +
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +/* Power-on write sequencer */
> +#define PSEQ_OP_MASK			GENMASK(23, 16)
> +#define PSEQ_OP_SHIFT			16
> +#define PSEQ_OP_WRITE_FULL_WORDS	3
> +#define PSEQ_OP_WRITE_X16_WORDS		2
> +#define PSEQ_OP_END_WORDS		1
> +#define PSEQ_OP_WRITE_FULL		0x00
> +#define PSEQ_OP_WRITE_ADDR8		0x02
> +#define PSEQ_OP_WRITE_L16		0x04
> +#define PSEQ_OP_WRITE_H16		0x05
> +#define PSEQ_OP_WRITE_UNLOCK		0xFD
> +#define PSEQ_OP_END			0xFF
> +
> +/* Open wavetable */
> +#define OWT_HEADER_SIZE		12
> +#define OWT_TYPE_PCM		8
> +#define OWT_TYPE_PWLE		12
> +#define PCM_ID			0x0
> +#define CUSTOM_DATA_SIZE	2
> +
> +/* GPIO */
> +#define BTN_NUM_MASK		GENMASK(14, 12)
> +#define BTN_EDGE_MASK		BIT(15)
> +#define GPIO_MAPPING_INVALID	0
> +#define GPIO_DISABLE		0x1FF
> +
> +enum cs_hap_bank_type {
> +	WVFRM_BANK_RAM,
> +	WVFRM_BANK_ROM,
> +	WVFRM_BANK_OWT,
> +	WVFRM_BANK_NUM,
> +};
> +
> +struct cs_hap_pseq_op {
> +	struct list_head list;
> +	u32 words[3];
> +	u16 offset;
> +	u8 operation;
> +	u8 size;
> +};
> +
> +struct cs_hap_effect {
> +	enum cs_hap_bank_type bank;
> +	struct list_head list;
> +	u32 mapping;
> +	u32 index;
> +	int id;
> +};
> +
> +struct cs_hap_pwle_header {
> +	u32 type;
> +	u32 data_words;
> +	u32 offset;
> +} __packed;
> +
> +struct cs_hap_bank {
> +	enum cs_hap_bank_type bank;
> +	u32 base_index;
> +	u32 max_index;
> +};
> +
> +struct cs_hap_dsp {
> +	u32 gpio_base_reg;
> +	u32 owt_offset_reg;
> +	u32 owt_size_reg;
> +	u32 owt_base_reg;
> +	u32 mailbox_reg;
> +	u32 pseq_reg;
> +	u32 push_owt_cmd;
> +	u32 delete_owt_cmd;
> +	u32 stop_cmd;
> +	u32 pseq_size;
> +};
> +
> +struct cs_hap {
> +	struct regmap *regmap;
> +	struct mutex lock;
> +	struct device *dev;
> +	struct list_head pseq_head;
> +	struct cs_hap_bank *banks;
> +	struct cs_hap_dsp dsp;
> +	struct workqueue_struct *vibe_wq;
> +	struct work_struct vibe_start_work;
> +	struct work_struct vibe_stop_work;
> +	struct work_struct erase_work;
> +	struct work_struct add_work;
> +	struct ff_effect *start_effect;
> +	struct ff_effect *erase_effect;
> +	struct ff_effect add_effect;
> +	struct list_head effect_head;
> +	int erase_error;
> +	int start_error;
> +	int stop_error;
> +	int add_error;
> +	bool runtime_pm;
> +};
> +
> +int cs_hap_pseq_write(struct cs_hap *haptics, u32 addr,
> +		      u32 data, bool update, u8 op_code);
> +int cs_hap_pseq_multi_write(struct cs_hap *haptics,
> +			    const struct reg_sequence *reg_seq,
> +			    int num_regs, bool update, u8 op_code);
> +int cs_hap_init(struct cs_hap *haptics);
> +void cs_hap_remove(struct cs_hap *haptics);
> +
> +#endif
> -- 
> 2.25.1
> 

Kind regards,
Jeff LaBundy
