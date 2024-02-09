Return-Path: <linux-kernel+bounces-59779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7477A84FBAE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EEFC1C2264A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC36F7F49A;
	Fri,  9 Feb 2024 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b="yFFYQacn"
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2112.outbound.protection.outlook.com [40.107.127.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3537BAED
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 18:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.127.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502440; cv=fail; b=mGPoJRp2MPR5J2f+pPvkR/MCmEd1RZ+RZAzRvl4gzyu1g94TwVlUiCdS1H3bGdr+lw3ikOSsRJEsVIGT8bj2ttZ/Z4cWuDECvOBCydDwdg5Ype7Js1sZOrk4GHlAFVi73rcsxE1ZXui8XhiDUb6ix7zE6jWlUpz0q6sNAIl5YIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502440; c=relaxed/simple;
	bh=hGunbNFZsjzG+lO5deu4lI4pCErQvZDormmKCPkLWkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T1mP3oqj20ym+X430pJ3ydTH7E/C1FzfkkFNuLW05YrTmb1xXkbEEhlhu/8uugtg6BdsTBQbKE5UE0NH9LxMtV4XYMqItJEtqYCLzRGX76QMiOfV5pUMahA+J5xaRnnOfmPJcmT/IYAjPwoR4raUZT4I9/hIz8f96bHdCNkDvEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de; spf=pass smtp.mailfrom=eckelmann.de; dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b=yFFYQacn; arc=fail smtp.client-ip=40.107.127.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eckelmann.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKG2Kumyt/RagxZIk8EzqjDI8FNz6heE4TBa19TlKQitXsMIsWDZHH6XMn/CdJJZqhfESP9HqqJSlLFc5Sfh1Sy5F+AO99WvG0nDU02Ukzby65fFNxtBW5ZFeOqLvK7KVEeaKFU94Bv8tN/OzpG7Qbz+TPwqHtNlbQRL0DyBkH2c3PZyVZg10Fx91lJ1Vac0ngYnFtANWuQfwGLLG/254OArbNlwAsSDg/H7Xv/9TnqgsP32m+oCFiBBVvvyCK/MgE4pn+YE9ej1T7PkaHDNfqV47uHEyFc6QNSm2PeD0VFRVbpxCHuXGrWRXvjnfq4zKDgizwApwW4MEV2ZOU+vBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HdfzzsVhgw1xAe48A7Lx8D9WPTP3wH70LpoHZq9vNc=;
 b=Q5gwiPuUr2SzcD2rMQSC+glrtOSFI6wJ/KWh0s2z2E9Qi7YC5fgatIiMval9yFJxFA+kOcXd6vZ5yYVQxbmZhpQf/xdzt4yUak0e3P2LBjzxLxH3/zVGxNvE9AXKYFoRgmofnJhMj4JviVWu9US/ey5fQyD4rvRkBYy8EV0nnj595vRb2B07JaCk8MfJkADL6+b1yKA4dAC6YGuz20DDAPYNngAKLh+/NVN5GBItgxQ2jOHsiTAXcGZ8fHAffl0WxjDKX143BX+we1cqS29az5p+dsHXIUL6AqehwV1FNFQQ4YP7AJAADstG/JekkSHZnpn5p6agGnIcXPRGA8yHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eckelmann.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HdfzzsVhgw1xAe48A7Lx8D9WPTP3wH70LpoHZq9vNc=;
 b=yFFYQacnqCAEIOWQEDThY3T9UlYxvueSwxXNjDPuvwpwvKPBRS5MynZpR827hS8umv4USu6k6WujS7dF6wIsb2nHeUeb0yB4eucHw/cNxySeH7Uvd7+kcFIUlhBPuBvD1ECRwyCL7UJkkA5m7x/6DLxug7nVFfnGCNoKKn41q/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:da::13)
 by BE1P281MB1938.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:31::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Fri, 9 Feb
 2024 18:13:56 +0000
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a175:dc81:cb6b:2dd8]) by FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a175:dc81:cb6b:2dd8%5]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 18:13:55 +0000
Date: Fri, 9 Feb 2024 19:13:54 +0100
From: Thorsten Scherer <T.Scherer@eckelmann.de>
To: "Ricardo B. Marliere" <ricardo@marliere.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-kernel@vger.kernel.org, 
	Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: Re: [PATCH v2] siox: make siox_bus_type const
Message-ID: <gixkaq442day5gcirj5rbcb4pbihlma2ruhrpqweyvzqx5rz3j@hpt5esbvvloj>
References: <20240204-bus_cleanup-siox-v2-1-3813a6a55dcc@marliere.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-siox-v2-1-3813a6a55dcc@marliere.net>
X-ClientProxiedBy: FR0P281CA0250.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::20) To FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:da::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR4P281MB3510:EE_|BE1P281MB1938:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8d26e4-6ad3-4d7f-876b-08dc299ae0f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yz7u+z/0dos9ZIyjZkUIs9CabEkIPaPKFyI9sZNoViAjoMfUYfcnHv+lqmYTcI6HJPTZxjjAY021rLPo6K5EVazcDV0HiRyshvmFJlvyXhZLMhf3vq1RIcWlfI1biaDppkTum/m5RX+YAYpTph/FmVaIpQXbrkVDisOLbSNl+yRU6/c2NSebCWymb9gvWhPxN0nxz3OyOCDU4PYG4q+7F6gx3KgE7fMiwFEK1Y1g3piHXbGSH+5CGYMqyP1NNmUkK8rtMfQIlrXKXFWW4OCrpP0GJ0+ddqp411aZSgS9XCJ7YQXhvv/MC/y4SMuXa5hFvJPgAWLJ+dpgq3Ca3HDb7zCvGPaMrwp2YBCqAkILPSf+EthR4j5EIrRRdtxbUiL+ec2RjRirnjySGds/oKAbiWdrsDCgvzw1rAYEXeIv0n6hNtoIyWq2mxkmLJtsuuQAhY2pJk9b0U6OT6QPxocoGBANXfWwsQcNhtWhFJP57yChXWFZLvAZY2Yip9zXqeqiHCn70FbxG8WXky1XXZziwkL6yRn14zh83b2bU2adkSo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(366004)(39850400004)(396003)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6506007)(316002)(66476007)(8936002)(8676002)(4326008)(5660300002)(38100700002)(2906002)(33716001)(478600001)(66946007)(9686003)(66556008)(966005)(86362001)(6486002)(6512007)(83380400001)(107886003)(110136005)(41300700001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FU0WJzmpbqS51dsvychP0Ez6AIRfgoalocrF+EhbOP7PHUVSIF2ev34Fvzok?=
 =?us-ascii?Q?MBXL5GZUG7wvpQKiJ5W+/PF2FrPlrvvlLmSxmjf7koh/gPlM3lapPZpQlSMG?=
 =?us-ascii?Q?0W2kldVHd5SYTxZMjMRSnvDBB0tEjEPP/uVtOrrM7+LqOglPy9IZCzZ4zdnt?=
 =?us-ascii?Q?X7V6N5pZLXIkuW8e87l2RaWlmoQ7FavcRO9x1YKdOgjdvjIpm57Cye+Y9v7m?=
 =?us-ascii?Q?iQ+rCRwBMvpTRL49EDn7f+3OWDXIsEhjpzNZ5f9lmBih9y2oFVmcd1/7Vqlb?=
 =?us-ascii?Q?1Kk3xG1cN+CqHdgiNk65z+klJIpZ4+TkKBldLrSvxzyiLeFCv+BrEiWSfbvn?=
 =?us-ascii?Q?TL46AeAN3w6dS0SwebT0Jng0G8idrDezEy8JXSWUfnh/FKSThP/8gwSXewsk?=
 =?us-ascii?Q?6VrV4QZ6yGvu8EZ12nyQGWOCHJ3x8pxGcJ9WyLtp9JhLsI7zK9vUXUHQQyyk?=
 =?us-ascii?Q?liPY1gxoksr0ZV2EV6xSR58xAzC3bRQ5XN9A+U/7BWJZI6vSBaSwo4Par8uj?=
 =?us-ascii?Q?bPt6vRY2iOX/WOGG8mSzkgl22Sb1/hh+29GhJtof3Z4VW5O3JDgzFt8ySr6Q?=
 =?us-ascii?Q?ERZByh8y8KsSpsULckFZnEGwAMcRswKF2rN9YG04LERGeS5Q5zAKbwsPn2yh?=
 =?us-ascii?Q?epMZIPE6Gt96rwAbLy4lwHdgRc1O1JAIY5RlZqGqnI2oYUDVwg8skFWBjUiV?=
 =?us-ascii?Q?0pgPP1ymJTVFfuQjtvd6zGUgDtuY7o4JoxphskWNuwXBG2Pb8pcEi0gouoao?=
 =?us-ascii?Q?NM1wHxPIXF6V+8NVzf9VlAw2/TfYcCek2wpnXOVIOFdukLBtUiCb8dQhpZ24?=
 =?us-ascii?Q?Orii2bCyR+OJusOaTpmvZmXzNnVi1s/RBHGdpQtRRiWC6MBZavP+WW4aCbS2?=
 =?us-ascii?Q?lTzhtWzBuc/AiMJIax9fUdwOnvdUfnFJHIi8NPpMl3h6qzCNbpKE3h1DEpo2?=
 =?us-ascii?Q?yc8zoBP/BMvpIAWhZgREt3ufuebSSexyu9h7F9aFViCE8Oih4Q4Nilaz85Dx?=
 =?us-ascii?Q?8OkawevKSk5XjVom4ENJ3yDasNHtcoGlvhPZytHjVlvT4tNxOZtRi4aOk+5M?=
 =?us-ascii?Q?k8QvvNdsiSsUsbOniDz2OCCod8wPehlh8mlptXzT5sjNdTFJsmuhCrVTvSd5?=
 =?us-ascii?Q?ymFmihFgvF+VZ5p4ujlEli+RPipotmdOg5+vSJqewSiekzjvdv5KUQAgTca8?=
 =?us-ascii?Q?IbLIbKFaAM6LBuYOhEkyZvjXD/gE1Fd5F9qCnO0UBQITore9NIzhX2u0LOZf?=
 =?us-ascii?Q?NmFAlUeOIOQ+kWLIKS/ZUPfWSV5qurpqxOKZ4gTktqvDD+UxEB4WfFsz2d6z?=
 =?us-ascii?Q?5CqWKR7TOGO+/doCH3g+NrDe+Fmgda0e9xEXKCWD1VOFXCNtyfazNzqcyx2u?=
 =?us-ascii?Q?O1C2M8/0ZgC4FwfOlbJTZ14n7i0QcKyAX3zAT6/f7ddKG+J3Hw8aTLnNzXVl?=
 =?us-ascii?Q?2Ke1es/QtwuDQWT5OAleciTgwPcHhFcYdrPeuOjtKVugoJJGqD9hW1fX9M44?=
 =?us-ascii?Q?8Taku+xXAxtZ5pQ0CVkzzFILMg2fpYDwZRfuxg3EjEwp0RzWeu5Fmyzcwlap?=
 =?us-ascii?Q?rolqWO7m6GKnr4SSdZrTMKraWd+yvxOhuSiDTqNDDdHUOo47lAmmQWev719t?=
 =?us-ascii?Q?nyuEnGRZ7daWHZ1SmQ88Y5jwiNjMyS03meXmuPtakDxf?=
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8d26e4-6ad3-4d7f-876b-08dc299ae0f1
X-MS-Exchange-CrossTenant-AuthSource: FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 18:13:55.7111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyh8QJhI/tgzdkKA8Az5bxMWmu8MWguqCVgz8ACJ+ehqZEy1o+GGoOkQ78lUeoS3sAZl+Mq8pHFeixgSRKI10g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1938

Hello,

On Sun, Feb 04, 2024 at 07:26:42PM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct bus_type
> a const *"), the driver core can properly handle constant struct
> bus_type. Move the siox_bus_type variable to be a constant structure as
> well, placing it into read-only memory which can not be modified at
> runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Acked-by: Thorsten Scherer <t.scherer@eckelmann.de>

@Ricardo: Thank you!

@gregkh: Would you please pick up this patch?

> ---
> Changes in v2:
> - Fixed changelog: mentioned commit d492cc2573a0 instead of the word
>   "Now".
> - Link to v1: https://lore.kernel.org/r/20240204-bus_cleanup-siox-v1-1-2d12583d3a6c@marliere.net
> ---
>  drivers/siox/siox-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
> index 561408583b2b..a1eda7bd76ed 100644
> --- a/drivers/siox/siox-core.c
> +++ b/drivers/siox/siox-core.c
> @@ -543,7 +543,7 @@ static void siox_shutdown(struct device *dev)
>  		sdriver->shutdown(sdevice);
>  }
>  
> -static struct bus_type siox_bus_type = {
> +static const struct bus_type siox_bus_type = {
>  	.name = "siox",
>  	.match = siox_match,
>  	.probe = siox_probe,
> 
> ---
> base-commit: 41b9fb381a486360b2daaec0c7480f8e3ff72bc7
> change-id: 20240204-bus_cleanup-siox-ccf8775bf069
> 
> Best regards,
> -- 
> Ricardo B. Marliere <ricardo@marliere.net>
> 

Best regards
Thorsten

