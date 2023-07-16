Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F716755898
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 00:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjGPWL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 18:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGPWL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 18:11:26 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B869D9;
        Sun, 16 Jul 2023 15:11:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLxz99uwMEVusKgG/F6Xe6gv7UWpdRnWrmMVgylE5fGL8RRT13ov+uYCfXpWJavsE7xahLDowHVjXw91/DfDjEdmpE8llhjfoI9eD6SDGhKaqPPuzBto6k/QCr8ravQexoi6hBfT0gRkD1qcnKYJVjIBPVir0XUrjrT5hkn6ZF4ef+edb/eLay08LQbt7sTnvFfbU9nCNCWa+QR5wIthYzatAVepXu5TUFKUs3d1/nUA657U/iemKuzdVdB/vAu6EsOkvzMubKqWy9CdS4i5A7IjpLBPyObseW8U1q/LOU4LzkWUmmSNeMxkOjOzlCikQFVj0hRSwsyenpnT0Ts3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ADHFBcr+D6JcWxIuzP+q1+rRDoKZyMcU16XsxRfsyU=;
 b=NXtPne64lf0eTjC7fEnkNH8lqK/OlM2+yirnRd5DYCLGlNgcsO23jT5gQv2v0kLIkpskMpaWYIgfTEE4qpYV04vQUfrseHe40HQ2ZgtjScr74yQTFvu1CEbsna6uKbTAhuEVJWzMpKT4IJDWXybF3lS4eeTji/oKHcjJign/Co36xYh8kJfXgY/WsypDXvwLUjEhF+JV4polBTVXhTzjJ7eGPZgy/+m4V30gZkzlqHh4rKi820xTeQvujvZJRIGVHjsj/IKMD60gG6uZg0eJ8wnP+pF05UqZkk6GoCBxkc+Bv+0LHQuRPuSaFB5sa8DYdEitPS6G2ONVgtU+Qq6FVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ADHFBcr+D6JcWxIuzP+q1+rRDoKZyMcU16XsxRfsyU=;
 b=eWTR5VRIEdPxnDZGPJRL9QvoVpqmHjilT2Ye5yoUnc7tXCBWr0ztmaG/WV1qP5WnbXsU0H3aI1kwmJUnIr3WfJAmozEXT1HHlsenmPpsln7orA4KtPWcFYTL3nWXtgGUbpDI9qzorCw1kAVf4BPKL/BgusSYzCE1+rW6I2Jik0LdARTOWQyhjIe3pS61Fo88msEnoH3/h9cXIxKf+TJ3RHiYeHalDRWdr1ye96ZGxJZWJaw2CPlec9tSh3rv3NXjBIWbq5ZWgiK9wS5Z/ZpOAOaZrGMdG+nenqL9TxBYXWPmN5IHajxGZVk0KiHdzBYPNeyA/sqdS5vP7xJMeBFz1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA3PR12MB7975.namprd12.prod.outlook.com (2603:10b6:806:320::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sun, 16 Jul
 2023 22:11:22 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::6933:8c58:b59:ba17]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::6933:8c58:b59:ba17%5]) with mapi id 15.20.6588.031; Sun, 16 Jul 2023
 22:11:21 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Fabio Baltieri <fabiobaltieri@chromium.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] HID: hid-google-stadiaff: add support for Stadia
 force feedback
In-Reply-To: <20230716204834.2879106-1-fabiobaltieri@chromium.org> (Fabio
        Baltieri's message of "Sun, 16 Jul 2023 20:48:34 +0000")
References: <20230716204834.2879106-1-fabiobaltieri@chromium.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date:   Sun, 16 Jul 2023 15:11:12 -0700
Message-ID: <87ttu3qzgf.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::28) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA3PR12MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 828e49cc-c762-4f22-f383-08db86499608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWGpq1B4pPVXz8PnNmkLzksayMIxK/Oe/r1JGrA98BVTBiEauU61dl6Q0sTauUxPpwxTdk2/q/cGyVbkm0gmJUrL2YZE3RNoAC1965DhpVsKiM8AX9/CF2ZOe/oQouiYwkxs9jeSDvLdFlQIZtUXhEEEn/zBBCWRQK+25ivRckMNM+x2a3ewZb+vMm4Ybn3uRkxBgpZrwq3zw53jcBIWE177oz0E7Hmm2wI1cnnIjixKkCoD1t4A6E/r4iaV+lPrTxN0kuNpGFu5corNc4uXDAcBfqkm5H7pMPwk2RYSk+dmRwqJmYoA8lL/z0yk4/2JYJAWiij29WJhhcIXLFKIcZBps5WrUK0lwXPq7t/+WqeqgTyJexP7AvABR/N6XXQ59IuTbJE6CIwgYkKtPHAzC8ZxeC+oOs7svnRsl0GUU0sEfwiJpVspiUjyL1/zwJILqBKjNFnlbTcOTzlvtMoqVcy2q+HjJKk5/L/NlCElAXbhhB41tU2wCM27sc/vx/cyNDmjnofFa2R4LcRh9P19dkUZ79V+iUURtjt6YSJvBlA41gqSGTq1kBoylK+QcOm8U55zB2AIMQfP6u7Wwz2IWhT2kFZfC4ez3GuqRbRYkfg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199021)(478600001)(6486002)(6666004)(54906003)(186003)(6506007)(26005)(6512007)(966005)(2906002)(316002)(41300700001)(66946007)(66556008)(66476007)(6916009)(4326008)(5660300002)(8936002)(8676002)(38100700002)(36756003)(86362001)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U03Sqj8HErfV3Q/G3/R8HGBYduoIr6/fWXheGBhwfdf69A9kFSMXH3r9MtJm?=
 =?us-ascii?Q?Lv6hYqpW9jiV+JBvv60lQghoxfMUeJjemY9N5rH01ZbPm00jh+gILUUPcZ/I?=
 =?us-ascii?Q?uxkForgarSjOxDzrxgjRanXZxc29Y30u44Cr1Zuv4qtFtJ2UMVNJsoFDlS+f?=
 =?us-ascii?Q?5jOw5QkNA7fvhLyuUToME9yu5Bv8CHDWW+jLCDItPDLCLuPyk03O505c/QPF?=
 =?us-ascii?Q?hyqgUinBHn2o/Y861EwDgu7vf+PjIVujvJUmJuqvlaDbNzGnAGGT3N50UTES?=
 =?us-ascii?Q?zHifMa7lPfhixJ5KBWQpMIob8N6syc/UxMKi4KzcLHz7ZbK8rgBQrGIx5qQb?=
 =?us-ascii?Q?xruO1p22cr8cg8mdT2keRkEBKO8y8wvuq9E/LvqDlUVgxQyTAmxQIkrsFRAU?=
 =?us-ascii?Q?5Kz3f+xRKFlejaaQGihzJk8bl1psoBNC6RsdCt5DUZcNeKk105ywylYHSb5H?=
 =?us-ascii?Q?o8ZNqy11JUmo7GaaJiNVSL8b21JfnR7ZTsy6bKvmCstTu2YuFb97v39UWUX+?=
 =?us-ascii?Q?+BnY0DKvP73u/X6lJtkrvzjDrc6lvgf+neCJX6D5uiXWf19/yTSZq0NeOQlk?=
 =?us-ascii?Q?5eaScvjMhspNKM5LAHM7sUHIO4KbX67vSXV49KsV++WaA0v2TJReORjQv0LC?=
 =?us-ascii?Q?c5f9g6K2hY+LsiD59aqAAf9dQ5e7bmSux9cMbpkWHDK0dcF7kU3rS2zdeSZh?=
 =?us-ascii?Q?IuKbRhWFIr5IM2L7lwqueGRhhwNluJMAPj81urBSW/jinNYQ0xOeuhLByD+e?=
 =?us-ascii?Q?VDdr/U9y8q5VFjZAObe1gMwQPDE5/ZkT7Xzv3gkkuBnGvdWZwNkoVHRa9h+w?=
 =?us-ascii?Q?wco2ZjlKRouPctfAFscmxkgYdTQ4qPND+ze/8pvn4U3zJjiNAkJBJVlM8hlr?=
 =?us-ascii?Q?Ok+Ckwcz619Q6xj7CW8szXIxC37bQiv4qL7kWf8MCsAN9CTt97frEarS5Ntv?=
 =?us-ascii?Q?tgQSI7SM6WhQx25kT6zfwoHiVORxWa+tb95KwI/eeedidkwJ7OvwQclFhf3r?=
 =?us-ascii?Q?pImKltqVDzZXDP4TWpL19weNUxt8MjZh2RphwarFbcKpuf66mjntGMp6isud?=
 =?us-ascii?Q?Uzpe+oVZNkrCQ/uzyjEs+gxtwg16hLlK+HcYj/3FiKdV/jC022vUlqm1lqtJ?=
 =?us-ascii?Q?/gjjLOijSNygpR9VEvfGdn6LICfsDlbTGDHp7LLZHIbs2VtfmjRgep7o9rwD?=
 =?us-ascii?Q?eJvlA1QDuDRMwNWRVo3+W/ffxuBiqDGJdLqXZSi7GqcdG48G1Y3HJhTedpha?=
 =?us-ascii?Q?w084eCHM8jfLBTOvq0oC5l9akxaXnY93oX4QEFfIBTKpSFU2kVJuvQzOnNt8?=
 =?us-ascii?Q?xYbjCK6d+qLfwyx+iDlq7pOa0Kce4KDAVMufrU0612+cc7el58lG4nezmm7I?=
 =?us-ascii?Q?jm+JtSPhBSaQUW8CJrM8XOg+cNadEcP1k8+VwAjRpsJLB/U9Gd+e0HBAgwPO?=
 =?us-ascii?Q?kgWQzhzROoy3WIzV+z5KpBb/jU8v9s0Q0p+f2q+wFu+AAmkN9TnBBkrUDzZe?=
 =?us-ascii?Q?Dvo2bRg/3W9LKtXcZ91vIz7MM/BZuBqMxBXSfKOAM/MFORHKbhIvzBfFdWnw?=
 =?us-ascii?Q?cgO1iIHiBRor4/NCGfxGpu9v8TISWT0L5dczCTBOsUmoVp2Mxa2YAfcmbR+3?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828e49cc-c762-4f22-f383-08db86499608
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2023 22:11:21.4171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rP4SeNZjRBzdDJdONGzTr6udzxeHPmUptkBcIvwpQLQmER+n2zwzeg4ARVG0hwnI0gycYqW4RMW5JluyTHgriQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7975
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jul, 2023 20:48:34 +0000 Fabio Baltieri <fabiobaltieri@chromium.org> wrote:
> Add a hid-google-stadiaff module to support rumble based force feedback
> on the Google Stadia controller. This works using the HID output
> endpoint exposed on both the USB and BLE interface.
>
> Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> ---
>
> Hi, this adds rumble support to the stadia controller using the input
> interface. Up to now this has only been implemented at application level
> using hidraw:
>
> https://source.chromium.org/chromium/chromium/src/+/main:device/gamepad/hid_haptic_gamepad.cc
>
> Tested with fftest, works both over USB and BLE.
>
> Changes from v3:
> - fixed an unintended use of dev_err instead of hid_err
> - fixed the driver name reference in the commit message
> - rebased so the change in hid-ids.h applies cleanly
>
> Changes from v2:
> - check stadiaff_init value at probe time and fail the probe if init
>   fails
>
> Changes from v1:
> - renamed the module to hid-google-stadiaff.c
> - added locking for passing the state to the worker code
> - added a module removed check to prevent the work from rescheduling
>
>  drivers/hid/Kconfig               |   7 ++
>  drivers/hid/Makefile              |   1 +
>  drivers/hid/hid-google-stadiaff.c | 158 ++++++++++++++++++++++++++++++
>  drivers/hid/hid-ids.h             |   1 +
>  4 files changed, 167 insertions(+)
>  create mode 100644 drivers/hid/hid-google-stadiaff.c
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index e11c1c803676..545e81c8f359 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -412,6 +412,13 @@ config HID_GOOGLE_HAMMER
>  	help
>  	Say Y here if you have a Google Hammer device.
>  
> +config HID_GOOGLE_STADIA_FF
> +	tristate "Google Stadia force feedback"
> +	select INPUT_FF_MEMLESS
> +	help
> +	Say Y here if you want to enable force feedback support for the Google
> +	Stadia controller.
> +
>  config HID_VIVALDI
>  	tristate "Vivaldi Keyboard"
>  	select HID_VIVALDI_COMMON
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 7a9e160158f7..8a06d0f840bc 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_HID_GFRM)		+= hid-gfrm.o
>  obj-$(CONFIG_HID_GLORIOUS)  += hid-glorious.o
>  obj-$(CONFIG_HID_VIVALDI_COMMON) += hid-vivaldi-common.o
>  obj-$(CONFIG_HID_GOOGLE_HAMMER)	+= hid-google-hammer.o
> +obj-$(CONFIG_HID_GOOGLE_STADIA_FF)	+= hid-google-stadiaff.o
>  obj-$(CONFIG_HID_VIVALDI)	+= hid-vivaldi.o
>  obj-$(CONFIG_HID_GT683R)	+= hid-gt683r.o
>  obj-$(CONFIG_HID_GYRATION)	+= hid-gyration.o
> diff --git a/drivers/hid/hid-google-stadiaff.c b/drivers/hid/hid-google-stadiaff.c
> new file mode 100644
> index 000000000000..3731575562ab
> --- /dev/null
> +++ b/drivers/hid/hid-google-stadiaff.c
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Stadia controller rumble support.
> + *
> + * Copyright 2023 Google LLC
> + */
> +
> +#include <linux/hid.h>
> +#include <linux/input.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +
> +#include "hid-ids.h"
> +
> +#define STADIA_FF_REPORT_ID 5
> +
> +struct stadiaff_device {
> +	struct hid_device *hid;
> +	struct hid_report *report;
> +	spinlock_t lock;
> +	bool removed;
> +	uint16_t strong_magnitude;
> +	uint16_t weak_magnitude;
> +	struct work_struct work;
> +};
> +
> +static void stadiaff_work(struct work_struct *work)
> +{
> +	struct stadiaff_device *stadiaff =
> +		container_of(work, struct stadiaff_device, work);
> +	struct hid_field *rumble_field = stadiaff->report->field[0];
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&stadiaff->lock, flags);
> +	rumble_field->value[0] = stadiaff->strong_magnitude;
> +	rumble_field->value[1] = stadiaff->weak_magnitude;
> +	spin_unlock_irqrestore(&stadiaff->lock, flags);
> +
> +	hid_hw_request(stadiaff->hid, stadiaff->report, HID_REQ_SET_REPORT);
> +}
> +
> +static int stadiaff_play(struct input_dev *dev, void *data,
> +			 struct ff_effect *effect)
> +{
> +	struct hid_device *hid = input_get_drvdata(dev);
> +	struct stadiaff_device *stadiaff = hid_get_drvdata(hid);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&stadiaff->lock, flags);
> +	if (!stadiaff->removed) {
> +		stadiaff->strong_magnitude = effect->u.rumble.strong_magnitude;
> +		stadiaff->weak_magnitude = effect->u.rumble.weak_magnitude;
> +		schedule_work(&stadiaff->work);
> +	}
> +	spin_unlock_irqrestore(&stadiaff->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int stadiaff_init(struct hid_device *hid)
> +{
> +	struct stadiaff_device *stadiaff;
> +	struct hid_report *report;
> +	struct hid_input *hidinput;
> +	struct input_dev *dev;
> +	int error;
> +
> +	if (list_empty(&hid->inputs)) {
> +		hid_err(hid, "no inputs found\n");
> +		return -ENODEV;
> +	}
> +	hidinput = list_entry(hid->inputs.next, struct hid_input, list);
> +	dev = hidinput->input;
> +
> +	report = hid_validate_values(hid, HID_OUTPUT_REPORT,
> +				     STADIA_FF_REPORT_ID, 0, 2);
> +	if (!report)
> +		return -ENODEV;
> +
> +	stadiaff = devm_kzalloc(&hid->dev, sizeof(struct stadiaff_device),
> +				GFP_KERNEL);
> +	if (!stadiaff)
> +		return -ENOMEM;
> +
> +	hid_set_drvdata(hid, stadiaff);
> +
> +	input_set_capability(dev, EV_FF, FF_RUMBLE);
> +
> +	error = input_ff_create_memless(dev, NULL, stadiaff_play);
> +	if (error)
> +		return error;
> +
> +	stadiaff->removed = false;
> +	stadiaff->hid = hid;
> +	stadiaff->report = report;
> +	INIT_WORK(&stadiaff->work, stadiaff_work);
> +	spin_lock_init(&stadiaff->lock);
> +
> +	hid_info(hid, "Force Feedback for Google Stadia controller\n");
> +
> +	return 0;
> +}
> +
> +static int stadia_probe(struct hid_device *hdev, const struct hid_device_id *id)
> +{
> +	int ret;
> +
> +	ret = hid_parse(hdev);
> +	if (ret) {
> +		hid_err(hdev, "parse failed\n");
> +		return ret;
> +	}
> +
> +	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
> +	if (ret) {
> +		hid_err(hdev, "hw start failed\n");
> +		return ret;
> +	}
> +
> +	ret = stadiaff_init(hdev);
> +	if (ret) {
> +		hid_err(hdev, "force feedback init failed\n");
> +		hid_hw_stop(hdev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void stadia_remove(struct hid_device *hid)
> +{
> +	struct stadiaff_device *stadiaff = hid_get_drvdata(hid);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&stadiaff->lock, flags);
> +	stadiaff->removed = true;
> +	spin_unlock_irqrestore(&stadiaff->lock, flags);
> +
> +	cancel_work_sync(&stadiaff->work);
> +	hid_hw_stop(hid);
> +}
> +
> +static const struct hid_device_id stadia_devices[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STADIA) },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STADIA) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, stadia_devices);
> +
> +static struct hid_driver stadia_driver = {
> +	.name = "stadia",
> +	.id_table = stadia_devices,
> +	.probe = stadia_probe,
> +	.remove = stadia_remove,
> +};
> +module_hid_driver(stadia_driver);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 8a310f8ff20f..42c43d309f98 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -531,6 +531,7 @@
>  #define USB_DEVICE_ID_GOOGLE_DON	0x5050
>  #define USB_DEVICE_ID_GOOGLE_EEL	0x5057
>  #define USB_DEVICE_ID_GOOGLE_JEWEL	0x5061
> +#define USB_DEVICE_ID_GOOGLE_STADIA	0x9400
>  
>  #define USB_VENDOR_ID_GOTOP		0x08f2
>  #define USB_DEVICE_ID_SUPER_Q2		0x007f

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
