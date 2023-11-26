Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08047F909A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 02:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjKZBDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 20:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZBDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 20:03:47 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778F0A9;
        Sat, 25 Nov 2023 17:03:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noQfXfgsNc9vFlhQGczyrB3ih8sIGDX+m0gQ28EJ09oCZ5qr0K2tJ8BoIK3xJ7rJ0H4W7kjCgwdy9lJLl5ona0cWTtVRE1UXlMW61+t7zVo1QlCf21n5RS2RRjnDxPn4MRq/T6jYb8+xMN4thpOZ+uOypEE/SHzokmt9FvzBQ6QQ6c2Jle/jNwp1iCcDkOZy8ZlwSfiLbKXe74SU7jlFLORkXwG26Y+Lf8v+QTq2CQfrrcIu+rzDTWtxlWfA6ERWfps/lc6F5X1cnfcNPkjo8xKhOAUDdIMVCNf/tHU6BiPJ4XqjnEMy0bWgWju5+FxPgkSvpb0fwaa3CAGtTwk/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCBQ+sqVJ4GZ3B/0RWrLLUbG1MscDeqKa4QbaLHf5Ew=;
 b=Qpr+zOjkUCA5NFbwxaJsiQtuP43tDOoxjUTxa1eg9AbHvDqXYM9MqfMylslnGlFJ6dUFfhLGCm+4BWexT0E4xSfobjX/hAIep1yn0EipcZjzqLvGsG0UWo+jZsUOQXAilwKdCPsCFke2+RnqsT5w+idOo3WosUOtTK2Ryj1mekObLDtHL0ryrQngO7oSJuwb7BDall3BAxWIRELxdV0b/GBYaK5VpPpXifavCRcFvtZc15StGG9W9S7Yvz1GIyoE3hEV+zrnEaSaaE7DvAE+tLdnxWVJ9cD7yEODAGf7hcwqd3iNQOKM/09SC9vRTSp5QJVVGFf0e6KkFxyxOP/SOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCBQ+sqVJ4GZ3B/0RWrLLUbG1MscDeqKa4QbaLHf5Ew=;
 b=df8Vb7BaSJdBPS3w8gWwIwHK+arRSxkt768TL1cT+Gd2h8ZKaFue8pw7VV8JB/USb+xBp+nfZIf7OHYCPymQVdaRDBBeNJy9FnI3abuIFx5tjqOoCX/VfQ+HRe0v9RSWN4sSMB6G9yxsIxOVQEhfMC73/Ywk0x2QTc/Te58wYXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by DM6PR08MB6316.namprd08.prod.outlook.com
 (2603:10b6:5:1e7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.25; Sun, 26 Nov
 2023 01:03:48 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da%4]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 01:03:48 +0000
Date:   Sat, 25 Nov 2023 19:03:42 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     James Ogletree <James.Ogletree@cirrus.com>
Cc:     James Ogletree <james.ogletree@opensource.cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] mfd: cs40l50: Add support for CS40L50 core driver
Message-ID: <ZWKZbgBO1+7Qx/ju@nixie71>
References: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
 <20231018175726.3879955-4-james.ogletree@opensource.cirrus.com>
 <ZTiD5VUSi65OK4VK@nixie71>
 <C3E444B1-4BC3-4C30-AD57-051B6B804662@cirrus.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C3E444B1-4BC3-4C30-AD57-051B6B804662@cirrus.com>
X-ClientProxiedBy: SN7PR04CA0198.namprd04.prod.outlook.com
 (2603:10b6:806:126::23) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|DM6PR08MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9392b2-2b9f-4013-53bf-08dbee1b8ba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EbY1kY8rN8KsmvcBzgmZrQ8XYVQHoLcXzb32qufHA/F7uzPYCv383cAfFyUrwndxgWfYr5r7mFgxu9ZsSf0YYbB1zS39DLCeG21gVYKZd69gBK85vPabRuQ/WSZVOvitwn0SNncneyFFytY5rJKuNPLM5RMFre/sNHnnl2892bvOOURI1yTzGQx2sAeq7SEf9IV3Gl9MNukdQygLatmRagIO40oeAQvOamX9phAiDOicvnZeMLiiYp94XYM3Dc69eENSfwzv9h30GJiZkIjBAo6KbmQIN/hHnLEVP7IsFMaHn/mu8pAbPkWcI15K1MF+EK/4oLUHoml2UI5qNsiiGzHvp7haJmxDFgFtzz68glnPOVOj8o2UYjrcVK+YSqRcYhFu4074geZ5KdMBI3Xq3pKqBuKUEr3IVOCW4YEnL3Phbmr2qUiMPzgXqEHUbjKp/FKCt4QEGxAGvo0a9beV9+90nWupYLiXjt3qCgcUbfBNQUEwYlWVzyKXJJqIYM0ki8p5q08/QuMqryvNY4E5+PmKGjjbsusunux37Ac1yYzlE5O+bAkVfEknRdvQGf7C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39830400003)(396003)(346002)(136003)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(5660300002)(7416002)(2906002)(6666004)(86362001)(33716001)(6506007)(53546011)(478600001)(26005)(9686003)(6512007)(316002)(54906003)(66946007)(66556008)(66476007)(6916009)(8676002)(4326008)(8936002)(6486002)(38100700002)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N0Zdrzw3/N5DkFlrL4ZEm0b7MlE8+J71/HmE2+xks0XiSEc0kyt9vGP7kEc7?=
 =?us-ascii?Q?q+2po9cCySKqDYsuRbytTbbKDo9wt/vIhhHRd7viGBmvaMKBkE3oiz2oN+k6?=
 =?us-ascii?Q?znlvHUuoRpXaSct8s+hU7mLfD4RGvPwPtFfKMg0mGYuY81WYtq1xc/YyYBo2?=
 =?us-ascii?Q?3wnZYrIr+Rr5dyZJcqhF7Isumrat7gcngFOWFzjeqcBhHZu0V1lBI/HDjhtp?=
 =?us-ascii?Q?muyIjfS8BMCUKzIOllFUJpPbuSFE2jfzybKu0w6HWUVwbIy41k8ZkvEq4nTa?=
 =?us-ascii?Q?1KHDjKFhi4/xKg/e0RPt8G5QaeMaiYroTLLvhPQdHWVSPb9BcbPGoX+w2N26?=
 =?us-ascii?Q?Kfxb1eHnu5VaW0QCrYg1RMy4miL1NgmcheZf5G156yRmZniVK7mmvhOWe0PY?=
 =?us-ascii?Q?C9/tEk2zI4epdy5P2Q5uYkVI5lFchd8zhmq7uHZuqkGGRwvZ4aks0g52RFUb?=
 =?us-ascii?Q?GVGixlRL+/ME9TKHCPMAaB77AAY9PYihg+wclIOGee6JQCvsMCpR8n1laxW6?=
 =?us-ascii?Q?sr32pCs84yCcjKmSRGGRKPJdh8LsnPsXYnvZ3xW5xIyQKCHG1smoRfdwc6LJ?=
 =?us-ascii?Q?+fXQVtFtKmf15UYD0MOTBWrOVz30DjBeQ7N/gi3+H0LE8wwoxewpSoXQpY84?=
 =?us-ascii?Q?PazcnvwJB1v8ZKsfpvo7X5IUXattOaGfHXQmWFQHBYLMn/WD7AIMy2MKGAgy?=
 =?us-ascii?Q?03myynFOyu6zUpJBsUs5cY+crfacqOPruR0DcAnm8LKCvm6N1bBnkksXSKCN?=
 =?us-ascii?Q?wmtPqWWkPCvTrfspn/TpN/erLr9HHbzs5BZnRdXwl81nfJSjchvcTNJnPZ8u?=
 =?us-ascii?Q?3zqBFJN+lzEbAzNhRPNjcexmPNF4LHtR/oBJhNHDBREJ4/CEdMFZn8rHBQyR?=
 =?us-ascii?Q?TVmiZ2azB/6+8kc4n3UewV9liZmqdgJupUVFpJLsPogUx6y9r5A92UTGUX9h?=
 =?us-ascii?Q?Ejcio8SW04Br7Y15AvAqdV/rq3ZYqpN4u2m8sG6wAtNO1DSzL3qcMjhiUxct?=
 =?us-ascii?Q?PTDte1E7wBBAS1sm2VxUQjWSpCthntZf8A3qpEd9IvpazNcn0o+hfc/RjYGL?=
 =?us-ascii?Q?4m3U2q3PNqfvjX/RxABJ0TY9zEVTJc+zA1ZQsqPWke5nS/5BYaqqFnd7gvQx?=
 =?us-ascii?Q?8Y4IJ1O60Z4afSMs2EfQ3GzgWq4+CCMBUFPKqTdyQSvLFVOhif1xMpoTsCtt?=
 =?us-ascii?Q?ZC7T3vMFAMSXWlD4+h/6BqjW58JmwvEGvv5xHanRAWtQHDjaOq4LZUUJasHv?=
 =?us-ascii?Q?HJx/B6YOeT+zHMAruJYXJzj7odURCsBfpsaEav7wmf9MVeg7/cJSDw+QPWI5?=
 =?us-ascii?Q?pXtuKSDfF5G+fTXz9lJ5EYjDqEk0ASwjXt71gc6kpWI7otpvjWPqLgaRWQJg?=
 =?us-ascii?Q?uq9tb07usgrmgwKw/jdmIZFut4S0cHL217vG7BtTD3fjqmkSuvYl7WfRmcql?=
 =?us-ascii?Q?Dj+JEH+1I3HP5APdFaJeRJTnPwWb+bTrUiPVXZqses1nDR4KtG2Hiduvezva?=
 =?us-ascii?Q?n9oTsGwznwpg20CX61S7ff7V0CRgG0RapJpnY7RvPR5MNY+WiHI09bYq/hon?=
 =?us-ascii?Q?aDEZzCTCB7pcET+cHruHwuOHFVEfmzFHAMJTflnu?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9392b2-2b9f-4013-53bf-08dbee1b8ba0
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 01:03:47.9468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/Yv83ZGN8iZDm9jDF36UbPdb5I0/3Lj3TO4WpXXP1JuciP2J2d0XOmkSqMfapp619vfNUFsziKvDV73kV3q+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB6316
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Wed, Nov 01, 2023 at 08:47:11PM +0000, James Ogletree wrote:
> Hi Jeff,
> 
> > On Oct 24, 2023, at 9:56 PM, Jeff LaBundy <jeff@labundy.com> wrote:
> > 
> > On Wed, Oct 18, 2023 at 05:57:24PM +0000, James Ogletree wrote:
> >> 
> >> +static irqreturn_t cs40l50_error(int irq, void *data);
> >> +
> >> +static const struct cs40l50_irq cs40l50_irqs[] = {
> >> +	CS40L50_IRQ(AMP_SHORT,		"Amp short",		error),
> >> +	CS40L50_IRQ(VIRT2_MBOX,		"Mailbox",		process_mbox),
> >> +	CS40L50_IRQ(TEMP_ERR,		"Overtemperature",	error),
> >> +	CS40L50_IRQ(BST_UVP,		"Boost undervoltage",	error),
> >> +	CS40L50_IRQ(BST_SHORT,		"Boost short",		error),
> >> +	CS40L50_IRQ(BST_ILIMIT,		"Boost current limit",	error),
> >> +	CS40L50_IRQ(UVLO_VDDBATT,	"Boost UVLO",		error),
> >> +	CS40L50_IRQ(GLOBAL_ERROR,	"Global",		error),
> >> +};
> >> +
> >> +static irqreturn_t cs40l50_error(int irq, void *data)
> >> +{
> >> +	struct cs40l50_private *cs40l50 = data;
> >> +
> >> +	dev_err(cs40l50->dev, "%s error\n", cs40l50_irqs[irq].name);
> >> +
> >> +	return IRQ_RETVAL(!cs40l50_error_release(cs40l50));
> >> +}
> >> +
> >> +static const struct regmap_irq cs40l50_reg_irqs[] = {
> >> +	CS40L50_REG_IRQ(IRQ1_INT_1,	AMP_SHORT),
> >> +	CS40L50_REG_IRQ(IRQ1_INT_2,	VIRT2_MBOX),
> >> +	CS40L50_REG_IRQ(IRQ1_INT_8,	TEMP_ERR),
> >> +	CS40L50_REG_IRQ(IRQ1_INT_9,	BST_UVP),
> >> +	CS40L50_REG_IRQ(IRQ1_INT_9,	BST_SHORT),
> >> +	CS40L50_REG_IRQ(IRQ1_INT_9,	BST_ILIMIT),
> >> +	CS40L50_REG_IRQ(IRQ1_INT_10,	UVLO_VDDBATT),
> >> +	CS40L50_REG_IRQ(IRQ1_INT_18,	GLOBAL_ERROR),
> >> +};
> >> +
> >> +static struct regmap_irq_chip cs40l50_irq_chip = {
> >> +	.name =			"CS40L50 IRQ Controller",
> >> +
> >> +	.status_base =		CS40L50_IRQ1_INT_1,
> >> +	.mask_base =		CS40L50_IRQ1_MASK_1,
> >> +	.ack_base =		CS40L50_IRQ1_INT_1,
> >> +	.num_regs =		22,
> >> +
> >> +	.irqs =			cs40l50_reg_irqs,
> >> +	.num_irqs =		ARRAY_SIZE(cs40l50_reg_irqs),
> >> +
> >> +	.runtime_pm =		true,
> >> +};
> >> +
> >> +static int cs40l50_irq_init(struct cs40l50_private *cs40l50)
> >> +{
> >> +	struct device *dev = cs40l50->dev;
> >> +	int error, i, irq;
> >> +
> >> +	error = devm_regmap_add_irq_chip(dev, cs40l50->regmap, cs40l50->irq,
> >> +					 IRQF_ONESHOT | IRQF_SHARED, 0,
> >> +					 &cs40l50_irq_chip, &cs40l50->irq_data);
> >> +	if (error)
> >> +		return error;
> >> +
> >> +	for (i = 0; i < ARRAY_SIZE(cs40l50_irqs); i++) {
> >> +		irq = regmap_irq_get_virq(cs40l50->irq_data, cs40l50_irqs[i].irq);
> >> +		if (irq < 0) {
> >> +			dev_err(dev, "Failed getting %s\n", cs40l50_irqs[i].name);
> >> +			return irq;
> >> +		}
> >> +
> >> +		error = devm_request_threaded_irq(dev, irq, NULL,
> >> +						  cs40l50_irqs[i].handler,
> >> +						  IRQF_ONESHOT | IRQF_SHARED,
> >> +						  cs40l50_irqs[i].name, cs40l50);
> >> +		if (error) {
> >> +			dev_err(dev, "Failed requesting %s\n", cs40l50_irqs[i].name);
> >> +			return error;
> >> +		}
> >> +	}
> > 
> > This is kind of an uncommon design pattern; if anyone reads /proc/interrupts
> > on their system, it's going to be full of L50 interrupts. Normally we declare
> > a single IRQ, read the status register(s) from inside its handler and then
> > act accordingly.
> > 
> > What is the motivation for having one handler per interrupt status bit? If
> > multiple bits are set at once, does the register get read multiple times and
> > if so, does doing so clear any pending status? Or are the status registers
> > write-to-clear instead of read-to-clear?
> 
> The reason I used the regmap_irq framework is that it takes care of
> the reading and clearing of the status register, and yes it handles the
> situation of multiple bits getting set at once. I think I will merge the IRQ
> handlers into one for the next version. The fact of /proc/interrupts filling
> up with these interrupts is not great and was something I overlooked,
> though I think I see instances of drivers with similar amount of interrupts
> upstream.

I'm very much a proponent of using regmap_irq for a device whose register
map is organized in this way; my question was mostly why to map an entire
irq line to every possible interrupt source as opposed to reserving only
one line for L50 altogether.

I noted other such examples as well, and I think either method is functionally
equivalent. But considering many of these interrupts are related to events
that no customer would reasonably care about, and the ones that customers do
care about can easily be delineated by printing, a single handler is fine in
my opinion.

> 
> Best,
> James
> 

Kind regards,
Jeff LaBundy
