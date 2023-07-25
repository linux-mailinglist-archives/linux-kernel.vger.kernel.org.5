Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC141761BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjGYOha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjGYOh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:37:28 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC841E5;
        Tue, 25 Jul 2023 07:37:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtMg7O8RvA9zJJ/hoLKmdNMR0VOLoxY/+f5bz0wJ1quixaLdbf1aEJYcErgEmv62dWVr9cvVZKOPi8IxdUxuAUxsV1XaIBNPATssJS3BXiT07po+ueu8AOScz9Ud9Z5IS9cp8xc1Ish06btj/npdzeEHpRDfP3jU/eJWoq/UCHjwqcsgQJvKVwd41CJvwB5jjuJE3R1jtE8HUL/TydywG1dZh0lPTLrjb+SPrpWh0P1zXtKlvrA/hhdWhTLRETa+xnaD3Yci+2R58W80paBLNSEIE4fmSBhf11z9wARgrTqnd/u0V+Rd+D+q6+izRRluivepxQESOou9nH11rQtHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmaaK4lbG4IGFOgQ8ckNjoTaE6cgefjsQ+qu0PiJ5ho=;
 b=Gao3WNGY5wiLNRaNuQqmAKr+K4PrmXmlgfGr5RImUnmkOEHVk1ehp9PTumUfwJoEmzrT49tTK3hiAOWSPZqPxpj9HlfqOIFI7FefcRzD+EK4iHHckCI40kUUXSy3vWjwJc9f/Ny1y0bdwOt4Z0mn4c3jxk7Cy9HNS+5BozmziSWaq9xApF2/LPDG289qC6VbCQ4vDmuGFyajD5LdjGAmUwhPMgzX2wlFFPGlBwJZqstd1RNFiV5MZ6r9OT+VC4qNR/+2ACUwcIDRKnJ8CRebCjfuwAvcyMiC4t2+U+/PskGk0HyzfCwbqBJui2NLNOCPfmxB4rFVdfoZ8YbOwTv2Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmaaK4lbG4IGFOgQ8ckNjoTaE6cgefjsQ+qu0PiJ5ho=;
 b=Tvm+o+OIrYU1MBE62hvaTg0K++fkPEEfeF2y8smVCIRcc4Ekw5QMEX9z4KZrDluv3RP4m/dbX/F9wH+DyjmHJNWCZTu/HTX+Kyl59X/aawqjYKS7gn2gp7Ob6Iu0Vz9HS4Acvc4sHCsjIn5XfkqEDraNSYk9XHNmkCtAyaT+kak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8756.eurprd04.prod.outlook.com (2603:10a6:20b:42f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 14:37:24 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 14:37:24 +0000
Date:   Tue, 25 Jul 2023 10:37:11 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Thinh.Nguyen@synopsys.com, andriy.shevchenko@linux.intel.com,
        gregkh@linuxfoundation.org, imx@lists.linux.dev, jgilab@gmail.com,
        jun.li@nxp.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, peter.chen@kernel.org,
        quic_eserrao@quicinc.com, quic_prashk@quicinc.com,
        r-gunasekaran@ti.com, rogerq@kernel.org
Subject: Re: [PATCH v2 1/2] usb: gadget: call usb_gadget_check_config() to
 verify UDC capability
Message-ID: <ZL/eF0fZe4k63sXX@lizhi-Precision-Tower-5810>
References: <20230707230015.494999-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707230015.494999-1-Frank.Li@nxp.com>
X-ClientProxiedBy: BYAPR02CA0061.namprd02.prod.outlook.com
 (2603:10b6:a03:54::38) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: 2febe654-ee42-43f0-5ef4-08db8d1ca8f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aXkflQmIybUIXOFICujgLklR82IP6nHK0jhgSzQf60J+jJX8WsFEnTglWSjUl703611L6OZu8mDPmEYc2ItTWUpSnacGqJzI/iJ8r2b831tS5H+OSnwDUWbD3Wm4IfC3k8nsb/3qu8svp5tonjnZ3lE5LI2nVPjnZ18Il45wOLAEufxlBaWlMF/DeNOr+vJZbT652qStq98Ypieb3G7NXf8HQeJyH+MDrsR5o6uMuXE2EbV92dW0iZFwFLP+TGq9YC3CUqGeKBLPa0+wGPoQrqza3tr2NBCjOfwjfIKw/nsRsMaSH8Y5X/M76dAw9zJZ2X3YI8ptnFCYQxKIPgratkZuk7H2eQqz5DiVRuK06QXbZCsNxmILPBY7ulK1AaCjMMMWq07VrbN+41S3i4pRjqZUg3SbJ12HYaV+2esJTs3VYFlnu/w+TYurVtAxPQHV1uD5Je2MFN51mYBzN7mYs8APFF7GszG5fnIujfFCWa/P9m4PQZje4d9MtwUOiW14At9Y1WrxDn33OOFBAaBXQlsu/CZjeP0QgIik6jiERjdTlqe+Oll5s+wqqmzCFs/LWUw2GBpPQr7dPmEbW3qMKpyMVpdMq8wL+0OqzNHLJhb9VgOhj05eUdvU96UuNYrcDsC6P0ungbcYJANAdVD87w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199021)(26005)(6506007)(186003)(921005)(478600001)(6666004)(86362001)(33716001)(66556008)(66476007)(6486002)(41300700001)(316002)(38350700002)(66946007)(38100700002)(8676002)(2906002)(8936002)(5660300002)(7416002)(52116002)(6512007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UUeA60ybfq9wTJKSvYW0OtGN1JcGh9w6zMouni6aswcvHuC5PnKL9UJk5tIM?=
 =?us-ascii?Q?RfFSunJDNiakE1FQlEvK7Yyaohi5vQ7dyDYcxbzgSoqm05Cm+a9IiSRl1zYU?=
 =?us-ascii?Q?uG+OBDAZdCbxXzbNzehYX4sJfjqfwsmJT2iRcWOYOkFRPtsJIozppZ423rw4?=
 =?us-ascii?Q?3b4K9SVo4YWo1D3EzGjHdzVXbua2sqS+kIy8G9fgUKlJByZrb/s1Ql3M+/wD?=
 =?us-ascii?Q?Va+AVc6dPhdV3QlLBp5bQ4llEHsVcFPx28n28TKzExBSTKlHV9fkneGee7D7?=
 =?us-ascii?Q?JivTL8SFfeJ4/QcqoLe9Yiz4Lh4+gmZQ+WXF66++0hVYl+F53Rm8HMW+j00g?=
 =?us-ascii?Q?PZQCopKBs7/VZsuqP0ieWeTC47bDy6+Mqm5dhbuHYo60roun9vOQDQtvvvr7?=
 =?us-ascii?Q?ra3Tg2HwP3G//MIHns5IB5IIdlRioiNr5wvfZsQ8SDjjuh8Y5S8oAjfjV6i1?=
 =?us-ascii?Q?lz3AW7yEOSYYxi1eLJDFyxb5JWBDwWLZaW63gKZXFtuqxFiEam4C8G6oEFhh?=
 =?us-ascii?Q?VK3CohFQ66zaVyBEPJmvH8knfWO4stSBfzmAjJB28m3xEj2npqBvc644i5Tf?=
 =?us-ascii?Q?4tEZMqjjosAFGf4/spAjMPBdOaTi5NzTuIqen39K2kFJwZU1LZoTdck9NYcM?=
 =?us-ascii?Q?Q9JqfL0xM+AyS/0G7L1VVzkv2WhY+dWGCHzCqohBYUFM0TG7HfSpXoO5HaXZ?=
 =?us-ascii?Q?qxKE5YRLRt69miOptfJeFrOrTycXNUcPjnabJA2d8jaZl208lJCwCQTdNjMV?=
 =?us-ascii?Q?J0HZYtgdhTm2g1Lw6ILu5aA4FCfb9/stKMLjcU1FcyxZEfvN9lD0DjFia5kk?=
 =?us-ascii?Q?2dPCb+IbOjyXM2YRL25IukxvrQo4N13LXs+CS7ISslmGCCTTymtiMRjOP19R?=
 =?us-ascii?Q?nKw8LSWX/3VBz6YLLCpE7J5+6lnLPbTI/llK9ZTrTxN+Mu8/n/vhnbXp7nER?=
 =?us-ascii?Q?RaYRo/Odq9evn2cgA5mAaruedwPmjYXGjWxsEuTuNqyW0ioj9HwjTWFnhnV4?=
 =?us-ascii?Q?doJCLbLyIAqp18yCQlQMKNUmQE9AljEMoMeLQ141ExpVkU6vgXrAGCJ6aCSM?=
 =?us-ascii?Q?gH057xTW9LquPd+67457XQgFJiaMuc2EQ3v3769hqHweJKY1WDQRlSwXVZb4?=
 =?us-ascii?Q?hcnf02U2gquwzQ4/QkeuE0/MCuUgUizt8y3WCSF+zS/feqjx7RAvywK5uHVq?=
 =?us-ascii?Q?wXiwkOJNba8D0pVboZxJ3wvlKOHdK30w0o2zP0m3B5qkYjf97swHQPBPUWlT?=
 =?us-ascii?Q?nS7VWilsUJj1yXwz8VZzk4U8N6FoKMmM958/Psl9yKCUeIfIsVMvaxL5JdCL?=
 =?us-ascii?Q?7bUZxcc87pLnIQKCrk32BDZlRJQdr6sJIUJWR0UNDtUwlumiA+p5hFHxCwVd?=
 =?us-ascii?Q?XDzawb9zEbEJqqcGGOIk64CC67nkuSgEbTr8B2cnzZvF76o2MqVMoyetaThV?=
 =?us-ascii?Q?hKV3Og+Ewi+Do+BlXkS1f0MzeI2SuSUC/T0CkbrihGaI0w/+A9j1BYVz0f+9?=
 =?us-ascii?Q?pbyRiT+XJkSZgBexvcsT5FrMfHwrm32OSoDzxIGLSiMmIPohpvF2EhEalIz/?=
 =?us-ascii?Q?jEKPz2v+7nXvEWjJ458=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2febe654-ee42-43f0-5ef4-08db8d1ca8f7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 14:37:24.0024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTxcPkwWb71jt47Hh7Yfwj287//o8itSzjKl2k0D6nXBkGstm7GYG7haBCfjBqEi42NEvNeP8gnZqEH8nrJCew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8756
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 07:00:14PM -0400, Frank Li wrote:
> The legacy gadget driver omitted calling usb_gadget_check_config()
> to ensure that the USB device controller (UDC) has adequate resources,
> including sufficient endpoint numbers and types, to support the given
> configuration.
> 
> Previously, usb_add_config() was solely invoked by the legacy gadget
> driver. Adds the necessary usb_gadget_check_config() after the bind()
> operation to fix the issue.
> 
> Fixes: dce49449e04f ("usb: cdns3: allocate TX FIFO size according to composite EP number")
> Reported-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

@greg
        ping

> change from v1 to v2
> - not change for this patch, just add new patch to fix multi-config case
> 
>  drivers/usb/gadget/composite.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index 403563c06477..cb0a4e2cdbb7 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -1029,6 +1029,10 @@ int usb_add_config(struct usb_composite_dev *cdev,
>  		goto done;
>  
>  	status = bind(config);
> +
> +	if (status == 0)
> +		status = usb_gadget_check_config(cdev->gadget);
> +
>  	if (status < 0) {
>  		while (!list_empty(&config->functions)) {
>  			struct usb_function		*f;
> -- 
> 2.34.1
> 
